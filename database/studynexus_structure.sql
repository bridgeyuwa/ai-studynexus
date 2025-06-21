-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 20, 2025 at 01:18 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `benghazi`
--

-- --------------------------------------------------------

--
-- Table structure for table `accreditation_bodies`
--

CREATE TABLE `accreditation_bodies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `abbr` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `accreditation_statuses`
--

CREATE TABLE `accreditation_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `action_events`
--

CREATE TABLE `action_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` char(36) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `actionable_type` varchar(255) NOT NULL,
  `actionable_id` varchar(20) NOT NULL,
  `target_type` varchar(255) NOT NULL,
  `target_id` varchar(20) NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` varchar(20) DEFAULT NULL,
  `fields` text NOT NULL,
  `status` varchar(25) NOT NULL DEFAULT 'running',
  `exception` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `original` mediumtext DEFAULT NULL,
  `changes` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `catchments`
--

CREATE TABLE `catchments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_state` tinyint(1) NOT NULL DEFAULT 1,
  `region_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `catchment_institution`
--

CREATE TABLE `catchment_institution` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `catchment_id` bigint(20) UNSIGNED NOT NULL,
  `institution_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `name_plural` varchar(255) NOT NULL,
  `category_class_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category_classes`
--

CREATE TABLE `category_classes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `name_plural` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `colleges`
--

CREATE TABLE `colleges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `exam_body_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `abbr` varchar(255) DEFAULT NULL,
  `month` tinyint(3) UNSIGNED NOT NULL,
  `year` year(4) NOT NULL,
  `type` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `remarks` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_bodies`
--

CREATE TABLE `exam_bodies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `abbr` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `state_id` bigint(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `locality` varchar(255) NOT NULL,
  `postal_code` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `institutions`
--

CREATE TABLE `institutions` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `former_name` varchar(255) DEFAULT NULL,
  `abbr` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `established` year(4) DEFAULT NULL,
  `state_id` bigint(20) UNSIGNED NOT NULL,
  `locality` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `institution_type_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `accreditation_body_id` bigint(20) UNSIGNED NOT NULL,
  `accreditation_status_id` bigint(20) UNSIGNED NOT NULL,
  `religious_affiliation_id` bigint(20) UNSIGNED NOT NULL,
  `slogan` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `institution_head_id` bigint(20) UNSIGNED NOT NULL,
  `head` varchar(255) DEFAULT NULL,
  `coordinates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`coordinates`)),
  `url` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `postal_code` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `institution_heads`
--

CREATE TABLE `institution_heads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `institution_institution`
--

CREATE TABLE `institution_institution` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `primary_institution_id` varchar(255) NOT NULL,
  `related_institution_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `institution_program`
--

CREATE TABLE `institution_program` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `institution_id` varchar(255) NOT NULL,
  `program_id` varchar(255) NOT NULL,
  `level_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `program_mode_id` bigint(20) UNSIGNED DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `tuition_fee` int(11) DEFAULT NULL,
  `utme_cutoff` int(11) DEFAULT NULL,
  `requirements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`requirements`)),
  `direct_entry` text DEFAULT NULL,
  `o_level` text DEFAULT NULL,
  `utme_subjects` text DEFAULT NULL,
  `accreditation_body_id` bigint(20) UNSIGNED NOT NULL,
  `accreditation_status_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_distinguished` tinyint(1) NOT NULL DEFAULT 0,
  `accreditation_grant_date` date DEFAULT NULL,
  `accreditation_expiry_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `institution_types`
--

CREATE TABLE `institution_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `institution_type_category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `institution_type_categories`
--

CREATE TABLE `institution_type_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `levels`
--

CREATE TABLE `levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `abbr` varchar(255) DEFAULT NULL,
  `utme_cutoff` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `level_program`
--

CREATE TABLE `level_program` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `program_id` varchar(255) NOT NULL,
  `level_id` bigint(20) UNSIGNED NOT NULL,
  `description` text DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `requirements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`requirements`)),
  `direct_entry` text DEFAULT NULL,
  `o_level` text DEFAULT NULL,
  `utme_subjects` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `excerpt` text NOT NULL,
  `content` text NOT NULL,
  `institution_id` varchar(255) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `news_categories`
--

CREATE TABLE `news_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `news_news_category`
--

CREATE TABLE `news_news_category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `news_id` bigint(20) UNSIGNED NOT NULL,
  `news_category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nova_field_attachments`
--

CREATE TABLE `nova_field_attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `attachable_type` varchar(255) NOT NULL,
  `attachable_id` varchar(20) NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `disk` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nova_notifications`
--

CREATE TABLE `nova_notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nova_pending_field_attachments`
--

CREATE TABLE `nova_pending_field_attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `draft_id` varchar(255) NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `disk` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phone_numbers`
--

CREATE TABLE `phone_numbers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `number` varchar(255) NOT NULL,
  `institution_id` varchar(255) NOT NULL,
  `holder` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `college_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_modes`
--

CREATE TABLE `program_modes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `religious_affiliations`
--

CREATE TABLE `religious_affiliations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `religious_affiliation_category_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `religious_affiliation_categories`
--

CREATE TABLE `religious_affiliation_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo`
--

CREATE TABLE `seo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `description` longtext DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `robots` varchar(255) DEFAULT NULL,
  `canonical_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `socials`
--

CREATE TABLE `socials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `social_type_id` bigint(20) UNSIGNED NOT NULL,
  `institution_id` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_types`
--

CREATE TABLE `social_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `is_state` tinyint(1) NOT NULL DEFAULT 1,
  `region_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `syllabi`
--

CREATE TABLE `syllabi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `subject` varchar(255) NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `terms`
--

CREATE TABLE `terms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timetables`
--

CREATE TABLE `timetables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `paper_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `start_time` datetime NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `end_time` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accreditation_bodies`
--
ALTER TABLE `accreditation_bodies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `accreditation_statuses`
--
ALTER TABLE `accreditation_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `action_events`
--
ALTER TABLE `action_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `action_events_actionable_type_actionable_id_index` (`actionable_type`,`actionable_id`),
  ADD KEY `action_events_target_type_target_id_index` (`target_type`,`target_id`),
  ADD KEY `action_events_batch_id_model_type_model_id_index` (`batch_id`,`model_type`,`model_id`),
  ADD KEY `action_events_user_id_index` (`user_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `catchments`
--
ALTER TABLE `catchments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `catchments_region_id_foreign` (`region_id`);

--
-- Indexes for table `catchment_institution`
--
ALTER TABLE `catchment_institution`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `catchment_institution_catchment_id_institution_id_unique` (`catchment_id`,`institution_id`),
  ADD KEY `catchment_institution_institution_id_foreign` (`institution_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_category_class_id_foreign` (`category_class_id`);

--
-- Indexes for table `category_classes`
--
ALTER TABLE `category_classes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `colleges`
--
ALTER TABLE `colleges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exams_exam_body_id_foreign` (`exam_body_id`);

--
-- Indexes for table `exam_bodies`
--
ALTER TABLE `exam_bodies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `institutions`
--
ALTER TABLE `institutions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `institutions_category_id_foreign` (`category_id`),
  ADD KEY `institutions_institution_type_id_foreign` (`institution_type_id`),
  ADD KEY `institutions_state_id_foreign` (`state_id`),
  ADD KEY `institutions_term_id_foreign` (`term_id`),
  ADD KEY `institutions_accreditation_body_id_foreign` (`accreditation_body_id`),
  ADD KEY `institutions_accreditation_status_id_foreign` (`accreditation_status_id`),
  ADD KEY `institutions_religious_affiliation_id_foreign` (`religious_affiliation_id`),
  ADD KEY `institutions_institution_head_id_foreign` (`institution_head_id`),
  ADD KEY `institutions_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `institution_heads`
--
ALTER TABLE `institution_heads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `institution_institution`
--
ALTER TABLE `institution_institution`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `self_reference_institution_unique_index` (`primary_institution_id`,`related_institution_id`),
  ADD KEY `institution_institution_related_institution_id_foreign` (`related_institution_id`);

--
-- Indexes for table `institution_program`
--
ALTER TABLE `institution_program`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `institution_program_institution_id_program_id_level_id_unique` (`institution_id`,`program_id`,`level_id`),
  ADD KEY `institution_program_program_id_foreign` (`program_id`),
  ADD KEY `institution_program_level_id_foreign` (`level_id`),
  ADD KEY `institution_program_accreditation_body_id_foreign` (`accreditation_body_id`),
  ADD KEY `institution_program_accreditation_status_id_foreign` (`accreditation_status_id`),
  ADD KEY `institution_program_program_mode_id_foreign` (`program_mode_id`);

--
-- Indexes for table `institution_types`
--
ALTER TABLE `institution_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `institution_types_slug_unique` (`slug`),
  ADD KEY `institution_types_institution_type_category_id_foreign` (`institution_type_category_id`);

--
-- Indexes for table `institution_type_categories`
--
ALTER TABLE `institution_type_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `institution_type_categories_slug_unique` (`slug`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `level_program`
--
ALTER TABLE `level_program`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `level_program_program_id_level_id_unique` (`program_id`,`level_id`),
  ADD KEY `level_program_level_id_foreign` (`level_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_institution_id_foreign` (`institution_id`);

--
-- Indexes for table `news_categories`
--
ALTER TABLE `news_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news_news_category`
--
ALTER TABLE `news_news_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_news_category_news_id_foreign` (`news_id`),
  ADD KEY `news_news_category_news_category_id_foreign` (`news_category_id`);

--
-- Indexes for table `nova_field_attachments`
--
ALTER TABLE `nova_field_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nova_field_attachments_attachable_type_attachable_id_index` (`attachable_type`,`attachable_id`),
  ADD KEY `nova_field_attachments_url_index` (`url`);

--
-- Indexes for table `nova_notifications`
--
ALTER TABLE `nova_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nova_notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `nova_pending_field_attachments`
--
ALTER TABLE `nova_pending_field_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nova_pending_field_attachments_draft_id_index` (`draft_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `phone_numbers`
--
ALTER TABLE `phone_numbers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone_numbers_number_institution_id_unique` (`number`,`institution_id`),
  ADD KEY `phone_numbers_institution_id_foreign` (`institution_id`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `programs_college_id_foreign` (`college_id`);

--
-- Indexes for table `program_modes`
--
ALTER TABLE `program_modes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `religious_affiliations`
--
ALTER TABLE `religious_affiliations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `religious_affiliations_religious_affiliation_category_id_foreign` (`religious_affiliation_category_id`);

--
-- Indexes for table `religious_affiliation_categories`
--
ALTER TABLE `religious_affiliation_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seo`
--
ALTER TABLE `seo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seo_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `socials`
--
ALTER TABLE `socials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socials_social_type_id_institution_id_unique` (`social_type_id`,`institution_id`),
  ADD KEY `socials_institution_id_foreign` (`institution_id`);

--
-- Indexes for table `social_types`
--
ALTER TABLE `social_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`),
  ADD KEY `states_region_id_foreign` (`region_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `syllabi`
--
ALTER TABLE `syllabi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `terms`
--
ALTER TABLE `terms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `timetables`
--
ALTER TABLE `timetables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timetables_exam_id_foreign` (`exam_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accreditation_bodies`
--
ALTER TABLE `accreditation_bodies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `accreditation_statuses`
--
ALTER TABLE `accreditation_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `action_events`
--
ALTER TABLE `action_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `catchments`
--
ALTER TABLE `catchments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `catchment_institution`
--
ALTER TABLE `catchment_institution`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_classes`
--
ALTER TABLE `category_classes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `colleges`
--
ALTER TABLE `colleges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_bodies`
--
ALTER TABLE `exam_bodies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `institution_heads`
--
ALTER TABLE `institution_heads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `institution_institution`
--
ALTER TABLE `institution_institution`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `institution_program`
--
ALTER TABLE `institution_program`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `institution_types`
--
ALTER TABLE `institution_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `institution_type_categories`
--
ALTER TABLE `institution_type_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `levels`
--
ALTER TABLE `levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `level_program`
--
ALTER TABLE `level_program`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `news_categories`
--
ALTER TABLE `news_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `news_news_category`
--
ALTER TABLE `news_news_category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nova_field_attachments`
--
ALTER TABLE `nova_field_attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nova_pending_field_attachments`
--
ALTER TABLE `nova_pending_field_attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_numbers`
--
ALTER TABLE `phone_numbers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program_modes`
--
ALTER TABLE `program_modes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `regions`
--
ALTER TABLE `regions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `religious_affiliations`
--
ALTER TABLE `religious_affiliations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `religious_affiliation_categories`
--
ALTER TABLE `religious_affiliation_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo`
--
ALTER TABLE `seo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socials`
--
ALTER TABLE `socials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_types`
--
ALTER TABLE `social_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `syllabi`
--
ALTER TABLE `syllabi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `terms`
--
ALTER TABLE `terms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timetables`
--
ALTER TABLE `timetables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `catchments`
--
ALTER TABLE `catchments`
  ADD CONSTRAINT `catchments_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `catchment_institution`
--
ALTER TABLE `catchment_institution`
  ADD CONSTRAINT `catchment_institution_catchment_id_foreign` FOREIGN KEY (`catchment_id`) REFERENCES `catchments` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `catchment_institution_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_category_class_id_foreign` FOREIGN KEY (`category_class_id`) REFERENCES `category_classes` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `exams`
--
ALTER TABLE `exams`
  ADD CONSTRAINT `exams_exam_body_id_foreign` FOREIGN KEY (`exam_body_id`) REFERENCES `exam_bodies` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `institutions`
--
ALTER TABLE `institutions`
  ADD CONSTRAINT `institutions_accreditation_body_id_foreign` FOREIGN KEY (`accreditation_body_id`) REFERENCES `accreditation_bodies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institutions_accreditation_status_id_foreign` FOREIGN KEY (`accreditation_status_id`) REFERENCES `accreditation_statuses` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institutions_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institutions_institution_head_id_foreign` FOREIGN KEY (`institution_head_id`) REFERENCES `institution_heads` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institutions_institution_type_id_foreign` FOREIGN KEY (`institution_type_id`) REFERENCES `institution_types` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institutions_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `institutions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institutions_religious_affiliation_id_foreign` FOREIGN KEY (`religious_affiliation_id`) REFERENCES `religious_affiliations` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institutions_state_id_foreign` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institutions_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `institution_institution`
--
ALTER TABLE `institution_institution`
  ADD CONSTRAINT `institution_institution_primary_institution_id_foreign` FOREIGN KEY (`primary_institution_id`) REFERENCES `institutions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institution_institution_related_institution_id_foreign` FOREIGN KEY (`related_institution_id`) REFERENCES `institutions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `institution_program`
--
ALTER TABLE `institution_program`
  ADD CONSTRAINT `institution_program_accreditation_body_id_foreign` FOREIGN KEY (`accreditation_body_id`) REFERENCES `accreditation_bodies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institution_program_accreditation_status_id_foreign` FOREIGN KEY (`accreditation_status_id`) REFERENCES `accreditation_statuses` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institution_program_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institution_program_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institution_program_program_id_foreign` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `institution_program_program_mode_id_foreign` FOREIGN KEY (`program_mode_id`) REFERENCES `program_modes` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `institution_types`
--
ALTER TABLE `institution_types`
  ADD CONSTRAINT `institution_types_institution_type_category_id_foreign` FOREIGN KEY (`institution_type_category_id`) REFERENCES `institution_type_categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `level_program`
--
ALTER TABLE `level_program`
  ADD CONSTRAINT `level_program_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `level_program_program_id_foreign` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `news_news_category`
--
ALTER TABLE `news_news_category`
  ADD CONSTRAINT `news_news_category_news_category_id_foreign` FOREIGN KEY (`news_category_id`) REFERENCES `news_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `news_news_category_news_id_foreign` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `phone_numbers`
--
ALTER TABLE `phone_numbers`
  ADD CONSTRAINT `phone_numbers_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `programs`
--
ALTER TABLE `programs`
  ADD CONSTRAINT `programs_college_id_foreign` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `religious_affiliations`
--
ALTER TABLE `religious_affiliations`
  ADD CONSTRAINT `religious_affiliations_religious_affiliation_category_id_foreign` FOREIGN KEY (`religious_affiliation_category_id`) REFERENCES `religious_affiliation_categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `socials`
--
ALTER TABLE `socials`
  ADD CONSTRAINT `socials_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `socials_social_type_id_foreign` FOREIGN KEY (`social_type_id`) REFERENCES `social_types` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `states`
--
ALTER TABLE `states`
  ADD CONSTRAINT `states_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `syllabi`
--
ALTER TABLE `syllabi`
  ADD CONSTRAINT `syllabi_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `timetables`
--
ALTER TABLE `timetables`
  ADD CONSTRAINT `timetables_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
