-- MySQL Script generated by MySQL Workbench
-- Sun Apr 29 21:30:30 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Location` (
  `LocationId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Hotle_HotelId` INT NOT NULL,
  PRIMARY KEY (`LocationId`),
  INDEX `fk_Location_hotle_idx` (`Hotle_HotelId` ASC),
  CONSTRAINT `fk_Location_hotle`
    FOREIGN KEY (`Hotle_HotelId`)
    REFERENCES `mydb`.`Hotle` (`HotelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hotle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hotle` (
  `HotelId` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Location_LocationId` INT NOT NULL,
  PRIMARY KEY (`HotelId`, `Location_LocationId`),
  INDEX `fk_hotle_Location1_idx` (`Location_LocationId` ASC),
  CONSTRAINT `fk_hotle_Location1`
    FOREIGN KEY (`Location_LocationId`)
    REFERENCES `mydb`.`Location` (`LocationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Room` (
  `RoomId` INT NOT NULL,
  `Type` VARCHAR(45) NULL,
  `Hotle_HotelId` INT NOT NULL,
  PRIMARY KEY (`RoomId`, `Hotle_HotelId`),
  INDEX `fk_room_hotle1_idx` (`Hotle_HotelId` ASC),
  CONSTRAINT `fk_room_hotle1`
    FOREIGN KEY (`Hotle_HotelId`)
    REFERENCES `mydb`.`Hotle` (`HotelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Traveller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Traveller` (
  `TravellerId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`TravellerId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reservation` (
  `ReservationId` INT NOT NULL,
  `HotelId` INT NULL,
  `TravellerId` INT NULL,
  `CheckIn` DATE NULL,
  `CheckOut` DATE NULL,
  `Traveller_TravellerId` INT NOT NULL,
  `Hotle_HotelId` INT NOT NULL,
  `Hotle_Location_LocationId` INT NOT NULL,
  `Room_RoomId` INT NOT NULL,
  `Room_Hotle_HotelId` INT NOT NULL,
  PRIMARY KEY (`ReservationId`, `Hotle_HotelId`, `Hotle_Location_LocationId`, `Room_RoomId`, `Room_Hotle_HotelId`),
  INDEX `fk_Reservation_Traveller1_idx` (`Traveller_TravellerId` ASC),
  INDEX `fk_Reservation_Hotle1_idx` (`Hotle_HotelId` ASC, `Hotle_Location_LocationId` ASC),
  INDEX `fk_Reservation_Room1_idx` (`Room_RoomId` ASC, `Room_Hotle_HotelId` ASC),
  CONSTRAINT `fk_Reservation_Traveller1`
    FOREIGN KEY (`Traveller_TravellerId`)
    REFERENCES `mydb`.`Traveller` (`TravellerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation_Hotle1`
    FOREIGN KEY (`Hotle_HotelId` , `Hotle_Location_LocationId`)
    REFERENCES `mydb`.`Hotle` (`HotelId` , `Location_LocationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation_Room1`
    FOREIGN KEY (`Room_RoomId` , `Room_Hotle_HotelId`)
    REFERENCES `mydb`.`Room` (`RoomId` , `Hotle_HotelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `Type` INT NULL,
  `Price` INT NULL,
  `Security code` VARCHAR(45) NULL,
  `Traveller_TravellerId` INT NOT NULL,
  `Reservation_ReservationId` INT NOT NULL,
  `Reservation_Hotle_HotelId` INT NOT NULL,
  `Reservation_Hotle_Location_LocationId` INT NOT NULL,
  INDEX `fk_Payment_Traveller1_idx` (`Traveller_TravellerId` ASC),
  INDEX `fk_Payment_Reservation1_idx` (`Reservation_ReservationId` ASC, `Reservation_Hotle_HotelId` ASC, `Reservation_Hotle_Location_LocationId` ASC),
  CONSTRAINT `fk_Payment_Traveller1`
    FOREIGN KEY (`Traveller_TravellerId`)
    REFERENCES `mydb`.`Traveller` (`TravellerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_Reservation1`
    FOREIGN KEY (`Reservation_ReservationId` , `Reservation_Hotle_HotelId` , `Reservation_Hotle_Location_LocationId`)
    REFERENCES `mydb`.`Reservation` (`ReservationId` , `Hotle_HotelId` , `Hotle_Location_LocationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
