-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Bioskop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Bioskop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Bioskop` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Bioskop` ;

-- -----------------------------------------------------
-- Table `Bioskop`.`korisnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`korisnik` (
  `korisnickoIme` VARCHAR(30) NOT NULL,
  `sifraKorisnika` VARCHAR(30) NOT NULL,
  `mail` VARCHAR(255) NOT NULL,
  `ime` VARCHAR(30) NOT NULL,
  `prezime` VARCHAR(30) NOT NULL,
  `datumRodjenja` DATE NULL,
  PRIMARY KEY (`korisnickoIme`),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC))
ENGINE = InnoDB;


INSERT INTO `korisnik` (`korisnickoIme`, `sifraKorisnika`, `mail`, `ime`, `prezime`, `datumRodjenja`) VALUES
('banjac_r', '2789baze2', 'r@gmail.com', 'Rada', 'Banjac', '1996-04-10'),
('dragonm', '0108atd', 'd@hotmail.com', 'Dragana', 'Miladi�', '1994-08-01'),
('Elizabet Vudvil', 'edvard', 'b@gmail.com', 'Branka', 'Petkovi�', '1997-01-22'),
('mihaelagalic', '03071993mg', 'm@hotmail.com', 'Mihaela', 'Gali�', '1993-07-03');


-- -----------------------------------------------------
-- Table `Bioskop`.`kriticar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`kriticar` (
  `korisnik_korisnickoIme` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`korisnik_korisnickoIme`),
  CONSTRAINT `fk_kriticar_korisnik1`
    FOREIGN KEY (`korisnik_korisnickoIme`)
    REFERENCES `Bioskop`.`korisnik` (`korisnickoIme`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


INSERT INTO `kriticar` (`korisnik_korisnickoIme`) VALUES
('Elizabet Vudvil');


-- -----------------------------------------------------
-- Table `Bioskop`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`film` (
  `sifraFilma` INT NOT NULL AUTO_INCREMENT,
  `avatar` VARCHAR(255) NOT NULL,
  `naziv` VARCHAR(100) NOT NULL,
  `godina` INT NOT NULL,
  `trailer` VARCHAR(255) NOT NULL,
  `sadrzaj` LONGTEXT NULL,
  `glumci` VARCHAR(255) NOT NULL,
  `zanr` VARCHAR(110) NOT NULL,
  `ocjena` FLOAT NOT NULL DEFAULT 0,
  `brojKorisnika` INT NULL,
  `trajanje` INT NOT NULL,
  `datumFilma` DATE NOT NULL,
  `kriticar_korisnik_korisnickoIme` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`sifraFilma`),
  INDEX `fk_film_kriticar1_idx` (`kriticar_korisnik_korisnickoIme` ASC),
  CONSTRAINT `fk_film_kriticar1`
    FOREIGN KEY (`kriticar_korisnik_korisnickoIme`)
    REFERENCES `Bioskop`.`kriticar` (`korisnik_korisnickoIme`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


INSERT INTO `film` (`sifraFilma`, `avatar`, `naziv`, `godina`, `trailer`, `sadrzaj`, `glumci`, `zanr`, `ocjena`, `brojKorisnika`, `trajanje`, `datumFilma`, `kriticar_korisnik_korisnickoIme`) VALUES
(1, 'Bohemian Rhapsody (2018).jpg', 'Bohemian Rhapsody', 2018, 'https://www.youtube.com/embed/mP0VHJYFOAU', 'Hronolo�ki opis godina koje su dovele do legendarnog nastupa muzi�ke grupe Queen na Live Aid koncertu (1985).', 'Rami Malek, Lucy Boynton, Gwilym Lee, Ben Hardy, Aidan Gillen', 'mjuzikl drama', 0, NULL, 133, '2020-09-08', 'Elizabet Vudvil'),
(2, 'Brimstone (2016).jpg', 'Brimstone', 2016, 'https://www.youtube.com/embed/Ci3OHOolzEk', 'Trijumfalan ep o pre�ivljavanju i borbi protiv sveprisutne okrutnosti na zemlji. Na�a heroina Liz, srda�na i hrabra djevojka, progonjena je od strane osvetolubivog sve�tenika. Me�utim, Liz nije �rtva, ona je �ena zastra�uju�e snage koja nastoji sa zapanjuju�om hrabrosti prona�i bolji �ivot za sebe i svoju k�er.', 'Dakota Fanning, Guy Pearce, Kit Harington, Carice van Houten', 'triler misterija vestern', 0, NULL, 148, '2020-09-08', 'Elizabet Vudvil'),
(3, 'Crimson Peak (2015).jpg', 'Crimson Peak', 2015, 'https://www.youtube.com/embed/6yAbFYbi8XU', 'Crimson Peak nam govori o Edith Cushing, koja poku�ava pobje�i od tragedije koja je pratila njenu porodicu. Kada njeno srce zarobi zavodljivi stranac, ona biva namamljena do ku�e na vrhu planine sa�injene od krvavo crvene gline. Edith �e uskoro saznati da su prava �udovi�ta napravljena od krvi i mesa. Izme�u po�ude i tame, misterije i ludosti, le�i istina o Crimson Peak-u.', 'Mia Wasikowska, Jessica Chastain, Tom Hiddleston, Charlie Hunnam', 'drama horor fantazija', 0, NULL, 119, '2020-09-08', 'Elizabet Vudvil'),
(4, 'Django Unchained (2012).jpg', 'Django Unchained', 2012, 'https://www.youtube.com/embed/eUdM9vrCbow', 'Uz pomo� njema�kog lovca na glave, oslobo�eni rob se otiskuje na put ka spasavanju sopstvene �ene od svirepog posjednika planta�e iz Misisipija.', 'Jamie Foxx, Christoph Waltz, Leonardo DiCaptio, Samuel L. Jackson', 'akcija drama vestern', 0, NULL, 165, '2020-09-08', 'Elizabet Vudvil'),
(5, 'Don Juan DeMarco (1994).jpg', 'Don Juan DeMarco', 1994, 'https://www.youtube.com/embed/AteQZ7q6rtA', 'Radnja se odvija oko psihijatra koji je sebi zadao cilj da izlije�i mladog pacijenta koji se predstavlja kao Don Juan, �panski plemi� i svjetski priznat zavodnik te ljubavnik �ena.', 'Marlon Brando, Johnny Depp, Faye Dunaway', 'romansa komedija drama', 0, NULL, 157, '2020-09-08', 'Elizabet Vudvil'),
(6, 'Gladiator (2000).png', 'Gladiator', 2000, 'https://www.youtube.com/embed/owK1qxDselE', 'Nakon izdaje rimskog generala i ubistva njegove porodice od strane iskvarenog imperatorovog sina, general odlazi u Rim kao gladijator u potrazi za osvetom.', 'Russell Crowe, Joaquin Phoenix, Connie Nielsen', 'akcija avantura drama', 0, NULL, 171, '2020-09-08', 'Elizabet Vudvil'),
(7, 'Legend (2015).jpg', 'Legend', 2015, 'https://www.youtube.com/embed/ey7S4hko_Mc', 'Zasnovano na knjizi �The Profession of Violence, The Rise and Fall of the Kray Twins� od D�ona Pirsona, Legenda pripovijeda pri�u o blizancima Krej, Red�iju i Roniju Krej. Kori��enjem nasilja da dobiju sve �to po�ele, bra�a su ostavila trag na londonsko podzemlje tokom 60-ih godina 20-og vijeka.', 'Tom Hardy, Emily Browning, Paul Anderson, Taron Edgerton ', 'triler', 0, NULL, 132, '2020-09-08', 'Elizabet Vudvil'),
(8, 'Mary Shelley (2017).jpg', 'Mary Shelley', 2017, 'https://www.youtube.com/embed/T-WGaZaojFc', 'Ljubavna pri�a nove vrste izme�u poznatog pisca �Franken�tajna� Meri Volstonkraft i pjesnika Persi �elija, puna nje�ne strasti i neizmjerne tuge koje su transformisale Meri i inspirisale njeno stvarala�tvo.', 'Elle Fanning, Douglas Booth, Ben Hardy, Maisie Williams, Bel Powley', 'drama romansa', 0, NULL, 121, '2020-09-08', 'Elizabet Vudvil'),
(9, 'Molly\'s Game (2017).png', 'Molly\'s Game', 2017, 'https://www.youtube.com/embed/Vu4UPet8Nyc', 'Zasnovano na istinitoj pri�i o Moli Blum, olimpijskoj skija�ici koja je vodila svjetski najekskluzivniju poker igru sa visokim ulozima deceniju prije hap�enja od strane FBI-a. Njeni igra�i su uklju�ivali holivudske i sportske zvijezde, poslovne velikane i najzad, bez njenog znanja, rusku mafiju. Njen jedini saveznik bio je pravni zastupnik �arli D�efi, koji je primijetio da je Moli mnogo vi�e nego �to to mediji predstavljaju.', 'Jessica Chastain, Idris Elba, Kevin Costner', 'drama', 0, NULL, 141, '2020-09-08', 'Elizabet Vudvil'),
(10, 'The Girl with the Dragon Tattoo (2009).jpg', 'The Girl with the Dragon Tattoo', 2009, 'https://www.youtube.com/embed/JlF-hk3IJQE', 'Pri�a po�inje u redakciji Milenijuma, novina koje su usmjerene ka korupciji, nepravdi i borbi za dru�tvena prava. Mikael Blomkvist, jedan od novinara, udru�uje se sa uli�nim hakerom Lisbet Salander kako bi zajedno istra�ili slu�ajeve vezane za nasilje prema �enama, prostituciju i organizovani kriminal', 'Michael Nyqvist, Noomi Rapace', 'drama misterija triler', 0, NULL, 179, '2020-09-08', 'Elizabet Vudvil'),
(11, 'The Phantom of the Opera (2004).jpg', 'The Phantom of the Opera', 2004, 'https://www.youtube.com/embed/N91AL8sAh9o', 'Mladi sopran postaje opsesija izobli�enog muzi�kog genija koji �ivi ispod Opera ku�e u Parizu.', 'Gerard Butler, Emmy Rossum, Patrick Wilson, Minnie Driver', 'romansa mjuzikl drama', 0, NULL, 143, '2020-09-08', 'Elizabet Vudvil'),
(12, 'Warcraft (2016).jpg', 'Warcraft', 2016, 'https://www.youtube.com/embed/RhFMIRuHAL4', "Tra�e�i izlaz iz svijeta koji umire, �aman orki Gul'dan, koriste�i crnu magiju, otvara portal ka ljudskom carstvu Azerot. Povezivanjem ta dva svijeta, jedna vojska se suo�ava sa uni�tenjem, a druga sa izumiranjem.", 'Travis Fimmel, Paula Patton, Ben Foster, Dominic Cooper', 'akcija avantura fantazija', 0, NULL, 123, '2020-09-08', 'Elizabet Vudvil'),
(13, 'Wonder Woman (2017).jpg', 'Wonder Woman', 2017, 'https://www.youtube.com/embed/VSB4wGIdDwo', 'Prije nego �to je postala Wonder Woman, bila je Dijana, princeza Amazona, trenirani ratnik. Kada se pilot sru�i na njenu teritoriju i ispri�a joj pri�u o konfliktima spoljnog svijeta, ona napu�ta dom kako bi se borila u ratu za okon�anje svih ratova, otkrivaju�i usput svoju snagu i pravu sudbinu.', 'Gal Gadot, Chris Pine, Connie Nielsen, Robin Wright', 'akcija avantura fantazija ratni', 0, NULL, 149, '2020-09-08', 'Elizabet Vudvil'),
(14, 'Troy (2004).jpg', 'Troy', 2004, 'https://www.youtube.com/embed/znTLzRJimeY', 'Troja je smje�tena u rat propra�en gladi za slavom i mo�i. Mnogo je nedu�nih izgubilo �ivote zbog ambicija jednoga �ovjeka. Oba naroda pate i kraljevstvo je zbrisano.', 'Brad Pitt, Eric Bana, Orlando Bloom, Diane Kruger, Sean Bean', 'avantura drama ratni', 0, NULL, 179, '2020-09-08', 'Elizabet Vudvil'),
(15, 'A Beautiful Mind (2001).jpg', 'A Beautiful Mind', 2001, 'https://www.youtube.com/embed/9wZM7CQY130', 'Nakon �to prihvati tajni posao vezan za kriptografiju, njegov �ivot postaje no�na mora.', 'Russell Crowe, Ed Harris, Jennifer Connelly, Christopher Plummer', 'romansa drama', 0, NULL, 140, '2020-09-09', 'Elizabet Vudvil'),
(16, 'Mesrine Part 1 - Killer Instinct (2008).jpg', 'Mesrine Part 1 - Killer Instinct', 2008, 'https://www.youtube.com/embed/GDSekGDUHHE', 'Nakon �to mu incident u vojsci ostavi ukus nasilne nadmo�i, ozlogla�eni francuski gangster izgra�uje karijeru sa lebde�om opasnosti nad glavom.', 'Vincent Cassel,  C�cile de France, G�rard Depardieu, Roy Dupuis', 'akcija triler', 0, NULL, 113, '2020-09-09', 'Elizabet Vudvil'),
(17, 'Atomic Blonde (2017).jpg', 'Atomic Blonde', 2017, 'https://www.youtube.com/embed/yIUube1pSC0', 'Tajni agent MI6 je poslan u Berlin tokom Hladnog rata kako bi prona�ao nestalog kolegu agenta, kao i listu dvojnih agenata.', 'Charlize Theron, James McAvoy, Eddie Marsan, Sofia Boutella, Bill SkarsgĂĄrd', 'akcija triler misterija', 0, NULL, 115, '2020-09-09', 'Elizabet Vudvil'),
(18, 'Black Book (2006).jpg', 'Black Book', 2006, 'https://www.youtube.com/embed/DIklvGsU7bM', 'Poslije izbjegavanja bliske smrti, mlada Rahel Rozental postaje dio jevrejskog otpora pritom uzimaju�i ime Elis de Vri. U nacisti�ki okupiranoj Norve�koj, ona se infiltrira u Gestapo rade�i ovaj put za danski otpor.', 'Carice van Houten, Sebastian Koch, Michiel Huisman', 'triler ratni drama', 0, NULL, 145, '2020-09-09', 'Elizabet Vudvil'),
(19, 'Changeling (2008).jpg', 'Changeling ', 2008, 'https://www.youtube.com/embed/PmfjureC-5I', 'Los An�eles, 1928. godina, samohrana majka Kristin Kolins poku�ava da doka�e policiji kako je njeno navodno dijete podme�e, dok istovremeno ne odustaje od tra�enja svoga sina.', 'Angelina Jolie, Gattlin Griffith, Michelle Gunn', 'drama misterija', 0, NULL, 142, '2020-09-09', 'Elizabet Vudvil'),
(20, 'Dogville (2003).jpg', 'Dogville', 2003, 'https://www.youtube.com/embed/J5-LqwUHTaM', 'Dra�esna bjegunka, Grejs, biva nevoljno prihva�ena u gradi� iz Kolorada. Kako vlasti pre�e�ljavaju grad u potrazi za njom, ona saznaje da za�tita mje�tana ima svoju cijenu. Me�utim, Grejs tako�e ima tajnu...', 'Nicole Kidman, Paul Bettany, Harriet Andersson, Lauren Bacall', 'drama triler', 8.8, 55, 179, '2020-09-09', 'Elizabet Vudvil');


-- -----------------------------------------------------
-- Table `Bioskop`.`komentar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`komentar` (
  `datum` DATETIME NOT NULL DEFAULT current_timestamp,
  `tekst` TEXT NOT NULL,
  `korisnik_korisnickoIme` VARCHAR(30) NOT NULL,
  `film_sifraFilma` INT NOT NULL,
  PRIMARY KEY (`datum`, `korisnik_korisnickoIme`, `film_sifraFilma`),
  INDEX `fk_komentar_korisnik_idx` (`korisnik_korisnickoIme` ASC),
  INDEX `fk_komentar_film1_idx` (`film_sifraFilma` ASC),
  CONSTRAINT `fk_komentar_korisnik`
    FOREIGN KEY (`korisnik_korisnickoIme`)
    REFERENCES `Bioskop`.`korisnik` (`korisnickoIme`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_komentar_film1`
    FOREIGN KEY (`film_sifraFilma`)
    REFERENCES `Bioskop`.`film` (`sifraFilma`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


INSERT INTO `komentar` (`datum`, `tekst`, `korisnik_korisnickoIme`, `film_sifraFilma`) VALUES
('2020-09-16 11:34:04', ' U ovom filmskom ostvarenju prikazana je varljiva priroda ljudskog dru�tva, kao i surovost svijeta oko nas. Po�etak filma je poprili�no spor, me�utim, kako radnja sve vi�e odmi�e, te�ko je skinuti pogled sa filmskog platna.', 'Elizabet Vudvil', 20),
('2020-09-16 13:05:52', ' Topla preporuka za sve one koji vole da vide ne�to sasvim druga�ije i potpuno neo�ekivano.', 'dragonm', 20);


-- -----------------------------------------------------
-- Table `Bioskop`.`administrator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`administrator` (
  `korisnik_korisnickoIme` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`korisnik_korisnickoIme`),
  CONSTRAINT `fk_administrator_korisnik1`
    FOREIGN KEY (`korisnik_korisnickoIme`)
    REFERENCES `Bioskop`.`korisnik` (`korisnickoIme`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


INSERT INTO `administrator` (`korisnik_korisnickoIme`) VALUES
('dragonm');


-- -----------------------------------------------------
-- Table `Bioskop`.`odobreni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`odobreni` (
  `film_sifraFilma` INT NOT NULL,
  `administrator_korisnik_korisnickoIme` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`film_sifraFilma`),
  INDEX `fk_odobreni_administrator1_idx` (`administrator_korisnik_korisnickoIme` ASC),
  CONSTRAINT `fk_odobreni_film1`
    FOREIGN KEY (`film_sifraFilma`)
    REFERENCES `Bioskop`.`film` (`sifraFilma`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_odobreni_administrator1`
    FOREIGN KEY (`administrator_korisnik_korisnickoIme`)
    REFERENCES `Bioskop`.`administrator` (`korisnik_korisnickoIme`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


INSERT INTO `odobreni` (`film_sifraFilma`, `administrator_korisnik_korisnickoIme`) VALUES
(1, 'dragonm'),
(2, 'dragonm'),
(3, 'dragonm'),
(4, 'dragonm'),
(5, 'dragonm'),
(6, 'dragonm'),
(7, 'dragonm'),
(8, 'dragonm'),
(11, 'dragonm'),
(13, 'dragonm'),
(14, 'dragonm'),
(16, 'dragonm'),
(17, 'dragonm'),
(18, 'dragonm'),
(20, 'dragonm');


-- -----------------------------------------------------
-- Table `Bioskop`.`sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`sala` (
  `idSale` INT NOT NULL AUTO_INCREMENT,
  `brojMjesta` INT NOT NULL,
  `brojRedova` INT NOT NULL,
  PRIMARY KEY (`idSale`))
ENGINE = InnoDB;


INSERT INTO `sala` (`idSale`, `brojMjesta`, `brojRedova`) VALUES ('1', '8', '8'), ('2', '7', '4');


-- -----------------------------------------------------
-- Table `Bioskop`.`prikazi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`prikazi` (
  `datumPrikazivanja` DATE NOT NULL,
  `termin` TIME NOT NULL,
  `odobreni_film_sifraFilma` INT NOT NULL,
  `sala_idSale` INT NOT NULL,
  PRIMARY KEY (`datumPrikazivanja`, `termin`, `odobreni_film_sifraFilma`, `sala_idSale`),
  INDEX `fk_prikazi_odobreni1_idx` (`odobreni_film_sifraFilma` ASC),
  INDEX `fk_prikazi_sala1_idx` (`sala_idSale` ASC),
  CONSTRAINT `fk_prikazi_odobreni1`
    FOREIGN KEY (`odobreni_film_sifraFilma`)
    REFERENCES `Bioskop`.`odobreni` (`film_sifraFilma`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_prikazi_sala1`
    FOREIGN KEY (`sala_idSale`)
    REFERENCES `Bioskop`.`sala` (`idSale`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


INSERT INTO `prikazi` (`datumPrikazivanja`, `termin`, `odobreni_film_sifraFilma`, `sala_idSale`) VALUES ('2020-11-16', '16:00', '20', '1'), ('2020-11-16', '22:15', '20', '1'), ('2020-11-16', '22:15', '20', '2'), ('2020-11-25', '17:30', '20', '2');


-- -----------------------------------------------------
-- Table `Bioskop`.`karta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`karta` (
  `red` INT NOT NULL,
  `brojSjedista` INT NOT NULL,
  `prikazi_datumPrikazivanja` DATE NOT NULL,
  `prikazi_termin` TIME NOT NULL,
  `prikazi_odobreni_film_sifraFilma` INT NOT NULL,
  `prikazi_sala_idSale` INT NOT NULL,
  PRIMARY KEY (`red`, `brojSjedista`, `prikazi_datumPrikazivanja`, `prikazi_termin`, `prikazi_odobreni_film_sifraFilma`, `prikazi_sala_idSale`),
  INDEX `fk_karta_prikazi1_idx` (`prikazi_datumPrikazivanja` ASC, `prikazi_termin` ASC, `prikazi_odobreni_film_sifraFilma` ASC, `prikazi_sala_idSale` ASC),
  CONSTRAINT `fk_karta_prikazi1`
    FOREIGN KEY (`prikazi_datumPrikazivanja` , `prikazi_termin` , `prikazi_odobreni_film_sifraFilma` , `prikazi_sala_idSale`)
    REFERENCES `Bioskop`.`prikazi` (`datumPrikazivanja` , `termin` , `odobreni_film_sifraFilma` , `sala_idSale`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


INSERT INTO `karta` (`red`, `brojSjedista`, `prikazi_datumPrikazivanja`, `prikazi_termin`, `prikazi_odobreni_film_sifraFilma`, `prikazi_sala_idSale`) VALUES
(1, 1, '2020-11-16', '16:00:00', 20, 1),
(1, 1, '2020-11-16', '22:15:00', 20, 1),
(1, 1, '2020-11-16', '22:15:00', 20, 2),
(1, 1, '2020-11-25', '17:30:00', 20, 2),
(1, 2, '2020-11-16', '16:00:00', 20, 1),
(1, 2, '2020-11-16', '22:15:00', 20, 1),
(1, 2, '2020-11-16', '22:15:00', 20, 2),
(1, 2, '2020-11-25', '17:30:00', 20, 2),
(1, 3, '2020-11-16', '16:00:00', 20, 1),
(1, 3, '2020-11-16', '22:15:00', 20, 1),
(1, 3, '2020-11-16', '22:15:00', 20, 2),
(1, 3, '2020-11-25', '17:30:00', 20, 2),
(1, 4, '2020-11-16', '16:00:00', 20, 1),
(1, 4, '2020-11-16', '22:15:00', 20, 1),
(1, 4, '2020-11-16', '22:15:00', 20, 2),
(1, 4, '2020-11-25', '17:30:00', 20, 2),
(1, 5, '2020-11-16', '16:00:00', 20, 1),
(1, 5, '2020-11-16', '22:15:00', 20, 1),
(1, 5, '2020-11-16', '22:15:00', 20, 2),
(1, 5, '2020-11-25', '17:30:00', 20, 2),
(1, 6, '2020-11-16', '16:00:00', 20, 1),
(1, 6, '2020-11-16', '22:15:00', 20, 1),
(1, 6, '2020-11-16', '22:15:00', 20, 2),
(1, 6, '2020-11-25', '17:30:00', 20, 2),
(1, 7, '2020-11-16', '16:00:00', 20, 1),
(1, 7, '2020-11-16', '22:15:00', 20, 1),
(1, 7, '2020-11-16', '22:15:00', 20, 2),
(1, 7, '2020-11-25', '17:30:00', 20, 2),
(1, 8, '2020-11-16', '16:00:00', 20, 1),
(1, 8, '2020-11-16', '22:15:00', 20, 1),
(2, 1, '2020-11-16', '16:00:00', 20, 1),
(2, 1, '2020-11-16', '22:15:00', 20, 1),
(2, 1, '2020-11-16', '22:15:00', 20, 2),
(2, 1, '2020-11-25', '17:30:00', 20, 2),
(2, 2, '2020-11-16', '16:00:00', 20, 1),
(2, 2, '2020-11-16', '22:15:00', 20, 1),
(2, 2, '2020-11-16', '22:15:00', 20, 2),
(2, 2, '2020-11-25', '17:30:00', 20, 2),
(2, 3, '2020-11-16', '16:00:00', 20, 1),
(2, 3, '2020-11-16', '22:15:00', 20, 1),
(2, 3, '2020-11-16', '22:15:00', 20, 2),
(2, 3, '2020-11-25', '17:30:00', 20, 2),
(2, 4, '2020-11-16', '16:00:00', 20, 1),
(2, 4, '2020-11-16', '22:15:00', 20, 1),
(2, 4, '2020-11-16', '22:15:00', 20, 2),
(2, 4, '2020-11-25', '17:30:00', 20, 2),
(2, 5, '2020-11-16', '16:00:00', 20, 1),
(2, 5, '2020-11-16', '22:15:00', 20, 1),
(2, 5, '2020-11-16', '22:15:00', 20, 2),
(2, 5, '2020-11-25', '17:30:00', 20, 2),
(2, 6, '2020-11-16', '16:00:00', 20, 1),
(2, 6, '2020-11-16', '22:15:00', 20, 1),
(2, 6, '2020-11-16', '22:15:00', 20, 2),
(2, 6, '2020-11-25', '17:30:00', 20, 2),
(2, 7, '2020-11-16', '16:00:00', 20, 1),
(2, 7, '2020-11-16', '22:15:00', 20, 1),
(2, 7, '2020-11-16', '22:15:00', 20, 2),
(2, 7, '2020-11-25', '17:30:00', 20, 2),
(2, 8, '2020-11-16', '16:00:00', 20, 1),
(2, 8, '2020-11-16', '22:15:00', 20, 1),
(3, 1, '2020-11-16', '16:00:00', 20, 1),
(3, 1, '2020-11-16', '22:15:00', 20, 1),
(3, 1, '2020-11-16', '22:15:00', 20, 2),
(3, 1, '2020-11-25', '17:30:00', 20, 2),
(3, 2, '2020-11-16', '16:00:00', 20, 1),
(3, 2, '2020-11-16', '22:15:00', 20, 1),
(3, 2, '2020-11-16', '22:15:00', 20, 2),
(3, 2, '2020-11-25', '17:30:00', 20, 2),
(3, 3, '2020-11-16', '16:00:00', 20, 1),
(3, 3, '2020-11-16', '22:15:00', 20, 1),
(3, 3, '2020-11-16', '22:15:00', 20, 2),
(3, 3, '2020-11-25', '17:30:00', 20, 2),
(3, 4, '2020-11-16', '16:00:00', 20, 1),
(3, 4, '2020-11-16', '22:15:00', 20, 1),
(3, 4, '2020-11-16', '22:15:00', 20, 2),
(3, 4, '2020-11-25', '17:30:00', 20, 2),
(3, 5, '2020-11-16', '16:00:00', 20, 1),
(3, 5, '2020-11-16', '22:15:00', 20, 1),
(3, 5, '2020-11-16', '22:15:00', 20, 2),
(3, 5, '2020-11-25', '17:30:00', 20, 2),
(3, 6, '2020-11-16', '16:00:00', 20, 1),
(3, 6, '2020-11-16', '22:15:00', 20, 1),
(3, 6, '2020-11-16', '22:15:00', 20, 2),
(3, 6, '2020-11-25', '17:30:00', 20, 2),
(3, 7, '2020-11-16', '16:00:00', 20, 1),
(3, 7, '2020-11-16', '22:15:00', 20, 1),
(3, 7, '2020-11-16', '22:15:00', 20, 2),
(3, 7, '2020-11-25', '17:30:00', 20, 2),
(3, 8, '2020-11-16', '16:00:00', 20, 1),
(3, 8, '2020-11-16', '22:15:00', 20, 1),
(4, 1, '2020-11-16', '16:00:00', 20, 1),
(4, 1, '2020-11-16', '22:15:00', 20, 1),
(4, 1, '2020-11-16', '22:15:00', 20, 2),
(4, 1, '2020-11-25', '17:30:00', 20, 2),
(4, 2, '2020-11-16', '16:00:00', 20, 1),
(4, 2, '2020-11-16', '22:15:00', 20, 1),
(4, 2, '2020-11-16', '22:15:00', 20, 2),
(4, 2, '2020-11-25', '17:30:00', 20, 2),
(4, 3, '2020-11-16', '16:00:00', 20, 1),
(4, 3, '2020-11-16', '22:15:00', 20, 1),
(4, 3, '2020-11-16', '22:15:00', 20, 2),
(4, 3, '2020-11-25', '17:30:00', 20, 2),
(4, 4, '2020-11-16', '16:00:00', 20, 1),
(4, 4, '2020-11-16', '22:15:00', 20, 1),
(4, 4, '2020-11-16', '22:15:00', 20, 2),
(4, 4, '2020-11-25', '17:30:00', 20, 2),
(4, 5, '2020-11-16', '16:00:00', 20, 1),
(4, 5, '2020-11-16', '22:15:00', 20, 1),
(4, 5, '2020-11-16', '22:15:00', 20, 2),
(4, 5, '2020-11-25', '17:30:00', 20, 2),
(4, 6, '2020-11-16', '16:00:00', 20, 1),
(4, 6, '2020-11-16', '22:15:00', 20, 1),
(4, 6, '2020-11-16', '22:15:00', 20, 2),
(4, 6, '2020-11-25', '17:30:00', 20, 2),
(4, 7, '2020-11-16', '16:00:00', 20, 1),
(4, 7, '2020-11-16', '22:15:00', 20, 1),
(4, 7, '2020-11-16', '22:15:00', 20, 2),
(4, 7, '2020-11-25', '17:30:00', 20, 2),
(4, 8, '2020-11-16', '16:00:00', 20, 1),
(4, 8, '2020-11-16', '22:15:00', 20, 1),
(5, 1, '2020-11-16', '16:00:00', 20, 1),
(5, 1, '2020-11-16', '22:15:00', 20, 1),
(5, 2, '2020-11-16', '16:00:00', 20, 1),
(5, 2, '2020-11-16', '22:15:00', 20, 1),
(5, 3, '2020-11-16', '16:00:00', 20, 1),
(5, 3, '2020-11-16', '22:15:00', 20, 1),
(5, 4, '2020-11-16', '16:00:00', 20, 1),
(5, 4, '2020-11-16', '22:15:00', 20, 1),
(5, 5, '2020-11-16', '16:00:00', 20, 1),
(5, 5, '2020-11-16', '22:15:00', 20, 1),
(5, 6, '2020-11-16', '16:00:00', 20, 1),
(5, 6, '2020-11-16', '22:15:00', 20, 1),
(5, 7, '2020-11-16', '16:00:00', 20, 1),
(5, 7, '2020-11-16', '22:15:00', 20, 1),
(5, 8, '2020-11-16', '16:00:00', 20, 1),
(5, 8, '2020-11-16', '22:15:00', 20, 1),
(6, 1, '2020-11-16', '16:00:00', 20, 1),
(6, 1, '2020-11-16', '22:15:00', 20, 1),
(6, 2, '2020-11-16', '16:00:00', 20, 1),
(6, 2, '2020-11-16', '22:15:00', 20, 1),
(6, 3, '2020-11-16', '16:00:00', 20, 1),
(6, 3, '2020-11-16', '22:15:00', 20, 1),
(6, 4, '2020-11-16', '16:00:00', 20, 1),
(6, 4, '2020-11-16', '22:15:00', 20, 1),
(6, 5, '2020-11-16', '16:00:00', 20, 1),
(6, 5, '2020-11-16', '22:15:00', 20, 1),
(6, 6, '2020-11-16', '16:00:00', 20, 1),
(6, 6, '2020-11-16', '22:15:00', 20, 1),
(6, 7, '2020-11-16', '16:00:00', 20, 1),
(6, 7, '2020-11-16', '22:15:00', 20, 1),
(6, 8, '2020-11-16', '16:00:00', 20, 1),
(6, 8, '2020-11-16', '22:15:00', 20, 1),
(7, 1, '2020-11-16', '16:00:00', 20, 1),
(7, 1, '2020-11-16', '22:15:00', 20, 1),
(7, 2, '2020-11-16', '16:00:00', 20, 1),
(7, 2, '2020-11-16', '22:15:00', 20, 1),
(7, 3, '2020-11-16', '16:00:00', 20, 1),
(7, 3, '2020-11-16', '22:15:00', 20, 1),
(7, 4, '2020-11-16', '16:00:00', 20, 1),
(7, 4, '2020-11-16', '22:15:00', 20, 1),
(7, 5, '2020-11-16', '16:00:00', 20, 1),
(7, 5, '2020-11-16', '22:15:00', 20, 1),
(7, 6, '2020-11-16', '16:00:00', 20, 1),
(7, 6, '2020-11-16', '22:15:00', 20, 1),
(7, 7, '2020-11-16', '16:00:00', 20, 1),
(7, 7, '2020-11-16', '22:15:00', 20, 1),
(7, 8, '2020-11-16', '16:00:00', 20, 1),
(7, 8, '2020-11-16', '22:15:00', 20, 1),
(8, 1, '2020-11-16', '16:00:00', 20, 1),
(8, 1, '2020-11-16', '22:15:00', 20, 1),
(8, 2, '2020-11-16', '16:00:00', 20, 1),
(8, 2, '2020-11-16', '22:15:00', 20, 1),
(8, 3, '2020-11-16', '16:00:00', 20, 1),
(8, 3, '2020-11-16', '22:15:00', 20, 1),
(8, 4, '2020-11-16', '16:00:00', 20, 1),
(8, 4, '2020-11-16', '22:15:00', 20, 1),
(8, 5, '2020-11-16', '16:00:00', 20, 1),
(8, 5, '2020-11-16', '22:15:00', 20, 1),
(8, 6, '2020-11-16', '16:00:00', 20, 1),
(8, 6, '2020-11-16', '22:15:00', 20, 1),
(8, 7, '2020-11-16', '16:00:00', 20, 1),
(8, 7, '2020-11-16', '22:15:00', 20, 1),
(8, 8, '2020-11-16', '16:00:00', 20, 1),
(8, 8, '2020-11-16', '22:15:00', 20, 1);


-- -----------------------------------------------------
-- Table `Bioskop`.`rezervisi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bioskop`.`rezervisi` (
  `karta_red` INT NOT NULL,
  `karta_brojSjedista` INT NOT NULL,
  `karta_prikazi_datumPrikazivanja` DATE NOT NULL,
  `karta_prikazi_termin` TIME NOT NULL,
  `karta_prikazi_odobreni_film_sifraFilma` INT NOT NULL,
  `karta_prikazi_sala_idSale` INT NOT NULL,
  `korisnik_korisnickoIme` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`karta_red`, `karta_brojSjedista`, `karta_prikazi_datumPrikazivanja`, `karta_prikazi_termin`, `karta_prikazi_odobreni_film_sifraFilma`, `karta_prikazi_sala_idSale`, `korisnik_korisnickoIme`),
  INDEX `fk_rezervisi_korisnik1_idx` (`korisnik_korisnickoIme` ASC),
  CONSTRAINT `fk_rezervisi_karta1`
    FOREIGN KEY (`karta_red` , `karta_brojSjedista` , `karta_prikazi_datumPrikazivanja` , `karta_prikazi_termin` , `karta_prikazi_odobreni_film_sifraFilma` , `karta_prikazi_sala_idSale`)
    REFERENCES `Bioskop`.`karta` (`red` , `brojSjedista` , `prikazi_datumPrikazivanja` , `prikazi_termin` , `prikazi_odobreni_film_sifraFilma` , `prikazi_sala_idSale`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rezervisi_korisnik1`
    FOREIGN KEY (`korisnik_korisnickoIme`)
    REFERENCES `Bioskop`.`korisnik` (`korisnickoIme`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


INSERT INTO `rezervisi` (`karta_red`, `karta_brojSjedista`, `karta_prikazi_datumPrikazivanja`, `karta_prikazi_termin`, `karta_prikazi_odobreni_film_sifraFilma`, `karta_prikazi_sala_idSale`, `korisnik_korisnickoIme`) VALUES ('2', '2', '2020-11-16', '16:00:00', '20', '1', 'dragonm'), ('2', '3', '2020-11-16', '16:00:00', '20', '1', 'dragonm'),
('4', '5', '2020-11-16', '16:00:00', '20', '1', 'banjac_r'),
('8', '2', '2020-11-16', '16:00:00', '20', '1', 'banjac_r'),
('7', '8', '2020-11-16', '16:00:00', '20', '1', 'banjac_r'),
('4', '4', '2020-11-16', '16:00:00', '20', '1', 'mihaelagalic'),
('4', '6', '2020-11-16', '16:00:00', '20', '1', 'mihaelagalic'),
('2', '4', '2020-11-16', '16:00:00', '20', '1', 'Elizabet Vudvil'),
('4', '3', '2020-11-16', '16:00:00', '20', '1', 'Elizabet Vudvil'),
('8', '3', '2020-11-16', '16:00:00', '20', '1', 'Elizabet Vudvil');


-- CHECK u obliku okidaca za provjeru godine i trajanja filma:
DELIMITER $$
CREATE TRIGGER film_check BEFORE INSERT ON `Bioskop`.`film`
	FOR EACH ROW
    BEGIN
    IF (NEW.godina<=1900 OR NEW.godina>YEAR(CURRENT_DATE)) THEN 
		 SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT='Godina filma nije validna!';
	END IF;
    IF (NEW.trajanje<30) THEN 
		 SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT='Greska: Film je kraci od 30 minuta!';
         ELSEIF (NEW.trajanje>180) THEN
         SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT='Greska: Film je duzi od 180 minuta!';
	END IF;
	END$$
    DELIMITER ;
    
-- TRIGGER koji prilikom ocjenjivanja filma mijenja prosjecnu ocjenu filma i broj korisnika:
DELIMITER $$
CREATE TRIGGER film_ocjena BEFORE UPDATE ON `Bioskop`.`film`
	FOR EACH ROW
    BEGIN 
    IF (OLD.ocjena = 0 && NEW.ocjena IS NOT NULL) THEN SET NEW.brojKorisnika=1;
    ELSE
    SET NEW.ocjena= ROUND (((OLD.ocjena * OLD.brojKorisnika) + NEW.ocjena)/(OLD.brojKorisnika + 1), 1), NEW.brojKorisnika=OLD.brojKorisnika + 1;
    END IF;
	END$$
    DELIMITER ;
    
-- Indeksi za pretragu:
ALTER TABLE `Bioskop`.`film` ADD INDEX USING HASH (`avatar`);

ALTER TABLE `Bioskop`.`film` ADD INDEX USING BTREE (`naziv`);

ALTER TABLE `Bioskop`.`film` ADD INDEX USING BTREE (`zanr`);

-- CHECK u obliku okidaca za promjenu termina filma:
DELIMITER $$
CREATE TRIGGER prikazivanje BEFORE INSERT ON `Bioskop`.`prikazi`
FOR EACH ROW 
BEGIN
DECLARE mali,veliki TIME;
DECLARE malitrajanje, temp, novitrajanje INT; 

IF(SECOND(NEW.termin) <> '00') THEN   -- Unos sekundi u terminu filma je blokiran
		 SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT='Greska: Nije potrebno unositi sekunde!';
		END IF;

IF(NEW.termin NOT BETWEEN '16:00:00' AND '23:00:00') THEN -- Dozvoljeni su samo termini izmedju 16:00 i 23:00
	     SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT='Greska: Termin filma nije validan!';
		END IF;

SET novitrajanje=(SELECT trajanje FROM film WHERE sifraFilma=NEW.odobreni_film_sifraFilma); -- trajanje novog filma kojeg unosimo u tabelu prikazi
SET temp=HOUR(NEW.termin)*60+MINUTE(NEW.termin); -- termin filma koji unosimo u bazu u INT (racunamo u kojem minutu dana pocinje film)
SELECT MAX(termin) INTO mali FROM prikazi WHERE sala_idSale=NEW.sala_idSale AND datumPrikazivanja=NEW.datumPrikazivanja AND termin<NEW.termin; -- termin filma koji je prije termina novog,koji je u istoj sali istog datuma 
SELECT MIN(termin) INTO veliki FROM prikazi WHERE sala_idSale=NEW.sala_idSale AND datumPrikazivanja=NEW.datumPrikazivanja AND termin>NEW.termin; -- termin filma koji je poslije termina novog
IF(mali IS NOT NULL) THEN
	SET malitrajanje=(SELECT trajanje FROM film WHERE sifraFilma IN (SELECT odobreni_film_sifraFilma FROM prikazi WHERE sala_idSale=NEW.sala_idSale AND datumPrikazivanja=NEW.datumPrikazivanja AND termin = mali)); -- trajanje filma koji je prije novog
	IF ((HOUR(mali)*60+MINUTE(mali)+malitrajanje+15) > temp) THEN
					SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT='Temin ulazi u termin prikazivanja drugog filma!';
	END IF;
END IF;
IF(veliki IS NOT NULL) THEN
					IF((temp+novitrajanje+15) > (HOUR(veliki)*60+MINUTE(veliki))) THEN
                    	SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT='Temin ulazi u termin prikazivanja drugog filma!';
                    END IF;
END IF;
END$$
DELIMITER ;

-- EVENT za brisanje filma cije prikazivanje je isteklo:
/* SET GLOBAL EVENT_SCHEDULER="ON";
CREATE EVENT `DatumPrikazivanja` ON SCHEDULE EVERY 1 DAY STARTS '2020-_-_00:00:00' ON 
COMPLETION PRESERVE ENABLE
DO DELETE FROM `Bioskop`.`prikazi` WHERE datumPrikazivanja > CURRENT_DATE; */


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
