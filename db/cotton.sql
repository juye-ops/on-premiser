-- MySQL Script generated by MySQL Workbench
-- 2023년 08월 01일 (화) 오후 04시 56분 55초
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cotton_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cotton_db` ;

-- -----------------------------------------------------
-- Schema cotton_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cotton_db` ;
USE `cotton_db` ;

-- -----------------------------------------------------
-- Table `cotton_db`.`framework`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`framework` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`framework` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`os`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`os` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`os` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`os_version`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`os_version` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`os_version` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `os_id` INT NOT NULL,
  `version` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_os_version_1_idx` (`os_id` ASC) VISIBLE,
  CONSTRAINT `fk_os_version_1`
    FOREIGN KEY (`os_id`)
    REFERENCES `cotton_db`.`os` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`framework_version`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`framework_version` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`framework_version` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `framework_id` INT NOT NULL,
  `version` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_framework_version_1_idx` (`framework_id` ASC) VISIBLE,
  CONSTRAINT `fk_framework_version_1`
    FOREIGN KEY (`framework_id`)
    REFERENCES `cotton_db`.`framework` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`member_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`member_user` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`member_user` (
  `id` INT NOT NULL,
  `user_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`project` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`project` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_project_1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `cotton_db`.`member_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`container`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`container` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`container` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_container_info_4_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `fk_container_info_3`
    FOREIGN KEY (`project_id`)
    REFERENCES `cotton_db`.`project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`container_framework`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`container_framework` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`container_framework` (
  `id` INT NOT NULL,
  `container_id` INT NOT NULL,
  `version_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_container_framework_1_idx` (`container_id` ASC) VISIBLE,
  INDEX `fk_container.framework_2_idx` (`version_id` ASC) VISIBLE,
  CONSTRAINT `fk_container.framework_1`
    FOREIGN KEY (`container_id`)
    REFERENCES `cotton_db`.`container` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_container.framework_2`
    FOREIGN KEY (`version_id`)
    REFERENCES `cotton_db`.`framework_version` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`container_os`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`container_os` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`container_os` (
  `id` INT NOT NULL,
  `container_id` INT NOT NULL,
  `version_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_container.os_2_idx` (`version_id` ASC) VISIBLE,
  INDEX `fk_container.os_1_idx` (`container_id` ASC) VISIBLE,
  CONSTRAINT `fk_container.os_1`
    FOREIGN KEY (`container_id`)
    REFERENCES `cotton_db`.`container` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_container.os_2`
    FOREIGN KEY (`version_id`)
    REFERENCES `cotton_db`.`os_version` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`container_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`container_info` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`container_info` (
  `id` INT NOT NULL,
  `container_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `gpu` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_container.info_1_idx` (`container_id` ASC) VISIBLE,
  CONSTRAINT `fk_container.info_1`
    FOREIGN KEY (`container_id`)
    REFERENCES `cotton_db`.`container` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cotton_db`.`auth_password`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cotton_db`.`auth_password` ;

CREATE TABLE IF NOT EXISTS `cotton_db`.`auth_password` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_auth.password_1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_auth.password_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `cotton_db`.`member_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `cotton_db`.`framework`
-- -----------------------------------------------------
START TRANSACTION;
USE `cotton_db`;
INSERT INTO `cotton_db`.`framework` (`id`, `name`) VALUES (DEFAULT, 'python');
INSERT INTO `cotton_db`.`framework` (`id`, `name`) VALUES (DEFAULT, 'node');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cotton_db`.`os`
-- -----------------------------------------------------
START TRANSACTION;
USE `cotton_db`;
INSERT INTO `cotton_db`.`os` (`id`, `name`) VALUES (DEFAULT, 'ubuntu');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cotton_db`.`os_version`
-- -----------------------------------------------------
START TRANSACTION;
USE `cotton_db`;
INSERT INTO `cotton_db`.`os_version` (`id`, `os_id`, `version`) VALUES (DEFAULT, 1, '14.04');
INSERT INTO `cotton_db`.`os_version` (`id`, `os_id`, `version`) VALUES (DEFAULT, 1, '16.04');
INSERT INTO `cotton_db`.`os_version` (`id`, `os_id`, `version`) VALUES (DEFAULT, 1, '18.04');
INSERT INTO `cotton_db`.`os_version` (`id`, `os_id`, `version`) VALUES (DEFAULT, 1, '20.04');
INSERT INTO `cotton_db`.`os_version` (`id`, `os_id`, `version`) VALUES (DEFAULT, 1, '22.04');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cotton_db`.`framework_version`
-- -----------------------------------------------------
START TRANSACTION;
USE `cotton_db`;
INSERT INTO `cotton_db`.`framework_version` (`id`, `framework_id`, `version`) VALUES (DEFAULT, 1, '3.7');
INSERT INTO `cotton_db`.`framework_version` (`id`, `framework_id`, `version`) VALUES (DEFAULT, 1, '3.8');
INSERT INTO `cotton_db`.`framework_version` (`id`, `framework_id`, `version`) VALUES (DEFAULT, 1, '3.9');
INSERT INTO `cotton_db`.`framework_version` (`id`, `framework_id`, `version`) VALUES (DEFAULT, 1, '3.10');
INSERT INTO `cotton_db`.`framework_version` (`id`, `framework_id`, `version`) VALUES (DEFAULT, 2, '14');
INSERT INTO `cotton_db`.`framework_version` (`id`, `framework_id`, `version`) VALUES (DEFAULT, 2, '16');
INSERT INTO `cotton_db`.`framework_version` (`id`, `framework_id`, `version`) VALUES (DEFAULT, 2, '18');
INSERT INTO `cotton_db`.`framework_version` (`id`, `framework_id`, `version`) VALUES (DEFAULT, 2, '20');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cotton_db`.`member_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `cotton_db`;
INSERT INTO `cotton_db`.`member_user` (`id`, `user_name`) VALUES (1, 'admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cotton_db`.`auth_password`
-- -----------------------------------------------------
START TRANSACTION;
USE `cotton_db`;
INSERT INTO `cotton_db`.`auth_password` (`id`, `user_id`, `password`) VALUES (1, 1, 'admin');

COMMIT;

