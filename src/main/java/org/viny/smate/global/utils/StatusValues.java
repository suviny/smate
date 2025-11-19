package org.viny.smate.global.utils;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 프로젝트 전반에서 사용되는 상태 값 처리를 위해 서로 다른 타입의 값들을 상응되는 의미별로 정의한 열거형 클래스
 */


@Getter
@AllArgsConstructor
public enum StatusValues {

    YES (1, "Y", true),
    NO (0, "N", false);

    private final  int number;

    private final String character;

    private final boolean flag;
}