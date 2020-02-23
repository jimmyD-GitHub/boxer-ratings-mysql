SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema boxers
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `boxers`;

-- -----------------------------------------------------
-- Schema boxers
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `boxers` DEFAULT CHARACTER SET utf8;
USE `boxers`;



-- -----------------------------------------------------
-- Table `boxers`.`division`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`division`;

CREATE TABLE IF NOT EXISTS `boxers`.`division`
(
    `id`         TINYINT(2) UNSIGNED NOT NULL,
    `name`       VARCHAR(20)         NOT NULL,
    `created_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME            NULL     DEFAULT NULL,
    UNIQUE INDEX `name` (`name` ASC),
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`boxer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`boxer`;

CREATE TABLE IF NOT EXISTS `boxers`.`boxer`
(
    `id`          INT(11) UNSIGNED    NOT NULL AUTO_INCREMENT,
    `division_id` TINYINT(2) UNSIGNED NOT NULL,
    `boxrec_id`   INT(11) UNSIGNED    NOT NULL,
    `name`        VARCHAR(45)         NOT NULL,
    `nationality` CHAR(2)             NOT NULL COMMENT 'ISO 3166-1 alpha-2 code',
    `dob`         DATE                NOT NULL,
    `record`      VARCHAR(20)         NOT NULL,
    `home_town`   VARCHAR(45)         NOT NULL,
    `snippet`     TEXT                NOT NULL,
    `titles`      VARCHAR(18)         NULL     DEFAULT NULL,
    `twitter`     VARCHAR(15)         NULL     DEFAULT NULL,
    `enabled`     TINYINT(1)          NOT NULL DEFAULT 0,
    `created_at`  DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at`  DATETIME            NULL     DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `index_divisionId` (`division_id` ASC),
    UNIQUE INDEX `twitter_UNIQUE` (`twitter` ASC),
    CONSTRAINT `fk_boxer_divisionId`
        FOREIGN KEY (`division_id`)
            REFERENCES `boxers`.`division` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`rating`
(
    `division_id` TINYINT(2) UNSIGNED   NOT NULL,
    `boxer_id`    INT(11) UNSIGNED      NOT NULL,
    `rating`      MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0,
    `points`      INT(11)               NOT NULL DEFAULT 0,
    PRIMARY KEY (`division_id`, `boxer_id`),
    INDEX `fk_rating_boxerId` (`boxer_id` ASC),
    INDEX `index_divisionId` (`division_id` ASC),
    CONSTRAINT `fk_rating_divisionId`
        FOREIGN KEY (`division_id`)
            REFERENCES `boxers`.`division` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_rating_boxerId`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`user`;

CREATE TABLE IF NOT EXISTS `boxers`.`user`
(
    `id`          INT(11)      NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(45)  NOT NULL,
    `email`       VARCHAR(255) NOT NULL,
    `password`    VARCHAR(255) NOT NULL,
    `created_at`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `active`      TINYINT(1)   NOT NULL DEFAULT 1,
    `confirmed`   VARCHAR(45)  NOT NULL DEFAULT 0,
    `fingerprint` CHAR(32)     NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `email_UNIQUE` (`email` ASC),
    INDEX `fingerprint` (`fingerprint`)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`password_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`password_token`;

CREATE TABLE IF NOT EXISTS `boxers`.`password_token`
(
    `user_id`    INT(11)      NOT NULL,
    `token`      VARCHAR(500) NOT NULL,
    `created_at` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE INDEX `token` (`token` ASC),
    PRIMARY KEY (`user_id`),
    CONSTRAINT `fk_passwordToken_userId`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`email_queue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`email_queue`;

CREATE TABLE IF NOT EXISTS `boxers`.`email_queue`
(
    `id`         TINYINT(2) UNSIGNED                          NOT NULL AUTO_INCREMENT,
    `user_id`    INT(11)                                      NOT NULL,
    `type`       ENUM ('resetPassword', 'signupConfirmation') NOT NULL,
    `token`      VARCHAR(500)                                 NOT NULL,
    `created_at` DATETIME                                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `sent_at`    DATETIME                                              DEFAULT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_emailQueue_userId`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`admin`;

CREATE TABLE IF NOT EXISTS `boxers`.`admin`
(
    `id`                        INT(11)      NOT NULL AUTO_INCREMENT,
    `name`                      VARCHAR(45)  NOT NULL,
    `password`                  VARCHAR(255) NOT NULL,
    `roles`                     JSON         NOT NULL,
    `created_at`                DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `active`                    TINYINT(1)   NOT NULL DEFAULT 1,
    `googleAuthenticatorSecret` char(52)              DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`p4p_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`p4p_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`p4p_rating`
(
    `id`         INT(11)          NOT NULL AUTO_INCREMENT,
    `boxer_id`   INT(11) UNSIGNED NOT NULL,
    `rating`     SMALLINT(5)      NULL,
    `created_at` DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_p4p_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`heavyweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`heavyweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`heavyweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_heavyweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_heavyweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_heavyweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`cruiserweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`cruiserweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`cruiserweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_cruiserweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_crusierweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_cruiserweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`lightheavyweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`lightheavyweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`lightheavyweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_lightheavyweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_lightheavyweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_lightheavyweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`supermiddleweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`supermiddleweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`supermiddleweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_supermiddleweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_supermiddleweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_supermiddleweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`middleweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`middleweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`middleweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_middleweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_middleweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_middleweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`lightmiddleweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`lightmiddleweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`lightmiddleweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_lightmiddleweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_lightmiddleweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_lightmiddleweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`welterweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`welterweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`welterweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_welterweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_welterweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_welterweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boxers`.`lightwelterweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`lightwelterweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`lightwelterweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_lightwelterweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_lightwelterweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_lightwelterweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`lightweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`lightweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`lightweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_lightweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_lightweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_lightweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`superfeatherweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`superfeatherweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`superfeatherweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_superfeatherweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_superfeatherweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_superfeatherweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Table `boxers`.`featherweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`featherweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`featherweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_featherweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_featherweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_featherweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`superbantamweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`superbantamweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`superbantamweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_superbantamweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_superbantamweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_superbantamweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`bantamweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`bantamweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`bantamweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_bantamweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_bantamweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_bantamweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`superflyweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`superflyweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`superflyweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_superflyweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_superflyweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_superflyweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`flyweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`flyweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`flyweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_flyweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_flyweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_flyweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`lightflyweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`lightflyweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`lightflyweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_lightflyweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_lightflyweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_lightflyweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `boxers`.`minimumweight_user_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boxers`.`minimumweight_user_rating`;

CREATE TABLE IF NOT EXISTS `boxers`.`minimumweight_user_rating`
(
    `user_id`  INT(11)          NOT NULL,
    `boxer_id` INT(11) UNSIGNED NOT NULL,
    `rating`   SMALLINT(5)      NULL,
    PRIMARY KEY (`user_id`, `boxer_id`),
    INDEX `fk_minimumweight_user_rating_boxer_idx` (`boxer_id` ASC),
    CONSTRAINT `fk_minimumweight_user_rating_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `boxers`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_minimumweight_user_rating_boxer`
        FOREIGN KEY (`boxer_id`)
            REFERENCES `boxers`.`boxer` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `boxers`.`division`
-- -----------------------------------------------------
START TRANSACTION;
USE `boxers`;
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 'Heavyweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (2, 'Cruiserweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (3, 'Light Heavyweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (4, 'Super Middleweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (5, 'Middleweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (6, 'Light Middleweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (7, 'Welterweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (8, 'Light Welterweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (9, 'Lightweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (10, 'Super Featherweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (11, 'Featherweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (12, 'Super Bantamweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (13, 'Bantamweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (14, 'Super Flyweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (15, 'Flyweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (16, 'Light Flyweight', DEFAULT, DEFAULT, NULL);
INSERT INTO `boxers`.`division` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`)
VALUES (17, 'Minimumweight', DEFAULT, DEFAULT, NULL);

COMMIT;

