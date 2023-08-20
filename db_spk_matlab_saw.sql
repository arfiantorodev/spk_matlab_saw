-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 26, 2014 at 10:17 PM
-- Server version: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sawkredit`
--

-- --------------------------------------------------------

--
-- Table structure for table `alternatif`
--

CREATE TABLE IF NOT EXISTS `alternatif` (
  `Id_Kriteria` varchar(5) NOT NULL,
  `UangMuka` int(13) NOT NULL,
  `Angsuran` int(5) NOT NULL,
  `Pekerjaan` int(13) NOT NULL,
  `LamaBekerja` int(13) NOT NULL,
  `Gaji` int(13) NOT NULL,
  `Pendidikan` int(4) NOT NULL,
  `StatusRumah` int(5) NOT NULL,
  PRIMARY KEY (`Id_Kriteria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `alternatif`
--

INSERT INTO `alternatif` (`Id_Kriteria`, `UangMuka`, `Angsuran`, `Pekerjaan`, `LamaBekerja`, `Gaji`, `Pendidikan`, `StatusRumah`) VALUES
('A1', 1000000, 34, 2, 3, 2500000, 1, 2),
('A2', 2250000, 24, 1, 10, 4000000, 3, 3),
('A3', 1000000, 32, 1, 10, 2000000, 2, 2),
('A4', 3000000, 36, 1, 5, 3500000, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pemohon`
--

CREATE TABLE IF NOT EXISTS `pemohon` (
  `Id_Kriteria` varchar(4) NOT NULL,
  `Nama_Pemohon` varchar(35) NOT NULL,
  `Usia` int(3) NOT NULL,
  `Telepon` varchar(15) NOT NULL,
  `JenisKelamin` varchar(15) NOT NULL,
  PRIMARY KEY (`Id_Kriteria`),
  UNIQUE KEY `Telepon` (`Telepon`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pemohon`
--

INSERT INTO `pemohon` (`Id_Kriteria`, `Nama_Pemohon`, `Usia`, `Telepon`, `JenisKelamin`) VALUES
('A1', 'DICKY ZAENAL LUTFI', 27, '085973937825', 'Laki-Laki'),
('A2', 'DOMU SIMBOLON', 48, '081362918124', 'Laki-Laki'),
('A3', 'NITA JEHAN', 35, '085269410353', 'Perempuan'),
('A4', 'ROBIN', 36, '082147587005', 'Laki-Laki');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
