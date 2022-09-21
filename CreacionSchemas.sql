-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gestioncitas_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gestioncitas_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gestioncitas_db` DEFAULT CHARACTER SET utf8 ;
USE `gestioncitas_db` ;

-- -----------------------------------------------------
-- Table `gestioncitas_db`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestioncitas_db`.`roles` (
  `idrol` TINYINT(2) NOT NULL,
  `descripcion` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestioncitas_db`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestioncitas_db`.`Usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `identificacion` INT(45) NOT NULL,
  `primer_nombre` VARCHAR(45) NOT NULL,
  `segundo_nombre` VARCHAR(45) NULL,
  `primer_apellido` VARCHAR(45) NOT NULL,
  `segundo_apellido` VARCHAR(45) NULL,
  `correo` VARCHAR(45) NOT NULL,
  `rol` TINYINT(2) NOT NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`idUsuarios`),
  UNIQUE INDEX `idUsuarios_UNIQUE` (`idUsuarios` ASC) VISIBLE,
  INDEX `rol_fk_idx` (`rol` ASC) VISIBLE,
  CONSTRAINT `rol_fk`
    FOREIGN KEY (`rol`)
    REFERENCES `gestioncitas_db`.`roles` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestioncitas_db`.`Pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestioncitas_db`.`Pacientes` (
  `idPaciente` INT NOT NULL,
  `Historia_clinica` VARCHAR(45) NULL,
  INDEX `idPaciente_idx` (`idPaciente` ASC) VISIBLE,
  UNIQUE INDEX `idPaciente_UNIQUE` (`idPaciente` ASC) VISIBLE,
  CONSTRAINT `idPaciente_fk`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `gestioncitas_db`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestioncitas_db`.`Medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestioncitas_db`.`Medicos` (
  `idMedicos` INT NOT NULL,
  `Especialidad` VARCHAR(45) NULL,
  INDEX `idMedicos_fk_idx` (`idMedicos` ASC) VISIBLE,
  CONSTRAINT `idMedicos_fk`
    FOREIGN KEY (`idMedicos`)
    REFERENCES `gestioncitas_db`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestioncitas_db`.`Citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestioncitas_db`.`Citas` (
  `idCitas` INT NOT NULL,
  `F_cita` DATETIME NOT NULL,
  `idMedicos` INT NOT NULL,
  `idPaciente` INT NOT NULL,
  `estadoCita` TINYTEXT NOT NULL,
  `copago` TINYINT NULL,
  `novedades` VARCHAR(100) NULL,
  PRIMARY KEY (`idCitas`),
  INDEX `idmedico_fk_idx` (`idMedicos` ASC) VISIBLE,
  INDEX `idpaciente_fk_idx` (`idPaciente` ASC) VISIBLE,
  CONSTRAINT `idmedico_fk`
    FOREIGN KEY (`idMedicos`)
    REFERENCES `gestioncitas_db`.`Medicos` (`idMedicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idpaciente_fk`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `gestioncitas_db`.`Pacientes` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
