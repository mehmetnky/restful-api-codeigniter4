-- --------------------------------------------------------
-- Sunucu:                       127.0.0.1
-- Sunucu sürümü:                10.4.10-MariaDB - mariadb.org binary distribution
-- Sunucu İşletim Sistemi:       Win64
-- HeidiSQL Sürüm:               9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- futbolapp için veritabanı yapısı dökülüyor
CREATE DATABASE IF NOT EXISTS `futbolapp` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `futbolapp`;

-- tablo yapısı dökülüyor futbolapp.formasyonlar
CREATE TABLE IF NOT EXISTS `formasyonlar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oyuncu_id` int(11) NOT NULL DEFAULT 0,
  `mevki_id` int(11) NOT NULL DEFAULT 0,
  `takim_id` int(11) NOT NULL DEFAULT 0,
  `onbirdeMi` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK__oyuncular` (`oyuncu_id`),
  KEY `FK__mevkiler` (`mevki_id`),
  KEY `FK__takimlar` (`takim_id`),
  CONSTRAINT `FK__mevkiler` FOREIGN KEY (`mevki_id`) REFERENCES `mevkiler` (`id`),
  CONSTRAINT `FK__oyuncular` FOREIGN KEY (`oyuncu_id`) REFERENCES `oyuncular` (`id`),
  CONSTRAINT `FK__takimlar` FOREIGN KEY (`takim_id`) REFERENCES `takimlar` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- futbolapp.formasyonlar: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `formasyonlar` DISABLE KEYS */;
REPLACE INTO `formasyonlar` (`id`, `oyuncu_id`, `mevki_id`, `takim_id`, `onbirdeMi`) VALUES
	(1, 3, 7, 1, 1),
	(3, 2, 5, 1, 1),
	(4, 1, 3, 1, 0),
	(5, 1, 24, 2, 1);
/*!40000 ALTER TABLE `formasyonlar` ENABLE KEYS */;

-- tablo yapısı dökülüyor futbolapp.forma_bedenler
CREATE TABLE IF NOT EXISTS `forma_bedenler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `beden` varchar(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- futbolapp.forma_bedenler: ~6 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `forma_bedenler` DISABLE KEYS */;
REPLACE INTO `forma_bedenler` (`id`, `beden`) VALUES
	(1, 'XS'),
	(2, 'S'),
	(3, 'SM'),
	(4, 'M'),
	(5, 'L'),
	(6, 'XL');
/*!40000 ALTER TABLE `forma_bedenler` ENABLE KEYS */;

-- tablo yapısı dökülüyor futbolapp.maclar
CREATE TABLE IF NOT EXISTS `maclar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `takim_ev_id` int(11) NOT NULL DEFAULT 0,
  `takim_deplasman_id` int(11) NOT NULL DEFAULT 0,
  `halisaha_id` int(11) NOT NULL DEFAULT 0,
  `baslangic_saati` int(11) NOT NULL DEFAULT 0,
  `bitis_saati` int(11) NOT NULL DEFAULT 0,
  `kazanan_takim_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_maclar_takimlar` (`takim_deplasman_id`),
  KEY `FK_maclar_takimlar_2` (`takim_ev_id`),
  CONSTRAINT `FK_maclar_takimlar` FOREIGN KEY (`takim_deplasman_id`) REFERENCES `takimlar` (`id`),
  CONSTRAINT `FK_maclar_takimlar_2` FOREIGN KEY (`takim_ev_id`) REFERENCES `takimlar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- futbolapp.maclar: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `maclar` DISABLE KEYS */;
/*!40000 ALTER TABLE `maclar` ENABLE KEYS */;

-- tablo yapısı dökülüyor futbolapp.mevkiler
CREATE TABLE IF NOT EXISTS `mevkiler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mevki` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- futbolapp.mevkiler: ~27 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `mevkiler` DISABLE KEYS */;
REPLACE INTO `mevkiler` (`id`, `mevki`) VALUES
	(1, 'KL'),
	(2, 'STP'),
	(3, 'SĞB'),
	(4, 'SLB'),
	(5, 'SĞKB'),
	(6, 'SLKB'),
	(7, 'MDO'),
	(8, 'MO'),
	(9, 'MOO'),
	(10, 'SLOO'),
	(11, 'SĞOO'),
	(12, 'OF'),
	(13, 'SNT'),
	(14, 'SLK'),
	(15, 'SĞK'),
	(16, 'SĞO'),
	(17, 'SLO'),
	(18, 'SLS'),
	(19, 'SĞS'),
	(20, 'SĞMO'),
	(21, 'SLMO'),
	(22, 'SĞF'),
	(23, 'SLF'),
	(24, 'SDOS'),
	(25, 'SĞDO'),
	(26, 'SLMB'),
	(27, 'SĞMB');
/*!40000 ALTER TABLE `mevkiler` ENABLE KEYS */;

-- tablo yapısı dökülüyor futbolapp.oyuncular
CREATE TABLE IF NOT EXISTS `oyuncular` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(256) NOT NULL DEFAULT '0',
  `sifre` varchar(64) NOT NULL DEFAULT '0',
  `accessToken` varchar(512) DEFAULT '0',
  `ad` varchar(64) NOT NULL DEFAULT '0',
  `soyad` varchar(64) NOT NULL DEFAULT '0',
  `foto` varchar(256) DEFAULT 'pp.png',
  `dogum_gunu` date NOT NULL,
  `forma_numarasi` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `mevki_id` int(11) NOT NULL,
  `ikincil_mevki_id` int(11) DEFAULT NULL,
  `forma_beden_id` int(11) NOT NULL,
  `boy` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `kilo` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `ayakkabi_numarasi` int(11) NOT NULL,
  `ayak` enum('Sağ','Sol','Çift') NOT NULL DEFAULT 'Sağ',
  PRIMARY KEY (`id`),
  KEY `bedenler` (`forma_beden_id`),
  KEY `mevkiler` (`mevki_id`) USING BTREE,
  KEY `ikincil_mevki` (`ikincil_mevki_id`) USING BTREE,
  CONSTRAINT `FK_oyuncular_forma_bedenler` FOREIGN KEY (`forma_beden_id`) REFERENCES `forma_bedenler` (`id`),
  CONSTRAINT `FK_oyuncular_mevkiler` FOREIGN KEY (`mevki_id`) REFERENCES `mevkiler` (`id`),
  CONSTRAINT `FK_oyuncular_mevkiler_2` FOREIGN KEY (`ikincil_mevki_id`) REFERENCES `mevkiler` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- futbolapp.oyuncular: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `oyuncular` DISABLE KEYS */;
REPLACE INTO `oyuncular` (`id`, `email`, `sifre`, `accessToken`, `ad`, `soyad`, `foto`, `dogum_gunu`, `forma_numarasi`, `mevki_id`, `ikincil_mevki_id`, `forma_beden_id`, `boy`, `kilo`, `ayakkabi_numarasi`, `ayak`) VALUES
	(1, 'mehmetnky@gmail.com', '$2y$10$PC6uK6gxSo3W3tY2gz23guV91crH96ohnj8iwHtMl46Dn5HXbufXW', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJhdWQiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJpYXQiOjE2MDQxNzgwMDAsIm5iZiI6MTYwNDE3ODAwMSwiZXhwIjoxNjA0Nzk2OTk2LCJkYXRhIjp7ImVtYWlsIjoibWVobWV0bmt5QGdtYWlsLmNvbSIsInNpZnJlIjoiMTIzIn19.Cct24ppWdyFzXA7KUn3JW88e9VfHB7hxE_hWFiGJL3w', 'Mehmet Can123', 'Nokay', 'pp.png', '1998-11-05', 25, 3, 4, 6, 181, 93, 43, 'Sağ'),
	(2, 'emre.sutuna1998@gmail.com', '$2y$10$GKgmUXipLiYuutRGkqID/uZaZmP.zr/LG4Ly.vnYufwQq33IDIfgC', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJhdWQiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJpYXQiOjE2MDI1MzY0MDAsIm5iZiI6MTYwMjUzNjQwMSwiZGF0YSI6eyJlbWFpbCI6ImVtcmUuc3V0dW5hMTk5OEBnbWFpbC5jb20iLCJzaWZyZSI6IjEyMzQifX0.rLdff4EVhCT6NNsTlDpVrD_oQlDIoTsLTJxrqq3p2To', 'Emre1234', 'Şutuna', 'pp.png', '1998-04-21', 7, 5, 2, 4, 174, 68, 42, 'Sol'),
	(3, 'tameryuksel@gmail.com', '$2y$10$xkBlWzE/lAcCnhqwFwN90OjGwM.Za8/1wDGMLb2Bx8nxf7GFY.u/2', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJhdWQiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJpYXQiOjE2MDI1MzY0MDAsIm5iZiI6MTYwMjUzNjQwMSwiZGF0YSI6eyJlbWFpbCI6InRhbWVyeXVrc2VsQGdtYWlsLmNvbSIsInNpZnJlIjoiMTIzNDUifX0.qVqDcNdpQtXFHjUf1L03v572ff9nXEyHdKu5eE5lQ2M', 'Tamer12345', 'Yüksel', 'pp.png', '1998-06-11', 5, 2, 7, 6, 187, 103, 47, 'Çift'),
	(34, 'test@test.com', '$2y$10$DA2rbuXU4mgayyZCNgqJXO/Y5WIR4rdPtnJjxiU3GsrByvabrxo92', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJhdWQiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJpYXQiOjE2MDI1MzY0MDAsIm5iZiI6MTYwMjUzNjQwMSwiZGF0YSI6eyJlbWFpbCI6InRlc3RAdGVzdC5jb20iLCJzaWZyZSI6IiQyeSQxMCREQTJyYnVYVTRtZ2F5eVpDTmdxSlhPXC9ZNVdJUjRyZFB0bkpqeGlVM0dzckJ5dmFicnhvOTIifX0.baRr9r-T4s4Sbk-d-tW3PS9vJo3-n_wwQvQMc-V78Xs', 'Testa', 'Oyuncu', 'asd.png', '1996-11-06', 10, 1, NULL, 2, 172, 63, 41, 'Sağ'),
	(35, 'test2@test.com', '$2y$10$Mz8sKCY.DfxYidE3UBdlHOQA57jx3h/5cZERgjE5hTlZjel4pHFSq', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJhdWQiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAiLCJpYXQiOjE2MDI1MzY0MDAsIm5iZiI6MTYwMjUzNjQwMSwiZXhwIjoxNjAzMjE3NjQ4LCJkYXRhIjp7ImVtYWlsIjoidGVzdDJAdGVzdC5jb20iLCJzaWZyZSI6IiQyeSQxMCRNejhzS0NZLkRmeFlpZEUzVUJkbEhPUUE1N2p4M2hcLzVjWkVSZ2pFNWhUbFpqZWw0cEhGU3EifX0.w2rIRrddglxh3cIaQCchVh-wJ7xwN8UTLAqrm3tSmUI', 'Test2', 'Oyuncu2', 'asd.png', '1995-12-09', 12, 2, NULL, 1, 169, 59, 42, 'Sol');
/*!40000 ALTER TABLE `oyuncular` ENABLE KEYS */;

-- tablo yapısı dökülüyor futbolapp.takimlar
CREATE TABLE IF NOT EXISTS `takimlar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad` varchar(128) NOT NULL DEFAULT '0',
  `kurucu_oyuncu_id` int(11) NOT NULL DEFAULT 0,
  `arma` varchar(256) NOT NULL DEFAULT 'arma.png',
  `kurulus_tarihi` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`id`),
  KEY `FK_takimlar_oyuncular` (`kurucu_oyuncu_id`),
  CONSTRAINT `FK_takimlar_oyuncular` FOREIGN KEY (`kurucu_oyuncu_id`) REFERENCES `oyuncular` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- futbolapp.takimlar: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `takimlar` DISABLE KEYS */;
REPLACE INTO `takimlar` (`id`, `ad`, `kurucu_oyuncu_id`, `arma`, `kurulus_tarihi`) VALUES
	(1, 'MemuşOğlanlar SK', 1, 'arma.png', '2020-09-20'),
	(2, 'Test', 2, 'arma.png', '2020-10-12');
/*!40000 ALTER TABLE `takimlar` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
