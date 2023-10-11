-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema mm_cpsc502101team02
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mm_cpsc502101team02
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mm_cpsc502101team02` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `stu_id` INT NOT NULL,
  `stu_firstname` VARCHAR(45) NULL,
  `stu_lastname` VARCHAR(45) NULL,
  `stu_email` VARCHAR(45) NULL,
  `stu_contact_no` VARCHAR(45) NULL,
  `stu_year` VARCHAR(45) NULL,
  PRIMARY KEY (`stu_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FACULTY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FACULTY` (
  `fac_id` INT NOT NULL,
  `fac_name` VARCHAR(45) NULL,
  PRIMARY KEY (`fac_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LIBRARY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LIBRARY` (
  `lib_id` INT NOT NULL,
  `lib_address` VARCHAR(45) NULL,
  `stu_id` INT NULL,
  `fac_id` INT NOT NULL,
  PRIMARY KEY (`lib_id`),
  INDEX `fk_LIBRARY_student1_idx` (`stu_id` ASC) VISIBLE,
  INDEX `fk_LIBRARY_FACULTY1_idx` (`fac_id` ASC) VISIBLE,
  CONSTRAINT `fk_LIBRARY_student1`
    FOREIGN KEY (`stu_id`)
    REFERENCES `mydb`.`student` (`stu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LIBRARY_FACULTY1`
    FOREIGN KEY (`fac_id`)
    REFERENCES `mydb`.`FACULTY` (`fac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BOOKS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BOOKS` (
  `bk_id` INT NOT NULL,
  `bk_author` VARCHAR(45) NULL,
  `bk_isbn` VARCHAR(45) NULL,
  `bk_title` VARCHAR(45) NULL,
  `bk_publisher` VARCHAR(45) NULL,
  `bk_edition` INT NULL,
  `lib_id` INT NOT NULL,
  `bk_number` VARCHAR(45) NULL,
  PRIMARY KEY (`bk_id`, `lib_id`),
  INDEX `fk_BOOKS_LIBRARY1_idx` (`lib_id` ASC) VISIBLE,
  CONSTRAINT `fk_BOOKS_LIBRARY1`
    FOREIGN KEY (`lib_id`)
    REFERENCES `mydb`.`LIBRARY` (`lib_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MAJOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MAJOR` (
  `maj_id` INT NOT NULL,
  `maj_name` VARCHAR(45) NULL,
  `fac_id` INT NOT NULL,
  PRIMARY KEY (`maj_id`, `fac_id`),
  INDEX `fk_MAJOR_FACULTY1_idx` (`fac_id` ASC) VISIBLE,
  CONSTRAINT `fk_MAJOR_FACULTY1`
    FOREIGN KEY (`fac_id`)
    REFERENCES `mydb`.`FACULTY` (`fac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Educator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Educator` (
  `edu_id` INT NOT NULL,
  `edu_firstname` VARCHAR(45) NULL,
  `edu_lastname` VARCHAR(45) NULL,
  `edu_contact` VARCHAR(45) NULL,
  `edu_officeAddress` VARCHAR(45) NULL,
  `edu_email` VARCHAR(45) NULL,
  PRIMARY KEY (`edu_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COURSE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COURSE` (
  `course_id` INT NOT NULL,
  `course_name` VARCHAR(45) NULL,
  `maj_id` INT NOT NULL,
  `Educator_edu_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `maj_id`, `Educator_edu_id`),
  INDEX `fk_COURSE_MAJOR1_idx` (`maj_id` ASC) VISIBLE,
  INDEX `fk_COURSE_Educator1_idx` (`Educator_edu_id` ASC) VISIBLE,
  CONSTRAINT `fk_COURSE_MAJOR1`
    FOREIGN KEY (`maj_id`)
    REFERENCES `mydb`.`MAJOR` (`maj_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COURSE_Educator1`
    FOREIGN KEY (`Educator_edu_id`)
    REFERENCES `mydb`.`Educator` (`edu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EBOOKS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EBOOKS` (
  `ebk_id` INT NOT NULL,
  `ebk_name` VARCHAR(45) NULL,
  `ebk_description` VARCHAR(45) NULL,
  `BOOKS_idBOOKS1` INT NOT NULL,
  PRIMARY KEY (`ebk_id`),
  INDEX `fk_EBOOK_BOOKS1_idx` (`BOOKS_idBOOKS1` ASC) VISIBLE,
  CONSTRAINT `fk_EBOOK_BOOKS1`
    FOREIGN KEY (`BOOKS_idBOOKS1`)
    REFERENCES `mydb`.`BOOKS` (`bk_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RATING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RATING` (
  `rating_score` INT NULL,
  `rating_description` LONGTEXT NULL,
  `rating_date` DATE NULL,
  `rat_id` VARCHAR(45) NOT NULL,
  `BOOKS_idBOOKS` INT NOT NULL,
  `stu_id` INT NOT NULL,
  PRIMARY KEY (`rat_id`),
  INDEX `fk_RATING_BOOKS1_idx` (`BOOKS_idBOOKS` ASC) VISIBLE,
  INDEX `fk_RATING_student1_idx` (`stu_id` ASC) VISIBLE,
  CONSTRAINT `fk_RATING_BOOKS1`
    FOREIGN KEY (`BOOKS_idBOOKS`)
    REFERENCES `mydb`.`BOOKS` (`bk_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RATING_student1`
    FOREIGN KEY (`stu_id`)
    REFERENCES `mydb`.`student` (`stu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPLOYEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPLOYEE` (
  `emp_id` INT NOT NULL,
  `lib_id` INT NOT NULL,
  `emp_firstname` VARCHAR(45) NULL,
  `emp_lastname` VARCHAR(45) NULL,
  `emp_contact` VARCHAR(45) NULL,
  `emp_email` VARCHAR(45) NULL,
  PRIMARY KEY (`emp_id`, `lib_id`),
  INDEX `fk_EMPLOYEE_LIBRARY1_idx` (`lib_id` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLOYEE_LIBRARY1`
    FOREIGN KEY (`lib_id`)
    REFERENCES `mydb`.`LIBRARY` (`lib_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COURSE_has_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COURSE_has_student` (
  `course_id` INT NOT NULL,
  `stu_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `stu_id`),
  INDEX `fk_COURSE_has_student_student1_idx` (`stu_id` ASC) VISIBLE,
  INDEX `fk_COURSE_has_student_COURSE1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_COURSE_has_student_COURSE1`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`COURSE` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COURSE_has_student_student1`
    FOREIGN KEY (`stu_id`)
    REFERENCES `mydb`.`student` (`stu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COURSE_REQUIRED_BOOKS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COURSE_REQUIRED_BOOKS` (
  `BOOKS_bk_id` INT NOT NULL,
  `COURSE_course_id` INT NOT NULL,
  `COURSE_Educator_edu_id` INT NOT NULL,
  PRIMARY KEY (`BOOKS_bk_id`, `COURSE_course_id`),
  INDEX `fk_BOOKS_has_COURSE_COURSE1_idx` (`COURSE_course_id` ASC, `COURSE_Educator_edu_id` ASC) VISIBLE,
  CONSTRAINT `fk_BOOKS_has_COURSE_BOOKS1`
    FOREIGN KEY (`BOOKS_bk_id`)
    REFERENCES `mydb`.`BOOKS` (`bk_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BOOKS_has_COURSE_COURSE1`
    FOREIGN KEY (`COURSE_course_id` , `COURSE_Educator_edu_id`)
    REFERENCES `mydb`.`COURSE` (`course_id` , `Educator_edu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mm_cpsc502101team02` ;

-- -----------------------------------------------------
-- Table `mm_cpsc502101team02`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team02`.`book` (
  `bid` INT NOT NULL AUTO_INCREMENT,
  `author` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `year` VARCHAR(45) NULL DEFAULT NULL,
  `location` VARCHAR(45) NOT NULL,
  `subjectid` VARCHAR(45) NULL DEFAULT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`bid`),
  UNIQUE INDEX `bid_UNIQUE` (`bid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team02`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team02`.`course` (
  `courseid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `credits` INT NOT NULL,
  PRIMARY KEY (`courseid`),
  UNIQUE INDEX `courseid_UNIQUE` (`courseid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team02`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team02`.`employee` (
  `employeeid` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employeeid`),
  UNIQUE INDEX `employeeid_UNIQUE` (`employeeid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team02`.`major`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team02`.`major` (
  `majorid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`majorid`),
  UNIQUE INDEX `majorid_UNIQUE` (`majorid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team02`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team02`.`people` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `middlename` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `birthdate` VARCHAR(45) NOT NULL,
  `streetaddress` VARCHAR(45) NOT NULL,
  `address2` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zipcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE INDEX `pid_UNIQUE` (`pid` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team02`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team02`.`rental` (
  `rentalid` INT NOT NULL,
  `bookid` INT NOT NULL,
  `peopleid` INT NOT NULL,
  `rentdate` DATE NOT NULL,
  `returndate` DATE NOT NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`rentalid`),
  UNIQUE INDEX `rentalid_UNIQUE` (`rentalid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team02`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team02`.`student` (
  `sid` INT NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `majorid` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE INDEX `sid_UNIQUE` (`sid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
