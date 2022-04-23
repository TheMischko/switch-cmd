-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema 6FrrJZwxhZ
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 6FrrJZwxhZ
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `6FrrJZwxhZ` DEFAULT CHARACTER SET utf8 COLLATE utf8_czech_ci ;
USE `6FrrJZwxhZ` ;

-- -----------------------------------------------------
-- Table `6FrrJZwxhZ`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `6FrrJZwxhZ`.`image` ;

CREATE TABLE IF NOT EXISTS `6FrrJZwxhZ`.`image` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `source` VARCHAR(255) NULL,
  `title` VARCHAR(32) NULL,
  `altText` VARCHAR(255) NULL,
  `rankNum` INT NULL DEFAULT 0,
  `dateUploaded` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6FrrJZwxhZ`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `6FrrJZwxhZ`.`post` ;

CREATE TABLE IF NOT EXISTS `6FrrJZwxhZ`.`post` (
  `id` INT NOT NULL,
  `title` VARCHAR(32) NULL,
  `slug` VARCHAR(48) NULL,
  `shortText` VARCHAR(255) NULL,
  `longText` TEXT NULL,
  `gallery_id` INT UNSIGNED NULL,
  `image_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_image1_idx` (`image_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `6FrrJZwxhZ`.`image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6FrrJZwxhZ`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `6FrrJZwxhZ`.`product` ;

CREATE TABLE IF NOT EXISTS `6FrrJZwxhZ`.`product` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NULL,
  `slug` VARCHAR(36) NULL,
  `price` DECIMAL NULL,
  `image_id` INT UNSIGNED NULL,
  `post_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idProduct_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_product_image1_idx` (`image_id` ASC) VISIBLE,
  INDEX `fk_product_post1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `6FrrJZwxhZ`.`image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `6FrrJZwxhZ`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6FrrJZwxhZ`.`product_variation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `6FrrJZwxhZ`.`product_variation` ;

CREATE TABLE IF NOT EXISTS `6FrrJZwxhZ`.`product_variation` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NULL,
  `slug` VARCHAR(72) NULL,
  `price` DECIMAL NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `image_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_variation_product_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_product_variation_image1_idx` (`image_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_variation_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `6FrrJZwxhZ`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_variation_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `6FrrJZwxhZ`.`image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6FrrJZwxhZ`.`product_variation_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `6FrrJZwxhZ`.`product_variation_data` ;

CREATE TABLE IF NOT EXISTS `6FrrJZwxhZ`.`product_variation_data` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NULL,
  `value` VARCHAR(255) NULL,
  `product_variation_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_variation_data_product_variation1_idx` (`product_variation_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_variation_data_product_variation1`
    FOREIGN KEY (`product_variation_id`)
    REFERENCES `6FrrJZwxhZ`.`product_variation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6FrrJZwxhZ`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `6FrrJZwxhZ`.`user` ;

CREATE TABLE IF NOT EXISTS `6FrrJZwxhZ`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(32) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `firstName` VARCHAR(32) NULL,
  `middleName` VARCHAR(32) NULL,
  `lastName` VARCHAR(32) NULL,
  `birthday` DATETIME NULL,
  `phoneNumber` VARCHAR(32) NULL,
  `email` VARCHAR(128) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6FrrJZwxhZ`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `6FrrJZwxhZ`.`role` ;

CREATE TABLE IF NOT EXISTS `6FrrJZwxhZ`.`role` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6FrrJZwxhZ`.`user_has_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `6FrrJZwxhZ`.`user_has_role` ;

CREATE TABLE IF NOT EXISTS `6FrrJZwxhZ`.`user_has_role` (
  `user_id` INT UNSIGNED NOT NULL,
  `role_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_user_has_role_role1_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_user_has_role_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_role_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `6FrrJZwxhZ`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_role_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `6FrrJZwxhZ`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6FrrJZwxhZ`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `6FrrJZwxhZ`.`address` ;

CREATE TABLE IF NOT EXISTS `6FrrJZwxhZ`.`address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(128) NULL,
  `city` VARCHAR(85) NULL,
  `state` VARCHAR(32) NULL,
  `country` VARCHAR(32) NULL,
  `postalCode` VARCHAR(10) NULL,
  `contactNumber` VARCHAR(32) NULL,
  `contactEmail` VARCHAR(128) NULL,
  `note` VARCHAR(255) NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `6FrrJZwxhZ`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
