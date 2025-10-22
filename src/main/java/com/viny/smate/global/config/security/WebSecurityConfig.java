package com.viny.smate.global.config.security;

import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    private static final String[] ALLOWED_MATCHERS = {
            "/",
            "/sign-up",
            "/api/v1/auth/login",
            "/api/v1/auth/logout",
            "/api/v1/user/exists/**",
            "/api/v1/user"
    };

    private static final String[] STATIC_RESOURCE_MATCHERS = {
            "/css/**",
            "/js/**",
            "/fonts/**",
            "/img/**",
            "/webjars/**",
            "/favicon.ico",
            "/h2-console/**"
    };

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public WebSecurityCustomizer customizer() {
        return web -> web.ignoring().requestMatchers(STATIC_RESOURCE_MATCHERS);
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.httpBasic(basic -> basic.disable())
            .formLogin(form -> form.disable())
            .csrf(csrf -> csrf.disable())
            /* 요청 인가 설정 */
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(ALLOWED_MATCHERS).permitAll()
                .anyRequest().authenticated())
            /* 세션 관리 정책 설정 */
            .sessionManagement(sessionManagement -> sessionManagement
                .sessionFixation()
                    .changeSessionId()
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
                .expiredUrl("/"))
            /* H2 콘솔 접근을 위한 X-Frame-Options 헤더 설정 (동일 도메인 내에선 접근 가능) */
            .headers(header -> header
                .frameOptions(HeadersConfigurer.FrameOptionsConfig::sameOrigin));

        return http.build();
    }
}