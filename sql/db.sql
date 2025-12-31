-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 31, 2025 at 07:03 PM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `expenses_db`
--
CREATE DATABASE IF NOT EXISTS `expenses_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `expenses_db`;

-- --------------------------------------------------------

--
-- Table structure for table `credits`
--

CREATE TABLE `credits` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `credits`
--

INSERT INTO `credits` (`id`, `user_id`, `description`, `amount`, `created_at`) VALUES
(1, 1, 'Lavanya Salary', '42000.00', '2025-10-03 11:27:29'),
(2, 1, 'Kittu Salary', '20000.00', '2025-10-03 11:29:04');

-- --------------------------------------------------------

--
-- Table structure for table `debits`
--

CREATE TABLE `debits` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `cleared` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `debits`
--

INSERT INTO `debits` (`id`, `user_id`, `description`, `amount`, `cleared`, `created_at`) VALUES
(1, 1, 'Srinu Card Bill', '20000.00', 0, '2025-10-03 11:31:21');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'hvskrishnakanth', '$2y$10$gHIQqFFxpMHGsGfLLykVXeJsFVwtShxm6q6K95LfILEcD4OsdO3uC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `credits`
--
ALTER TABLE `credits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `debits`
--
ALTER TABLE `debits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `credits`
--
ALTER TABLE `credits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `debits`
--
ALTER TABLE `debits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `credits`
--
ALTER TABLE `credits`
  ADD CONSTRAINT `credits_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `debits`
--
ALTER TABLE `debits`
  ADD CONSTRAINT `debits_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `expense_dashboard`
--
CREATE DATABASE IF NOT EXISTS `expense_dashboard` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `expense_dashboard`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Food'),
(2, 'Travel'),
(3, 'Bills'),
(4, 'Shopping');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expense_date` date NOT NULL,
  `expense_for` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `necessity_rating` tinyint(4) NOT NULL,
  `reason` mediumtext COLLATE utf8mb4_unicode_ci,
  `payment_type` enum('cash','online') COLLATE utf8mb4_unicode_ci NOT NULL,
  `cash_amount` decimal(10,2) DEFAULT '0.00',
  `online_app` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `user_id`, `expense_date`, `expense_for`, `amount`, `necessity_rating`, `reason`, `payment_type`, `cash_amount`, `online_app`, `created_at`) VALUES
(1, 1, '2025-12-31', 'Test', '1222.00', 1, 'Test spent', 'online', '0.00', 'Google Pay', '2025-12-31 15:08:48');

-- --------------------------------------------------------

--
-- Table structure for table `goals`
--

CREATE TABLE `goals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `goal_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goal_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goal_for` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goal_desc` mediumtext COLLATE utf8mb4_unicode_ci,
  `icon` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `occasion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `goals`
--

INSERT INTO `goals` (`id`, `user_id`, `goal_name`, `goal_type`, `goal_for`, `goal_desc`, `icon`, `amount`, `occasion`, `target_date`, `created_at`) VALUES
(1, 1, 'Car', 'Short Term', 'Just saving', 'Just saving', '💻', '10000.00', 'No', '2026-01-30', '2025-12-31 16:14:25');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `loan_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lender_type` enum('bank','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `lender_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `principal` decimal(10,2) NOT NULL,
  `interest_rate` decimal(5,2) DEFAULT NULL,
  `tenure_months` int(11) DEFAULT NULL,
  `emi` decimal(10,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `paid_months` int(11) DEFAULT '0',
  `status` enum('active','closed') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`id`, `user_id`, `loan_name`, `lender_type`, `lender_name`, `principal`, `interest_rate`, `tenure_months`, `emi`, `start_date`, `paid_months`, `status`, `created_at`) VALUES
(1, 1, 'House Loan', 'bank', 'LIC HFL', '220000.00', '9.05', 40, '0.00', '2025-12-31', 0, 'active', '2025-12-31 17:01:33');

-- --------------------------------------------------------

--
-- Table structure for table `monthly_limits`
--

CREATE TABLE `monthly_limits` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `month_year` char(7) NOT NULL,
  `limit_amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `monthly_limits`
--

INSERT INTO `monthly_limits` (`id`, `user_id`, `month_year`, `limit_amount`, `created_at`) VALUES
(1, 1, '2025-12', '100000.00', '2025-12-31 15:29:40');

-- --------------------------------------------------------

--
-- Table structure for table `savings`
--

CREATE TABLE `savings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `month_year` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `income` decimal(10,2) NOT NULL,
  `saved_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings`
--

INSERT INTO `savings` (`id`, `user_id`, `month_year`, `income`, `saved_amount`, `note`, `created_at`) VALUES
(1, 1, '2025-12', '25000.00', '3000.00', '', '2025-12-31 16:21:27');

-- --------------------------------------------------------

--
-- Table structure for table `saving_allocations`
--

CREATE TABLE `saving_allocations` (
  `id` int(11) NOT NULL,
  `saving_id` int(11) DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monthly_income` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `gender`, `password`, `monthly_income`) VALUES
(1, 'admin', '', 'admin@example.com', NULL, NULL, '$2y$10$8phCmFs9CmE9MgvSX6HwkekqzXUadj5zR3/lAHHgcfDGiS2j9AyQO', '100000.00'),
(2, 'hvskrishnakanth', 'H V S Krishna Kanth', 'krishna@example.com', NULL, NULL, '$2y$10$8phCmFs9CmE9MgvSX6HwkekqzXUadj5zR3/lAHHgcfDGiS2j9AyQO', '75000.00'),
(3, NULL, '', 'user1@example.com', NULL, NULL, '$2y$10$8phCmFs9CmE9MgvSX6HwkekqzXUadj5zR3/lAHHgcfDGiS2j9AyQO', '50000.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `goals`
--
ALTER TABLE `goals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `monthly_limits`
--
ALTER TABLE `monthly_limits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_user_month` (`user_id`,`month_year`);

--
-- Indexes for table `savings`
--
ALTER TABLE `savings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`month_year`);

--
-- Indexes for table `saving_allocations`
--
ALTER TABLE `saving_allocations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `saving_id` (`saving_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `goals`
--
ALTER TABLE `goals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `monthly_limits`
--
ALTER TABLE `monthly_limits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `savings`
--
ALTER TABLE `savings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `saving_allocations`
--
ALTER TABLE `saving_allocations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `saving_allocations`
--
ALTER TABLE `saving_allocations`
  ADD CONSTRAINT `saving_allocations_ibfk_1` FOREIGN KEY (`saving_id`) REFERENCES `savings` (`id`) ON DELETE CASCADE;
--
-- Database: `inventorymanagement`
--
CREATE DATABASE IF NOT EXISTS `inventorymanagement` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `inventorymanagement`;

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `adjustment_name` varchar(255) DEFAULT NULL,
  `adjustment_number` varchar(50) NOT NULL,
  `date_time` datetime NOT NULL,
  `item_id` varchar(50) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `old_quantity` int(11) DEFAULT NULL,
  `new_quantity` int(11) DEFAULT NULL,
  `adjust_quantity` int(11) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `total_cost` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_adjust_qty` decimal(10,2) DEFAULT '0.00',
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `adjustments`
--

INSERT INTO `adjustments` (`id`, `user_id`, `adjustment_name`, `adjustment_number`, `date_time`, `item_id`, `item_name`, `old_quantity`, `new_quantity`, `adjust_quantity`, `cost`, `total_cost`, `created_at`, `total_adjust_qty`, `updated_at`) VALUES
(1, 1, 'Test', '1', '2025-05-07 17:16:00', '364393000046650231', 'Finished', 6, 10, 4, '700.00', '2800.00', '2025-05-07 06:19:32', '0.00', NULL),
(2, 1, '', '2', '2025-05-07 17:22:00', '364393000046650231', 'Finished', 10, 20, 10, '700.00', '7000.00', '2025-05-07 06:22:11', '0.00', NULL),
(3, 1, '', '3', '2025-05-07 17:23:00', '364393000046650231', 'Finished', 30, 40, 10, '700.00', '7000.00', '2025-05-07 06:23:24', '0.00', NULL),
(4, 1, '', '4', '2025-05-07 17:24:00', '364393000046638449', 'Raw1', 4, 16, 12, '70.00', '840.00', '2025-05-07 06:24:54', '0.00', NULL),
(5, 1, '', '5', '2025-05-07 17:31:00', '364393000046650231', 'Finished', 50, 61, 11, '700.00', '7700.00', '2025-05-07 06:31:52', '0.00', NULL),
(6, 1, '', '6', '2025-05-07 17:32:00', '364393000046638449', 'Raw1', 28, 1, -27, '70.00', '-1890.00', '2025-05-07 06:32:40', '0.00', NULL),
(7, 1, '', '7', '2025-05-07 18:22:00', '364393000046650231', 'Finished', 6, 20, 14, '700.00', '9800.00', '2025-05-07 07:22:53', '0.00', NULL),
(8, 1, '', '8', '2025-05-07 18:24:00', '364393000046650231', 'Finished', 20, 16, -4, '700.00', '-2800.00', '2025-05-07 07:24:18', '0.00', NULL),
(9, 1, 'New Price Testing', '9', '2025-05-08 11:40:00', '364393000046650231', 'Finished', 31, 40, 9, '700.00', '6300.00', '2025-05-08 00:41:23', '0.00', NULL),
(10, 1, 'New Price Testing', '9', '2025-05-08 11:40:00', '364393000046638449', 'Raw1', -146, 100, 246, '70.00', '17220.00', '2025-05-08 00:41:23', '0.00', NULL),
(11, 1, 'New Price Testing', '9', '2025-05-08 11:40:00', '364393000046638510', 'Raw2', -296, 100, 396, '80.00', '31680.00', '2025-05-08 00:41:23', '0.00', NULL),
(12, 1, '', '10', '2025-05-08 12:32:00', '364393000046650231', 'Finished', 4, 200, 196, '800.00', '156800.00', '2025-05-08 01:32:34', '0.00', NULL),
(13, 1, '', '11', '2025-05-14 15:42:00', '364393000046650231', 'Finished', 17, 10, -7, '800.00', '-5600.00', '2025-05-14 04:43:35', '0.00', NULL),
(14, 1, '', '11', '2025-05-14 15:42:00', '364393000046638449', 'Raw1', -18, 58, 76, '70.00', '5320.00', '2025-05-14 04:43:35', '0.00', NULL),
(15, 1, '', '11', '2025-05-14 15:42:00', '364393000046638510', 'Raw2', -37, 57, 94, '80.00', '7520.00', '2025-05-14 04:43:35', '0.00', NULL),
(16, 1, '', '12', '2025-05-19 15:34:00', '364393000046650231', 'Finished', 12, 50, 38, '800.00', '30400.00', '2025-05-19 04:35:39', '0.00', '2025-05-19 10:13:47'),
(17, 1, '', '12', '2025-05-19 15:34:00', '364393000046638449', 'Raw1', 38, 50, 12, '70.00', '840.00', '2025-05-19 04:35:39', '0.00', '2025-05-19 10:13:49'),
(18, 1, '', '12', '2025-05-19 15:34:00', '364393000046638510', 'Raw2', 42, 50, 8, '80.00', '640.00', '2025-05-19 04:35:39', '0.00', '2025-05-19 10:13:51'),
(19, 1, '', '13', '2025-05-19 15:44:00', '364393000045713031', 'salt test', 0, 16, 16, '0.00', '0.00', '2025-05-19 04:44:34', '0.00', '2025-05-19 10:14:55');

-- --------------------------------------------------------

--
-- Table structure for table `adjustment_items`
--

CREATE TABLE `adjustment_items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `old_quantity` decimal(10,2) NOT NULL,
  `new_quantity` decimal(10,2) NOT NULL,
  `adjust_quantity` decimal(10,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `total_cost` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `batch_total`
--

CREATE TABLE `batch_total` (
  `id` int(11) NOT NULL,
  `item_id` varchar(50) NOT NULL,
  `batch_item_name` varchar(100) NOT NULL,
  `batch_total_quantity` float NOT NULL,
  `batch_total` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `batch_total`
--

INSERT INTO `batch_total` (`id`, `item_id`, `batch_item_name`, `batch_total_quantity`, `batch_total`, `created_at`, `modified_at`) VALUES
(1, '364393000045713031', 'Raw1', 12, 940, '2025-05-23 07:39:10', '2025-05-23 07:39:10'),
(2, '364393000001022004', 'Raw1', 123, 8730, '2025-05-23 10:29:48', '2025-05-23 10:29:48'),
(3, '364393000000975452', 'Raw1', 23, 1730, '2025-05-23 10:36:16', '2025-05-23 10:36:16'),
(4, '364393000046944070', 'Testing item', 2, 150, '2025-05-23 10:40:45', '2025-05-23 10:40:45'),
(5, '364393000000906511', 'BAGS Zeoweight', 246.1, 30757000, '2025-05-23 10:41:50', '2025-06-07 06:11:24'),
(6, '364393000047708239', 'Batch L Algacure', 42, 2005, '2025-05-23 10:48:10', '2025-05-26 04:33:40'),
(7, '364393000046388556', 'BATCH P Growmin BW Plus', 600, 2475, '2025-05-26 06:14:33', '2025-05-26 06:14:33'),
(8, '364393000047524298', 'Argocure 500 ml', 3.2, 50100, '2025-07-03 06:21:07', '2025-07-03 06:21:20');

-- --------------------------------------------------------

--
-- Table structure for table `bill_items`
--

CREATE TABLE `bill_items` (
  `id` int(11) NOT NULL,
  `bill_id` varchar(255) DEFAULT NULL,
  `bill_number` varchar(255) DEFAULT NULL,
  `item_id` varchar(255) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bill_items`
--

INSERT INTO `bill_items` (`id`, `bill_id`, `bill_number`, `item_id`, `item_name`, `rate`, `created_at`, `updated_at`) VALUES
(1, '364393000047268546', 'APR-2025', '', '', '167000.00', '2025-05-02 11:46:53', '2025-05-02 11:46:59'),
(2, '364393000047268434', 'MD-APR-25-04', '', '', '17338.00', '2025-05-02 09:47:30', '2025-05-02 09:47:41'),
(3, '364393000047268184', 'BZA/25-26/0120', '', '', '55143.00', '2025-05-02 07:01:11', '2025-05-05 07:16:37'),
(4, '364393000047280613', 'ASC/25-26/19', '364393000045975920', 'RPX Quartz Powder', '4.30', '2025-05-02 05:52:42', '2025-05-02 05:55:11'),
(5, '364393000047280536', '91', '364393000045992148', 'CNTR Pouch Inner Printed 10kg (Running Logo)', '240.00', '2025-05-02 05:49:37', '2025-05-02 05:55:56'),
(6, '364393000047280536', '91', '364393000045993270', 'CNTR Pouches 10kg (inner cover)', '165.00', '2025-05-02 05:49:37', '2025-05-02 05:55:56'),
(7, '364393000047280536', '91', '364393000045993321', 'CNTR Pouches 1KG Size (INNER COVER) 0.0166Kg Ea', '165.00', '2025-05-02 05:49:37', '2025-05-02 05:55:56'),
(8, '364393000047280536', '91', '364393000047280473', 'CNTR Pouches 5kg Plain', '165.00', '2025-05-02 05:49:37', '2025-05-02 05:55:56'),
(9, '364393000047280418', '2025-26/0067', '364393000045976787', 'RPX Sulphuric Acid', '18.00', '2025-05-02 05:34:39', '2025-05-02 05:56:27'),
(10, '364393000047280418', '2025-26/0067', '364393000045969533', 'RPX  Acetic Acid Glacial', '62.00', '2025-05-02 05:34:39', '2025-05-02 05:56:27'),
(11, '364393000047280268', '034', '364393000045969737', 'RPX Aamylase', '300.00', '2025-05-02 05:24:43', '2025-05-02 05:56:53'),
(12, '364393000047280268', '034', '364393000045974492', 'RPX Lipase', '265.00', '2025-05-02 05:24:43', '2025-05-02 05:56:53'),
(13, '364393000047280268', '034', '364393000045974849', 'RPX Mannanase', '230.00', '2025-05-02 05:24:43', '2025-05-02 05:56:53'),
(14, '364393000047280268', '034', '364393000045975563', 'RPX Phytase', '120.00', '2025-05-02 05:24:43', '2025-05-02 05:56:53'),
(15, '364393000047280268', '034', '364393000045973625', 'RPX Galzym XT', '600.00', '2025-05-02 05:24:43', '2025-05-02 05:56:53'),
(16, '364393000047280268', '034', '364393000047280207', 'RPX PROTEASE', '700.00', '2025-05-02 05:24:43', '2025-05-02 05:56:53'),
(17, '364393000047280140', 'ESSP/25-26/106', '364393000045989637', 'CNTR Buckets 10KG', '80.00', '2025-05-02 05:15:07', '2025-05-02 05:58:01'),
(18, '364393000047280140', 'ESSP/25-26/106', '364393000045989688', 'CNTR Buckets 20KG', '165.00', '2025-05-02 05:15:07', '2025-05-02 05:58:01'),
(19, '364393000047280085', 'TV/048/25-26', '364393000045972299', 'RPX CFU Sodium Chloride', '79.00', '2025-05-02 05:08:06', '2025-05-02 05:58:52'),
(20, '364393000047280040', 'INV/3653/2025-26', '', '', '225.00', '2025-05-02 05:04:45', '2025-05-02 07:01:51'),
(21, '364393000047210073', '1025260044787', '', '', '2521.65', '2025-04-30 10:11:15', '2025-04-30 10:11:57'),
(22, '364393000047125579', '55', '', '', '12240.00', '2025-04-29 10:55:33', '2025-04-29 11:08:42'),
(23, '364393000047125550', '54', '', '', '12000.00', '2025-04-29 10:54:52', '2025-04-29 11:08:42'),
(24, '364393000047125456', '53', '', '', '12660.00', '2025-04-29 10:41:13', '2025-04-29 11:08:02'),
(25, '364393000047125427', '52', '', '', '12000.00', '2025-04-29 10:40:44', '2025-04-29 11:08:02'),
(26, '364393000047125398', '51', '', '', '12240.00', '2025-04-29 10:39:39', '2025-04-29 11:08:02'),
(27, '364393000047125359', '50', '', '', '7590.00', '2025-04-29 10:34:43', '2025-04-29 11:08:42'),
(28, '364393000047125091', '360', '', '', '80999.00', '2025-04-29 10:16:52', '2025-04-30 05:22:13'),
(29, '364393000047109030', '9488005664', '', '', '1410.00', '2025-04-29 04:08:47', '2025-04-29 04:40:57'),
(30, '364393000047103309', 'C37E242500080604', '', '', '5635.68', '2025-04-28 10:10:13', '2025-04-28 10:24:01'),
(31, '364393000047103221', 'MAR-2025', '', '', '167000.00', '2025-04-28 09:31:06', '2025-04-28 09:31:14'),
(32, '364393000047099848', '24-25/VW-0583', '364393000045988668', 'CNTR ODOSWEEP LIDS', '3.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(33, '364393000047099848', '24-25/VW-0583', '364393000045995514', 'CNTR Papper Bags', '8.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(34, '364393000047099848', '24-25/VW-0583', '364393000045995208', 'CNTR Plane Square Bucket 5kg', '24.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(35, '364393000047099848', '24-25/VW-0583', '364393000045991740', 'CNTR Pouch Chillzinc (Glassy) 1kg', '200.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(36, '364393000047099848', '24-25/VW-0583', '364393000045991842', 'CNTR Pouch Flourish Min 1KG', '8.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(37, '364393000047099848', '24-25/VW-0583', '364393000045988821', 'CNTR Pouch Flourshmin 10KG (GLASSY)', '200.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(38, '364393000047099848', '24-25/VW-0583', '364393000045988872', 'CNTR Pouch Growmin 10KG (GLASSY)', '200.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(39, '364393000047099848', '24-25/VW-0583', '364393000045992148', 'CNTR Pouch Inner Printed 10kg (Running Logo)', '180.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(40, '364393000047099848', '24-25/VW-0583', '364393000045992199', 'CNTR Pouch Inner Printed 1kg (Running Logo)', '180.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(41, '364393000047099848', '24-25/VW-0583', '364393000045994800', 'CNTR Pouch Inner Printed Big size', '180.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(42, '364393000047099848', '24-25/VW-0583', '364393000045992352', 'CNTR Pouch Livertreat XL (Glaasy) 2kg', '200.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(43, '364393000047099848', '24-25/VW-0583', '364393000045992454', 'CNTR Pouch Oxybreeze (Glassy) 1kg', '200.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(44, '364393000047099848', '24-25/VW-0583', '364393000045992556', 'CNTR Pouch Planktolyze 10KG (GLASSY)', '200.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(45, '364393000047099848', '24-25/VW-0583', '364393000045992658', 'CNTR Pouch Profish BW 10kg', '200.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(46, '364393000047099848', '24-25/VW-0583', '364393000045988923', 'CNTR Pouch Profish BW 1KG', '8.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(47, '364393000047099848', '24-25/VW-0583', '364393000045996024', 'CNTR Pouch Silver 1kg Printed (ZIPPER)', '190.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(48, '364393000047099848', '24-25/VW-0583', '364393000045992760', 'CNTR Pouch Silver Printed 10kg (Running Logo)', '190.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(49, '364393000047099848', '24-25/VW-0583', '364393000045992811', 'CNTR Pouch Silver Printed 1kg (Running Logo)', '190.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(50, '364393000047099848', '24-25/VW-0583', '364393000045992862', 'CNTR Pouch Silver Printed 5kg (Running Logo)', '190.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(51, '364393000047099848', '24-25/VW-0583', '364393000045995463', 'CNTR Pouch Silver Zipper 500GMS', '190.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(52, '364393000047099848', '24-25/VW-0583', '364393000045996177', 'CNTR POUCH SMART GRO 9 5KG', '18.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(53, '364393000047099848', '24-25/VW-0583', '364393000045995004', 'CNTR Pouch Zeoweight 10kg', '17.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(54, '364393000047099848', '24-25/VW-0583', '364393000045993117', 'CNTR Pouches (Blue)', '120.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(55, '364393000047099848', '24-25/VW-0583', '364393000045993168', 'CNTR Pouches (Green)', '120.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(56, '364393000047099848', '24-25/VW-0583', '364393000045993321', 'CNTR Pouches 1KG Size (INNER COVER) 0.0166Kg Ea', '170.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(57, '364393000047099848', '24-25/VW-0583', '364393000045993372', 'CNTR Pouches 500GM/1KG (Silver)', '170.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(58, '364393000047099848', '24-25/VW-0583', '364393000045993423', 'CNTR Pouches 5KG (Silver)', '150.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(59, '364393000047099848', '24-25/VW-0583', '364393000045993474', 'CNTR Pouches Silver 10KG', '150.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(60, '364393000047099848', '24-25/VW-0583', '364393000045993525', 'CNTR Printed Rolls', '140.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(61, '364393000047099848', '24-25/VW-0583', '364393000045988974', 'CNTR Product Quantity Bags', '14.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(62, '364393000047099848', '24-25/VW-0583', '364393000045993627', 'CNTR Rolls C 1KG', '140.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(63, '364393000047099848', '24-25/VW-0583', '364393000045993678', 'CNTR Rolls D 1KG', '140.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(64, '364393000047099848', '24-25/VW-0583', '364393000045993729', 'CNTR Rolls P 1KG', '140.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(65, '364393000047099848', '24-25/VW-0583', '364393000045993780', 'CNTR Rolls R 1KG', '140.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(66, '364393000047099848', '24-25/VW-0583', '364393000045996126', 'CNTR Scoops Small', '2.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(67, '364393000047099848', '24-25/VW-0583', '364393000045993984', 'CNTR SHINKS 1/2 KG', '1.50', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(68, '364393000047099848', '24-25/VW-0583', '364393000045994035', 'CNTR SHINKS 1/2 LT', '1.50', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(69, '364393000047099848', '24-25/VW-0583', '364393000045994086', 'CNTR SHINKS 100ML', '1.20', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(70, '364393000047099848', '24-25/VW-0583', '364393000045994137', 'CNTR SHINKS 1KG', '2.50', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(71, '364393000047099848', '24-25/VW-0583', '364393000045994188', 'CNTR SHINKS 1LT', '2.50', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(72, '364393000047099848', '24-25/VW-0583', '364393000045994239', 'CNTR SHINKS 500ML', '0.90', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(73, '364393000047099848', '24-25/VW-0583', '364393000045994290', 'CNTR SHINKS 500ML (IMD)', '0.90', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(74, '364393000047099848', '24-25/VW-0583', '364393000045994341', 'CNTR SHINKS 5LT', '2.50', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(75, '364393000047099848', '24-25/VW-0583', '364393000045995565', 'CNTR Silver  Printed Zipper 5kg', '190.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(76, '364393000047099848', '24-25/VW-0583', '364393000045995157', 'CNTR Square 1LT', '12.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(77, '364393000047099848', '24-25/VW-0583', '364393000045995259', 'CNTR Square 500ml', '6.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(78, '364393000047099848', '24-25/VW-0583', '364393000045989025', 'CNTR STD Can (Black)', '30.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(79, '364393000047099848', '24-25/VW-0583', '364393000045989076', 'CNTR STD Can (White)', '30.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(80, '364393000047099848', '24-25/VW-0583', '364393000045994545', 'CNTR VITC-S Bottle (White)', '11.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(81, '364393000047099848', '24-25/VW-0583', '364393000045989127', 'CNTR VITC-S Bottle (Yellow)', '11.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(82, '364393000047099848', '24-25/VW-0583', '364393000045995412', 'CNTR White CB 5KG Square', '35.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(83, '364393000047099848', '24-25/VW-0583', '364393000045994647', 'CNTR Zeoweight Pouch 25KG', '15.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(84, '364393000047099848', '24-25/VW-0583', '364393000045995106', 'CNTR Zipper Inner Printed 5kg', '195.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(85, '364393000047099848', '24-25/VW-0583', '364393000045994902', 'CNTR Zipper Printed cover 10kg', '195.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(86, '364393000047099848', '24-25/VW-0583', '364393000045992250', 'CNTR Pouch Inner Printed 500gm (Running Logo)', '180.00', '2025-04-28 06:53:06', '2025-04-28 07:48:39'),
(87, '364393000047004433', '123456', '364393000046650231', 'Finished', '800.00', '2025-04-26 11:28:00', '2025-04-29 05:15:21'),
(88, '364393000047004433', '123456', '364393000046638449', 'Raw1', '70.00', '2025-04-26 11:28:00', '2025-04-29 05:15:21'),
(89, '364393000047004433', '123456', '364393000046638510', 'Raw2', '80.00', '2025-04-26 11:28:00', '2025-04-29 05:15:21'),
(90, '364393000046990790', '24-25/VW-0582', '364393000045989280', 'CNTR  Cans 30LT', '200.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(91, '364393000046990790', '24-25/VW-0582', '364393000046990668', 'CNTR CYL Bottle 500ML', '10.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(92, '364393000046990790', '24-25/VW-0582', '364393000046990729', 'CNTR Plain Rolls', '140.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(93, '364393000046990790', '24-25/VW-0582', '364393000045989433', 'CNTR 300ml Bottle', '8.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(94, '364393000046990790', '24-25/VW-0582', '364393000045995769', 'CNTR Bottle 2KG', '25.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(95, '364393000046990790', '24-25/VW-0582', '364393000045995718', 'CNTR Bottle 2LT', '25.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(96, '364393000046990790', '24-25/VW-0582', '364393000045989484', 'CNTR Bottles 100ml', '4.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(97, '364393000046990790', '24-25/VW-0582', '364393000045994953', 'CNTR BOX WHITE', '40.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(98, '364393000046990790', '24-25/VW-0582', '364393000045989535', 'CNTR Bspk 500GMS', '10.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(99, '364393000046990790', '24-25/VW-0582', '364393000045989637', 'CNTR Buckets 10KG', '65.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(100, '364393000046990790', '24-25/VW-0582', '364393000045989688', 'CNTR Buckets 20KG', '130.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(101, '364393000046990790', '24-25/VW-0582', '364393000045989790', 'CNTR CB Brown  Plane 5 LT', '40.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(102, '364393000046990790', '24-25/VW-0582', '364393000045988203', 'CNTR CB Brown Plane 1 LT', '35.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(103, '364393000046990790', '24-25/VW-0582', '364393000045989841', 'CNTR CB Brown Plane 500ML', '32.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(104, '364393000046990790', '24-25/VW-0582', '364393000045989892', 'CNTR CB DF', '6.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(105, '364393000046990790', '24-25/VW-0582', '364393000045988254', 'CNTR CB Milk can 5lt', '40.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(106, '364393000046990790', '24-25/VW-0582', '364393000045989943', 'CNTR CB Moldtek 500gms (48)', '50.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(107, '364393000046990790', '24-25/VW-0582', '364393000045989994', 'CNTR CB Moldtek/500GM', '46.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(108, '364393000046990790', '24-25/VW-0582', '364393000045988305', 'CNTR CB Moldtek/500GM (Brown)', '42.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(109, '364393000046990790', '24-25/VW-0582', '364393000045995616', 'CNTR CB White 10kg', '47.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(110, '364393000046990790', '24-25/VW-0582', '364393000045990198', 'CNTR CB White 1lt', '36.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(111, '364393000046990790', '24-25/VW-0582', '364393000045996075', 'CNTR CB White 2KG', '38.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(112, '364393000046990790', '24-25/VW-0582', '364393000045990300', 'CNTR CB White 5lt', '40.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(113, '364393000046990790', '24-25/VW-0582', '364393000045994851', 'Cntr Cyl Black 1LT', '14.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(114, '364393000046990790', '24-25/VW-0582', '364393000045990402', 'CNTR CYL Bottle (White)', '14.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(115, '364393000046990790', '24-25/VW-0582', '364393000045990657', 'CNTR HDPE MODEL 5LT', '25.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(116, '364393000046990790', '24-25/VW-0582', '364393000045990708', 'CNTR IMD Black 1 LT', '13.50', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(117, '364393000046990790', '24-25/VW-0582', '364393000045988356', 'CNTR IMD Black 500ml', '8.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(118, '364393000046990790', '24-25/VW-0582', '364393000045990810', 'CNTR IMD Bottle (White)', '13.50', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(119, '364393000046990790', '24-25/VW-0582', '364393000045996228', 'CNTR IMD YELLOW', '13.50', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(120, '364393000046990790', '24-25/VW-0582', '364393000045990861', 'CNTR JRY Can (Blue)', '130.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(121, '364393000046990790', '24-25/VW-0582', '364393000045991014', 'CNTR MILK CAN White - 5 LT', '28.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(122, '364393000046990790', '24-25/VW-0582', '364393000046990841', 'CNTR MOLD-TEK Common Bucket 5lt (Blue)', '28.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(123, '364393000046990790', '24-25/VW-0582', '364393000046990902', 'CNTR MOLD-TEK Common Bucket 5lt (white)', '28.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(124, '364393000046990790', '24-25/VW-0582', '364393000045991167', 'CNTR MOLD-TEK ABOLISH 500GMS', '11.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(125, '364393000046990790', '24-25/VW-0582', '364393000045991224', 'CNTR MOLD-TEK CITRIX 500GMS', '11.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(126, '364393000046990790', '24-25/VW-0582', '364393000000825079', 'CNTR MOLD-TEK BLUEGOLD GEL 17LT', '65.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(127, '364393000046990790', '24-25/VW-0582', '364393000045995973', 'CNTR MOLD-TEK Common Bucket 2KG', '18.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(128, '364393000046990790', '24-25/VW-0582', '364393000004678548', 'CNTR MOLD-TEK DOMINATOR -XL 20LT', '70.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(129, '364393000046990790', '24-25/VW-0582', '364393000005286679', 'CNTR MOLD-TEK DOMINATOR-XL 5LT (NEW)', '28.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(130, '364393000046990790', '24-25/VW-0582', '364393000045988566', 'CNTR MOLD-TEK ECOFRESH 10KG', '45.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(131, '364393000046990790', '24-25/VW-0582', '364393000045995820', 'CNTR MOLD-TEK Ecofresh 5KG', '29.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(132, '364393000046990790', '24-25/VW-0582', '364393000045991332', 'CNTR MOLD-TEK EVERFRESH PRO 500GM', '11.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(133, '364393000046990790', '24-25/VW-0582', '364393000045991383', 'CNTR MOLD-TEK ISOWEIGHT 500GMS', '11.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(134, '364393000046990790', '24-25/VW-0582', '364393000045988617', 'CNTR MOLD-TEK ODOSWEEP 500GMS', '11.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(135, '364393000046990790', '24-25/VW-0582', '364393000045995055', 'CNTR MOLD-TEK Plane White Round 1kg', '9.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(136, '364393000046990790', '24-25/VW-0582', '364393000045995361', 'CNTR MOLD-TEK Powerpac 500GMS', '11.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(137, '364393000046990790', '24-25/VW-0582', '364393000045995310', 'CNTR MOLD-TEK Powerpac 5kg', '25.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(138, '364393000046990790', '24-25/VW-0582', '364393000045994698', 'CNTR MOLD-TEK TWENTY-20 POWER PLUS 20LT', '70.00', '2025-04-26 09:11:27', '2025-04-26 11:02:38'),
(139, '364393000046956129', '9021285134', '', '', '2778.00', '2025-04-26 06:40:09', '2025-04-26 06:40:23'),
(140, '364393000046956069', '431', '', '', '36190.00', '2025-04-26 06:38:22', '2025-04-26 06:40:44'),
(141, '364393000046944166', '2025-26/CT45', '364393000045973778', 'RPX Glutaraldehyde', '320.00', '2025-04-26 04:23:08', '2025-04-26 04:24:11'),
(142, '364393000046944133', '10', '', '', '18644.07', '2025-04-26 04:17:37', '2025-04-26 04:20:53'),
(143, '364393000046945109', 'GST-12', '', '', '9030.00', '2025-04-25 11:26:17', '2025-04-25 11:27:56'),
(144, '364393000046968081', '24-25/VW-0581', '364393000045980159', 'RPX Manganese Chillated', '250.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(145, '364393000046968081', '24-25/VW-0581', '364393000045969788', 'RPX AB MOS', '175.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(146, '364393000046968081', '24-25/VW-0581', '364393000045970769', 'RPX CATB EM', '10.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(147, '364393000046968081', '24-25/VW-0581', '364393000045970871', 'RPX CATB IV', '22.50', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(148, '364393000046968081', '24-25/VW-0581', '364393000045970922', 'RPX CATB NEO', '2.45', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(149, '364393000046968081', '24-25/VW-0581', '364393000045972452', 'RPX CFU Yeast Extract', '425.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(150, '364393000046968081', '24-25/VW-0581', '364393000045980057', 'RPX Chromium Chillated', '95.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(151, '364393000046968081', '24-25/VW-0581', '364393000045980108', 'RPX Copper Sulphate Chillated', '325.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(152, '364393000046968081', '24-25/VW-0581', '364393000045977813', 'RPX Di-Calcium Phospate DCP', '35.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(153, '364393000046968081', '24-25/VW-0581', '364393000045974543', 'RPX Liquid Yucca', '600.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(154, '364393000046968081', '24-25/VW-0581', '364393000045978680', 'RPX MOLASSES-40 FLAVOUR', '260.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(155, '364393000046968081', '24-25/VW-0581', '364393000045975308', 'RPX Multizyme', '90.00', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(156, '364393000046968081', '24-25/VW-0581', '364393000045975359', 'RPX NCMLD (FEED SUPPLIMENT)', '3.30', '2025-04-25 06:27:55', '2025-04-25 06:27:55'),
(157, '364393000046945013', 'MD-APR-25-02', '', '', '23290.00', '2025-04-25 06:11:12', '2025-04-25 09:10:20'),
(158, '364393000046966558', '24-25/VW-0580', '364393000045967418', 'RPX POTASSIUM IODIDE', '120.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(159, '364393000046966558', '24-25/VW-0580', '364393000045975818', 'RPX Potassium Di Formate', '160.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(160, '364393000046966558', '24-25/VW-0580', '364393000045967724', 'RPX Propionic Acid', '80.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(161, '364393000046966558', '24-25/VW-0580', '364393000045978833', 'RPX Proplene Glycol', '64.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(162, '364393000046966558', '24-25/VW-0580', '364393000045975869', 'RPX PVPK-30', '775.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(163, '364393000046966558', '24-25/VW-0580', '364393000045975920', 'RPX Quartz Powder', '4.20', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(164, '364393000046966558', '24-25/VW-0580', '364393000045975971', 'RPX Raspberry Flavor', '60.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(165, '364393000046966558', '24-25/VW-0580', '364393000045976124', 'RPX SLS Powder', '75.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(166, '364393000046966558', '24-25/VW-0580', '364393000045976175', 'RPX Soda Ash', '25.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(167, '364393000046966558', '24-25/VW-0580', '364393000045976226', 'RPX Soda Ash Granulas', '7.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(168, '364393000046966558', '24-25/VW-0580', '364393000045963728', 'RPX Sodium Benzoate', '70.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(169, '364393000046966558', '24-25/VW-0580', '364393000045976277', 'RPX Sodium Bi Sulphite', '40.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(170, '364393000046966558', '24-25/VW-0580', '364393000045976328', 'RPX Sodium Bicarbonate (Backing soda)', '25.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(171, '364393000046966558', '24-25/VW-0580', '364393000045978935', 'RPX Sodium Butyrate -FG', '250.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(172, '364393000046966558', '24-25/VW-0580', '364393000045978884', 'RPX Sodium Formate', '75.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(173, '364393000046966558', '24-25/VW-0580', '364393000045976430', 'RPX Sodium Hypo Chlorite', '35.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(174, '364393000046966558', '24-25/VW-0580', '364393000045969431', 'RPX Sodium Methyl Paraben', '325.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(175, '364393000046966558', '24-25/VW-0580', '364393000045976481', 'RPX Sodium Percorbonate Granules', '50.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(176, '364393000046966558', '24-25/VW-0580', '364393000045969482', 'RPX Sodium Propyl Paraben', '390.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(177, '364393000046966558', '24-25/VW-0580', '364393000045976532', 'RPX Sodium Selenite', '1300.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(178, '364393000046966558', '24-25/VW-0580', '364393000045978323', 'RPX Sodium Starch Glycolate', '50.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(179, '364393000046966558', '24-25/VW-0580', '364393000045976634', 'RPX Solvent C-9', '70.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(180, '364393000046966558', '24-25/VW-0580', '364393000045976685', 'RPX Spirulina', '475.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(181, '364393000046966558', '24-25/VW-0580', '364393000045979343', 'RPX SULPHUR', '25.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(182, '364393000046966558', '24-25/VW-0580', '364393000045976787', 'RPX Sulphuric Acid', '12.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(183, '364393000046966558', '24-25/VW-0580', '364393000045976838', 'RPX Sunset Yellow Color 500gms', '250.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(184, '364393000046966558', '24-25/VW-0580', '364393000045976889', 'RPX Sweet Orange Flavor', '250.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(185, '364393000046966558', '24-25/VW-0580', '364393000045976940', 'RPX TALC', '15.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(186, '364393000046966558', '24-25/VW-0580', '364393000045979496', 'RPX Thiamine Hydrochloride (Vitamin B1)', '2700.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(187, '364393000046966558', '24-25/VW-0580', '364393000045969056', 'RPX TRI Calcium Phospate', '70.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(188, '364393000046966558', '24-25/VW-0580', '364393000045977093', 'RPX TWEEN 80', '120.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(189, '364393000046966558', '24-25/VW-0580', '364393000045969113', 'RPX Vanilla Flavour', '160.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(190, '364393000046966558', '24-25/VW-0580', '364393000045978221', 'RPX Unigel', '90.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(191, '364393000046966558', '24-25/VW-0580', '364393000045979853', 'RPX VIitamin B12 (1per)', '600.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(192, '364393000046966558', '24-25/VW-0580', '364393000045979139', 'RPX VIitamin B12', '3000.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(193, '364393000046966558', '24-25/VW-0580', '364393000045979802', 'RPX Vitamin AD3', '3500.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(194, '364393000046966558', '24-25/VW-0580', '364393000045969170', 'RPX Vitamin B2', '1700.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(195, '364393000046966558', '24-25/VW-0580', '364393000045979547', 'RPX Vitamin B6', '1900.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(196, '364393000046966558', '24-25/VW-0580', '364393000045977144', 'RPX Vitamin C Coated (Ascorbic Acid)', '200.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(197, '364393000046966558', '24-25/VW-0580', '364393000045977195', 'RPX Vitamin E 50%', '800.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(198, '364393000046966558', '24-25/VW-0580', '364393000045977348', 'RPX Xantham Gum', '250.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(199, '364393000046966558', '24-25/VW-0580', '364393000045977501', 'RPX Zeolight Pink', '3.50', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(200, '364393000046966558', '24-25/VW-0580', '364393000045969278', 'RPX Zeolite Granules', '6.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(201, '364393000046966558', '24-25/VW-0580', '364393000045977450', 'RPX Zinc sulphate', '50.00', '2025-04-25 05:50:20', '2025-04-25 06:17:08'),
(202, '364393000046843802', '24-25/VW-0579', '364393000045978578', 'RPX Cross Povadine XL', '600.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(203, '364393000046843802', '24-25/VW-0579', '364393000045978272', 'RPX Crosscarmellose Sodium', '110.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(204, '364393000046843802', '24-25/VW-0579', '364393000045979649', 'RPX D Calcium Pantothenate (CDP)', '400.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(205, '364393000046843802', '24-25/VW-0579', '364393000045973064', 'RPX Dextrose', '30.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(206, '364393000046843802', '24-25/VW-0579', '364393000045966080', 'RPX DI Potassium Hydrogen Orthophosphate Anhydrous', '330.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(207, '364393000046843802', '24-25/VW-0579', '364393000045973166', 'RPX DL-Methionine(feed Grade)', '150.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(208, '364393000046843802', '24-25/VW-0579', '364393000045973217', 'RPX Dolomite Powder Export Quality', '1.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(209, '364393000046843802', '24-25/VW-0579', '364393000045977762', 'RPX EDTA -70', '35.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(210, '364393000046843802', '24-25/VW-0579', '364393000045973421', 'RPX Erythrozine 500gms', '2250.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(211, '364393000046843802', '24-25/VW-0579', '364393000045979292', 'RPX FERRIC AMMONIUM CITRATE', '80.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(212, '364393000046843802', '24-25/VW-0579', '364393000045977966', 'RPX Ferrous sulphate', '24.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(213, '364393000046843802', '24-25/VW-0579', '364393000045973472', 'RPX Fish Oil Flavor', '1800.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(214, '364393000046843802', '24-25/VW-0579', '364393000045966284', 'RPX Folic Acid', '1300.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(215, '364393000046843802', '24-25/VW-0579', '364393000045973523', 'RPX Formic Acid', '40.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(216, '364393000046843802', '24-25/VW-0579', '364393000045973574', 'RPX Fullers Earth Powder', '5.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(217, '364393000046843802', '24-25/VW-0579', '364393000045973676', 'RPX Garlic', '200.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(218, '364393000046843802', '24-25/VW-0579', '364393000045973727', 'RPX Gelatine', '300.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(219, '364393000046843802', '24-25/VW-0579', '364393000045963932', 'RPX Ginger  Dry Mix', '200.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(220, '364393000046843802', '24-25/VW-0579', '364393000045978170', 'RPX Glycine', '150.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(221, '364393000046843802', '24-25/VW-0579', '364393000045973829', 'RPX Herb  Amla', '80.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(222, '364393000046843802', '24-25/VW-0579', '364393000045973880', 'RPX Herb Karakkaya', '35.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(223, '364393000046843802', '24-25/VW-0579', '364393000045973931', 'RPX Herb Neem', '45.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(224, '364393000046843802', '24-25/VW-0579', '364393000045973982', 'RPX Herb Nelavemu', '40.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(225, '364393000046843802', '24-25/VW-0579', '364393000045974033', 'RPX Herb Tanikaya', '35.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(226, '364393000046843802', '24-25/VW-0579', '364393000045966539', 'RPX Herbs Vasa', '80.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(227, '364393000046843802', '24-25/VW-0579', '364393000045978476', 'RPX Humic Acid', '42.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(228, '364393000046843802', '24-25/VW-0579', '364393000045978068', 'RPX Hydrogen Peroxide', '20.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(229, '364393000046843802', '24-25/VW-0579', '364393000045979598', 'RPX Inositol', '330.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(230, '364393000046843802', '24-25/VW-0579', '364393000045963983', 'RPX IODINE', '3500.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(231, '364393000046843802', '24-25/VW-0579', '364393000045974084', 'RPX L-Lysine Mono Hcl (FEED GRADE).', '85.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(232, '364393000046843802', '24-25/VW-0579', '364393000045978374', 'RPX Lactose', '185.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(233, '364393000046843802', '24-25/VW-0579', '364393000045974441', 'RPX Lemon flavour', '220.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(234, '364393000046843802', '24-25/VW-0579', '364393000045978986', 'RPX Liquid Methionine', '170.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(235, '364393000046843802', '24-25/VW-0579', '364393000045974696', 'RPX Magnesium Stereate', '105.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(236, '364393000046843802', '24-25/VW-0579', '364393000045978119', 'RPX Maize Starch', '54.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(237, '364393000046843802', '24-25/VW-0579', '364393000045978425', 'RPX Mannitol', '430.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(238, '364393000046843802', '24-25/VW-0579', '364393000045975053', 'RPX MG (Malchite Green)', '220.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(239, '364393000046843802', '24-25/VW-0579', '364393000045975155', 'RPX Mono Potassium Phospate(MPP)', '25.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(240, '364393000046843802', '24-25/VW-0579', '364393000045975206', 'RPX Mono Sodium Glutamate', '60.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(241, '364393000046843802', '24-25/VW-0579', '364393000045975257', 'RPX MTAB', '350.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(242, '364393000046843802', '24-25/VW-0579', '364393000045979445', 'RPX NIACINAMIDE', '275.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(243, '364393000046843802', '24-25/VW-0579', '364393000045975461', 'RPX Pam Anionic', '90.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(244, '364393000046843802', '24-25/VW-0579', '364393000045975614', 'RPX Pine Apple Flavor 500gms', '220.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(245, '364393000046843802', '24-25/VW-0579', '364393000045975716', 'RPX PMPS Powder', '200.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(246, '364393000046843802', '24-25/VW-0579', '364393000045977864', 'RPX Magnesium Sulphate', '45.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(247, '364393000046843802', '24-25/VW-0579', '364393000045974798', 'RPX Manganese sulphate', '45.00', '2025-04-24 07:45:34', '2025-04-24 08:36:08'),
(248, '364393000046843159', '24-25/VW-0578', '364393000045969533', 'RPX  Acetic Acid Glacial', '82.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(249, '364393000046843159', '24-25/VW-0578', '364393000045969584', 'RPX  Formaldehyde', '12.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(250, '364393000046843159', '24-25/VW-0578', '364393000045969635', 'RPX  Hydro Chloric Acid', '90.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(251, '364393000046843159', '24-25/VW-0578', '364393000045969686', 'RPX  ISO Propyl Alcoho IPA', '80.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(252, '364393000046843159', '24-25/VW-0578', '364393000045909236', 'RPX ACRIFLAVINE', '4750.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(253, '364393000046843159', '24-25/VW-0578', '364393000045977711', 'RPX Aerosil', '300.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(254, '364393000046843159', '24-25/VW-0578', '364393000045969896', 'RPX Alphox', '140.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(255, '364393000046843159', '24-25/VW-0578', '364393000045970100', 'RPX Ammonium Propionate', '115.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(256, '364393000046843159', '24-25/VW-0578', '364393000045970151', 'RPX Apple', '260.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(257, '364393000046843159', '24-25/VW-0578', '364393000045979751', 'RPX Biotin', '450.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(258, '364393000046843159', '24-25/VW-0578', '364393000045909009', 'RPX BKC 50', '80.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(259, '364393000046843159', '24-25/VW-0578', '364393000045970259', 'RPX BKC 80', '90.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(260, '364393000046843159', '24-25/VW-0578', '364393000045970310', 'RPX BLACKCURENT', '200.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(261, '364393000046843159', '24-25/VW-0578', '364393000045970361', 'RPX Boric Acid', '85.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(262, '364393000046843159', '24-25/VW-0578', '364393000045970412', 'RPX BRILIANT BLUE', '90.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(263, '364393000046843159', '24-25/VW-0578', '364393000045963830', 'RPX Bronopol', '400.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(264, '364393000046843159', '24-25/VW-0578', '364393000045979190', 'RPX CALCIUM CARBONATE', '10.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(265, '364393000046843159', '24-25/VW-0578', '364393000045964397', 'RPX Calcium Propionate', '120.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(266, '364393000046843159', '24-25/VW-0578', '364393000045970565', 'RPX Cardamom', '230.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(267, '364393000046843159', '24-25/VW-0578', '364393000045970616', 'RPX Carmoisine Color', '400.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(268, '364393000046843159', '24-25/VW-0578', '364393000045971024', 'RPX CFU  Corn Steep Liquir', '14.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(269, '364393000046843159', '24-25/VW-0578', '364393000045963881', 'RPX Cetodet 500', '100.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(270, '364393000046843159', '24-25/VW-0578', '364393000045972095', 'RPX CFU Potassium Dihydrogen Ophosphate', '320.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(271, '364393000046843159', '24-25/VW-0578', '364393000045971177', 'RPX CFU Ammonium Sulphate', '100.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(272, '364393000046843159', '24-25/VW-0578', '364393000045971228', 'RPX CFU Antifoam', '200.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(273, '364393000046843159', '24-25/VW-0578', '364393000045977609', 'RPX CFU BEEF EXTRACT (BOCTO GRADE)', '250.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(274, '364393000046843159', '24-25/VW-0578', '364393000045964754', 'RPX CFU Calcium Chloride Dihydrate LR', '60.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(275, '364393000046843159', '24-25/VW-0578', '364393000045971585', 'RPX CFU Citric Acid', '110.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(276, '364393000046843159', '24-25/VW-0578', '364393000045965009', 'RPX CFU Dextrose', '80.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(277, '364393000046843159', '24-25/VW-0578', '364393000045971636', 'RPX CFU Ferrous Sulphate', '55.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(278, '364393000046843159', '24-25/VW-0578', '364393000045965111', 'RPX CFU IPA (LR)', '85.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(279, '364393000046843159', '24-25/VW-0578', '364393000045971687', 'RPX CFU Formaldehyde (LR)', '50.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(280, '364393000046843159', '24-25/VW-0578', '364393000045971789', 'RPX CFU Magnesium Chloride', '50.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(281, '364393000046843159', '24-25/VW-0578', '364393000045971840', 'RPX CFU Magnesium Sulphate', '60.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(282, '364393000046843159', '24-25/VW-0578', '364393000045971840', 'RPX CFU Magnesium Sulphate', '100.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(283, '364393000046843159', '24-25/VW-0578', '364393000045971942', 'RPX CFU Nitric Acid', '150.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(284, '364393000046843159', '24-25/VW-0578', '364393000045965264', 'RPX CFU Ortho phosphoric acid', '600.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(285, '364393000046843159', '24-25/VW-0578', '364393000045965417', 'RPX CFU Peptone Powder', '320.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(286, '364393000046843159', '24-25/VW-0578', '364393000045965468', 'RPX CFU Potassium Chloride LR', '20.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(287, '364393000046843159', '24-25/VW-0578', '364393000045972146', 'RPX CFU Potassium Permanganate', '110.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(288, '364393000046843159', '24-25/VW-0578', '364393000045972248', 'RPX CFU Sodium Acetate', '50.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(289, '364393000046843159', '24-25/VW-0578', '364393000045972299', 'RPX CFU Sodium Chloride', '50.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(290, '364393000046843159', '24-25/VW-0578', '364393000045972350', 'RPX CFU Sodium Selenite', '1020.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(291, '364393000046843159', '24-25/VW-0578', '364393000045972401', 'RPX CFU Tri Ammonium Citrate', '320.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(292, '364393000046843159', '24-25/VW-0578', '364393000045972503', 'RPX Charcoal', '40.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(293, '364393000046843159', '24-25/VW-0578', '364393000045972554', 'RPX Chocolate Brown', '200.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(294, '364393000046843159', '24-25/VW-0578', '364393000045979241', 'RPX CHROMIUM CHLORIDE', '220.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(295, '364393000046843159', '24-25/VW-0578', '364393000045972656', 'RPX Citric Acid', '100.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(296, '364393000046843159', '24-25/VW-0578', '364393000045972707', 'RPX Clove', '100.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(297, '364393000046843159', '24-25/VW-0578', '364393000045972758', 'RPX CMC Sodium', '100.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(298, '364393000046843159', '24-25/VW-0578', '364393000045972809', 'RPX Cobalt Sulphate', '600.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(299, '364393000046843159', '24-25/VW-0578', '364393000045972860', 'RPX Copper Sulphate', '150.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(300, '364393000046843159', '24-25/VW-0578', '364393000045969998', 'RPX Ammonium Formate', '100.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(301, '364393000046843159', '24-25/VW-0578', '364393000045970049', 'RPX Ammonium Molybdate', '2016.00', '2025-04-24 05:13:15', '2025-04-24 06:05:04'),
(302, '364393000046388341', 'SLI-1-25-26', '364393000045975767', 'RPX Potassium Chloride-', '60.00', '2025-04-16 08:46:19', '2025-04-16 08:51:47'),
(303, '364393000046388341', 'SLI-1-25-26', '364393000045978068', 'RPX Hydrogen Peroxide', '40.00', '2025-04-16 08:46:19', '2025-04-16 08:51:47'),
(304, '364393000046280160', '43', '', '', '10800.00', '2025-04-15 09:16:40', '2025-04-15 09:27:21'),
(305, '364393000046280131', '42', '', '', '10800.00', '2025-04-15 09:16:00', '2025-04-15 09:27:21'),
(306, '364393000046280090', '40-41', '', '', '20430.00', '2025-04-15 09:11:11', '2025-04-15 09:27:21'),
(307, '364393000046280049', '39', '', '', '17070.00', '2025-04-15 09:02:10', '2025-04-15 09:27:21'),
(308, '364393000046176213', '3133183840', '', '', '2860.00', '2025-04-14 06:35:13', '2025-04-15 04:25:39'),
(309, '364393000046201221', '1003252328697', '', '', '519998.86', '2025-04-12 04:51:13', '2025-04-12 04:51:26'),
(310, '364393000046183280', '36', '364393000045990861', 'CNTR JRY Can (Blue)', '186.00', '2025-04-12 04:08:50', '2025-04-12 04:09:38'),
(311, '364393000046183223', '4', '364393000045988407', 'CNTR JRY Can (White)', '186.00', '2025-04-12 04:06:47', '2025-04-12 04:07:29'),
(312, '364393000046183223', '4', '364393000045996228', 'CNTR IMD YELLOW', '17.00', '2025-04-12 04:06:47', '2025-04-12 04:07:29'),
(313, '364393000046183079', '19', '364393000045969845', 'RPX Allicin', '1000.00', '2025-04-12 03:48:21', '2025-04-12 03:50:36'),
(314, '364393000046169324', 'SAPR26002329185', '', '', '1769.00', '2025-04-11 10:30:38', '2025-04-11 10:31:04'),
(315, '364393000046169224', '104/25-26', '', '', '24190.00', '2025-04-11 10:28:36', '2025-04-11 10:29:03'),
(316, '364393000046169224', '104/25-26', '', '', '-4190.00', '2025-04-11 10:28:36', '2025-04-11 10:29:03'),
(317, '364393000046127130', 'HPT-25-26/5', '', '', '3894.00', '2025-04-10 09:51:03', '2025-04-10 09:57:13'),
(318, '364393000046127029', 'MTS-832', '', '', '9450.00', '2025-04-10 09:47:14', '2025-04-10 10:03:01'),
(319, '364393000046079065', 'APFEB25382', '', '', '10620.00', '2025-04-10 05:07:26', '2025-04-11 03:41:05'),
(320, '364393000046071160', 'C37E242500077623', '', '', '5870.50', '2025-04-09 10:59:53', '2025-04-09 11:00:00'),
(321, '364393000045895173', '2025-26/006', '', '', '18962.00', '2025-04-08 11:15:50', '2025-04-08 11:17:43'),
(322, '364393000045938624', '24-25/VW-0577', '364393000000079451', 'FP BW Blaster-5/5LT', '136.44', '2025-04-08 06:55:51', '2025-04-08 06:55:51'),
(323, '364393000045938624', '24-25/VW-0577', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-04-08 06:55:51', '2025-04-08 06:55:51'),
(324, '364393000045938624', '24-25/VW-0577', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-04-08 06:55:51', '2025-04-08 06:55:51'),
(325, '364393000045938624', '24-25/VW-0577', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.47', '2025-04-08 06:55:51', '2025-04-08 06:55:51'),
(326, '364393000045938624', '24-25/VW-0577', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-04-08 06:55:51', '2025-04-08 06:55:51'),
(327, '364393000045938624', '24-25/VW-0577', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-04-08 06:55:51', '2025-04-08 06:55:51'),
(328, '364393000045938407', '24-25/VW-0576', '364393000000079803', 'FP BW Planktolyze/10KG', '341.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(329, '364393000045938407', '24-25/VW-0576', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(330, '364393000045938407', '24-25/VW-0576', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(331, '364393000045938407', '24-25/VW-0576', '364393000000080103', 'FP BW Profish-BW/10KG', '157.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(332, '364393000045938407', '24-25/VW-0576', '364393000000283116', 'FP BW Proclarify-9/1KG', '322.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(333, '364393000045938407', '24-25/VW-0576', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(334, '364393000045938407', '24-25/VW-0576', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(335, '364393000045938407', '24-25/VW-0576', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(336, '364393000045938407', '24-25/VW-0576', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(337, '364393000045938407', '24-25/VW-0576', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(338, '364393000045938407', '24-25/VW-0576', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(339, '364393000045938407', '24-25/VW-0576', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(340, '364393000045938407', '24-25/VW-0576', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(341, '364393000045938407', '24-25/VW-0576', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(342, '364393000045938407', '24-25/VW-0576', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(343, '364393000045938407', '24-25/VW-0576', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-04-08 06:53:53', '2025-04-08 06:53:53'),
(344, '364393000045938139', '24-25/VW-0575', '364393000000079741', 'FP BW Abolish/1KG', '184.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(345, '364393000045938139', '24-25/VW-0575', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(346, '364393000045938139', '24-25/VW-0575', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(347, '364393000045938139', '24-25/VW-0575', '364393000000079745', 'FP BW Bluespark/500GM', '500.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(348, '364393000045938139', '24-25/VW-0575', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(349, '364393000045938139', '24-25/VW-0575', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(350, '364393000045938139', '24-25/VW-0575', '364393000000079749', 'FP BW Cut-PH/1KG', '98.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(351, '364393000045938139', '24-25/VW-0575', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05');
INSERT INTO `bill_items` (`id`, `bill_id`, `bill_number`, `item_id`, `item_name`, `rate`, `created_at`, `updated_at`) VALUES
(352, '364393000045938139', '24-25/VW-0575', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(353, '364393000045938139', '24-25/VW-0575', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(354, '364393000045938139', '24-25/VW-0575', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(355, '364393000045938139', '24-25/VW-0575', '364393000000079457', 'FP BW Dr. Green-X/5LT', '350.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(356, '364393000045938139', '24-25/VW-0575', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(357, '364393000045938139', '24-25/VW-0575', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '110.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(358, '364393000045938139', '24-25/VW-0575', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(359, '364393000045938139', '24-25/VW-0575', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(360, '364393000045938139', '24-25/VW-0575', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(361, '364393000045938139', '24-25/VW-0575', '364393000002697704', 'FP BW Isoweight/250GM', '300.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(362, '364393000045938139', '24-25/VW-0575', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '600.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(363, '364393000045938139', '24-25/VW-0575', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(364, '364393000045938139', '24-25/VW-0575', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-04-08 06:49:05', '2025-04-08 06:49:05'),
(365, '364393000045587019', 'BZA/24-25/1566', '', '', '56980.00', '2025-04-02 09:34:39', '2025-04-05 03:54:54'),
(366, '364393000045570624', 'MD-MAR-61', '', '', '44348.00', '2025-04-02 08:17:54', '2025-04-02 08:18:31'),
(367, '364393000045512740', '425', '', '', '23010.00', '2025-04-01 11:16:07', '2025-04-01 11:20:15'),
(368, '364393000045512657', '391', '', '', '83997.00', '2025-04-01 07:11:43', '2025-04-01 07:12:51'),
(369, '364393000045560526', 'BW24/25-0053', '364393000000928052', 'FP BW T-SMASH/20KG', '1700.00', '2025-04-01 05:48:32', '2025-04-01 05:48:47'),
(370, '364393000045512062', '3465', '', '', '67850.00', '2025-04-01 03:58:03', '2025-04-01 04:00:37'),
(371, '364393000045535804', '24-25/VW-0573', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-03-31 11:32:58', '2025-03-31 11:33:18'),
(372, '364393000045535804', '24-25/VW-0573', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.48', '2025-03-31 11:32:58', '2025-03-31 11:33:18'),
(373, '364393000045535804', '24-25/VW-0573', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-03-31 11:32:58', '2025-03-31 11:33:18'),
(374, '364393000045535804', '24-25/VW-0573', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-03-31 11:32:58', '2025-03-31 11:33:18'),
(375, '364393000045535804', '24-25/VW-0573', '364393000000079431', 'FP BW Apex-6/1LT', '72.03', '2025-03-31 11:32:58', '2025-03-31 11:33:18'),
(376, '364393000045535804', '24-25/VW-0573', '364393000000079435', 'FP BW Apex-6/20LT', '1227.12', '2025-03-31 11:32:58', '2025-03-31 11:33:18'),
(377, '364393000045535804', '24-25/VW-0573', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-31 11:32:58', '2025-03-31 11:33:18'),
(378, '364393000045535804', '24-25/VW-0573', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-03-31 11:32:58', '2025-03-31 11:33:18'),
(379, '364393000045535804', '24-25/VW-0573', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.48', '2025-03-31 11:32:58', '2025-03-31 11:33:18'),
(380, '364393000045535338', '24-25/VW-0572', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(381, '364393000045535338', '24-25/VW-0572', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(382, '364393000045535338', '24-25/VW-0572', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(383, '364393000045535338', '24-25/VW-0572', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(384, '364393000045535338', '24-25/VW-0572', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(385, '364393000045535338', '24-25/VW-0572', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(386, '364393000045535338', '24-25/VW-0572', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(387, '364393000045535338', '24-25/VW-0572', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(388, '364393000045535338', '24-25/VW-0572', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(389, '364393000045535338', '24-25/VW-0572', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(390, '364393000045535338', '24-25/VW-0572', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(391, '364393000045535338', '24-25/VW-0572', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(392, '364393000045535338', '24-25/VW-0572', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(393, '364393000045535338', '24-25/VW-0572', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(394, '364393000045535338', '24-25/VW-0572', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(395, '364393000045535338', '24-25/VW-0572', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(396, '364393000045535338', '24-25/VW-0572', '364393000000079771', 'FP BW Ammofree 99/1LT', '250.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(397, '364393000045535338', '24-25/VW-0572', '364393000000080111', 'FP BW Bluegold Gel/5LT', '167.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(398, '364393000045535338', '24-25/VW-0572', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(399, '364393000045535338', '24-25/VW-0572', '364393000000079455', 'FP BW Dr. Green-X/1LT', '84.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(400, '364393000045535338', '24-25/VW-0572', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(401, '364393000045535338', '24-25/VW-0572', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(402, '364393000045535338', '24-25/VW-0572', '364393000000079741', 'FP BW Abolish/1KG', '184.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(403, '364393000045535338', '24-25/VW-0572', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(404, '364393000045535338', '24-25/VW-0572', '364393000001811153', 'FP BW Bluesoft/5KG', '882.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(405, '364393000045535338', '24-25/VW-0572', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(406, '364393000045535338', '24-25/VW-0572', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '110.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(407, '364393000045535338', '24-25/VW-0572', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(408, '364393000045535338', '24-25/VW-0572', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(409, '364393000045535338', '24-25/VW-0572', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '505.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(410, '364393000045535338', '24-25/VW-0572', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(411, '364393000045535338', '24-25/VW-0572', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(412, '364393000045535338', '24-25/VW-0572', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(413, '364393000045535338', '24-25/VW-0572', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(414, '364393000045535338', '24-25/VW-0572', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(415, '364393000045535338', '24-25/VW-0572', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(416, '364393000045535338', '24-25/VW-0572', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-31 11:21:56', '2025-03-31 11:22:17'),
(417, '364393000045535241', 'SAEE/24-25/4286', '', '', '62608.00', '2025-03-31 11:16:30', '2025-04-01 04:00:37'),
(418, '364393000045486188', 'VLS/15562/24-25', '', '', '12036.00', '2025-03-31 05:56:49', '2025-03-31 05:58:01'),
(419, '364393000045366962', 'PP/SL/24-25/165', '', '', '26822.00', '2025-03-29 10:20:31', '2025-04-01 04:01:07'),
(420, '364393000045366962', 'PP/SL/24-25/165', '', '', '-822.00', '2025-03-29 10:20:31', '2025-04-01 04:01:07'),
(421, '364393000045377736', '24-25/VW-0570', '364393000000079473', 'FP BW Iodoshine 20%/1LT', '694.07', '2025-03-28 10:52:01', '2025-03-28 10:52:01'),
(422, '364393000045377736', '24-25/VW-0570', '364393000000079435', 'FP BW Apex-6/20LT', '1227.12', '2025-03-28 10:52:01', '2025-03-28 10:52:01'),
(423, '364393000045377736', '24-25/VW-0570', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-28 10:52:01', '2025-03-28 10:52:01'),
(424, '364393000045377736', '24-25/VW-0570', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-03-28 10:52:01', '2025-03-28 10:52:01'),
(425, '364393000045377736', '24-25/VW-0570', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-03-28 10:52:01', '2025-03-28 10:52:01'),
(426, '364393000045326437', '24-25/VW-0571', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(427, '364393000045326437', '24-25/VW-0571', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(428, '364393000045326437', '24-25/VW-0571', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(429, '364393000045326437', '24-25/VW-0571', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(430, '364393000045326437', '24-25/VW-0571', '364393000000079459', 'FP BW Dr Green-X/20LT', '1440.00', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(431, '364393000045326437', '24-25/VW-0571', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(432, '364393000045326437', '24-25/VW-0571', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(433, '364393000045326437', '24-25/VW-0571', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(434, '364393000045326437', '24-25/VW-0571', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(435, '364393000045326437', '24-25/VW-0571', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(436, '364393000045326437', '24-25/VW-0571', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-28 10:09:11', '2025-03-28 10:09:40'),
(437, '364393000045326227', 'GST-276', '', '', '7142.00', '2025-03-28 08:49:08', '2025-04-09 10:55:24'),
(438, '364393000045322436', 'BW24/25-0052', '364393000000928052', 'FP BW T-SMASH/20KG', '1700.00', '2025-03-28 05:34:28', '2025-03-28 05:34:41'),
(439, '364393000045342832', '24-25/VW-0569', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-03-27 08:55:56', '2025-03-27 08:57:00'),
(440, '364393000045342832', '24-25/VW-0569', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-03-27 08:55:56', '2025-03-27 08:57:00'),
(441, '364393000045342832', '24-25/VW-0569', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-03-27 08:55:56', '2025-03-27 08:57:00'),
(442, '364393000045342832', '24-25/VW-0569', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-03-27 08:55:56', '2025-03-27 08:57:00'),
(443, '364393000045342832', '24-25/VW-0569', '364393000004394315', 'FP VW MG/500GM', '402.00', '2025-03-27 08:55:56', '2025-03-27 08:57:00'),
(444, '364393000045342832', '24-25/VW-0569', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-03-27 08:55:56', '2025-03-27 08:57:00'),
(445, '364393000045342648', '24-25/VW-0568', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(446, '364393000045342648', '24-25/VW-0568', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(447, '364393000045342648', '24-25/VW-0568', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(448, '364393000045342648', '24-25/VW-0568', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(449, '364393000045342648', '24-25/VW-0568', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(450, '364393000045342648', '24-25/VW-0568', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(451, '364393000045342648', '24-25/VW-0568', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(452, '364393000045342648', '24-25/VW-0568', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(453, '364393000045342648', '24-25/VW-0568', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(454, '364393000045342648', '24-25/VW-0568', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(455, '364393000045342648', '24-25/VW-0568', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(456, '364393000045342648', '24-25/VW-0568', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(457, '364393000045342648', '24-25/VW-0568', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(458, '364393000045342648', '24-25/VW-0568', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(459, '364393000045342648', '24-25/VW-0568', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(460, '364393000045342648', '24-25/VW-0568', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(461, '364393000045342648', '24-25/VW-0568', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(462, '364393000045342648', '24-25/VW-0568', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(463, '364393000045342648', '24-25/VW-0568', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(464, '364393000045342648', '24-25/VW-0568', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(465, '364393000045342648', '24-25/VW-0568', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(466, '364393000045342648', '24-25/VW-0568', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(467, '364393000045342648', '24-25/VW-0568', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(468, '364393000045342648', '24-25/VW-0568', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(469, '364393000045342648', '24-25/VW-0568', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(470, '364393000045342648', '24-25/VW-0568', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(471, '364393000045342648', '24-25/VW-0568', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(472, '364393000045342648', '24-25/VW-0568', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(473, '364393000045342648', '24-25/VW-0568', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(474, '364393000045342648', '24-25/VW-0568', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(475, '364393000045342648', '24-25/VW-0568', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(476, '364393000045342648', '24-25/VW-0568', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(477, '364393000045342648', '24-25/VW-0568', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(478, '364393000045342648', '24-25/VW-0568', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(479, '364393000045342648', '24-25/VW-0568', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(480, '364393000045342648', '24-25/VW-0568', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(481, '364393000045342648', '24-25/VW-0568', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(482, '364393000045342648', '24-25/VW-0568', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(483, '364393000045342648', '24-25/VW-0568', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(484, '364393000045342648', '24-25/VW-0568', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(485, '364393000045342648', '24-25/VW-0568', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(486, '364393000045342648', '24-25/VW-0568', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(487, '364393000045342648', '24-25/VW-0568', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(488, '364393000045342648', '24-25/VW-0568', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(489, '364393000045342648', '24-25/VW-0568', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(490, '364393000045342648', '24-25/VW-0568', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(491, '364393000045342648', '24-25/VW-0568', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(492, '364393000045342648', '24-25/VW-0568', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(493, '364393000045342648', '24-25/VW-0568', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(494, '364393000045342648', '24-25/VW-0568', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(495, '364393000045342648', '24-25/VW-0568', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(496, '364393000045342648', '24-25/VW-0568', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(497, '364393000045342648', '24-25/VW-0568', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(498, '364393000045342648', '24-25/VW-0568', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-27 08:48:00', '2025-03-27 08:56:57'),
(499, '364393000045293109', '38', '', '', '11940.00', '2025-03-26 10:02:49', '2025-03-26 10:05:56'),
(500, '364393000045293065', '37', '', '', '11670.00', '2025-03-26 10:01:55', '2025-03-26 10:05:56'),
(501, '364393000045293021', '36', '', '', '11670.00', '2025-03-26 10:01:02', '2025-03-26 10:05:56'),
(502, '364393000045241160', '700/24-25', '', '', '1890.00', '2025-03-26 06:02:25', '2025-03-26 09:57:44'),
(503, '364393000045146125', '24-25/VW-0564', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(504, '364393000045146125', '24-25/VW-0564', '364393000000080119', 'FP BW Provitagel-BW/20LT', '975.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(505, '364393000045146125', '24-25/VW-0564', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(506, '364393000045146125', '24-25/VW-0564', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(507, '364393000045146125', '24-25/VW-0564', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(508, '364393000045146125', '24-25/VW-0564', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(509, '364393000045146125', '24-25/VW-0564', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(510, '364393000045146125', '24-25/VW-0564', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(511, '364393000045146125', '24-25/VW-0564', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(512, '364393000045146125', '24-25/VW-0564', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(513, '364393000045146125', '24-25/VW-0564', '364393000000283116', 'FP BW Proclarify-9/1KG', '322.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(514, '364393000045146125', '24-25/VW-0564', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(515, '364393000045146125', '24-25/VW-0564', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(516, '364393000045146125', '24-25/VW-0564', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(517, '364393000045146125', '24-25/VW-0564', '364393000000080111', 'FP BW Bluegold Gel/5LT', '167.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(518, '364393000045146125', '24-25/VW-0564', '364393000000079459', 'FP BW Dr Green-X/20LT', '1440.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(519, '364393000045146125', '24-25/VW-0564', '364393000000079741', 'FP BW Abolish/1KG', '184.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(520, '364393000045146125', '24-25/VW-0564', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(521, '364393000045146125', '24-25/VW-0564', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(522, '364393000045146125', '24-25/VW-0564', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(523, '364393000045146125', '24-25/VW-0564', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(524, '364393000045146125', '24-25/VW-0564', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(525, '364393000045146125', '24-25/VW-0564', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(526, '364393000045146125', '24-25/VW-0564', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(527, '364393000045146125', '24-25/VW-0564', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(528, '364393000045146125', '24-25/VW-0564', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(529, '364393000045146125', '24-25/VW-0564', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(530, '364393000045146125', '24-25/VW-0564', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(531, '364393000045146125', '24-25/VW-0564', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(532, '364393000045146125', '24-25/VW-0564', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(533, '364393000045146125', '24-25/VW-0564', '364393000001811153', 'FP BW Bluesoft/5KG', '882.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(534, '364393000045146125', '24-25/VW-0564', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(535, '364393000045146125', '24-25/VW-0564', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(536, '364393000045146125', '24-25/VW-0564', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(537, '364393000045146125', '24-25/VW-0564', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(538, '364393000045146125', '24-25/VW-0564', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '505.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(539, '364393000045146125', '24-25/VW-0564', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(540, '364393000045146125', '24-25/VW-0564', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(541, '364393000045146125', '24-25/VW-0564', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(542, '364393000045146125', '24-25/VW-0564', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(543, '364393000045146125', '24-25/VW-0564', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(544, '364393000045146125', '24-25/VW-0564', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(545, '364393000045146125', '24-25/VW-0564', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(546, '364393000045146125', '24-25/VW-0564', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(547, '364393000045146125', '24-25/VW-0564', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(548, '364393000045146125', '24-25/VW-0564', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(549, '364393000045146125', '24-25/VW-0564', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(550, '364393000045146125', '24-25/VW-0564', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(551, '364393000045146125', '24-25/VW-0564', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(552, '364393000045146125', '24-25/VW-0564', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(553, '364393000045146125', '24-25/VW-0564', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(554, '364393000045146125', '24-25/VW-0564', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(555, '364393000045146125', '24-25/VW-0564', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(556, '364393000045146125', '24-25/VW-0564', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(557, '364393000045146125', '24-25/VW-0564', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-25 04:10:52', '2025-03-25 11:34:15'),
(558, '364393000045146053', '24-25/VW-0563', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(559, '364393000045146053', '24-25/VW-0563', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(560, '364393000045146053', '24-25/VW-0563', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(561, '364393000045146053', '24-25/VW-0563', '364393000000079433', 'FP BW Apex-6/5LT', '299.15', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(562, '364393000045146053', '24-25/VW-0563', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(563, '364393000045146053', '24-25/VW-0563', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(564, '364393000045146053', '24-25/VW-0563', '364393000001386759', 'FP BW Iodoshine 20%/500ML', '351.69', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(565, '364393000045146053', '24-25/VW-0563', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.48', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(566, '364393000045146053', '24-25/VW-0563', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(567, '364393000045146053', '24-25/VW-0563', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(568, '364393000045146053', '24-25/VW-0563', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(569, '364393000045146053', '24-25/VW-0563', '364393000000079471', 'FP BW Iodoshine 2%/20LT', '1044.07', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(570, '364393000045146053', '24-25/VW-0563', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-03-25 03:36:26', '2025-03-25 11:34:12'),
(571, '364393000045065179', 'EGARUH2425000973', '', '', '6617.00', '2025-03-24 08:20:36', '2025-03-24 08:22:11'),
(572, '364393000045050114', '391', '', '', '10210.00', '2025-03-21 07:24:59', '2025-04-01 04:01:07'),
(573, '364393000045060070', '24-25/VW-0562', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-03-21 05:54:21', '2025-03-22 07:34:28'),
(574, '364393000045060070', '24-25/VW-0562', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-21 05:54:21', '2025-03-22 07:34:28'),
(575, '364393000045060070', '24-25/VW-0562', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-03-21 05:54:21', '2025-03-22 07:34:28'),
(576, '364393000045060070', '24-25/VW-0562', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.48', '2025-03-21 05:54:21', '2025-03-22 07:34:28'),
(577, '364393000045060001', '24-25/VW-0561', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(578, '364393000045060001', '24-25/VW-0561', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(579, '364393000045060001', '24-25/VW-0561', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(580, '364393000045060001', '24-25/VW-0561', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(581, '364393000045060001', '24-25/VW-0561', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(582, '364393000045060001', '24-25/VW-0561', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(583, '364393000045060001', '24-25/VW-0561', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(584, '364393000045060001', '24-25/VW-0561', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(585, '364393000045060001', '24-25/VW-0561', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '110.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(586, '364393000045060001', '24-25/VW-0561', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(587, '364393000045060001', '24-25/VW-0561', '364393000000079775', 'FP BW Viracon-S/500GM', '238.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(588, '364393000045060001', '24-25/VW-0561', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(589, '364393000045060001', '24-25/VW-0561', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(590, '364393000045060001', '24-25/VW-0561', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(591, '364393000045060001', '24-25/VW-0561', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(592, '364393000045060001', '24-25/VW-0561', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-21 05:50:26', '2025-03-22 07:34:26'),
(593, '364393000045050008', '1024250444155', '', '', '117032.40', '2025-03-21 05:14:53', '2025-05-03 06:59:38'),
(594, '364393000044967193', '24-25/VW-0560', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-20 09:12:36', '2025-03-20 09:13:13'),
(595, '364393000044967193', '24-25/VW-0560', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-20 09:12:36', '2025-03-20 09:13:13'),
(596, '364393000044967193', '24-25/VW-0560', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-03-20 09:12:36', '2025-03-20 09:13:13'),
(597, '364393000044967067', '24-25/VW-0555', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(598, '364393000044967067', '24-25/VW-0555', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(599, '364393000044967067', '24-25/VW-0555', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(600, '364393000044967067', '24-25/VW-0555', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(601, '364393000044967067', '24-25/VW-0555', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(602, '364393000044967067', '24-25/VW-0555', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(603, '364393000044967067', '24-25/VW-0555', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(604, '364393000044967067', '24-25/VW-0555', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(605, '364393000044967067', '24-25/VW-0555', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(606, '364393000044967067', '24-25/VW-0555', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(607, '364393000044967067', '24-25/VW-0555', '364393000000080111', 'FP BW Bluegold Gel/5LT', '167.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(608, '364393000044967067', '24-25/VW-0555', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(609, '364393000044967067', '24-25/VW-0555', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(610, '364393000044967067', '24-25/VW-0555', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(611, '364393000044967067', '24-25/VW-0555', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(612, '364393000044967067', '24-25/VW-0555', '364393000000079749', 'FP BW Cut-PH/1KG', '98.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(613, '364393000044967067', '24-25/VW-0555', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(614, '364393000044967067', '24-25/VW-0555', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(615, '364393000044967067', '24-25/VW-0555', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(616, '364393000044967067', '24-25/VW-0555', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(617, '364393000044967067', '24-25/VW-0555', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(618, '364393000044967067', '24-25/VW-0555', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(619, '364393000044967067', '24-25/VW-0555', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(620, '364393000044967067', '24-25/VW-0555', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(621, '364393000044967067', '24-25/VW-0555', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(622, '364393000044967067', '24-25/VW-0555', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(623, '364393000044967067', '24-25/VW-0555', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(624, '364393000044967067', '24-25/VW-0555', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(625, '364393000044967067', '24-25/VW-0555', '364393000000079803', 'FP BW Planktolyze/10KG', '341.00', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(626, '364393000044967067', '24-25/VW-0555', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(627, '364393000044967067', '24-25/VW-0555', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-20 09:10:23', '2025-03-20 09:13:23'),
(628, '364393000044930446', '25', '', '', '13680.00', '2025-03-19 07:27:21', '2025-03-19 07:27:41'),
(629, '364393000044930326', '24', '', '', '14820.00', '2025-03-19 07:24:13', '2025-03-19 07:25:09'),
(630, '364393000044930154', '23', '', '', '8250.00', '2025-03-19 07:19:31', '2025-03-19 07:22:51'),
(631, '364393000044930122', '22', '', '', '8250.00', '2025-03-19 07:18:33', '2025-03-19 07:22:45'),
(632, '364393000044930039', 'C-5020/24-25', '', '', '34728.00', '2025-03-19 03:56:43', '2025-04-01 04:01:07'),
(633, '364393000044825371', 'MD-MAR-59', '', '', '66410.00', '2025-03-18 03:50:26', '2025-03-18 03:50:36'),
(634, '364393000044834191', '9021284623', '', '', '3010.00', '2025-03-17 10:01:19', '2025-04-01 04:01:38'),
(635, '364393000044834139', '593', '', '', '2900.00', '2025-03-17 08:34:01', '2025-04-01 04:01:38'),
(636, '364393000044823060', '2', '', '', '8300.00', '2025-03-15 09:44:19', '2025-04-01 04:01:38'),
(637, '364393000044852177', '24-25/VW-0554', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-03-15 08:30:00', '2025-03-15 08:30:52'),
(638, '364393000044852108', '24-25/VW-0553', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(639, '364393000044852108', '24-25/VW-0553', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(640, '364393000044852108', '24-25/VW-0553', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(641, '364393000044852108', '24-25/VW-0553', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(642, '364393000044852108', '24-25/VW-0553', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(643, '364393000044852108', '24-25/VW-0553', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(644, '364393000044852108', '24-25/VW-0553', '364393000001811153', 'FP BW Bluesoft/5KG', '882.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(645, '364393000044852108', '24-25/VW-0553', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(646, '364393000044852108', '24-25/VW-0553', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(647, '364393000044852108', '24-25/VW-0553', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(648, '364393000044852108', '24-25/VW-0553', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(649, '364393000044852108', '24-25/VW-0553', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-03-15 08:26:50', '2025-03-15 08:30:55'),
(650, '364393000044760031', '3842/2024-25', '', '', '2404.00', '2025-03-13 07:28:19', '2025-03-13 07:28:42'),
(651, '364393000044643003', 'GST-14811', '', '', '60770.00', '2025-03-12 04:39:21', '2025-04-01 04:01:38'),
(652, '364393000044534047', 'SAPR25002081533', '', '', '1769.00', '2025-03-11 08:04:37', '2025-03-11 08:04:58'),
(653, '364393000044525899', '24-25/VW-0552', '364393000000079433', 'FP BW Apex-6/5LT', '299.15', '2025-03-11 06:18:23', '2025-03-11 06:19:39'),
(654, '364393000044525899', '24-25/VW-0552', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-03-11 06:18:23', '2025-03-11 06:19:39'),
(655, '364393000044525899', '24-25/VW-0552', '364393000000079471', 'FP BW Iodoshine 2%/20LT', '1044.07', '2025-03-11 06:18:23', '2025-03-11 06:19:39'),
(656, '364393000044525899', '24-25/VW-0552', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.48', '2025-03-11 06:18:23', '2025-03-11 06:19:39'),
(657, '364393000044525899', '24-25/VW-0552', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-03-11 06:18:23', '2025-03-11 06:19:39'),
(658, '364393000044525899', '24-25/VW-0552', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-11 06:18:23', '2025-03-11 06:19:39'),
(659, '364393000044525713', '24-25/VW-0551', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(660, '364393000044525713', '24-25/VW-0551', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(661, '364393000044525713', '24-25/VW-0551', '364393000000283116', 'FP BW Proclarify-9/1KG', '322.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(662, '364393000044525713', '24-25/VW-0551', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(663, '364393000044525713', '24-25/VW-0551', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(664, '364393000044525713', '24-25/VW-0551', '364393000000079459', 'FP BW Dr Green-X/20LT', '1440.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(665, '364393000044525713', '24-25/VW-0551', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(666, '364393000044525713', '24-25/VW-0551', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(667, '364393000044525713', '24-25/VW-0551', '364393000000080119', 'FP BW Provitagel-BW/20LT', '975.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(668, '364393000044525713', '24-25/VW-0551', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(669, '364393000044525713', '24-25/VW-0551', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(670, '364393000044525713', '24-25/VW-0551', '364393000000080091', 'FP BW Zyme-B/500GM', '300.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(671, '364393000044525713', '24-25/VW-0551', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(672, '364393000044525713', '24-25/VW-0551', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(673, '364393000044525713', '24-25/VW-0551', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(674, '364393000044525713', '24-25/VW-0551', '364393000000283116', 'FP BW Proclarify-9/1KG', '322.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(675, '364393000044525713', '24-25/VW-0551', '364393000003361471', 'FP BW Snail Blast/1KG', '800.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(676, '364393000044525713', '24-25/VW-0551', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(677, '364393000044525713', '24-25/VW-0551', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(678, '364393000044525713', '24-25/VW-0551', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(679, '364393000044525713', '24-25/VW-0551', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(680, '364393000044525713', '24-25/VW-0551', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '600.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(681, '364393000044525713', '24-25/VW-0551', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(682, '364393000044525713', '24-25/VW-0551', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(683, '364393000044525713', '24-25/VW-0551', '364393000000485189', 'FP BW GUTWEIGHT 1LT', '200.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(684, '364393000044525713', '24-25/VW-0551', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(685, '364393000044525713', '24-25/VW-0551', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(686, '364393000044525713', '24-25/VW-0551', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(687, '364393000044525713', '24-25/VW-0551', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(688, '364393000044525713', '24-25/VW-0551', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(689, '364393000044525713', '24-25/VW-0551', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(690, '364393000044525713', '24-25/VW-0551', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '600.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(691, '364393000044525713', '24-25/VW-0551', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(692, '364393000044525713', '24-25/VW-0551', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '505.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(693, '364393000044525713', '24-25/VW-0551', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(694, '364393000044525713', '24-25/VW-0551', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(695, '364393000044525713', '24-25/VW-0551', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(696, '364393000044525713', '24-25/VW-0551', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(697, '364393000044525713', '24-25/VW-0551', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-11 06:04:54', '2025-03-11 06:19:33'),
(698, '364393000044510304', 'BW24/25-0050', '364393000000928052', 'FP BW T-SMASH/20KG', '1700.00', '2025-03-10 11:57:22', '2025-03-10 11:57:22'),
(699, '364393000044510238', '24-25/VW-0543', '364393000003361471', 'FP BW Snail Blast/1KG', '800.00', '2025-03-10 10:23:57', '2025-03-10 10:23:57');
INSERT INTO `bill_items` (`id`, `bill_id`, `bill_number`, `item_id`, `item_name`, `rate`, `created_at`, `updated_at`) VALUES
(700, '364393000044342057', 'HLPL/24-25/1207A', '', '', '7080.00', '2025-03-07 09:39:42', '2025-03-08 04:28:35'),
(701, '364393000044346613', '24-25/VW-0544', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-07 05:20:29', '2025-03-07 08:56:32'),
(702, '364393000044346613', '24-25/VW-0544', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.48', '2025-03-07 05:20:29', '2025-03-07 08:56:32'),
(703, '364393000044346613', '24-25/VW-0544', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-03-07 05:20:29', '2025-03-07 08:56:32'),
(704, '364393000044346613', '24-25/VW-0544', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-03-07 05:20:29', '2025-03-07 08:56:32'),
(705, '364393000044346613', '24-25/VW-0544', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-03-07 05:20:29', '2025-03-07 08:56:32'),
(706, '364393000044346550', '24-25/VW-0548', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(707, '364393000044346550', '24-25/VW-0548', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(708, '364393000044346550', '24-25/VW-0548', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(709, '364393000044346550', '24-25/VW-0548', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(710, '364393000044346550', '24-25/VW-0548', '364393000000079741', 'FP BW Abolish/1KG', '184.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(711, '364393000044346550', '24-25/VW-0548', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '110.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(712, '364393000044346550', '24-25/VW-0548', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(713, '364393000044346550', '24-25/VW-0548', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(714, '364393000044346550', '24-25/VW-0548', '364393000000079775', 'FP BW Viracon-S/500GM', '238.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(715, '364393000044346550', '24-25/VW-0548', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(716, '364393000044346550', '24-25/VW-0548', '364393000039148035', 'FP BW ECOFRESH POWERPRO TABLETS 2KG', '1500.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(717, '364393000044346550', '24-25/VW-0548', '364393000000079741', 'FP BW Abolish/1KG', '184.00', '2025-03-07 05:13:34', '2025-03-12 04:44:28'),
(718, '364393000044305801', '34', '', '', '8100.00', '2025-03-06 10:51:23', '2025-03-13 07:31:07'),
(719, '364393000044305769', '33', '', '', '7500.00', '2025-03-06 10:50:00', '2025-03-13 07:31:19'),
(720, '364393000044305737', '32', '', '', '10110.00', '2025-03-06 10:49:25', '2025-03-13 07:31:56'),
(721, '364393000044305464', '31', '', '', '7920.00', '2025-03-06 10:36:32', '2025-03-13 07:32:10'),
(722, '364393000044305432', '30', '', '', '7800.00', '2025-03-06 10:32:33', '2025-03-13 07:32:28'),
(723, '364393000044305043', '29', '', '', '7770.00', '2025-03-06 10:23:13', '2025-03-13 07:32:42'),
(724, '364393000044305011', '28', '', '', '7770.00', '2025-03-06 10:22:34', '2025-03-13 07:36:42'),
(725, '364393000044247350', '223', '', '', '17794.00', '2025-03-05 10:31:33', '2025-03-10 06:33:49'),
(726, '364393000044247350', '223', '', '', '-7000.00', '2025-03-05 10:31:33', '2025-03-10 06:33:49'),
(727, '364393000044247176', '222', '', '', '380000.00', '2025-03-05 10:28:36', '2025-03-10 06:33:11'),
(728, '364393000044251127', '24-25/VW-0547', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-03-05 08:52:26', '2025-03-05 08:53:18'),
(729, '364393000044251127', '24-25/VW-0547', '364393000000079433', 'FP BW Apex-6/5LT', '299.15', '2025-03-05 08:52:26', '2025-03-05 08:53:18'),
(730, '364393000044251127', '24-25/VW-0547', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-03-05 08:52:26', '2025-03-05 08:53:18'),
(731, '364393000044251127', '24-25/VW-0547', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-03-05 08:52:26', '2025-03-05 08:53:18'),
(732, '364393000044251001', '24-25/VW-0546', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(733, '364393000044251001', '24-25/VW-0546', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(734, '364393000044251001', '24-25/VW-0546', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(735, '364393000044251001', '24-25/VW-0546', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(736, '364393000044251001', '24-25/VW-0546', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(737, '364393000044251001', '24-25/VW-0546', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(738, '364393000044251001', '24-25/VW-0546', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(739, '364393000044251001', '24-25/VW-0546', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(740, '364393000044251001', '24-25/VW-0546', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(741, '364393000044251001', '24-25/VW-0546', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(742, '364393000044251001', '24-25/VW-0546', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(743, '364393000044251001', '24-25/VW-0546', '364393000000079803', 'FP BW Planktolyze/10KG', '341.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(744, '364393000044251001', '24-25/VW-0546', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(745, '364393000044251001', '24-25/VW-0546', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(746, '364393000044251001', '24-25/VW-0546', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(747, '364393000044251001', '24-25/VW-0546', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(748, '364393000044251001', '24-25/VW-0546', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(749, '364393000044251001', '24-25/VW-0546', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(750, '364393000044251001', '24-25/VW-0546', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(751, '364393000044251001', '24-25/VW-0546', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(752, '364393000044251001', '24-25/VW-0546', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(753, '364393000044251001', '24-25/VW-0546', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(754, '364393000044251001', '24-25/VW-0546', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(755, '364393000044251001', '24-25/VW-0546', '364393000000079803', 'FP BW Planktolyze/10KG', '341.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(756, '364393000044251001', '24-25/VW-0546', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(757, '364393000044251001', '24-25/VW-0546', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(758, '364393000044251001', '24-25/VW-0546', '364393000000079745', 'FP BW Bluespark/500GM', '500.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(759, '364393000044251001', '24-25/VW-0546', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(760, '364393000044251001', '24-25/VW-0546', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(761, '364393000044251001', '24-25/VW-0546', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(762, '364393000044251001', '24-25/VW-0546', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-03-05 08:39:18', '2025-03-05 08:53:14'),
(763, '364393000044247003', '174/24-25', '', '', '6490.00', '2025-03-05 06:33:47', '2025-03-05 06:33:57'),
(764, '364393000044169351', '1090365001', '', '', '730.00', '2025-03-04 10:03:26', '2025-04-28 09:26:44'),
(765, '364393000044169287', 'BZA/24-25/1275', '', '', '51465.00', '2025-03-04 04:09:06', '2025-03-05 04:23:21'),
(766, '364393000044080316', '190/24-25', '', '', '15812.00', '2025-03-03 06:58:57', '2025-03-03 07:01:31'),
(767, '364393000044080211', 'T25030009', '', '', '657.00', '2025-03-03 06:02:25', '2025-03-03 06:05:26'),
(768, '364393000044111490', 'FEB-2025', '', '', '167000.00', '2025-03-01 05:46:27', '2025-03-01 06:54:59'),
(769, '364393000044087066', '24-25/VW-0540', '364393000000079461', 'FP BW Benz-80/1LT', '205.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(770, '364393000044087066', '24-25/VW-0540', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(771, '364393000044087066', '24-25/VW-0540', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(772, '364393000044087066', '24-25/VW-0540', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(773, '364393000044087066', '24-25/VW-0540', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(774, '364393000044087066', '24-25/VW-0540', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(775, '364393000044087066', '24-25/VW-0540', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(776, '364393000044087066', '24-25/VW-0540', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(777, '364393000044087066', '24-25/VW-0540', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(778, '364393000044087066', '24-25/VW-0540', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(779, '364393000044087066', '24-25/VW-0540', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '505.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(780, '364393000044087066', '24-25/VW-0540', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(781, '364393000044087066', '24-25/VW-0540', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(782, '364393000044087066', '24-25/VW-0540', '364393000000079457', 'FP BW Dr. Green-X/5LT', '350.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(783, '364393000044087066', '24-25/VW-0540', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(784, '364393000044087066', '24-25/VW-0540', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(785, '364393000044087066', '24-25/VW-0540', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(786, '364393000044087066', '24-25/VW-0540', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(787, '364393000044087066', '24-25/VW-0540', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(788, '364393000044087066', '24-25/VW-0540', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(789, '364393000044087066', '24-25/VW-0540', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '600.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(790, '364393000044087066', '24-25/VW-0540', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(791, '364393000044087066', '24-25/VW-0540', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-28 09:01:41', '2025-02-28 09:02:08'),
(792, '364393000044087029', '24-25/VW-0539', '364393000000079431', 'FP BW Apex-6/1LT', '72.03', '2025-02-28 08:39:36', '2025-02-28 09:02:11'),
(793, '364393000044087029', '24-25/VW-0539', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-02-28 08:39:36', '2025-02-28 09:02:11'),
(794, '364393000044087029', '24-25/VW-0539', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-02-28 08:39:36', '2025-02-28 09:02:11'),
(795, '364393000044087029', '24-25/VW-0539', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.48', '2025-02-28 08:39:36', '2025-02-28 09:02:11'),
(796, '364393000044094126', 'MD-FEB-57', '', '', '24107.00', '2025-02-28 04:54:29', '2025-04-02 08:19:04'),
(797, '364393000044094015', '529', '', '', '81840.00', '2025-02-28 04:51:47', '2025-02-28 04:53:14'),
(798, '364393000044000087', '1756/24-25', '364393000000079745', 'FP BW Bluespark/500GM', '1062.00', '2025-02-27 04:42:49', '2025-02-27 04:43:18'),
(799, '364393000043917213', '1024250409268', '', '', '1020.94', '2025-02-25 11:07:16', '2025-03-21 05:08:15'),
(800, '364393000043917140', 'EGARUH2425000880', '', '', '2585.00', '2025-02-25 10:37:35', '2025-02-25 10:37:56'),
(801, '364393000043917067', 'MD-FEB-51', '', '', '20437.00', '2025-02-25 10:35:25', '2025-04-02 08:19:04'),
(802, '364393000043922050', 'FT/24-25/002631', '', '', '20060.00', '2025-02-25 07:41:53', '2025-02-25 07:50:03'),
(803, '364393000043943316', '24-25/VW-0538', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(804, '364393000043943316', '24-25/VW-0538', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(805, '364393000043943316', '24-25/VW-0538', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(806, '364393000043943316', '24-25/VW-0538', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '600.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(807, '364393000043943316', '24-25/VW-0538', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(808, '364393000043943316', '24-25/VW-0538', '364393000000080119', 'FP BW Provitagel-BW/20LT', '975.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(809, '364393000043943316', '24-25/VW-0538', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(810, '364393000043943316', '24-25/VW-0538', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(811, '364393000043943316', '24-25/VW-0538', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(812, '364393000043943316', '24-25/VW-0538', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '505.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(813, '364393000043943316', '24-25/VW-0538', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(814, '364393000043943316', '24-25/VW-0538', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(815, '364393000043943316', '24-25/VW-0538', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-02-25 05:45:05', '2025-02-25 05:45:58'),
(816, '364393000043943260', '24-25/VW-0537', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-02-25 05:31:24', '2025-02-25 05:46:02'),
(817, '364393000043943260', '24-25/VW-0537', '364393000000079471', 'FP BW Iodoshine 2%/20LT', '1044.07', '2025-02-25 05:31:24', '2025-02-25 05:46:02'),
(818, '364393000043943260', '24-25/VW-0537', '364393000000079431', 'FP BW Apex-6/1LT', '72.03', '2025-02-25 05:31:24', '2025-02-25 05:46:02'),
(819, '364393000043943260', '24-25/VW-0537', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-02-25 05:31:24', '2025-02-25 05:46:02'),
(820, '364393000043943260', '24-25/VW-0537', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-02-25 05:31:24', '2025-02-25 05:46:02'),
(821, '364393000043746142', '24/25-1936', '', '', '2065.00', '2025-02-21 10:04:55', '2025-02-21 10:09:27'),
(822, '364393000043746112', '24/25-1921', '', '', '2065.00', '2025-02-21 10:04:10', '2025-02-21 10:07:20'),
(823, '364393000043777078', '24-25/VW-0536', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(824, '364393000043777078', '24-25/VW-0536', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(825, '364393000043777078', '24-25/VW-0536', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(826, '364393000043777078', '24-25/VW-0536', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(827, '364393000043777078', '24-25/VW-0536', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(828, '364393000043777078', '24-25/VW-0536', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(829, '364393000043777078', '24-25/VW-0536', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(830, '364393000043777078', '24-25/VW-0536', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(831, '364393000043777078', '24-25/VW-0536', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(832, '364393000043777078', '24-25/VW-0536', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '505.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(833, '364393000043777078', '24-25/VW-0536', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(834, '364393000043777078', '24-25/VW-0536', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(835, '364393000043777078', '24-25/VW-0536', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(836, '364393000043777078', '24-25/VW-0536', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(837, '364393000043777078', '24-25/VW-0536', '364393000000080111', 'FP BW Bluegold Gel/5LT', '167.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(838, '364393000043777078', '24-25/VW-0536', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(839, '364393000043777078', '24-25/VW-0536', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(840, '364393000043777078', '24-25/VW-0536', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '110.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(841, '364393000043777078', '24-25/VW-0536', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(842, '364393000043777078', '24-25/VW-0536', '364393000000080091', 'FP BW Zyme-B/500GM', '300.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(843, '364393000043777078', '24-25/VW-0536', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '600.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(844, '364393000043777078', '24-25/VW-0536', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(845, '364393000043777078', '24-25/VW-0536', '364393000000079775', 'FP BW Viracon-S/500GM', '238.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(846, '364393000043777078', '24-25/VW-0536', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(847, '364393000043777078', '24-25/VW-0536', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(848, '364393000043777078', '24-25/VW-0536', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(849, '364393000043777078', '24-25/VW-0536', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(850, '364393000043777078', '24-25/VW-0536', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(851, '364393000043777078', '24-25/VW-0536', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(852, '364393000043777078', '24-25/VW-0536', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(853, '364393000043777078', '24-25/VW-0536', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(854, '364393000043777078', '24-25/VW-0536', '364393000000080091', 'FP BW Zyme-B/500GM', '300.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(855, '364393000043777078', '24-25/VW-0536', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(856, '364393000043777078', '24-25/VW-0536', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(857, '364393000043777078', '24-25/VW-0536', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(858, '364393000043777078', '24-25/VW-0536', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(859, '364393000043777078', '24-25/VW-0536', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(860, '364393000043777078', '24-25/VW-0536', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(861, '364393000043777078', '24-25/VW-0536', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(862, '364393000043777078', '24-25/VW-0536', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(863, '364393000043777078', '24-25/VW-0536', '364393000000079741', 'FP BW Abolish/1KG', '184.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(864, '364393000043777078', '24-25/VW-0536', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(865, '364393000043777078', '24-25/VW-0536', '364393000003361471', 'FP BW Snail Blast/1KG', '800.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(866, '364393000043777078', '24-25/VW-0536', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(867, '364393000043777078', '24-25/VW-0536', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-02-21 07:16:09', '2025-02-21 07:16:32'),
(868, '364393000043777029', '24-25/VW-0535', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(869, '364393000043777029', '24-25/VW-0535', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(870, '364393000043777029', '24-25/VW-0535', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.48', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(871, '364393000043777029', '24-25/VW-0535', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(872, '364393000043777029', '24-25/VW-0535', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(873, '364393000043777029', '24-25/VW-0535', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(874, '364393000043777029', '24-25/VW-0535', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(875, '364393000043777029', '24-25/VW-0535', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(876, '364393000043777029', '24-25/VW-0535', '364393000000079473', 'FP BW Iodoshine 20%/1LT', '694.07', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(877, '364393000043777029', '24-25/VW-0535', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-02-21 06:35:37', '2025-02-21 07:17:04'),
(878, '364393000043755011', '418', '', '', '11800.00', '2025-02-20 05:34:27', '2025-02-21 07:18:51'),
(879, '364393000043721045', 'BW24/25-0047', '364393000000928052', 'FP BW T-SMASH/20KG', '1700.00', '2025-02-19 09:48:39', '2025-02-24 06:29:25'),
(880, '364393000043609438', 'C37E242500068577', '', '', '5870.50', '2025-02-18 08:29:42', '2025-02-18 08:29:52'),
(881, '364393000043609369', 'C37E242500052147', '', '', '5870.50', '2025-02-18 08:28:17', '2025-02-18 08:28:26'),
(882, '364393000043616271', '1088454578', '', '', '4840.00', '2025-02-17 06:05:54', '2025-02-17 06:11:47'),
(883, '364393000043653471', '21054833', '', '', '313.65', '2025-02-17 06:04:12', '2025-02-27 08:47:38'),
(884, '364393000043616229', '2024-25/234', '', '', '10584.00', '2025-02-17 05:51:38', '2025-02-18 04:09:03'),
(885, '364393000043601723', '24-25/VW-0532', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(886, '364393000043601723', '24-25/VW-0532', '364393000000079455', 'FP BW Dr. Green-X/1LT', '84.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(887, '364393000043601723', '24-25/VW-0532', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(888, '364393000043601723', '24-25/VW-0532', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(889, '364393000043601723', '24-25/VW-0532', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(890, '364393000043601723', '24-25/VW-0532', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(891, '364393000043601723', '24-25/VW-0532', '364393000000079741', 'FP BW Abolish/1KG', '184.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(892, '364393000043601723', '24-25/VW-0532', '364393000001811153', 'FP BW Bluesoft/5KG', '882.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(893, '364393000043601723', '24-25/VW-0532', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(894, '364393000043601723', '24-25/VW-0532', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(895, '364393000043601723', '24-25/VW-0532', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(896, '364393000043601723', '24-25/VW-0532', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(897, '364393000043601723', '24-25/VW-0532', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(898, '364393000043601723', '24-25/VW-0532', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '505.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(899, '364393000043601723', '24-25/VW-0532', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(900, '364393000043601723', '24-25/VW-0532', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(901, '364393000043601723', '24-25/VW-0532', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(902, '364393000043601723', '24-25/VW-0532', '364393000000079775', 'FP BW Viracon-S/500GM', '238.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(903, '364393000043601723', '24-25/VW-0532', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(904, '364393000043601723', '24-25/VW-0532', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(905, '364393000043601723', '24-25/VW-0532', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-02-15 05:18:24', '2025-02-15 05:20:23'),
(906, '364393000043601680', '24-25/VW-0531', '364393000000079433', 'FP BW Apex-6/5LT', '299.15', '2025-02-15 05:00:27', '2025-02-15 05:20:16'),
(907, '364393000043601680', '24-25/VW-0531', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-02-15 05:00:27', '2025-02-15 05:20:16'),
(908, '364393000043601680', '24-25/VW-0531', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-02-15 05:00:27', '2025-02-15 05:20:16'),
(909, '364393000043601680', '24-25/VW-0531', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-02-15 05:00:27', '2025-02-15 05:20:16'),
(910, '364393000043601680', '24-25/VW-0531', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-02-15 05:00:27', '2025-02-15 05:20:16'),
(911, '364393000043601680', '24-25/VW-0531', '364393000000715362', 'FP BW Oxybreeze/5KG', '508.47', '2025-02-15 05:00:27', '2025-02-15 05:20:16'),
(912, '364393000043601680', '24-25/VW-0531', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-02-15 05:00:27', '2025-02-15 05:20:16'),
(913, '364393000043601680', '24-25/VW-0531', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-02-15 05:00:27', '2025-02-15 05:20:16'),
(914, '364393000043394205', '24-25/VW-0485', '364393000027006179', 'FP BW ECOFRESH POWER PRO TABLETS 10KG', '3500.00', '2025-02-13 06:20:06', '2025-02-13 06:20:06'),
(915, '364393000043394205', '24-25/VW-0485', '364393000031243813', 'FP BW ECOFRESH POWER PRO TABLETS 5KG', '2900.00', '2025-02-13 06:20:06', '2025-02-13 06:20:06'),
(916, '364393000043394205', '24-25/VW-0485', '364393000039148086', 'FP BW ABOLISH 5KG', '1200.00', '2025-02-13 06:20:06', '2025-02-13 06:20:06'),
(917, '364393000043397419', '3133177579', '', '', '430.00', '2025-02-12 11:33:28', '2025-02-17 05:45:14'),
(918, '364393000043397255', '3231', '', '', '73490.00', '2025-02-12 11:26:27', '2025-02-12 11:37:53'),
(919, '364393000043424073', '24-25/VW-0530', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(920, '364393000043424073', '24-25/VW-0530', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(921, '364393000043424073', '24-25/VW-0530', '364393000000079749', 'FP BW Cut-PH/1KG', '98.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(922, '364393000043424073', '24-25/VW-0530', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(923, '364393000043424073', '24-25/VW-0530', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(924, '364393000043424073', '24-25/VW-0530', '364393000000080091', 'FP BW Zyme-B/500GM', '300.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(925, '364393000043424073', '24-25/VW-0530', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(926, '364393000043424073', '24-25/VW-0530', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '600.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(927, '364393000043424073', '24-25/VW-0530', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(928, '364393000043424073', '24-25/VW-0530', '364393000000283116', 'FP BW Proclarify-9/1KG', '322.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(929, '364393000043424073', '24-25/VW-0530', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(930, '364393000043424073', '24-25/VW-0530', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(931, '364393000043424073', '24-25/VW-0530', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(932, '364393000043424073', '24-25/VW-0530', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(933, '364393000043424073', '24-25/VW-0530', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(934, '364393000043424073', '24-25/VW-0530', '364393000000080119', 'FP BW Provitagel-BW/20LT', '975.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(935, '364393000043424073', '24-25/VW-0530', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-02-12 06:25:01', '2025-02-12 06:25:05'),
(936, '364393000043424015', '24-25/VW-0529', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-02-12 06:13:08', '2025-02-12 06:13:19'),
(937, '364393000043397097', 'T25020886', '', '', '364.00', '2025-02-12 05:55:42', '2025-02-12 05:58:34'),
(938, '364393000043397033', 'T25020885', '', '', '228161.00', '2025-02-12 05:46:41', '2025-02-12 05:58:34'),
(939, '364393000043365538', '24-25/VW-0528', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-02-11 05:25:56', '2025-02-11 05:28:37'),
(940, '364393000043365538', '24-25/VW-0528', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-02-11 05:25:56', '2025-02-11 05:28:37'),
(941, '364393000043365538', '24-25/VW-0528', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-11 05:25:56', '2025-02-11 05:28:37'),
(942, '364393000043365538', '24-25/VW-0528', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-02-11 05:25:56', '2025-02-11 05:28:37'),
(943, '364393000043365538', '24-25/VW-0528', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-11 05:25:56', '2025-02-11 05:28:37'),
(944, '364393000043365538', '24-25/VW-0528', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-02-11 05:25:56', '2025-02-11 05:28:37'),
(945, '364393000043365538', '24-25/VW-0528', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-11 05:25:56', '2025-02-11 05:28:37'),
(946, '364393000043365538', '24-25/VW-0528', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-11 05:25:56', '2025-02-11 05:28:37'),
(947, '364393000043365493', '24-25/VW-0527', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-02-11 05:17:28', '2025-02-11 05:28:33'),
(948, '364393000043365493', '24-25/VW-0527', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-02-11 05:17:28', '2025-02-11 05:28:33'),
(949, '364393000043365493', '24-25/VW-0527', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-02-11 05:17:28', '2025-02-11 05:28:33'),
(950, '364393000043365493', '24-25/VW-0527', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-02-11 05:17:28', '2025-02-11 05:28:33'),
(951, '364393000043281013', 'SAPR25001853264', '', '', '1769.00', '2025-02-08 09:37:35', '2025-02-18 04:09:07'),
(952, '364393000043258132', '2425/NCL/2229', '', '', '70800.00', '2025-02-08 06:03:17', '2025-02-08 06:07:33'),
(953, '364393000043242807', '24-25/VW-0526', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(954, '364393000043242807', '24-25/VW-0526', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(955, '364393000043242807', '24-25/VW-0526', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(956, '364393000043242807', '24-25/VW-0526', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(957, '364393000043242807', '24-25/VW-0526', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(958, '364393000043242807', '24-25/VW-0526', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(959, '364393000043242807', '24-25/VW-0526', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(960, '364393000043242807', '24-25/VW-0526', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(961, '364393000043242807', '24-25/VW-0526', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(962, '364393000043242807', '24-25/VW-0526', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '110.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(963, '364393000043242807', '24-25/VW-0526', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(964, '364393000043242807', '24-25/VW-0526', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(965, '364393000043242807', '24-25/VW-0526', '364393000000079733', 'FP BW D-300/25KG', '145.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(966, '364393000043242807', '24-25/VW-0526', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(967, '364393000043242807', '24-25/VW-0526', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(968, '364393000043242807', '24-25/VW-0526', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '505.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(969, '364393000043242807', '24-25/VW-0526', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(970, '364393000043242807', '24-25/VW-0526', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(971, '364393000043242807', '24-25/VW-0526', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(972, '364393000043242807', '24-25/VW-0526', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(973, '364393000043242807', '24-25/VW-0526', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(974, '364393000043242807', '24-25/VW-0526', '364393000000079771', 'FP BW Ammofree 99/1LT', '250.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(975, '364393000043242807', '24-25/VW-0526', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(976, '364393000043242807', '24-25/VW-0526', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-02-07 08:31:03', '2025-02-07 08:33:23'),
(977, '364393000043242770', '24-25/VW-0525', '364393000000079433', 'FP BW Apex-6/5LT', '299.15', '2025-02-07 06:24:07', '2025-02-07 08:33:05'),
(978, '364393000043242770', '24-25/VW-0525', '364393000000079471', 'FP BW Iodoshine 2%/20LT', '1044.07', '2025-02-07 06:24:07', '2025-02-07 08:33:05'),
(979, '364393000043242770', '24-25/VW-0525', '364393000000079473', 'FP BW Iodoshine 20%/1LT', '694.07', '2025-02-07 06:24:07', '2025-02-07 08:33:05'),
(980, '364393000043242770', '24-25/VW-0525', '364393000000079431', 'FP BW Apex-6/1LT', '72.03', '2025-02-07 06:24:07', '2025-02-07 08:33:05'),
(981, '364393000043171229', '24-25/VW-0522', '364393000000080111', 'FP BW Bluegold Gel/5LT', '167.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(982, '364393000043171229', '24-25/VW-0522', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(983, '364393000043171229', '24-25/VW-0522', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(984, '364393000043171229', '24-25/VW-0522', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(985, '364393000043171229', '24-25/VW-0522', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(986, '364393000043171229', '24-25/VW-0522', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '110.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(987, '364393000043171229', '24-25/VW-0522', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(988, '364393000043171229', '24-25/VW-0522', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(989, '364393000043171229', '24-25/VW-0522', '364393000000079785', 'FP BW Argocure/1L', '1.20', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(990, '364393000043171229', '24-25/VW-0522', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(991, '364393000043171229', '24-25/VW-0522', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(992, '364393000043171229', '24-25/VW-0522', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(993, '364393000043171229', '24-25/VW-0522', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(994, '364393000043171229', '24-25/VW-0522', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(995, '364393000043171229', '24-25/VW-0522', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(996, '364393000043171229', '24-25/VW-0522', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(997, '364393000043171229', '24-25/VW-0522', '364393000000079785', 'FP BW Argocure/1L', '1.20', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(998, '364393000043171229', '24-25/VW-0522', '364393000000079459', 'FP BW Dr Green-X/20LT', '1440.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(999, '364393000043171229', '24-25/VW-0522', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1000, '364393000043171229', '24-25/VW-0522', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1001, '364393000043171229', '24-25/VW-0522', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1002, '364393000043171229', '24-25/VW-0522', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1003, '364393000043171229', '24-25/VW-0522', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '110.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1004, '364393000043171229', '24-25/VW-0522', '364393000000080091', 'FP BW Zyme-B/500GM', '300.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1005, '364393000043171229', '24-25/VW-0522', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1006, '364393000043171229', '24-25/VW-0522', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1007, '364393000043171229', '24-25/VW-0522', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1008, '364393000043171229', '24-25/VW-0522', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '1800.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1009, '364393000043171229', '24-25/VW-0522', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1010, '364393000043171229', '24-25/VW-0522', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1011, '364393000043171229', '24-25/VW-0522', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1012, '364393000043171229', '24-25/VW-0522', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1013, '364393000043171229', '24-25/VW-0522', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-02-06 05:18:58', '2025-02-06 05:19:09'),
(1014, '364393000043171178', '24-25/VW-0521', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1015, '364393000043171178', '24-25/VW-0521', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1016, '364393000043171178', '24-25/VW-0521', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1017, '364393000043171178', '24-25/VW-0521', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1018, '364393000043171178', '24-25/VW-0521', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1019, '364393000043171178', '24-25/VW-0521', '364393000000079471', 'FP BW Iodoshine 2%/20LT', '1044.07', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1020, '364393000043171178', '24-25/VW-0521', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1021, '364393000043171178', '24-25/VW-0521', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1022, '364393000043171178', '24-25/VW-0521', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1023, '364393000043171178', '24-25/VW-0521', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-02-06 05:04:21', '2025-02-06 05:19:23'),
(1024, '364393000043111552', 'MD-DEC-41', '', '', '11070.00', '2025-02-05 12:04:12', '2025-02-05 12:04:29'),
(1025, '364393000043111439', 'MD-JAN-46', '', '', '18550.00', '2025-02-05 11:59:46', '2025-02-05 12:01:36'),
(1026, '364393000043111439', 'MD-JAN-46', '', '', '4800.00', '2025-02-05 11:59:46', '2025-02-05 12:01:36'),
(1027, '364393000042978415', '21', '', '', '10950.00', '2025-02-04 10:42:41', '2025-02-04 10:50:56'),
(1028, '364393000042978383', '19', '', '', '10950.00', '2025-02-04 10:41:11', '2025-02-04 10:49:30'),
(1029, '364393000042978351', '18', '', '', '14802.00', '2025-02-04 10:40:35', '2025-02-04 10:47:47'),
(1030, '364393000042978319', '17', '', '', '7400.00', '2025-02-04 10:39:54', '2025-02-04 10:46:31'),
(1031, '364393000042978177', 'BZA/24-25/1046', '', '', '56980.00', '2025-02-04 05:19:16', '2025-02-05 06:01:19'),
(1032, '364393000042956980', '12345', '', '', '50000.00', '2025-02-01 06:19:36', '2025-02-17 06:45:53'),
(1033, '364393000042918490', '302', '', '', '58400.00', '2025-02-01 06:04:02', '2025-02-03 04:25:29'),
(1034, '364393000042952462', '24-25/VW-0508', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1035, '364393000042952462', '24-25/VW-0508', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1036, '364393000042952462', '24-25/VW-0508', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1037, '364393000042952462', '24-25/VW-0508', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1038, '364393000042952462', '24-25/VW-0508', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1039, '364393000042952462', '24-25/VW-0508', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1040, '364393000042952462', '24-25/VW-0508', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1041, '364393000042952462', '24-25/VW-0508', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1042, '364393000042952462', '24-25/VW-0508', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1043, '364393000042952462', '24-25/VW-0508', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1044, '364393000042952462', '24-25/VW-0508', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1045, '364393000042952462', '24-25/VW-0508', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1046, '364393000042952462', '24-25/VW-0508', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1047, '364393000042952462', '24-25/VW-0508', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1048, '364393000042952462', '24-25/VW-0508', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1049, '364393000042952462', '24-25/VW-0508', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23');
INSERT INTO `bill_items` (`id`, `bill_id`, `bill_number`, `item_id`, `item_name`, `rate`, `created_at`, `updated_at`) VALUES
(1050, '364393000042952462', '24-25/VW-0508', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1051, '364393000042952462', '24-25/VW-0508', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1052, '364393000042952462', '24-25/VW-0508', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1053, '364393000042952462', '24-25/VW-0508', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1054, '364393000042952462', '24-25/VW-0508', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1055, '364393000042952462', '24-25/VW-0508', '364393000000283116', 'FP BW Proclarify-9/1KG', '322.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1056, '364393000042952462', '24-25/VW-0508', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1057, '364393000042952462', '24-25/VW-0508', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1058, '364393000042952462', '24-25/VW-0508', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1059, '364393000042952462', '24-25/VW-0508', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-02-01 05:20:51', '2025-02-01 05:21:23'),
(1060, '364393000042952426', '24-25/VW-0507', '364393000000079471', 'FP BW Iodoshine 2%/20LT', '1044.07', '2025-02-01 05:07:06', '2025-02-01 05:21:49'),
(1061, '364393000042952426', '24-25/VW-0507', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-02-01 05:07:06', '2025-02-01 05:21:49'),
(1062, '364393000042952426', '24-25/VW-0507', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-02-01 05:07:06', '2025-02-01 05:21:49'),
(1063, '364393000042952426', '24-25/VW-0507', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-02-01 05:07:06', '2025-02-01 05:21:49'),
(1064, '364393000042952426', '24-25/VW-0507', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-02-01 05:07:06', '2025-02-01 05:21:49'),
(1065, '364393000042918272', 'PTMT11068', '', '', '17600.00', '2025-02-01 04:41:18', '2025-02-01 04:43:36'),
(1066, '364393000042918083', 'T25012457', '', '', '128620.00', '2025-02-01 04:28:10', '2025-02-01 06:07:02'),
(1067, '364393000042928671', 'JAN-2025', '', '', '167000.00', '2025-01-31 10:39:35', '2025-02-06 06:04:09'),
(1068, '364393000042928175', '24-25/107', '', '', '51840.00', '2025-01-31 08:56:54', '2025-02-01 03:59:14'),
(1069, '364393000042823272', '24-25/VW-0500', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1070, '364393000042823272', '24-25/VW-0500', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1071, '364393000042823272', '24-25/VW-0500', '364393000000079455', 'FP BW Dr. Green-X/1LT', '84.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1072, '364393000042823272', '24-25/VW-0500', '364393000000079457', 'FP BW Dr. Green-X/5LT', '350.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1073, '364393000042823272', '24-25/VW-0500', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1074, '364393000042823272', '24-25/VW-0500', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1075, '364393000042823272', '24-25/VW-0500', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1076, '364393000042823272', '24-25/VW-0500', '364393000000080091', 'FP BW Zyme-B/500GM', '300.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1077, '364393000042823272', '24-25/VW-0500', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1078, '364393000042823272', '24-25/VW-0500', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1079, '364393000042823272', '24-25/VW-0500', '364393000003361471', 'FP BW Snail Blast/1KG', '800.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1080, '364393000042823272', '24-25/VW-0500', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1081, '364393000042823272', '24-25/VW-0500', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1082, '364393000042823272', '24-25/VW-0500', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1083, '364393000042823272', '24-25/VW-0500', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-30 05:30:26', '2025-01-31 04:55:10'),
(1084, '364393000042823248', '24-25/VW-0499', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-01-30 05:23:36', '2025-01-30 05:31:44'),
(1085, '364393000042740101', '1806', '', '', '20178.00', '2025-01-29 04:52:19', '2025-01-29 04:54:46'),
(1086, '364393000042740049', 'C-4190/24-25', '', '', '13570.00', '2025-01-29 04:48:14', '2025-01-29 04:53:44'),
(1087, '364393000042665458', '24-25/VW-0496', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1088, '364393000042665458', '24-25/VW-0496', '364393000000080091', 'FP BW Zyme-B/500GM', '300.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1089, '364393000042665458', '24-25/VW-0496', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1090, '364393000042665458', '24-25/VW-0496', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1091, '364393000042665458', '24-25/VW-0496', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1092, '364393000042665458', '24-25/VW-0496', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1093, '364393000042665458', '24-25/VW-0496', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1094, '364393000042665458', '24-25/VW-0496', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1095, '364393000042665458', '24-25/VW-0496', '364393000001811153', 'FP BW Bluesoft/5KG', '882.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1096, '364393000042665458', '24-25/VW-0496', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1097, '364393000042665458', '24-25/VW-0496', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1098, '364393000042665458', '24-25/VW-0496', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1099, '364393000042665458', '24-25/VW-0496', '364393000004732306', 'FP BW CYANO-L/5LT', '225.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1100, '364393000042665458', '24-25/VW-0496', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1101, '364393000042665458', '24-25/VW-0496', '364393000000079459', 'FP BW Dr Green-X/20LT', '1440.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1102, '364393000042665458', '24-25/VW-0496', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1103, '364393000042665458', '24-25/VW-0496', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1104, '364393000042665458', '24-25/VW-0496', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1105, '364393000042665458', '24-25/VW-0496', '364393000000382001', 'FP BW Cyano Pro/1KG', '826.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1106, '364393000042665458', '24-25/VW-0496', '364393000000080091', 'FP BW Zyme-B/500GM', '300.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1107, '364393000042665458', '24-25/VW-0496', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1108, '364393000042665458', '24-25/VW-0496', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1109, '364393000042665458', '24-25/VW-0496', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1110, '364393000042665458', '24-25/VW-0496', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1111, '364393000042665458', '24-25/VW-0496', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1112, '364393000042665458', '24-25/VW-0496', '364393000003361471', 'FP BW Snail Blast/1KG', '800.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1113, '364393000042665458', '24-25/VW-0496', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1114, '364393000042665458', '24-25/VW-0496', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1115, '364393000042665458', '24-25/VW-0496', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1116, '364393000042665458', '24-25/VW-0496', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1117, '364393000042665458', '24-25/VW-0496', '364393000000080119', 'FP BW Provitagel-BW/20LT', '975.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1118, '364393000042665458', '24-25/VW-0496', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1119, '364393000042665458', '24-25/VW-0496', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1120, '364393000042665458', '24-25/VW-0496', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1121, '364393000042665458', '24-25/VW-0496', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1122, '364393000042665458', '24-25/VW-0496', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-01-27 06:47:02', '2025-01-28 06:17:00'),
(1123, '364393000042665436', '24-25/VW-0495', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-01-27 06:34:24', '2025-01-28 06:06:54'),
(1124, '364393000042665436', '24-25/VW-0495', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-01-27 06:34:24', '2025-01-28 06:06:54'),
(1125, '364393000042614063', 'BW24/25-0046', '364393000000928052', 'FP BW T-SMASH/20KG', '1700.00', '2025-01-25 06:03:42', '2025-01-25 06:03:53'),
(1126, '364393000042614007', 'BW24/25-0045', '364393000000928052', 'FP BW T-SMASH/20KG', '1700.00', '2025-01-25 06:02:50', '2025-01-25 06:03:02'),
(1127, '364393000042521087', '24-25/VW-0491', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1128, '364393000042521087', '24-25/VW-0491', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1129, '364393000042521087', '24-25/VW-0491', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1130, '364393000042521087', '24-25/VW-0491', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1131, '364393000042521087', '24-25/VW-0491', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1132, '364393000042521087', '24-25/VW-0491', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1133, '364393000042521087', '24-25/VW-0491', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1134, '364393000042521087', '24-25/VW-0491', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1135, '364393000042521087', '24-25/VW-0491', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1136, '364393000042521087', '24-25/VW-0491', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1137, '364393000042521087', '24-25/VW-0491', '364393000000079741', 'FP BW Abolish/1KG', '184.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1138, '364393000042521087', '24-25/VW-0491', '364393000000079739', 'FP BW Abolish/500GM', '110.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1139, '364393000042521087', '24-25/VW-0491', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1140, '364393000042521087', '24-25/VW-0491', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1141, '364393000042521087', '24-25/VW-0491', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '110.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1142, '364393000042521087', '24-25/VW-0491', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1143, '364393000042521087', '24-25/VW-0491', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1144, '364393000042521087', '24-25/VW-0491', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1145, '364393000042521087', '24-25/VW-0491', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1146, '364393000042521087', '24-25/VW-0491', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '505.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1147, '364393000042521087', '24-25/VW-0491', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1148, '364393000042521087', '24-25/VW-0491', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1149, '364393000042521087', '24-25/VW-0491', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1150, '364393000042521087', '24-25/VW-0491', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1151, '364393000042521087', '24-25/VW-0491', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-01-24 05:04:17', '2025-01-24 05:05:14'),
(1152, '364393000042521056', '24-25/VW-0490', '364393000000079797', 'FP BW Oxybrix-T/1KG', '92.00', '2025-01-24 04:49:28', '2025-01-24 05:05:18'),
(1153, '364393000042521056', '24-25/VW-0490', '364393000000079799', 'FP BW Oxybrix-T/5KG', '304.24', '2025-01-24 04:49:28', '2025-01-24 05:05:18'),
(1154, '364393000042521056', '24-25/VW-0490', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-01-24 04:49:28', '2025-01-24 05:05:18'),
(1155, '364393000042521056', '24-25/VW-0490', '364393000000079791', 'FP BW Oxybreeze/1KG', '101.70', '2025-01-24 04:49:28', '2025-01-24 05:05:18'),
(1156, '364393000042367258', 'ME/24-25/2659', '', '', '3220.00', '2025-01-21 12:14:03', '2025-01-21 12:15:25'),
(1157, '364393000042367140', '2777', '', '', '67850.00', '2025-01-21 04:45:13', '2025-02-01 03:59:06'),
(1158, '364393000042367051', '0070', '', '', '8960.63', '2025-01-21 04:23:09', '2025-03-10 06:40:09'),
(1159, '364393000042352185', '24-25/VW-0489', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1160, '364393000042352185', '24-25/VW-0489', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1161, '364393000042352185', '24-25/VW-0489', '364393000000079767', 'FP BW Super Probes-PS/5LT', '180.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1162, '364393000042352185', '24-25/VW-0489', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1163, '364393000042352185', '24-25/VW-0489', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1164, '364393000042352185', '24-25/VW-0489', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1165, '364393000042352185', '24-25/VW-0489', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1166, '364393000042352185', '24-25/VW-0489', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1167, '364393000042352185', '24-25/VW-0489', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1168, '364393000042352185', '24-25/VW-0489', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1169, '364393000042352185', '24-25/VW-0489', '364393000001189173', 'FP BW Ecofresh/10KG', '458.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1170, '364393000042352185', '24-25/VW-0489', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1171, '364393000042352185', '24-25/VW-0489', '364393000000757321', 'FP BW Livertreat-XL 2KG', '255.00', '2025-01-20 11:16:13', '2025-01-20 11:16:40'),
(1172, '364393000042332349', 'DEC-2024', '', '', '167000.00', '2025-01-20 06:56:58', '2025-01-21 11:13:11'),
(1173, '364393000042332311', 'NOV-2024', '', '', '155000.00', '2025-01-20 06:56:04', '2025-01-21 11:13:11'),
(1174, '364393000042313221', 'OCT-2024', '', '', '155000.00', '2025-01-18 05:51:13', '2025-01-21 11:13:11'),
(1175, '364393000042245011', 'HLPL/24-25/911A', '', '', '46020.00', '2025-01-17 04:25:32', '2025-01-17 04:29:03'),
(1176, '364393000042084312', '24-25/VW-0488', '364393000000079743', 'FP BW Bluesoft/1KG', '205.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1177, '364393000042084312', '24-25/VW-0488', '364393000000079781', 'FP BW K-Blue/10KG', '390.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1178, '364393000042084312', '24-25/VW-0488', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1179, '364393000042084312', '24-25/VW-0488', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1180, '364393000042084312', '24-25/VW-0488', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1181, '364393000042084312', '24-25/VW-0488', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1182, '364393000042084312', '24-25/VW-0488', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1183, '364393000042084312', '24-25/VW-0488', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1184, '364393000042084312', '24-25/VW-0488', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1185, '364393000042084312', '24-25/VW-0488', '364393000000079459', 'FP BW Dr Green-X/20LT', '1440.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1186, '364393000042084312', '24-25/VW-0488', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1187, '364393000042084312', '24-25/VW-0488', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1188, '364393000042084312', '24-25/VW-0488', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1189, '364393000042084312', '24-25/VW-0488', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1190, '364393000042084312', '24-25/VW-0488', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1191, '364393000042084312', '24-25/VW-0488', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1192, '364393000042084312', '24-25/VW-0488', '364393000000079737', 'FP BW Odosweep/500GM', '202.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1193, '364393000042084312', '24-25/VW-0488', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1194, '364393000042084312', '24-25/VW-0488', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1195, '364393000042084312', '24-25/VW-0488', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1196, '364393000042084312', '24-25/VW-0488', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1197, '364393000042084312', '24-25/VW-0488', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-01-11 10:23:46', '2025-01-11 10:24:05'),
(1198, '364393000042053045', 'SAPR25001515033', '', '', '1769.00', '2025-01-11 07:13:22', '2025-01-18 03:52:02'),
(1199, '364393000042006398', '24-25/VW-0487', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1200, '364393000042006398', '24-25/VW-0487', '364393000000079785', 'FP BW Argocure/1L', '1.20', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1201, '364393000042006398', '24-25/VW-0487', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1202, '364393000042006398', '24-25/VW-0487', '364393000000080119', 'FP BW Provitagel-BW/20LT', '975.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1203, '364393000042006398', '24-25/VW-0487', '364393000000080115', 'FP BW Provitagel-BW/5LT', '245.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1204, '364393000042006398', '24-25/VW-0487', '364393000000079735', 'FP BW Chill Zinc/1KG', '95.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1205, '364393000042006398', '24-25/VW-0487', '364393000000080105', 'FP BW Flourishmin-10KG', '219.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1206, '364393000042006398', '24-25/VW-0487', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1207, '364393000042006398', '24-25/VW-0487', '364393000000079741', 'FP BW Abolish/1KG', '184.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1208, '364393000042006398', '24-25/VW-0487', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1209, '364393000042006398', '24-25/VW-0487', '364393000000079731', 'FP BW Zeoweight/25KG', '150.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1210, '364393000042006398', '24-25/VW-0487', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1211, '364393000042006398', '24-25/VW-0487', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1212, '364393000042006398', '24-25/VW-0487', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1213, '364393000042006398', '24-25/VW-0487', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1214, '364393000042006398', '24-25/VW-0487', '364393000000080119', 'FP BW Provitagel-BW/20LT', '975.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1215, '364393000042006398', '24-25/VW-0487', '364393000001436852', 'FP BW Citrix-100/5KG', '5035.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1216, '364393000042006398', '24-25/VW-0487', '364393000001436723', 'FP BW Megastaminizer/5KG', '1000.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1217, '364393000042006398', '24-25/VW-0487', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1218, '364393000042006398', '24-25/VW-0487', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1219, '364393000042006398', '24-25/VW-0487', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1220, '364393000042006398', '24-25/VW-0487', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1221, '364393000042006398', '24-25/VW-0487', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1222, '364393000042006398', '24-25/VW-0487', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1223, '364393000042006398', '24-25/VW-0487', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1224, '364393000042006398', '24-25/VW-0487', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '170.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1225, '364393000042006398', '24-25/VW-0487', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '656.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1226, '364393000042006398', '24-25/VW-0487', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1227, '364393000042006398', '24-25/VW-0487', '364393000000080093', 'FP BW Citrix-100/500GM', '475.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1228, '364393000042006398', '24-25/VW-0487', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1229, '364393000042006398', '24-25/VW-0487', '364393000000485153', 'FP BW GUTGOLD 1KG', '185.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1230, '364393000042006398', '24-25/VW-0487', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '600.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1231, '364393000042006398', '24-25/VW-0487', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '200.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1232, '364393000042006398', '24-25/VW-0487', '364393000000927001', 'FP BW Bluegold Gel/17LT', '490.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1233, '364393000042006398', '24-25/VW-0487', '364393000000906039', 'FP BW Dominator XL/5LT', '655.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1234, '364393000042006398', '24-25/VW-0487', '364393000005077887', 'FP BW Dominator-XL 20LT', '2596.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1235, '364393000042006398', '24-25/VW-0487', '364393000000080119', 'FP BW Provitagel-BW/20LT', '975.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1236, '364393000042006398', '24-25/VW-0487', '364393000000079769', 'FP BW Super Probes-PS/20LT', '650.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1237, '364393000042006398', '24-25/VW-0487', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '2640.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1238, '364393000042006398', '24-25/VW-0487', '364393000000715251', 'FP BW Growmin BW+/10KG', '237.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1239, '364393000042006398', '24-25/VW-0487', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '200.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1240, '364393000042006398', '24-25/VW-0487', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '360.00', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1241, '364393000042006398', '24-25/VW-0487', '364393000000964020', 'FP CASB WSP1/1K', '0.32', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1242, '364393000042006398', '24-25/VW-0487', '364393000000964063', 'FP CASB WSP2/1K', '0.38', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1243, '364393000042006398', '24-25/VW-0487', '364393000000964106', 'FP CASB WSP3/1K', '0.16', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1244, '364393000042006398', '24-25/VW-0487', '364393000000964149', 'FP CASB WSP4/1KG', '0.30', '2025-01-10 10:48:15', '2025-01-10 10:48:20'),
(1245, '364393000042006361', '24-25/VW-0486', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-01-10 10:23:57', '2025-01-10 10:48:23'),
(1246, '364393000042006361', '24-25/VW-0486', '364393000000079487', 'FP BW FOT 37/5LT', '172.03', '2025-01-10 10:23:57', '2025-01-10 10:48:23'),
(1247, '364393000042006361', '24-25/VW-0486', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-01-10 10:23:57', '2025-01-10 10:48:23'),
(1248, '364393000042006361', '24-25/VW-0486', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '63.56', '2025-01-10 10:23:57', '2025-01-10 10:48:23'),
(1249, '364393000042006361', '24-25/VW-0486', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '281.36', '2025-01-10 10:23:57', '2025-01-10 10:48:23'),
(1250, '364393000042006361', '24-25/VW-0486', '364393000000079489', 'FP BW FOT 37/20LT', '593.22', '2025-01-10 10:23:57', '2025-01-10 10:48:23'),
(1251, '364393000041996045', '24/25-1673', '', '', '637.00', '2025-01-10 10:07:15', '2025-02-18 04:08:47'),
(1252, '364393000041996015', '24/25-1672', '', '', '4307.00', '2025-01-10 10:06:34', '2025-02-18 04:08:47');

-- --------------------------------------------------------

--
-- Table structure for table `bill_of_materials`
--

CREATE TABLE `bill_of_materials` (
  `id` int(11) NOT NULL,
  `bill_of_materials_id` varchar(50) DEFAULT NULL,
  `item_id` varchar(50) NOT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `description` text,
  `date_time` datetime DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `cost_each` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bill_of_materials`
--

INSERT INTO `bill_of_materials` (`id`, `bill_of_materials_id`, `item_id`, `item_name`, `description`, `date_time`, `type`, `quantity`, `cost_each`, `total`, `created_at`) VALUES
(1, '364393000046650231', '364393000046638449', 'Raw1', NULL, NULL, NULL, 10, 70, 700, '2025-05-05 05:00:29'),
(2, '364393000046650231', '364393000046638510', 'Raw2', NULL, NULL, NULL, 20, 60, 1200, '2025-05-05 05:00:29'),
(50, '364393000045713031', '364393000046638449', 'Raw1', NULL, NULL, NULL, 2, 70, 140, '2025-05-23 07:39:10'),
(51, '364393000045713031', '364393000046638510', 'Raw2', NULL, NULL, NULL, 10, 80, 800, '2025-05-23 07:39:10'),
(52, '364393000001022004', '364393000046638449', 'Raw1', NULL, NULL, NULL, 111, 70, 7770, '2025-05-23 10:29:48'),
(53, '364393000001022004', '364393000046638510', 'Raw2', NULL, NULL, NULL, 12, 80, 960, '2025-05-23 10:29:48'),
(54, '364393000000975452', '364393000046638449', 'Raw1', NULL, NULL, NULL, 11, 70, 770, '2025-05-23 10:36:16'),
(55, '364393000000975452', '364393000046638510', 'Raw2', NULL, NULL, NULL, 12, 80, 960, '2025-05-23 10:36:16'),
(56, '364393000046944070', '364393000046638449', 'Raw1', NULL, NULL, NULL, 1, 70, 70, '2025-05-23 10:40:45'),
(57, '364393000046944070', '364393000046638510', 'Raw2', NULL, NULL, NULL, 1, 80, 80, '2025-05-23 10:40:45'),
(62, '364393000047708239', '364393000046638449', 'Raw1', NULL, NULL, NULL, 12, 70, 840, '2025-05-26 04:33:40'),
(63, '364393000047708239', '364393000046638510', 'Raw2', NULL, NULL, NULL, 11, 80, 880, '2025-05-26 04:33:40'),
(64, '364393000047708239', '364393000001022004', 'Test Item1', NULL, NULL, NULL, 19, 15, 285, '2025-05-26 04:33:40'),
(65, '364393000046388556', '364393000045973217', 'RPX Dolomite Powder Export Quality', NULL, NULL, NULL, 500, 1.6, 800, '2025-05-26 06:14:33'),
(66, '364393000046388556', '364393000045977864', 'RPX Magnesium Sulphate', NULL, NULL, NULL, 100, 16.75, 1675, '2025-05-26 06:14:33'),
(79, '364393000000906511', '364393000046638449', 'Raw1', NULL, NULL, NULL, 0.1, 70, 7000, '2025-06-07 06:11:24'),
(80, '364393000000906511', '364393000047524298', 'Argocure 500 ml', NULL, NULL, NULL, 123, 250, 30750000, '2025-06-07 06:11:24'),
(81, '364393000000906511', '364393000000906511', 'BAGS Zeoweight', NULL, NULL, NULL, 123, 0, 0, '2025-06-07 06:11:24'),
(94, '364393000047524298', '364393000045713031', 'salt test', NULL, NULL, NULL, 2, 50, 100, '2025-07-03 06:21:20'),
(95, '364393000047524298', '364393000047524298', 'Argocure 500 ml', NULL, NULL, NULL, 0.2, 250, 50000, '2025-07-03 06:21:20'),
(96, '364393000047524298', '364393000000906511', 'BAGS Zeoweight', NULL, NULL, NULL, 1, 0, 0, '2025-07-03 06:21:20');

-- --------------------------------------------------------

--
-- Table structure for table `builds`
--

CREATE TABLE `builds` (
  `build_id` int(11) NOT NULL,
  `build_number` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `location` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `builds`
--

INSERT INTO `builds` (`build_id`, `build_number`, `date_time`, `location`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-05-05 10:31:00', 'Warehouse', '2025-05-05 05:05:43', '2025-05-05 05:05:43'),
(2, 2, '2025-05-05 13:38:00', 'Warehouse', '2025-05-05 08:08:08', '2025-05-05 08:08:08'),
(3, 3, '2025-05-05 13:43:00', 'Warehouse', '2025-05-05 08:13:45', '2025-05-05 08:13:45'),
(4, 4, '2025-05-05 13:47:00', 'Warehouse', '2025-05-05 08:18:04', '2025-05-05 08:18:04'),
(5, 5, '2025-05-05 13:49:00', 'Warehouse', '2025-05-05 08:19:45', '2025-05-05 08:19:45'),
(6, 6, '2025-05-05 13:50:00', 'Warehouse', '2025-05-05 08:20:25', '2025-05-05 08:20:25'),
(7, 7, '2025-05-05 13:54:00', 'Warehouse', '2025-05-05 08:24:58', '2025-05-05 08:24:58'),
(8, 8, '2025-05-05 13:58:00', 'Warehouse', '2025-05-05 08:28:34', '2025-05-05 08:28:34'),
(9, 9, '2025-05-05 13:59:00', 'Warehouse', '2025-05-05 08:29:38', '2025-05-05 08:29:38'),
(10, 10, '2025-05-05 14:04:00', 'Warehouse', '2025-05-05 08:34:38', '2025-05-05 08:34:38'),
(11, 11, '2025-05-05 14:14:00', 'Warehouse', '2025-05-05 08:44:37', '2025-05-05 08:44:37'),
(12, 12, '2025-05-05 15:17:00', 'Warehouse', '2025-05-05 09:47:30', '2025-05-05 09:47:30'),
(13, 13, '2025-05-05 15:19:00', 'Warehouse', '2025-05-05 09:49:47', '2025-05-05 09:49:47'),
(14, 14, '2025-05-05 15:25:00', 'Warehouse', '2025-05-05 09:55:16', '2025-05-05 09:55:16'),
(15, 15, '2025-05-05 15:26:00', 'Warehouse', '2025-05-05 09:56:21', '2025-05-05 09:56:21'),
(16, 16, '2025-05-05 16:43:00', 'Warehouse', '2025-05-05 11:13:55', '2025-05-05 11:13:55'),
(17, 17, '2025-05-07 22:23:00', 'Warehouse', '2025-05-07 16:54:20', '2025-05-07 16:54:20'),
(18, 18, '2025-05-07 22:28:00', 'Warehouse', '2025-05-07 16:58:34', '2025-05-07 16:58:34'),
(19, 19, '2025-05-07 22:39:00', 'Warehouse', '2025-05-07 17:09:45', '2025-05-07 17:09:45'),
(20, 20, '2025-05-08 09:12:00', 'Warehouse', '2025-05-08 03:42:15', '2025-05-08 03:42:15'),
(21, 21, '2025-05-08 11:08:00', 'Warehouse', '2025-05-08 05:38:51', '2025-05-08 05:38:51'),
(22, 22, '2025-05-08 11:27:00', 'Warehouse', '2025-05-08 05:57:50', '2025-05-08 05:57:50'),
(23, 23, '2025-05-08 11:29:00', 'Warehouse', '2025-05-08 06:00:10', '2025-05-08 06:00:10'),
(24, 24, '2025-05-08 11:32:00', 'Warehouse', '2025-05-08 06:02:26', '2025-05-08 06:02:26'),
(25, 25, '2025-05-08 11:37:00', 'Warehouse', '2025-05-08 06:07:36', '2025-05-08 06:07:36'),
(26, 26, '2025-05-08 11:38:00', 'Warehouse', '2025-05-08 06:10:23', '2025-05-08 06:10:23'),
(27, 27, '2025-05-12 09:42:00', 'Warehouse', '2025-05-12 04:12:48', '2025-05-12 04:12:48'),
(28, 28, '2025-05-12 09:44:00', 'Warehouse', '2025-05-12 04:14:38', '2025-05-12 04:14:38'),
(29, 29, '2025-05-12 10:02:00', 'Warehouse', '2025-05-12 04:32:15', '2025-05-12 04:32:15'),
(30, 30, '2025-05-12 10:36:00', 'Warehouse', '2025-05-12 05:04:20', '2025-05-12 05:06:37'),
(31, 31, '2025-05-13 11:23:00', 'Warehouse', '2025-05-13 05:53:48', '2025-05-13 05:53:48'),
(32, 32, '2025-05-13 12:44:00', 'Warehouse', '2025-05-13 07:14:47', '2025-05-13 07:14:47'),
(33, 33, '2025-05-13 15:36:00', 'Warehouse', '2025-05-13 10:06:41', '2025-05-13 10:06:41'),
(34, 34, '2025-05-13 15:39:00', 'Warehouse', '2025-05-13 10:09:55', '2025-05-13 10:09:55'),
(35, 35, '2025-05-13 15:42:00', 'Warehouse', '2025-05-13 10:12:58', '2025-05-13 10:12:58'),
(36, 36, '2025-05-13 15:52:00', 'Warehouse', '2025-05-13 10:22:47', '2025-05-13 10:22:47'),
(37, 37, '2025-05-13 15:55:00', 'Warehouse', '2025-05-13 10:25:27', '2025-05-13 10:25:27'),
(38, 38, '2025-05-14 16:49:00', 'Warehouse', '2025-05-14 11:15:46', '2025-05-14 11:19:31'),
(39, 39, '2025-05-18 15:22:00', 'Warehouse', '2025-05-18 09:52:35', '2025-05-18 09:52:35');

-- --------------------------------------------------------

--
-- Table structure for table `build_items`
--

CREATE TABLE `build_items` (
  `id` int(11) NOT NULL,
  `build_id` int(11) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `purchase_rate` float NOT NULL,
  `description` text,
  `stock_on_hand` int(11) DEFAULT '0',
  `stock_on_so` int(11) DEFAULT '0',
  `quantity_to_build` decimal(20,10) NOT NULL,
  `type` enum('input','output') NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `build_items`
--

INSERT INTO `build_items` (`id`, `build_id`, `item_id`, `item_name`, `rate`, `purchase_rate`, `description`, `stock_on_hand`, `stock_on_so`, `quantity_to_build`, `type`, `created_at`, `updated_at`) VALUES
(1, 5, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'output', '2025-05-05 08:19:45', '2025-05-05 08:19:45'),
(2, 5, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-05 08:19:47', '2025-05-05 08:19:47'),
(3, 5, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-05 08:19:50', '2025-05-05 08:19:50'),
(4, 6, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '2.0000000000', 'output', '2025-05-05 08:20:25', '2025-05-05 08:20:25'),
(5, 6, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-05 08:20:28', '2025-05-05 08:20:28'),
(6, 6, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '40.0000000000', 'input', '2025-05-05 08:20:31', '2025-05-05 08:20:31'),
(7, 7, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-05 08:24:58', '2025-05-05 08:24:58'),
(8, 7, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-05 08:25:01', '2025-05-05 08:25:01'),
(9, 7, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-05 08:25:04', '2025-05-05 08:25:04'),
(10, 8, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-05 08:28:34', '2025-05-05 08:28:34'),
(11, 8, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-05 08:28:37', '2025-05-05 08:28:37'),
(12, 8, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-05 08:28:39', '2025-05-05 08:28:39'),
(13, 9, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-05 08:29:38', '2025-05-05 08:29:38'),
(14, 9, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-05 08:29:40', '2025-05-05 08:29:40'),
(15, 9, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-05 08:29:43', '2025-05-05 08:29:43'),
(16, 10, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-05 08:34:38', '2025-05-05 08:34:38'),
(17, 10, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-05 08:34:40', '2025-05-05 08:34:40'),
(18, 10, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-05 08:34:43', '2025-05-05 08:34:43'),
(19, 11, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '2.0000000000', 'output', '2025-05-05 08:44:37', '2025-05-05 08:44:37'),
(20, 11, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-05 08:44:39', '2025-05-05 08:44:39'),
(21, 11, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '40.0000000000', 'input', '2025-05-05 08:44:42', '2025-05-05 08:44:42'),
(22, 12, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'output', '2025-05-05 09:47:30', '2025-05-05 09:47:30'),
(23, 12, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-05 09:47:33', '2025-05-05 09:47:33'),
(24, 12, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-05 09:47:36', '2025-05-05 09:47:36'),
(25, 13, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'output', '2025-05-05 09:49:47', '2025-05-05 09:49:47'),
(26, 13, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-05 09:49:52', '2025-05-05 09:49:52'),
(27, 13, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-05 09:49:54', '2025-05-05 09:49:54'),
(28, 14, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-05 09:55:16', '2025-05-05 09:55:16'),
(29, 14, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-05 09:55:19', '2025-05-05 09:55:19'),
(30, 14, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-05 09:55:23', '2025-05-05 09:55:23'),
(31, 15, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '2.0000000000', 'output', '2025-05-05 09:56:21', '2025-05-05 09:56:21'),
(32, 15, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-05 09:56:24', '2025-05-05 09:56:24'),
(33, 15, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '40.0000000000', 'input', '2025-05-05 09:56:26', '2025-05-05 09:56:26'),
(34, 16, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-05 11:13:55', '2025-05-05 11:13:55'),
(35, 16, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-05 11:13:58', '2025-05-05 11:13:58'),
(36, 16, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-05 11:14:00', '2025-05-05 11:14:00'),
(37, 18, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-07 16:58:34', '2025-05-07 16:58:34'),
(38, 18, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-07 16:58:36', '2025-05-07 16:58:36'),
(39, 18, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-07 16:58:38', '2025-05-07 16:58:38'),
(40, 19, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-07 17:09:45', '2025-05-07 17:09:45'),
(41, 19, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-07 17:09:47', '2025-05-07 17:09:47'),
(42, 19, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-07 17:09:49', '2025-05-07 17:09:49'),
(43, 20, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'output', '2025-05-08 03:42:15', '2025-05-08 03:42:15'),
(44, 20, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '100.0000000000', 'input', '2025-05-08 03:42:17', '2025-05-08 03:42:17'),
(45, 20, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '200.0000000000', 'input', '2025-05-08 03:42:19', '2025-05-08 03:42:19'),
(46, 21, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-08 05:38:51', '2025-05-08 05:38:51'),
(47, 21, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-08 05:38:53', '2025-05-08 05:38:53'),
(48, 21, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-08 05:38:55', '2025-05-08 05:38:55'),
(49, 22, '364393000046650231', 'Finished', NULL, 700, 'N/A', 0, 0, '0.0000000000', 'output', '2025-05-08 05:57:50', '2025-05-08 05:57:50'),
(50, 22, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-08 05:57:53', '2025-05-08 05:57:53'),
(51, 22, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-08 05:57:55', '2025-05-08 05:57:55'),
(52, 23, '364393000046650231', 'Finished', NULL, 700, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-08 06:00:10', '2025-05-08 06:00:10'),
(53, 23, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-08 06:00:12', '2025-05-08 06:00:12'),
(54, 23, '364393000046638510', 'Raw2', NULL, 0, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-08 06:00:14', '2025-05-08 06:00:14'),
(55, 24, '364393000046650231', 'Finished', NULL, 700, 'N/A', 0, 0, '0.0000000000', 'output', '2025-05-08 06:02:26', '2025-05-08 06:02:26'),
(56, 24, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-08 06:02:28', '2025-05-08 06:02:28'),
(57, 24, '364393000046638510', 'Raw2', NULL, 50, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-08 06:02:30', '2025-05-08 06:02:30'),
(58, 25, '364393000046650231', 'Finished', NULL, 700, 'N/A', 0, 0, '0.0000000000', 'output', '2025-05-08 06:07:36', '2025-05-08 06:07:36'),
(59, 25, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-08 06:07:38', '2025-05-08 06:07:38'),
(60, 25, '364393000046638510', 'Raw2', NULL, 50, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-08 06:07:40', '2025-05-08 06:07:40'),
(61, 26, '364393000046650231', 'Finished', NULL, 700, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-08 06:10:23', '2025-05-08 06:10:23'),
(62, 26, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '10.0000000000', 'input', '2025-05-08 06:10:25', '2025-05-08 06:10:25'),
(63, 26, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '20.0000000000', 'input', '2025-05-08 06:10:27', '2025-05-08 06:10:27'),
(64, 27, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-12 04:12:48', '2025-05-12 04:12:48'),
(65, 27, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-12 04:12:50', '2025-05-12 04:12:50'),
(66, 27, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-12 04:12:52', '2025-05-12 04:12:52'),
(67, 28, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '0.0000000000', 'output', '2025-05-12 04:14:38', '2025-05-12 04:14:38'),
(68, 28, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-12 04:14:40', '2025-05-12 04:14:40'),
(69, 28, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-12 04:14:42', '2025-05-12 04:14:42'),
(70, 29, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-12 04:32:15', '2025-05-12 04:32:15'),
(71, 29, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-12 04:32:19', '2025-05-12 04:32:19'),
(72, 29, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-12 04:32:22', '2025-05-12 04:32:22'),
(73, 31, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '0.0000000000', 'output', '2025-05-13 05:53:48', '2025-05-13 05:53:48'),
(74, 31, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-13 05:53:51', '2025-05-13 05:53:51'),
(75, 31, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.0000000000', 'input', '2025-05-13 05:53:54', '2025-05-13 05:53:54'),
(76, 32, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '5.0000000000', 'output', '2025-05-13 07:14:47', '2025-05-13 07:14:47'),
(77, 32, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '1.0000000000', 'input', '2025-05-13 07:14:49', '2025-05-13 07:14:49'),
(78, 32, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '1.0000000000', 'input', '2025-05-13 07:14:52', '2025-05-13 07:14:52'),
(79, 33, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '0.1234567890', 'output', '2025-05-13 10:06:41', '2025-05-13 10:06:41'),
(80, 33, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0200000000', 'input', '2025-05-13 10:06:43', '2025-05-13 10:06:43'),
(81, 33, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.0200000000', 'input', '2025-05-13 10:06:46', '2025-05-13 10:06:46'),
(82, 34, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '0.1234567890', 'output', '2025-05-13 10:09:55', '2025-05-13 10:09:55'),
(83, 34, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0200000000', 'input', '2025-05-13 10:09:59', '2025-05-13 10:09:59'),
(84, 34, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.0200000000', 'input', '2025-05-13 10:10:01', '2025-05-13 10:10:01'),
(85, 35, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '0.1234567890', 'output', '2025-05-13 10:12:58', '2025-05-13 10:12:58'),
(86, 35, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0200000000', 'input', '2025-05-13 10:13:00', '2025-05-13 10:13:00'),
(87, 35, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.0200000000', 'input', '2025-05-13 10:13:02', '2025-05-13 10:13:02'),
(88, 36, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '0.1234567890', 'output', '2025-05-13 10:22:47', '2025-05-13 10:22:47'),
(89, 36, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0200000000', 'input', '2025-05-13 10:22:49', '2025-05-13 10:22:49'),
(90, 36, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.0200000000', 'input', '2025-05-13 10:22:51', '2025-05-13 10:22:51'),
(91, 37, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '0.1234567890', 'output', '2025-05-13 10:25:27', '2025-05-13 10:25:27'),
(92, 37, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.0179839505', 'input', '2025-05-13 10:25:29', '2025-05-13 10:25:29'),
(93, 37, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.0152415788', 'input', '2025-05-13 10:25:32', '2025-05-13 10:25:32'),
(100, 38, '364393000046650231', 'Finished', NULL, 0, 'N/A', 0, 0, '0.2200000000', 'output', '2025-05-14 11:19:31', '2025-05-14 11:19:31'),
(101, 38, '364393000046638449', 'Raw1', NULL, 0, 'N/A', 0, 0, '2.2000000000', 'input', '2025-05-14 11:19:33', '2025-05-14 11:19:33'),
(102, 39, '364393000046650231', 'Finished', NULL, 800, 'N/A', 0, 0, '1.0000000000', 'output', '2025-05-18 09:52:35', '2025-05-18 09:52:35'),
(103, 39, '364393000046638449', 'Raw1', NULL, 70, 'N/A', 0, 0, '0.1230000000', 'input', '2025-05-18 09:52:37', '2025-05-18 09:52:37'),
(104, 39, '364393000046638510', 'Raw2', NULL, 80, 'N/A', 0, 0, '0.8760000000', 'input', '2025-05-18 09:52:39', '2025-05-18 09:52:39');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int(11) NOT NULL,
  `invoice_id` varchar(255) DEFAULT NULL,
  `invoice_number` varchar(255) DEFAULT NULL,
  `item_id` varchar(255) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `invoice_id`, `invoice_number`, `item_id`, `item_name`, `rate`, `created_at`, `updated_at`) VALUES
(1, '364393000047357151', '25-26/BBSPL01647', '364393000046650231', 'Finished', '180.00', '2025-05-05 10:44:25', '2025-05-05 10:44:33'),
(2, '364393000047357151', '25-26/BBSPL01647', '364393000046638449', 'Raw1', '70.00', '2025-05-05 10:44:25', '2025-05-05 10:44:33'),
(3, '364393000047357151', '25-26/BBSPL01647', '364393000046638510', 'Raw2', '75.00', '2025-05-05 10:44:25', '2025-05-05 10:44:33'),
(4, '364393000047423736', '25-26/BBSPL01646', '364393000000382001', 'FP BW Cyano Pro/1KG', '1500.00', '2025-05-05 07:09:38', '2025-05-05 07:10:05'),
(5, '364393000047423736', '25-26/BBSPL01646', '364393000000079737', 'FP BW Odosweep/500GM', '0.00', '2025-05-05 07:09:38', '2025-05-05 07:10:05'),
(6, '364393000047423582', '25-26/BBSPL01645', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-05 07:08:28', '2025-05-05 07:08:47'),
(7, '364393000047423582', '25-26/BBSPL01645', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-05 07:08:28', '2025-05-05 07:08:47'),
(8, '364393000047423582', '25-26/BBSPL01645', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-05 07:08:28', '2025-05-05 07:08:47'),
(9, '364393000047423413', '25-26/BBSPL01644', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '950.00', '2025-05-05 07:07:27', '2025-05-05 07:07:41'),
(10, '364393000047423413', '25-26/BBSPL01644', '364393000000080091', 'FP BW Zyme-B/500GM', '950.00', '2025-05-05 07:07:27', '2025-05-05 07:07:41'),
(11, '364393000047423413', '25-26/BBSPL01644', '364393000000080093', 'FP BW Citrix-100/500GM', '900.00', '2025-05-05 07:07:27', '2025-05-05 07:07:41'),
(12, '364393000047423276', '25-26/BBSPL01643', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-05 07:06:03', '2025-05-05 07:06:15'),
(13, '364393000047423128', '25-26/BBSPL01642', '364393000004732306', 'FP BW CYANO-L/5LT', '900.00', '2025-05-05 07:05:00', '2025-05-05 07:05:14'),
(14, '364393000047423128', '25-26/BBSPL01642', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-05 07:05:00', '2025-05-05 07:05:14'),
(15, '364393000047420981', '25-26/BBSPL01641', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 07:02:55', '2025-05-05 07:03:26'),
(16, '364393000047420767', '25-26/BBSPL01640', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-05 07:02:05', '2025-05-05 07:02:17'),
(17, '364393000047420767', '25-26/BBSPL01640', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 07:02:05', '2025-05-05 07:02:17'),
(18, '364393000047420767', '25-26/BBSPL01640', '364393000000079743', 'FP BW Bluesoft/1KG', '320.00', '2025-05-05 07:02:05', '2025-05-05 07:02:17'),
(19, '364393000047420767', '25-26/BBSPL01640', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '780.00', '2025-05-05 07:02:05', '2025-05-05 07:02:17'),
(20, '364393000047420767', '25-26/BBSPL01640', '364393000000079781', 'FP BW K-Blue/10KG', '800.00', '2025-05-05 07:02:05', '2025-05-05 07:02:17'),
(21, '364393000047420767', '25-26/BBSPL01640', '364393000000079769', 'FP BW Super Probes-PS/20LT', '1800.00', '2025-05-05 07:02:05', '2025-05-05 07:02:17'),
(22, '364393000047420767', '25-26/BBSPL01640', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-05 07:02:05', '2025-05-05 07:02:17'),
(23, '364393000047420767', '25-26/BBSPL01640', '364393000000079737', 'FP BW Odosweep/500GM', '0.00', '2025-05-05 07:02:05', '2025-05-05 07:02:17'),
(24, '364393000047420609', '25-26/BBSPL01639', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 06:59:22', '2025-05-05 06:59:37'),
(25, '364393000047420609', '25-26/BBSPL01639', '364393000000079767', 'FP BW Super Probes-PS/5LT', '500.00', '2025-05-05 06:59:22', '2025-05-05 06:59:37'),
(26, '364393000047420335', '25-26/BBSPL01638', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-05 06:57:46', '2025-05-05 06:58:03'),
(27, '364393000047420335', '25-26/BBSPL01638', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-05 06:57:46', '2025-05-05 06:58:03'),
(28, '364393000047420335', '25-26/BBSPL01638', '364393000000079781', 'FP BW K-Blue/10KG', '800.00', '2025-05-05 06:57:46', '2025-05-05 06:58:03'),
(29, '364393000047420335', '25-26/BBSPL01638', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '780.00', '2025-05-05 06:57:46', '2025-05-05 06:58:03'),
(30, '364393000047420335', '25-26/BBSPL01638', '364393000000079799', 'FP BW Oxybrix-T/5KG', '1016.95', '2025-05-05 06:57:46', '2025-05-05 06:58:03'),
(31, '364393000047420335', '25-26/BBSPL01638', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-05 06:57:46', '2025-05-05 06:58:03'),
(32, '364393000047420335', '25-26/BBSPL01638', '364393000000715251', 'FP BW Growmin BW+/10KG', '0.00', '2025-05-05 06:57:46', '2025-05-05 06:58:03'),
(33, '364393000047420193', '25-26/BBSPL01637', '364393000000927001', 'FP BW Bluegold Gel/17LT', '1700.00', '2025-05-05 06:53:55', '2025-05-05 06:54:35'),
(34, '364393000047420039', '25-26/BBSPL01636', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-05 06:52:42', '2025-05-05 06:52:55'),
(35, '364393000047420039', '25-26/BBSPL01636', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-05 06:52:42', '2025-05-05 06:52:55'),
(36, '364393000047420039', '25-26/BBSPL01636', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-05 06:52:42', '2025-05-05 06:52:55'),
(37, '364393000047418907', '25-26/BBSPL01635', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-05 06:51:40', '2025-05-05 06:51:51'),
(38, '364393000047418693', '25-26/BBSPL01634', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-05 06:50:28', '2025-05-05 06:51:10'),
(39, '364393000047418693', '25-26/BBSPL01634', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-05 06:50:28', '2025-05-05 06:51:10'),
(40, '364393000047418693', '25-26/BBSPL01634', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-05 06:50:28', '2025-05-05 06:51:10'),
(41, '364393000047418693', '25-26/BBSPL01634', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-05 06:50:28', '2025-05-05 06:51:10'),
(42, '364393000047418556', '25-26/BBSPL01633', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-05 06:47:45', '2025-05-05 06:47:59'),
(43, '364393000047418155', '25-26/BBSPL01632', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-05 06:44:19', '2025-05-05 06:46:09'),
(44, '364393000047418155', '25-26/BBSPL01632', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-05 06:44:19', '2025-05-05 06:46:09'),
(45, '364393000047418013', '25-26/BBSPL01631', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-05 06:41:18', '2025-05-05 06:41:38'),
(46, '364393000047416855', '25-26/BBSPL01630', '364393000000906039', 'FP BW Dominator XL/5LT', '2150.00', '2025-05-05 06:40:21', '2025-05-05 06:40:38'),
(47, '364393000047416855', '25-26/BBSPL01630', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '490.00', '2025-05-05 06:40:21', '2025-05-05 06:40:38'),
(48, '364393000047416648', '25-26/BBSPL01629', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-05 06:38:35', '2025-05-05 06:39:24'),
(49, '364393000047416648', '25-26/BBSPL01629', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '490.00', '2025-05-05 06:38:35', '2025-05-05 06:39:24'),
(50, '364393000047416451', '25-26/BBSPL01628', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-05 06:36:46', '2025-05-05 06:37:06'),
(51, '364393000047416451', '25-26/BBSPL01628', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-05 06:36:46', '2025-05-05 06:37:06'),
(52, '364393000047416451', '25-26/BBSPL01628', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-05 06:36:46', '2025-05-05 06:37:06'),
(53, '364393000047416076', '25-26/BBSPL01627', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 06:35:16', '2025-05-05 06:35:58'),
(54, '364393000047416076', '25-26/BBSPL01627', '364393000000079743', 'FP BW Bluesoft/1KG', '320.00', '2025-05-05 06:35:16', '2025-05-05 06:35:58'),
(55, '364393000047416076', '25-26/BBSPL01627', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-05 06:35:16', '2025-05-05 06:35:58'),
(56, '364393000047416076', '25-26/BBSPL01627', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-05 06:35:16', '2025-05-05 06:35:58'),
(57, '364393000047416076', '25-26/BBSPL01627', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-05 06:35:16', '2025-05-05 06:35:58'),
(58, '364393000047414907', '25-26/BBSPL01626', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-05 06:32:31', '2025-05-05 06:32:45'),
(59, '364393000047414658', '25-26/BBSPL01625', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-05 06:30:40', '2025-05-05 06:30:56'),
(60, '364393000047414658', '25-26/BBSPL01625', '364393000000079799', 'FP BW Oxybrix-T/5KG', '1016.95', '2025-05-05 06:30:40', '2025-05-05 06:30:56'),
(61, '364393000047414658', '25-26/BBSPL01625', '364393000000757321', 'FP BW Livertreat-XL 2KG', '450.00', '2025-05-05 06:30:40', '2025-05-05 06:30:56'),
(62, '364393000047414658', '25-26/BBSPL01625', '364393000000715362', 'FP BW Oxybreeze/5KG', '762.71', '2025-05-05 06:30:40', '2025-05-05 06:30:56'),
(63, '364393000047414504', '25-26/BBSPL01624', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-05 06:28:49', '2025-05-05 06:29:02'),
(64, '364393000047414504', '25-26/BBSPL01624', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-05 06:28:49', '2025-05-05 06:29:02'),
(65, '364393000047414504', '25-26/BBSPL01624', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-05 06:28:49', '2025-05-05 06:29:02'),
(66, '364393000047414327', '25-26/BBSPL01623', '364393000000485153', 'FP BW GUTGOLD 1KG', '750.00', '2025-05-05 06:25:55', '2025-05-05 06:27:30'),
(67, '364393000047414327', '25-26/BBSPL01623', '364393000000080093', 'FP BW Citrix-100/500GM', '900.00', '2025-05-05 06:25:55', '2025-05-05 06:27:30'),
(68, '364393000047414327', '25-26/BBSPL01623', '364393000000927001', 'FP BW Bluegold Gel/17LT', '1700.00', '2025-05-05 06:25:55', '2025-05-05 06:27:30'),
(69, '364393000047414327', '25-26/BBSPL01623', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 06:25:55', '2025-05-05 06:27:30'),
(70, '364393000047414327', '25-26/BBSPL01623', '364393000000080093', 'FP BW Citrix-100/500GM', '0.00', '2025-05-05 06:25:55', '2025-05-05 06:27:30'),
(71, '364393000047414195', '25-26/BBSPL01622', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-05 06:23:29', '2025-05-05 06:23:39'),
(72, '364393000047414035', '25-26/BBSPL01621', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 06:22:28', '2025-05-05 06:22:49'),
(73, '364393000047412898', '25-26/BBSPL01620', '364393000005077887', 'FP BW Dominator-XL 20LT', '8200.00', '2025-05-05 06:19:51', '2025-05-05 06:20:07'),
(74, '364393000047412669', '25-26/BBSPL01619', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-05 06:18:27', '2025-05-05 06:18:53'),
(75, '364393000047412669', '25-26/BBSPL01619', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-05 06:18:27', '2025-05-05 06:18:53'),
(76, '364393000047412669', '25-26/BBSPL01619', '364393000000079743', 'FP BW Bluesoft/1KG', '320.00', '2025-05-05 06:18:27', '2025-05-05 06:18:53'),
(77, '364393000047412669', '25-26/BBSPL01619', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-05 06:18:27', '2025-05-05 06:18:53'),
(78, '364393000047412527', '25-26/BBSPL01618', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-05 06:16:55', '2025-05-05 06:17:14'),
(79, '364393000047412269', '25-26/BBSPL01617', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-05 06:14:57', '2025-05-05 06:15:27'),
(80, '364393000047412269', '25-26/BBSPL01617', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-05 06:14:57', '2025-05-05 06:15:27'),
(81, '364393000047412269', '25-26/BBSPL01617', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-05 06:14:57', '2025-05-05 06:15:27'),
(82, '364393000047412269', '25-26/BBSPL01617', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-05 06:14:57', '2025-05-05 06:15:27'),
(83, '364393000047412269', '25-26/BBSPL01617', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-05 06:14:57', '2025-05-05 06:15:27'),
(84, '364393000047412132', '25-26/BBSPL01616', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-05 06:12:48', '2025-05-05 06:13:03'),
(85, '364393000047409937', '25-26/BBSPL01615', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '211.86', '2025-05-05 06:11:50', '2025-05-05 06:12:06'),
(86, '364393000047409937', '25-26/BBSPL01615', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 06:11:50', '2025-05-05 06:12:06'),
(87, '364393000047409937', '25-26/BBSPL01615', '364393000000079489', 'FP BW FOT 37/20LT', '1059.32', '2025-05-05 06:11:50', '2025-05-05 06:12:06'),
(88, '364393000047409778', '25-26/BBSPL01614', '364393000000485153', 'FP BW GUTGOLD 1KG', '750.00', '2025-05-05 06:10:31', '2025-05-05 06:10:48'),
(89, '364393000047409778', '25-26/BBSPL01614', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-05 06:10:31', '2025-05-05 06:10:48'),
(90, '364393000047409778', '25-26/BBSPL01614', '364393000000079743', 'FP BW Bluesoft/1KG', '320.00', '2025-05-05 06:10:31', '2025-05-05 06:10:48'),
(91, '364393000047409585', '25-26/BBSPL01613', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-05 06:08:47', '2025-05-05 06:09:18'),
(92, '364393000047409585', '25-26/BBSPL01613', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-05 06:08:47', '2025-05-05 06:09:18'),
(93, '364393000047409585', '25-26/BBSPL01613', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-05 06:08:47', '2025-05-05 06:09:18'),
(94, '364393000047409448', '25-26/BBSPL01612', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 06:07:27', '2025-05-05 06:07:38'),
(95, '364393000047409311', '25-26/BBSPL01611', '364393000000927001', 'FP BW Bluegold Gel/17LT', '1700.00', '2025-05-05 06:06:24', '2025-05-05 06:06:36'),
(96, '364393000047409157', '25-26/BBSPL01610', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-05 06:05:04', '2025-05-05 06:05:40'),
(97, '364393000047409157', '25-26/BBSPL01610', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-05 06:05:04', '2025-05-05 06:05:40'),
(98, '364393000047409157', '25-26/BBSPL01610', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-05 06:05:04', '2025-05-05 06:05:40'),
(99, '364393000047409025', '25-26/BBSPL01609', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-05 06:04:18', '2025-05-05 06:04:31'),
(100, '364393000047408893', '25-26/BBSPL01608', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-05 06:03:29', '2025-05-05 06:03:40'),
(101, '364393000047408739', '25-26/BBSPL01607', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-05 06:02:42', '2025-05-05 06:02:58'),
(102, '364393000047408739', '25-26/BBSPL01607', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-05 06:02:42', '2025-05-05 06:02:58'),
(103, '364393000047408739', '25-26/BBSPL01607', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-05 06:02:42', '2025-05-05 06:02:58'),
(104, '364393000047408585', '25-26/BBSPL01606', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-05 06:01:51', '2025-05-05 06:02:02'),
(105, '364393000047408585', '25-26/BBSPL01606', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-05 06:01:51', '2025-05-05 06:02:02'),
(106, '364393000047408585', '25-26/BBSPL01606', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-05 06:01:51', '2025-05-05 06:02:02'),
(107, '364393000047408448', '25-26/BBSPL01605', '364393000000080103', 'FP BW Profish-BW/10KG', '900.00', '2025-05-05 06:00:55', '2025-05-05 06:01:06'),
(108, '364393000047408311', '25-26/BBSPL01604', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-05 06:00:10', '2025-05-05 06:00:20'),
(109, '364393000047408163', '25-26/BBSPL01603', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-05 05:59:14', '2025-05-05 05:59:26'),
(110, '364393000047408163', '25-26/BBSPL01603', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-05 05:59:14', '2025-05-05 05:59:26'),
(111, '364393000047406982', '25-26/BBSPL01602', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-05 05:57:42', '2025-05-05 05:57:54'),
(112, '364393000047406982', '25-26/BBSPL01602', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-05 05:57:42', '2025-05-05 05:57:54'),
(113, '364393000047406823', '25-26/BBSPL01601', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-05 05:56:25', '2025-05-05 05:56:35'),
(114, '364393000047406823', '25-26/BBSPL01601', '364393000000079737', 'FP BW Odosweep/500GM', '900.00', '2025-05-05 05:56:25', '2025-05-05 05:56:35'),
(115, '364393000047406823', '25-26/BBSPL01601', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 05:56:25', '2025-05-05 05:56:35'),
(116, '364393000047406686', '25-26/BBSPL01600', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-05 05:55:04', '2025-05-05 05:55:24'),
(117, '364393000047406549', '25-26/BBSPL01599', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-05 05:54:08', '2025-05-05 05:54:22'),
(118, '364393000047406320', '25-26/BBSPL01598', '364393000000079769', 'FP BW Super Probes-PS/20LT', '1800.00', '2025-05-05 05:52:16', '2025-05-05 05:52:58'),
(119, '364393000047406183', '25-26/BBSPL01597', '364393000000079489', 'FP BW FOT 37/20LT', '1059.32', '2025-05-05 05:51:10', '2025-05-05 05:51:22'),
(120, '364393000047406044', '25-26/BBSPL01596', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-05 05:49:22', '2025-05-05 05:49:33'),
(121, '364393000047405897', '25-26/BBSPL01595', '364393000000757321', 'FP BW Livertreat-XL 2KG', '450.00', '2025-05-05 05:48:20', '2025-05-05 05:48:33'),
(122, '364393000047405637', '25-26/BBSPL01594', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-05 05:46:37', '2025-05-05 05:47:36'),
(123, '364393000047405637', '25-26/BBSPL01594', '364393000000080093', 'FP BW Citrix-100/500GM', '900.00', '2025-05-05 05:46:37', '2025-05-05 05:47:36'),
(124, '364393000047405637', '25-26/BBSPL01594', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 05:46:37', '2025-05-05 05:47:36'),
(125, '364393000047405637', '25-26/BBSPL01594', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-05 05:46:37', '2025-05-05 05:47:36'),
(126, '364393000047405637', '25-26/BBSPL01594', '364393000000927001', 'FP BW Bluegold Gel/17LT', '1700.00', '2025-05-05 05:46:37', '2025-05-05 05:47:36'),
(127, '364393000047405637', '25-26/BBSPL01594', '364393000000927001', 'FP BW Bluegold Gel/17LT', '0.00', '2025-05-05 05:46:37', '2025-05-05 05:47:36'),
(128, '364393000047405505', '25-26/BBSPL01593', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-05 05:44:41', '2025-05-05 05:44:57'),
(129, '364393000047405335', '25-26/BBSPL01592', '364393000004394315', 'FP VW MG/500GM', '950.00', '2025-05-05 05:43:42', '2025-05-05 05:43:54'),
(130, '364393000047405335', '25-26/BBSPL01592', '364393000000079741', 'FP BW Abolish/1KG', '850.00', '2025-05-05 05:43:42', '2025-05-05 05:43:54'),
(131, '364393000047405335', '25-26/BBSPL01592', '364393000000079769', 'FP BW Super Probes-PS/20LT', '1800.00', '2025-05-05 05:43:42', '2025-05-05 05:43:54'),
(132, '364393000047405335', '25-26/BBSPL01592', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-05 05:43:42', '2025-05-05 05:43:54'),
(133, '364393000047405252', '25-26/BBSPL01591', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 05:40:23', '2025-05-05 07:10:40'),
(134, '364393000047405035', '25-26/BBSPL01590', '364393000000079743', 'FP BW Bluesoft/1KG', '320.00', '2025-05-05 05:39:29', '2025-05-05 05:39:42'),
(135, '364393000047405035', '25-26/BBSPL01590', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 05:39:29', '2025-05-05 05:39:42'),
(136, '364393000047405035', '25-26/BBSPL01590', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-05 05:39:29', '2025-05-05 05:39:42'),
(137, '364393000047405035', '25-26/BBSPL01590', '364393000000715362', 'FP BW Oxybreeze/5KG', '762.71', '2025-05-05 05:39:29', '2025-05-05 05:39:42'),
(138, '364393000047405035', '25-26/BBSPL01590', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-05 05:39:29', '2025-05-05 05:39:42'),
(139, '364393000047402816', '25-26/BBSPL01589', '364393000000080093', 'FP BW Citrix-100/500GM', '900.00', '2025-05-05 05:37:36', '2025-05-05 05:38:02'),
(140, '364393000047402816', '25-26/BBSPL01589', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-05 05:37:36', '2025-05-05 05:38:02'),
(141, '364393000047402816', '25-26/BBSPL01589', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '8900.00', '2025-05-05 05:37:36', '2025-05-05 05:38:02'),
(142, '364393000047402816', '25-26/BBSPL01589', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '0.00', '2025-05-05 05:37:36', '2025-05-05 05:38:02'),
(143, '364393000047402583', '25-26/BBSPL01588', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-05 05:35:27', '2025-05-05 05:36:04'),
(144, '364393000047402583', '25-26/BBSPL01588', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-05 05:35:27', '2025-05-05 05:36:04'),
(145, '364393000047402583', '25-26/BBSPL01588', '364393000000080115', 'FP BW Provitagel-BW/5LT', '650.00', '2025-05-05 05:35:27', '2025-05-05 05:36:04'),
(146, '364393000047402339', '25-26/BBSPL01587', '364393000000079431', 'FP BW Apex-6/1LT', '271.19', '2025-05-05 05:33:57', '2025-05-05 05:34:23'),
(147, '364393000047402339', '25-26/BBSPL01587', '364393000000906039', 'FP BW Dominator XL/5LT', '2150.00', '2025-05-05 05:33:57', '2025-05-05 05:34:23'),
(148, '364393000047402339', '25-26/BBSPL01587', '364393000000079797', 'FP BW Oxybrix-T/1KG', '211.86', '2025-05-05 05:33:57', '2025-05-05 05:34:23'),
(149, '364393000047402084', '25-26/BBSPL01586', '364393000000079743', 'FP BW Bluesoft/1KG', '320.00', '2025-05-05 05:32:23', '2025-05-05 05:32:51'),
(150, '364393000047402084', '25-26/BBSPL01586', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-05 05:32:23', '2025-05-05 05:32:51'),
(151, '364393000047402084', '25-26/BBSPL01586', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-05 05:32:23', '2025-05-05 05:32:51'),
(152, '364393000047402084', '25-26/BBSPL01586', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-05 05:32:23', '2025-05-05 05:32:51'),
(153, '364393000047399925', '25-26/BBSPL01585', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-05 05:30:59', '2025-05-05 05:31:11'),
(154, '364393000047399925', '25-26/BBSPL01585', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-05 05:30:59', '2025-05-05 05:31:11'),
(155, '364393000047399925', '25-26/BBSPL01585', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '490.00', '2025-05-05 05:30:59', '2025-05-05 05:31:11'),
(156, '364393000047399604', '25-26/BBSPL01584', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-05 05:28:19', '2025-05-05 05:29:20'),
(157, '364393000047399604', '25-26/BBSPL01584', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-05 05:28:19', '2025-05-05 05:29:20'),
(158, '364393000047399604', '25-26/BBSPL01584', '364393000000079489', 'FP BW FOT 37/20LT', '1059.32', '2025-05-05 05:28:19', '2025-05-05 05:29:20'),
(159, '364393000047399604', '25-26/BBSPL01584', '364393000000079743', 'FP BW Bluesoft/1KG', '320.00', '2025-05-05 05:28:19', '2025-05-05 05:29:20'),
(160, '364393000047399397', '25-26/BBSPL01583', '364393000000079775', 'FP BW Viracon-S/500GM', '650.00', '2025-05-05 05:17:14', '2025-05-05 05:17:48'),
(161, '364393000047399397', '25-26/BBSPL01583', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-05 05:17:14', '2025-05-05 05:17:48'),
(162, '364393000047399125', '25-26/BBSPL01582', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-05 05:15:21', '2025-05-05 05:16:27'),
(163, '364393000047399125', '25-26/BBSPL01582', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-05 05:15:21', '2025-05-05 05:16:27'),
(164, '364393000047399125', '25-26/BBSPL01582', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '780.00', '2025-05-05 05:15:21', '2025-05-05 05:16:27'),
(165, '364393000047397871', '25-26/BBSPL01581', '364393000000079489', 'FP BW FOT 37/20LT', '1059.32', '2025-05-05 04:16:22', '2025-05-05 05:14:22'),
(166, '364393000047397871', '25-26/BBSPL01581', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-05 04:16:22', '2025-05-05 05:14:22'),
(167, '364393000047397871', '25-26/BBSPL01581', '364393000000079797', 'FP BW Oxybrix-T/1KG', '211.86', '2025-05-05 04:16:22', '2025-05-05 05:14:22'),
(168, '364393000047397871', '25-26/BBSPL01581', '364393000000715362', 'FP BW Oxybreeze/5KG', '762.71', '2025-05-05 04:16:22', '2025-05-05 05:14:22'),
(169, '364393000047397713', '25-26/BBSPL01580', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-05 03:58:15', '2025-05-05 03:58:34'),
(170, '364393000047397713', '25-26/BBSPL01580', '364393000000079737', 'FP BW Odosweep/500GM', '0.00', '2025-05-05 03:58:15', '2025-05-05 03:58:34'),
(171, '364393000047397517', '25-26/BBSPL01579', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-05 03:56:44', '2025-05-05 03:57:08'),
(172, '364393000047397380', '25-26/BBSPL01578', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-05 03:53:43', '2025-05-05 03:54:02'),
(173, '364393000047397248', '25-26/BBSPL01577', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-05 03:51:15', '2025-05-05 03:52:38'),
(174, '364393000047397076', '25-26/BBSPL01576', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-05 03:48:41', '2025-05-05 03:48:53'),
(175, '364393000047388922', '25-26/BBSPL01575', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-05 03:46:15', '2025-05-05 03:46:42'),
(176, '364393000047388922', '25-26/BBSPL01575', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '950.00', '2025-05-05 03:46:15', '2025-05-05 03:46:42'),
(177, '364393000047388922', '25-26/BBSPL01575', '364393000000080093', 'FP BW Citrix-100/500GM', '900.00', '2025-05-05 03:46:15', '2025-05-05 03:46:42'),
(178, '364393000047337575', '25-26/BBSPL01574', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-04 10:24:04', '2025-05-04 10:24:22'),
(179, '364393000047337494', '25-26/BBSPL01573', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-04 10:22:35', '2025-05-04 10:22:52'),
(180, '364393000047337402', '25-26/BBSPL01572', '364393000000927001', 'FP BW Bluegold Gel/17LT', '1700.00', '2025-05-04 10:21:39', '2025-05-04 10:21:59'),
(181, '364393000047337402', '25-26/BBSPL01572', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '0.00', '2025-05-04 10:21:39', '2025-05-04 10:21:59'),
(182, '364393000047337353', '25-26/BBSPL01571', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-04 10:20:39', '2025-05-04 10:20:42'),
(183, '364393000047387590', '25-26/BBSPL01570', '364393000000964149', 'FP CASB WSP4/1KG', '0.50', '2025-05-03 05:22:25', '2025-05-03 05:22:42'),
(184, '364393000047387431', '25-26/BBSPL01569', '364393000000485153', 'FP BW GUTGOLD 1KG', '750.00', '2025-05-03 05:21:32', '2025-05-03 05:21:46'),
(185, '364393000047387431', '25-26/BBSPL01569', '364393000000080093', 'FP BW Citrix-100/500GM', '900.00', '2025-05-03 05:21:32', '2025-05-03 05:21:46'),
(186, '364393000047387431', '25-26/BBSPL01569', '364393000000283116', 'FP BW Proclarify-9/1KG', '1400.00', '2025-05-03 05:21:32', '2025-05-03 05:21:46'),
(187, '364393000047387272', '25-26/BBSPL01568', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-03 05:20:11', '2025-05-03 05:20:25'),
(188, '364393000047387272', '25-26/BBSPL01568', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-03 05:20:11', '2025-05-03 05:20:25'),
(189, '364393000047387272', '25-26/BBSPL01568', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '490.00', '2025-05-03 05:20:11', '2025-05-03 05:20:25'),
(190, '364393000047387091', '25-26/BBSPL01567', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-03 05:17:36', '2025-05-03 05:17:58'),
(191, '364393000047387091', '25-26/BBSPL01567', '364393000000079737', 'FP BW Odosweep/500GM', '900.00', '2025-05-03 05:17:36', '2025-05-03 05:17:58'),
(192, '364393000047386959', '25-26/BBSPL01566', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-03 05:16:21', '2025-05-03 05:16:36'),
(193, '364393000047386812', '25-26/BBSPL01565', '364393000000906039', 'FP BW Dominator XL/5LT', '2150.00', '2025-05-03 05:15:31', '2025-05-03 05:15:44'),
(194, '364393000047386675', '25-26/BBSPL01564', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-03 05:14:30', '2025-05-03 05:14:47'),
(195, '364393000047386488', '25-26/BBSPL01563', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-03 05:10:01', '2025-05-03 05:10:17'),
(196, '364393000047386488', '25-26/BBSPL01563', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-03 05:10:01', '2025-05-03 05:10:17'),
(197, '364393000047386488', '25-26/BBSPL01563', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-03 05:10:01', '2025-05-03 05:10:17'),
(198, '364393000047386356', '25-26/BBSPL01562', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-03 05:07:46', '2025-05-03 05:08:00'),
(199, '364393000047386126', '25-26/BBSPL01561', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-03 05:06:28', '2025-05-03 05:07:00'),
(200, '364393000047386126', '25-26/BBSPL01561', '364393000000079781', 'FP BW K-Blue/10KG', '800.00', '2025-05-03 05:06:28', '2025-05-03 05:07:00'),
(201, '364393000047386126', '25-26/BBSPL01561', '364393000004732306', 'FP BW CYANO-L/5LT', '900.00', '2025-05-03 05:06:28', '2025-05-03 05:07:00'),
(202, '364393000047386126', '25-26/BBSPL01561', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '490.00', '2025-05-03 05:06:28', '2025-05-03 05:07:00'),
(203, '364393000047386126', '25-26/BBSPL01561', '364393000000927001', 'FP BW Bluegold Gel/17LT', '0.00', '2025-05-03 05:06:28', '2025-05-03 05:07:00'),
(204, '364393000047384956', '25-26/BBSPL01560', '364393000000382001', 'FP BW Cyano Pro/1KG', '1500.00', '2025-05-03 05:03:37', '2025-05-03 05:03:52'),
(205, '364393000047384786', '25-26/BBSPL01559', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-03 05:01:12', '2025-05-03 05:01:48'),
(206, '364393000047384649', '25-26/BBSPL01558', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-03 04:59:30', '2025-05-03 04:59:52'),
(207, '364393000047384517', '25-26/BBSPL01557', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-03 04:57:52', '2025-05-03 04:58:08'),
(208, '364393000047384338', '25-26/BBSPL01556', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-03 04:56:42', '2025-05-03 04:57:01'),
(209, '364393000047384338', '25-26/BBSPL01556', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-03 04:56:42', '2025-05-03 04:57:01'),
(210, '364393000047384338', '25-26/BBSPL01556', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-03 04:56:42', '2025-05-03 04:57:01'),
(211, '364393000047384201', '25-26/BBSPL01555', '364393000000080119', 'FP BW Provitagel-BW/20LT', '2500.00', '2025-05-03 04:55:23', '2025-05-03 04:55:34'),
(212, '364393000047384067', '25-26/BBSPL01554', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-03 04:54:34', '2025-05-03 04:54:45'),
(213, '364393000047382905', '25-26/BBSPL01553', '364393000000079741', 'FP BW Abolish/1KG', '850.00', '2025-05-03 04:53:47', '2025-05-03 04:54:00'),
(214, '364393000047382905', '25-26/BBSPL01553', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-03 04:53:47', '2025-05-03 04:54:00'),
(215, '364393000047382773', '25-26/BBSPL01552', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-03 04:52:38', '2025-05-03 04:52:52'),
(216, '364393000047382641', '25-26/BBSPL01551', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-03 04:51:58', '2025-05-03 04:52:08'),
(217, '364393000047382504', '25-26/BBSPL01550', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-03 04:50:49', '2025-05-03 04:51:23'),
(218, '364393000047382356', '25-26/BBSPL01549', '364393000000079769', 'FP BW Super Probes-PS/20LT', '1800.00', '2025-05-03 04:50:07', '2025-05-03 04:50:17'),
(219, '364393000047382356', '25-26/BBSPL01549', '364393000000079743', 'FP BW Bluesoft/1KG', '320.00', '2025-05-03 04:50:07', '2025-05-03 04:50:17'),
(220, '364393000047382198', '25-26/BBSPL01548', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-03 04:48:52', '2025-05-03 04:49:13'),
(221, '364393000047382198', '25-26/BBSPL01548', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-03 04:48:52', '2025-05-03 04:49:13'),
(222, '364393000047381978', '25-26/BBSPL01547', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-03 04:47:47', '2025-05-03 04:47:57'),
(223, '364393000047381978', '25-26/BBSPL01547', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-03 04:47:47', '2025-05-03 04:47:57'),
(224, '364393000047381978', '25-26/BBSPL01547', '364393000000079469', 'FP BW Iodoshine 2%/5LT', '1016.95', '2025-05-03 04:47:47', '2025-05-03 04:47:57'),
(225, '364393000047381784', '25-26/BBSPL01546', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-03 04:46:21', '2025-05-03 04:46:34'),
(226, '364393000047381784', '25-26/BBSPL01546', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-03 04:46:21', '2025-05-03 04:46:34'),
(227, '364393000047381784', '25-26/BBSPL01546', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-03 04:46:21', '2025-05-03 04:46:34'),
(228, '364393000047381784', '25-26/BBSPL01546', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-03 04:46:21', '2025-05-03 04:46:34'),
(229, '364393000047381601', '25-26/BBSPL01545', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-03 04:44:44', '2025-05-03 04:44:57'),
(230, '364393000047381601', '25-26/BBSPL01545', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-03 04:44:44', '2025-05-03 04:44:57'),
(231, '364393000047381601', '25-26/BBSPL01545', '364393000000079431', 'FP BW Apex-6/1LT', '271.19', '2025-05-03 04:44:44', '2025-05-03 04:44:57'),
(232, '364393000047381464', '25-26/BBSPL01544', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-03 04:43:35', '2025-05-03 04:43:47'),
(233, '364393000047381303', '25-26/BBSPL01543', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-03 04:38:41', '2025-05-03 04:38:50'),
(234, '364393000047381303', '25-26/BBSPL01543', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-03 04:38:41', '2025-05-03 04:38:50'),
(235, '364393000047381303', '25-26/BBSPL01543', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-03 04:38:41', '2025-05-03 04:38:50'),
(236, '364393000047381097', '25-26/BBSPL01542', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '490.00', '2025-05-03 04:37:25', '2025-05-03 04:37:39'),
(237, '364393000047381097', '25-26/BBSPL01542', '364393000000079775', 'FP BW Viracon-S/500GM', '650.00', '2025-05-03 04:37:25', '2025-05-03 04:37:39'),
(238, '364393000047381097', '25-26/BBSPL01542', '364393000001386759', 'FP BW Iodoshine 20%/500ML', '1016.95', '2025-05-03 04:37:25', '2025-05-03 04:37:39'),
(239, '364393000047381097', '25-26/BBSPL01542', '364393000000079461', 'FP BW Benz-80/1LT', '531.00', '2025-05-03 04:37:25', '2025-05-03 04:37:39'),
(240, '364393000047380942', '25-26/BBSPL01541', '364393000000079737', 'FP BW Odosweep/500GM', '900.00', '2025-05-03 04:33:10', '2025-05-03 04:35:09'),
(241, '364393000047380942', '25-26/BBSPL01541', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-03 04:33:10', '2025-05-03 04:35:09'),
(242, '364393000047380942', '25-26/BBSPL01541', '364393000000079737', 'FP BW Odosweep/500GM', '0.00', '2025-05-03 04:33:10', '2025-05-03 04:35:09'),
(243, '364393000047380736', '25-26/BBSPL01540', '364393000000079467', 'FP BW Iodoshine 2%/1LT', '211.86', '2025-05-03 04:32:12', '2025-05-03 04:32:23'),
(244, '364393000047380736', '25-26/BBSPL01540', '364393000000079735', 'FP BW Chill Zinc/1KG', '300.00', '2025-05-03 04:32:12', '2025-05-03 04:32:23'),
(245, '364393000047380736', '25-26/BBSPL01540', '364393000000079797', 'FP BW Oxybrix-T/1KG', '211.86', '2025-05-03 04:32:12', '2025-05-03 04:32:23'),
(246, '364393000047380736', '25-26/BBSPL01540', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '490.00', '2025-05-03 04:32:12', '2025-05-03 04:32:23'),
(247, '364393000047380578', '25-26/BBSPL01539', '364393000000079737', 'FP BW Odosweep/500GM', '900.00', '2025-05-03 04:30:29', '2025-05-03 04:30:48'),
(248, '364393000047380578', '25-26/BBSPL01539', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-03 04:30:29', '2025-05-03 04:30:48'),
(249, '364393000047380397', '25-26/BBSPL01538', '364393000000964149', 'FP CASB WSP4/1KG', '0.50', '2025-05-03 04:29:08', '2025-05-03 04:29:32'),
(250, '364393000047380250', '25-26/BBSPL01537', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-03 04:28:07', '2025-05-03 04:28:26'),
(251, '364393000047380053', '25-26/BBSPL01536', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-03 04:26:46', '2025-05-03 04:27:14'),
(252, '364393000047380053', '25-26/BBSPL01536', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-03 04:26:46', '2025-05-03 04:27:14'),
(253, '364393000047379873', '25-26/BBSPL01535', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-03 04:24:52', '2025-05-03 04:25:06'),
(254, '364393000047379626', '25-26/BBSPL01534', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-03 04:23:00', '2025-05-03 04:23:30'),
(255, '364393000047379626', '25-26/BBSPL01534', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-03 04:23:00', '2025-05-03 04:23:30'),
(256, '364393000047379626', '25-26/BBSPL01534', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-03 04:23:00', '2025-05-03 04:23:30'),
(257, '364393000047379626', '25-26/BBSPL01534', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-03 04:23:00', '2025-05-03 04:23:30'),
(258, '364393000047379489', '25-26/BBSPL01533', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-03 04:21:59', '2025-05-03 04:22:11'),
(259, '364393000047379262', '25-26/BBSPL01532', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-03 04:20:09', '2025-05-03 04:20:51'),
(260, '364393000047379262', '25-26/BBSPL01532', '364393000000964149', 'FP CASB WSP4/1KG', '0.50', '2025-05-03 04:20:09', '2025-05-03 04:20:51'),
(261, '364393000047379115', '25-26/BBSPL01531', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-03 04:19:01', '2025-05-03 04:19:23'),
(262, '364393000047377978', '25-26/BBSPL01530', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-03 04:12:15', '2025-05-03 04:12:31'),
(263, '364393000047377791', '25-26/BBSPL01529', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-03 04:10:06', '2025-05-03 04:10:21'),
(264, '364393000047377791', '25-26/BBSPL01529', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-03 04:10:06', '2025-05-03 04:10:21'),
(265, '364393000047377791', '25-26/BBSPL01529', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-03 04:10:06', '2025-05-03 04:10:21'),
(266, '364393000047377654', '25-26/BBSPL01528', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-03 04:08:37', '2025-05-03 04:08:47'),
(267, '364393000047377473', '25-26/BBSPL01527', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-03 04:06:54', '2025-05-03 04:07:10'),
(268, '364393000047377473', '25-26/BBSPL01527', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-03 04:06:54', '2025-05-03 04:07:10'),
(269, '364393000047377325', '25-26/BBSPL01526', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-03 04:05:30', '2025-05-03 04:05:47'),
(270, '364393000047377325', '25-26/BBSPL01526', '364393000000079769', 'FP BW Super Probes-PS/20LT', '1800.00', '2025-05-03 04:05:30', '2025-05-03 04:05:47'),
(271, '364393000047377177', '25-26/BBSPL01525', '364393000000079737', 'FP BW Odosweep/500GM', '900.00', '2025-05-03 04:04:31', '2025-05-03 04:04:41'),
(272, '364393000047377177', '25-26/BBSPL01525', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-03 04:04:31', '2025-05-03 04:04:41'),
(273, '364393000047352997', '25-26/BBSPL01524', '364393000000080093', 'FP BW Citrix-100/500GM', '900.00', '2025-05-03 04:03:13', '2025-05-03 04:03:34'),
(274, '364393000047352997', '25-26/BBSPL01524', '364393000000485153', 'FP BW GUTGOLD 1KG', '750.00', '2025-05-03 04:03:13', '2025-05-03 04:03:34'),
(275, '364393000047352997', '25-26/BBSPL01524', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '950.00', '2025-05-03 04:03:13', '2025-05-03 04:03:34'),
(276, '364393000047352997', '25-26/BBSPL01524', '364393000000080091', 'FP BW Zyme-B/500GM', '950.00', '2025-05-03 04:03:13', '2025-05-03 04:03:34'),
(277, '364393000047352850', '25-26/BBSPL01523', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-03 04:01:36', '2025-05-03 04:02:06'),
(278, '364393000047352713', '25-26/BBSPL01522', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-03 04:00:41', '2025-05-03 04:00:52'),
(279, '364393000047352556', '25-26/BBSPL01521', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-03 03:58:35', '2025-05-03 03:59:54'),
(280, '364393000047352391', '25-26/BBSPL01520', '364393000000964149', 'FP CASB WSP4/1KG', '0.50', '2025-05-03 03:56:24', '2025-05-03 03:56:57'),
(281, '364393000047352237', '25-26/BBSPL01519', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-03 03:55:25', '2025-05-03 03:55:45'),
(282, '364393000047352237', '25-26/BBSPL01519', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-03 03:55:25', '2025-05-03 03:55:45'),
(283, '364393000047352237', '25-26/BBSPL01519', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-03 03:55:25', '2025-05-03 03:55:45'),
(284, '364393000047352023', '25-26/BBSPL01518', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-03 03:53:58', '2025-05-03 03:54:34'),
(285, '364393000047352023', '25-26/BBSPL01518', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-03 03:53:58', '2025-05-03 03:54:34'),
(286, '364393000047352023', '25-26/BBSPL01518', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-03 03:53:58', '2025-05-03 03:54:34'),
(287, '364393000047352023', '25-26/BBSPL01518', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-03 03:53:58', '2025-05-03 03:54:34'),
(288, '364393000047256660', '25-26/BBSPL01517', '364393000000079489', 'FP BW FOT 37/20LT', '1059.32', '2025-05-02 10:23:24', '2025-05-02 10:23:52'),
(289, '364393000047256568', '25-26/BBSPL01516', '364393000000079735', 'FP BW Chill Zinc/1KG', '300.00', '2025-05-02 10:22:14', '2025-05-02 10:22:31'),
(290, '364393000047256568', '25-26/BBSPL01516', '364393000000927001', 'FP BW Bluegold Gel/17LT', '1700.00', '2025-05-02 10:22:14', '2025-05-02 10:22:31'),
(291, '364393000047256508', '25-26/BBSPL01515', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-02 10:20:50', '2025-05-02 10:20:54'),
(292, '364393000047256508', '25-26/BBSPL01515', '364393000000079735', 'FP BW Chill Zinc/1KG', '300.00', '2025-05-02 10:20:50', '2025-05-02 10:20:54'),
(293, '364393000047256448', '25-26/BBSPL01514', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-02 10:18:34', '2025-05-02 10:18:39'),
(294, '364393000047256448', '25-26/BBSPL01514', '364393000000079735', 'FP BW Chill Zinc/1KG', '300.00', '2025-05-02 10:18:34', '2025-05-02 10:18:39'),
(295, '364393000047256367', '25-26/BBSPL01513', '364393000000079799', 'FP BW Oxybrix-T/5KG', '1016.95', '2025-05-02 10:17:05', '2025-05-02 10:17:23'),
(296, '364393000047256264', '25-26/BBSPL01512', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 10:15:24', '2025-05-02 10:15:46'),
(297, '364393000047256264', '25-26/BBSPL01512', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 10:15:24', '2025-05-02 10:15:46'),
(298, '364393000047256264', '25-26/BBSPL01512', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 10:15:24', '2025-05-02 10:15:46'),
(299, '364393000047256161', '25-26/BBSPL01511', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 10:13:49', '2025-05-02 10:14:09'),
(300, '364393000047256161', '25-26/BBSPL01511', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 10:13:49', '2025-05-02 10:14:09'),
(301, '364393000047256161', '25-26/BBSPL01511', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 10:13:49', '2025-05-02 10:14:09'),
(302, '364393000047326839', '25-26/BBSPL01510', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 07:13:14', '2025-05-02 07:13:39'),
(303, '364393000047326839', '25-26/BBSPL01510', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 07:13:14', '2025-05-02 07:13:39'),
(304, '364393000047326839', '25-26/BBSPL01510', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 07:13:14', '2025-05-02 07:13:39'),
(305, '364393000047326680', '25-26/BBSPL01509', '364393000000079797', 'FP BW Oxybrix-T/1KG', '211.86', '2025-05-02 07:11:12', '2025-05-02 07:11:33'),
(306, '364393000047326543', '25-26/BBSPL01508', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-02 07:09:43', '2025-05-02 07:09:56'),
(307, '364393000047326315', '25-26/BBSPL01507', '364393000000079741', 'FP BW Abolish/1KG', '850.00', '2025-05-02 07:07:32', '2025-05-02 07:07:51'),
(308, '364393000047326315', '25-26/BBSPL01507', '364393000000079797', 'FP BW Oxybrix-T/1KG', '211.86', '2025-05-02 07:07:32', '2025-05-02 07:07:51'),
(309, '364393000047326315', '25-26/BBSPL01507', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-02 07:07:32', '2025-05-02 07:07:51'),
(310, '364393000047326145', '25-26/BBSPL01506', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-02 07:05:09', '2025-05-02 07:05:28'),
(311, '364393000047326002', '25-26/BBSPL01505', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 07:03:50', '2025-05-02 07:04:15'),
(312, '364393000047326002', '25-26/BBSPL01505', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-02 07:03:50', '2025-05-02 07:04:15'),
(313, '364393000047323815', '25-26/BBSPL01504', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 06:57:53', '2025-05-02 06:58:13'),
(314, '364393000047323815', '25-26/BBSPL01504', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 06:57:53', '2025-05-02 06:58:13'),
(315, '364393000047323815', '25-26/BBSPL01504', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 06:57:53', '2025-05-02 06:58:13'),
(316, '364393000047323672', '25-26/BBSPL01503', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-02 06:56:23', '2025-05-02 06:56:59'),
(317, '364393000047323672', '25-26/BBSPL01503', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 06:56:23', '2025-05-02 06:56:59'),
(318, '364393000047323524', '25-26/BBSPL01502', '364393000005077887', 'FP BW Dominator-XL 20LT', '8200.00', '2025-05-02 06:53:36', '2025-05-02 06:53:57'),
(319, '364393000047323524', '25-26/BBSPL01502', '364393000000906039', 'FP BW Dominator XL/5LT', '2150.00', '2025-05-02 06:53:36', '2025-05-02 06:53:57'),
(320, '364393000047323387', '25-26/BBSPL01501', '364393000000079799', 'FP BW Oxybrix-T/5KG', '1016.95', '2025-05-02 06:51:43', '2025-05-02 06:52:03'),
(321, '364393000047323250', '25-26/BBSPL01500', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-02 06:50:10', '2025-05-02 06:50:47'),
(322, '364393000047323113', '25-26/BBSPL01499', '364393000005077887', 'FP BW Dominator-XL 20LT', '8200.00', '2025-05-02 06:48:37', '2025-05-02 06:49:07'),
(323, '364393000047320737', '25-26/BBSPL01498', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-02 06:41:16', '2025-05-02 06:42:05'),
(324, '364393000047320737', '25-26/BBSPL01498', '364393000000079781', 'FP BW K-Blue/10KG', '800.00', '2025-05-02 06:41:16', '2025-05-02 06:42:05'),
(325, '364393000047320737', '25-26/BBSPL01498', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-02 06:41:16', '2025-05-02 06:42:05'),
(326, '364393000047320737', '25-26/BBSPL01498', '364393000000079743', 'FP BW Bluesoft/1KG', '320.00', '2025-05-02 06:41:16', '2025-05-02 06:42:05'),
(327, '364393000047320737', '25-26/BBSPL01498', '364393000000079487', 'FP BW FOT 37/5LT', '296.61', '2025-05-02 06:41:16', '2025-05-02 06:42:05'),
(328, '364393000047320410', '25-26/BBSPL01497', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-02 06:38:34', '2025-05-02 06:39:28'),
(329, '364393000047320410', '25-26/BBSPL01497', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-02 06:38:34', '2025-05-02 06:39:28'),
(330, '364393000047320410', '25-26/BBSPL01497', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-02 06:38:34', '2025-05-02 06:39:28'),
(331, '364393000047320410', '25-26/BBSPL01497', '364393000000080115', 'FP BW Provitagel-BW/5LT', '650.00', '2025-05-02 06:38:34', '2025-05-02 06:39:28'),
(332, '364393000047320410', '25-26/BBSPL01497', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '490.00', '2025-05-02 06:38:34', '2025-05-02 06:39:28'),
(333, '364393000047320144', '25-26/BBSPL01496', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-02 06:34:15', '2025-05-02 06:34:43'),
(334, '364393000047320144', '25-26/BBSPL01496', '364393000000079735', 'FP BW Chill Zinc/1KG', '300.00', '2025-05-02 06:34:15', '2025-05-02 06:34:43'),
(335, '364393000047320144', '25-26/BBSPL01496', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', '800.00', '2025-05-02 06:34:15', '2025-05-02 06:34:43');
INSERT INTO `invoice_items` (`id`, `invoice_id`, `invoice_number`, `item_id`, `item_name`, `rate`, `created_at`, `updated_at`) VALUES
(336, '364393000047320144', '25-26/BBSPL01496', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-02 06:34:15', '2025-05-02 06:34:43'),
(337, '364393000047320144', '25-26/BBSPL01496', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-02 06:34:15', '2025-05-02 06:34:43'),
(338, '364393000047317757', '25-26/BBSPL01495', '364393000000079739', 'FP BW Abolish/500GM', '450.00', '2025-05-02 06:31:12', '2025-05-02 06:32:28'),
(339, '364393000047317757', '25-26/BBSPL01495', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-02 06:31:12', '2025-05-02 06:32:28'),
(340, '364393000047317757', '25-26/BBSPL01495', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-02 06:31:12', '2025-05-02 06:32:28'),
(341, '364393000047317757', '25-26/BBSPL01495', '364393000000079797', 'FP BW Oxybrix-T/1KG', '211.86', '2025-05-02 06:31:12', '2025-05-02 06:32:28'),
(342, '364393000047317529', '25-26/BBSPL01494', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-02 06:28:56', '2025-05-02 06:29:34'),
(343, '364393000047317529', '25-26/BBSPL01494', '364393000000080105', 'FP BW Flourishmin-10KG', '470.00', '2025-05-02 06:28:56', '2025-05-02 06:29:34'),
(344, '364393000047317529', '25-26/BBSPL01494', '364393000000757321', 'FP BW Livertreat-XL 2KG', '450.00', '2025-05-02 06:28:56', '2025-05-02 06:29:34'),
(345, '364393000047317312', '25-26/BBSPL01493', '364393000001189173', 'FP BW Ecofresh/10KG', '1500.00', '2025-05-02 06:27:27', '2025-05-02 06:27:38'),
(346, '364393000047317312', '25-26/BBSPL01493', '364393000000079771', 'FP BW Ammofree 99/1LT', '900.00', '2025-05-02 06:27:27', '2025-05-02 06:27:38'),
(347, '364393000047317312', '25-26/BBSPL01493', '364393000000715362', 'FP BW Oxybreeze/5KG', '762.71', '2025-05-02 06:27:27', '2025-05-02 06:27:38'),
(348, '364393000047317312', '25-26/BBSPL01493', '364393000000079799', 'FP BW Oxybrix-T/5KG', '1016.95', '2025-05-02 06:27:27', '2025-05-02 06:27:38'),
(349, '364393000047317312', '25-26/BBSPL01493', '364393000000079737', 'FP BW Odosweep/500GM', '0.00', '2025-05-02 06:27:27', '2025-05-02 06:27:38'),
(350, '364393000047317006', '25-26/BBSPL01492', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-02 06:24:06', '2025-05-02 06:24:18'),
(351, '364393000047317006', '25-26/BBSPL01492', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-02 06:24:06', '2025-05-02 06:24:18'),
(352, '364393000047317006', '25-26/BBSPL01492', '364393000000715362', 'FP BW Oxybreeze/5KG', '762.71', '2025-05-02 06:24:06', '2025-05-02 06:24:18'),
(353, '364393000047317006', '25-26/BBSPL01492', '364393000000079799', 'FP BW Oxybrix-T/5KG', '1016.95', '2025-05-02 06:24:06', '2025-05-02 06:24:18'),
(354, '364393000047317006', '25-26/BBSPL01492', '364393000000079737', 'FP BW Odosweep/500GM', '0.00', '2025-05-02 06:24:06', '2025-05-02 06:24:18'),
(355, '364393000047316821', '25-26/BBSPL01491', '364393000000715362', 'FP BW Oxybreeze/5KG', '762.71', '2025-05-02 06:19:44', '2025-05-02 06:25:20'),
(356, '364393000047316821', '25-26/BBSPL01491', '364393000012226123', 'FP BW ISOWEIGHT 500GM', '2100.00', '2025-05-02 06:19:44', '2025-05-02 06:25:20'),
(357, '364393000047316568', '25-26/BBSPL01490', '364393000000079799', 'FP BW Oxybrix-T/5KG', '1016.95', '2025-05-02 06:17:51', '2025-05-02 06:18:30'),
(358, '364393000047316568', '25-26/BBSPL01490', '364393000000927001', 'FP BW Bluegold Gel/17LT', '1700.00', '2025-05-02 06:17:51', '2025-05-02 06:18:30'),
(359, '364393000047316406', '25-26/BBSPL01489', '364393000000079487', 'FP BW FOT 37/5LT', '296.61', '2025-05-02 06:16:17', '2025-05-02 09:00:04'),
(360, '364393000047316252', '25-26/BBSPL01488', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 06:15:11', '2025-05-02 06:15:32'),
(361, '364393000047316252', '25-26/BBSPL01488', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 06:15:11', '2025-05-02 06:15:32'),
(362, '364393000047316252', '25-26/BBSPL01488', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 06:15:11', '2025-05-02 06:15:32'),
(363, '364393000047316109', '25-26/BBSPL01487', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 06:14:18', '2025-05-02 06:14:30'),
(364, '364393000047316109', '25-26/BBSPL01487', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-02 06:14:18', '2025-05-02 06:14:30'),
(365, '364393000047314966', '25-26/BBSPL01486', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 06:13:18', '2025-05-02 06:13:35'),
(366, '364393000047314966', '25-26/BBSPL01486', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-02 06:13:18', '2025-05-02 06:13:35'),
(367, '364393000047314752', '25-26/BBSPL01485', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 06:11:18', '2025-05-02 06:12:00'),
(368, '364393000047314752', '25-26/BBSPL01485', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 06:11:18', '2025-05-02 06:12:00'),
(369, '364393000047314752', '25-26/BBSPL01485', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 06:11:18', '2025-05-02 06:12:00'),
(370, '364393000047314752', '25-26/BBSPL01485', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-02 06:11:18', '2025-05-02 06:12:00'),
(371, '364393000047314620', '25-26/BBSPL01484', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 06:10:07', '2025-05-02 06:10:23'),
(372, '364393000047314472', '25-26/BBSPL01483', '364393000000079737', 'FP BW Odosweep/500GM', '900.00', '2025-05-02 06:09:17', '2025-05-02 06:09:30'),
(373, '364393000047314472', '25-26/BBSPL01483', '364393000000079731', 'FP BW Zeoweight/25KG', '750.00', '2025-05-02 06:09:17', '2025-05-02 06:09:30'),
(374, '364393000047314176', '25-26/BBSPL01482', '364393000000283116', 'FP BW Proclarify-9/1KG', '1400.00', '2025-05-02 06:06:26', '2025-05-02 06:07:25'),
(375, '364393000047314176', '25-26/BBSPL01482', '364393000000079797', 'FP BW Oxybrix-T/1KG', '211.86', '2025-05-02 06:06:26', '2025-05-02 06:07:25'),
(376, '364393000047311995', '25-26/BBSPL01481', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-02 06:04:18', '2025-05-02 06:04:29'),
(377, '364393000047311995', '25-26/BBSPL01481', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-02 06:04:18', '2025-05-02 06:04:29'),
(378, '364393000047311818', '25-26/BBSPL01480', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-02 06:03:01', '2025-05-02 06:03:13'),
(379, '364393000047311818', '25-26/BBSPL01480', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-02 06:03:01', '2025-05-02 06:03:13'),
(380, '364393000047311681', '25-26/BBSPL01479', '364393000005077887', 'FP BW Dominator-XL 20LT', '8200.00', '2025-05-02 06:01:47', '2025-05-02 06:01:59'),
(381, '364393000047311474', '25-26/BBSPL01478', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-02 06:00:06', '2025-05-02 06:00:50'),
(382, '364393000047311474', '25-26/BBSPL01478', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-02 06:00:06', '2025-05-02 06:00:50'),
(383, '364393000047311337', '25-26/BBSPL01477', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-02 05:58:57', '2025-05-02 05:59:10'),
(384, '364393000047311205', '25-26/BBSPL01476', '364393000000079737', 'FP BW Odosweep/500GM', '900.00', '2025-05-02 05:57:54', '2025-05-02 05:58:13'),
(385, '364393000047311004', '25-26/BBSPL01475', '364393000021135688', 'FP BW Twenty -20 Power Plus - 1 lt', '490.00', '2025-05-02 05:56:14', '2025-05-02 05:56:27'),
(386, '364393000047311004', '25-26/BBSPL01475', '364393000000079799', 'FP BW Oxybrix-T/5KG', '1016.95', '2025-05-02 05:56:14', '2025-05-02 05:56:27'),
(387, '364393000047311004', '25-26/BBSPL01475', '364393000000079791', 'FP BW Oxybreeze/1KG', '161.02', '2025-05-02 05:56:14', '2025-05-02 05:56:27'),
(388, '364393000047310855', '25-26/BBSPL01474', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-02 05:54:53', '2025-05-02 05:55:09'),
(389, '364393000047310723', '25-26/BBSPL01473', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 05:53:50', '2025-05-02 05:54:10'),
(390, '364393000047310569', '25-26/BBSPL01472', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 05:53:06', '2025-05-02 05:53:21'),
(391, '364393000047310569', '25-26/BBSPL01472', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 05:53:06', '2025-05-02 05:53:21'),
(392, '364393000047310569', '25-26/BBSPL01472', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 05:53:06', '2025-05-02 05:53:21'),
(393, '364393000047310415', '25-26/BBSPL01471', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 05:52:12', '2025-05-02 05:52:27'),
(394, '364393000047310415', '25-26/BBSPL01471', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 05:52:12', '2025-05-02 05:52:27'),
(395, '364393000047310415', '25-26/BBSPL01471', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 05:52:12', '2025-05-02 05:52:27'),
(396, '364393000047310278', '25-26/BBSPL01470', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-02 05:51:01', '2025-05-02 05:51:17'),
(397, '364393000047310108', '25-26/BBSPL01469', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-02 05:50:00', '2025-05-02 05:50:15'),
(398, '364393000047310108', '25-26/BBSPL01469', '364393000000079781', 'FP BW K-Blue/10KG', '800.00', '2025-05-02 05:50:00', '2025-05-02 05:50:15'),
(399, '364393000047310108', '25-26/BBSPL01469', '364393000000079777', 'FP BW Mag-Do-Mix/20KG', '780.00', '2025-05-02 05:50:00', '2025-05-02 05:50:15'),
(400, '364393000047310108', '25-26/BBSPL01469', '364393000000080093', 'FP BW Citrix-100/500GM', '900.00', '2025-05-02 05:50:00', '2025-05-02 05:50:15'),
(401, '364393000047308971', '25-26/BBSPL01468', '364393000000906039', 'FP BW Dominator XL/5LT', '2150.00', '2025-05-02 05:48:30', '2025-05-02 05:48:48'),
(402, '364393000047308802', '25-26/BBSPL01467', '364393000000080103', 'FP BW Profish-BW/10KG', '900.00', '2025-05-02 05:43:07', '2025-05-02 05:45:59'),
(403, '364393000047308802', '25-26/BBSPL01467', '364393000000080105', 'FP BW Flourishmin-10KG', '470.00', '2025-05-02 05:43:07', '2025-05-02 05:45:59'),
(404, '364393000047308802', '25-26/BBSPL01467', '364393000000757321', 'FP BW Livertreat-XL 2KG', '450.00', '2025-05-02 05:43:07', '2025-05-02 05:45:59'),
(405, '364393000047308665', '25-26/BBSPL01466', '364393000000080111', 'FP BW Bluegold Gel/5LT', '500.00', '2025-05-02 05:41:29', '2025-05-02 05:41:48'),
(406, '364393000047308474', '25-26/BBSPL01465', '364393000025445127', 'FP BW POWERPAC - 7 5 KG', '8900.00', '2025-05-02 05:40:21', '2025-05-02 05:40:36'),
(407, '364393000047308474', '25-26/BBSPL01465', '364393000000283116', 'FP BW Proclarify-9/1KG', '1400.00', '2025-05-02 05:40:21', '2025-05-02 05:40:36'),
(408, '364393000047308474', '25-26/BBSPL01465', '364393000000079735', 'FP BW Chill Zinc/1KG', '300.00', '2025-05-02 05:40:21', '2025-05-02 05:40:36'),
(409, '364393000047308474', '25-26/BBSPL01465', '364393000026422701', 'FP BW ZEOWEIGHT GRANULES 10KG', '650.00', '2025-05-02 05:40:21', '2025-05-02 05:40:36'),
(410, '364393000047308474', '25-26/BBSPL01465', '364393000000485238', 'FP BW MEGASTAMINIZER 1KG', '0.00', '2025-05-02 05:40:21', '2025-05-02 05:40:36'),
(411, '364393000047308271', '25-26/BBSPL01464', '364393000000715251', 'FP BW Growmin BW+/10KG', '700.00', '2025-05-02 05:38:00', '2025-05-02 05:38:35'),
(412, '364393000047308271', '25-26/BBSPL01464', '364393000025445184', 'FP BW POWERPAC - 7 500 GM', '900.00', '2025-05-02 05:38:00', '2025-05-02 05:38:35'),
(413, '364393000047308271', '25-26/BBSPL01464', '364393000000927001', 'FP BW Bluegold Gel/17LT', '1700.00', '2025-05-02 05:38:00', '2025-05-02 05:38:35'),
(414, '364393000047308271', '25-26/BBSPL01464', '364393000000079737', 'FP BW Odosweep/500GM', '0.00', '2025-05-02 05:38:00', '2025-05-02 05:38:35'),
(415, '364393000047308139', '25-26/BBSPL01463', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 05:34:17', '2025-05-02 05:34:32'),
(416, '364393000047307985', '25-26/BBSPL01462', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 05:33:02', '2025-05-02 05:33:31'),
(417, '364393000047307985', '25-26/BBSPL01462', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 05:33:02', '2025-05-02 05:33:31'),
(418, '364393000047307985', '25-26/BBSPL01462', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 05:33:02', '2025-05-02 05:33:31'),
(419, '364393000047307853', '25-26/BBSPL01461', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-02 05:28:53', '2025-05-02 05:29:03'),
(420, '364393000047307666', '25-26/BBSPL01460', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 05:27:13', '2025-05-02 05:27:27'),
(421, '364393000047307666', '25-26/BBSPL01460', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 05:27:13', '2025-05-02 05:27:27'),
(422, '364393000047307666', '25-26/BBSPL01460', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 05:27:13', '2025-05-02 05:27:27'),
(423, '364393000047307485', '25-26/BBSPL01459', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 05:26:02', '2025-05-02 05:26:28'),
(424, '364393000047307353', '25-26/BBSPL01458', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 05:25:21', '2025-05-02 05:25:34'),
(425, '364393000047307199', '25-26/BBSPL01457', '364393000000964020', 'FP CASB WSP1/1K', '0.59', '2025-05-02 05:24:37', '2025-05-02 05:24:57'),
(426, '364393000047307199', '25-26/BBSPL01457', '364393000000964063', 'FP CASB WSP2/1K', '0.59', '2025-05-02 05:24:37', '2025-05-02 05:24:57'),
(427, '364393000047307199', '25-26/BBSPL01457', '364393000000964106', 'FP CASB WSP3/1K', '0.47', '2025-05-02 05:24:37', '2025-05-02 05:24:57'),
(428, '364393000047307050', '25-26/BBSPL01456', '364393000000079799', 'FP BW Oxybrix-T/5KG', '1016.95', '2025-05-02 05:23:11', '2025-05-02 05:23:50'),
(429, '364393000047306877', '25-26/BBSPL01455', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-02 05:22:06', '2025-05-02 05:22:19'),
(430, '364393000047306877', '25-26/BBSPL01455', '364393000000079771', 'FP BW Ammofree 99/1LT', '900.00', '2025-05-02 05:22:06', '2025-05-02 05:22:19'),
(431, '364393000047306740', '25-26/BBSPL01454', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-02 05:20:57', '2025-05-02 05:21:12'),
(432, '364393000047306603', '25-26/BBSPL01453', '364393000000906039', 'FP BW Dominator XL/5LT', '2150.00', '2025-05-02 05:20:04', '2025-05-02 05:20:17'),
(433, '364393000047306433', '25-26/BBSPL01452', '364393000000080093', 'FP BW Citrix-100/500GM', '900.00', '2025-05-02 05:18:18', '2025-05-02 05:18:34'),
(434, '364393000047306257', '25-26/BBSPL01451', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 05:16:15', '2025-05-02 05:16:31'),
(435, '364393000047306257', '25-26/BBSPL01451', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-02 05:16:15', '2025-05-02 05:16:31'),
(436, '364393000047306116', '25-26/BBSPL01450', '364393000000975254', 'FP VW DS/1L', '0.65', '2025-05-02 05:15:15', '2025-05-02 05:15:28'),
(437, '364393000047306116', '25-26/BBSPL01450', '364393000000975340', 'FP VW EM/1L', '1.35', '2025-05-02 05:15:15', '2025-05-02 05:15:28'),
(438, '364393000047304935', '25-26/BBSPL01449', '364393000018299499', 'FP BW Twenty-20 Power Plus 20LT', '9000.00', '2025-05-02 05:13:18', '2025-05-02 05:13:36'),
(439, '364393000047304935', '25-26/BBSPL01449', '364393000018299790', 'FP BW Twenty-20 Power Plus 5LT', '2300.00', '2025-05-02 05:13:18', '2025-05-02 05:13:36'),
(440, '364393000047304798', '25-26/BBSPL01448', '364393000001189173', 'FP BW Ecofresh/10KG', '1500.00', '2025-05-02 05:12:12', '2025-05-02 05:12:23');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `item_id` varchar(255) NOT NULL DEFAULT '',
  `item_name` varchar(255) NOT NULL,
  `description` text,
  `type` enum('Inventory Item','Non-inventory Item','Category','Expense','Assembly','Item Group','Service','Labor','Overhead','Other') DEFAULT 'Inventory Item',
  `category` varchar(255) DEFAULT NULL,
  `sales_price` decimal(10,2) DEFAULT NULL,
  `min_sales_price` decimal(10,2) DEFAULT NULL,
  `track_serial_numbers` tinyint(1) DEFAULT '0',
  `track_lot_numbers` tinyint(1) DEFAULT '0',
  `income_account` varchar(255) DEFAULT NULL,
  `asset_account` varchar(255) DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `warranty` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `web_address` varchar(255) DEFAULT NULL,
  `purchase_description` text,
  `purchase_cost` decimal(10,2) DEFAULT NULL,
  `preferred_vendor` varchar(255) DEFAULT NULL,
  `vendor_part_number` varchar(255) DEFAULT NULL,
  `customer_part_number` varchar(255) DEFAULT NULL,
  `max_stock_level` int(11) DEFAULT NULL,
  `reorder_point` int(11) DEFAULT NULL,
  `lead_time` int(11) DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `weight_unit` enum('lb','oz','kg','g') DEFAULT 'lb',
  `volume` decimal(10,2) DEFAULT NULL,
  `volume_unit` enum('cbm') DEFAULT 'cbm',
  `sync_with_quickbooks` tinyint(1) DEFAULT '0',
  `taxable` tinyint(1) DEFAULT '0',
  `commission_exempt` tinyint(1) DEFAULT '0',
  `percent_commission` decimal(5,2) DEFAULT NULL,
  `per_unit_commission` decimal(10,2) DEFAULT NULL,
  `used_on_sales_forms` tinyint(1) DEFAULT '0',
  `used_on_purchasing_forms` tinyint(1) DEFAULT '0',
  `used_on_manufacturing_forms` tinyint(1) DEFAULT '0',
  `tags` varchar(255) DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `item_id`, `item_name`, `description`, `type`, `category`, `sales_price`, `min_sales_price`, `track_serial_numbers`, `track_lot_numbers`, `income_account`, `asset_account`, `barcode`, `warranty`, `sku`, `picture`, `web_address`, `purchase_description`, `purchase_cost`, `preferred_vendor`, `vendor_part_number`, `customer_part_number`, `max_stock_level`, `reorder_point`, `lead_time`, `weight`, `weight_unit`, `volume`, `volume_unit`, `sync_with_quickbooks`, `taxable`, `commission_exempt`, `percent_commission`, `per_unit_commission`, `used_on_sales_forms`, `used_on_purchasing_forms`, `used_on_manufacturing_forms`, `tags`, `notes`, `created_at`, `updated_at`) VALUES
(1, '364393000000906511', 'BAGS Zeoweight', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-05 04:21:17', '2025-05-05 04:21:17'),
(2, '364393000000260706', 'BATCH L-ALGACURE', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-05 04:21:34', '2025-05-05 04:21:34'),
(3, '364393000046650231', 'Finished', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-05 04:59:57', '2025-05-05 04:59:57'),
(4, '364393000047524298', 'Argocure 500 ml', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-08 09:14:42', '2025-05-18 06:29:03'),
(5, '364393000047708239', 'Batch L Algacure', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-14 11:13:36', '2025-05-14 11:13:36'),
(6, '364393000045713031', 'salt test', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-23 07:38:39', '2025-05-23 07:38:39'),
(7, '364393000001022004', 'Test Item1', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-23 10:10:35', '2025-05-23 10:10:35'),
(8, '364393000000975452', 'TEST ITEM10', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-23 10:35:42', '2025-05-23 10:35:42'),
(9, '364393000046944070', 'Testing item', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-23 10:40:10', '2025-05-23 10:40:10'),
(10, '364393000046388556', 'BATCH P Growmin BW Plus', '', 'Assembly', '', NULL, NULL, 0, 0, NULL, NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'lb', NULL, 'cbm', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '', '2025-05-26 06:13:25', '2025-05-26 06:13:25');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(11) NOT NULL,
  `menu_name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `menu_name`, `parent_id`, `url`, `icon`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 'Dashboard', NULL, 'index.php', 'fas fa-tachometer-alt', 1, '2025-04-12 01:59:21', '2025-05-19 15:46:13'),
(2, 'Production', NULL, NULL, 'fas fa-industry', 2, '2025-04-12 01:59:21', '2025-04-12 01:59:21'),
(3, 'Inventory', NULL, NULL, 'fas fa-boxes', 3, '2025-04-12 01:59:21', '2025-04-12 01:59:21'),
(4, 'Purchasing', NULL, NULL, 'fas fa-shopping-cart', 4, '2025-04-12 01:59:21', '2025-04-12 01:59:21'),
(5, 'Sales', NULL, NULL, 'fas fa-chart-line', 5, '2025-04-12 01:59:21', '2025-04-12 01:59:21'),
(6, 'Fulfilment', NULL, NULL, 'fas fa-shipping-fast', 6, '2025-04-12 01:59:21', '2025-04-12 01:59:21'),
(7, 'Transactions', NULL, NULL, 'fas fa-exchange-alt', 7, '2025-04-12 01:59:21', '2025-04-12 01:59:21'),
(8, 'Reports', NULL, 'reports', 'fas fa-chart-pie', 8, '2025-04-12 01:59:21', '2025-04-12 01:59:21'),
(9, 'Admin', NULL, NULL, 'fas fa-cogs', 9, '2025-04-12 01:59:21', '2025-04-12 01:59:21'),
(10, 'Calendar', NULL, 'calendar', 'fas fa-calendar-alt', 10, '2025-04-12 01:59:21', '2025-04-12 01:59:21'),
(11, 'Builds', 2, '/production/builds.php', NULL, 1, '2025-04-12 01:59:22', '2025-05-05 09:59:17'),
(12, 'Processes', 2, '/production/process.php', NULL, 2, '2025-04-12 01:59:22', '2025-05-05 10:31:31'),
(13, 'Process Template', 2, '/production/process-template.php', NULL, 3, '2025-04-12 01:59:22', '2025-05-08 11:46:54'),
(14, 'Jobs', 2, '#', NULL, 4, '2025-04-12 01:59:22', '2025-05-05 09:59:55'),
(15, 'Work Orders', 2, '#', NULL, 5, '2025-04-12 01:59:22', '2025-05-05 09:59:56'),
(16, 'Items', 3, '/inventory/items.php', NULL, 1, '2025-04-12 01:59:22', '2025-05-05 10:00:08'),
(17, 'Adjustment', 3, '/inventory/adjustments.php', NULL, 2, '2025-04-12 01:59:22', '2025-05-05 15:28:11'),
(18, 'Transfers', 3, '#', NULL, 3, '2025-04-12 01:59:22', '2025-05-05 10:08:34'),
(19, 'Serial Inventory', 3, '#', NULL, 4, '2025-04-12 01:59:22', '2025-05-05 10:08:32'),
(20, 'Lots', 3, '#', NULL, 5, '2025-04-12 01:59:22', '2025-05-05 10:08:36'),
(21, 'Vendors', 4, '/purchasing/vendors.php', NULL, 1, '2025-04-12 01:59:22', '2025-05-05 10:10:46'),
(22, 'Purchase Orders', 4, '#', NULL, 2, '2025-04-12 01:59:22', '2025-05-05 10:10:56'),
(23, 'Item Receipts', 4, '#', NULL, 3, '2025-04-12 01:59:22', '2025-05-05 10:10:58'),
(24, 'Returns to Vendors', 4, '#', NULL, 4, '2025-04-12 01:59:22', '2025-05-05 10:11:00'),
(25, 'Reorder List', 4, '#', NULL, 5, '2025-04-12 01:59:22', '2025-05-05 10:11:01'),
(26, 'Bills', 4, '#', NULL, 6, '2025-04-12 01:59:22', '2025-05-05 10:11:03'),
(27, 'Orders', 5, '#', NULL, 1, '2025-04-12 01:59:22', '2025-05-05 10:11:04'),
(28, 'Invoices', 5, '#', NULL, 2, '2025-04-12 01:59:22', '2025-05-05 10:11:06'),
(29, 'Customers', 5, '#', NULL, 3, '2025-04-12 01:59:22', '2025-05-05 10:11:08'),
(30, 'Payments', 5, '#', NULL, 4, '2025-04-12 01:59:22', '2025-05-05 10:11:10'),
(31, 'Clients', 5, '#', NULL, 5, '2025-04-12 01:59:22', '2025-05-05 10:11:11'),
(32, 'Pick Tickets', 6, '#', NULL, 1, '2025-04-12 01:59:22', '2025-05-05 10:11:13'),
(33, 'Shipments', 6, '#', NULL, 2, '2025-04-12 01:59:22', '2025-05-05 10:11:15'),
(34, 'Transfers', 7, '#', NULL, 1, '2025-04-12 01:59:22', '2025-05-05 10:11:16'),
(35, 'Returns', 7, '#', NULL, 2, '2025-04-12 01:59:22', '2025-05-05 10:11:17'),
(36, 'Write-Offs', 7, '#', NULL, 3, '2025-04-12 01:59:22', '2025-05-05 10:11:19'),
(37, 'Users', 9, '/admin/users.php', NULL, 1, '2025-04-12 01:59:22', '2025-05-05 10:11:29'),
(38, 'Roles', 9, '/admin/roles.php', NULL, 2, '2025-04-12 01:59:22', '2025-05-05 10:11:34');

-- --------------------------------------------------------

--
-- Table structure for table `process_templates`
--

CREATE TABLE `process_templates` (
  `id` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `template_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `total` float NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `process_templates`
--

INSERT INTO `process_templates` (`id`, `date_time`, `template_name`, `description`, `total`, `created_at`) VALUES
(1, '2025-05-08 06:22:00', 'Testing Tempalte', 'Testing Tempalte', 0, '2025-05-08 06:23:27'),
(2, '2025-05-10 02:55:00', 'Testing Template', 'No Description', 0, '2025-05-10 02:55:55'),
(3, '2025-05-10 02:57:00', 'Testing with Decimal', 'Testing with Decimal', 0, '2025-05-10 02:57:38'),
(4, '2025-05-16 07:03:00', 'Process Template', 'No Description', 0, '2025-05-16 07:05:01'),
(5, '2025-05-21 06:57:00', 'Evefresh', 'No Description', 0, '2025-05-21 01:31:23'),
(6, '2025-05-21 01:39:00', 'Evefresh Testing', 'Evefresh Testing', 0, '2025-05-21 01:41:13'),
(7, '2025-05-28 13:05:00', 'Test', 'Test', 0, '2025-05-28 07:36:06');

-- --------------------------------------------------------

--
-- Table structure for table `process_template_items`
--

CREATE TABLE `process_template_items` (
  `id` int(11) NOT NULL,
  `process_template_id` int(11) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `quantity` float NOT NULL,
  `cost_each` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `type` enum('input','output') NOT NULL,
  `item_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `process_template_items`
--

INSERT INTO `process_template_items` (`id`, `process_template_id`, `item_id`, `quantity`, `cost_each`, `total`, `type`, `item_name`) VALUES
(1, 1, '364393000046650231', 1, '700.00', '700.00', 'input', 'Finished'),
(2, 1, '364393000046638449', 2, '70.00', '140.00', 'output', 'Raw1'),
(3, 1, '364393000046638510', 2, '80.00', '160.00', 'output', 'Raw2'),
(4, 2, '364393000046650231', 1, '800.00', '720.00', 'input', 'Finished'),
(5, 2, '364393000047524298', 0, '535.00', '107.00', 'output', 'Argocure 500 ml'),
(6, 3, '364393000046650231', 0.1, '800.00', '80.00', 'input', 'Finished'),
(7, 3, '364393000046638449', 0.2, '70.00', '14.00', 'output', 'Raw1'),
(8, 4, '364393000046650231', 1, '800.00', '800.00', 'input', 'Finished'),
(9, 4, '364393000046638449', 12, '70.00', '840.00', 'output', 'Raw1'),
(10, 4, '364393000046638510', 3, '80.00', '240.00', 'output', 'Raw2'),
(11, 5, '364393000045975920', 150, '100.00', '15000.00', 'input', 'RPX Quartz Powder'),
(12, 5, '364393000045973217', 100, '100.00', '10000.00', 'input', 'RPX Dolomite Powder Export Quality'),
(13, 5, '364393000045974543', 50, '1000.00', '50000.00', 'input', 'RPX Liquid Yucca'),
(14, 5, '364393000047724171', 100, '0.00', '0.00', 'input', 'Batch P Multizyme'),
(15, 5, '364393000045977297', 10, '1350.00', '13500.00', 'input', 'RPX White Gut  (probiotic)'),
(16, 5, '364393000045977711', 100, '710.00', '71000.00', 'input', 'RPX Aerosil'),
(17, 5, '364393000000079759', 400, '800.00', '320000.00', 'output', 'FP BW Everfresh Pro Biofloc-500GM'),
(18, 6, '364393000000079759', 100, '800.00', '80000.00', 'input', 'FP BW Everfresh Pro Biofloc-500GM'),
(19, 6, '364393000045975920', 1, '100.00', '100.00', 'output', 'RPX Quartz Powder'),
(20, 6, '364393000045973217', 1, '100.00', '100.00', 'output', 'RPX Dolomite Powder Export Quality'),
(21, 6, '364393000045974543', 1, '1000.00', '1000.00', 'output', 'RPX Liquid Yucca'),
(22, 6, '364393000047724171', 1, '0.00', '0.00', 'output', 'Batch P Multizyme'),
(23, 6, '364393000045977297', 1, '1350.00', '1350.00', 'output', 'RPX White Gut  (probiotic)'),
(24, 6, '364393000045977711', 1, '710.00', '710.00', 'output', 'RPX Aerosil'),
(25, 7, '364393000047708302', 12, '0.00', '0.00', 'input', 'Batch L Bluebest'),
(26, 7, '364393000046638449', 12, '70.00', '840.00', 'output', 'Raw1'),
(27, 7, '364393000046638510', 13, '80.00', '1040.00', 'output', 'Raw2');

-- --------------------------------------------------------

--
-- Table structure for table `process_transaction`
--

CREATE TABLE `process_transaction` (
  `id` int(11) NOT NULL,
  `template_name` varchar(255) NOT NULL,
  `process_transaction_number` varchar(100) NOT NULL,
  `date_time` datetime NOT NULL,
  `template_description` text,
  `start_date` date NOT NULL,
  `work_center` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `multiplier` int(11) DEFAULT '1',
  `comments` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `file_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `process_transaction`
--

INSERT INTO `process_transaction` (`id`, `template_name`, `process_transaction_number`, `date_time`, `template_description`, `start_date`, `work_center`, `location`, `multiplier`, `comments`, `created_at`, `file_path`) VALUES
(1, 'Testing Tempalte', '', '2025-05-08 06:34:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 06:49:06', NULL),
(2, 'Testing Tempalte', '', '2025-05-08 06:49:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 06:49:19', NULL),
(3, 'Testing Tempalte', '', '2025-05-08 06:49:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 06:49:28', NULL),
(4, 'Testing Tempalte', '', '2025-05-08 06:50:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 06:50:19', NULL),
(5, 'Testing Tempalte', '', '2025-05-08 06:50:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 06:50:39', NULL),
(6, 'Testing Tempalte', '', '2025-05-08 06:53:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 06:53:29', NULL),
(7, 'Testing Tempalte', '', '2025-05-08 06:55:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 06:55:14', NULL),
(8, 'Testing Tempalte', '', '2025-05-08 06:57:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 06:57:27', NULL),
(9, 'Testing Tempalte', '', '2025-05-08 06:59:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 06:59:47', NULL),
(10, 'Testing Tempalte', '', '2025-05-08 07:33:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 07:33:32', NULL),
(11, 'Testing Tempalte', '', '2025-05-08 07:47:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 07:47:36', NULL),
(12, 'Testing Tempalte', '', '2025-05-08 07:51:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 07:52:29', NULL),
(13, 'Testing Tempalte', '', '2025-05-08 07:58:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 07:59:13', NULL),
(14, 'Testing Tempalte', '', '2025-05-08 07:59:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 08:00:24', NULL),
(15, 'Testing Tempalte', '', '2025-05-08 08:02:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 08:02:52', NULL),
(16, 'Testing Tempalte', '', '2025-05-08 08:04:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 08:05:15', NULL),
(17, 'Testing Tempalte', '', '2025-05-08 08:06:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 08:06:35', NULL),
(18, 'Testing Tempalte', '', '2025-05-08 08:07:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 08:08:08', NULL),
(19, 'Testing Tempalte', '', '2025-05-08 08:19:00', 'Testing Tempalte', '2025-05-08', 'Finished Goods', 'Default', NULL, '', '2025-05-08 08:19:58', NULL),
(20, 'Testing with Decimal', '', '2025-05-10 02:58:00', 'Testing with Decimal', '2025-05-10', 'Finished Goods', 'Default', NULL, '', '2025-05-10 02:58:14', NULL),
(21, 'Process Template', '', '2025-05-16 10:58:00', 'No Description', '2025-05-16', 'Finished Goods', 'Default', NULL, '', '2025-05-16 10:58:22', NULL),
(22, 'Testing Tempalte', '', '2025-05-21 06:56:00', 'Testing Tempalte', '2025-05-21', 'Finished Goods', 'Default', NULL, '', '2025-05-21 01:27:13', NULL),
(23, 'Evefresh', '', '2025-05-21 07:01:00', 'No Description', '2025-05-21', 'Finished Goods', 'Default', NULL, '', '2025-05-21 01:31:45', NULL),
(24, 'Evefresh Testing', '', '2025-05-21 01:41:00', 'Evefresh Testing', '2025-05-21', 'Finished Goods', 'Default', NULL, '', '2025-05-21 01:41:38', NULL),
(25, 'Testing Tempalte', '', '2025-05-28 12:48:00', 'Testing Tempalte', '2025-05-28', 'Finished Goods', 'Default', NULL, '', '2025-05-28 07:26:36', NULL),
(26, 'Test', '', '2025-05-28 13:06:00', 'Test', '2025-05-28', 'Finished Goods', 'Default', NULL, '', '2025-05-28 07:36:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `process_transaction_items`
--

CREATE TABLE `process_transaction_items` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `item_type` enum('input','output') NOT NULL,
  `item_id` varchar(100) NOT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `quantity` float NOT NULL,
  `cost_each` float NOT NULL,
  `total` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `process_transaction_items`
--

INSERT INTO `process_transaction_items` (`id`, `transaction_id`, `item_type`, `item_id`, `item_name`, `quantity`, `cost_each`, `total`, `created_at`) VALUES
(1, 1, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 06:49:06'),
(2, 1, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 06:49:06'),
(3, 1, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 06:49:06'),
(4, 2, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 06:49:19'),
(5, 2, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 06:49:19'),
(6, 2, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 06:49:19'),
(7, 3, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 06:49:28'),
(8, 3, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 06:49:28'),
(9, 3, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 06:49:28'),
(10, 4, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 06:50:19'),
(11, 4, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 06:50:19'),
(12, 4, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 06:50:19'),
(13, 5, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 06:50:39'),
(14, 5, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 06:50:39'),
(15, 5, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 06:50:39'),
(16, 6, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 06:53:29'),
(17, 6, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 06:53:29'),
(18, 6, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 06:53:29'),
(19, 7, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 06:55:14'),
(20, 7, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 06:55:14'),
(21, 7, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 06:55:14'),
(22, 8, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 06:57:27'),
(23, 8, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 06:57:27'),
(24, 8, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 06:57:27'),
(25, 9, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 06:59:47'),
(26, 9, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 06:59:47'),
(27, 9, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 06:59:47'),
(28, 10, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 07:33:32'),
(29, 10, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 07:33:32'),
(30, 10, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 07:33:32'),
(31, 11, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 07:47:36'),
(32, 11, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 07:47:36'),
(33, 11, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 07:47:36'),
(34, 12, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 07:52:29'),
(35, 12, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 07:52:29'),
(36, 12, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 07:52:29'),
(37, 13, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 07:59:13'),
(38, 13, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 07:59:13'),
(39, 13, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 07:59:13'),
(40, 14, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 08:00:24'),
(41, 14, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 08:00:24'),
(42, 14, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 08:00:24'),
(43, 15, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 08:02:52'),
(44, 15, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 08:02:52'),
(45, 15, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 08:02:52'),
(46, 16, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 08:05:15'),
(47, 16, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 08:05:15'),
(48, 16, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 08:05:15'),
(49, 17, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 08:06:35'),
(50, 17, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 08:06:35'),
(51, 17, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 08:06:35'),
(52, 18, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 08:08:08'),
(53, 18, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 08:08:08'),
(54, 18, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 08:08:08'),
(55, 19, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-08 08:19:58'),
(56, 19, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-08 08:19:58'),
(57, 19, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-08 08:19:58'),
(58, 20, 'input', '364393000046650231', 'Finished', 0.1, 800, 80, '2025-05-10 02:58:14'),
(59, 20, 'output', '364393000046638449', 'Raw1', 0.2, 70, 14, '2025-05-10 02:58:14'),
(60, 21, 'input', '364393000046650231', 'Finished', 1, 800, 800, '2025-05-16 10:58:22'),
(61, 21, 'output', '364393000046638449', 'Raw1', 12, 70, 840, '2025-05-16 10:58:22'),
(62, 21, 'output', '364393000046638510', 'Raw2', 3, 80, 240, '2025-05-16 10:58:22'),
(63, 22, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-21 01:27:13'),
(64, 22, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-21 01:27:13'),
(65, 22, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-21 01:27:13'),
(66, 23, 'input', '364393000045975920', 'RPX Quartz Powder', 150, 100, 15000, '2025-05-21 01:31:45'),
(67, 23, 'input', '364393000045973217', 'RPX Dolomite Powder Export Quality', 100, 100, 10000, '2025-05-21 01:31:45'),
(68, 23, 'input', '364393000045974543', 'RPX Liquid Yucca', 50, 1000, 50000, '2025-05-21 01:31:45'),
(69, 23, 'input', '364393000047724171', 'Batch P Multizyme', 100, 0, 0, '2025-05-21 01:31:45'),
(70, 23, 'input', '364393000045977297', 'RPX White Gut (probiotic)', 10, 1350, 13500, '2025-05-21 01:31:45'),
(71, 23, 'input', '364393000045977711', 'RPX Aerosil', 100, 710, 71000, '2025-05-21 01:31:45'),
(72, 23, 'output', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', 400, 800, 320000, '2025-05-21 01:31:45'),
(73, 24, 'input', '364393000000079759', 'FP BW Everfresh Pro Biofloc-500GM', 100, 800, 80000, '2025-05-21 01:41:38'),
(74, 24, 'output', '364393000045975920', 'RPX Quartz Powder', 1, 100, 100, '2025-05-21 01:41:38'),
(75, 24, 'output', '364393000045973217', 'RPX Dolomite Powder Export Quality', 1, 100, 100, '2025-05-21 01:41:38'),
(76, 24, 'output', '364393000045974543', 'RPX Liquid Yucca', 1, 1000, 1000, '2025-05-21 01:41:38'),
(77, 24, 'output', '364393000047724171', 'Batch P Multizyme', 1, 0, 0, '2025-05-21 01:41:38'),
(78, 24, 'output', '364393000045977297', 'RPX White Gut (probiotic)', 1, 1350, 1350, '2025-05-21 01:41:38'),
(79, 24, 'output', '364393000045977711', 'RPX Aerosil', 1, 710, 710, '2025-05-21 01:41:38'),
(80, 25, 'input', '364393000046650231', 'Finished', 1, 700, 700, '2025-05-28 07:26:36'),
(81, 25, 'output', '364393000046638449', 'Raw1', 2, 70, 140, '2025-05-28 07:26:36'),
(82, 25, 'output', '364393000046638510', 'Raw2', 2, 80, 160, '2025-05-28 07:26:36'),
(83, 26, 'input', '364393000047708302', 'Batch L Bluebest', 12, 0, 0, '2025-05-28 07:36:31'),
(84, 26, 'output', '364393000046638449', 'Raw1', 12, 70, 840, '2025-05-28 07:36:31'),
(85, 26, 'output', '364393000046638510', 'Raw2', 13, 80, 1040, '2025-05-28 07:36:31');

-- --------------------------------------------------------

--
-- Table structure for table `role_menus`
--

CREATE TABLE `role_menus` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role_menus`
--

INSERT INTO `role_menus` (`role_id`, `menu_id`) VALUES
(1, 1),
(1, 2),
(3, 2),
(1, 3),
(3, 3),
(1, 4),
(1, 5),
(6, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(3, 11),
(1, 12),
(3, 12),
(1, 13),
(3, 13),
(1, 14),
(3, 14),
(1, 15),
(3, 15),
(1, 16),
(3, 16),
(1, 17),
(3, 17),
(1, 18),
(3, 18),
(1, 19),
(3, 19),
(1, 20),
(3, 20),
(1, 21),
(1, 22),
(1, 23),
(1, 24),
(1, 25),
(1, 26),
(1, 27),
(6, 27),
(1, 28),
(6, 28),
(1, 29),
(6, 29),
(1, 30),
(6, 30),
(1, 31),
(6, 31),
(1, 32),
(1, 33),
(1, 34),
(1, 35),
(1, 36),
(1, 37),
(1, 38);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `gender` enum('male','female') CHARACTER SET utf8 NOT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `image` varchar(250) DEFAULT NULL,
  `type` varchar(250) NOT NULL DEFAULT 'general',
  `status` enum('active','pending','deleted','') NOT NULL DEFAULT 'pending',
  `authtoken` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `gender`, `mobile`, `designation`, `image`, `type`, `status`, `authtoken`) VALUES
(1, 'BW', 'Admin', 'admin@bw.com', '202cb962ac59075b964b07152d234b70', 'male', '123456789', 'Web developer', '', 'admin', 'active', ''),
(2, 'Krishna Kanth', 'Hanumanthu', 'krishnakanthhanumanthu@gmail.com', '7cee6005d3e56b10f94926c2c3c7ba43', 'male', NULL, NULL, NULL, 'Probiotics', 'active', '73f66749989c7b09389894f1b27daa738da1afe89132e1ad8357d8dfd308738b');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `role_name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', '2025-04-11 08:35:19', '2025-04-12 17:42:04'),
(3, 'Probiotics', '2025-04-11 08:44:09', '2025-04-12 17:42:17'),
(6, 'Production', '2025-04-14 04:44:47', '2025-04-14 04:45:10');

-- --------------------------------------------------------

--
-- Table structure for table `zoho_bill_items`
--

CREATE TABLE `zoho_bill_items` (
  `id` int(11) NOT NULL,
  `item_id` varchar(50) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `adjustment_items`
--
ALTER TABLE `adjustment_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adjustment_id` (`adjustment_id`);

--
-- Indexes for table `batch_total`
--
ALTER TABLE `batch_total`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_item_id` (`item_id`);

--
-- Indexes for table `bill_items`
--
ALTER TABLE `bill_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bill_of_materials`
--
ALTER TABLE `bill_of_materials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `builds`
--
ALTER TABLE `builds`
  ADD PRIMARY KEY (`build_id`),
  ADD UNIQUE KEY `build_number` (`build_number`);

--
-- Indexes for table `build_items`
--
ALTER TABLE `build_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `build_id` (`build_id`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_id` (`item_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `process_templates`
--
ALTER TABLE `process_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `process_template_items`
--
ALTER TABLE `process_template_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `process_template_id` (`process_template_id`);

--
-- Indexes for table `process_transaction`
--
ALTER TABLE `process_transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `process_transaction_items`
--
ALTER TABLE `process_transaction_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`);

--
-- Indexes for table `role_menus`
--
ALTER TABLE `role_menus`
  ADD PRIMARY KEY (`role_id`,`menu_id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zoho_bill_items`
--
ALTER TABLE `zoho_bill_items`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `adjustment_items`
--
ALTER TABLE `adjustment_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `batch_total`
--
ALTER TABLE `batch_total`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `bill_items`
--
ALTER TABLE `bill_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1253;

--
-- AUTO_INCREMENT for table `bill_of_materials`
--
ALTER TABLE `bill_of_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `builds`
--
ALTER TABLE `builds`
  MODIFY `build_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `build_items`
--
ALTER TABLE `build_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=441;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `process_templates`
--
ALTER TABLE `process_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `process_template_items`
--
ALTER TABLE `process_template_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `process_transaction`
--
ALTER TABLE `process_transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `process_transaction_items`
--
ALTER TABLE `process_transaction_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `zoho_bill_items`
--
ALTER TABLE `zoho_bill_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `adjustment_items`
--
ALTER TABLE `adjustment_items`
  ADD CONSTRAINT `adjustment_items_ibfk_1` FOREIGN KEY (`adjustment_id`) REFERENCES `adjustments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `build_items`
--
ALTER TABLE `build_items`
  ADD CONSTRAINT `build_items_ibfk_1` FOREIGN KEY (`build_id`) REFERENCES `builds` (`build_id`) ON DELETE CASCADE;

--
-- Constraints for table `process_template_items`
--
ALTER TABLE `process_template_items`
  ADD CONSTRAINT `process_template_items_ibfk_1` FOREIGN KEY (`process_template_id`) REFERENCES `process_templates` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `process_transaction_items`
--
ALTER TABLE `process_transaction_items`
  ADD CONSTRAINT `process_transaction_items_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `process_transaction` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_menus`
--
ALTER TABLE `role_menus`
  ADD CONSTRAINT `role_menus_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_menus_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;
--
-- Database: `otp_forwarder`
--
CREATE DATABASE IF NOT EXISTS `otp_forwarder` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `otp_forwarder`;
--
-- Database: `trading_dashboard`
--
CREATE DATABASE IF NOT EXISTS `trading_dashboard` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `trading_dashboard`;

-- --------------------------------------------------------

--
-- Table structure for table `daily_levels`
--

CREATE TABLE `daily_levels` (
  `id` int(11) NOT NULL,
  `symbol` varchar(20) NOT NULL,
  `trade_date` date NOT NULL,
  `high` decimal(10,2) DEFAULT NULL,
  `low` decimal(10,2) DEFAULT NULL,
  `close` decimal(10,2) DEFAULT NULL,
  `pivot` decimal(10,2) DEFAULT NULL,
  `s1` decimal(10,2) DEFAULT NULL,
  `s2` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `playbooks`
--

CREATE TABLE `playbooks` (
  `user_id` int(11) NOT NULL,
  `content` mediumtext,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `playbooks`
--

INSERT INTO `playbooks` (`user_id`, `content`, `updated_at`) VALUES
(1, 'Testing the dashboard', '2025-12-05 06:05:56');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_lots`
--

CREATE TABLE `portfolio_lots` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `position_id` int(10) UNSIGNED NOT NULL,
  `trade_date` date NOT NULL,
  `qty` decimal(16,4) NOT NULL,
  `price` decimal(16,4) NOT NULL,
  `charges` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `notes` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `portfolio_lots`
--

INSERT INTO `portfolio_lots` (`id`, `user_id`, `position_id`, `trade_date`, `qty`, `price`, `charges`, `notes`, `created_at`) VALUES
(6, 1, 2, '2025-12-05', '12.0000', '2700.0000', '0.0000', '', '2025-12-06 14:12:34'),
(7, 1, 3, '2025-12-06', '5.0000', '1212.0000', '0.0000', '', '2025-12-06 14:31:39'),
(8, 1, 4, '2025-12-06', '10.0000', '1200.0000', '0.0000', '', '2025-12-06 14:35:19'),
(9, 1, 5, '2025-12-06', '12.0000', '2000.0000', '0.0000', '', '2025-12-06 14:45:24'),
(10, 1, 2, '2025-12-02', '10.0000', '3000.0000', '0.0000', '', '2025-12-06 14:47:29');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_positions`
--

CREATE TABLE `portfolio_positions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `symbol` varchar(32) NOT NULL,
  `name` varchar(128) NOT NULL,
  `total_qty` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `avg_price` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `last_ltp` decimal(16,4) DEFAULT NULL,
  `last_ltp_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `portfolio_positions`
--

INSERT INTO `portfolio_positions` (`id`, `user_id`, `symbol`, `name`, `total_qty`, `avg_price`, `last_ltp`, `last_ltp_at`, `is_active`, `created_at`, `updated_at`) VALUES
(2, 1, 'BSE', 'BSE Limited', '22.0000', '2836.3636', '2651.0000', '2025-12-28 11:43:58', 1, '2025-12-06 14:12:34', '2025-12-28 11:43:58'),
(3, 1, 'GROWW', 'Billionbrains Garage Ventures Limited', '5.0000', '1212.0000', '164.9000', '2025-12-28 11:43:50', 1, '2025-12-06 14:31:39', '2025-12-28 11:43:50'),
(4, 1, 'TCS', 'Tata Consultancy Services Limited', '10.0000', '1200.0000', '3276.8000', '2025-12-28 11:44:06', 1, '2025-12-06 14:35:19', '2025-12-28 11:44:06'),
(5, 1, '20MICRONS', '20 Microns Limited', '12.0000', '2000.0000', '216.1000', '2025-12-28 11:43:41', 1, '2025-12-06 14:45:24', '2025-12-28 11:43:41');

-- --------------------------------------------------------

--
-- Table structure for table `strategy_templates`
--

CREATE TABLE `strategy_templates` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `strategy_templates`
--

INSERT INTO `strategy_templates` (`id`, `user_id`, `name`, `description`, `created_at`, `enabled`) VALUES
(2, 1, '180 Startergy at 9:30 AM', '<ul><li>The best one updated</li><li>Enter after 9:27 AM</li></ul>', '2025-12-05 05:53:37', 1),
(5, 1, 'Rajsekhar Strategy', '<ul><li>Entry <b><u>time 10 AM</u></b></li></ul>', '2025-12-06 06:12:59', 1);

-- --------------------------------------------------------

--
-- Table structure for table `trades`
--

CREATE TABLE `trades` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `trade_no` varchar(50) NOT NULL,
  `trade_date` date NOT NULL,
  `day` varchar(20) DEFAULT NULL,
  `no_trades` int(11) DEFAULT NULL,
  `option_strike` int(11) DEFAULT NULL,
  `opening_bal` decimal(15,2) DEFAULT NULL,
  `closing_bal` decimal(15,2) DEFAULT NULL,
  `profit` decimal(15,2) DEFAULT NULL,
  `loss` decimal(15,2) DEFAULT NULL,
  `strike_price` decimal(10,2) DEFAULT NULL,
  `option_type` varchar(10) DEFAULT NULL,
  `underlying_close` decimal(10,2) DEFAULT NULL,
  `eod_price` decimal(10,2) DEFAULT NULL,
  `setup_type` varchar(100) DEFAULT NULL,
  `entry_reason` varchar(255) DEFAULT NULL,
  `rule_followed` varchar(50) DEFAULT NULL,
  `emotion` varchar(100) DEFAULT NULL,
  `strategy_tags` text,
  `mistake_tags` text,
  `notes` text,
  `screenshot_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `entry_point` decimal(12,2) DEFAULT NULL,
  `exit_point` decimal(12,2) DEFAULT NULL,
  `lots` int(11) DEFAULT NULL,
  `instrument` varchar(64) DEFAULT NULL,
  `trade_profit` decimal(12,2) DEFAULT NULL,
  `trade_loss` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trades`
--

INSERT INTO `trades` (`id`, `user_id`, `trade_no`, `trade_date`, `day`, `no_trades`, `option_strike`, `opening_bal`, `closing_bal`, `profit`, `loss`, `strike_price`, `option_type`, `underlying_close`, `eod_price`, `setup_type`, `entry_reason`, `rule_followed`, `emotion`, `strategy_tags`, `mistake_tags`, `notes`, `screenshot_path`, `created_at`, `entry_point`, `exit_point`, `lots`, `instrument`, `trade_profit`, `trade_loss`) VALUES
(1, 1, '1', '2025-12-01', 'Thursday', 1, NULL, '10000.00', '11000.00', '1000.00', '0.00', NULL, NULL, NULL, NULL, 'Reversal', 'Confident', 'Yes', 'Calm', '[{\"value\":\"1\"}]', '[{\"value\":\"1\"}]', 'Greate', 'uploads/trade_screenshots/shot_1764872636_5161.png', '2025-12-04 18:23:56', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, '2', '2025-12-02', 'Friday', 2, NULL, '20000.00', '30000.00', '819.00', '0.00', NULL, NULL, NULL, NULL, '', 'Perfect', '', '', '[{\"value\":\"2\"}]', '[{\"value\":\"3\"}]', 'Great', 'uploads/trade_screenshots/shot_1764873368_4546.png', '2025-12-04 18:36:08', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, '3', '2025-12-04', 'Friday', 1, NULL, '20000.00', '20200.20', '200.20', '0.00', NULL, NULL, NULL, NULL, 'Reversal', 'Perfect', 'Yes', 'Fearful', '[{\"value\":\"1\"}]', '[{\"value\":\"2\"}]', 'I entered the trade at 9:27 AM based on the 180 strategy. When the option\r\ncrossed 200, I moved my stop-loss to 190 to secure at least 10 points, which\r\nwould give me around ₹750. The price went up to 205, then reversed and hit my\r\ntrailing stop-loss. I booked ₹703 profit. After hitting my stop-loss, the option\r\ncontinued upward and eventually reached my original target of 220.', 'uploads/trade_screenshots/shot_1764874662_2062.png', '2025-12-04 18:57:43', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, '4', '2025-12-05', 'Friday', 2, NULL, '23000.00', '19223.00', '220.00', '0.00', NULL, NULL, NULL, NULL, 'Breakout', 'A random', 'No', 'Greedy', '[{\"value\":\"180\"}]', '[{\"value\":\"Random\"}]', 'I just entered for taking profit with any setup', 'uploads/trade_screenshots/shot_1764914187_2565.png', '2025-12-05 05:56:27', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, '5', '2025-12-03', 'Friday', 2, NULL, '20000.00', '30000.00', '713.00', '0.00', NULL, NULL, NULL, NULL, '', 'Perfect', '', '', '[{\"value\":\"2\"}]', '[{\"value\":\"3\"}]', 'Great', 'uploads/trade_screenshots/shot_1764873368_4546.png', '2025-12-04 18:36:08', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 1, '6', '2025-12-06', 'Saturday', 1, NULL, '22000.00', '23000.00', '1000.00', '0.00', NULL, NULL, NULL, NULL, '180 Startergy at 9:30 AM', 'Clean', 'Yes', 'Calm', '[{\"value\":\"1\"}]', '[{\"value\":\"1\"}]', 'Testing', 'uploads/trade_screenshots/shot_1765001215_9897.png', '2025-12-06 06:06:55', NULL, NULL, NULL, NULL, NULL, NULL),
(9, 1, '7', '2025-12-06', 'Saturday', 1, NULL, '100000.00', '110000.00', '10000.00', '0.00', NULL, NULL, NULL, NULL, 'Rajsekhar Strategy', 'Cool', 'Yes', 'Calm', '', '', 'Great', 'uploads/trade_screenshots/shot_1765001701_4469.png', '2025-12-06 06:15:01', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 1, '8', '2025-12-08', 'Monday', 2, NULL, '20001.79', '20121.80', '120.01', '0.00', NULL, NULL, NULL, NULL, '180 Startergy at 9:30 AM', '180 above and downtrend', 'Partially', 'Greedy', '', '', 'I entered this trade just make myself green today. I know this very wrong as trader but couldn\'t controlled myself.', NULL, '2025-12-08 15:25:35', NULL, NULL, NULL, NULL, NULL, NULL),
(11, 1, '9', '2025-12-10', 'Wednesday', 2, 26000, NULL, NULL, '0.00', '0.00', NULL, 'CE', '200.00', NULL, '180 Startergy at 9:30 AM', NULL, 'Yes', 'Calm', NULL, NULL, NULL, 'uploads/trade_screenshots/shot_1765376381_1352.png', '2025-12-10 14:19:41', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 1, '9', '2025-12-10', 'Wednesday', 2, 25950, NULL, NULL, '0.00', '0.00', NULL, 'PE', '220.00', NULL, '180 Startergy at 9:30 AM', NULL, 'Yes', 'Calm', NULL, NULL, NULL, 'uploads/trade_screenshots/shot_1765376381_1352.png', '2025-12-10 14:19:41', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 1, '1', '2025-12-10', 'Wednesday', 2, 26000, '20000.00', '18500.00', '0.00', '1500.00', NULL, 'CE', '200.00', NULL, '180 Startergy at 9:30 AM', 'Clean', 'Yes', 'Calm', NULL, NULL, NULL, 'uploads/trade_screenshots/shot_1765377908_5607.png', '2025-12-10 14:45:08', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 1, '1', '2025-12-10', 'Wednesday', 2, 25850, '20000.00', '18500.00', '0.00', '1500.00', NULL, 'CE', '163.00', NULL, '180 Startergy at 9:30 AM', 'Clean', 'Partially', 'Calm', NULL, NULL, NULL, 'uploads/trade_screenshots/shot_1765377908_7398.png', '2025-12-10 14:45:08', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `username_locked` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(120) DEFAULT NULL,
  `pending_email` varchar(120) DEFAULT NULL,
  `email_change_token` varchar(64) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `verification_token` varchar(64) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `username_locked`, `email`, `pending_email`, `email_change_token`, `phone`, `password`, `verification_token`, `is_verified`, `created_at`) VALUES
(1, 'Krishna Kanth', 'hvskrishnakanth', 0, 'admin@example.com', NULL, NULL, NULL, '123456', NULL, 1, '2025-12-04 18:02:49');

-- --------------------------------------------------------

--
-- Table structure for table `user_monthly_capital`
--

CREATE TABLE `user_monthly_capital` (
  `user_id` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `capital` decimal(10,2) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_monthly_capital`
--

INSERT INTO `user_monthly_capital` (`user_id`, `year`, `month`, `capital`, `locked`) VALUES
(1, 2025, 12, '20000.00', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `daily_levels`
--
ALTER TABLE `daily_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `symbol` (`symbol`,`trade_date`);

--
-- Indexes for table `playbooks`
--
ALTER TABLE `playbooks`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `portfolio_lots`
--
ALTER TABLE `portfolio_lots`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lot_position` (`position_id`),
  ADD KEY `idx_user_date` (`user_id`,`trade_date`);

--
-- Indexes for table `portfolio_positions`
--
ALTER TABLE `portfolio_positions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_user_symbol` (`user_id`,`symbol`),
  ADD KEY `idx_user_active` (`user_id`,`is_active`);

--
-- Indexes for table `strategy_templates`
--
ALTER TABLE `strategy_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `trades`
--
ALTER TABLE `trades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_monthly_capital`
--
ALTER TABLE `user_monthly_capital`
  ADD PRIMARY KEY (`user_id`,`year`,`month`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `daily_levels`
--
ALTER TABLE `daily_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `portfolio_lots`
--
ALTER TABLE `portfolio_lots`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `portfolio_positions`
--
ALTER TABLE `portfolio_positions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `strategy_templates`
--
ALTER TABLE `strategy_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `trades`
--
ALTER TABLE `trades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `playbooks`
--
ALTER TABLE `playbooks`
  ADD CONSTRAINT `playbooks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_lots`
--
ALTER TABLE `portfolio_lots`
  ADD CONSTRAINT `fk_lot_position` FOREIGN KEY (`position_id`) REFERENCES `portfolio_positions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `strategy_templates`
--
ALTER TABLE `strategy_templates`
  ADD CONSTRAINT `strategy_templates_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `trades`
--
ALTER TABLE `trades`
  ADD CONSTRAINT `trades_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
