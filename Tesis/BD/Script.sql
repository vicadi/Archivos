-- -----------------------------------------------------
-- Schema QueLeo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `QueLeo` DEFAULT CHARACTER SET utf8 ;
USE `QueLeo` ;

-- -----------------------------------------------------
-- Table `QueLeo`.`Estado_Civil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Estado_Civil` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Estado_Civil` (
  `Id_Estado` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id_Estado`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Tema_Interes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Tema_Interes` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Tema_Interes` (
  `Id_Tema` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Descripcion` VARCHAR(150) NULL,
  PRIMARY KEY (`Id_Tema`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Nivel_Educativo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Nivel_Educativo` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Nivel_Educativo` (
  `Id_Nivel` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id_Nivel`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Pais` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Pais` (
  `Id_Pais` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id_Pais`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Genero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Genero` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Genero` (
  `Id_Genero` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`Id_Genero`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Autor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Autor` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Autor` (
  `Id_Autor` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Fecha_Nacimiento` DATE NULL,
  `Fecha_Muerte` DATE NULL,
  `Pais_Nacimiento` INT NULL,
  PRIMARY KEY (`Id_Autor`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC),
  INDEX `Id_Pais_idx` (`Pais_Nacimiento` ASC),
  CONSTRAINT `Pais_Nacimiento`
    FOREIGN KEY (`Pais_Nacimiento`)
    REFERENCES `QueLeo`.`Pais` (`Id_Pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Libro` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Libro` (
  `Id_Libro` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Autor` INT NULL,
  `Genero` INT NULL,
  `Descripcion` VARCHAR(200) NULL,
  `Donde_Encontrarlo` VARCHAR(100) NULL,
  `Calificacion` DOUBLE NULL,
  `Imagen` VARCHAR(100) NULL,
  `Num_Califi` INT NULL,
  PRIMARY KEY (`Id_Libro`),
  INDEX `Autor_idx` (`Autor` ASC),
  INDEX `Genero_idx` (`Genero` ASC),
  CONSTRAINT `Autor`
    FOREIGN KEY (`Autor`)
    REFERENCES `QueLeo`.`Autor` (`Id_Autor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Genero`
    FOREIGN KEY (`Genero`)
    REFERENCES `QueLeo`.`Genero` (`Id_Genero`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Lector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Lector` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Lector` (
  `Id_Lector` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `NickName` VARCHAR(50) NOT NULL,
  `Fecha_Nacimiento` DATE NOT NULL,
  `Pais_Nacimiento` INT NULL,
  `Pais_Residencia` INT NULL,
  `Sexo` VARCHAR(50) NULL,
  `Nivel_Educativo` INT NULL,
  `Estado_Civil` INT NULL,
  `Puntaje_Lector` INT NULL,
  PRIMARY KEY (`Id_Lector`),
  UNIQUE INDEX `NickName_UNIQUE` (`NickName` ASC),
  INDEX `Pais_Nacimiento_Lector_idx` (`Pais_Nacimiento` ASC),
  INDEX `Pais_Residencia_idx` (`Pais_Residencia` ASC),
  INDEX `Nivel_Educativo_idx` (`Nivel_Educativo` ASC),
  INDEX `Estado_Civil_idx` (`Estado_Civil` ASC),
  CONSTRAINT `Pais_Nacimiento_Lector`
    FOREIGN KEY (`Pais_Nacimiento`)
    REFERENCES `QueLeo`.`Pais` (`Id_Pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Pais_Residencia`
    FOREIGN KEY (`Pais_Residencia`)
    REFERENCES `QueLeo`.`Pais` (`Id_Pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Nivel_Educativo`
    FOREIGN KEY (`Nivel_Educativo`)
    REFERENCES `QueLeo`.`Nivel_Educativo` (`Id_Nivel`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Estado_Civil`
    FOREIGN KEY (`Estado_Civil`)
    REFERENCES `QueLeo`.`Estado_Civil` (`Id_Estado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Lector_Temas_Interes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Lector_Temas_Interes` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Lector_Temas_Interes` (
  `Lector` INT NOT NULL,
  `Tema_Interes` INT NOT NULL,
  PRIMARY KEY (`Lector`, `Tema_Interes`),
  INDEX `Lector_Tema_idx` (`Lector` ASC),
  INDEX `Tema_Lector_idx` (`Tema_Interes` ASC),
  CONSTRAINT `Lector_Tema`
    FOREIGN KEY (`Lector`)
    REFERENCES `QueLeo`.`Lector` (`Id_Lector`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Tema_Lector`
    FOREIGN KEY (`Tema_Interes`)
    REFERENCES `QueLeo`.`Tema_Interes` (`Id_Tema`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Lectura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Lectura` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Lectura` (
  `Id_Lectura` INT NOT NULL,
  `Libro` INT NULL,
  `Fecha_Lectura` DATE NULL,
  `Estado` VARCHAR(50) NULL,
  `Calificacion` DOUBLE NULL,
  `Comentario` VARCHAR(150) NULL,
  `Lector` INT NULL,
  PRIMARY KEY (`Id_Lectura`),
  INDEX `Libro_idx` (`Libro` ASC),
  INDEX `Lector_idx` (`Lector` ASC),
  CONSTRAINT `Libro`
    FOREIGN KEY (`Libro`)
    REFERENCES `QueLeo`.`Libro` (`Id_Libro`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Lector`
    FOREIGN KEY (`Lector`)
    REFERENCES `QueLeo`.`Lector` (`Id_Lector`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Recomendacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Recomendacion` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Recomendacion` (
  `Id_Recomendacion` INT NOT NULL,
  `Fecha` DATE NULL,
  `Libro` INT NULL,
  `Ponderado` DOUBLE NULL,
  `Lectura` INT NULL,
  PRIMARY KEY (`Id_Recomendacion`),
  INDEX `Libro_Rec_idx` (`Libro` ASC),
  INDEX `Lectura_idx` (`Lectura` ASC),
  CONSTRAINT `Libro_Rec`
    FOREIGN KEY (`Libro`)
    REFERENCES `QueLeo`.`Libro` (`Id_Libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Lectura`
    FOREIGN KEY (`Lectura`)
    REFERENCES `QueLeo`.`Lectura` (`Id_Lectura`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Tipo_Recomendacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Tipo_Recomendacion` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Tipo_Recomendacion` (
  `Id_Tipo_Rec` INT NOT NULL,
  `Nombre` VARCHAR(50) NULL,
  `Puntuacion` DOUBLE NULL,
  `Numero_Selecciones` INT NULL,
  PRIMARY KEY (`Id_Tipo_Rec`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Atributo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Atributo` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Atributo` (
  `Id_Atributo` INT NOT NULL,
  `Nombre` VARCHAR(50) NULL,
  `Tipo_Recomendacion` INT NULL,
  `Peso` DOUBLE NULL,
  `Porcentaje` DOUBLE NULL,
  `Numero_Hijos` INT NULL,
  `Es_Estatico` TINYINT(1) NULL,
  `Atributo_Padre` INT NULL,
  `Numero_Selecciones` INT NULL,
  PRIMARY KEY (`Id_Atributo`),
  INDEX `Tipo_Recomendacion_idx` (`Tipo_Recomendacion` ASC),
  INDEX `Atributo_Padre_idx` (`Atributo_Padre` ASC),
  CONSTRAINT `Tipo_Recomendacion`
    FOREIGN KEY (`Tipo_Recomendacion`)
    REFERENCES `QueLeo`.`Tipo_Recomendacion` (`Id_Tipo_Rec`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Atributo_Padre`
    FOREIGN KEY (`Atributo_Padre`)
    REFERENCES `QueLeo`.`Atributo` (`Id_Atributo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QueLeo`.`Atributo_Seleccionado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QueLeo`.`Atributo_Seleccionado` ;

CREATE TABLE IF NOT EXISTS `QueLeo`.`Atributo_Seleccionado` (
  `Id_Atrib_Sel` INT NOT NULL,
  `Nombre` VARCHAR(50) NULL,
  `Tipo_Recomendacion` INT NULL,
  `Recomendacion` INT NULL,
  PRIMARY KEY (`Id_Atrib_Sel`),
  INDEX `Tipo_Recomendacion_Atrib_Sel_idx` (`Tipo_Recomendacion` ASC),
  INDEX `Recomendacion_idx` (`Recomendacion` ASC),
  CONSTRAINT `Tipo_Recomendacion_Atrib_Sel`
    FOREIGN KEY (`Tipo_Recomendacion`)
    REFERENCES `QueLeo`.`Tipo_Recomendacion` (`Id_Tipo_Rec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Recomendacion`
    FOREIGN KEY (`Recomendacion`)
    REFERENCES `QueLeo`.`Recomendacion` (`Id_Recomendacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

ALTER TABLE `QueLeo`.`Lector` 
ADD COLUMN `Password` VARCHAR(50) NOT NULL AFTER `Puntaje_Lector`,
ADD COLUMN `Email` VARCHAR(50) NOT NULL AFTER `Password`,
ADD UNIQUE INDEX `Email_UNIQUE` (`Email` ASC);