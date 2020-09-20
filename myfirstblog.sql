-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 20, 2020 at 02:44 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `myfirstblog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `srNo` int(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `msg` varchar(100) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`srNo`, `name`, `phone`, `msg`, `date`, `email`) VALUES
(1, 'first post', '9820456789', 'first post', '2020-09-10 20:39:57', 'firsrt_post@gmail.com'),
(2, 'Mehboob Shaikh', '9820456865', 'ksadjisaidwjasnd', '2020-09-11 14:15:02', 'mehboob123@gmail.com'),
(3, 'Salman', '654477342', 'hey buddy how are you', '2020-09-11 14:16:26', 'salman451@gmail.com'),
(4, 'Mehboob', '9820456890', 'hi', '2020-09-11 18:10:32', 'mehboob675@gmail.com'),
(5, 'kaleem', '8765439865', 'hi mehboob bhai', '2020-09-12 15:45:23', 'kaleem123@gmail.com'),
(6, 'kaleem', '8765439865', 'hi mehboob bhai', '2020-09-12 15:46:49', 'kaleem123@gmail.com'),
(7, 'kaleem', '8765439865', 'hi mehboob bhai', '2020-09-12 16:01:00', 'kaleem123@gmail.com'),
(8, 'kaleem', '8765439865', 'hi mehboob bhai', '2020-09-12 16:08:13', 'kaleem123@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `srNo` int(20) NOT NULL,
  `title` varchar(70) NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` mediumtext NOT NULL,
  `img_file` varchar(20) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`srNo`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'This is my First Post And Practice', 'This is my First Post', 'first-post', 'this is my ', 'about-bg.jpg', '2020-09-17 19:23:48'),
(2, 'This is My Second Post', 'This is today news about Apple Company', 'second-post', 'Apple is expected to spotlight its smartwatch, iPad, and subscription services on Tuesday as it strives to reignite growth with a must-have holiday lineup.\r\n\r\nA keenly anticipated 5G iPhone considered', '', '2020-09-13 16:31:57'),
(3, 'this is my third post', 'This News About Kangna Ranawat', 'third-post', 'Bollywood actor Kangana Ranaut on Sunday reached Raj Bhavan in Mumbai to meet Maharashtra Governor Bhagat Singh Koshyari amid a row over the demolition of her office in the city by the Brihanmumbai Municipal Corporation (BMC).\r\n\r\nRanaut’s meeting comes in the backdrop of her tiff with the Shiv Sena over her comments on Mumbai’s tackling of the Sushant Singh Rajput death case.\r\n\r\nRanaut is likely to apprise Koshyari of the situation before leaving for her hometown of Manali in Himachal Pradesh on September 14.\r\n\r\n', '', '2020-09-13 17:05:29'),
(4, 'This is My fourth post', 'This News About Nepotism', 'fourth-post', 'Bollywood actor Kangana Ranaut on Sunday reached Raj Bhavan in Mumbai to meet Maharashtra Governor Bhagat Singh Koshyari amid a row over the demolition of her office in the city by the Brihanmumbai Municipal Corporation (BMC).\r\n\r\nRanaut’s meeting comes in the backdrop of her tiff with the Shiv Sena over her comments on Mumbai’s tackling of the Sushant Singh Rajput death case.\r\n\r\nRanaut is likely to apprise Koshyari of the situation before leaving for her hometown of Manali in Himachal Pradesh on September 14.\r\n\r\n', '', '2020-09-13 17:07:46'),
(5, 'This is my fifth post', 'this news about to china and russia', 'fifth-post', 'In a rare media interaction, the chief of Britain’s Defence Intelligence (DI) on Sunday identified China and Russia as key adversaries challenging the existing world order without promoting direct conflict, and operating in the expanding grey zone between war and peacetime.\r\n\r\nLt Gen Jim Hockenhull said the United Kingdom’s adversaries are developing new ways of operating, backed up by cutting-edge military capabilities that leverage advanced technologies such as artificial intelligence and machine learning.\r\n\r\nIn the first-ever media briefing at DI’s base in Cambridgeshire, he said the shifting global picture has changed the character of warfare in ways that will challenge the West to keep pace with adversaries who do not play by the rules.\r\n\r\n', '', '2020-09-13 17:09:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`srNo`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`srNo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `srNo` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `srNo` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
