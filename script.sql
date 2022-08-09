-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema muro_privado
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema muro_privado
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `muro_privado` DEFAULT CHARACTER SET utf8 ;
USE `muro_privado` ;

-- -----------------------------------------------------
-- Table `muro_privado`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muro_privado`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(105) NULL,
  `last_name` VARCHAR(105) NULL,
  `email` VARCHAR(105) NULL,
  `password` VARCHAR(255) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muro_privado`.`mesagges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muro_privado`.`mesagges` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mensaje` VARCHAR(255) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sender_id` INT NOT NULL,
  `receiver_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mesagges_users_idx` (`sender_id` ASC) VISIBLE,
  INDEX `fk_mesagges_users1_idx` (`receiver_id` ASC) VISIBLE,
  CONSTRAINT `fk_mesagges_users`
    FOREIGN KEY (`sender_id`)
    REFERENCES `muro_privado`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mesagges_users1`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `muro_privado`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
