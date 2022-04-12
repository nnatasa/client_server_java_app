/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.18-MariaDB : Database - database
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sladoled` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `sladoled`;



DROP TABLE IF EXISTS `Administrator`;

CREATE TABLE `Administrator` (
  `AdministratorID` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Ime` VARCHAR(20) NOT NULL,
  `Prezime` VARCHAR(30) NOT NULL,
  `Username` VARCHAR(20) NOT NULL,
  `Password` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`AdministratorID`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;



INSERT  INTO `Administrator`(`AdministratorID`,`Ime`,`Prezime`,`Username`,`Password`) VALUES 
(1,'Natasa','Jovanovic','natasa','natasa123');



DROP TABLE IF EXISTS `Kupac`;

CREATE TABLE `Kupac` (
  `KupacID` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `PIB` VARCHAR(20) NOT NULL,
  `NazivKupca` VARCHAR(30) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `Telefon` VARCHAR(50) NOT NULL,
  `Adresa` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`KupacID`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;



INSERT  INTO `Kupac`(`KupacID`,`PIB`,`NazivKupca`,`Email`,`Telefon`,`Adresa`) VALUES 
(1,'273829387', 'Crna ovca', 'crnaovcica@gmail.com', '0631231234','Kralja Petra 15'),
(2,'829283748', 'Moritz Eis', 'moritz@gmail.com', '0654645434','Vuka Karadzica 47');


DROP TABLE IF EXISTS `Proizvodjac`;

CREATE TABLE `Proizvodjac` (
  `ProizvodjacID` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NazivProizvodjaca` VARCHAR(50) NOT NULL,
  `AdresaProizvodjaca` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ProizvodjacID`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;



INSERT  INTO `Proizvodjac`(`ProizvodjacID`,`NazivProizvodjaca`,`AdresaProizvodjaca`) VALUES 
(1,'Ben & Jerrys', 'Bulevar Kralja Aleksandra 82'),
(2,'Hagendas', 'Bulevar Mihajla Pupina 123');

DROP TABLE IF EXISTS `TipSladoleda`;

CREATE TABLE `TipSladoleda` (
  `TipSladoledaID` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NazivTipaSladoleda` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`TipSladoledaID`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;



INSERT  INTO `TipSladoleda`(`TipSladoledaID`,`NazivTipaSladoleda`) VALUES 
(1,'Casica'),
(2,'Kornet'),
(3,'Stapic'),
(4,'Posuda');



DROP TABLE IF EXISTS `Sladoled`;

CREATE TABLE `Sladoled` (
  `SladoledID` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NazivSladoleda` VARCHAR(50) NOT NULL,
  `Cena` DECIMAL(10,2) NOT NULL,
  `Opis` VARCHAR(200) NOT NULL,
  `TipSladoledaID` BIGINT(10) UNSIGNED NOT NULL,
  `ProizvodjacID` BIGINT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`SladoledID`),
  CONSTRAINT `fk_tipSladoleda_id` FOREIGN KEY (`TipSladoledaID`) REFERENCES `TipSladoleda` (`TipSladoledaID`),
  CONSTRAINT `fk_proizvodjac_id` FOREIGN KEY (`ProizvodjacID`) REFERENCES `Proizvodjac` (`ProizvodjacID`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;



INSERT  INTO `Sladoled`(`SladoledID`,`NazivSladoleda`,`Cena`,`Opis`,`TipSladoledaID`,`ProizvodjacID`) VALUES 
(1,'Chocolate Chip Cookie', 700, 'Prelep sladoled.',4,1),
(2,'Vanilla', 700, 'Prelep sladoled.',1,2),
(3,'Pistachio', 700, 'Prelep sladoled.',2,1),
(4,'Walnut', 700, 'Prelep sladoled.',3,2),
(5,'Hazelnut', 700, 'Prelep sladoled.',4,1),
(6,'Salted Caramel', 700, 'Prelep sladoled.',3,2),
(7,'Straciatella', 700, 'Prelep sladoled.',2,1),
(8,'Kiwi', 700, 'Prelep sladoled.',1,2);



DROP TABLE IF EXISTS `Narudzbina`;

CREATE TABLE `Narudzbina` (
  `NarudzbinaID` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `DatumVreme` DATETIME NOT NULL,
  `DatumIsporuke` DATE NOT NULL,
  `OsnovnaCena` DECIMAL(10,2) NOT NULL,
  `KolicinskiRabat` DECIMAL(10,2) NOT NULL,
  `KonacnaCena` DECIMAL(10,2) NOT NULL,
  `KupacID` BIGINT(10) UNSIGNED NOT NULL,
  `AdministratorID` BIGINT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`NarudzbinaID`),
  CONSTRAINT `fk_kupac_id` FOREIGN KEY (`KupacID`) REFERENCES `Kupac` (`KupacID`),
  CONSTRAINT `fk_admin_id` FOREIGN KEY (`AdministratorID`) REFERENCES `Administrator` (`AdministratorID`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



INSERT  INTO `Narudzbina`(`NarudzbinaID`,`DatumVreme`,`DatumIsporuke`,`OsnovnaCena`,`KolicinskiRabat`,`KonacnaCena`,`KupacID`,`AdministratorID`) VALUES 
(1,'2022-02-03 10:30:22','2022-02-10',14000,10,12600,1,1);


DROP TABLE IF EXISTS `StavkaNarudzbine`;

CREATE TABLE `StavkaNarudzbine` (
  `NarudzbinaID` BIGINT(10) UNSIGNED NOT NULL,
  `RbStavke` INT(7) NOT NULL,
  `KolicinaStavke` INT(7) NOT NULL,
  `CenaStavke` DECIMAL(10,2) NOT NULL,
  `SladoledID` BIGINT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`NarudzbinaID`,`RbStavke`),
  CONSTRAINT `fk_narudzbina_id` FOREIGN KEY (`NarudzbinaID`) REFERENCES `Narudzbina` (`NarudzbinaID`) ON DELETE CASCADE,
  CONSTRAINT `fk_sladoled_id` FOREIGN KEY (`SladoledID`) REFERENCES `Sladoled` (`SladoledID`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;



INSERT  INTO `StavkaNarudzbine`(`NarudzbinaID`,`RbStavke`,`KolicinaStavke`,`CenaStavke`, `SladoledID`) VALUES 
(1,1,10,7000,3),
(1,2,10,7000,7);







/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
