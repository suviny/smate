
-- 사용자 테이블
DROP TABLE IF EXISTS USERS CASCADE;
CREATE TABLE IF NOT EXISTS USERS (
    ID                  INT                 NOT NULL AUTO_INCREMENT,
    EMAIL               VARCHAR(45)         UNIQUE NOT NULL,
    PASSWORD            VARCHAR(255)        NOT NULL,
    NICKNAME            VARCHAR(15)         UNIQUE NOT NULL,
    NAME                VARCHAR(15)         NOT NULL,
    PHONE               VARCHAR(11)         NOT NULL,
    AUTH_TYPE           VARCHAR(7)          NOT NULL,
    ENABLED             TINYINT(1)          NOT NULL,
    DELETED_YN          CHAR(1)             NOT NULL DEFAULT 'N',
    CREATED_AT          DATETIME            NOT NULL DEFAULT NOW(),
    UPDATED_AT          DATETIME            NOT NULL,
    DELETED_AT          DATETIME            NULL,
    PRIMARY KEY (ID)
);


-- 사용자 별 권한 관리 테이블
DROP TABLE IF EXISTS USER_ROLES CASCADE;
CREATE TABLE IF NOT EXISTS USER_ROLES (
    USER_ID             INT                 NOT NULL,
    ROLE                VARCHAR(25)         NOT NULL,
    CREATED_AT          DATETIME            NOT NULL DEFAULT NOW(),
    UPDATED_AT          DATETIME            NOT NULL,
    PRIMARY KEY (USER_ID, ROLE),
    CONSTRAINT FK_USER_ROLES_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);


-- 프로필 정보 테이블
DROP TABLE IF EXISTS PROFILES CASCADE;
CREATE TABLE IF NOT EXISTS PROFILES (
    ID                  INT                 NOT NULL AUTO_INCREMENT,
    USER_ID             INT                 NOT NULL,
    PROFILE_IMG_URL     VARCHAR(255)        NULL,
    BIO                 VARCHAR(255)        NULL,
    UNIV                VARCHAR(50)         NULL,
    LOCATION            VARCHAR(50)         NULL,
    SITE                VARCHAR(255)        NULL,
    CREATED_AT          DATETIME            NOT NULL DEFAULT NOW(),
    UPDATED_AT          DATETIME            NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT FK_PROFILES_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);


-- 로그인 이력 테이블
DROP TABLE IF EXISTS LOGIN_HISTORIES CASCADE;
CREATE TABLE IF NOT EXISTS LOGIN_HISTORIES (
    ID                  INT                 NOT NULL AUTO_INCREMENT,
    USER_ID             INT                 NOT NULL,
    IP_ADDRESS          VARCHAR(15)         NOT NULL,
    DEVICE_TYPE         VARCHAR(7)          NOT NULL,
    OS                  VARCHAR(20)         NOT NULL,
    BROWSER             VARCHAR(20)         NOT NULL,
    STATUS              CHAR(1)             NOT NULL,
    LOGIN_AT            DATETIME            NOT NULL,
    LOGOUT_AT           DATETIME            NULL,
    PRIMARY KEY (ID),
    CONSTRAINT FK_LOGIN_HISTORIES_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);


-- 작업 그룹 관리 테이블
DROP TABLE IF EXISTS TASK_GROUPS CASCADE;
CREATE TABLE IF NOT EXISTS TASK_GROUPS (
    ID                  INT                 NOT NULL AUTO_INCREMENT,
    NAME                VARCHAR(50)         NOT NULL,
    SORT                INT                 NOT NULL,
    USED_YN             CHAR(1)             NOT NULL,
    CREATED_AT          DATETIME            NOT NULL DEFAULT NOW(),
    UPDATED_AT          DATETIME            NOT NULL,
    PRIMARY KEY (ID)
);


-- 게시판 관리 테이블
DROP TABLE IF EXISTS BOARDS CASCADE;
CREATE TABLE IF NOT EXISTS BOARDS (
    ID                  INT                 NOT NULL AUTO_INCREMENT,
    NAME                VARCHAR(50)         NOT NULL,
    DESCRIPTION         VARCHAR(55)         NOT NULL,
    SORT                INT                 NOT NULL,
    DELETED_YN          CHAR(1)             NOT NULL DEFAULT 'N',
    CREATED_AT          DATETIME            NOT NULL DEFAULT NOW(),
    UPDATED_AT          DATETIME            NOT NULL,
    DELETED_AT          DATETIME            NULL,
    PRIMARY KEY (ID)
);
