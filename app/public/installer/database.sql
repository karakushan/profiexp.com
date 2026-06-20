-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 21, 2026 at 02:31 PM
-- Server version: 8.0.30
-- PHP Version: 8.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bulistio_4.0_installer`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `show_email_address` int DEFAULT '0',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `show_phone_number` int NOT NULL DEFAULT '0',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `details` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `lang_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `role_id`, `first_name`, `last_name`, `image`, `username`, `email`, `show_email_address`, `phone`, `show_phone_number`, `password`, `address`, `details`, `status`, `created_at`, `updated_at`, `code`, `lang_code`) VALUES
(1, NULL, 'Azim', 'Ahmed', '65c20e674bd34.png', 'admin', 'leonardbourne@example.com', 1, '+39 02 1234 5678', 1, '$2y$10$7rcuMv8LG9adF09JnRjt.O35YL/3dkFWA7EBhBT.LOZvS07OaeDFm', 'House no 3, Road 5/c, sector 11, Uttara, Dhaka, Bangladesh', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Molestiae blanditiis minus tempora quibusdam quas quo magni, repellat sit? Adipisci accusantium quasi autem tempora nemo aspernatur tenetur repellat numquam sed cupiditate.', 1, NULL, '2026-03-08 22:54:25', 'en', 'admin_en'),
(3, 4, 'Azim', 'superBusiness47', '673ade9473c42.png', 'superBusiness47', 'user@gmail.com', 0, NULL, 0, '$2y$10$l4T0/Q8/TJOpO9IDFgrdTOt6tdxH4DCU/XSZc9B1xixZz1lxHr68.', NULL, NULL, 1, '2024-11-18 00:28:36', '2024-11-18 00:28:36', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `advertisements`
--

CREATE TABLE `advertisements` (
  `id` bigint UNSIGNED NOT NULL,
  `ad_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `resolution_type` smallint UNSIGNED NOT NULL COMMENT '1 => 300 x 250, 2 => 300 x 600, 3 => 728 x 90',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slot` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `views` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `advertisements`
--

INSERT INTO `advertisements` (`id`, `ad_type`, `resolution_type`, `image`, `url`, `slot`, `views`, `created_at`, `updated_at`) VALUES
(7, 'banner', 3, '664f0a5c79248.png', 'http://example.com/', NULL, 7, '2021-08-15 22:44:47', '2024-05-23 03:20:28'),
(8, 'banner', 2, '664f0fea4e4ed.png', 'http://example.com/', NULL, 0, '2021-08-15 22:45:21', '2024-05-23 03:44:10'),
(10, 'banner', 1, '664f100d7ac6d.png', 'http://example.com/', NULL, 2, '2021-08-15 23:13:44', '2024-05-23 03:44:45'),
(11, 'banner', 2, '664f0a7a71f21.png', 'http://example.com/', NULL, 3, '2021-08-15 23:15:14', '2024-05-23 03:20:58'),
(12, 'banner', 1, '664f0a68e96a7.png', 'http://example.com/', NULL, 1, '2021-08-15 23:16:41', '2024-05-23 03:20:40'),
(13, 'banner', 3, '664f0a365d199.png', 'http://example.com/', NULL, 3, '2021-08-17 04:52:09', '2025-01-15 23:49:34');

-- --------------------------------------------------------

--
-- Table structure for table `aminites`
--

CREATE TABLE `aminites` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `aminites`
--

INSERT INTO `aminites` (`id`, `language_id`, `icon`, `title`, `created_at`, `updated_at`) VALUES
(1, 20, 'fas fa-swimming-pool', 'Swimming Pool', '2024-05-01 20:55:17', '2024-05-01 20:55:17'),
(2, 21, 'fas fa-swimming-pool', 'حمام السباحة', '2024-05-01 20:55:56', '2024-05-01 20:55:56'),
(3, 20, 'fas fa-chair', 'Comfortable Seating', '2024-05-01 20:57:48', '2024-05-01 20:57:48'),
(4, 21, 'fas fa-chair', 'مقاعد مريحة', '2024-05-01 20:58:12', '2024-05-01 20:58:12'),
(5, 20, 'fas fa-wifi', 'Free Wifi', '2024-05-01 20:58:37', '2024-05-01 20:58:37'),
(6, 21, 'fas fa-wifi', 'واى فاى مجانى', '2024-05-01 20:58:58', '2024-05-01 20:58:58'),
(8, 20, 'fas fa-parking', 'Parking Facilities', '2024-05-01 22:25:49', '2024-05-01 22:25:49'),
(9, 21, 'fas fa-parking', 'مرافق وقوف السيارات', '2024-05-01 22:28:18', '2024-05-01 22:28:18'),
(10, 20, 'fas fa-pray', 'Prayer Room', '2024-05-01 22:29:08', '2024-05-01 22:29:08'),
(11, 21, 'fas fa-pray', 'غرفة الصلاة', '2024-05-01 22:29:32', '2024-05-01 22:29:32'),
(12, 20, 'fas fa-file-prescription', 'Pharmacy', '2024-05-01 22:31:31', '2024-05-01 22:31:31'),
(13, 21, 'fas fa-file-prescription', 'مقابل', '2024-05-01 22:31:53', '2024-05-01 22:31:53'),
(14, 20, 'fas fa-stamp', 'Multilingual Staff', '2024-05-01 23:22:01', '2024-05-01 23:22:01'),
(15, 20, 'fas fa-utensils', 'Resturant', '2024-05-02 02:24:15', '2024-05-02 02:24:15'),
(16, 21, 'fas fa-utensils', 'مطعم', '2024-05-02 02:24:53', '2024-05-02 02:24:53'),
(17, 20, 'fab fa-cc-diners-club', 'Private Dining Room', '2024-05-05 20:45:41', '2024-05-05 20:45:41'),
(18, 21, 'fab fa-cc-diners-club', 'غرفة طعام خاصة', '2024-05-05 20:46:03', '2024-05-05 20:46:03'),
(19, 20, 'fas fa-dumbbell', 'Group Exercise Studios', '2024-05-06 02:26:04', '2024-05-06 02:26:04'),
(20, 21, 'fas fa-dumbbell', 'استوديوهات التمارين الجماعية', '2024-05-06 02:26:29', '2024-05-07 23:27:58'),
(21, 20, 'fas fa-lock', 'Locker Rooms', '2024-05-06 02:26:56', '2024-05-06 02:26:56'),
(22, 21, 'fas fa-lock', 'غرف خلع الملابس', '2024-05-06 02:27:18', '2024-11-08 21:03:15');

-- --------------------------------------------------------

--
-- Table structure for table `basic_settings`
--

CREATE TABLE `basic_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `uniqid` int UNSIGNED NOT NULL DEFAULT '12345',
  `favicon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `logo_two` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `website_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `redeem_token_expire_days` smallint UNSIGNED NOT NULL DEFAULT '3',
  `email_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `theme_version` smallint UNSIGNED NOT NULL,
  `base_currency_symbol` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_symbol_position` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_text` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_text_position` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_rate` decimal(8,2) DEFAULT NULL,
  `primary_color` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_status` tinyint DEFAULT NULL,
  `smtp_host` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_port` int DEFAULT NULL,
  `encryption` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `from_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `to_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `breadcrumb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `disqus_status` tinyint UNSIGNED DEFAULT NULL,
  `disqus_short_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_recaptcha_status` tinyint DEFAULT NULL,
  `google_recaptcha_site_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_recaptcha_secret_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_status` tinyint UNSIGNED DEFAULT NULL,
  `whatsapp_number` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_header_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_popup_status` tinyint UNSIGNED DEFAULT NULL,
  `whatsapp_popup_message` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `maintenance_img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `maintenance_status` tinyint DEFAULT NULL,
  `maintenance_msg` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `bypass_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `footer_logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `footer_background_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `admin_theme_version` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'light',
  `notification_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `counter_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `call_to_action_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `call_to_action_section_highlight_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `video_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `testimonial_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `category_section_background` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_adsense_publisher_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `equipment_tax_amount` decimal(5,2) UNSIGNED DEFAULT NULL,
  `product_tax_amount` decimal(5,2) UNSIGNED DEFAULT NULL,
  `self_pickup_status` tinyint UNSIGNED DEFAULT NULL,
  `two_way_delivery_status` tinyint UNSIGNED DEFAULT NULL,
  `guest_checkout_status` tinyint UNSIGNED NOT NULL,
  `shop_status` int DEFAULT '1',
  `admin_approve_status` int NOT NULL DEFAULT '0',
  `listing_view` int DEFAULT NULL,
  `facebook_login_status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '1 -> enable, 0 -> disable',
  `facebook_app_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `facebook_app_secret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_login_status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '1 -> enable, 0 -> disable',
  `google_client_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_client_secret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tawkto_status` tinyint UNSIGNED NOT NULL COMMENT '1 -> enable, 0 -> disable',
  `hero_section_background_img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tawkto_direct_chat_link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_admin_approval` int NOT NULL DEFAULT '0' COMMENT '1 active, 2 deactive',
  `vendor_email_verification` int NOT NULL DEFAULT '0' COMMENT '1 active, 2 deactive',
  `admin_approval_notice` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `expiration_reminder` int DEFAULT '3',
  `timezone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `hero_section_video_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `contact_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_subtile` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_details` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `latitude` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `preloader_status` int DEFAULT '1',
  `preloader` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_format` int DEFAULT '12',
  `google_map_api_key_status` int DEFAULT '0',
  `google_map_api_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `radius` int DEFAULT '0',
  `commission_amount` decimal(8,2) DEFAULT NULL,
  `app_logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `app_fav` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `app_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `app_primary_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `app_breadcrumb_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `app_breadcrumb_overlay_opacity` decimal(8,2) NOT NULL DEFAULT '0.00',
  `app_google_map_status` tinyint NOT NULL DEFAULT '0',
  `app_firebase_json_file` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `openai_api_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `openai_text_model` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `openai_image_model` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `gemini_api_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `gemini_text_model` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `gemini_image_model` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pollinations_secret_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pollinations_text_model` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pollinations_image_model` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `basic_settings`
--

INSERT INTO `basic_settings` (`id`, `uniqid`, `favicon`, `logo`, `logo_two`, `website_title`, `redeem_token_expire_days`, `email_address`, `contact_number`, `address`, `theme_version`, `base_currency_symbol`, `base_currency_symbol_position`, `base_currency_text`, `base_currency_text_position`, `base_currency_rate`, `primary_color`, `smtp_status`, `smtp_host`, `smtp_port`, `encryption`, `smtp_username`, `smtp_password`, `from_mail`, `from_name`, `to_mail`, `breadcrumb`, `disqus_status`, `disqus_short_name`, `google_recaptcha_status`, `google_recaptcha_site_key`, `google_recaptcha_secret_key`, `whatsapp_status`, `whatsapp_number`, `whatsapp_header_title`, `whatsapp_popup_status`, `whatsapp_popup_message`, `maintenance_img`, `maintenance_status`, `maintenance_msg`, `bypass_token`, `footer_logo`, `footer_background_image`, `admin_theme_version`, `notification_image`, `counter_section_image`, `call_to_action_section_image`, `call_to_action_section_highlight_image`, `video_section_image`, `testimonial_section_image`, `category_section_background`, `google_adsense_publisher_id`, `equipment_tax_amount`, `product_tax_amount`, `self_pickup_status`, `two_way_delivery_status`, `guest_checkout_status`, `shop_status`, `admin_approve_status`, `listing_view`, `facebook_login_status`, `facebook_app_id`, `facebook_app_secret`, `google_login_status`, `google_client_id`, `google_client_secret`, `tawkto_status`, `hero_section_background_img`, `tawkto_direct_chat_link`, `vendor_admin_approval`, `vendor_email_verification`, `admin_approval_notice`, `expiration_reminder`, `timezone`, `hero_section_video_url`, `contact_title`, `contact_subtile`, `contact_details`, `latitude`, `longitude`, `preloader_status`, `preloader`, `updated_at`, `time_format`, `google_map_api_key_status`, `google_map_api_key`, `radius`, `commission_amount`, `app_logo`, `app_fav`, `app_url`, `app_primary_color`, `app_breadcrumb_color`, `app_breadcrumb_overlay_opacity`, `app_google_map_status`, `app_firebase_json_file`, `openai_api_key`, `openai_text_model`, `openai_image_model`, `gemini_api_key`, `gemini_text_model`, `gemini_image_model`, `pollinations_secret_key`, `pollinations_text_model`, `pollinations_image_model`) VALUES
(2, 12345, '66321327155b0.png', '65b9bb8f98dd7.png', '64ed7071b1844.png', 'Bulistio', 364, 'bulistio@example.com', '+701 - 1111 - 2222 - 333', '450 Young Road, New York, USA', 2, '$', 'left', 'USD', 'right', 1.00, 'F9725F', 1, 'smtp.gmail.com', 587, 'TLS', 'xxxxxx', 'xxxxxxxxxxxxxx', 'xxx@example.com', 'Bulistio', 'demo@example.com', '65c200e4ea394.png', 0, 'test', 0, '1', '1', 0, '+880111111111', 'Hi,there!', 0, 'If you have any issues, let us know.', '1632725312.png', 0, 'We are upgrading our site. We will come back soon. \r\nPlease stay with us.\r\nThank you.', 'azim', '690978719ca9e.png', '638db9bf3f92a.jpg', 'dark', '619b7d5e5e9df.png', '6530b4b2c6984.jpg', '663c8354ee10d.jpg', '663c8354ef694.jpg', '663efd5b5134b.jpg', '657a7500bb6c1.jpg', '63c92601cb853.jpg', 'dvf', 5.00, 5.00, 1, 1, 0, 1, 1, 1, 0, '1', '1', 1, 'dsds', 'dsdsdsd', 1, '664af3245b2b4.png', 'xxxxx', 1, 1, 'Your account is deactive or pending now. Please Contact with admin!', 3, 'Asia/Dhaka', 'https://www.youtube.com/watch?v=9l6RywtDlKA', 'Get Connected', 'How Can We Help You?', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\r\n\r\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.', '23.8587', '90.4001', 1, '65e7f2608a3c1.gif', '2023-08-24 00:02:42', 12, 1, 'google-api-key', 500, 10.00, '693504171db56.png', '69350407b717e.png', NULL, 'FF8000', 'AC68FF', 0.00, 0, '69185257de210.json', 'sdsdsddsdsd', 'gpt-4o', 'dall-e-3', 'hh', 'gemini-2.5-flash', 'imagen-4.0-generat-001', 'dsdsds', 'gemini-fast', 'flux');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` mediumint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `image`, `serial_number`, `created_at`, `updated_at`) VALUES
(32, '663b3fa55cb46.png', 1, '2024-05-07 22:55:16', '2024-05-08 03:02:29'),
(33, '663b3fb1052e5.png', 2, '2024-05-07 23:03:31', '2024-05-08 03:02:41'),
(34, '663b3fc9a3c11.png', 3, '2024-05-07 23:07:53', '2024-05-08 03:03:05'),
(35, '663b3fdcf2d29.png', 4, '2024-05-07 23:10:14', '2024-05-08 03:03:24'),
(36, '663b4016d8f69.png', 5, '2024-05-07 23:13:27', '2024-05-08 03:04:22'),
(37, '663b40207f13d.png', 6, '2024-05-07 23:15:48', '2024-05-08 03:04:32');

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blog_categories`
--

INSERT INTO `blog_categories` (`id`, `language_id`, `name`, `slug`, `status`, `serial_number`, `created_at`, `updated_at`) VALUES
(50, 20, 'Business Optimization', 'business-optimization', 1, 1, '2024-05-07 22:52:58', '2024-05-07 22:52:58'),
(51, 21, 'تحسين الأعمال', 'تحسين-الأعمال', 1, 1, '2024-05-07 22:53:22', '2024-05-07 22:53:22'),
(52, 20, 'Local Business Tips', 'local-business-tips', 1, 2, '2024-05-07 22:58:14', '2024-05-07 22:58:14'),
(53, 21, 'نصائح الأعمال المحلية', 'نصائح-الأعمال-المحلية', 1, 2, '2024-05-07 22:58:39', '2024-05-07 23:27:08'),
(54, 20, 'Small Business Growth', 'small-business-growth', 1, 3, '2024-05-07 23:05:10', '2024-05-07 23:05:10'),
(55, 21, 'نمو الأعمال الصغيرة', 'نمو-الأعمال-الصغيرة', 1, 3, '2024-05-07 23:05:30', '2024-05-07 23:27:02'),
(56, 20, 'Online Presence', 'online-presence', 1, 4, '2024-05-07 23:18:57', '2024-05-07 23:18:57'),
(57, 21, 'التواجد على الشبكة', 'التواجد-على-الشبكة', 1, 4, '2024-05-07 23:19:20', '2024-05-07 23:19:20');

-- --------------------------------------------------------

--
-- Table structure for table `blog_informations`
--

CREATE TABLE `blog_informations` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `blog_category_id` bigint UNSIGNED NOT NULL,
  `blog_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `author` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` blob NOT NULL,
  `meta_keywords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blog_informations`
--

INSERT INTO `blog_informations` (`id`, `language_id`, `blog_category_id`, `blog_id`, `title`, `slug`, `author`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(3, 20, 50, 32, '10 Essential Tips for Optimizing Your Business Listing on Bulistio', '10-essential-tips-for-optimizing-your-business-listing-on-bulistio', 'Admin', 0x3c703e496e20746f6461792773206469676974616c206167652c20686176696e672061207374726f6e67206f6e6c696e652070726573656e6365206973206372756369616c20666f72207468652073756363657373206f6620616e7920627573696e6573732e204f6e65206f6620746865206d6f737420656666656374697665207761797320746f20656e68616e636520796f7572207669736962696c69747920616e64206174747261637420706f74656e7469616c20637573746f6d657273206973206279206f7074696d697a696e6720796f757220627573696e657373206c697374696e67206f6e205b596f75722057656273697465204e616d655d2e205768657468657220796f752772652061206c6f63616c20736572766963652070726f76696465722c20612072657461696c65722c206f7220616e206f6e6c696e6520656e7472657072656e6575722c206f7074696d697a696e6720796f757220627573696e657373206c697374696e672063616e207369676e69666963616e746c7920626f6f737420796f7572206f6e6c696e65207669736962696c69747920616e64206472697665206d6f7265207472616666696320746f20796f757220776562736974652e2048657265206172652074656e20657373656e7469616c207469707320746f2068656c7020796f75206d616b6520746865206d6f7374206f7574206f6620796f757220627573696e657373206c697374696e673a3c2f703e0d0a3c6f6c3e0d0a3c6c693e0d0a3c703e3c7374726f6e673e436f6d706c65746520596f75722050726f66696c653c2f7374726f6e673e3a20546865206669727374207374657020746f206f7074696d697a696e6720796f757220627573696e657373206c697374696e6720697320746f20656e73757265207468617420616c6c20746865206e656365737361727920696e666f726d6174696f6e2061626f757420796f757220627573696e65737320697320636f6d706c65746520616e642075702d746f2d646174652e205468697320696e636c7564657320796f757220627573696e657373206e616d652c20616464726573732c2070686f6e65206e756d6265722c20776562736974652055524c2c20686f757273206f66206f7065726174696f6e2c20616e642061206272696566206465736372697074696f6e206f6620796f75722070726f6475637473206f722073657276696365732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e43686f6f7365207468652052696768742043617465676f726965733c2f7374726f6e673e3a2053656c656374696e6720746865206d6f73742072656c6576616e742063617465676f7269657320666f7220796f757220627573696e6573732077696c6c2068656c7020706f74656e7469616c20637573746f6d6572732066696e6420796f75206d6f726520656173696c79207768656e20746865792073656172636820666f722072656c617465642070726f6475637473206f722073657276696365732e20426520617320737065636966696320617320706f737369626c6520746f20656e73757265207468617420796f757220627573696e657373206170706561727320696e207468652072696768742073656172636820726573756c74732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e4f7074696d697a6520596f757220427573696e657373204465736372697074696f6e3c2f7374726f6e673e3a2055736520796f757220627573696e657373206465736372697074696f6e20746f20686967686c696768742077686174206d616b657320796f757220627573696e65737320756e6971756520616e642077687920637573746f6d6572732073686f756c642063686f6f736520796f75206f76657220796f757220636f6d70657469746f72732e20496e636f72706f726174652072656c6576616e74206b6579776f72647320746f20696d70726f766520796f75722073656172636820656e67696e65207669736962696c6974792e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e41646420486967682d5175616c6974792050686f746f7320616e6420566964656f733c2f7374726f6e673e3a2056697375616c20636f6e74656e7420706c6179732061206372756369616c20726f6c6520696e2061747472616374696e6720616e6420656e676167696e6720706f74656e7469616c20637573746f6d6572732e2055706c6f616420686967682d7175616c6974792070686f746f7320616e6420766964656f7320746861742073686f776361736520796f75722070726f64756374732c2073657276696365732c20616e64207072656d6973657320746f206769766520637573746f6d6572732061206265747465722069646561206f66207768617420746f206578706563742e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e456e636f757261676520437573746f6d657220526576696577733c2f7374726f6e673e3a20506f73697469766520726576696577732063616e207369676e69666963616e746c7920696d7061637420796f757220627573696e65737327732072657075746174696f6e20616e6420637265646962696c6974792e20456e636f757261676520796f75722073617469736669656420637573746f6d65727320746f206c656176652072657669657773206f6e20796f757220627573696e657373206c697374696e672c20616e6420616c7761797320726573706f6e642070726f6d70746c7920616e642070726f66657373696f6e616c6c7920746f20616e7920666565646261636b2c207768657468657220706f736974697665206f72206e656761746976652e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e496e636c75646520436f6e7461637420496e666f726d6174696f6e3c2f7374726f6e673e3a204d616b65206974206561737920666f7220637573746f6d65727320746f2067657420696e20746f756368207769746820796f752062792070726f766964696e67206d756c7469706c6520636f6e74616374206f7074696f6e732c20737563682061732070686f6e65206e756d626572732c20656d61696c206164647265737365732c20616e6420736f6369616c206d656469612070726f66696c65732e20546869732068656c7073206275696c6420747275737420616e64206163636573736962696c6974792e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e55706461746520596f757220427573696e65737320486f7572733c2f7374726f6e673e3a204b65657020796f757220627573696e65737320686f757273207570646174656420746f207265666c65637420616e79206368616e6765732c20657370656369616c6c7920647572696e6720686f6c6964617973206f72207370656369616c206f63636173696f6e732e20546869732070726576656e747320706f74656e7469616c20637573746f6d6572732066726f6d2073686f77696e67207570207768656e20796f7527726520636c6f73656420616e642068656c7073206d616e616765206578706563746174696f6e732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e5574696c697a65204b6579776f72647320537472617465676963616c6c793c2f7374726f6e673e3a20496e636f72706f726174652072656c6576616e74206b6579776f726473207468726f7567686f757420796f757220627573696e657373206c697374696e6720746f20696d70726f766520796f75722073656172636820656e67696e652072616e6b696e67732e20466f637573206f6e206c6f6e672d7461696c206b6579776f72647320746861742061726520737065636966696320746f20796f7572206e6963686520616e64207461726765742061756469656e63652e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e4c696e6b20746f20596f7572205765627369746520616e6420536f6369616c204d656469612050726f66696c65733c2f7374726f6e673e3a20496e636c756465206c696e6b7320746f20796f7572207765627369746520616e6420736f6369616c206d656469612070726f66696c657320696e20796f757220627573696e657373206c697374696e6720746f206472697665207472616666696320616e6420656e636f757261676520656e676167656d656e742e20546869732070726f766964657320637573746f6d6572732077697468206164646974696f6e616c206176656e75657320746f206c6561726e206d6f72652061626f757420796f757220627573696e65737320616e64207374617920636f6e6e65637465642e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e4d6f6e69746f7220616e6420416e616c797a6520596f757220506572666f726d616e63653c2f7374726f6e673e3a20526567756c61726c79206d6f6e69746f722074686520706572666f726d616e6365206f6620796f757220627573696e657373206c697374696e6720746f20747261636b2076696577732c20636c69636b732c20616e6420637573746f6d657220696e746572616374696f6e732e2055736520616e616c797469637320746f6f6c7320746f206761696e20696e73696768747320696e746f2077686174277320776f726b696e672077656c6c20616e64207768657265207468657265277320726f6f6d20666f7220696d70726f76656d656e742e3c2f703e0d0a3c2f6c693e0d0a3c2f6f6c3e0d0a3c703e427920666f6c6c6f77696e672074686573652074656e20657373656e7469616c20746970732c20796f752063616e206f7074696d697a6520796f757220627573696e657373206c697374696e67206f6e205b596f75722057656273697465204e616d655d20746f206d6178696d697a6520796f7572206f6e6c696e65207669736962696c6974792c2061747472616374206d6f726520637573746f6d6572732c20616e6420756c74696d6174656c792067726f7720796f757220627573696e6573732e20537461792070726f61637469766520616e6420636f6e74696e756520746f20726566696e6520796f7572206c697374696e67206261736564206f6e20637573746f6d657220666565646261636b20616e64206368616e67696e67206d61726b6574207472656e647320746f20656e73757265206c6f6e672d7465726d20737563636573732e3c2f703e0d0a3c703e52656d656d6265722c20796f757220627573696e657373206c697374696e67206973206f6674656e2074686520666972737420696d7072657373696f6e20706f74656e7469616c20637573746f6d6572732068617665206f6620796f757220627573696e6573732c20736f206d616b6520697420636f756e74213c2f703e, NULL, NULL, '2024-05-07 22:55:16', '2024-05-07 22:55:16'),
(4, 21, 51, 32, '10 نصائح أساسية لتحسين قائمة أعمالك على بوليستيو', '10-نصائح-أساسية-لتحسين-قائمة-أعمالك-على-بوليستيو', 'مسؤل', 0x3c703ed981d98a20d8a7d984d8b9d8b5d8b120d8a7d984d8b1d982d985d98a20d8a7d984d8b0d98a20d986d8b9d98ad8b4d98720d8a7d984d98ad988d985d88c20d98ad8b9d8af20d8a7d984d8aad988d8a7d8acd8af20d8a7d984d982d988d98a20d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aa20d8a3d985d8b1d98bd8a720d8a8d8a7d984d8ba20d8a7d984d8a3d987d985d98ad8a920d984d986d8acd8a7d8ad20d8a3d98a20d8b9d985d98420d8aad8acd8a7d8b1d98a2e20d8a5d8add8afd98920d8a7d984d8b7d8b1d98220d8a7d984d8a3d983d8abd8b120d981d8b9d8a7d984d98ad8a920d984d8aad8b9d8b2d98ad8b220d8b8d987d988d8b1d98320d988d8acd8b0d8a820d8a7d984d8b9d985d984d8a7d8a120d8a7d984d985d8add8aad985d984d98ad98620d987d98a20d8aad8add8b3d98ad98620d982d8a7d8a6d985d8a920d8a3d8b9d985d8a7d984d98320d8b9d984d989205bd8a7d8b3d98520d985d988d982d8b920d8a7d984d988d98ad8a820d8a7d984d8aed8a7d8b520d8a8d9835d2e20d8b3d988d8a7d8a120d983d986d8aa20d985d8b2d988d8af20d8aed8afd985d8a920d985d8add984d98ad98bd8a7d88c20d8a3d98820d8a8d8a7d8a6d8b920d8aad8acd8b2d8a6d8a9d88c20d8a3d98820d8b1d8a7d8a6d8af20d8a3d8b9d985d8a7d98420d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aad88c20d981d8a5d98620d8aad8add8b3d98ad98620d982d8a7d8a6d985d8a920d8a3d8b9d985d8a7d984d98320d98ad985d983d98620d8a3d98620d98ad8b9d8b2d8b220d8a8d8b4d983d98420d983d8a8d98ad8b120d8b8d987d988d8b1d98320d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aa20d988d98ad8acd8b0d8a820d8a7d984d985d8b2d98ad8af20d985d98620d8a7d984d8b2d98ad8a7d8b1d8a7d8aa20d8a5d984d98920d985d988d982d8b920d8a7d984d988d98ad8a820d8a7d984d8aed8a7d8b520d8a8d9832e20d981d98ad985d8a720d98ad984d98a20d8b9d8b4d8b120d986d8b5d8a7d8a6d8ad20d8a3d8b3d8a7d8b3d98ad8a920d984d985d8b3d8a7d8b9d8afd8aad98320d981d98a20d8aad8add982d98ad98220d8a3d982d8b5d98920d8a7d8b3d8aad981d8a7d8afd8a920d985d98620d982d8a7d8a6d985d8a920d8a3d8b9d985d8a7d984d9833a3c2f703e0d0a3c6f6c3e0d0a3c6c693e0d0a3c703ed8a3d983d985d98420d985d984d981d98320d8a7d984d8b4d8aed8b5d98a3a203a20d8a7d984d8aed8b7d988d8a920d8a7d984d8a3d988d984d98920d984d8aad8add8b3d98ad98620d982d8a7d8a6d985d8a920d8a3d8b9d985d8a7d984d98320d987d98a20d8a7d984d8aad8a3d983d8af20d985d98620d8a3d98620d8acd985d98ad8b920d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8b6d8b1d988d8b1d98ad8a920d8b9d98620d8b9d985d984d98320d983d8a7d985d984d8a920d988d8add8afd98ad8abd8a92e20d98ad8aad8b6d985d98620d8b0d984d98320d8a7d8b3d98520d8b9d985d984d98320d988d8b9d986d988d8a7d986d98320d988d8b1d982d98520d987d8a7d8aad981d98320d988d8b9d986d988d8a7d9862055524c20d984d985d988d982d8b920d8a7d984d988d98ad8a820d988d8b3d8a7d8b9d8a7d8aa20d8a7d984d8b9d985d98420d988d988d8b5d981d98bd8a720d985d988d8acd8b2d98bd8a720e2808be2808bd984d985d986d8aad8acd8a7d8aad98320d8a3d98820d8aed8afd985d8a7d8aad9832e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703ed8a7d8aed8aad8b120d8a7d984d981d8a6d8a7d8aa20d8a7d984d985d986d8a7d8b3d8a8d8a93a20d8a5d98620d8aad8add8afd98ad8af20d8a7d984d981d8a6d8a7d8aa20d8a7d984d8a3d983d8abd8b120d8b5d984d8a920d8a8d986d8b4d8a7d8b7d98320d8a7d984d8aad8acd8a7d8b1d98a20d8b3d98ad8b3d8a7d8b9d8af20d8a7d984d8b9d985d984d8a7d8a120d8a7d984d985d8add8aad985d984d98ad98620d981d98a20d8a7d984d8b9d8abd988d8b120d8b9d984d98ad98320d8a8d8b3d987d988d984d8a920d8a3d983d8a8d8b120d8b9d986d8afd985d8a720d98ad8a8d8add8abd988d98620d8b9d98620d8a7d984d985d986d8aad8acd8a7d8aa20d8a3d98820d8a7d984d8aed8afd985d8a7d8aa20d8b0d8a7d8aa20d8a7d984d8b5d984d8a92e20d983d98620d985d8add8afd8afd98bd8a720d982d8afd8b120d8a7d984d8a5d985d983d8a7d98620d984d8b6d985d8a7d98620d8b8d987d988d8b120d986d8b4d8a7d8b7d98320d8a7d984d8aad8acd8a7d8b1d98a20d981d98a20d986d8aad8a7d8a6d8ac20d8a7d984d8a8d8add8ab20d8a7d984d8b5d8add98ad8add8a92e3c2f703e0d0a3c703ed8aad8add8b3d98ad98620d988d8b5d98120d8b9d985d984d9833a20d8a7d8b3d8aad8aed8afd98520d988d8b5d98120d8b9d985d984d98320d984d8aad8b3d984d98ad8b720d8a7d984d8b6d988d8a120d8b9d984d98920d985d8a720d98ad8acd8b9d98420d8b9d985d984d98320d981d8b1d98ad8afd98bd8a720d988d984d985d8a7d8b0d8a720d98ad8acd8a820d8b9d984d98920d8a7d984d8b9d985d984d8a7d8a120d8a7d8aed8aad98ad8a7d8b1d98320d8b9d984d98920d985d986d8a7d981d8b3d98ad9832e20d982d98520d8a8d8afd985d8ac20d8a7d984d983d984d985d8a7d8aa20d8a7d984d8b1d8a6d98ad8b3d98ad8a920d8b0d8a7d8aa20d8a7d984d8b5d984d8a920d984d8aad8add8b3d98ad98620d8b8d987d988d8b120d985d8add8b1d98320d8a7d984d8a8d8add8ab20d8a7d984d8aed8a7d8b520d8a8d9832e3c2f703e0d0a3c703ed8a5d8b6d8a7d981d8a920d8b5d988d8b120d988d985d982d8a7d8b7d8b920d981d98ad8afd98ad98820d8b9d8a7d984d98ad8a920d8a7d984d8acd988d8afd8a93a20d98ad984d8b9d8a820d8a7d984d985d8add8aad988d98920d8a7d984d985d8b1d8a6d98a20d8afd988d8b1d98bd8a720d8add8a7d8b3d985d98bd8a720d981d98a20d8acd8b0d8a820d8a7d984d8b9d985d984d8a7d8a120d8a7d984d985d8add8aad985d984d98ad98620d988d8a5d8b4d8b1d8a7d983d987d9852e20d982d98520d8a8d8aad8add985d98ad98420d8b5d988d8b120d988d985d982d8a7d8b7d8b920d981d98ad8afd98ad98820d8b9d8a7d984d98ad8a920d8a7d984d8acd988d8afd8a920d8aad8b9d8b1d8b620d985d986d8aad8acd8a7d8aad98320d988d8aed8afd985d8a7d8aad98320d988d985d8a8d8a7d986d98ad98320d984d985d986d8ad20d8a7d984d8b9d985d984d8a7d8a120d981d983d8b1d8a920d8a3d981d8b6d98420d8b9d985d8a720d98ad985d983d98620d8aad988d982d8b9d9872e3c2f703e0d0a3c703ed8aad8b4d8acd98ad8b920d8aad982d98ad98ad985d8a7d8aa20d8a7d984d8b9d985d984d8a7d8a13a20d98ad985d983d98620d8a3d98620d8aad8a4d8abd8b120d8a7d984d8aad982d98ad98ad985d8a7d8aa20d8a7d984d8a5d98ad8acd8a7d8a8d98ad8a920d8a8d8b4d983d98420d983d8a8d98ad8b120d8b9d984d98920d8b3d985d8b9d8a920d8b9d985d984d98320d988d985d8b5d8afd8a7d982d98ad8aad9872e20d8b4d8acd8b920d8b9d985d984d8a7d8a6d98320d8a7d984d8b1d8a7d8b6d98ad98620d8b9d984d98920d8aad8b1d98320d8aad8b9d984d98ad982d8a7d8aad987d98520d8b9d984d98920d982d8a7d8a6d985d8a920d8a3d8b9d985d8a7d984d983d88c20d988d8a7d984d8b1d8af20d8afd8a7d8a6d985d98bd8a720d8a8d8b3d8b1d8b9d8a920d988d985d987d986d98ad8a920d8b9d984d98920d8a3d98a20d8aad8b9d984d98ad982d8a7d8aad88c20d8b3d988d8a7d8a120d983d8a7d986d8aa20d8a5d98ad8acd8a7d8a8d98ad8a920d8a3d98820d8b3d984d8a8d98ad8a92e3c2f703e0d0a3c703ed8aad8b6d985d98ad98620d985d8b9d984d988d985d8a7d8aa20d8a7d984d8a7d8aad8b5d8a7d9843a20d8a7d8acd8b9d98420d985d98620d8a7d984d8b3d987d98420d8b9d984d98920d8a7d984d8b9d985d984d8a7d8a120d8a7d984d8aad988d8a7d8b5d98420d985d8b9d98320d985d98620d8aed984d8a7d98420d8aad988d981d98ad8b120d8aed98ad8a7d8b1d8a7d8aa20d8a7d8aad8b5d8a7d98420d985d8aad8b9d8afd8afd8a9d88c20d985d8abd98420d8a3d8b1d982d8a7d98520d8a7d984d987d988d8a7d8aad98120d988d8b9d986d8a7d988d98ad98620d8a7d984d8a8d8b1d98ad8af20d8a7d984d8a5d984d983d8aad8b1d988d986d98a20d988d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d988d8b3d8a7d8a6d8b720d8a7d984d8a7d8acd8aad985d8a7d8b9d98ad8a92e20d988d987d8b0d8a720d98ad8b3d8a7d8b9d8af20d8b9d984d98920d8a8d986d8a7d8a120d8a7d984d8abd982d8a920d988d8a5d985d983d8a7d986d98ad8a920d8a7d984d988d8b5d988d9842e3c2f703e0d0a3c703ed982d98520d8a8d8aad8add8afd98ad8ab20d8b3d8a7d8b9d8a7d8aa20d8b9d985d984d9833a20d8add8a7d981d8b820d8b9d984d98920d8aad8add8afd98ad8ab20d8b3d8a7d8b9d8a7d8aa20d8b9d985d984d98320d984d8aad8b9d983d8b320d8a3d98a20d8aad8bad98ad98ad8b1d8a7d8aad88c20d8aed8a7d8b5d8a920d8a3d8abd986d8a7d8a120d8a7d984d8b9d8b7d984d8a7d8aa20d8a3d98820d8a7d984d985d986d8a7d8b3d8a8d8a7d8aa20d8a7d984d8aed8a7d8b5d8a92e20d988d987d8b0d8a720d98ad985d986d8b920d8a7d984d8b9d985d984d8a7d8a120d8a7d984d985d8add8aad985d984d98ad98620d985d98620d8a7d984d8b8d987d988d8b120d8b9d986d8afd985d8a720d8aad983d988d98620d985d8bad984d982d98bd8a720d988d98ad8b3d8a7d8b9d8af20d981d98a20d8a5d8afd8a7d8b1d8a920d8a7d984d8aad988d982d8b9d8a7d8aa2e3c2f703e0d0a3c703ed8a7d8b3d8aad8aed8afd98520d8a7d984d983d984d985d8a7d8aa20d8a7d984d8b1d8a6d98ad8b3d98ad8a920d8a8d8b4d983d98420d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98a3a20d982d98520d8a8d8afd985d8ac20d8a7d984d983d984d985d8a7d8aa20d8a7d984d8b1d8a6d98ad8b3d98ad8a920d8b0d8a7d8aa20d8a7d984d8b5d984d8a920d981d98a20d982d8a7d8a6d985d8a920d8a3d8b9d985d8a7d984d98320d984d8aad8add8b3d98ad98620d8aad8b5d986d98ad981d8a7d8aa20d985d8add8b1d98320d8a7d984d8a8d8add8ab20d8a7d984d8aed8a7d8b520d8a8d9832e20d8b1d983d8b220d8b9d984d98920d8a7d984d983d984d985d8a7d8aa20d8a7d984d8b1d8a6d98ad8b3d98ad8a920d8a7d984d8b7d988d98ad984d8a920d8a7d984d985d8aed8b5d8b5d8a920d984d982d8b7d8a7d8b9d98320d988d8a7d984d8acd985d987d988d8b120d8a7d984d985d8b3d8aad987d8afd9812e3c2f703e0d0a3c703ed8b1d8a7d8a8d8b720d8a5d984d98920d985d988d982d8b920d8a7d984d988d98ad8a820d8a7d984d8aed8a7d8b520d8a8d98320d988d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d988d8b3d8a7d8a6d8b720d8a7d984d8a7d8acd8aad985d8a7d8b9d98ad8a93a20d982d98520d8a8d8aad8b6d985d98ad98620d8b1d988d8a7d8a8d8b720d8a5d984d98920d985d988d982d8b920d8a7d984d988d98ad8a820d8a7d984d8aed8a7d8b520d8a8d98320d988d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d988d8b3d8a7d8a6d8b720d8a7d984d8a7d8acd8aad985d8a7d8b9d98ad8a920d981d98a20d982d8a7d8a6d985d8a920d8a3d8b9d985d8a7d984d98320d984d8b2d98ad8a7d8afd8a920d8add8b1d983d8a920d8a7d984d985d8b1d988d8b120d988d8aad8b4d8acd98ad8b920d8a7d984d985d8b4d8a7d8b1d983d8a92e20d988d987d8b0d8a720d98ad988d981d8b120d984d984d8b9d985d984d8a7d8a120d8b3d8a8d984d98bd8a720d8a5d8b6d8a7d981d98ad8a920d984d985d8b9d8b1d981d8a920d8a7d984d985d8b2d98ad8af20d8b9d98620d8b9d985d984d98320d988d8a7d984d8a8d982d8a7d8a120d8b9d984d98920d8a7d8aad8b5d8a7d9842e3c2f703e0d0a3c703ed985d8b1d8a7d982d8a8d8a920d988d8aad8add984d98ad98420d8a3d8afd8a7d8a6d9833a20d8b1d8a7d982d8a820d8a3d8afd8a7d8a120d982d8a7d8a6d985d8a920d8a3d8b9d985d8a7d984d98320d8a8d8a7d986d8aad8b8d8a7d98520d984d8aad8aad8a8d8b920d985d8b1d8a7d8aa20d8a7d984d985d8b4d8a7d987d8afd8a920d988d8a7d984d986d982d8b1d8a7d8aa20d988d8aad981d8a7d8b9d984d8a7d8aa20d8a7d984d8b9d985d984d8a7d8a12e20d8a7d8b3d8aad8aed8afd98520d8a3d8afd988d8a7d8aa20d8a7d984d8aad8add984d98ad984d8a7d8aa20d984d984d8add8b5d988d98420d8b9d984d98920d8b1d8a4d98920d8add988d98420d985d8a720d98ad8b9d985d98420d8a8d8b4d983d98420d8acd98ad8af20d988d8a3d98ad98620d98ad988d8acd8af20d985d8acd8a7d98420d984d984d8aad8add8b3d98ad9862e3c2f703e0d0a3c703ed8a8d8a7d8aad8a8d8a7d8b920d987d8b0d98720d8a7d984d986d8b5d8a7d8a6d8ad20d8a7d984d8b9d8b4d8b120d8a7d984d8a3d8b3d8a7d8b3d98ad8a9d88c20d98ad985d983d986d98320d8aad8add8b3d98ad98620d982d8a7d8a6d985d8a920d8a3d8b9d985d8a7d984d98320d8b9d984d989205bd8a7d8b3d98520d985d988d982d8b920d8a7d984d988d98ad8a820d8a7d984d8aed8a7d8b520d8a8d9835d20d984d8b2d98ad8a7d8afd8a920d8b8d987d988d8b1d98320d8b9d984d98920d8a7d984d8a5d986d8aad8b1d986d8aad88c20d988d8acd8b0d8a820d8a7d984d985d8b2d98ad8af20d985d98620d8a7d984d8b9d985d984d8a7d8a1d88c20d988d8aad986d985d98ad8a920d8a3d8b9d985d8a7d984d98320d981d98a20d986d987d8a7d98ad8a920d8a7d984d985d8b7d8a7d9812e20d983d98620d8a7d8b3d8aad8a8d8a7d982d98ad98bd8a720d988d8a7d8b3d8aad985d8b120d981d98a20d8aad8add8b3d98ad98620d982d8a7d8a6d985d8aad98320d8a8d986d8a7d8a1d98b20d8b9d984d98920d8aad8b9d984d98ad982d8a7d8aa20d8a7d984d8b9d985d984d8a7d8a120d988d8a7d8aad8acd8a7d987d8a7d8aa20d8a7d984d8b3d988d98220d8a7d984d985d8aad8bad98ad8b1d8a920d984d8b6d985d8a7d98620d8a7d984d986d8acd8a7d8ad20d8b9d984d98920d8a7d984d985d8afd98920d8a7d984d8b7d988d98ad9842e3c2f703e0d0a3c703ed8aad8b0d983d8b120d8a3d98620d982d8a7d8a6d985d8a920d986d8b4d8a7d8b7d98320d8a7d984d8aad8acd8a7d8b1d98a20d8bad8a7d984d8a8d98bd8a720d985d8a720d8aad983d988d98620d8a3d988d98420d8a7d986d8b7d8a8d8a7d8b920d984d8afd98920d8a7d984d8b9d985d984d8a7d8a120d8a7d984d985d8add8aad985d984d98ad98620d8b9d98620d986d8b4d8a7d8b7d98320d8a7d984d8aad8acd8a7d8b1d98ad88c20d984d8b0d8a720d8a7d8acd8b9d984d98720d985d987d985d98bd8a7213c2f703e0d0a3c2f6c693e0d0a3c2f6f6c3e, NULL, NULL, '2024-05-07 22:55:16', '2024-05-07 22:57:08'),
(5, 20, 52, 33, 'Unlocking Success: Top 7 Local Business Tips for Thriving in Your Community', 'unlocking-success:-top-7-local-business-tips-for-thriving-in-your-community', 'Admin', 0x3c703e4c6f63616c20627573696e65737365732061726520746865206c696665626c6f6f64206f6620636f6d6d756e69746965732c206f66666572696e6720756e697175652070726f64756374732c20706572736f6e616c697a65642073657276696365732c20616e6420612073656e7365206f662062656c6f6e67696e672074686174206269672d626f782073746f7265732073696d706c792063616e2774206d617463682e20486f77657665722c2073756363656564696e672061732061206c6f63616c20627573696e657373206f776e6572207265717569726573206d6f7265207468616e206a7573742070617373696f6e20616e642064656469636174696f6ee28094697420616c736f2072657175697265732073747261746567696320706c616e6e696e6720616e64207361767679206465636973696f6e2d6d616b696e672e205768657468657220796f75277265206120736561736f6e656420656e7472657072656e657572206f72206a757374207374617274696e67206f75742c20746865736520736576656e206c6f63616c20627573696e65737320746970732077696c6c2068656c7020796f752074687269766520696e20796f757220636f6d6d756e6974793a3c2f703e0d0a3c6f6c3e0d0a3c6c693e0d0a3c703e3c7374726f6e673e456d627261636520596f7572204c6f63616c204964656e746974793c2f7374726f6e673e3a204f6e65206f6620746865206b657920616476616e7461676573206f66206265696e672061206c6f63616c20627573696e65737320697320796f757220636f6e6e656374696f6e20746f2074686520636f6d6d756e6974792e20456d627261636520796f7572206c6f63616c206964656e746974792062792070617274696369706174696e6720696e20636f6d6d756e697479206576656e74732c20737570706f7274696e67206c6f63616c206368617269746965732c20616e6420666f726d696e6720706172746e657273686970732077697468206f7468657220627573696e657373657320696e20796f757220617265612e2054686973206e6f74206f6e6c7920737472656e677468656e7320796f7572206272616e642062757420616c736f20666f7374657273206c6f79616c747920616d6f6e67206c6f63616c20637573746f6d6572732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e4f7074696d697a6520596f7572204f6e6c696e652050726573656e63653c2f7374726f6e673e3a20496e20746f6461792773206469676974616c206167652c20686176696e672061207374726f6e67206f6e6c696e652070726573656e636520697320657373656e7469616c20666f722061747472616374696e67206e657720637573746f6d65727320616e642073746179696e6720636f6d70657469746976652e204d616b65207375726520796f757220627573696e657373206973206c69737465642061636375726174656c79206f6e206c6f63616c206469726563746f726965732c207265766965772073697465732c20616e6420736f6369616c206d6564696120706c6174666f726d732e20526567756c61726c792075706461746520796f75722077656273697465207769746820667265736820636f6e74656e7420616e6420656e67616765207769746820796f75722061756469656e6365207468726f75676820736f6369616c206d6564696120746f206b656570207468656d20696e666f726d656420616e6420656e67616765642e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e50726f7669646520457863656c6c656e7420437573746f6d657220536572766963653c2f7374726f6e673e3a20457863657074696f6e616c20637573746f6d657220736572766963652069732074686520636f726e657273746f6e65206f6620616e79207375636365737366756c20627573696e6573732c20657370656369616c6c7920696e2061206c6f63616c2073657474696e6720776865726520776f72642d6f662d6d6f75746820726566657272616c732063616e206d616b65206f7220627265616b20796f75722072657075746174696f6e2e20547261696e20796f757220737461666620746f207072696f726974697a6520637573746f6d657220736174697366616374696f6e2c207265736f6c7665206973737565732070726f6d70746c792c20616e6420676f2061626f766520616e64206265796f6e6420746f2065786365656420637573746f6d6572206578706563746174696f6e732e20486170707920637573746f6d65727320617265206d6f7265206c696b656c7920746f206265636f6d652072657065617420637573746f6d65727320616e64207265636f6d6d656e6420796f757220627573696e65737320746f206f74686572732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e466f637573206f6e204c6f63616c2053454f3c2f7374726f6e673e3a204c6f63616c2073656172636820656e67696e65206f7074696d697a6174696f6e202853454f2920697320637269746963616c20666f7220656e737572696e67207468617420796f757220627573696e657373206170706561727320696e206c6f63616c2073656172636820726573756c7473207768656e20706f74656e7469616c20637573746f6d65727320617265206c6f6f6b696e6720666f722070726f6475637473206f72207365727669636573206c696b6520796f7572732e204f7074696d697a6520796f7572207765627369746520616e64206f6e6c696e65206c697374696e677320776974682072656c6576616e74206b6579776f7264732c206c6f63616c206964656e7469666965727320287375636820617320796f75722063697479206f72206e65696768626f72686f6f64292c20616e6420616363757261746520636f6e7461637420696e666f726d6174696f6e2e20456e636f75726167652073617469736669656420637573746f6d65727320746f206c6561766520706f73697469766520726576696577732c20617320746865792063616e20626f6f737420796f7572206c6f63616c207365617263682072616e6b696e67732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e4f6666657220506572736f6e616c697a656420457870657269656e6365733c2f7374726f6e673e3a204f6e65206f662074686520616476616e7461676573206f66206265696e672061206c6f63616c20627573696e65737320697320796f7572206162696c69747920746f206f6666657220706572736f6e616c697a656420657870657269656e6365732074686174206c617267657220636f72706f726174696f6e732063616e2774206d617463682e2047657420746f206b6e6f7720796f757220637573746f6d657273206f6e20612066697273742d6e616d652062617369732c20616e7469636970617465207468656972206e656564732c20616e64207461696c6f7220796f75722070726f6475637473206f7220736572766963657320746f206d65657420746865697220707265666572656e6365732e204275696c64696e67207374726f6e672072656c6174696f6e7368697073207769746820796f757220637573746f6d657273206e6f74206f6e6c7920666f7374657273206c6f79616c74792062757420616c736f207365747320796f752061706172742066726f6d2074686520636f6d7065746974696f6e2e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e5374617920466c657869626c6520616e6420416461707420746f204368616e67653c2f7374726f6e673e3a2054686520627573696e657373206c616e64736361706520697320636f6e7374616e746c792065766f6c76696e672c20616e64207375636365737366756c206c6f63616c20627573696e6573736573206172652074686f736520746861742063616e20616461707420746f206368616e676520717569636b6c7920616e64206566666563746976656c792e20537461792061627265617374206f6620696e647573747279207472656e64732c206d6f6e69746f7220796f757220636f6d70657469746f72732c20616e642062652077696c6c696e6720746f206578706572696d656e742077697468206e657720696465617320616e6420737472617465676965732e2057686574686572206974277320656d62726163696e67206e657720746563686e6f6c6f67792c2061646a757374696e6720796f75722070726963696e672073747261746567792c206f7220657870616e64696e6720796f75722070726f64756374206f66666572696e67732c2073746179696e6720666c657869626c65206973206b657920746f206c6f6e672d7465726d20737563636573732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e4d65617375726520616e6420416e616c797a6520596f757220506572666f726d616e63653c2f7374726f6e673e3a20546f20656e73757265207468617420796f757220627573696e657373206973206f6e2074686520726967687420747261636b2c206974277320696d706f7274616e7420746f20726567756c61726c79206d65617375726520616e6420616e616c797a6520796f757220706572666f726d616e63652e20547261636b206b6579206d65747269637320737563682061732073616c65732c20637573746f6d657220736174697366616374696f6e2c207765627369746520747261666669632c20616e6420736f6369616c206d6564696120656e676167656d656e7420746f206964656e7469667920617265617320666f7220696d70726f76656d656e7420616e64206d616b6520646174612d64726976656e206465636973696f6e732e20557365207468697320696e666f726d6174696f6e20746f20726566696e6520796f757220737472617465676965732c20616c6c6f63617465207265736f7572636573206d6f7265206566666563746976656c792c20616e6420647269766520636f6e74696e7565642067726f7774682e3c2f703e0d0a3c2f6c693e0d0a3c2f6f6c3e0d0a3c703e427920666f6c6c6f77696e6720746865736520736576656e206c6f63616c20627573696e65737320746970732c20796f752063616e20706f736974696f6e20796f757220627573696e65737320666f72207375636365737320616e64206265636f6d6520612076616c756564206d656d626572206f6620796f757220636f6d6d756e6974792e2052656d656d6265722c207375636365737320646f65736e27742068617070656e206f7665726e696768742c2062757420776974682064656469636174696f6e2c207065727365766572616e63652c20616e64206120636f6d6d69746d656e7420746f20657863656c6c656e63652c20796f752063616e206275696c642061207468726976696e67206c6f63616c20627573696e6573732074686174207374616e6473207468652074657374206f662074696d652e3c2f703e, NULL, NULL, '2024-05-07 23:03:31', '2024-05-07 23:03:31'),
(6, 21, 53, 33, 'استراتيجيات لتعزيز الإقبال المحلي: ٧ نصائح لنجاح الأعمال المحلية', 'استراتيجيات-لتعزيز-الإقبال-المحلي:-٧-نصائح-لنجاح-الأعمال-المحلية', 'مسؤل', 0x3c703e5469746c653a2022d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a7d8aa20d984d8aad8b9d8b2d98ad8b220d8a7d984d8a5d982d8a8d8a7d98420d8a7d984d985d8add984d98a3a20d9a720d986d8b5d8a7d8a6d8ad20d984d986d8acd8a7d8ad20d8a7d984d8a3d8b9d985d8a7d98420d8a7d984d985d8add984d98ad8a9223c2f703e0d0a3c703ed8a7d984d8a3d8b9d985d8a7d98420d8a7d984d985d8add984d98ad8a920d987d98a20d8b9d985d8a7d8af20d8a7d984d985d8acd8aad985d8b9d8a7d8aad88c20d8add98ad8ab20d8aad982d8afd98520d985d986d8aad8acd8a7d8aa20d981d8b1d98ad8afd8a9d88c20d988d8aed8afd985d8a7d8aa20d8b4d8aed8b5d98ad8a9d88c20d988d8b4d8b9d988d8b1d98bd8a720d8a8d8a7d984d8a7d986d8aad985d8a7d8a120d8a7d984d8b0d98a20d984d8a720d98ad985d983d98620d984d984d985d8aad8a7d8acd8b120d8a7d984d983d8a8d98ad8b1d8a920d8a7d984d985d8b6d8a7d8afd8a92e20d988d985d8b920d8b0d984d983d88c20d98ad8aad8b7d984d8a820d8a7d984d986d8acd8a7d8ad20d983d8b5d8a7d8add8a820d8b9d985d98420d985d8add984d98a20d8a7d984d985d8b2d98ad8af20d985d98620d8a7d984d8b4d8bad98120d988d8a7d984d8aad981d8a7d986d98ad88c20d8a8d98420d988d98ad8aad8b7d984d8a820d8a3d98ad8b6d98bd8a720d8aad8aed8b7d98ad8b7d98bd8a720d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad98bd8a720d988d8a7d8aad8aed8a7d8b020d982d8b1d8a7d8b1d8a7d8aa20d8b0d983d98ad8a92e20d8b3d988d8a7d8a120d983d986d8aa20d8b1d8a7d8a6d8af20d8a3d8b9d985d8a7d98420d985d8aad985d8b1d8b3d98bd8a720d8a3d98820d985d8a8d8aad8afd8a6d98bd8a720d981d8a5d984d98ad98320d8b3d8a8d8b920d986d8b5d8a7d8a6d8ad20d984d8aad8b9d8b2d98ad8b220d986d8acd8a7d8add98320d981d98a20d985d8acd8aad985d8b9d9833a3c2f703e0d0a3c703ed9a12e202a2ad8a7d8b9d8aad986d98220d987d988d98ad8aad98320d8a7d984d985d8add984d98ad8a92a2a3a20d8a5d8add8afd98920d8a7d984d985d8b2d8a7d98ad8a720d8a7d984d8b1d8a6d98ad8b3d98ad8a920d984d983d988d986d98320d8b9d985d98420d985d8add984d98a20d987d98820d8a7d8b1d8aad8a8d8a7d8b7d98320d8a8d8a7d984d985d8acd8aad985d8b92e20d8a7d8b9d8aad986d98220d987d988d98ad8aad98320d8a7d984d985d8add984d98ad8a920d985d98620d8aed984d8a7d98420d8a7d984d985d8b4d8a7d8b1d983d8a920d981d98a20d8a7d984d981d8b9d8a7d984d98ad8a7d8aa20d8a7d984d985d8acd8aad985d8b9d98ad8a9d88c20d988d8afd8b9d98520d8a7d984d8acd985d8b9d98ad8a7d8aa20d8a7d984d8aed98ad8b1d98ad8a920d8a7d984d985d8add984d98ad8a9d88c20d988d8aad8b4d983d98ad98420d8b4d8b1d8a7d983d8a7d8aa20d985d8b920d8a7d984d8a3d8b9d985d8a7d98420d8a7d984d8a3d8aed8b1d98920d981d98a20d985d986d8b7d982d8aad9832e20d987d8b0d8a720d984d98ad8b320d981d982d8b720d98ad8b9d8b2d8b220d8b9d984d8a7d985d8aad98320d8a7d984d8aad8acd8a7d8b1d98ad8a920d988d984d983d986d98720d98ad8b9d8b2d8b220d8a3d98ad8b6d98bd8a720d8a7d984d988d984d8a7d8a120d8a8d98ad98620d8a7d984d8b9d985d984d8a7d8a120d8a7d984d985d8add984d98ad98ad9862e3c2f703e0d0a3c703ed9a22e202a2ad982d98520d8a8d8aad8add8b3d98ad98620d988d8acd988d8afd98320d8b9d984d98920d8a7d984d8a5d986d8aad8b1d986d8aa2a2a3a20d981d98a20d8b9d8b5d8b120d8a7d984d98ad988d98520d8a7d984d8b1d982d985d98ad88c20d98ad8b9d8aad8a8d8b120d988d8acd988d8af20d982d988d98a20d8b9d984d98920d8a7d984d8a5d986d8aad8b1d986d8aa20d8a3d985d8b1d98bd8a720d8b6d8b1d988d8b1d98ad98bd8a720d984d8acd8b0d8a820d8b9d985d984d8a7d8a120d8acd8afd8af20d988d8a7d984d8a8d982d8a7d8a120d8aad986d8a7d981d8b3d98ad98bd8a72e20d8aad8a3d983d8af20d985d98620d8a3d98620d8b9d985d984d98320d985d8afd8b1d8ac20d8a8d8afd982d8a920d8b9d984d98920d8a7d984d8afd984d8a7d8a6d98420d8a7d984d985d8add984d98ad8a920d988d985d988d8a7d982d8b920d8a7d984d985d8b1d8a7d8acd8b9d8a7d8aa20d988d985d986d8b5d8a7d8aa20d8a7d984d8aad988d8a7d8b5d98420d8a7d984d8a7d8acd8aad985d8a7d8b9d98a2e20d982d98520d8a8d8aad8add8afd98ad8ab20d985d988d982d8b920d8a7d984d988d98ad8a820d8a7d984d8aed8a7d8b520d8a8d98320d8a8d8b4d983d98420d985d986d8aad8b8d98520d8a8d985d8add8aad988d98920d8acd8afd98ad8af20d988d8aad981d8a7d8b9d98420d985d8b920d8acd985d987d988d8b1d98320d985d98620d8aed984d8a7d98420d988d8b3d8a7d8a6d98420d8a7d984d8aad988d8a7d8b5d98420d8a7d984d8a7d8acd8aad985d8a7d8b9d98a20d984d8a5d8a8d982d8a7d8a6d987d98520d8b9d984d98920d8a7d8b7d984d8a7d8b920d988d985d8b4d8a7d8b1d983d8aad987d9852e3c2f703e0d0a3c703ed9a32e202a2ad982d8afd98520d8aed8afd985d8a920d8b9d985d984d8a7d8a120d985d985d8aad8a7d8b2d8a92a2a3a20d8a7d984d8aed8afd985d8a920d8a7d984d8b9d985d984d8a7d8a120d8a7d984d8a7d8b3d8aad8abd986d8a7d8a6d98ad8a920d987d98a20d8b1d983d98620d8a3d98a20d8b9d985d98420d986d8a7d8acd8add88c20d8aed8a7d8b5d8a920d981d98a20d8a5d8b9d8afd8a7d8af20d985d8add984d98a20d8add98ad8ab20d98ad985d983d98620d8a3d98620d8aad983d988d98620d8a7d984d8a5d8add8a7d984d8a7d8aa20d8b9d98620d8b7d8b1d98ad98220d8a7d984d983d984d985d8a920d8a7d984d981d985d988d98ad8a920d985d8b5d8afd8b1d98bd8a720d983d8a8d98ad8b1d98bd8a720d984d984d8b3d985d8b9d8a920d8a7d984d8acd98ad8afd8a920d8a3d98820d8a7d984d8b3d98ad8a6d8a92e20d982d98520d8a8d8aad8afd8b1d98ad8a820d985d988d8b8d981d98ad98320d8b9d984d98920d8a5d8b9d8b7d8a7d8a120d8a7d984d8a3d988d984d988d98ad8a920d984d8b1d8b6d8a720d8a7d984d8b9d985d984d8a7d8a1d88c20d988d8add98420d8a7d984d985d8b4d983d984d8a7d8aa20d8a8d8b3d8b1d8b9d8a9d88c20d988d8a7d984d8b0d987d8a7d8a820d8a5d984d98920d8a7d984d8a3d8a8d8b9d8af20d984d8aad8acd8a7d988d8b220d8aad988d982d8b9d8a7d8aa20d8a7d984d8b9d985d984d8a7d8a12e20d8a7d984d8b9d985d984d8a7d8a120d8a7d984d8b3d8b9d8afd8a7d8a120d987d98520d8a7d984d8a3d983d8abd8b120d8a7d8add8aad985d8a7d984d8a7d98b20d984d8a3d98620d98ad8b5d8a8d8add988d8a720d8b9d985d984d8a7d8a120d985d8aad983d8b1d8b1d98ad98620d988d98ad988d8b5d988d8a720d8a8d8b9d985d984d98320d984d984d8a2d8aed8b1d98ad9862e3c2f703e0d0a3c703ed9a42e202a2ad8b1d983d8b220d8b9d984d98920d8aad8add8b3d98ad98620d985d8add8b1d983d8a7d8aa20d8a7d984d8a8d8add8ab20d8a7d984d985d8add984d98ad8a92a2a3a20d8aad8add8b3d98ad98620d985d8add8b1d983d8a7d8aa20d8a7d984d8a8d8add8ab20d8a7d984d985d8add984d98ad8a9202853454f2920d8a3d985d8b120d8add98ad988d98a20d984d8b6d985d8a7d98620d8b8d987d988d8b120d8b9d985d984d98320d981d98a20d986d8aad8a7d8a6d8ac20d8a7d984d8a8d8add8ab20d8a7d984d985d8add984d98a20d8b9d986d8afd985d8a720d98ad8a8d8add8ab20d8a7d984d985d8b3d8aad8aed8afd985d988d98620d8b9d98620d985d986d8aad8acd8a7d8aa20d8a3d98820d8aed8afd985d8a7d8aa20d985d8abd98420d8aad984d98320d8a7d984d8aad98a20d8aad982d8afd985d987d8a72e20d982d98520d8a8d8aad8add8b3d98ad98620d985d988d982d8b920d8a7d984d988d98ad8a820d8a7d984d8aed8a7d8b520d8a8d98320d988d8a7d984d982d988d8a7d8a6d98520d8a7d984d8aed8a7d8b5d8a920d8a8d98320d8b9d984d98920d8a7d984d8a5d986d8aad8b1d986d8aa20d8a8d983d984d985d8a7d8aa20d985d981d8aad8a7d8add98ad8a920d8b0d8a7d8aa20d8b5d984d8a920d988d985d8b9d8b1d981d8a7d8aa20d985d8add984d98ad8a92028d985d8abd98420d985d8afd98ad986d8aad98320d8a3d98820d8add98ad9832920d988d985d8b9d984d988d985d8a7d8aa20d8a7d8aad8b5d8a7d98420d8afd982d98ad982d8a92e20d8b4d8acd8b920d8a7d984d8b9d985d984d8a7d8a120d8a7d984d985d8b1d8aad8a7d8add98ad98620d8b9d984d98920d8aad8b1d98320d8aad982d98ad98ad985d8a7d8aa20d8a5d98ad8acd8a7d8a8d98ad8a9d88c20d8add98ad8ab20d98ad985d983d98620d8a3d98620d8aad8b9d8b2d8b220d8aad982d98ad98ad985d8a7d8aad987d98520d985d8b1d8aad8a8d8a7d8aa20d8a7d984d8a8d8add8ab20d8a7d984d985d8add984d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d9832e3c2f703e0d0a3c703ed9a52e202a2ad982d8afd98520d8aad8acd8a7d8b1d8a820d8b4d8aed8b5d98ad8a92a2a3a20d8a5d8add8afd98920d8a7d984d985d8b2d8a7d98ad8a720d984d983d988d986d98320d8b9d985d98420d985d8add984d98a20d987d98820d982d8afd8b1d8aad98320d8b9d984d98920d8aad982d8afd98ad98520d8aad8acd8a7d8b1d8a820d8b4d8aed8b5d98ad8a920d984d8a720d98ad985d983d98620d984d984d8b4d8b1d983d8a7d8aa20d8a7d984d983d8a8d8b1d98920d8a7d984d985d8b6d8a7d8afd8a920d985d986d8a7d981d8b3d8aad9832e20d8aad8b9d8b1d98120d8b9d984d98920d8b9d985d984d8a7d8a6d98320d8a8d8a7d8b3d985d8a7d8a6d987d985d88c20d988d8aad988d982d8b9d8a7d8aa20d8a7d8add8aad98ad8a7d8acd8a7d8aad987d985d88c20d988d8b9d8af20d985d986d8aad8acd8a7d8aad98320d8a3d98820d8aed8afd985d8a7d8aad98320d984d8aad984d8a8d98ad8a920d8aad981d8b6d98ad984d8a7d8aad987d9852e20d8a8d986d8a7d8a120d8b9d984d8a7d982d8a7d8aa20d982d988d98ad8a920d985d8b920d8b9d985d984d8a7d8a6d98320d984d8a720d98ad8b2d98ad8af20d981d982d8b720d985d98620d8a7d984d988d984d8a7d8a120d988d984d983d986d98720d8a3d98ad8b6d98bd8a720d98ad981d8b5d984d98320d8b9d98620d8a7d984d985d986d8a7d981d8b33c2f703e, NULL, NULL, '2024-05-07 23:03:31', '2024-05-07 23:03:31'),
(7, 20, 54, 34, 'Nurturing Growth: Strategies for Small Business Success', 'nurturing-growth:-strategies-for-small-business-success', 'Admin', 0x3c703e496e20746865207661737420616e6420657665722d65766f6c76696e67206c616e647363617065206f6620636f6d6d657263652c20736d616c6c20627573696e657373657320726570726573656e742074686520686561727462656174206f6620656e7472657072656e657572736869702e2054686579206172652074686520656e67696e6573207468617420647269766520696e6e6f766174696f6e2c20637265617469766974792c20616e642065636f6e6f6d696320766974616c69747920696e20636f6d6d756e697469657320776f726c64776964652e20486f77657665722c206e617669676174696e6720746865207061746820746f207375737461696e61626c652067726f77746820696e206120636f6d7065746974697665206d61726b65742063616e2062652061206461756e74696e67206368616c6c656e67652e205965742c207769746820746865207269676874207374726174656769657320616e64206d696e647365742c20736d616c6c20627573696e65737365732063616e2074687269766520616e6420657870616e6420746865697220666f6f747072696e742e20496e207468697320626c6f672c207765276c6c206578706c6f726520736f6d65206b6579207374726174656769657320666f7220666f73746572696e67207468652067726f777468206f6620736d616c6c20627573696e65737365732e3c2f703e0d0a3c6f6c3e0d0a3c6c693e0d0a3c703e3c7374726f6e673e446566696e6520596f757220556e697175652056616c75652050726f706f736974696f6e3c2f7374726f6e673e3a2041742074686520636f7265206f66206576657279207375636365737366756c20627573696e657373206c696573206120636c65617220616e6420636f6d70656c6c696e672076616c75652070726f706f736974696f6e2e20446566696e652077686174207365747320796f757220627573696e6573732061706172742066726f6d2074686520636f6d7065746974696f6e2e205768617420756e697175652070726f64756374732c2073657276696365732c206f7220657870657269656e63657320646f20796f75206f6666657220746f20796f757220637573746f6d6572733f20556e6465727374616e64696e6720616e64206566666563746976656c7920636f6d6d756e69636174696e6720796f75722076616c75652070726f706f736974696f6e2077696c6c206e6f74206f6e6c792061747472616374206e657720637573746f6d6572732062757420616c736f20666f73746572206c6f79616c747920616e642072657065617420627573696e6573732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e466f637573206f6e20437573746f6d657220457870657269656e63653c2f7374726f6e673e3a20496e20746f64617927732068797065722d636f6e6e656374656420776f726c642c2064656c69766572696e6720657863657074696f6e616c20637573746f6d657220657870657269656e63657320697320706172616d6f756e742e20457665727920696e746572616374696f6e206120637573746f6d657220686173207769746820796f757220627573696e6573732c2077686574686572206f6e6c696e65206f72206f66666c696e652c207368617065732074686569722070657263657074696f6e20616e6420696e666c75656e636573207468656972206465636973696f6e20746f2072657475726e2e20496e7665737420696e206275696c64696e67207374726f6e672072656c6174696f6e7368697073207769746820796f757220637573746f6d6572732062792070726f766964696e6720706572736f6e616c697a656420736572766963652c2061646472657373696e67207468656972206e656564732070726f6d70746c792c20616e6420736f6c69636974696e6720666565646261636b20746f20636f6e74696e75616c6c7920696d70726f76652e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e456d627261636520496e6e6f766174696f6e3c2f7374726f6e673e3a20496e6e6f766174696f6e20697320746865206c696665626c6f6f64206f662067726f7774682e20537461792061627265617374206f6620696e647573747279207472656e64732c20656d657267696e6720746563686e6f6c6f676965732c20616e642065766f6c76696e6720636f6e73756d657220707265666572656e6365732e2042652077696c6c696e6720746f20616461707420616e6420656d6272616365206368616e676520746f2072656d61696e2072656c6576616e7420696e20612064796e616d6963206d61726b65742e20456e636f757261676520612063756c74757265206f66206372656174697669747920616e64206578706572696d656e746174696f6e2077697468696e20796f7572206f7267616e697a6174696f6e2c20656d706f776572696e6720796f7572207465616d20746f206578706c6f7265206e657720696465617320616e6420736f6c7574696f6e732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e4861726e6573732074686520506f776572206f66204469676974616c204d61726b6574696e673c2f7374726f6e673e3a20496e20746f6461792773206469676974616c206167652c20616e20656666656374697665206f6e6c696e652070726573656e636520697320657373656e7469616c20666f7220736d616c6c20627573696e657373657320746f20726561636820616e6420656e67616765207468656972207461726765742061756469656e63652e204c65766572616765206469676974616c206d61726b6574696e67206368616e6e656c73207375636820617320736f6369616c206d656469612c20656d61696c206d61726b6574696e672c20616e642073656172636820656e67696e65206f7074696d697a6174696f6e202853454f2920746f20657870616e6420796f75722072656163682c206472697665207472616666696320746f20796f757220776562736974652c20616e642067656e6572617465206c656164732e20496e7665737420696e20726f6275737420616e616c797469637320746f6f6c7320746f206d6561737572652074686520706572666f726d616e6365206f6620796f7572206469676974616c206d61726b6574696e67206566666f72747320616e64206f7074696d697a6520796f75722073747261746567696573206163636f7264696e676c792e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e4275696c642053747261746567696320506172746e657273686970733c2f7374726f6e673e3a20436f6c6c61626f726174696f6e2063616e206265206120706f77657266756c20636174616c79737420666f722067726f7774682e204964656e7469667920706f74656e7469616c20706172746e6572732c20737570706c696572732c206f7220636f6d706c656d656e7461727920627573696e6573736573207468617420736861726520796f75722076616c75657320616e6420746172676574206d61726b65742e20427920666f7267696e672073747261746567696320706172746e657273686970732c20796f752063616e2074617020696e746f206e6577206d61726b6574732c20616363657373207265736f757263657320616e64206578706572746973652c20616e6420637265617465206d757475616c6c792062656e6566696369616c206f70706f7274756e697469657320666f722067726f7774682e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e496e7665737420696e20596f7572205465616d3c2f7374726f6e673e3a20596f757220656d706c6f796565732061726520796f7572206d6f73742076616c7561626c652061737365742e20496e7665737420696e20746865697220747261696e696e672c20646576656c6f706d656e742c20616e642077656c6c2d6265696e6720746f20666f7374657220612063756c74757265206f6620657863656c6c656e636520616e64206472697665206f7267616e697a6174696f6e616c2067726f7774682e2050726f76696465206f70706f7274756e697469657320666f72206c6561726e696e6720616e642063617265657220616476616e63656d656e742c2063756c746976617465206120737570706f727469766520776f726b20656e7669726f6e6d656e742c20616e64207265636f676e697a6520616e642072657761726420746865697220636f6e747269627574696f6e732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e44697665727369667920526576656e75652053747265616d733c2f7374726f6e673e3a2052656c79696e6720746f6f2068656176696c79206f6e20612073696e676c652070726f647563742c20736572766963652c206f7220637573746f6d6572207365676d656e742063616e206c6561766520796f757220627573696e6573732076756c6e657261626c6520746f20666c756374756174696f6e7320696e20746865206d61726b65742e2044697665727369667920796f757220726576656e75652073747265616d7320627920657870616e64696e6720796f75722070726f64756374206f722073657276696365206f66666572696e67732c20746172676574696e67206e657720637573746f6d6572207365676d656e74732c206f72206578706c6f72696e67206164646974696f6e616c2073616c6573206368616e6e656c732e2054686973206e6f74206f6e6c792072656475636573207269736b2062757420616c736f2063726561746573206f70706f7274756e697469657320666f7220726576656e75652067726f7774682e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e537461792046696e616e6369616c6c792053617676793c2f7374726f6e673e3a20536f756e642066696e616e6369616c206d616e6167656d656e7420697320637269746963616c20666f7220746865206c6f6e672d7465726d2073756363657373206f6620616e7920627573696e6573732e204b656570206120636c6f736520657965206f6e20796f75722066696e616e6365732c206d6f6e69746f72206361736820666c6f772c20616e64206d61696e7461696e206163637572617465207265636f7264732e20446576656c6f7020616e6420726567756c61726c792072657669657720796f757220627573696e6573732062756467657420616e642066696e616e6369616c2070726f6a656374696f6e7320746f20656e7375726520796f75277265206f6e20747261636b20746f206d65657420796f75722067726f777468206f626a656374697665732e20436f6e7369646572207365656b696e67206164766963652066726f6d2066696e616e6369616c2070726f66657373696f6e616c73206f72206d656e746f727320746f2068656c7020796f75206d616b6520696e666f726d6564206465636973696f6e732e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e43756c7469766174652061205374726f6e67204272616e64204964656e746974793c2f7374726f6e673e3a20596f7572206272616e64206973206d6f7265207468616e206a7573742061206c6f676f206f722061207461676c696e65e28094697427732074686520657373656e6365206f6620796f757220627573696e65737320616e642077686174206974207374616e647320666f722e20496e7665737420696e206275696c64696e672061207374726f6e67206272616e64206964656e746974792074686174207265736f6e61746573207769746820796f7572207461726765742061756469656e636520616e64207365747320796f752061706172742066726f6d20636f6d70657469746f72732e20436f6e73697374656e746c7920636f6d6d756e696361746520796f7572206272616e642076616c7565732c20766f6963652c20616e6420706572736f6e616c697479206163726f737320616c6c20746f756368706f696e747320746f20637265617465206120636f68657369766520616e64206d656d6f7261626c65206272616e6420657870657269656e63652e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e53746179204167696c6520616e642041646170746976653c2f7374726f6e673e3a2046696e616c6c792c20696e20612072617069646c79206368616e67696e6720627573696e65737320656e7669726f6e6d656e742c206167696c69747920616e642061646170746162696c69747920617265206b657920746f2073746179696e67206168656164206f66207468652063757276652e20426520707265706172656420746f207069766f7420796f757220737472617465676965732c207365697a65206e6577206f70706f7274756e69746965732c20616e64206e61766967617465206368616c6c656e676573207769746820726573696c69656e636520616e642064657465726d696e6174696f6e2e20456d627261636520612067726f777468206d696e647365742074686174207669657773206f62737461636c6573206173206f70706f7274756e697469657320666f72206c6561726e696e6720616e6420696e6e6f766174696f6e2e3c2f703e0d0a3c2f6c693e0d0a3c2f6f6c3e0d0a3c703e496e20636f6e636c7573696f6e2c207768696c6520746865206a6f75726e657920746f20736d616c6c20627573696e6573732067726f777468206d617920626520667261756768742077697468206368616c6c656e6765732c206974277320616c736f2066696c6c6564207769746820656e646c65737320706f73736962696c69746965732e20427920656d62726163696e67207468657365207374726174656769657320616e6420636f6d6d697474696e6720746f20636f6e74696e756f757320696d70726f76656d656e742c20736d616c6c20627573696e65737365732063616e20756e6c6f636b2074686569722066756c6c20706f74656e7469616c2c20657870616e642074686569722072656163682c20616e642061636869657665207375737461696e61626c652067726f77746820696e20746865206c6f6e672072756e2e3c2f703e, NULL, NULL, '2024-05-07 23:07:53', '2024-05-07 23:07:53');
INSERT INTO `blog_informations` (`id`, `language_id`, `blog_category_id`, `blog_id`, `title`, `slug`, `author`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(8, 21, 55, 34, 'عنوان: بناء النمو: استراتيجيات نجاح الأعمال الصغيرة', 'عنوان:-بناء-النمو:-استراتيجيات-نجاح-الأعمال-الصغيرة', 'مسؤل', 0x3c64697620636c6173733d22666c65782d31206f766572666c6f772d68696464656e223e0d0a3c64697620636c6173733d2272656163742d7363726f6c6c2d746f2d626f74746f6d2d2d6373732d6b6564726a2d3739656c626b20682d66756c6c223e0d0a3c64697620636c6173733d2272656163742d7363726f6c6c2d746f2d626f74746f6d2d2d6373732d6b6564726a2d316e376d307975223e0d0a3c6469763e0d0a3c64697620636c6173733d22666c657820666c65782d636f6c20746578742d736d223e0d0a3c64697620636c6173733d22772d66756c6c20746578742d746f6b656e2d746578742d7072696d617279223e0d0a3c64697620636c6173733d2270792d322070782d3320746578742d62617365206d643a70782d34206d2d6175746f206d643a70782d35206c673a70782d3120786c3a70782d35223e0d0a3c64697620636c6173733d226d782d6175746f20666c657820666c65782d31206761702d3320746578742d62617365206a756963653a6761702d34206a756963653a6d643a6761702d36206d643a6d61782d772d33786c206c673a6d61782d772d5b343072656d5d20786c3a6d61782d772d5b343872656d5d223e0d0a3c64697620636c6173733d2272656c617469766520666c657820772d66756c6c206d696e2d772d3020666c65782d636f6c206167656e742d7475726e223e0d0a3c64697620636c6173733d22666c65782d636f6c206761702d31206d643a6761702d33223e0d0a3c64697620636c6173733d22666c657820666c65782d67726f7720666c65782d636f6c206d61782d772d66756c6c223e0d0a3c64697620636c6173733d226d696e2d682d5b323070785d20746578742d6d65737361676520666c657820666c65782d636f6c206974656d732d737461727420776869746573706163652d7072652d7772617020627265616b2d776f726473205b2e746578742d6d6573736167652b26616d703b5d3a6d742d35206f766572666c6f772d782d6175746f206761702d33223e0d0a3c64697620636c6173733d226d61726b646f776e2070726f736520772d66756c6c20627265616b2d776f726473206461726b3a70726f73652d696e76657274206c69676874223e0d0a3c703ed981d98a20d8a7d984d8b3d8a7d8add8a920d8a7d984d8b4d8a7d8b3d8b9d8a920d988d8a7d984d985d8aad8b7d988d8b1d8a920d8afd8a7d8a6d985d98bd8a720d984d984d8aad8acd8a7d8b1d8a9d88c20d8aad985d8abd98420d8a7d984d8a3d8b9d985d8a7d98420d8a7d984d8b5d8bad98ad8b1d8a920d986d8a8d8b620d8b1d98ad8a7d8afd8a920d8a7d984d8a3d8b9d985d8a7d9842e20d8a5d986d987d8a720d8a7d984d985d8add8b1d983d8a7d8aa20d8a7d984d8aad98a20d8aad8afd981d8b920d8a7d984d8a7d8a8d8aad983d8a7d8b120d988d8a7d984d8a5d8a8d8afd8a7d8b920d988d8a7d984d8add98ad988d98ad8a920d8a7d984d8a7d982d8aad8b5d8a7d8afd98ad8a920d981d98a20d8a7d984d985d8acd8aad985d8b9d8a7d8aa20d981d98a20d8acd985d98ad8b920d8a3d986d8add8a7d8a120d8a7d984d8b9d8a7d984d9852e20d988d985d8b920d8b0d984d983d88c20d98ad985d983d98620d8a3d98620d98ad983d988d98620d8a7d984d8aad986d982d98420d981d98a20d8b7d8b1d98ad98220d8a7d984d986d985d98820d8a7d984d985d8b3d8aad8afd8a7d98520d981d98a20d8b3d988d98220d8aad986d8a7d981d8b3d98a20d8aad8add8afd98ad98bd8a720d985d8b1d8b9d8a8d98bd8a72e20d988d985d8b920d8b0d984d983d88c20d985d8b920d8a7d984d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a7d8aa20d988d8a7d984d8b9d982d984d98ad8a920d8a7d984d8b5d8add98ad8add8a9d88c20d98ad985d983d98620d984d984d8b4d8b1d983d8a7d8aa20d8a7d984d8b5d8bad98ad8b1d8a920d8a3d98620d8aad8b2d8afd987d8b120d988d8aad988d8b3d8b920d985d986d8b7d982d8aad987d8a72e20d981d98a20d987d8b0d8a720d8a7d984d985d8afd988d986d8a9d88c20d8b3d988d98120d986d8b3d8aad983d8b4d98120d8a8d8b9d8b620d8a7d984d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a7d8aa20d8a7d984d8b1d8a6d98ad8b3d98ad8a920d984d8aad8b9d8b2d98ad8b220d986d985d98820d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d8b5d8bad98ad8b1d8a92e3c2f703e0d0a3c6f6c3e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8aad8add8afd98ad8af20d8b9d8b1d8b6d98320d8a7d984d981d8b1d98ad8af20d985d98620d986d988d8b9d9873c2f7374726f6e673e3a20d981d98a20d8acd988d987d8b120d983d98420d8b9d985d98420d986d8a7d8acd8ad20d98ad983d985d98620d8b9d8b1d8b620d982d98ad985d8a920d988d8a7d8b6d8ad20d988d8acd8b0d8a7d8a82e20d8add8afd8af20d985d8a720d98ad985d98ad8b220d8b4d8b1d983d8aad98320d8b9d98620d8a7d984d985d986d8a7d981d8b3d8a92e20d985d8a720d987d98a20d8a7d984d985d986d8aad8acd8a7d8aa20d8a3d98820d8a7d984d8aed8afd985d8a7d8aa20d8a3d98820d8a7d984d8aad8acd8a7d8b1d8a820d8a7d984d981d8b1d98ad8afd8a920d8a7d984d8aad98a20d8aad982d8afd985d987d8a720d984d8b9d985d984d8a7d8a6d983d89f20d981d987d98520d8a7d984d982d98ad985d8a920d8a7d984d985d8b6d8a7d981d8a920d988d8a7d984d8aad988d8a7d8b5d98420d8a8d8b4d983d98420d981d8b9d8a7d98420d8a8d8b9d8b1d8b6d98320d8a7d984d981d8b1d98ad8af20d984d98620d98ad8acd8b0d8a820d981d982d8b720d8b9d985d984d8a7d8a120d8acd8afd8af20d988d984d983d98620d8b3d98ad8b9d8b2d8b220d8a3d98ad8b6d98bd8a720d8a7d984d988d984d8a7d8a120d988d8a7d984d8b9d985d98420d8a7d984d985d8aad983d8b1d8b12e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8a7d984d8aad8b1d983d98ad8b220d8b9d984d98920d8aad8acd8b1d8a8d8a920d8a7d984d8b9d985d98ad9843c2f7374726f6e673e3a20d981d98a20d8b9d8a7d984d98520d8a7d984d98ad988d98520d8a7d984d985d8aad8b5d98420d8a8d8b4d983d98420d981d8a7d8a6d982d88c20d8aad982d8afd98ad98520d8aad8acd8a7d8b1d8a820d8b9d985d984d8a7d8a120d8a7d8b3d8aad8abd986d8a7d8a6d98ad8a920d8a3d985d8b120d8a8d8a7d984d8ba20d8a7d984d8a3d987d985d98ad8a92e20d983d98420d8aad981d8a7d8b9d98420d984d984d8b9d985d98ad98420d985d8b920d8b9d985d984d983d88c20d8b3d988d8a7d8a120d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aa20d8a3d98820d8aed8a7d8b1d8acd987d88c20d98ad8b4d983d98420d8a5d8afd8b1d8a7d983d987d98520d988d98ad8a4d8abd8b120d981d98a20d982d8b1d8a7d8b1d987d98520d8a8d8a7d984d8b9d988d8afd8a92e20d982d98520d8a8d8a7d984d8a7d8b3d8aad8abd985d8a7d8b120d981d98a20d8a8d986d8a7d8a120d8b9d984d8a7d982d8a7d8aa20d982d988d98ad8a920d985d8b920d8b9d985d984d8a7d8a6d98320d985d98620d8aed984d8a7d98420d8aad982d8afd98ad98520d8aed8afd985d8a920d8b4d8aed8b5d98ad8a9d88c20d988d8a7d984d8aad8b9d8a7d985d98420d985d8b920d8a7d8add8aad98ad8a7d8acd8a7d8aad987d98520d8a8d8b3d8b1d8b9d8a9d88c20d988d8a7d984d8aad985d8a7d8b320d985d984d8a7d8add8b8d8a7d8aad987d98520d984d8aad8add8b3d98ad986d987d8a720d8a8d8a7d8b3d8aad985d8b1d8a7d8b12e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8a7d8b9d8aad986d8a7d98220d8a7d984d8a7d8a8d8aad983d8a7d8b13c2f7374726f6e673e3a20d8a7d984d8a7d8a8d8aad983d8a7d8b120d987d98820d8afd98520d8a7d984d986d985d9882e20d983d98620d8b9d984d98920d8a7d8b7d984d8a7d8b920d8a8d8a7d984d8a7d8aad8acd8a7d987d8a7d8aa20d8a7d984d8b5d986d8a7d8b9d98ad8a9d88c20d988d8a7d984d8aad982d986d98ad8a7d8aa20d8a7d984d986d8a7d8b4d8a6d8a9d88c20d988d8aad981d8b6d98ad984d8a7d8aa20d8a7d984d985d8b3d8aad987d984d983d98ad98620d8a7d984d985d8aad8b7d988d8b1d8a92e20d983d98620d985d8b3d8aad8b9d8afd98bd8a720d984d984d8aad983d98ad98120d988d982d8a8d988d98420d8a7d984d8aad8bad98ad98ad8b120d984d8aad8b8d98420d8b0d8a7d8aa20d8b5d984d8a920d981d98a20d8b3d988d98220d8afd98ad986d8a7d985d98ad983d98a2e20d8b4d8acd8b920d8b9d984d98920d8abd982d8a7d981d8a920d8a7d984d8a5d8a8d8afd8a7d8b920d988d8a7d984d8aad8acd8b1d98ad8a820d8afd8a7d8aed98420d985d986d8b8d985d8aad983d88c20d985d985d8a720d98ad985d983d991d98620d981d8b1d98ad982d98320d985d98620d8a7d8b3d8aad983d8b4d8a7d98120d8a3d981d983d8a7d8b120d988d8add984d988d98420d8acd8afd98ad8afd8a92e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8a7d8b3d8aad8bad984d8a7d98420d982d988d8a920d8a7d984d8aad8b3d988d98ad98220d8a7d984d8b1d982d985d98a3c2f7374726f6e673e3a20d981d98a20d8b9d8b5d8b1d986d8a720d8a7d984d8b1d982d985d98a20d8a7d984d98ad988d985d88c20d8aad985d8abd98420d8a7d984d988d8acd988d8af20d8a7d984d8a5d984d983d8aad8b1d988d986d98a20d8a7d984d981d8b9d8a7d98420d8a3d985d8b1d98bd8a720d8b6d8b1d988d8b1d98ad98bd8a720d984d984d8b4d8b1d983d8a7d8aa20d8a7d984d8b5d8bad98ad8b1d8a920d984d984d988d8b5d988d98420d8a5d984d98920d8acd985d987d988d8b1d987d8a720d8a7d984d985d8b3d8aad987d8afd98120d988d8acd8b0d8a8d987d9852e20d8a7d8b3d8aad981d8af20d985d98620d982d986d988d8a7d8aa20d8a7d984d8aad8b3d988d98ad98220d8a7d984d8b1d982d985d98a20d985d8abd98420d988d8b3d8a7d8a6d98420d8a7d984d8aad988d8a7d8b5d98420d8a7d984d8a7d8acd8aad985d8a7d8b9d98ad88c20d988d8a7d984d8aad8b3d988d98ad98220d8b9d8a8d8b120d8a7d984d8a8d8b1d98ad8af20d8a7d984d8a5d984d983d8aad8b1d988d986d98ad88c20d988d8aad8add8b3d98ad98620d985d8add8b1d983d8a7d8aa20d8a7d984d8a8d8add8ab20d984d8aad988d8b3d98ad8b920d986d8b7d8a7d982d983d88c20d988d8b2d98ad8a7d8afd8a920d8add8b1d983d8a920d8a7d984d985d8b1d988d8b120d8a5d984d98920d985d988d982d8b9d98320d8a7d984d8a5d984d983d8aad8b1d988d986d98ad88c20d988d8aad988d984d98ad8af20d8a7d984d8b9d985d984d8a7d8a120d8a7d984d985d8add8aad985d984d98ad9862e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8a8d986d8a7d8a120d8b4d8b1d8a7d983d8a7d8aa20d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a93c2f7374726f6e673e3a20d8a7d984d8aad8b9d8a7d988d98620d98ad985d983d98620d8a3d98620d98ad983d988d98620d8b9d8a7d985d984d8a7d98b20d982d988d98ad98bd8a720d984d984d986d985d9882e20d8add8afd8af20d8a7d984d8b4d8b1d983d8a7d8a120d8a7d984d985d8add8aad985d984d98ad986d88c20d8a3d98820d8a7d984d985d988d8b1d8afd98ad986d88c20d8a3d98820d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d985d983d985d984d8a920d8a7d984d8aad98a20d8aad8b4d8aad8b1d98320d981d98a20d982d98ad985d98320d988d8b3d988d982d98320d8a7d984d985d8b3d8aad987d8afd9812e20d985d98620d8aed984d8a7d98420d8aad983d988d98ad98620d8b4d8b1d8a7d983d8a7d8aa20d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a9d88c20d98ad985d983d986d98320d8a7d984d988d984d988d8ac20d8a5d984d98920d8a3d8b3d988d8a7d98220d8acd8afd98ad8afd8a9d88c20d988d8a7d984d988d8b5d988d98420d8a5d984d98920d8a7d984d985d988d8a7d8b1d8af20d988d8a7d984d8aed8a8d8b1d8a7d8aad88c20d988d8aed984d98220d981d8b1d8b520d985d8aad8a8d8a7d8afd984d8a920d984d984d986d985d9882e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8a7d8b3d8aad8abd985d8a7d8b120d981d98a20d981d8b1d98ad982d9833c2f7374726f6e673e3a20d985d988d8b8d981d988d98320d987d98520d8a3d983d8abd8b120d8a3d8b5d988d984d98320d982d98ad985d8a92e20d982d98520d8a8d8a7d984d8a7d8b3d8aad8abd985d8a7d8b120d981d98a20d8aad8afd8b1d98ad8a8d987d98520d988d8aad8b7d988d98ad8b1d987d98520d988d8b1d981d8a7d987d98ad8aad987d98520d984d8a8d986d8a7d8a120d8abd982d8a7d981d8a920d8a7d984d8aad985d98ad8b220d988d8afd981d8b920d8a7d984d986d985d98820d8a7d984d8aad986d8b8d98ad985d98a2e20d982d8afd98520d981d8b1d8b520d8a7d984d8aad8b9d984d98520d988d8a7d984d8aad982d8afd98520d8a7d984d985d987d986d98ad88c20d988d8b9d8b2d8b220d8a7d984d8a8d98ad8a6d8a920d8a7d984d8b9d985d984d98ad8a920d8a7d984d8afd8a7d8b9d9853c2f703e0d0a3c2f6c693e0d0a3c2f6f6c3e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c64697620636c6173733d226d742d3120666c6578206761702d3320656d7074793a68696464656e223e0d0a3c64697620636c6173733d22746578742d677261792d34303020666c65782073656c662d656e64206c673a73656c662d63656e746572206974656d732d63656e746572206a7573746966792d63656e746572206c673a6a7573746966792d7374617274206d742d30202d6d6c2d3120682d37206761702d5b3270785d2076697369626c65223e0d0a3c64697620636c6173733d22666c6578206974656d732d63656e746572206761702d312e3520746578742d7873223ec2a03c2f6469763e0d0a3c64697620636c6173733d22666c6578223ec2a03c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c64697620636c6173733d2270722d32206c673a70722d30223ec2a03c2f6469763e0d0a3c2f6469763e0d0a3c64697620636c6173733d226162736f6c757465223e0d0a3c64697620636c6173733d22666c657820772d66756c6c206761702d32206974656d732d63656e746572206a7573746966792d63656e746572223ec2a03c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c64697620636c6173733d22772d66756c6c206d643a70742d30206461726b3a626f726465722d77686974652f3230206d643a626f726465722d7472616e73706172656e74206d643a6461726b3a626f726465722d7472616e73706172656e74206d643a772d5b63616c6328313030252d2e3572656d295d206a756963653a772d66756c6c223e0d0a3c64697620636c6173733d2270782d3320746578742d62617365206d643a70782d34206d2d6175746f206d643a70782d35206c673a70782d3120786c3a70782d35223e0d0a3c64697620636c6173733d226d782d6175746f20666c657820666c65782d31206761702d3320746578742d62617365206a756963653a6761702d34206a756963653a6d643a6761702d36206d643a6d61782d772d33786c206c673a6d61782d772d5b343072656d5d20786c3a6d61782d772d5b343872656d5d223e0d0a3c64697620636c6173733d2272656c617469766520666c657820682d66756c6c206d61782d772d66756c6c20666c65782d3120666c65782d636f6c223e0d0a3c64697620636c6173733d226162736f6c75746520626f74746f6d2d66756c6c206c6566742d302072696768742d30223e0d0a3c64697620636c6173733d2272656c617469766520682d66756c6c20772d66756c6c223e0d0a3c64697620636c6173733d22666c657820666c65782d636f6c206761702d332e352070622d332e352070742d32223e0d0a3c64697620636c6173733d22666c657820682d66756c6c20772d66756c6c206974656d732d63656e746572206a7573746966792d656e64206761702d302070792d34206d643a6761702d32223e0d0a3c6469763ec2a03c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e, NULL, NULL, '2024-05-07 23:07:53', '2024-05-07 23:07:53'),
(9, 20, 50, 35, 'Unleashing the Power of Business Optimization: Elevate Your Success', 'unleashing-the-power-of-business-optimization:-elevate-your-success', 'Admin', 0x3c703e496e20746f64617927732072617069646c792065766f6c76696e6720627573696e657373206c616e6473636170652c2074686520717565737420666f72206f7074696d697a6174696f6e20686173206265636f6d6520706172616d6f756e742e204576657279206f7267616e697a6174696f6e2c207265676172646c657373206f662073697a65206f7220696e6475737472792c207365656b7320746f2073747265616d6c696e65206f7065726174696f6e732c206d6178696d697a6520656666696369656e63792c20616e64206472697665207375737461696e61626c652067726f7774682e2057656c636f6d6520746f20746865207265616c6d206f6620427573696e657373204f7074696d697a6174696f6e20e2809320612073747261746567696320696d706572617469766520746861742063616e207265646566696e6520796f757220627573696e6573732773207472616a6563746f72792e3c2f703e0d0a3c68323e556e6465727374616e64696e6720427573696e657373204f7074696d697a6174696f6e3c2f68323e0d0a3c703e427573696e657373204f7074696d697a6174696f6e2069736e2774206d6572656c792061626f75742063757474696e6720636f737473206f7220696e6372656173696e672070726f6475637469766974793b20697427732061626f7574206f726368657374726174696e672061206861726d6f6e696f75732073796d70686f6e79206f662070726f6365737365732c2070656f706c652c20616e6420746563686e6f6c6f677920746f2061636869657665207065616b20706572666f726d616e63652e20497420696e766f6c766573206964656e74696679696e6720696e656666696369656e636965732c206c657665726167696e67206461746120696e7369676874732c20616e6420696d706c656d656e74696e67207461696c6f72656420736f6c7574696f6e7320746f20656e68616e6365206f766572616c6c206566666563746976656e6573732e3c2f703e0d0a3c68323e5468652050696c6c617273206f6620427573696e657373204f7074696d697a6174696f6e3c2f68323e0d0a3c68333e446174612d44726976656e20496e7369676874733c2f68333e0d0a3c703e4461746120697320746865206c696665626c6f6f64206f66206f7074696d697a6174696f6e2e204279206861726e657373696e672074686520706f776572206f66206461746120616e616c79746963732c20627573696e65737365732063616e206761696e20696e76616c7561626c6520696e73696768747320696e746f20637573746f6d6572206265686176696f722c206d61726b6574207472656e64732c20616e64206f7065726174696f6e616c20696e656666696369656e636965732e2046726f6d207072656469637469766520616e616c797469637320746f207265616c2d74696d65207265706f7274696e672c20646174612d64726976656e206465636973696f6e2d6d616b696e6720666f726d732074686520636f726e657273746f6e65206f66207375636365737366756c206f7074696d697a6174696f6e20737472617465676965732e3c2f703e0d0a3c68333e50726f6365737320496d70726f76656d656e743c2f68333e0d0a3c703e4f7074696d697a6174696f6e20626567696e7320617420746865206772617373726f6f7473206c6576656c20e2809320796f757220627573696e6573732070726f6365737365732e20427920636f6e64756374696e672074686f726f7567682070726f636573732061756469747320616e64207265656e67696e656572696e6720776f726b666c6f77732c206f7267616e697a6174696f6e732063616e20656c696d696e61746520626f74746c656e65636b732c20726564756365206379636c652074696d65732c20616e6420656e68616e6365206f766572616c6c206167696c6974792e20576865746865722069742773207468726f756768204c65616e20536978205369676d61206d6574686f646f6c6f67696573206f72206167696c65206672616d65776f726b732c20636f6e74696e756f75732070726f6365737320696d70726f76656d656e7420697320657373656e7469616c20666f722073746179696e67206168656164206f66207468652063757276652e3c2f703e0d0a3c68333e546563686e6f6c6f677920496e746567726174696f6e3c2f68333e0d0a3c703e496e20746f6461792773206469676974616c206167652c20746563686e6f6c6f677920736572766573206173206120636174616c79737420666f72206f7074696d697a6174696f6e2e2046726f6d20656e7465727072697365207265736f7572636520706c616e6e696e672028455250292073797374656d7320746f20726f626f7469632070726f63657373206175746f6d6174696f6e2028525041292c20696e746567726174696e672063757474696e672d6564676520746563686e6f6c6f676965732063616e207265766f6c7574696f6e697a6520686f7720627573696e6573736573206f7065726174652e204175746f6d6174696f6e2c20696e20706172746963756c61722c2063616e2073747265616d6c696e652072657065746974697665207461736b732c206d696e696d697a65206572726f72732c20616e642066726565207570207265736f757263657320666f72206d6f72652073747261746567696320656e646561766f72732e3c2f703e0d0a3c68333e54616c656e74204f7074696d697a6174696f6e3c2f68333e0d0a3c703e50656f706c6520617265207468652064726976696e6720666f72636520626568696e64206576657279207375636365737366756c20627573696e6573732e2054616c656e74206f7074696d697a6174696f6e20696e766f6c76657320616c69676e696e6720796f757220776f726b666f726365277320736b696c6c732c2070617373696f6e732c20616e642061737069726174696f6e732077697468206f7267616e697a6174696f6e616c20676f616c732e20427920666f73746572696e6720612063756c74757265206f6620636f6e74696e756f7573206c6561726e696e672c20656d706f7765726d656e742c20616e6420636f6c6c61626f726174696f6e2c20627573696e65737365732063616e20756e6c6f636b20746865697220656d706c6f79656573272066756c6c20706f74656e7469616c20616e6420647269766520696e6e6f766174696f6e2066726f6d2077697468696e2e3c2f703e0d0a3c68323e5468652042656e6566697473206f6620427573696e657373204f7074696d697a6174696f6e3c2f68323e0d0a3c68333e456e68616e63656420456666696369656e63793c2f68333e0d0a3c703e4f7074696d697a65642070726f636573736573206c65616420746f2073747265616d6c696e6564206f7065726174696f6e732c20726564756365642077617374652c20616e6420696e637265617365642070726f6475637469766974792e20427920656c696d696e6174696e6720726564756e64616e74207461736b7320616e64206f7074696d697a696e67207265736f7572636520616c6c6f636174696f6e2c20627573696e65737365732063616e206163636f6d706c697368206d6f72652077697468206665776572207265736f75726365732c20756c74696d6174656c7920626f6f7374696e6720746865697220626f74746f6d206c696e652e3c2f703e0d0a3c68333e496d70726f766564204167696c6974793c2f68333e0d0a3c703e496e20746f646179277320666173742d706163656420627573696e65737320656e7669726f6e6d656e742c206167696c697479206973206e6f6e2d6e65676f746961626c652e204f7074696d697a6174696f6e20656e61626c6573206f7267616e697a6174696f6e7320746f2061646170742073776966746c7920746f206368616e67696e67206d61726b65742064796e616d6963732c20637573746f6d65722064656d616e64732c20616e6420636f6d7065746974697665207072657373757265732e20576865746865722069742773207363616c696e67206f7065726174696f6e73206f72207069766f74696e6720737472617465676965732c206167696c6974792065717569707320627573696e657373657320776974682074686520726573696c69656e6365206e656564656420746f2074687269766520696e20756e6365727461696e2074696d65732e3c2f703e0d0a3c68333e4772656174657220437573746f6d657220536174697366616374696f6e3c2f68333e0d0a3c703e417420746865206865617274206f66206576657279206f7074696d697a6174696f6e20656e646561766f72206c6965732074686520637573746f6d65722e204279206f7074696d697a696e672070726f6365737365732c2070726f64756374732c20616e6420736572766963657320746f206d65657420637573746f6d6572206e6565647320616e64206578706563746174696f6e732c20627573696e65737365732063616e20666f73746572206c6f6e672d6c617374696e672072656c6174696f6e736869707320616e64206472697665206272616e64206c6f79616c74792e2053617469736669656420637573746f6d657273206e6f74206f6e6c79206265636f6d6520726570656174206275796572732062757420616c736f207365727665206173206272616e64206164766f63617465732c20616d706c696679696e6720796f757220726561636820616e642072657075746174696f6e2e3c2f703e0d0a3c68333e5375737461696e61626c652047726f7774683c2f68333e0d0a3c703e427573696e657373206f7074696d697a6174696f6e2069736e2774206a7573742061626f75742073686f72742d7465726d206761696e733b20697427732061626f7574206c6179696e67207468652067726f756e64776f726b20666f72207375737461696e61626c652067726f7774682e20427920636f6e74696e756f75736c7920726566696e696e67206f7065726174696f6e732c206164617074696e6720746f206d61726b6574206368616e6765732c20616e6420696e76657374696e6720696e20696e6e6f766174696f6e2c206f7267616e697a6174696f6e732063616e20706f736974696f6e207468656d73656c76657320666f72206c6f6e672d7465726d207375636365737320696e20616e20657665722d65766f6c76696e67206c616e6473636170652e3c2f703e0d0a3c68323e456d62726163696e6720746865204a6f75726e6579206f66204f7074696d697a6174696f6e3c2f68323e0d0a3c703e496e20636f6e636c7573696f6e2c20627573696e657373206f7074696d697a6174696f6e2069736e277420612064657374696e6174696f6e3b20697427732061206a6f75726e657920e280932061206a6f75726e657920746f7761726420657863656c6c656e63652c20656666696369656e63792c20616e6420656e647572696e6720737563636573732e20427920656d62726163696e67207468652070696c6c617273206f6620646174612d64726976656e20696e7369676874732c2070726f6365737320696d70726f76656d656e742c20746563686e6f6c6f677920696e746567726174696f6e2c20616e642074616c656e74206f7074696d697a6174696f6e2c20627573696e65737365732063616e20756e6c6f636b2074686569722066756c6c20706f74656e7469616c20616e642074687269766520696e207468652066616365206f66206164766572736974792e3c2f703e, NULL, NULL, '2024-05-07 23:10:14', '2024-05-07 23:10:14'),
(10, 21, 51, 35, 'إطلاق العنان لقوة تحسين الأعمال: ارفع مستوى نجاحك', 'إطلاق-العنان-لقوة-تحسين-الأعمال:-ارفع-مستوى-نجاحك', 'مسؤل', 0x3c703ed8a8d8bad8b620d8a7d984d986d8b8d8b120d8b9d98620d8add8acd985d987d8a720d8a3d98820d982d8b7d8a7d8b9d987d8a7d88c20d8a5d984d98920d8aad8a8d8b3d98ad8b720d8a7d984d8b9d985d984d98ad8a7d8aad88c20d988d8b2d98ad8a7d8afd8a920d8a7d984d983d981d8a7d8a1d8a9d88c20d988d8afd981d8b920d8a7d984d986d985d98820d8a7d984d985d8b3d8aad8afd8a7d9852e20d985d8b1d8add8a8d98bd8a720d8a8d983d98520d981d98a20d985d98ad8afd8a7d98620d8aad8add8b3d98ad98620d8a7d984d8a3d8b9d985d8a7d984202d20d8a7d984d8b6d8b1d988d8b1d8a920d8a7d984d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a920d8a7d984d8aad98a20d98ad985d983d98620d8a3d98620d8aad8b9d98ad8af20d8aad8b9d8b1d98ad98120d985d8b3d8a7d8b120d8b9d985d984d9832e3c2f703e0d0a3c68323ed981d987d98520d8aad8add8b3d98ad98620d8a7d984d8a3d8b9d985d8a7d9843c2f68323e0d0a3c703ed984d8a720d98ad8aad8b9d984d98220d8aad8add8b3d98ad98620d8a7d984d8a3d8b9d985d8a7d98420d981d982d8b720d8a8d8aad982d984d98ad98420d8a7d984d8aad983d8a7d984d98ad98120d8a3d98820d8b2d98ad8a7d8afd8a920d8a7d984d8a5d986d8aad8a7d8acd98ad8a9d89b20d8a8d98420d98ad8aad8b9d984d98220d8a8d8aad986d8b8d98ad98520d8b3d98ad985d981d988d986d98ad8a920d985d8aad986d8a7d8bad985d8a920d985d98620d8a7d984d8b9d985d984d98ad8a7d8aa20d988d8a7d984d8a3d8b4d8aed8a7d8b520d988d8a7d984d8aad983d986d988d984d988d8acd98ad8a720d984d8aad8add982d98ad98220d8a3d982d8b5d98920d982d8afd8b120d985d98620d8a7d984d8a3d8afd8a7d8a12e20d98ad8aad8b6d985d98620d8a7d984d8aad8add8b3d98ad98620d8aad8add8afd98ad8af20d8a7d984d981d8acd988d8a7d8aa20d981d98a20d8a7d984d983d981d8a7d8a1d8a920d988d8a7d8b3d8aad8bad984d8a7d98420d8a7d984d8a8d98ad8a7d986d8a7d8aa20d984d8aad8add982d98ad98220d8aad8add8b3d98ad986d8a7d8aa20d8b4d8a7d985d984d8a92e3c2f703e0d0a3c68323ed8a3d8b1d983d8a7d98620d8aad8add8b3d98ad98620d8a7d984d8a3d8b9d985d8a7d9843c2f68323e0d0a3c68333ed8a7d984d8aad8add984d98ad98420d8a7d984d982d8a7d8a6d98520d8b9d984d98920d8a7d984d8a8d98ad8a7d986d8a7d8aa3c2f68333e0d0a3c703ed8a7d984d8a8d98ad8a7d986d8a7d8aa20d987d98a20d8a7d984d8afd98520d8a7d984d8add98ad988d98a20d984d984d8aad8add8b3d98ad9862e20d985d98620d8aed984d8a7d98420d8a7d8b3d8aad8bad984d8a7d98420d982d988d8a920d8aad8add984d98ad98420d8a7d984d8a8d98ad8a7d986d8a7d8aad88c20d98ad985d983d98620d984d984d8b4d8b1d983d8a7d8aa20d8a7d984d8add8b5d988d98420d8b9d984d98920d8b1d8a4d98920d984d8a720d8aad982d8afd8b120d8a8d8abd985d98620d8add988d98420d8b3d984d988d98320d8a7d984d8b9d985d984d8a7d8a120d988d8a7d8aad8acd8a7d987d8a7d8aa20d8a7d984d8b3d988d98220d988d8a7d984d981d8acd988d8a7d8aa20d8a7d984d8aad8b4d8bad98ad984d98ad8a92e20d985d98620d8a7d984d8aad8add984d98ad98420d8a7d984d8aad986d8a8d8a4d98a20d8a5d984d98920d8a7d984d8aad982d8a7d8b1d98ad8b120d981d98a20d8a7d984d988d982d8aa20d8a7d984d8add982d98ad982d98ad88c20d98ad8b4d983d98420d8a7d8aad8aed8a7d8b020d8a7d984d982d8b1d8a7d8b1d8a7d8aa20d8a7d8b3d8aad986d8a7d8afd98bd8a720d8a5d984d98920d8a7d984d8a8d98ad8a7d986d8a7d8aa20d8a7d984d8add8acd8b120d8a7d984d8a3d8b3d8a7d8b3d98a20d984d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a7d8aa20d8a7d984d8aad8add8b3d98ad98620d8a7d984d986d8a7d8acd8add8a92e3c2f703e0d0a3c68333ed8aad8add8b3d98ad98620d8a7d984d8b9d985d984d98ad8a7d8aa3c2f68333e0d0a3c703ed98ad8a8d8afd8a320d8a7d984d8aad8add8b3d98ad98620d985d98620d8a7d984d8a3d8b3d8a7d8b3202d20d8b9d985d984d98ad8a7d8aa20d8b9d985d984d9832e20d985d98620d8aed984d8a7d98420d8a5d8acd8b1d8a7d8a120d8aad8afd982d98ad982d8a7d8aa20d8b9d985d984d98ad8a7d8aa20d8b4d8a7d985d984d8a920d988d8a5d8b9d8a7d8afd8a920d987d986d8afd8b3d8a920d8a7d984d8b9d985d984d98ad8a7d8aad88c20d98ad985d983d98620d984d984d985d8a4d8b3d8b3d8a7d8aa20d8a7d984d982d8b6d8a7d8a120d8b9d984d98920d8a7d984d8b9d982d8a8d8a7d8aa20d988d8aad982d984d98ad98420d8a3d988d982d8a7d8aa20d8a7d984d8afd988d8b1d8a920d988d8aad8b9d8b2d98ad8b220d8a7d984d8b1d8b4d8a7d982d8a920d8a7d984d8b9d8a7d985d8a92e20d8b3d988d8a7d8a120d983d8a7d98620d8b0d984d98320d985d98620d8aed984d8a7d98420d985d986d987d8acd98ad8a7d8aa204c65616e20536978205369676d6120d8a3d98820d8a7d984d8a5d8b7d8a7d8b1d8a7d8aa20d8a7d984d8b1d8b4d98ad982d8a9d88c20d981d8a5d98620d8a7d984d8aad8add8b3d98ad98620d8a7d984d985d8b3d8aad985d8b120d8b6d8b1d988d8b1d98a20d984d984d8a8d982d8a7d8a120d8b9d984d98920d8b1d8a3d8b320d8a7d984d8b3d984d9852e3c2f703e0d0a3c68333ed8afd985d8ac20d8a7d984d8aad983d986d988d984d988d8acd98ad8a73c2f68333e0d0a3c703ed981d98a20d8b9d8b5d8b1d986d8a720d8a7d984d8b1d982d985d98ad88c20d8aad8b9d8af20d8a7d984d8aad983d986d988d984d988d8acd98ad8a720d8add8a7d981d8b2d98bd8a720d984d984d8aad8add8b3d98ad9862e20d985d98620d986d8b8d98520d8aad8aed8b7d98ad8b720d8a7d984d985d988d8a7d8b1d8af20d8a7d984d985d8a4d8b3d8b3d98ad8a920284552502920d8a5d984d98920d8a7d984d8a3d8aad985d8aad8a920d8a7d984d8b1d988d8a8d988d8aad98ad8a920d984d984d8b9d985d984d98ad8a7d8aa202852504129d88c20d98ad985d983d98620d984d8aad983d8a7d985d98420d8a7d984d8aad982d986d98ad8a7d8aa20d8a7d984d8add8afd98ad8abd8a920d8a3d98620d98ad8add8afd8ab20d8abd988d8b1d8a920d981d98a20d983d98ad981d98ad8a920d8b9d985d98420d8a7d984d8b4d8b1d983d8a7d8aa2e20d98ad985d983d98620d984d984d8a3d8aad985d8aad8a9d88c20d8a8d8b4d983d98420d8aed8a7d8b5d88c20d8aad8a8d8b3d98ad8b720d8a7d984d985d987d8a7d98520d8a7d984d985d8aad983d8b1d8b1d8a9d88c20d988d8aad982d984d98ad98420d8a7d984d8a3d8aed8b7d8a7d8a1d88c20d988d8aad8add8b1d98ad8b120d8a7d984d985d988d8a7d8b1d8af20d984d8a3d8bad8b1d8a7d8b620d8a3d983d8abd8b120d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a92e3c2f703e0d0a3c68333ed8aad8add8b3d98ad98620d8a7d984d983d981d8a7d8a1d8a920d8a7d984d8a8d8b4d8b1d98ad8a93c2f68333e0d0a3c703ed8a7d984d8a3d8b4d8aed8a7d8b520d987d98520d8a7d984d982d988d8a920d8a7d984d8afd8a7d981d8b9d8a920d988d8b1d8a7d8a120d983d98420d986d8acd8a7d8ad20d8b9d985d984d98a2e20d98ad986d8b7d988d98a20d8aad8add8b3d98ad98620d8a7d984d983d981d8a7d8a1d8a920d8a7d984d8a8d8b4d8b1d98ad8a920d8b9d984d98920d8aad988d8acd98ad98720d985d987d8a7d8b1d8a7d8aa20d981d8b1d98ad98220d8a7d984d8b9d985d98420d988d8b4d8bad981d987d98520d988d8b7d985d988d8add8a7d8aad987d98520d985d8b920d8a3d987d8afd8a7d98120d8a7d984d985d8a4d8b3d8b3d8a92e20d985d98620d8aed984d8a7d98420d8aad8b9d8b2d98ad8b220d8abd982d8a7d981d8a920d8a7d984d981d8b9d8a7d984d98ad8a920d8a7d984d985d8b3d8aad985d8b1d8a920d988d8a7d984d8aad985d983d98ad98620d988d8a7d984d8aad8b9d8a7d988d986d88c20d98ad985d983d98620d984d984d8b4d8b1d983d8a7d8aa20d8a7d8b3d8aad8aed984d8a7d8b520d8a7d984d983d981d8a7d8a1d8a920d8a7d984d983d8a7d985d984d8a920d984d985d988d8b8d981d98ad987d8a720d988d8afd981d8b920d8a7d984d8a7d8a8d8aad983d8a7d8b120d985d98620d8a7d984d8afd8a7d8aed9842e3c2f703e0d0a3c68323ed981d988d8a7d8a6d8af20d8aad8add8b3d98ad98620d8a7d984d8a3d8b9d985d8a7d9843c2f68323e0d0a3c68333ed8b2d98ad8a7d8afd8a920d8a7d984d983d981d8a7d8a1d8a93c2f68333e0d0a3c703ed8aad8a4d8afd98a20d8a7d984d8b9d985d984d98ad8a7d8aa20d8a7d984d985d8add8b3d986d8a920d8a5d984d98920d8aad98ad8b3d98ad8b120d8a7d984d8b9d985d984d98ad8a7d8aa20d988d8aad982d984d98ad98420d8a7d984d981d8a7d982d8af20d988d8b2d98ad8a7d8afd8a920d8a7d984d8a5d986d8aad8a7d8acd98ad8a92e20d985d98620d8aed984d8a7d98420d8a7d984d982d8b6d8a7d8a120d8b9d984d98920d8a7d984d985d987d8a7d98520d8a7d984d8b2d8a7d8a6d8afd8a920d988d8aad8add8b3d98ad98620d8aad988d8b2d98ad8b920d8a7d984d985d988d8a7d8b1d8afd88c20d98ad985d983d98620d984d984d8b4d8b1d983d8a7d8aa20d8a5d986d8acd8a7d8b220d8a7d984d985d8b2d98ad8af20d8a8d8a7d8b3d8aad8aed8afd8a7d98520d985d988d8a7d8b1d8af20d8a3d982d984d88c20d985d985d8a720d98ad8b9d8b2d8b220d981d98a20d8a7d984d986d987d8a7d98ad8a920d8aed8b720d8a7d984d8a3d8b3d8a7d8b32e3c2f703e0d0a3c68333ed8b2d98ad8a7d8afd8a920d8a7d984d8b1d8b4d8a7d982d8a93c2f68333e0d0a3c703ed981d98a20d8a7d984d8a8d98ad8a6d8a920d8a7d984d8b9d985d984d98ad8a920d8a7d984d8b3d8b1d98ad8b9d8a920d8a7d984d8aed8b7d98920d8a7d984d8aad98a20d986d8b9d98ad8b4d987d8a720d8a7d984d98ad988d985d88c20d8a7d984d8b1d8b4d8a7d982d8a920d984d98ad8b3d8aa20d982d8a7d8a8d984d8a920d984d984d8aad981d8a7d988d8b62e20d98ad985d983d98620d984d984d8aad8add8b3d98ad98620d8a3d98620d98ad985d983d98620d8a7d984d985d8a4d8b3d8b3d8a7d8aa20d985d98620d8a7d984d8aad983d98ad98120d8a8d8b3d8b1d8b9d8a920d985d8b920d8a7d984d8aad8bad98ad8b1d8a7d8aa20d981d98a20d8afd98ad986d8a7d985d98ad8a7d8aa20d8a7d9843c2f703e, NULL, NULL, '2024-05-07 23:10:14', '2024-05-07 23:10:14'),
(11, 20, 52, 36, 'Boost Your Local Business: Essential Tips for Success', 'boost-your-local-business:-essential-tips-for-success', 'Admin', 0x3c703e496e20746f646179277320636f6d7065746974697665206d61726b65742c206c6f63616c20627573696e65737365732066616365206e756d65726f7573206368616c6c656e67657320696e2061747472616374696e6720616e642072657461696e696e6720637573746f6d6572732e2057697468207468652072697365206f6620652d636f6d6d6572636520616e64206269672d626f782072657461696c6572732c2069742773206d6f726520696d706f7274616e74207468616e206576657220666f72206c6f63616c20627573696e657373657320746f207374616e64206f757420616e642074687269766520696e20746865697220636f6d6d756e69746965732e205768657468657220796f75277265206120736d616c6c20626f7574697175652c206120636f7a7920636166652c206f722061206e65696768626f72686f6f642068617264776172652073746f72652c20696d706c656d656e74696e672074686520726967687420737472617465676965732063616e206d616b6520616c6c2074686520646966666572656e63652e20486572652061726520736f6d6520657373656e7469616c207469707320746f2068656c7020796f7572206c6f63616c20627573696e65737320737563636565643a3c2f703e0d0a3c6f6c3e0d0a3c6c693e0d0a3c703e3c7374726f6e673e456d627261636520596f757220436f6d6d756e6974793c2f7374726f6e673e3a204f6e65206f662074686520677265617465737420616476616e7461676573206f66206265696e672061206c6f63616c20627573696e65737320697320796f757220636f6e6e656374696f6e20746f2074686520636f6d6d756e6974792e20456e67616765207769746820796f7572206e65696768626f72732062792073706f6e736f72696e67206c6f63616c206576656e74732c2070617274696369706174696e6720696e20636f6d6d756e6974792066756e64726169736572732c206f7220686f7374696e6720776f726b73686f707320616e6420636c61737365732e204275696c64696e67207374726f6e672072656c6174696f6e7368697073207769746820796f757220636f6d6d756e6974792063616e20637265617465206c6f79616c20637573746f6d6572732077686f2077696c6c20737570706f727420796f757220627573696e65737320666f7220796561727320746f20636f6d652e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e4f6666657220506572736f6e616c697a656420457870657269656e6365733c2f7374726f6e673e3a20576861742073657473206c6f63616c20627573696e65737365732061706172742066726f6d206c617267657220636f72706f726174696f6e73206973207468656972206162696c69747920746f2070726f7669646520706572736f6e616c697a656420657870657269656e6365732e2047657420746f206b6e6f7720796f757220637573746f6d657273206279206e616d652c2072656d656d62657220746865697220707265666572656e6365732c20616e64207461696c6f7220796f75722070726f6475637473206f7220736572766963657320746f206d656574207468656972206e656564732e20576865746865722069742773206120637573746f6d697a6564207265636f6d6d656e646174696f6e206f7220612074686f7567687466756c20676573747572652c20706572736f6e616c697a656420657870657269656e63657320676f2061206c6f6e672077617920696e20666f73746572696e6720637573746f6d6572206c6f79616c74792e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e466f637573206f6e20437573746f6d657220536572766963653c2f7374726f6e673e3a20457863657074696f6e616c20637573746f6d657220736572766963652063616e207475726e2066697273742d74696d652076697369746f727320696e746f206c6f79616c20706174726f6e732e20547261696e20796f757220737461666620746f20677265657420637573746f6d6572732077697468206120736d696c652c206163746976656c79206c697374656e20746f20746865697220636f6e6365726e732c20616e6420676f2061626f766520616e64206265796f6e6420746f20656e7375726520746865697220736174697366616374696f6e2e20526573706f6e642070726f6d70746c7920746f20696e7175697269657320616e6420666565646261636b2c2077686574686572206974277320696e20706572736f6e2c206f766572207468652070686f6e652c206f72207468726f75676820736f6369616c206d65646961206368616e6e656c732e204279207072696f726974697a696e6720637573746f6d657220736572766963652c20796f75276c6c20637265617465206120706f7369746976652072657075746174696f6e2074686174206174747261637473206e657720637573746f6d65727320616e64206b65657073206578697374696e67206f6e657320636f6d696e67206261636b2e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e5574696c697a65204f6e6c696e6520506c6174666f726d733c2f7374726f6e673e3a205768696c65206d61696e7461696e696e672061207374726f6e672070726573656e636520696e20746865206c6f63616c20636f6d6d756e697479206973206372756369616c2c20646f6e277420756e646572657374696d6174652074686520706f776572206f66206f6e6c696e6520706c6174666f726d732e20437265617465206120757365722d667269656e646c79207765627369746520746861742073686f77636173657320796f75722070726f6475637473206f722073657276696365732c20616e64206f7074696d697a6520697420666f72206c6f63616c2073656172636820656e67696e65206f7074696d697a6174696f6e202853454f2920746f20696d70726f766520796f7572207669736962696c69747920696e206c6f63616c2073656172636820726573756c74732e205574696c697a6520736f6369616c206d6564696120706c6174666f726d73206c696b652046616365626f6f6b2c20496e7374616772616d2c20616e64205477697474657220746f20636f6e6e656374207769746820637573746f6d6572732c207368617265207570646174657320616e642070726f6d6f74696f6e732c20616e642073686f776361736520796f7572206272616e64277320706572736f6e616c6974792e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e436f6c6c61626f726174652077697468204f7468657220427573696e65737365733c2f7374726f6e673e3a20506172746e6572696e67207769746820636f6d706c656d656e7461727920627573696e657373657320696e20796f757220617265612063616e20657870616e6420796f757220726561636820616e642061747472616374206e657720637573746f6d6572732e20436f6e73696465722063726f73732d70726f6d6f74696f6e732c206a6f696e74206576656e74732c206f7220636f2d6272616e6465642070726f64756374732f736572766963657320746f206c657665726167652065616368206f74686572277320637573746f6d657220626173652e20427920636f6c6c61626f726174696e672077697468206f74686572206c6f63616c20627573696e65737365732c20796f752063616e2074617020696e746f206e6577206d61726b65747320616e6420737472656e677468656e20796f757220706f736974696f6e2077697468696e2074686520636f6d6d756e6974792e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e5374617920466c657869626c6520616e642041646170743c2f7374726f6e673e3a20496e20746f646179277320666173742d706163656420627573696e65737320656e7669726f6e6d656e742c206974277320657373656e7469616c20746f207374617920666c657869626c6520616e6420616461707420746f206368616e67696e67207472656e647320616e6420637573746f6d657220707265666572656e6365732e204b65657020616e20657965206f6e20696e64757374727920646576656c6f706d656e74732c206d6f6e69746f7220796f757220636f6d70657469746f72732c20616e642062652077696c6c696e6720746f2061646a75737420796f75722073747261746567696573206163636f7264696e676c792e2057686574686572206974277320696e74726f647563696e67206e65772070726f64756374732c207570646174696e6720796f7572206d656e752c206f7220696d706c656d656e74696e6720696e6e6f766174697665206d61726b6574696e6720746163746963732c2073746179696e67206168656164206f66207468652063757276652077696c6c2068656c7020796f757220627573696e6573732074687269766520696e20746865206c6f6e672072756e2e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673e536f6c6963697420616e6420416374206f6e20466565646261636b3c2f7374726f6e673e3a20596f757220637573746f6d6572732720666565646261636b20697320696e76616c7561626c6520696e2068656c70696e6720796f7520696d70726f766520796f757220627573696e6573732e20456e636f757261676520637573746f6d65727320746f206c6561766520726576696577732c20706172746963697061746520696e20737572766579732c206f722070726f7669646520666565646261636b206469726563746c792e2054616b6520636f6e7374727563746976652063726974696369736d20736572696f75736c7920616e642075736520697420617320616e206f70706f7274756e69747920746f206d616b65206e656365737361727920696d70726f76656d656e74732e204279206163746976656c7920736f6c69636974696e6720616e6420616374696e67206f6e20666565646261636b2c20796f752064656d6f6e73747261746520796f757220636f6d6d69746d656e7420746f2070726f766964696e6720746865206265737420706f737369626c6520657870657269656e636520666f7220796f757220637573746f6d6572732e3c2f703e0d0a3c2f6c693e0d0a3c2f6f6c3e0d0a3c703e496e20636f6e636c7573696f6e2c2073756363656564696e672061732061206c6f63616c20627573696e657373207265717569726573206120636f6d62696e6174696f6e206f6620636f6d6d756e69747920656e676167656d656e742c20706572736f6e616c697a656420736572766963652c206f6e6c696e652070726573656e63652c20636f6c6c61626f726174696f6e2c2061646170746162696c6974792c20616e6420612072656c656e746c65737320666f637573206f6e20637573746f6d657220736174697366616374696f6e2e20427920696d706c656d656e74696e6720746865736520657373656e7469616c20746970732c20796f752063616e20646966666572656e746961746520796f757220627573696e6573732c2061747472616374206c6f79616c20637573746f6d6572732c20616e642074687269766520696e20796f7572206c6f63616c206d61726b65742e3c2f703e, NULL, NULL, '2024-05-07 23:13:27', '2024-05-07 23:13:27'),
(12, 21, 53, 36, 'تعزيز عملك المحلي: نصائح أساسية للنجاح', 'تعزيز-عملك-المحلي:-نصائح-أساسية-للنجاح', 'مسؤل', 0x3c703ed98a20d8a7d984d8b3d988d98220d8a7d984d8aad986d8a7d981d8b3d98ad8a920d8a7d984d8add8a7d984d98ad8a9d88c20d8aad988d8a7d8acd98720d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d985d8add984d98ad8a920d8aad8add8afd98ad8a7d8aa20d8b9d8afd98ad8afd8a920d981d98a20d8acd8b0d8a820d988d8a7d8b3d8aad8a8d982d8a7d8a120d8a7d984d8b9d985d984d8a7d8a12e20d985d8b920d8a7d8b1d8aad981d8a7d8b920d8a7d984d8aad8acd8a7d8b1d8a920d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a920d988d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d983d8a8d98ad8b1d8a9d88c20d985d98620d8a7d984d985d987d98520d8a3d983d8abd8b120d985d98620d8a3d98a20d988d982d8aa20d985d8b6d98920d984d984d8b4d8b1d983d8a7d8aa20d8a7d984d985d8add984d98ad8a920d8a3d98620d8aad8a8d8b1d8b220d988d8aad8b2d8afd987d8b120d981d98a20d985d8acd8aad985d8b9d8a7d8aad987d8a72e20d8b3d988d8a7d8a120d983d986d8aa20d985d8aad8acd8b1d98bd8a720d8b5d8bad98ad8b1d98bd8a7d88c20d8a3d98820d985d982d987d989d98b20d985d8b1d98ad8add98bd8a7d88c20d8a3d98820d985d8aad8acd8b1d98bd8a720d984d984d8a3d8afd988d8a7d8aa20d981d98a20d8a7d984d8add98ad88c20d98ad985d983d98620d8a3d98620d8aad8add982d98220d8aad8b7d8a8d98ad98220d8a7d984d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a7d8aa20d8a7d984d8b5d8add98ad8add8a920d981d8a7d8b1d982d98bd8a720d983d8a8d98ad8b1d98bd8a72e20d981d98ad985d8a720d98ad984d98a20d8a8d8b9d8b620d8a7d984d986d8b5d8a7d8a6d8ad20d8a7d984d8a3d8b3d8a7d8b3d98ad8a920d984d985d8b3d8a7d8b9d8afd8a920d8b9d985d984d98320d8a7d984d985d8add984d98a20d8b9d984d98920d8a7d984d986d8acd8a7d8ad3a3c2f703e0d0a3c6f6c3e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8aad8a8d986d98ed99120d8b9d985d984d98320d8a7d984d985d8acd8aad985d8b9d98a3c2f7374726f6e673e3a20d8a3d8add8af20d8a3d983d8a8d8b120d8a7d984d985d8b2d8a7d98ad8a720d984d8aad8b4d8bad98ad98420d8b9d985d98420d985d8add984d98a20d987d98820d8a7d8b1d8aad8a8d8a7d8b7d98320d8a8d8a7d984d985d8acd8aad985d8b92e20d8aad981d8a7d8b9d98420d985d8b920d8acd98ad8b1d8a7d986d98320d985d98620d8aed984d8a7d98420d8b1d8b9d8a7d98ad8a920d8a7d984d981d8b9d8a7d984d98ad8a7d8aa20d8a7d984d985d8add984d98ad8a9d88c20d988d8a7d984d985d8b4d8a7d8b1d983d8a920d981d98a20d8add985d984d8a7d8aa20d8a7d984d8aad985d988d98ad984d88c20d8a3d98820d8aad986d8b8d98ad98520d988d8b1d8b420d8a7d984d8b9d985d98420d988d8a7d984d8afd988d8b1d8a7d8aa2e20d8a8d986d8a7d8a120d8b9d984d8a7d982d8a7d8aa20d982d988d98ad8a920d985d8b920d985d8acd8aad985d8b9d98320d98ad985d983d98620d8a3d98620d98ad8aed984d98220d8b9d985d984d8a7d8a120d985d8aed984d8b5d98ad98620d8b3d98ad8afd8b9d985d988d98620d8b9d985d984d98320d984d8b3d986d988d8a7d8aa20d982d8a7d8afd985d8a92e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed982d8afd98520d8aad8acd8a7d8b1d8a820d985d8aed8b5d8b5d8a93c2f7374726f6e673e3a20d985d8a720d98ad985d98ad8b220d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d985d8add984d98ad8a920d8b9d98620d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d983d8a8d98ad8b1d8a920d987d98820d982d8afd8b1d8aad987d8a720d8b9d984d98920d8aad982d8afd98ad98520d8aad8acd8a7d8b1d8a820d985d8aed8b5d8b5d8a92e20d8aad8b9d8b1d98120d8b9d984d98920d8b9d985d984d8a7d8a6d98320d8a8d8a7d984d8a7d8b3d985d88c20d988d8aad8b0d983d8b120d8aad981d8b6d98ad984d8a7d8aad987d985d88c20d988d8add8afd8af20d985d986d8aad8acd8a7d8aad98320d8a3d98820d8aed8afd985d8a7d8aad98320d984d8aad984d8a8d98ad8a920d8a7d8add8aad98ad8a7d8acd8a7d8aad987d9852e20d8b3d988d8a7d8a120d983d8a7d986d8aa20d8aad988d8b5d98ad8a920d985d8aed8b5d8b5d8a920d8a3d98820d984d981d8aad8a920d985d8afd8b1d988d8b3d8a9d88c20d981d8a5d98620d8a7d984d8aad8acd8a7d8b1d8a820d8a7d984d985d8aed8b5d8b5d8a920d8aad984d8b9d8a820d8afd988d8b1d98bd8a720d983d8a8d98ad8b1d98bd8a720d981d98a20d8aad8b9d8b2d98ad8b220d988d984d8a7d8a120d8a7d984d8b9d985d984d8a7d8a12e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8b1d983d8b220d8b9d984d98920d8aed8afd985d8a920d8a7d984d8b9d985d984d8a7d8a13c2f7374726f6e673e3a20d98ad985d983d98620d984d8aed8afd985d8a920d8a7d984d8b9d985d984d8a7d8a120d8a7d984d8a7d8b3d8aad8abd986d8a7d8a6d98ad8a920d8aad8add988d98ad98420d8a7d984d8b2d988d8a7d8b120d984d8a3d988d98420d985d8b1d8a920d8a5d984d98920d8b2d8a8d8a7d8a6d98620d985d8aed984d8b5d98ad9862e20d982d98520d8a8d8aad8afd8b1d98ad8a820d985d988d8b8d981d98ad98320d8b9d984d98920d8a7d984d8aad8b1d8add98ad8a820d8a8d8a7d984d8b9d985d984d8a7d8a120d8a8d8a7d8a8d8aad8b3d8a7d985d8a9d88c20d988d8a7d984d8a7d8b3d8aad985d8a7d8b920d8a8d8a7d986d8aad8a8d8a7d98720d984d985d8b4d8a7d983d984d987d985d88c20d988d8a7d984d8b0d987d8a7d8a820d8a5d984d98920d8a7d984d8a3d985d8a7d98520d984d8b6d985d8a7d98620d8b1d8b6d8a7d987d9852e20d8a7d8b3d8aad8acd8a820d8a8d8b3d8b1d8b9d8a920d984d984d8a7d8b3d8aad981d8b3d8a7d8b1d8a7d8aa20d988d8a7d984d8aad8b9d984d98ad982d8a7d8aad88c20d8b3d988d8a7d8a120d983d8a7d98620d8b0d984d98320d8b4d8aed8b5d98ad98bd8a7d88c20d8b9d8a8d8b120d8a7d984d987d8a7d8aad981d88c20d8a3d98820d985d98620d8aed984d8a7d98420d988d8b3d8a7d8a6d98420d8a7d984d8aad988d8a7d8b5d98420d8a7d984d8a7d8acd8aad985d8a7d8b9d98a2e20d985d98620d8aed984d8a7d98420d8a5d8b9d8b7d8a7d8a120d8a7d984d8a3d988d984d988d98ad8a920d984d8aed8afd985d8a920d8a7d984d8b9d985d984d8a7d8a1d88c20d8b3d8aad8aed984d98220d8b3d985d8b9d8a920d8a5d98ad8acd8a7d8a8d98ad8a920d8aad8acd8b0d8a820d8b9d985d984d8a7d8a120d8acd8afd8afd98bd8a720d988d8aad8add8aad981d8b820d8a8d8a7d984d982d8afd8a7d985d9892e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8a7d8b3d8aad8aed8afd98520d8a7d984d986d98fd8b3d8ae20d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a93c2f7374726f6e673e3a20d8a8d98ad986d985d8a720d98ad8add8a7d981d8b820d8a7d984d8aad988d8a7d8acd8af20d8a7d984d982d988d98a20d981d98a20d8a7d984d985d8acd8aad985d8b920d8a7d984d985d8add984d98a20d8b9d984d98920d8a3d987d985d98ad8a920d983d8a8d98ad8b1d8a9d88c20d984d8a720d8aad8b3d8aad987d98620d8a8d982d988d8a920d8a7d984d986d98fd8b3d8ae20d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a92e20d982d98520d8a8d8a5d986d8b4d8a7d8a120d985d988d982d8b920d988d98ad8a820d8b3d987d98420d8a7d984d8a7d8b3d8aad8aed8afd8a7d98520d98ad8b9d8b1d8b620d985d986d8aad8acd8a7d8aad98320d8a3d98820d8aed8afd985d8a7d8aad983d88c20d988d982d98520d8a8d8aad8add8b3d98ad986d98720d984d8aad8add8b3d98ad98620d8b8d987d988d8b1d98320d981d98a20d986d8aad8a7d8a6d8ac20d8a7d984d8a8d8add8ab20d8a7d984d985d8add984d98ad8a92e20d8a7d8b3d8aad8aed8afd98520d985d986d8b5d8a7d8aa20d8a7d984d8aad988d8a7d8b5d98420d8a7d984d8a7d8acd8aad985d8a7d8b9d98a20d985d8abd98420d8a7d984d981d98ad8b3d8a8d988d98320d988d8a5d986d8b3d8aad8bad8b1d8a7d98520d988d8aad988d98ad8aad8b120d984d984d8aad988d8a7d8b5d98420d985d8b920d8a7d984d8b9d985d984d8a7d8a1d88c20d988d985d8b4d8a7d8b1d983d8a920d8a7d984d8aad8add8afd98ad8abd8a7d8aa20d988d8a7d984d8b9d8b1d988d8b620d988d8b9d8b1d8b620d8b4d8aed8b5d98ad8a920d8b9d984d8a7d985d8aad9832e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed8aad8b9d8a7d988d98620d985d8b920d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d8a3d8aed8b1d9893c2f7374726f6e673e3a20d8a7d984d8aad8b9d8a7d988d98620d985d8b920d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d985d983d985d984d8a920d981d98a20d985d986d8b7d982d8aad98320d98ad985d983d98620d8a3d98620d98ad988d8b3d8b920d986d8b7d8a7d982d98320d988d98ad8acd8b0d8a820d8b9d985d984d8a7d8a120d8acd8afd8afd98bd8a72e20d8a7d981d983d8b120d981d98a20d8a7d984d8aad8b1d988d98ad8ac20d8a7d984d985d8b4d8aad8b1d983d88c20d988d8a7d984d981d8b9d8a7d984d98ad8a7d8aa20d8a7d984d985d8b4d8aad8b1d983d8a9d88c20d8a3d98820d8a7d984d985d986d8aad8acd8a7d8aa2fd8a7d984d8aed8afd985d8a7d8aa20d8a7d984d985d8b4d8aad8b1d983d8a920d984d984d8a7d8b3d8aad981d8a7d8afd8a920d985d98620d982d8a7d8b9d8afd8a920d8b9d985d984d8a7d8a120d8a8d8b9d8b6d983d98520d8a7d984d8a8d8b9d8b62e20d985d98620d8aed984d8a7d98420d8a7d984d8aad8b9d8a7d988d98620d985d8b920d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d985d8add984d98ad8a920d8a7d984d8a3d8aed8b1d989d88c20d98ad985d983d986d98320d8a7d984d988d8b5d988d98420d8a5d984d98920d8a3d8b3d988d8a7d98220d8acd8afd98ad8afd8a920d988d8aad8b9d8b2d98ad8b220d985d988d982d8b9d98320d8b6d985d98620d8a7d984d985d8acd8aad985d8b92e3c2f703e0d0a3c2f6c693e0d0a3c6c693e0d0a3c703e3c7374726f6e673ed983d98620d985d8b1d986d98bd8a720d988d8aad983d98ad9813c2f7374726f6e673e3a20d981d98a20d8a7d984d8a8d98ad8a6d8a920d8a7d984d8aad8acd8a7d8b1d98ad8a920d8a7d984d8b3d8b1d98ad8b9d8a920d8a7d984d8aad8bad98ad8b120d8a7d984d8add8a7d984d98ad8a9d88c20d985d98620d8a7d984d8b6d8b1d988d8b1d98a20d8a7d984d8a8d982d8a7d8a120d985d8b1d986d98bd8a720d988d8a7d984d8aad983d98ad98120d985d8b920d8a7d984d8aad8bad98ad8b1d8a7d8aa20d981d98a20d8a7d984d8a7d8aad8acd8a7d987d8a7d8aa20d988d8aad981d8b6d98ad984d8a7d8aa20d8a7d984d8b9d985d984d8a7d8a12e20d8a7d986d8b8d8b120d8a53c2f703e0d0a3c2f6c693e0d0a3c2f6f6c3e, NULL, NULL, '2024-05-07 23:13:27', '2024-05-07 23:13:27');
INSERT INTO `blog_informations` (`id`, `language_id`, `blog_category_id`, `blog_id`, `title`, `slug`, `author`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(13, 20, 54, 37, 'From Seedling to Skyline: Nurturing Small Business Growth', 'from-seedling-to-skyline:-nurturing-small-business-growth', 'Admin', 0x3c703e496e207468652076617374206c616e647363617065206f6620636f6d6d657263652c20736d616c6c20627573696e6573736573207374616e6420617320626561636f6e73206f6620696e6e6f766174696f6e2c207065727365766572616e63652c20616e642074686520656d626f64696d656e74206f662074686520656e7472657072656e65757269616c207370697269742e20546865736520656e7465727072697365732c206f6674656e20626f726e206f7574206f6620612073696e67756c617220766973696f6e20616e64206675656c656420627920756e7761766572696e672064657465726d696e6174696f6e2c20636f6e74726962757465207369676e69666963616e746c7920746f207468652065636f6e6f6d6963207461706573747279206f6620736f6369657469657320776f726c64776964652e205965742c20616d696473742074686569722068756d626c6520626567696e6e696e677320616e64206d6f64657374207363616c65732c206c69657320612070726f666f756e6420706f74656e7469616c20666f722067726f7774682c2065766f6c7574696f6e2c20616e6420696d706163742e3c2f703e0d0a3c703e546865206a6f75726e6579206f66206120736d616c6c20627573696e65737320697320616b696e20746f206e7572747572696e67206120736565646c696e6720696e746f2061206d6967687479206f616b20747265652e204974207265717569726573206d65746963756c6f757320636172652c2073747261746567696320706c616e6e696e672c20616e6420612077696c6c696e676e65737320746f20616461707420746f20657665722d6368616e67696e6720656e7669726f6e6d656e74732e20576861742073657473207375636365737366756c20736d616c6c20627573696e6573736573206170617274206973206e6f74206d6572656c79207468656972206162696c69747920746f2073757276697665206275742074686569722072656c656e746c6573732070757273756974206f662067726f77746820696e20616c6c20697473206661636574732e3c2f703e0d0a3c68333e43756c7469766174696e6720566973696f6e20616e642050617373696f6e3c2f68333e0d0a3c703e417420746865206865617274206f6620657665727920736d616c6c20627573696e657373206973206120766973696f6e61727920696e646976696475616c206f7220612067726f7570206f66206c696b652d6d696e64656420696e646976696475616c732064726976656e2062792070617373696f6e20616e6420707572706f73652e205468697320766973696f6e20736572766573206173207468652067756964696e6720737461722c20696c6c756d696e6174696e6720746865207061746820666f7277617264207468726f75676820746865206d75726b7920776174657273206f6620756e6365727461696e74792e204974206973207468697320636c6172697479206f6620707572706f73652074686174206675656c732074686520696e697469616c20737061726b20616e642069676e697465732074686520666c616d6573206f6620656e7472657072656e657572736869702e3c2f703e0d0a3c68333e506c616e74696e6720746865205365656473206f6620496e6e6f766174696f6e3c2f68333e0d0a3c703e496e6e6f766174696f6e206c6965732061742074686520636f7265206f66207375737461696e61626c652067726f7774682e20536d616c6c20627573696e6573736573206d75737420636f6e74696e756f75736c7920696e6e6f7661746520746f20737461792072656c6576616e7420696e2064796e616d6963206d61726b6574732e2057686574686572206974277320656d62726163696e672063757474696e672d6564676520746563686e6f6c6f676965732c207265696d6167696e696e6720747261646974696f6e616c207072616374696365732c206f722070696f6e656572696e67206e6f76656c20736f6c7574696f6e7320746f206167652d6f6c642070726f626c656d732c20696e6e6f766174696f6e207365727665732061732074686520636174616c79737420666f7220657870616e73696f6e20616e6420646966666572656e74696174696f6e2e3c2f703e0d0a3c68333e4e617669676174696e67204368616c6c656e676573207769746820526573696c69656e63653c2f68333e0d0a3c703e54686520726f616420746f2067726f77746820697320726172656c7920736d6f6f74682c2070657070657265642077697468206f62737461636c657320616e64206368616c6c656e676573206174206576657279207475726e2e2045636f6e6f6d696320646f776e7475726e732c2066696572636520636f6d7065746974696f6e2c20726567756c61746f727920687572646c657320e280932074686573652061726520627574206120666577206f662074686520666f726d696461626c6520616476657273617269657320736d616c6c20627573696e657373657320656e636f756e74657220616c6f6e67207468656972206a6f75726e65792e205965742c20697420697320707265636973656c7920647572696e672074686573652074756d756c74756f75732074696d6573207468617420726573696c69656e6365207368696e6573206272696768746573742e20536d616c6c20627573696e6573736573206d7573742077656174686572207468652073746f726d73207769746820666f727469747564652c206c6561726e696e672066726f6d207365746261636b732c20616e6420656d657267696e67207374726f6e67657220616e642077697365722e3c2f703e0d0a3c68333e466f73746572696e672052656c6174696f6e736869707320616e6420436f6d6d756e6974793c2f68333e0d0a3c703e4e6f20627573696e6573732065786973747320696e2069736f6c6174696f6e2e2043756c7469766174696e67207374726f6e672072656c6174696f6e7368697073207769746820637573746f6d6572732c20737570706c696572732c20616e642074686520636f6d6d756e697479206174206c6172676520697320706172616d6f756e7420666f72207375737461696e65642067726f7774682e20546865736520636f6e6e656374696f6e73206e6f74206f6e6c7920666f73746572206c6f79616c747920616e642074727573742062757420616c736f207365727665206173206120736f75726365206f6620696e76616c7561626c6520666565646261636b20616e6420737570706f72742e20496e206120776f726c6420696e756e646174656420776974682063686f696365732c2069742773207468652068756d616e20746f75636820616e6420706572736f6e616c697a656420657870657269656e63657320746861742073657420736d616c6c20627573696e65737365732061706172742e3c2f703e0d0a3c68333e5363616c696e6720526573706f6e7369626c7920616e64205375737461696e61626c793c2f68333e0d0a3c703e417320736d616c6c20627573696e6573736573206761696e206d6f6d656e74756d2c207468652074656d70746174696f6e20746f207363616c652072617069646c792063616e20626520616c6c7572696e672e20486f77657665722c2067726f777468206d75737420626520617070726f616368656420776974682063617574696f6e20616e6420666f726573696768742e205363616c696e6720746f6f20717569636b6c7920776974686f7574206164657175617465207265736f7572636573206f7220696e6672617374727563747572652063616e206c65616420746f206f7065726174696f6e616c20696e656666696369656e6369657320616e642064696c7574696f6e206f66207175616c6974792e205375737461696e61626c652067726f77746820656e7461696c7320737472696b696e6720612064656c69636174652062616c616e6365206265747765656e20616d626974696f6e20616e642070727564656e63652c207363616c696e6720617420612070616365207468617420656e7375726573206c6f6e672d7465726d2076696162696c69747920616e642073746162696c6974792e3c2f703e0d0a3c68333e456d62726163696e67204469676974616c205472616e73666f726d6174696f6e3c2f68333e0d0a3c703e496e20616e20696e6372656173696e676c79206469676974697a656420776f726c642c20656d62726163696e6720746563686e6f6c6f6779206973206e6f206c6f6e67657220612063686f696365206275742061206e656365737369747920666f7220736d616c6c20627573696e6573736573206c6f6f6b696e6720746f207468726976652e2046726f6d2065737461626c697368696e67206120726f62757374206f6e6c696e652070726573656e636520746f206c657665726167696e67206461746120616e616c797469637320666f7220696e666f726d6564206465636973696f6e2d6d616b696e672c206469676974616c207472616e73666f726d6174696f6e206f70656e73207570206120776f726c64206f66206f70706f7274756e697469657320666f722067726f77746820616e6420657870616e73696f6e2e20456d62726163696e6720746563686e6f6c6f6779206e6f74206f6e6c7920656e68616e636573206f7065726174696f6e616c20656666696369656e63792062757420616c736f20656e61626c657320736d616c6c20627573696e657373657320746f207265616368206e6577206d61726b65747320616e642064656d6f67726170686963732e3c2f703e0d0a3c68333e43656c6562726174696e67204d696c6573746f6e657320616e642041636b6e6f776c656467696e672050726f67726573733c2f68333e0d0a3c703e416d696473742074686520687573746c6520616e6420627573746c65206f66206461696c79206f7065726174696f6e732c206974277320657373656e7469616c20666f7220736d616c6c20627573696e657373206f776e65727320746f2070617573652c207265666c6563742c20616e642063656c656272617465206d696c6573746f6e657320616c6f6e6720746865206a6f75726e65792e20576865746865722069742773207265616368696e67206120726576656e7565207461726765742c20657870616e64696e6720696e746f206e6577207465727269746f726965732c206f7220726563656976696e67206163636f6c6164657320666f72206578656d706c61727920736572766963652c207468657365206d696c6573746f6e6573207365727665206173206d61726b657273206f662070726f677265737320616e642072656d696e64657273206f66207468652064697374616e63652074726176656c65642e2043656c6562726174696e6720616368696576656d656e7473206e6f74206f6e6c7920626f6f737473206d6f72616c652062757420616c736f20696e7374696c6c7320612073656e7365206f6620707269646520616e64206d6f7469766174696f6e20746f20636f6e74696e75652070757368696e672074686520626f756e646172696573206f662077686174277320706f737369626c652e3c2f703e0d0a3c703e496e20636f6e636c7573696f6e2c207468652067726f777468206a6f75726e6579206f66206120736d616c6c20627573696e65737320697320612074657374616d656e7420746f2074686520696e646f6d697461626c6520737069726974206f6620656e7472657072656e657572736869702e20497427732061206a6f75726e657920636861726163746572697a656420627920726573696c69656e63652c20696e6e6f766174696f6e2c20616e6420756e7761766572696e672064657465726d696e6174696f6e2e20417320736d616c6c20627573696e657373657320636f6e74696e756520746f2065766f6c766520616e6420666c6f75726973682c2074686579206e6f74206f6e6c7920636f6e7472696275746520746f207468652076696272616e6379206f66206c6f63616c2065636f6e6f6d6965732062757420616c736f20696e7370697265206675747572652067656e65726174696f6e73206f6620647265616d65727320616e6420646f65727320746f20656d6261726b206f6e207468656972206f776e20656e7472657072656e65757269616c206f6479737365792e3c2f703e, NULL, NULL, '2024-05-07 23:15:49', '2024-05-07 23:15:49'),
(14, 21, 55, 37, 'من بذرة صغيرة إلى سماء النجاح: تنمية نمو الأعمال الصغيرة', 'من-بذرة-صغيرة-إلى-سماء-النجاح:-تنمية-نمو-الأعمال-الصغيرة', 'مسؤل', 0x3c703ed981d98a20d8a7d984d8b3d8a7d8add8a920d8a7d984d988d8a7d8b3d8b9d8a920d984d984d8aad8acd8a7d8b1d8a9d88c20d8aad982d98120d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d8b5d8bad98ad8b1d8a920d983d985d8b5d8a7d8a8d98ad8ad20d98ad8a8d984d8bad987d8a720d8a7d984d8a5d8a8d8afd8a7d8b920d988d8a7d984d985d8abd8a7d8a8d8b1d8a9d88c20d988d8aad8acd8b3d8af20d8b1d988d8ad20d8a7d984d8b1d988d8a7d8af20d8a7d984d8b1d98ad8a7d8afd98ad98ad9862e20d8aad984d98320d8a7d984d985d8b4d8a7d8b1d98ad8b9d88c20d8a7d984d8aad98a20d8bad8a7d984d8a8d8a7d98b20d985d8a720d8aad988d984d8af20d985d98620d8b1d8a4d98ad8a920d981d8b1d8afd98ad8a920d988d8aad8add8aad8b6d986d987d8a720d8a5d8b1d8a7d8afd8a920d8abd8a7d8a8d8aad8a9d88c20d8aad8b3d987d98520d8a8d8b4d983d98420d983d8a8d98ad8b120d981d98a20d986d8b3d98ad8ac20d8a7d984d8a7d982d8aad8b5d8a7d8af20d981d98a20d8a7d984d985d8acd8aad985d8b9d8a7d8aa20d8add988d98420d8a7d984d8b9d8a7d984d9852e20d988d985d8b920d8b0d984d983d88c20d8aad983d985d98620d988d8b1d8a7d8a120d8a8d8afd8a7d98ad8a7d8aad987d8a720d8a7d984d985d8aad988d8a7d8b6d8b9d8a920d988d8add8acd985d987d8a720d8a7d984d985d8aad988d8a7d8b6d8b9d88c20d8a5d985d983d8a7d986d98ad8a920d8b9d985d98ad982d8a920d984d984d986d985d98820d988d8a7d984d8aad8b7d988d8b120d988d8a7d984d8aad8a3d8abd98ad8b12e3c2f703e0d0a3c703ed8b1d8add984d8a920d8a7d984d8b9d985d98420d8a7d984d8b5d8bad98ad8b1d8a920d8b4d8a8d98ad987d8a920d8a8d8aad8b1d8a8d98ad8a920d8b4d8aad984d8a920d8add8aad98920d8aad986d985d98820d8a5d984d98920d8b4d8acd8b1d8a920d8b9d8b8d98ad985d8a92e20d8a5d986d987d8a720d8aad8aad8b7d984d8a820d8b9d986d8a7d98ad8a920d8afd982d98ad982d8a920d988d8aad8aed8b7d98ad8b720d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98a20d988d8a7d8b3d8aad8b9d8afd8a7d8af20d984d984d8aad983d98ad98120d985d8b920d8a7d984d8a8d98ad8a6d8a7d8aa20d8a7d984d985d8aad8bad98ad8b1d8a920d8a8d8a7d8b3d8aad985d8b1d8a7d8b12e20d985d8a720d98ad985d98ad8b220d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d8b5d8bad98ad8b1d8a920d8a7d984d986d8a7d8acd8add8a920d984d98ad8b320d981d982d8b720d982d8afd8b1d8aad987d8a720d8b9d984d98920d8a7d984d8a8d982d8a7d8a120d988d8a5d986d985d8a720d985d8b7d8a7d8b1d8afd8aad987d8a720d984d984d986d985d98820d8a8d8acd985d98ad8b920d8acd988d8a7d986d8a8d9872e3c2f703e0d0a3c68333ed8a8d8b2d8b1d8b920d8a7d984d8b1d8a4d98ad8a920d988d8a7d984d8b4d8bad9813c2f68333e0d0a3c703ed981d98a20d982d984d8a820d983d98420d8b4d8b1d983d8a920d8b5d8bad98ad8b1d8a920d8b4d8aed8b520d8b1d8a4d988d98a20d8a3d98820d985d8acd985d988d8b9d8a920d985d98620d8a7d984d8a3d981d8b1d8a7d8af20d8b0d988d98a20d8a7d984d8b1d8a4d98ad8a920d8a7d984d985d8b4d8aad8b1d983d8a920d8a7d984d8b0d98ad98620d98ad8aad8add8b1d983d988d98620d8a8d8a7d984d8b4d8bad98120d988d8a7d984d8bad8b1d8b62e20d987d8b0d98720d8a7d984d8b1d8a4d98ad8a920d8aad983d988d98620d983d8a7d984d986d8acd98520d8a7d984d985d988d8acd991d990d987d88c20d8aad8b6d98ad8a120d8a7d984d8b7d8b1d98ad98220d8a5d984d98920d8a7d984d8a3d985d8a7d98520d985d98620d8aed984d8a7d98420d985d98ad8a7d98720d8a7d984d8b4d98320d988d8a7d984d8bad985d988d8b62e20d8a5d986d98720d987d8b0d8a720d8a7d984d988d8b6d988d8ad20d981d98a20d8a7d984d8bad8b1d8b620d8a7d984d8b0d98a20d98ad8bad8b0d98a20d8a7d984d8b4d8b1d8a7d8b1d8a920d8a7d984d8a3d988d984d98920d988d98ad8b4d8b9d98420d984d987d8a820d8b1d988d8ad20d8a7d984d8b1d988d8a7d8af2e3c2f703e0d0a3c68333ed8b2d8b1d8a7d8b9d8a920d8a8d8b0d988d8b120d8a7d984d8a7d8a8d8aad983d8a7d8b13c2f68333e0d0a3c703ed8a7d984d8a7d8a8d8aad983d8a7d8b120d987d98820d8a7d984d8b9d986d8b5d8b120d8a7d984d8a3d8b3d8a7d8b3d98a20d981d98a20d8a7d984d986d985d98820d8a7d984d985d8b3d8aad8afd8a7d9852e20d98ad8acd8a820d8b9d984d98920d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d8b5d8bad98ad8b1d8a920d8a7d984d8a7d8a8d8aad983d8a7d8b120d8a8d8a7d8b3d8aad985d8b1d8a7d8b120d984d984d8a8d982d8a7d8a120d985d8aad985d98ad8b2d8a920d981d98a20d8a7d984d8a3d8b3d988d8a7d98220d8a7d984d8afd98ad986d8a7d985d98ad983d98ad8a92e20d8b3d988d8a7d8a120d983d8a7d98620d8b0d984d98320d8a8d8a7d8b9d8aad986d8a7d98220d8a7d984d8aad982d986d98ad8a7d8aa20d8a7d984d8add8afd98ad8abd8a9d88c20d8a3d98820d8a5d8b9d8a7d8afd8a920d8aad8b5d988d98ad8b120d8a7d984d985d985d8a7d8b1d8b3d8a7d8aa20d8a7d984d8aad982d984d98ad8afd98ad8a9d88c20d8a3d98820d8b1d8b3d98520d8a7d984d8add984d988d98420d8a7d984d8acd8afd98ad8afd8a920d984d985d8b4d8a7d983d98420d982d8afd98ad985d8a9d88c20d981d8a5d98620d8a7d984d8a7d8a8d8aad983d8a7d8b120d98ad8b9d985d98420d983d985d8add981d8b220d984d984d8aad988d8b3d8b920d988d8a7d984d8aad985d98ad8b22e3c2f703e0d0a3c68333ed8a7d984d8aad8b9d8a7d985d98420d985d8b920d8a7d984d8aad8add8afd98ad8a7d8aa20d8a8d8a7d984d985d8b1d988d986d8a93c2f68333e0d0a3c703ed8a7d984d8b7d8b1d98ad98220d8a5d984d98920d8a7d984d986d985d98820d986d8a7d8afd8b1d8a7d98b20d985d8a720d98ad983d988d98620d8b3d984d8b3d8a7d98bd88c20d8a8d98420d98ad8add985d98420d8aad8add8afd98ad8a7d8aa20d988d8b9d8b1d8a7d982d98ad98420d981d98a20d983d98420d985d983d8a7d9862e20d8a7d984d8a7d986d983d985d8a7d8b420d8a7d984d8a7d982d8aad8b5d8a7d8afd98ad88c20d988d8a7d984d985d986d8a7d981d8b3d8a920d8a7d984d8b4d8b1d8b3d8a9d88c20d988d8a7d984d8b9d982d8a8d8a7d8aa20d8a7d984d8aad986d8b8d98ad985d98ad8a9202d20d987d8b0d98720d8a8d8b9d8b620d985d98620d8a7d984d8aed8b5d988d98520d8a7d984d982d988d98ad991d8a920d8a7d984d8aad98a20d8aad988d8a7d8acd987d987d8a720d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d8b5d8bad98ad8b1d8a920d8aed984d8a7d98420d8b1d8add984d8aad987d8a72e20d988d985d8b920d8b0d984d983d88c20d981d985d98620d8aed984d8a7d98420d987d8b0d98720d8a7d984d8a3d988d982d8a7d8aa20d8a7d984d8b9d8b5d98ad8a8d8a920d98ad8aad8a3d984d98220d8a7d984d8b5d985d988d8af2e20d98ad8acd8a820d8b9d984d98920d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d8b5d8bad98ad8b1d8a920d8a7d984d8aad8bad984d8a820d8b9d984d98920d8a7d984d8b9d988d8a7d982d8a820d8a8d8add8b2d985d88c20d988d8a7d984d8aad8b9d984d98520d985d98620d8a7d984d8a7d986d8aad983d8a7d8b3d8a7d8aad88c20d988d8a7d984d8b8d987d988d8b120d8a8d982d988d8a920d988d8add983d985d8a92e3c2f703e0d0a3c68333ed8aad8b9d8b2d98ad8b220d8a7d984d8b9d984d8a7d982d8a7d8aa20d988d8a7d984d985d8acd8aad985d8b93c2f68333e0d0a3c703ed984d8a720d8aad988d8acd8af20d8a3d8b9d985d8a7d98420d8aad8b9d985d98420d8b9d984d98920d8a7d986d981d8b1d8a7d8af2e20d8a5d98620d8a8d986d8a7d8a120d8b9d984d8a7d982d8a7d8aa20d982d988d98ad8a920d985d8b920d8a7d984d8b9d985d984d8a7d8a120d988d8a7d984d985d988d8b1d8afd98ad98620d988d8a7d984d985d8acd8aad985d8b920d8a8d8b4d983d98420d8b9d8a7d98520d8a3d985d8b120d8a8d8a7d984d8ba20d8a7d984d8a3d987d985d98ad8a920d984d984d986d985d98820d8a7d984d985d8b3d8aad8afd8a7d9852e20d8aad984d98320d8a7d984d8b9d984d8a7d982d8a7d8aa20d984d98ad8b3d8aa20d981d982d8b720d8aad8b9d8b2d8b220d8a7d984d988d984d8a7d8a120d988d8a7d984d8abd982d8a9d88c20d8a8d98420d8aad983d988d98620d8a3d98ad8b6d8a7d98b20d985d8b5d8afd8b1d8a7d98b20d984d984d8aad8bad8b0d98ad8a920d8a7d984d8b1d8a7d8acd8b9d8a920d8a7d984d982d98ad985d8a920d988d8a7d984d8afd8b9d9852e20d981d98a20d8b9d8a7d984d98520d985d984d98ad8a120d8a8d8a7d984d8aed98ad8a7d8b1d8a7d8aad88c20d8a5d986d985d8a720d987d98820d8a7d984d984d985d8b3d8a920d8a7d984d8a5d986d8b3d8a7d986d98ad8a920d988d8a7d984d8aad8acd8a7d8b1d8a820d8a7d984d985d8aed8b5d8b5d8a920d8a7d984d8aad98a20d8aad985d98ad8b220d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d8b5d8bad98ad8b1d8a92e3c2f703e0d0a3c68333ed8a7d984d8aad988d8b3d8b920d8a8d8b4d983d98420d985d8b3d8a4d988d98420d988d985d8b3d8aad8afd8a7d9853c2f68333e0d0a3c703ed985d8b920d8a7d983d8aad8b3d8a7d8a820d8a7d984d8b2d8aed985d88c20d982d8af20d8aad983d988d98620d8a5d8bad8b1d8a7d8a1d8a7d8aa20d8a7d984d8aad988d8b3d8b920d8a8d8b3d8b1d8b9d8a920d985d8bad8b1d98ad8a92e20d988d985d8b920d8b0d984d983d88c20d98ad8acd8a820d8a7d984d8aad8b9d8a7d985d98420d985d8b920d8a7d984d986d985d98820d8a8d8add8b0d8b120d988d8aad8a8d8b5d8b12e20d8a7d984d8aad988d8b3d8b920d8a8d8b3d8b1d8b9d8a920d8afd988d98620d985d988d8a7d8b1d8af20d8a3d98820d987d98ad983d98420d8aad8add8aad98ad8a920d983d8a7d981d98ad8a920d98ad985d983d98620d8a3d98620d98ad8a4d8afd98a20d8a5d984d98920d8b9d8afd98520d8a7d984d983d981d8a7d8a1d8a920d8a7d984d8aad8b4d8bad98ad984d98ad8a920d988d8aad8b6d98ad98ad8b920d8a7d984d8acd988d8afd8a92e20d98ad8aad8b7d984d8a820d8a7d984d986d985d98820d8a7d984d985d8b3d8aad8afd8a7d98520d8a5d98ad8acd8a7d8af20d8aad988d8a7d8b2d98620d8add8b3d8a7d8b320d8a8d98ad98620d8a7d984d8b7d985d988d8ad20d988d8a7d984d8add8b0d8b1d88c20d988d8a7d984d8aad988d8b3d8b920d8a8d988d8aad98ad8b1d8a920d8aad8b63c2f703e, NULL, NULL, '2024-05-07 23:15:49', '2024-05-07 23:15:49');

-- --------------------------------------------------------

--
-- Table structure for table `blog_sections`
--

CREATE TABLE `blog_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `button_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blog_sections`
--

INSERT INTO `blog_sections` (`id`, `language_id`, `button_text`, `title`, `created_at`, `updated_at`) VALUES
(5, 20, 'Mores', 'Read our latest blogs', '2023-08-19 00:44:01', '2023-12-13 21:29:05'),
(6, 21, 'المدونات', 'اقرأ أحدث مدوناتنا', '2023-08-28 03:06:59', '2023-08-28 03:06:59');

-- --------------------------------------------------------

--
-- Table structure for table `business_hours`
--

CREATE TABLE `business_hours` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `day` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holiday` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `business_hours`
--

INSERT INTO `business_hours` (`id`, `listing_id`, `day`, `start_time`, `end_time`, `holiday`, `created_at`, `updated_at`) VALUES
(1, 1, 'Saturday', '08:00 AM', '07:00 PM', 1, '2024-05-01 21:11:40', '2024-05-01 21:19:39'),
(2, 1, 'Sunday', '08:00 AM', '07:00 PM', 1, '2024-05-01 21:11:40', '2024-05-01 21:20:04'),
(3, 1, 'Monday', '08:00 AM', '07:00 PM', 1, '2024-05-01 21:11:40', '2024-05-01 21:20:04'),
(4, 1, 'Tuesday', '08:00 AM', '07:00 PM', 1, '2024-05-01 21:11:40', '2024-05-01 21:20:04'),
(5, 1, 'Wednesday', NULL, NULL, 0, '2024-05-01 21:11:40', '2024-05-01 21:20:04'),
(6, 1, 'Thursday', '08:00 AM', '07:00 PM', 1, '2024-05-01 21:11:40', '2024-05-01 21:20:04'),
(7, 1, 'Friday', '08:00 AM', '07:00 PM', 1, '2024-05-01 21:11:40', '2024-05-01 21:20:04'),
(15, 3, 'Saturday', '10:00 AM', '07:00 PM', 1, '2024-05-01 23:18:29', '2024-05-01 23:18:29'),
(16, 3, 'Sunday', '10:00 AM', '07:00 PM', 1, '2024-05-01 23:18:29', '2024-05-01 23:18:29'),
(17, 3, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-05-01 23:18:29', '2024-05-01 23:18:29'),
(18, 3, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-01 23:18:29', '2024-05-01 23:18:29'),
(19, 3, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-01 23:18:29', '2024-05-01 23:18:29'),
(20, 3, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-05-01 23:18:29', '2024-05-01 23:18:29'),
(21, 3, 'Friday', NULL, NULL, 0, '2024-05-01 23:18:29', '2024-05-01 23:24:37'),
(22, 4, 'Saturday', '10:00 AM', '07:00 PM', 1, '2024-05-02 02:33:34', '2024-05-02 02:33:34'),
(23, 4, 'Sunday', '10:00 AM', '07:00 PM', 1, '2024-05-02 02:33:34', '2024-05-02 02:33:34'),
(24, 4, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-05-02 02:33:34', '2024-05-02 02:33:34'),
(25, 4, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-02 02:33:34', '2024-05-02 02:33:34'),
(26, 4, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-02 02:33:34', '2024-05-02 02:33:34'),
(27, 4, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-05-02 02:33:34', '2024-05-02 02:33:34'),
(28, 4, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-02 02:33:34', '2024-05-02 02:33:34'),
(29, 5, 'Saturday', NULL, NULL, 0, '2024-05-05 20:59:20', '2024-05-08 04:04:10'),
(30, 5, 'Sunday', '10:00 AM', '07:00 PM', 1, '2024-05-05 20:59:20', '2024-05-05 20:59:20'),
(31, 5, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-05-05 20:59:20', '2024-05-05 20:59:20'),
(32, 5, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-05 20:59:20', '2024-05-05 20:59:20'),
(33, 5, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-05 20:59:20', '2024-05-05 20:59:20'),
(34, 5, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-05-05 20:59:20', '2024-05-05 20:59:20'),
(35, 5, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-05 20:59:20', '2024-05-05 20:59:20'),
(36, 6, 'Saturday', '10:00 AM', '07:00 PM', 1, '2024-05-05 21:47:53', '2024-05-05 21:47:53'),
(37, 6, 'Sunday', '10:00 AM', '07:00 PM', 1, '2024-05-05 21:47:53', '2024-05-05 21:47:53'),
(38, 6, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-05-05 21:47:53', '2024-05-05 21:47:53'),
(39, 6, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-05 21:47:53', '2024-05-05 21:47:53'),
(40, 6, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-05 21:47:53', '2024-05-05 21:47:53'),
(41, 6, 'Thursday', NULL, NULL, 0, '2024-05-05 21:47:53', '2024-05-08 04:04:26'),
(42, 6, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-05 21:47:53', '2024-05-05 21:47:53'),
(43, 7, 'Saturday', NULL, NULL, 0, '2024-05-05 23:06:52', '2024-05-08 04:04:53'),
(44, 7, 'Sunday', NULL, NULL, 0, '2024-05-05 23:06:52', '2024-05-08 04:04:59'),
(45, 7, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-05-05 23:06:52', '2024-05-05 23:06:52'),
(46, 7, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-05 23:06:52', '2024-05-05 23:06:52'),
(47, 7, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-05 23:06:52', '2024-05-05 23:06:52'),
(48, 7, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-05-05 23:06:52', '2024-05-05 23:06:52'),
(49, 7, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-05 23:06:52', '2024-05-05 23:06:52'),
(57, 9, 'Saturday', '10:00 AM', '07:00 PM', 1, '2024-05-06 20:37:36', '2024-05-06 20:37:36'),
(58, 9, 'Sunday', NULL, NULL, 0, '2024-05-06 20:37:36', '2024-05-08 04:05:24'),
(59, 9, 'Monday', NULL, NULL, 0, '2024-05-06 20:37:36', '2024-05-08 04:05:24'),
(60, 9, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-06 20:37:36', '2024-05-06 20:37:36'),
(61, 9, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-06 20:37:36', '2024-05-06 20:37:36'),
(62, 9, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-05-06 20:37:36', '2024-05-06 20:37:36'),
(63, 9, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-06 20:37:36', '2024-05-06 20:37:36'),
(64, 10, 'Saturday', '10:00 AM', '07:00 PM', 1, '2024-05-06 21:22:20', '2024-05-06 21:22:20'),
(65, 10, 'Sunday', '10:00 AM', '07:00 PM', 1, '2024-05-06 21:22:20', '2024-05-06 21:22:20'),
(66, 10, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-05-06 21:22:20', '2024-05-06 21:22:20'),
(67, 10, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-06 21:22:20', '2024-05-06 21:22:20'),
(68, 10, 'Wednesday', NULL, NULL, 0, '2024-05-06 21:22:20', '2024-05-08 04:05:35'),
(69, 10, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-05-06 21:22:20', '2024-05-06 21:22:20'),
(70, 10, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-06 21:22:20', '2024-05-06 21:22:20'),
(71, 11, 'Saturday', NULL, NULL, 0, '2024-05-06 22:34:31', '2024-05-08 04:05:46'),
(72, 11, 'Sunday', '10:00 AM', '07:00 PM', 1, '2024-05-06 22:34:31', '2024-05-06 22:34:31'),
(73, 11, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-05-06 22:34:31', '2024-05-06 22:34:31'),
(74, 11, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-06 22:34:31', '2024-05-06 22:34:31'),
(75, 11, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-06 22:34:31', '2024-05-06 22:34:31'),
(76, 11, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-05-06 22:34:31', '2024-05-06 22:34:31'),
(77, 11, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-06 22:34:31', '2024-05-06 22:34:31'),
(78, 12, 'Saturday', '10:00 AM', '07:00 PM', 1, '2024-05-07 00:07:13', '2024-05-07 00:07:13'),
(79, 12, 'Sunday', '10:00 AM', '07:00 PM', 1, '2024-05-07 00:07:13', '2024-05-07 00:07:13'),
(80, 12, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-05-07 00:07:13', '2024-05-07 00:07:13'),
(81, 12, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-07 00:07:13', '2024-05-07 00:07:13'),
(82, 12, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-07 00:07:13', '2024-05-07 00:07:13'),
(83, 12, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-05-07 00:07:13', '2024-05-07 00:07:13'),
(84, 12, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-07 00:07:13', '2024-05-07 00:07:13'),
(85, 13, 'Saturday', NULL, NULL, 0, '2024-05-07 02:40:46', '2024-05-08 04:06:06'),
(86, 13, 'Sunday', NULL, NULL, 0, '2024-05-07 02:40:46', '2024-05-08 04:06:06'),
(87, 13, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-05-07 02:40:46', '2024-05-07 02:40:46'),
(88, 13, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-07 02:40:46', '2024-05-07 02:40:46'),
(89, 13, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-07 02:40:46', '2024-05-07 02:40:46'),
(90, 13, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-05-07 02:40:46', '2024-05-07 02:40:46'),
(91, 13, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-07 02:40:46', '2024-05-07 02:40:46'),
(92, 14, 'Saturday', '10:00 AM', '07:00 PM', 1, '2024-05-07 20:48:37', '2024-05-07 20:48:37'),
(93, 14, 'Sunday', '10:00 AM', '07:00 PM', 1, '2024-05-07 20:48:37', '2024-05-07 20:48:37'),
(94, 14, 'Monday', NULL, NULL, 0, '2024-05-07 20:48:37', '2024-05-08 04:06:22'),
(95, 14, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-05-07 20:48:37', '2024-05-07 20:48:37'),
(96, 14, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-05-07 20:48:37', '2024-05-07 20:48:37'),
(97, 14, 'Thursday', NULL, NULL, 0, '2024-05-07 20:48:37', '2024-05-08 04:06:22'),
(98, 14, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-05-07 20:48:37', '2024-05-07 20:48:37'),
(99, 15, 'Saturday', '06:06', '07:00', 1, '2024-05-08 02:46:04', '2024-10-27 20:28:30'),
(100, 15, 'Sunday', '10:00', '07:00', 1, '2024-05-08 02:46:04', '2024-10-27 20:28:30'),
(101, 15, 'Monday', '10:00', '07:00', 1, '2024-05-08 02:46:04', '2024-10-27 20:28:30'),
(102, 15, 'Tuesday', '10:00', '07:00', 1, '2024-05-08 02:46:04', '2024-10-27 20:28:30'),
(103, 15, 'Wednesday', '10:00', '07:00', 1, '2024-05-08 02:46:04', '2024-10-27 20:28:30'),
(104, 15, 'Thursday', '10:00', '07:00', 1, '2024-05-08 02:46:04', '2024-10-27 20:28:30'),
(105, 15, 'Friday', '10:00', '07:00', 1, '2024-05-08 02:46:04', '2024-10-27 20:28:30'),
(113, 17, 'Saturday', '10:00 AM', '07:00 PM', 1, '2025-10-29 04:38:48', '2025-10-29 04:38:48'),
(114, 17, 'Sunday', '10:00 AM', '07:00 PM', 1, '2025-10-29 04:38:48', '2025-10-29 04:38:48'),
(115, 17, 'Monday', '10:00 AM', '07:00 PM', 1, '2025-10-29 04:38:48', '2025-10-29 04:38:48'),
(116, 17, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2025-10-29 04:38:48', '2025-10-29 04:38:48'),
(117, 17, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2025-10-29 04:38:48', '2025-10-29 04:38:48'),
(118, 17, 'Thursday', '10:00 AM', '07:00 PM', 1, '2025-10-29 04:38:48', '2025-10-29 04:38:48'),
(119, 17, 'Friday', '10:00 AM', '07:00 PM', 1, '2025-10-29 04:38:48', '2025-10-29 04:38:48'),
(120, 18, 'Saturday', '10:00 AM', '07:00 PM', 1, '2025-11-03 06:24:56', '2025-11-03 06:24:56'),
(121, 18, 'Sunday', '10:00 AM', '07:00 PM', 1, '2025-11-03 06:24:56', '2025-11-03 06:24:56'),
(122, 18, 'Monday', '10:00 AM', '07:00 PM', 1, '2025-11-03 06:24:56', '2025-11-03 06:24:56'),
(123, 18, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2025-11-03 06:24:56', '2025-11-03 06:24:56'),
(124, 18, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2025-11-03 06:24:56', '2025-11-03 06:24:56'),
(125, 18, 'Thursday', '10:00 AM', '07:00 PM', 1, '2025-11-03 06:24:56', '2025-11-03 06:24:56'),
(126, 18, 'Friday', '10:00 AM', '07:00 PM', 1, '2025-11-03 06:24:56', '2025-11-03 06:24:56');

-- --------------------------------------------------------

--
-- Table structure for table `call_to_action_sections`
--

CREATE TABLE `call_to_action_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `video_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `call_to_action_sections`
--

INSERT INTO `call_to_action_sections` (`id`, `language_id`, `subtitle`, `title`, `text`, `video_url`, `button_name`, `button_url`, `created_at`, `updated_at`) VALUES
(4, 20, 'pe earum totam minima aperiam repellendus possimus molestias optio sapiente, quam               repudiandae voluptatum accusantium.', 'Find Your Favorite Traveling Place', 'We highly recommend Carlist. We\'ve used them several times and have always been impressed with their excellent and awesome service.', NULL, 'Register Now', 'https://www.youtube.com/', '2023-08-28 02:47:29', '2024-05-09 02:03:42'),
(5, 21, 'هل تريد أن تكون بائعًا لقائمة السيارات؟', 'ابحث عن مكان السفر المفضل لديك', 'ونحن نوصي بشدة كارليست. لقد استخدمناها عدة مرات وقد أعجبنا دائمًا بخدمتهم الممتازة والرائعة.', NULL, 'سجل الان', 'https://codecanyon8.kreativdev.com/carlist/vendor/signup', '2023-08-28 02:52:05', '2024-05-06 03:17:01');

-- --------------------------------------------------------

--
-- Table structure for table `category_sections`
--

CREATE TABLE `category_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `category_sections`
--

INSERT INTO `category_sections` (`id`, `language_id`, `title`, `subtitle`, `text`, `button_text`, `created_at`, `updated_at`) VALUES
(1, '8', 'Popular Car Categories', NULL, '', 'View All', '2023-01-19 05:15:30', '2023-08-12 23:44:50'),
(2, '9', 'فئات السيارات الشعبية', 'تصفح حسب فئات السيارات الأكثر شهرة', 'إذا كنت في السوق لشراء سيارة جديدة ، فمن المحتمل أنك أجريت حصتك العادلة من البحث حول خدمات السيارات.', NULL, '2023-01-19 05:16:21', '2023-01-19 05:16:21'),
(3, '20', 'Most Popular Categories', 'Sed ut perspiciatis unde omnis iste nat um doloremque laudantium.', '', 'All Categories', '2023-08-19 00:11:48', '2024-05-09 02:13:32'),
(4, '21', 'اكتشف الفئات الشائعة', 'اكتشف الفئات الشائعةاكتشف الفئات الشائعةاكتشف الفئات الشائعةاكتشف الفئات الشائعةاكتشف الفئات الشائعة', '', 'عرض الكل', '2023-08-28 02:54:03', '2023-12-13 04:26:02');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `country_id` bigint DEFAULT NULL,
  `feature_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `language_id`, `country_id`, `feature_image`, `state_id`, `name`, `created_at`, `updated_at`, `slug`) VALUES
(1, 20, 2, '1714619111.png', 1, 'Melbourne', '2024-05-01 21:05:11', '2024-10-14 22:00:32', 'melbourne'),
(2, 21, 3, '66330314045e9.jpg', 2, 'ملبورن', '2024-05-01 21:05:41', '2024-10-14 22:00:57', 'ملبورن'),
(3, 20, 4, '1714624599.png', 3, 'Anantapuram', '2024-05-01 22:36:39', '2024-10-14 22:01:39', 'anantapuram'),
(4, 21, 5, '1714624623.png', 4, 'أنانتابور', '2024-05-01 22:37:03', '2024-10-14 22:00:54', 'أنانتابور'),
(5, 20, 6, '663b4310a25d4.jpg', NULL, 'Cox\'s Bazar', '2024-05-02 02:27:07', '2024-10-14 22:00:29', 'cox\'s-bazar'),
(6, 21, 7, '663b431a4fa77.jpg', NULL, 'كوكس بازار', '2024-05-02 02:27:44', '2024-05-08 03:17:14', 'كوكس بازار'),
(7, 20, 8, '663845c341299.jpg', NULL, 'Skardu', '2024-05-05 20:51:12', '2024-10-14 22:01:16', 'skardu'),
(8, 21, 9, '1714963933.png', NULL, 'سكاردو', '2024-05-05 20:52:13', '2024-10-14 22:00:51', 'سكاردو'),
(9, 20, 10, '1714966820.png', 5, 'Los Angeles', '2024-05-05 21:40:20', '2024-10-14 22:00:25', 'los-angeles'),
(10, 21, 11, '1714966853.png', 6, 'لوس أنجلوس', '2024-05-05 21:40:53', '2024-10-14 22:00:48', 'لوس-أنجلوس'),
(11, 20, 10, '1714971495.png', 7, 'Jacksonville', '2024-05-05 22:58:15', '2024-10-14 22:00:22', 'jacksonville'),
(12, 21, 11, '1714971519.png', 8, 'جاكسونفيل', '2024-05-05 22:58:39', '2024-10-14 22:00:46', 'جاكسونفيل'),
(13, 20, 6, '663b42f87da7c.jpg', NULL, 'Dhaka', '2024-05-06 02:29:30', '2024-10-14 22:00:07', 'dhaka'),
(14, 21, 7, '663b4302a138a.jpg', NULL, 'دكا', '2024-05-06 02:30:01', '2024-10-14 22:00:43', 'دكا'),
(15, 20, 10, '670e07914c51e.jpg', 5, 'San Diego', '2024-05-06 21:15:50', '2024-10-15 00:11:29', 'san-diego'),
(16, 21, 11, '672edbc5d0826.jpg', 6, 'سان دييغو', '2024-05-06 21:16:26', '2024-11-08 21:49:25', 'سان-دييغو');

-- --------------------------------------------------------

--
-- Table structure for table `claim_listings`
--

CREATE TABLE `claim_listings` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint UNSIGNED DEFAULT NULL,
  `language_id` bigint UNSIGNED DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `redemption_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `raw_redemption_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redemption_expires_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `information` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `claim_listings`
--

INSERT INTO `claim_listings` (`id`, `listing_id`, `user_id`, `vendor_id`, `language_id`, `status`, `redemption_token`, `raw_redemption_token`, `redemption_expires_at`, `approved_at`, `customer_name`, `customer_email`, `customer_phone`, `information`, `created_at`, `updated_at`) VALUES
(11, 17, 2, NULL, 20, 'approved', 'ecc6db5883cdb75b6aca489cd6d444cfb77f3d78f2260d3fbe3f05e5a980fa02', '7ddf4487-0639-4fcd-8735-12c30fd7b1be', '2026-11-02 06:11:09', '2025-11-03 06:11:09', 'Mercedes Ellison', 'mitefa@mailinator.com', '+1 (982) 597-9874', '{\"phone\":{\"value\":\"+1 (982) 597-9874\",\"type\":1},\"content\":{\"value\":\"Vel autem eu commodo\",\"type\":5},\"date\":{\"value\":\"2002-05-18\",\"type\":6},\"time\":{\"value\":\"10:19\",\"type\":7},\"zip_file\":{\"originalName\":\"list_s1 (1).zip\",\"value\":\"69089b8b54307.zip\",\"type\":8}}', '2025-11-03 06:09:47', '2025-11-03 06:11:09'),
(12, 18, 12, NULL, 20, 'pending', NULL, NULL, NULL, NULL, 'saiful islam', NULL, '0187233075', '{\"phone\":{\"value\":\"0187233075\",\"type\":1},\"date\":{\"value\":\"2024-02-25\",\"type\":6},\"time\":{\"value\":\"10:25\",\"type\":7},\"zip_file\":{\"originalName\":\"chart-line.zip\",\"value\":\"6925528610b16.zip\",\"type\":8}}', '2025-11-25 00:53:58', '2025-11-25 00:53:58');

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int DEFAULT NULL,
  `type` tinyint DEFAULT NULL COMMENT '1=user, 2=admin, 3=vendor',
  `support_ticket_id` int DEFAULT NULL,
  `reply` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`id`, `user_id`, `type`, `support_ticket_id`, `reply`, `file`, `created_at`, `updated_at`) VALUES
(9, 204, 3, 5, '<p>test</p>', '69d4af3185ea6.zip', '2026-04-07 01:16:01', '2026-04-07 01:16:01'),
(10, 204, 3, 5, '<p>test</p>', '69d4af519c21b.zip', '2026-04-07 01:16:33', '2026-04-07 01:16:33'),
(11, 204, 3, 5, 'test', '69d4b24352d38.zip', '2026-04-07 01:29:07', '2026-04-07 01:29:07'),
(12, 1, 2, 8, '<p>fdfdfdf</p>', '6a033533527d0.zip', '2026-05-12 08:12:03', '2026-05-12 08:12:03');

-- --------------------------------------------------------

--
-- Table structure for table `cookie_alerts`
--

CREATE TABLE `cookie_alerts` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `cookie_alert_status` tinyint UNSIGNED NOT NULL,
  `cookie_alert_btn_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cookie_alert_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `cookie_alerts`
--

INSERT INTO `cookie_alerts` (`id`, `language_id`, `cookie_alert_status`, `cookie_alert_btn_text`, `cookie_alert_text`, `created_at`, `updated_at`) VALUES
(3, 20, 1, 'I Agree', 'We use cookies to give you the best online experience.\r\nBy continuing to browse the site you are agreeing to our use of cookies.', '2023-08-29 02:35:44', '2025-11-03 23:36:12'),
(4, 21, 0, 'أنا موافق', 'نحن نستخدم ملفات تعريف الارتباط لنمنحك أفضل تجربة عبر الإنترنت. من خلال الاستمرار في تصفح الموقع فإنك توافق على استخدامنا لملفات تعريف الارتباط.', '2023-08-29 02:36:53', '2024-02-07 01:00:30');

-- --------------------------------------------------------

--
-- Table structure for table `counter_informations`
--

CREATE TABLE `counter_informations` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `amount` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `counter_informations`
--

INSERT INTO `counter_informations` (`id`, `language_id`, `icon`, `amount`, `title`, `created_at`, `updated_at`) VALUES
(10, 20, 'fas fa-trophy', 500, 'Awards Winning', '2023-08-19 00:41:52', '2024-05-06 03:11:10'),
(15, 20, 'fas fa-users', 299, 'Happy Users', '2023-11-13 02:40:35', '2024-05-06 03:12:06'),
(16, 20, 'fas fa-landmark', 199, 'Active Members', '2023-11-17 20:49:46', '2024-05-06 03:13:12'),
(17, 20, 'far fa-list-alt', 499, 'Total Listing', '2024-05-06 03:10:15', '2024-05-06 03:10:15'),
(18, 21, 'fas fa-trophy', 500, 'الفوز بالجوائز', '2023-08-19 00:41:52', '2024-05-06 03:15:10'),
(19, 21, 'fas fa-users', 299, 'المستخدمين السعداء', '2023-11-13 02:40:35', '2024-05-06 03:14:54'),
(20, 21, 'fas fa-landmark', 199, 'الأعضاء النشطين', '2023-11-17 20:49:46', '2024-05-06 03:14:40'),
(21, 21, 'far fa-list-alt', 499, 'القائمة الإجمالية', '2024-05-06 03:10:15', '2024-05-06 03:14:24');

-- --------------------------------------------------------

--
-- Table structure for table `counter_sections`
--

CREATE TABLE `counter_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `subtitle` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `counter_sections`
--

INSERT INTO `counter_sections` (`id`, `language_id`, `title`, `subtitle`, `created_at`, `updated_at`) VALUES
(3, 20, 'See Our Achievements', NULL, '2023-08-19 00:38:24', '2024-05-06 03:08:01'),
(4, 21, 'لماذا اخترت خدمات قائمة السيارات لدينا؟', 'إذا كنت في السوق لشراء سيارة جديدة ، فمن المحتمل أنك أجريت نصيبك العادل من البحث في خدمات السيارات. أنت تعرف نوع السيارة التي تريدها ، وما الميزات التي تحتاجها؟ نحن هنا لمساعدتك في أي وقت.', '2023-08-19 03:44:15', '2023-08-19 03:44:15');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `language_id`, `name`, `created_at`, `updated_at`) VALUES
(2, 20, 'Australia', '2024-05-01 21:01:14', '2024-05-01 21:01:14'),
(3, 21, 'أستراليا', '2024-05-01 21:01:40', '2024-05-07 23:28:36'),
(4, 20, 'India', '2024-05-01 22:32:15', '2024-05-01 22:32:15'),
(5, 21, 'الهند', '2024-05-01 22:33:22', '2024-05-07 23:28:32'),
(6, 20, 'Bangladesh', '2024-05-02 02:25:08', '2024-05-02 02:25:08'),
(7, 21, 'بنغلاديش', '2024-05-02 02:25:34', '2024-05-07 23:28:27'),
(8, 20, 'Pakistan', '2024-05-05 20:46:21', '2024-05-05 20:46:21'),
(9, 21, 'باكستان', '2024-05-05 20:46:54', '2024-05-07 23:28:22'),
(10, 20, 'United States', '2024-05-05 21:35:22', '2024-05-05 21:35:22'),
(11, 21, 'الولايات المتحدة', '2024-05-05 21:35:51', '2024-05-07 23:28:15');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `answer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `language_id`, `question`, `answer`, `serial_number`, `created_at`, `updated_at`) VALUES
(16, 20, 'What is Bulistio app?', 'To list your car, simply create an account on our website, provide accurate vehicle information, upload high-quality photos, and set an appropriate price.', 1, '2023-08-19 02:29:36', '2023-10-21 03:10:34'),
(17, 20, 'How to Purchase this App ?', 'Yes, you can list multiple cars using a single account. Just follow the same listing process for each vehicle.', 2, '2023-08-19 02:29:51', '2023-10-21 03:11:50'),
(18, 20, 'How do I Make a Premium User?', 'We offer both free and premium listing options. Basic listings are free, while premium options may include enhanced visibility and additional features for a fee.', 3, '2023-08-19 02:30:06', '2023-10-21 03:12:08'),
(19, 20, 'How to Debug this App?', 'It\'s important to provide detailed information such as the make, model, year, mileage, condition, features, and any history of accidents or repairs. The more details you provide, the better your chances of attracting potential buyers.', 4, '2023-08-19 02:30:22', '2023-10-21 03:12:25'),
(20, 20, 'Can I make an Appointment?', 'The duration of your car listing depends on the type of listing you choose. Free listings usually have a standard duration, while premium listings may have extended visibility periods.', 5, '2023-08-19 02:30:37', '2023-10-21 03:12:38'),
(21, 20, 'What\'s the Business Policies?', 'Yes, you can edit your listing at any time. Log in to your account, access your listing, and make the necessary changes to the details, price, or images.', 6, '2023-08-19 02:30:55', '2023-10-21 03:12:52'),
(22, 20, 'What\'s the Business Policies?', 'Interested buyers can contact you through the contact information you provide in your listing. We recommend using our secure messaging system to maintain privacy and security during negotiations.', 7, '2023-08-19 02:31:11', '2023-10-21 03:13:07'),
(26, 21, 'كيف أقوم بإدراج سيارتي في موقع الويب الخاص بك؟', 'لإدراج سيارتك ، ما عليك سوى إنشاء حساب على موقعنا الإلكتروني ، وتقديم معلومات دقيقة عن السيارة ، وتحميل صور عالية الجودة ، وتحديد السعر المناسب.', 1, '2023-08-19 02:32:32', '2023-08-19 02:32:32'),
(27, 21, 'هل يمكنني إدراج عدة سيارات في حساب واحد؟', 'نعم ، يمكنك إدراج عدة سيارات باستخدام حساب واحد. ما عليك سوى اتباع نفس عملية الإدراج لكل مركبة.', 2, '2023-08-19 02:32:57', '2023-08-19 02:32:57'),
(28, 21, 'هل هناك رسوم لإدراج سيارتي على منصتك؟', 'نحن نقدم كلاً من خيارات الإدراج المجانية والمتميزة. القوائم الأساسية مجانية ، بينما قد تتضمن الخيارات المتميزة رؤية محسنة وميزات إضافية مقابل رسوم.', 3, '2023-08-19 02:33:20', '2023-08-19 02:33:20'),
(29, 21, 'ما نوع المعلومات التي يجب أن أدرجها في قائمة سيارتي؟', 'من المهم تقديم معلومات مفصلة مثل الطراز والطراز والسنة والمسافة المقطوعة والحالة والميزات وأي سجل للحوادث أو الإصلاحات. كلما زادت التفاصيل التي تقدمها ، زادت فرصك في جذب المشترين المحتملين.', 4, '2023-08-19 02:33:43', '2023-08-19 02:33:43'),
(30, 21, 'كم من الوقت ستكون قائمة سيارتي نشطة؟', 'تعتمد مدة قائمة سيارتك على نوع القائمة التي تختارها. عادةً ما يكون للقوائم المجانية مدة قياسية ، في حين أن القوائم المميزة قد تحتوي على فترات رؤية ممتدة.', 5, '2023-08-19 02:34:08', '2023-08-19 02:34:08'),
(31, 21, 'هل يمكنني تعديل القائمة الخاصة بي بعد أن تكون مباشرة؟', 'نعم ، يمكنك تعديل قائمتك في أي وقت. قم بتسجيل الدخول إلى حسابك ، والوصول إلى قائمتك ، وإجراء التغييرات اللازمة على التفاصيل أو السعر أو الصور.', 6, '2023-08-19 02:34:32', '2023-08-19 02:34:32'),
(32, 21, 'كيف أتواصل مع المشترين المحتملين؟', 'يمكن للمشترين المهتمين الاتصال بك من خلال معلومات الاتصال التي تقدمها في قائمتك. نوصي باستخدام نظام المراسلة الآمن الخاص بنا للحفاظ على الخصوصية والأمان أثناء المفاوضات.', 7, '2023-08-19 02:35:10', '2023-08-19 02:35:10'),
(33, 21, 'ماذا يحدث إذا تم بيع سيارتي من خلال منصة أخرى؟', 'إذا كانت سيارتك تبيع من خلال منصة أخرى ، فمن المهم إزالة أو وضع علامة على قائمتك على الفور على أنها مباعة على موقعنا على الإنترنت لتجنب أي ارتباك للمشترين المحتملين.', 8, '2023-08-19 02:35:46', '2023-08-19 02:35:46'),
(34, 21, 'هل هناك أي نصائح لالتقاط صور جذابة للسيارة؟', 'قطعاً! يمكن للصور الواضحة والمضاءة جيدًا التي تم التقاطها من زوايا مختلفة أن تعزز إدراجك بشكل كبير. قم بتضمين لقطات من الداخل والخارج والمحرك وأي ميزات خاصة.', 9, '2023-08-19 02:36:10', '2023-08-19 02:36:10'),
(35, 21, 'ما هي تدابير السلامة المعمول بها لمنع الاحتيال؟', 'نحن نتعامل مع منع الاحتيال على محمل الجد. نحن نستخدم تدابير أمنية مختلفة ونوصي بالتعامل محليًا ، والتحقق من معلومات المشتري ، والحذر من طلبات الدفع غير العادية.', 10, '2023-08-19 02:36:34', '2023-08-19 02:36:34');

-- --------------------------------------------------------

--
-- Table structure for table `fcm_tokens`
--

CREATE TABLE `fcm_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `booking_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fcm_tokens`
--

INSERT INTO `fcm_tokens` (`id`, `user_id`, `token`, `platform`, `message_title`, `message_description`, `created_at`, `updated_at`, `booking_id`) VALUES
(1, NULL, 'bk jfghjash', 'web', 'Product Purchase Complete', 'Your current payment status pending', '2025-12-06 02:54:57', '2025-12-06 02:54:57', 77),
(2, NULL, 'bk jfghjash', 'web', 'Product Purchase Complete', 'Your current payment status pending', '2025-12-06 02:55:10', '2025-12-06 02:55:10', 78),
(3, NULL, 'bk jfghjash', 'web', 'Product Purchase Complete', 'Your current payment status pending', '2025-12-06 02:55:27', '2025-12-06 02:55:27', 79);

-- --------------------------------------------------------

--
-- Table structure for table `featured_listing_charges`
--

CREATE TABLE `featured_listing_charges` (
  `id` bigint UNSIGNED NOT NULL,
  `days` bigint DEFAULT NULL,
  `price` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `featured_listing_charges`
--

INSERT INTO `featured_listing_charges` (`id`, `days`, `price`, `created_at`, `updated_at`) VALUES
(1, 900, 1000, '2024-05-02 00:47:38', '2024-05-02 00:47:38'),
(2, 700, 775, '2024-05-02 00:47:53', '2024-05-02 00:47:53'),
(3, 500, 600, '2024-05-07 22:30:33', '2024-05-07 22:30:42'),
(4, 100, 150, '2024-05-07 22:30:58', '2024-05-07 22:30:58');

-- --------------------------------------------------------

--
-- Table structure for table `feature_orders`
--

CREATE TABLE `feature_orders` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `vendor_mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `days` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conversation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feature_orders`
--

INSERT INTO `feature_orders` (`id`, `listing_id`, `vendor_id`, `vendor_mail`, `order_number`, `total`, `payment_method`, `gateway_type`, `payment_status`, `order_status`, `attachment`, `invoice`, `days`, `start_date`, `end_date`, `created_at`, `updated_at`, `conversation_id`) VALUES
(1, 1, 204, 'superBusiness47@example.com', '678c9598299fc', 1000.00, 'Paypal', 'online', 'completed', 'completed', NULL, '1.pdf', '900', '2025-01-19', '2027-07-08', '2025-01-19 00:03:04', '2025-01-19 00:10:13', NULL),
(2, 14, 204, 'superBusiness47@example.com', '678c95bc2181b', 1000.00, 'Bank of America', 'offline', 'completed', 'completed', '678c95bc20eae.jpg', '2.pdf', '900', '2025-11-03', '2028-04-21', '2025-01-19 00:03:40', '2025-11-03 07:04:36', NULL),
(4, 11, 202, 'biznexus22@example.com', '678c969130e1d', 1000.00, 'Paypal', 'online', 'completed', 'completed', NULL, '4.pdf', '900', '2025-01-19', '2027-07-08', '2025-01-19 00:04:57', '2025-01-19 00:10:30', NULL),
(6, 10, 203, 'tradetrail9@example.com', '678c9734b8b5d', 1000.00, 'Paypal', 'online', 'completed', 'completed', NULL, '6.pdf', '900', '2025-01-19', '2027-07-08', '2025-01-19 00:09:56', '2025-01-19 00:10:31', NULL),
(11, 7, 205, 'bizroster@example.com', '691325cd7677b', 1000.00, 'paypal', 'offline', 'completed', 'completed', NULL, NULL, '900', '2025-11-11', '2028-04-29', '2025-11-11 06:02:21', '2025-11-11 06:02:21', NULL),
(13, 9, 201, 'listingspot56@example.com', '691326a79a46f', 600.00, 'Paypal', 'online', 'completed', 'completed', NULL, '13.pdf', '500', '2025-11-11', '2027-03-26', '2025-11-11 06:05:59', '2025-11-11 06:06:16', NULL),
(14, 15, 204, 'superBusiness47@example.com', '6a04263f31710', 150.00, 'Bank of America', 'offline', 'completed', 'completed', '6a04263f30975.png', '14.pdf', '100', '2026-05-13', '2026-08-21', '2026-05-13 01:20:31', '2026-05-13 01:23:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `feature_sections`
--

CREATE TABLE `feature_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feature_sections`
--

INSERT INTO `feature_sections` (`id`, `language_id`, `subtitle`, `title`, `button_text`, `created_at`, `updated_at`) VALUES
(3, 20, NULL, 'Our top listing', 'Explore All', '2023-08-19 03:00:57', '2025-11-03 22:18:23'),
(4, 21, NULL, 'أفضل مركباتنا المميزة', 'مركباتنا المميزة', '2023-08-19 03:02:05', '2023-12-13 20:54:14');

-- --------------------------------------------------------

--
-- Table structure for table `footer_contents`
--

CREATE TABLE `footer_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `about_company` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `copyright_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `footer_contents`
--

INSERT INTO `footer_contents` (`id`, `language_id`, `about_company`, `copyright_text`, `created_at`, `updated_at`) VALUES
(5, 20, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.', '<p>Copyright ©2026. All Rights Reserved..</p>', '2023-08-19 23:40:53', '2025-12-07 21:20:32'),
(6, 21, 'في قائمة سيارة ، نقدم مجموعة واسعة من السيارات المستعملة عالية الجودة لتلبية احتياجات قيادتك وميزانيتك. مع سنوات من الخبرة في صناعة السيارات ، نفخر بتقديم خدمة عملاء استثنائية والتأكد من أن كل سيارة في قطعتنا تلبي معاييرنا الصارمة للجودة والموثوقية.', '<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">حقوق النشر © 2026. كل الحقوق محفوظة.</span></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"> </div>', '2023-08-19 23:43:21', '2025-12-07 21:20:55');

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('quote_request','claim_request') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`id`, `language_id`, `vendor_id`, `name`, `type`, `status`, `created_at`, `updated_at`) VALUES
(4, 20, NULL, 'Claim Request', 'claim_request', 'active', '2025-09-24 00:41:03', '2025-09-24 00:41:03'),
(6, 21, NULL, 'test', 'quote_request', 'active', '2025-10-17 08:49:35', '2025-10-17 09:33:48'),
(10, 21, NULL, 'vgdfdfdfd', 'claim_request', 'active', '2025-10-21 04:50:17', '2025-10-21 04:50:17'),
(12, 21, 208, 'vcvcvcv', 'quote_request', 'active', '2025-10-21 04:51:15', '2025-10-21 04:51:15'),
(13, 20, 204, 'product query form', 'quote_request', 'active', '2025-10-26 22:28:09', '2025-11-03 06:35:31'),
(14, 21, 207, 'dsdsdsdsd', 'quote_request', 'active', '2025-10-28 04:51:27', '2025-10-28 04:51:27'),
(15, 20, NULL, 'ok', 'quote_request', 'active', '2025-12-07 01:23:41', '2025-12-07 01:23:41');

-- --------------------------------------------------------

--
-- Table structure for table `form_inputs`
--

CREATE TABLE `form_inputs` (
  `id` bigint UNSIGNED NOT NULL,
  `form_id` bigint UNSIGNED DEFAULT NULL,
  `type` tinyint NOT NULL DEFAULT '1' COMMENT '1 - Text Field\n2 - Number Field\n3 - Select\n4 - Checkbox\n5 - Textarea Field\n6 - Datepicker\n7 - Timepicker\n8 - File',
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `placeholder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - not required\n1 - required',
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `file_size` int DEFAULT NULL,
  `order_no` int NOT NULL DEFAULT '0' COMMENT 'Order number for sorting\ndefault value 0 means, this input field has created just now and it has not sorted yet',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `form_inputs`
--

INSERT INTO `form_inputs` (`id`, `form_id`, `type`, `label`, `placeholder`, `name`, `is_required`, `options`, `file_size`, `order_no`, `created_at`, `updated_at`) VALUES
(16, 4, 1, 'Phone', 'Enter phone', 'phone', 1, NULL, NULL, 1, '2025-09-24 00:41:26', '2025-09-24 00:41:26'),
(17, 4, 5, 'Content', 'Enter Message', 'content', 0, NULL, NULL, 2, '2025-09-24 00:42:02', '2025-09-24 00:42:02'),
(18, 4, 6, 'Date', 'Select date', 'date', 1, NULL, NULL, 3, '2025-09-24 00:42:33', '2025-09-24 00:42:33'),
(19, 4, 7, 'time', 'select time', 'time', 1, NULL, NULL, 4, '2025-09-24 00:42:50', '2025-09-24 00:42:50'),
(20, 4, 8, 'Zip file', NULL, 'zip_file', 1, NULL, 10, 5, '2025-09-24 00:44:14', '2025-09-24 00:44:14'),
(31, 13, 1, 'Phone Number', 'phone', 'phone_number', 1, NULL, NULL, 1, '2025-10-27 00:00:01', '2025-10-27 00:00:01'),
(32, 13, 1, 'Product Name', 'Product Name', 'product_name', 1, NULL, NULL, 2, '2025-10-27 00:00:31', '2025-10-27 00:00:31'),
(33, 13, 1, 'Quantity Needed', 'Quantity', 'quantity_needed', 1, NULL, NULL, 3, '2025-10-27 00:00:47', '2025-10-27 00:00:47'),
(34, 13, 5, 'Product Details', 'Product Details', 'product_details', 1, NULL, NULL, 4, '2025-10-27 00:01:25', '2025-10-27 05:55:24'),
(35, 13, 1, 'Delivery Location', 'Delivery Location', 'delivery_location', 1, NULL, NULL, 5, '2025-10-27 00:01:45', '2025-10-27 00:01:45'),
(36, 13, 6, 'Expected Delivery Date', 'Expected Delivery Date', 'expected_delivery_date', 1, NULL, NULL, 6, '2025-10-27 00:02:03', '2025-10-27 00:02:03'),
(37, 13, 2, 'Expected Budget (optional)', 'Expected Budget', 'expected_budget_(optional)', 0, NULL, NULL, 7, '2025-10-27 00:02:25', '2025-10-27 00:02:25'),
(38, 13, 1, 'Additional Comments/Note', 'Additional Comments/Note', 'additional_comments/note', 0, NULL, NULL, 8, '2025-10-27 00:02:46', '2025-10-27 00:02:46'),
(39, 13, 8, 'file', NULL, 'file', 0, NULL, 23, 9, '2025-10-27 22:35:52', '2025-12-06 23:47:24'),
(40, 15, 1, 'sdsd', 'asd', 'sdsd', 1, NULL, NULL, 1, '2025-12-07 01:23:56', '2025-12-07 01:23:56'),
(41, 13, 6, 'Test Date', 'Date', 'test_date', 1, NULL, NULL, 10, '2026-04-21 23:44:22', '2026-04-22 00:50:20');

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `id` bigint UNSIGNED NOT NULL,
  `endpoint` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `guests`
--

INSERT INTO `guests` (`id`, `endpoint`, `created_at`, `updated_at`) VALUES
(10, 'https://fcm.googleapis.com/fcm/send/dnSze7t5tAs:APA91bHjfo1pSMafpV2cHXURCr1zbheCWNEFUOhdzEtsQkb2o0xWi6knO1ovl4KgSE0AY2r26csSiWKf5pZQzP1f43VzOlFfh-8lSdNZAuRioIgV_dJV2On7uoGGfwuot_FiMwnq_DUA', '2024-06-23 00:30:12', '2024-06-23 00:30:12'),
(11, 'https://fcm.googleapis.com/fcm/send/dqTWShBKda4:APA91bEj6e7yaguVik1fJdOfZxZwWzkjIbtCPuzCtFhmbi3g1TmSvmZUvwcdPurox4XT9hatxpe4W8fD-uqfbCu2eH1pNBZL_ZOiOmuPyp6Kn4a4ln84MIPP4RSsTxVsGiuaLyKhDFZj', '2024-09-30 21:33:54', '2024-09-30 21:33:54'),
(12, 'https://fcm.googleapis.com/fcm/send/cxzkYsgQ2oU:APA91bGNLPJwyzbqRFyTqfe_r_dHjfJYsSHaZ5vGF1S1cRMBkbRTai203yvsoUNv5vsJD_IJJLwPaCeVW0o9C0HRHRMWkAVkGTnlOUMCWeXadSkR-4PbuSEn6aDgDpGucZ_CcUytx3nJ', '2024-10-08 23:07:30', '2024-10-08 23:07:30'),
(13, 'https://fcm.googleapis.com/fcm/send/d4SZbcDK9tI:APA91bHTCBrS6YZekpkTxh-iqTsqD68JWIP4Sx28PIutRWRuGHvwf714CFiq5R1Q87KcN0dVbcIoyb2RT2Jxzq9k8zmZwnnerd4ELoHClVlrpsv1VKY2U2E1NcY6suFrm2ob6xkLExJQ', '2025-03-26 22:37:02', '2025-03-26 22:37:02');

-- --------------------------------------------------------

--
-- Table structure for table `hero_sections`
--

CREATE TABLE `hero_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hero_sections`
--

INSERT INTO `hero_sections` (`id`, `language_id`, `title`, `text`, `created_at`, `updated_at`) VALUES
(1, 21, 'هل تبحث عن عمل؟', 'تّبع الشرقي و. أم المضي أجزاء بال, ولم أم وصغار الشمال عشوائية. لم الأولىد. الربيع، وايرلندا الإنذار، ان نفس, بعد ان وعُرفت الطريق الأوروبيّون. أي مارد معارضة هذه', '2024-03-26 20:40:56', '2024-11-11 00:42:08'),
(2, 20, 'Are You Looking For A business?', 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusa ntium doloremque laudantium, totamrem.', '2024-03-26 20:41:33', '2024-05-07 23:48:16');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` char(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `direction` tinyint NOT NULL,
  `is_default` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `direction`, `is_default`, `created_at`, `updated_at`) VALUES
(20, 'English', 'en', 0, 1, '2023-08-17 03:19:12', '2024-05-07 23:38:03'),
(21, 'عربي', 'ar', 1, 0, '2023-08-17 03:19:32', '2025-02-06 01:56:24');

-- --------------------------------------------------------

--
-- Table structure for table `listings`
--

CREATE TABLE `listings` (
  `id` bigint UNSIGNED NOT NULL,
  `feature_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_background_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor_id` bigint DEFAULT '0',
  `mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `average_rating` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_price` double DEFAULT NULL,
  `max_price` double DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `visibility` int NOT NULL DEFAULT '0',
  `is_featured` int NOT NULL DEFAULT '0',
  `tawkto_status` tinyint DEFAULT '0',
  `tawkto_direct_chat_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram_status` int NOT NULL DEFAULT '0',
  `telegram_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `messenger_status` int NOT NULL DEFAULT '0',
  `messenger_direct_chat_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_status` int DEFAULT '0',
  `whatsapp_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_header_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_popup_status` int DEFAULT NULL,
  `whatsapp_popup_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listings`
--

INSERT INTO `listings` (`id`, `feature_image`, `video_background_image`, `video_url`, `vendor_id`, `mail`, `average_rating`, `phone`, `latitude`, `longitude`, `min_price`, `max_price`, `status`, `visibility`, `is_featured`, `tawkto_status`, `tawkto_direct_chat_link`, `telegram_status`, `telegram_username`, `messenger_status`, `messenger_direct_chat_link`, `whatsapp_status`, `whatsapp_number`, `whatsapp_header_title`, `whatsapp_popup_status`, `whatsapp_popup_message`, `created_at`, `updated_at`) VALUES
(1, '1714619499.png', '1715160698.png', 'https://www.youtube.com/watch?v=-FnrCZJw6TE', 204, 'sddlesaloon@gmail.commm', '4.5', '+3545469034096', '-37.89743', '145.06727', 397, 2858, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-01 21:11:39', '2025-01-18 21:56:07'),
(3, '1714627109.png', '1715161205.png', 'https://www.youtube.com/watch?v=Xj4E0Zry6K4', 204, 'ulka@gmail.com', '0', '66', '-37.8152145', '144.9700836', 892, 1430, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8801775891798', 'Hey,...', 1, 'What need you?', '2024-05-01 23:18:29', '2025-01-18 21:59:55'),
(4, '1714638814.png', '1715161266.png', 'https://www.youtube.com/watch?v=hNN9Q3GuWEM', 204, 'resorthotel34@gmail.com', '3.5', '+78685678678', '21.4265856', '91.9796587', NULL, NULL, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-02 02:33:34', '2025-01-18 22:00:52'),
(5, '1714964359.png', '1715161438.png', 'https://www.youtube.com/watch?v=--MdohXec7M', 207, 'feastHaven@gmail.com', '0', '+5469560654690', '35.32473427220887', '75.55125792520062', 631, 3612, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-05 20:59:19', '2025-01-18 22:02:00'),
(6, '1714967273.png', '1715161572.png', 'https://www.youtube.com/watch?v=9l6RywtDlKA', 206, 'motors@gmail.com', '0', '+3545478654', '33.9596331', '-118.3907052', 2729, 3948, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-05 21:47:53', '2025-01-18 22:02:53'),
(7, '1714972012.png', '1715161646.png', 'https://www.youtube.com/watch?v=ugK8HYpoDzE', 205, 'real@gmail.com', '0', '+54679354795', '30.3322', '81.6557', 1005, 3081, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8801775891798', 'Hey,...', 1, 'What need you?', '2024-05-05 23:06:52', '2024-05-08 03:47:26'),
(9, '1715059991.png', '1715161408.png', 'https://www.youtube.com/watch?v=rI8FOLA-9XM', 201, 'Wholesome@gmail.com', '0', '+0354583546', '23.6933', '90.3818', 1155, 2362, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8801775891798', 'Hey,...', 1, 'What need you?', '2024-05-06 20:37:35', '2024-05-08 03:43:28'),
(10, '1715052140.png', '1715161357.png', 'https://www.youtube.com/watch?v=_dui6BUmMBg', 203, 'cafe@gmail.com', '0', '+346753547835467', '32.7157', '117.1611', 751, 2314, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-06 21:22:20', '2024-05-08 03:42:37'),
(11, '1715056471.png', '1715161751.png', 'https://www.youtube.com/watch?v=UrZlTz8NMr0', 202, 'gymcraft@gmail.com', '3', '+234783457984', '37.8136', '142.9631', 2700, 5142, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-06 22:34:31', '2025-12-06 22:55:05'),
(12, '1715062033.png', '1715161036.png', 'https://www.youtube.com/watch?v=KqCUuvl1myg', 205, 'Eliartaltique@gmail.com', '0', '+3485478234234', '30.3322', '81.6557', 1349, 1564, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-07 00:07:13', '2024-05-08 03:37:16'),
(13, '1715071246.png', '1715160819.png', 'https://www.youtube.com/watch?v=_GSc3uAm8rQ', 207, 'bosky@gmail.com', '0', '+65463546954', '33.9983', '71.4859', NULL, NULL, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-07 02:40:46', '2024-05-08 03:35:08'),
(14, '1715138647.png', '1715160845.png', 'https://www.youtube.com/watch?v=-FnrCZJw6TE', 204, 'outlaw@gmail.com', '4', '+609354689546', '27.1234', '-81.5678', 2289, 4903, 1, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-07 20:48:36', '2026-05-12 08:20:08'),
(15, '1715161965.png', '1728975507.png', 'https://www.youtube.com/watch?v=KqCUuvl1myg', 204, 'evergreen@gmail.com', '0', '+3549354765343', '24.3746', '88.6004', NULL, NULL, 0, 1, 0, 1, 'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j', 1, 'example', 1, 'https://www.example.com', 1, '+8800000000000', 'Hey,...', 1, 'What need you?', '2024-05-08 02:46:04', '2026-05-12 08:17:20'),
(17, '1762171703.jpg', NULL, NULL, 0, 'sovoha9006@hh7f.com', '0', '2121212', '49.43453', '149.91553', 2072, 2288, 1, 1, 0, 0, 'gdfgfgf', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, '2025-10-29 04:38:46', '2025-11-03 06:08:23'),
(18, '1762172696.jpg', NULL, NULL, 0, 'fobaj71978@burangir.com', '0', '+1 (422) 432-2987', '40.7614', '-73.9776', 828, 855, 1, 1, 0, 0, NULL, 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, '2025-11-03 06:24:56', '2025-11-03 06:24:56');

-- --------------------------------------------------------

--
-- Table structure for table `listing_categories`
--

CREATE TABLE `listing_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` bigint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mobile_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_categories`
--

INSERT INTO `listing_categories` (`id`, `language_id`, `name`, `icon`, `slug`, `serial_number`, `status`, `created_at`, `updated_at`, `mobile_image`) VALUES
(1, 20, 'salon', 'fas fa-spa', 'salon', 1, 1, '2024-04-30 23:18:55', '2025-12-07 03:46:35', '69354cfbca52c.png'),
(2, 21, 'صالون', 'fas fa-spa', 'صالون', 1, 1, '2024-04-30 23:28:04', '2025-12-07 03:48:16', '69354d604cac3.png'),
(3, 20, 'Hospital', 'fas fa-hospital-alt', 'hospital', 2, 1, '2024-05-01 22:22:03', '2025-12-07 03:46:30', '69354cf60ec37.png'),
(4, 21, 'مستشفى', 'fas fa-hospital-alt', 'مستشفى', 2, 1, '2024-05-01 22:22:38', '2025-12-07 03:48:09', '69354d596ede6.png'),
(5, 20, 'Travel', 'fas fa-plane', 'travel', 3, 1, '2024-05-01 23:19:47', '2025-12-07 03:46:21', '69354cedc4ff8.png'),
(6, 21, 'يسافر', 'fas fa-plane', 'يسافر', 3, 1, '2024-05-01 23:20:22', '2025-12-07 03:48:02', '69354d527a727.png'),
(7, 20, 'Hotel', 'fas fa-h-square', 'hotel', 4, 1, '2024-05-02 02:20:21', '2025-12-07 03:46:12', '69354ce4a5998.png'),
(8, 21, 'الفندق', 'fas fa-h-square', 'الفندق', 4, 1, '2024-05-02 02:21:19', '2025-12-07 03:47:53', '69354d495e537.png'),
(9, 20, 'Restaurant', 'fas fa-utensils', 'restaurant', 5, 1, '2024-05-05 20:43:05', '2025-12-07 03:46:03', '69354cdb52c4a.png'),
(10, 21, 'مطعم', 'fas fa-utensils', 'مطعم', 5, 1, '2024-05-05 20:43:53', '2025-12-07 03:47:38', '69354d3acdc74.png'),
(11, 20, 'Car', 'fas fa-car-side', 'car', 6, 1, '2024-05-05 21:32:25', '2025-12-07 03:45:51', '69354ccfc9ff3.png'),
(12, 21, 'أعمال ال', 'fas fa-car-side', 'أعمال-ال', 6, 1, '2024-05-05 21:33:01', '2025-12-07 03:47:30', '69354d32539c2.png'),
(13, 20, 'Real Estate', 'fas fa-vr-cardboard', 'real-estate', 7, 1, '2024-05-05 22:45:36', '2025-12-07 03:44:54', '69354c966fb5d.png'),
(14, 21, 'العقارات', 'fas fa-vr-cardboard', 'العقارات', 7, 1, '2024-05-05 22:46:09', '2025-12-07 03:47:20', '69354d286a937.png'),
(15, 20, 'Gymnasium', 'fas fa-dumbbell', 'gymnasium', 8, 1, '2024-05-06 02:23:44', '2025-12-07 03:44:44', '69354c8c33a5d.png'),
(16, 21, 'صالة للألعاب الرياضية', 'fas fa-dumbbell', 'صالة-للألعاب-الرياضية', 8, 1, '2024-05-06 02:24:11', '2025-12-07 03:46:48', '69354d08100c2.png');

-- --------------------------------------------------------

--
-- Table structure for table `listing_contents`
--

CREATE TABLE `listing_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `listing_id` bigint DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `state_id` int DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aminities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keyword` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_contents`
--

INSERT INTO `listing_contents` (`id`, `language_id`, `listing_id`, `category_id`, `country_id`, `state_id`, `city_id`, `title`, `slug`, `aminities`, `description`, `address`, `meta_keyword`, `meta_description`, `features`, `created_at`, `updated_at`, `summary`) VALUES
(1, 20, 1, 1, 2, 1, 1, 'Saddle & Sip Saloon', 'saddle-&-sip-saloon', '[\"1\",\"3\",\"5\"]', '<p>\"Saddle &amp; Sip Saloon\" is a lively Western-themed establishment nestled in the heart of [imaginary town name]. Stepping through its swinging doors, patrons are transported to an era where cowboys roamed the frontier and camaraderie was as plentiful as the whiskey poured at the bar.</p>\r\n<p>The saloon\'s rustic decor, adorned with weathered wood, flickering lanterns, and vintage cowboy memorabilia, creates an inviting ambiance that welcomes locals and travelers alike. The scent of hearty barbecue and smoky flavors wafts from the kitchen, tempting hungry guests to indulge in the saloon\'s savory fare.</p>\r\n<p>At the center of the saloon stands a polished wooden bar, where skilled bartenders craft signature cocktails alongside pouring pints of local brews and pouring shots of premium spirits. The bar\'s extensive whiskey selection boasts both classic favorites and rare finds, inviting connoisseurs to savor the rich flavors of aged spirits.</p>\r\n<p>Throughout the week, \"Saddle &amp; Sip Saloon\" hosts a variety of events to entertain its patrons. From live country music performances and line dancing nights to spirited karaoke competitions and themed costume parties, there\'s always something happening to keep the saloon buzzing with excitement.</p>\r\n<p>For those seeking a break from the lively atmosphere, the saloon offers cozy nooks and comfortable seating areas where guests can unwind with friends or enjoy a quiet moment alone. Outside, a spacious patio provides the perfect setting to soak up the sunshine and sip on refreshing drinks beneath the open sky.</p>\r\n<p>With its warm hospitality, authentic Western charm, and spirited atmosphere, \"Saddle &amp; Sip Saloon\" stands as a beloved gathering place where memories are made and friendships flourish amidst the spirited revelry of the Wild West.</p>', 'Second Ave/Kangaroo Rd, Murrumbeena VIC, Australia', NULL, NULL, NULL, '2024-05-01 21:11:40', '2025-01-18 21:57:23', 'Saddle & Sip Saloon is a lively haven blending rustic charm with modern flair. Nestled in the heart of town, this saloon offers handcrafted cocktails, hearty meals, and a warm, welcoming ambiance. Perfect for gatherings or a quiet evening, its vibrant atmosphere and live music make every visit unforgettable. Saddle up and sip your way to great memories!'),
(2, 21, 1, 2, 3, 2, 2, 'صالون السرج ورشفة', 'صالون-السرج-ورشفة', '[\"2\",\"4\",\"6\"]', '<p>\"صالون السرج ورشفة\" هي مؤسسة حيوية ذات طابع غربي تقع في قلب [اسم المدينة الخيالي]. من خلال أبوابه المتأرجحة، يتم نقل الزبائن إلى عصر كان فيه رعاة البقر يجوبون الحدود وكانت الصداقة الحميمة وفيرة مثل صب الويسكي في البار.</p>\r\n<p>يخلق الديكور الريفي للصالون، المزين بالخشب المتأثر بالعوامل الجوية والفوانيس الوامضة وتذكارات رعاة البقر العتيقة، أجواءً جذابة ترحب بالسكان المحليين والمسافرين على حدٍ سواء. تنبعث رائحة الشواء اللذيذة والنكهات المدخنة من المطبخ، مما يغري الضيوف الجائعين بالانغماس في مأكولات الصالون اللذيذة.</p>\r\n<p>يوجد في وسط الصالون بار خشبي مصقول، حيث يصنع السقاة المهرة الكوكتيلات المميزة جنبًا إلى جنب مع سكب مكاييل من المشروبات المحلية وسكب جرعات من المشروبات الروحية الفاخرة. تتميز تشكيلة الويسكي الواسعة في البار بكل من المفضلات الكلاسيكية والاكتشافات النادرة، مما يدعو الخبراء لتذوق النكهات الغنية للمشروبات الروحية القديمة.</p>\r\n<p>على مدار الأسبوع، يستضيف \"صالون السرج ورشفة\" مجموعة متنوعة من الفعاليات للترفيه عن رواده. من عروض الموسيقى الريفية الحية وليالي الرقص إلى مسابقات الكاريوكي الحماسية وحفلات الأزياء ذات الطابع الخاص، هناك دائمًا شيء ما يحدث لإبقاء الصالون مليئًا بالإثارة.</p>\r\n<p>بالنسبة لأولئك الذين يبحثون عن استراحة من الأجواء المفعمة بالحيوية، يوفر الصالون زوايا مريحة ومناطق جلوس مريحة حيث يمكن للضيوف الاسترخاء مع الأصدقاء أو الاستمتاع بلحظة هادئة بمفردهم. في الخارج، يوفر الفناء الفسيح مكانًا مثاليًا للاستمتاع بأشعة الشمس واحتساء المشروبات المنعشة تحت السماء المفتوحة.</p>\r\n<p>بفضل ضيافته الدافئة وسحره الغربي الأصيل وأجوائه المفعمة بالحيوية، يعد \"Saddle &amp; Sip Saloon\" مكانًا محبوبًا للتجمع حيث يتم صنع الذكريات وتزدهر الصداقات وسط احتفالات الغرب المتوحش المفعمة بالحيوية.</p>', '123 شارع المناطق النائية، معبر الكنغر, ملبورن، فيكتوريا 3000، أستراليا', NULL, NULL, NULL, '2024-05-01 21:11:40', '2025-01-18 21:57:23', 'صالون سادل آند سيب هو ملاذ حيوي يجمع بين الطابع الريفي والجاذبية العصرية. يقع في قلب المدينة ويقدم كوكتيلات مُعدة بعناية وأطباق شهية في أجواء دافئة ومرحبة. سواء كنت تخطط لتجمع مع الأصدقاء أو قضاء أمسية هادئة، فإن أجواءه الحيوية والموسيقى الحية تجعل كل زيارة لا تُنسى. استمتع بأوقات رائعة في هذا المكان المميز!'),
(5, 20, 3, 5, 2, 1, 1, 'Dreamscapes Travel Agency', 'dreamscapes-travel-agency', '[\"3\",\"14\"]', '<p><strong>Dreamscapes Travel Agency: Where Every Journey Begins with a Dream</strong></p>\r\n<p>Welcome to Dreamscapes Travel Agency, your gateway to a world of unforgettable adventures and experiences. At Dreamscapes, we believe that travel is not just about visiting destinations; it\'s about embarking on transformative journeys that enrich your life and leave you with cherished memories that last a lifetime.</p>\r\n<p>Founded with a passion for exploration and a commitment to excellence, Dreamscapes Travel Agency has been fulfilling the travel dreams of discerning adventurers since our inception. Whether you\'re yearning for a relaxing beach getaway, an adrenaline-pumping adventure in the great outdoors, or a cultural immersion in a far-flung destination, we are here to turn your travel dreams into reality.</p>\r\n<p>At the heart of our ethos lies a dedication to personalized service and attention to detail. We understand that no two travelers are alike, and that\'s why we take the time to tailor each itinerary to suit your unique preferences, interests, and budget. From the moment you contact us, our team of experienced travel consultants will work tirelessly to craft a bespoke journey that exceeds your expectations and fulfills your deepest travel desires.</p>\r\n<p>What sets Dreamscapes apart is our unwavering commitment to quality and authenticity. We handpick our partners and suppliers to ensure that every aspect of your trip – from accommodations and transportation to activities and excursions – meets the highest standards of excellence. Whether you\'re staying at a luxury resort, a boutique hotel, or a charming bed and breakfast, rest assured that you\'ll enjoy impeccable service and comfort throughout your stay.</p>\r\n<p>But our dedication to excellence extends beyond logistics; it\'s about creating meaningful connections and unforgettable experiences that resonate with you long after your journey has ended. Whether you\'re savoring a gourmet meal prepared by a local chef, exploring hidden gems off the beaten path, or immersing yourself in the vibrant culture of a new destination, we strive to create moments of magic that will leave you inspired and invigorated.</p>\r\n<p>At Dreamscapes Travel Agency, we believe that travel has the power to transform lives and broaden horizons. That\'s why we\'re committed to sustainable and responsible tourism practices that preserve the beauty and integrity of the destinations we visit. From supporting local communities and initiatives to minimizing our environmental footprint, we\'re dedicated to making a positive impact wherever we go.</p>\r\n<p>So whether you\'re planning your honeymoon, a family vacation, a solo adventure, or a group getaway, let Dreamscapes Travel Agency be your trusted partner in exploration. With our passion for travel, dedication to excellence, and commitment to personalized service, we\'ll make sure that every journey you embark on is nothing short of extraordinary.</p>\r\n<p>Dream big. Travel far. Explore with Dreamscapes Travel Agency.</p>', '123 Collins Street, Melbourne VIC 3000, Australia', NULL, NULL, NULL, '2024-05-01 23:18:29', '2025-01-19 00:08:46', 'Dreamscapes Travel Agency specializes in creating unforgettable travel experiences tailored to your needs. Whether it’s a dream vacation, corporate travel, or a weekend getaway, we provide personalized itineraries, affordable packages, and exceptional service. From flights and accommodations to guided tours, Ulka ensures every journey is seamless and memorable. Discover the world with Ulka Travel Agency—your trusted travel companion!'),
(6, 21, 3, 6, 3, 2, 2, 'وكالة دريم سكيبس للسفريات', 'وكالة-دريم-سكيبس-للسفريات', '[\"9\",\"11\",\"13\"]', '<p>وكالة Dreamscapes للسفر: حيث تبدأ كل رحلة بحلم</p>\r\n<p>مرحبًا بك في وكالة سفريات Dreamscapes، بوابتك إلى عالم من المغامرات والتجارب التي لا تُنسى. في Dreamscapes، نؤمن بأن السفر لا يقتصر فقط على زيارة الوجهات؛ يتعلق الأمر بالشروع في رحلات تحويلية تثري حياتك وتترك لك ذكريات عزيزة تدوم مدى الحياة.</p>\r\n<p>تأسست شركة Dreamscapes Travel Agency بشغف للاستكشاف والالتزام بالتميز، وهي تحقق أحلام السفر للمغامرين المميزين منذ بدايتها. سواء كنت تتوق إلى قضاء عطلة مريحة على الشاطئ، أو مغامرة تضخ الأدرينالين في الهواء الطلق، أو الانغماس الثقافي في وجهة بعيدة، فنحن هنا لتحويل أحلام السفر الخاصة بك إلى حقيقة.</p>\r\n<p>في قلب روحنا يكمن التفاني في الخدمة الشخصية والاهتمام بالتفاصيل. نحن ندرك أنه لا يوجد مسافران متشابهان، ولهذا السبب نأخذ الوقت الكافي لتخصيص كل خط سير ليناسب تفضيلاتك واهتماماتك وميزانيتك الفريدة. منذ لحظة اتصالك بنا، سيعمل فريقنا من مستشاري السفر ذوي الخبرة بلا كلل لصياغة رحلة مخصصة تتجاوز توقعاتك وتلبي رغباتك العميقة في السفر.</p>\r\n<p>ما يميز Dreamscapes عن الآخرين هو التزامنا الثابت بالجودة والأصالة. نحن نختار شركائنا وموردينا بعناية للتأكد من أن كل جانب من جوانب رحلتك - بدءًا من الإقامة والنقل إلى الأنشطة والرحلات - يلبي أعلى معايير التميز. سواء كنت تقيم في منتجع فاخر، أو فندق بوتيكي، أو فندق مبيت وإفطار ساحر، كن مطمئنًا أنك ستستمتع بخدمة وراحة لا تشوبها شائبة طوال فترة إقامتك.</p>\r\n<p>وكالة Dreamscapes للسفر: حيث تبدأ كل رحلة بحلم</p>\r\n<p>مرحبًا بك في وكالة سفريات Dreamscapes، بوابتك إلى عالم من المغامرات والتجارب التي لا تُنسى. في Dreamscapes، نؤمن بأن السفر لا يقتصر فقط على زيارة الوجهات؛ يتعلق الأمر بالشروع في رحلات تحويلية تثري حياتك وتترك لك ذكريات عزيزة تدوم مدى الحياة.</p>\r\n<p>تأسست شركة Dreamscapes Travel Agency بشغف للاستكشاف والالتزام بالتميز، وهي تحقق أحلام السفر للمغامرين المميزين منذ بدايتها. سواء كنت تتوق إلى قضاء عطلة مريحة على الشاطئ، أو مغامرة تضخ الأدرينالين في الهواء الطلق، أو الانغماس الثقافي في وجهة بعيدة، فنحن هنا لتحويل أحلام السفر الخاصة بك إلى حقيقة.</p>\r\n<p>في قلب روحنا يكمن التفاني في الخدمة الشخصية والاهتمام بالتفاصيل. نحن ندرك أنه لا يوجد مسافران متشابهان، ولهذا السبب نأخذ الوقت الكافي لتخصيص كل خط سير ليناسب تفضيلاتك واهتماماتك وميزانيتك الفريدة. منذ لحظة اتصالك بنا، سيعمل فريقنا من مستشاري السفر ذوي الخبرة بلا كلل لصياغة رحلة مخصصة تتجاوز توقعاتك وتلبي رغباتك العميقة في السفر.</p>\r\n<p>ما يميز Dreamscapes عن الآخرين هو التزامنا الثابت بالجودة والأصالة. نحن نختار شركائنا وموردينا بعناية للتأكد من أن كل جانب من جوانب رحلتك - بدءًا من الإقامة والنقل إلى الأنشطة والرحلات - يلبي أعلى معايير التميز. سواء كنت تقيم في منتجع فاخر، أو فندق بوتيكي، أو فندق مبيت وإفطار ساحر، كن مطمئنًا أنك ستستمتع بخدمة وراحة لا تشوبها شائبة طوال فترة إقامتك.</p>', 'وكالة دريم سكيبس للسفريات جناح 301، برج كولينز 123 شارع كولينز ملبورن، فكتوريا 3000 أستراليا', NULL, NULL, NULL, '2024-05-01 23:18:29', '2025-01-18 21:59:55', 'تتخصص وكالة أولكا للسفر في خلق تجارب سفر لا تُنسى مصممة حسب احتياجاتك. سواء كانت عطلة حلم أو سفر تجاري أو عطلة نهاية أسبوع، نحن نقدم مسارات مخصصة، باقات بأسعار معقولة، وخدمة استثنائية. من الرحلات الجوية والإقامة إلى الجولات السياحية، تضمن أولكا أن تكون كل رحلة سلسة ولا تُنسى. اكتشف العالم مع وكالة أولكا للسفر - رفيقك الموثوق في السفر!'),
(7, 20, 4, 7, 6, NULL, 5, 'Tranquil Haven Hotel', 'tranquil-haven-hotel', '[\"1\",\"3\"]', '<p>Nestled along the picturesque shores of Cox\'s Bazar, Bangladesh, Tranquil Haven Hotel stands as an oasis of serenity amidst the vibrant coastal ambiance. Enveloped by the soothing sounds of the ocean waves and surrounded by breathtaking natural beauty, this luxurious haven offers a sanctuary for travelers seeking relaxation and rejuvenation.</p>\r\n<p>As you step into Tranquil Haven Hotel, you are greeted by an atmosphere of understated elegance and warm hospitality. The hotel\'s contemporary design seamlessly blends with traditional Bangladeshi aesthetics, creating a harmonious environment that instantly puts guests at ease.</p>\r\n<p>Accommodations at Tranquil Haven Hotel are designed to provide the utmost comfort and luxury. Each room and suite is thoughtfully appointed with modern amenities and tasteful décor, offering a tranquil retreat after a day of exploration. From stunning ocean views to plush bedding and spacious living areas, every detail has been carefully curated to ensure a memorable stay.</p>\r\n<p>Guests can indulge their senses and nourish their bodies at the hotel\'s spa and wellness center. Offering an array of rejuvenating treatments and therapies, including massages, facials, and yoga sessions, the spa provides a sanctuary for relaxation and renewal.</p>\r\n<p>For those seeking culinary delights, Tranquil Haven Hotel boasts a fine dining restaurant that tantalizes the taste buds with a diverse menu of local and international cuisine. Using only the freshest ingredients, the hotel\'s talented chefs create culinary masterpieces that satisfy even the most discerning palate.</p>\r\n<p>Beyond the comforts of the hotel, guests can explore the wonders of Cox\'s Bazar and its surrounding areas. From pristine beaches and lush hills to vibrant markets and cultural landmarks, there is no shortage of experiences to discover.</p>\r\n<p>Whether you are seeking a peaceful escape, a romantic getaway, or a memorable family vacation, Tranquil Haven Hotel invites you to immerse yourself in luxury and tranquility amidst the beauty of Cox\'s Bazar. Experience the essence of Bangladeshi hospitality at its finest and create unforgettable memories that will last a lifetime.</p>', 'Hotel Ocean View, Hotel Motel Zone, Cox\'s Bazar, Chittagong Division, Bangladesh', NULL, NULL, NULL, '2024-05-02 02:33:34', '2025-01-18 22:00:52', 'Tranquil Haven Hotel offers a serene retreat with luxurious accommodations and exceptional service. Nestled in a peaceful setting, it provides the perfect escape for relaxation and rejuvenation. Whether you’re here for a romantic getaway, a family vacation, or a business trip, Tranquil Haven promises an unforgettable experience with top-notch amenities and a welcoming atmosphere.'),
(8, 21, 4, 8, 7, NULL, 6, 'فندق ترانكويل هافن', 'فندق-ترانكويل-هافن', '[\"2\",\"6\",\"13\"]', '<div class=\"flex-1 overflow-hidden\">\r\n<div class=\"react-scroll-to-bottom--css-vawqt-79elbk h-full\">\r\n<div class=\"react-scroll-to-bottom--css-vawqt-1n7m0yu\">\r\n<div>\r\n<div class=\"flex flex-col text-sm pb-9\">\r\n<div class=\"w-full text-token-text-primary\">\r\n<div class=\"px-4 py-2 justify-center text-base md:gap-6 m-auto\">\r\n<div class=\"flex flex-1 text-base mx-auto gap-3 juice:gap-4 juice:md:gap-6 md:px-5 lg:px-1 xl:px-5 md:max-w-3xl lg:max-w-[40rem] xl:max-w-[48rem]\">\r\n<div class=\"relative flex w-full min-w-0 flex-col agent-turn\">\r\n<div class=\"flex-col gap-1 md:gap-3\">\r\n<div class=\"flex flex-grow flex-col max-w-full\">\r\n<div class=\"min-h-[20px] text-message flex flex-col items-start gap-3 whitespace-pre-wrap break-words [.text-message+&amp;]:mt-5 overflow-x-auto\">\r\n<div class=\"markdown prose w-full break-words dark:prose-invert dark\">\r\n<p>تقع فندق Tranquil Haven على طول شواطئ كوكس بازار الخلابة في بنغلاديش، حيث يقف كواحة للسكينة بين أجواء الساحل النابضة بالحياة. محاطًا بأصوات الأمواج الهادئة للبحر ومحاطًا بجمال الطبيعة الساحرة، يوفر هذا النزل الفاخر ملاذًا للمسافرين الذين يبحثون عن الاسترخاء والتجديد.</p>\r\n<p>عند دخولك إلى فندق Tranquil Haven، يُرحب بك بأجواء من الأناقة المتفائلة والضيافة الدافئة. تمزج التصميم العصري للفندق بسلاسة مع الجماليات التقليدية البنغلاديشية، مما يخلق بيئة متناغمة تضع الضيوف في راحة تامة.</p>\r\n<p>تم تصميم الإقامة في فندق Tranquil Haven لتوفير أقصى درجات الراحة والفخامة. تم تجهيز كل غرفة وجناح بعناية فائقة مع وسائل الراحة الحديثة والديكور الذوق، مما يوفر ملاذًا هادئًا بعد يوم من الاستكشاف. من إطلالات البحر الرائعة إلى الفراش الفاخر والمساحات المعيشية الواسعة، تم ترتيب كل التفاصيل بعناية لضمان إقامة لا تُنسى.</p>\r\n<p>يمكن للضيوف تدليل حواسهم وتغذية أجسادهم في مركز السبا والعافية في الفندق. يقدم المركز مجموعة من العلاجات والجلسات المتجددة بما في ذلك التدليك والتقشير وجلسات اليوغا، مما يوفر ملاذًا للراحة والتجديد.</p>\r\n<p>لمن يبحثون عن النكهات الشهية، يفتخر فندق Tranquil Haven بمطعم يقدم أطباقًا فاخرة من المأكولات المحلية والعالمية. باستخدام فقط أجود المكونات، يقوم الطهاة الموهوبون بإعداد أطباق تلبي حتى أرقى الأذواق.</p>\r\n<p>بعيدًا عن راحة الفندق، يمكن للضيوف استكشاف عجائب كوكس بازار ومناطقها المحيطة. من الشواطئ النقية والتلال الخضراء إلى الأسواق الحيوية والمعالم الثقافية، لا يوجد نقص في التجارب التي يمكن اكتشافها.</p>\r\n<p>سواء كنت تبحث عن الهروب السلمي، أو عطلة رومانسية، أو عطلة عائلية لا تُنسى، يدعوك فندق Tranquil Haven لغوص في الفخامة والهدوء بين جمال كوكس بازار. عش تجربة جوهر الضيافة البنغلاديشية على أفضل وجه وخلق ذكريات لا تُنسى تدوم مدى الحيا</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"pr-2 lg:pr-0\"> </div>\r\n</div>\r\n<div class=\"absolute\">\r\n<div class=\"flex w-full gap-2 items-center justify-center\"> </div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"w-full pt-2 md:pt-0 dark:border-white/20 md:border-transparent md:dark:border-transparent md:w-[calc(100%-.5rem)] juice:w-full\">\r\n<div class=\"relative flex h-full max-w-full flex-1 flex-col\">\r\n<div class=\"absolute bottom-full left-0 right-0\"> </div>\r\n<div class=\"flex w-full items-center\"> </div>\r\n</div>\r\n</div>', 'فندق ترانكويل هافن، طريق أوشن فيو، كالاتالي، شاطئ كولاتولي، كوكس بازار، قسم شيتاغونغ، بنغلاديش، 4700', NULL, NULL, NULL, '2024-05-02 02:33:34', '2025-01-18 22:00:52', 'فندق ترانكيل هافن يقدم ملاذًا هادئًا مع أماكن إقامة فاخرة وخدمة استثنائية. يقع في بيئة هادئة، ويوفر الهروب المثالي للاسترخاء والتجديد. سواء كنت هنا لقضاء عطلة رومانسية، أو عطلة عائلية، أو رحلة عمل، يعد فندق ترانكيل هافن بتقديم تجربة لا تُنسى مع أفضل وسائل الراحة وأجواء ترحيبية.'),
(9, 20, 5, 9, 8, NULL, 7, 'Feast Haven Restaurant', 'feast-haven-restaurant', '[\"5\",\"8\",\"10\",\"14\",\"17\"]', '<p>Nestled amidst the breathtaking landscapes of Skardu, Pakistan, FeastHaven Restaurant stands as a culinary oasis, beckoning travelers and locals alike to indulge in a gastronomic journey like no other. Perched along the scenic Gilgit-Baltistan Road, this culinary gem offers a haven where exquisite flavors, warm hospitality, and stunning vistas converge to create unforgettable dining experiences.</p>\r\n<p>As you step into FeastHaven, you\'re greeted by an ambiance that seamlessly blends rustic charm with modern elegance. The interior decor exudes warmth, with earthy tones, intricate woodwork, and ambient lighting, evoking a sense of comfort and relaxation. Whether you\'re seeking a romantic dinner for two, a lively gathering with friends, or a celebratory feast with family, the restaurant\'s inviting atmosphere sets the stage for memorable moments.</p>\r\n<p>At the heart of FeastHaven lies its culinary philosophy – a dedication to showcasing the rich tapestry of Pakistani cuisine while embracing global influences. The menu, curated by skilled chefs, celebrates the region\'s diverse culinary heritage, offering a tantalizing array of dishes crafted from the finest locally sourced ingredients. From aromatic biryanis and succulent kebabs to fragrant curries and delicate desserts, each dish is a culinary masterpiece, bursting with flavors and spices that dance on the palate.</p>\r\n<p>Beyond its delectable fare, FeastHaven prides itself on its commitment to exceptional service. The attentive staff, guided by a passion for hospitality, ensures that every guest\'s needs are met with warmth and efficiency. Whether you\'re a first-time visitor or a regular patron, you\'ll be treated to personalized attention and a dining experience that exceeds expectations.</p>\r\n<p>For those seeking a truly immersive culinary adventure, FeastHaven offers a range of amenities to enhance the dining experience. Whether it\'s alfresco dining on the terrace, private gatherings in secluded dining rooms, or live music performances to enliven the evenings, there\'s something to delight every palate and preference.</p>\r\n<p>In essence, FeastHaven Restaurant is more than just a dining destination – it\'s a sanctuary for food lovers, a place where flavors come alive, and memories are made against the backdrop of Skardu\'s majestic beauty. So come, embark on a culinary voyage with us, and discover why FeastHaven is not just a restaurant but an experience to savor and cherish.</p>', 'FeastHaven Restaurant Gilgit-Baltistan Road, Skardu 16100, Gilgit-Baltistan, Pakistan', NULL, NULL, NULL, '2024-05-05 20:59:20', '2025-01-18 22:02:00', 'Feast Haven Restaurant offers a delightful dining experience with a wide variety of delicious dishes, expertly prepared to satisfy every palate. Whether you\'re enjoying a casual meal with friends, a family gathering, or a special celebration, Feast Haven provides a warm, welcoming atmosphere with exceptional service and flavorful cuisine. Indulge in a feast like no other at Feast Haven Restaurant.'),
(10, 21, 5, 10, 9, NULL, 8, 'مطعم فيست هيفن', 'مطعم-فيست-هيفن', '[\"2\",\"4\",\"18\"]', '<p>يقع مطعم وسط المناظر الطبيعية الخلابة في سكاردو بباكستان، ويعد بمثابة واحة للطهي، حيث يدعو المسافرين والسكان المحليين على حدٍ سواء للانغماس في رحلة تذوق الطعام لا مثيل لها. تقع جوهرة الطهي هذه على طول طريق جيلجيت-بالتستان الخلاب، وتوفر ملاذًا حيث تتلاقى النكهات الرائعة وكرم الضيافة والمناظر الخلابة لخلق تجارب طعام لا تُنسى.</p>\r\n<p>عند دخولك إلى FeastHaven، ستستقبلك أجواء تمزج بسلاسة بين السحر الريفي والأناقة العصرية. ينضح الديكور الداخلي بالدفء مع الألوان الترابية والأعمال الخشبية المعقدة والإضاءة المحيطة، مما يثير الشعور بالراحة والاسترخاء. سواء كنت تبحث عن عشاء رومانسي لشخصين، أو تجمع حيوي مع الأصدقاء، أو وليمة احتفالية مع العائلة، فإن أجواء المطعم الجذابة تمهد الطريق للحظات لا تنسى.</p>\r\n<p>في قلب FeastHaven تكمن فلسفته الطهوية - التفاني في عرض النسيج الغني للمطبخ الباكستاني مع احتضان التأثيرات العالمية. تحتفل القائمة، التي يرعاها طهاة ماهرون، بتراث الطهي المتنوع في المنطقة، وتقدم مجموعة رائعة من الأطباق المحضرة من أجود المكونات المحلية. من البرياني العطري والكباب اللذيذ إلى الكاري العطري والحلويات اللذيذة، كل طبق عبارة عن تحفة طهي، مليئة بالنكهات والتوابل التي تتراقص على الحنك.</p>\r\n<p>بالإضافة إلى أجرته اللذيذة، يفتخر FeastHaven بالتزامه بتقديم خدمة استثنائية. يضمن الموظفون اليقظون، الذين يسترشدون بشغف الضيافة، تلبية احتياجات كل ضيف بدفء وكفاءة. سواء كنت زائرًا لأول مرة أو زائرًا منتظمًا، فسوف تحظى باهتمام شخصي وتجربة طعام تتجاوز التوقعات.</p>\r\n<p>بالنسبة لأولئك الذين يبحثون عن مغامرة طهي غامرة حقًا، يقدم FeastHaven مجموعة من وسائل الراحة لتعزيز تجربة تناول الطعام. سواء كان تناول الطعام في الهواء الطلق على الشرفة، أو التجمعات الخاصة في غرف الطعام المنعزلة، أو العروض الموسيقية الحية لإضفاء الحيوية على الأمسيات، هناك ما يسعد كل الأذواق والتفضيلات.</p>\r\n<p>في جوهره، يعد مطعم FeastHaven أكثر من مجرد وجهة لتناول الطعام - فهو ملاذ لمحبي الطعام، ومكان تنبض فيه النكهات بالحياة، وتصنع الذكريات على خلفية جمال سكاردو المهيب. لذا تعال، وانطلق معنا في رحلة طهي، واكتشف لماذا لا يعد FeastHaven مجرد مطعم، بل تجربة تستحق التذوق والاعتزاز بها.</p>', 'مطعم FeastHaven طريق جيلجيت-بالتستان، سكاردو 16100، جيلجيت-بالتستان، باكستان', NULL, NULL, NULL, '2024-05-05 20:59:20', '2025-01-18 22:02:00', 'مطعم فيست هافن يقدم تجربة طعام لذيذة مع مجموعة واسعة من الأطباق الشهية، التي تم تحضيرها بعناية لإرضاء جميع الأذواق. سواء كنت تستمتع بوجبة غير رسمية مع الأصدقاء، أو تجمع عائلي، أو احتفال خاص، يوفر مطعم فيست هافن أجواء دافئة وترحيبية مع خدمة استثنائية ومأكولات لذيذة. استمتع بوجبة لا مثيل لها في مطعم فيست هافن.'),
(11, 20, 6, 11, 10, 5, 9, 'Precision Performance Motors', 'precision-performance-motors', '[\"3\",\"5\",\"8\",\"10\",\"15\"]', '<p>Precision Performance Motors is more than just a car dealership; it\'s an automotive oasis nestled in the heart of bustling Los Angeles, California. With a legacy of excellence and a commitment to unparalleled customer service, Precision Performance Motors stands as a beacon of automotive refinement and sophistication.</p>\r\n<p>From the moment you step onto our pristine showroom floor at 1234 Luxe Avenue in Beverly Hills, you\'re enveloped in an atmosphere of luxury and elegance. Every detail, from the sleek modern design to the meticulous placement of each vehicle, is crafted to evoke a sense of awe and admiration.</p>\r\n<p>As you explore our extensive inventory of premium automobiles, ranging from high-performance sports cars to luxurious sedans, you\'ll be guided by our team of knowledgeable and passionate automotive experts. With a deep understanding of the latest automotive trends and technologies, our staff is dedicated to helping you find the perfect vehicle that not only meets but exceeds your expectations.</p>\r\n<p>At Precision Performance Motors, we believe that the car-buying experience should be as enjoyable as it is seamless. That\'s why we offer a comprehensive suite of amenities designed to cater to your every need. Whether you\'re sipping on a freshly brewed cup of coffee in our comfortable lounge area, browsing the internet with complimentary Wi-Fi, or enjoying a complimentary car wash with your service appointment, every aspect of your visit is carefully curated to ensure your complete satisfaction.</p>\r\n<p>But our commitment to excellence doesn\'t end when you drive off the lot. With our state-of-the-art service center staffed by factory-trained technicians, we\'re here to provide you with the highest quality maintenance and repair services to keep your vehicle running smoothly for years to come. And with amenities such as loaner cars and shuttle service, we make it easy to keep up with your busy schedule while your vehicle is in our care.</p>\r\n<p>At Precision Performance Motors, we don\'t just sell cars – we cultivate experiences. Whether you\'re a seasoned automotive enthusiast or a first-time buyer, we invite you to discover the unparalleled luxury and service that define the Precision Performance Motors experience. Visit us today and let us help you embark on the journey of a lifetime behind the wheel of your dream car.</p>', 'Los Angeles Performance Motors, West Manchester Avenue, Los Angeles, CA, USA', NULL, NULL, NULL, '2024-05-05 21:47:53', '2025-01-18 22:02:53', 'Precision Performance Motors specializes in high-performance automotive services, offering top-quality repairs, maintenance, and upgrades. Whether you\'re looking to enhance your vehicle\'s performance, restore its condition, or keep it running smoothly, we provide expert solutions tailored to your needs. Trust Precision Performance Motors for unmatched craftsmanship and superior service to keep your vehicle performing at its best.'),
(12, 21, 6, 12, 11, 6, 10, 'محركات الأداء الدقيقة', 'محركات-الأداء-الدقيقة', '[\"2\",\"6\",\"18\"]', '<p>إن شركة محركات الأداء بالدقةهي أكثر من مجرد وكالة لبيع السيارات؛ إنها واحة سيارات تقع في قلب مدينة لوس أنجلوس الصاخبة، كاليفورنيا. بفضل تراثها من التميز والالتزام بخدمة العملاء التي لا مثيل لها، تقف شركة محركات الأداء بالدقةكمنارة لصقل السيارات وتطورها.</p>\r\n<p>منذ اللحظة التي تخطو فيها إلى صالة العرض الأصلية في 1234 Luxe Avenue في بيفرلي هيلز، ستجد نفسك محاطًا بجو من الفخامة والأناقة. تم تصميم كل التفاصيل، بدءًا من التصميم العصري الأنيق وحتى الموضع الدقيق لكل مركبة، لإثارة شعور بالرهبة والإعجاب.</p>\r\n<p>بينما تستكشف مخزوننا الكبير من السيارات الفاخرة، بدءًا من السيارات الرياضية عالية الأداء إلى سيارات السيدان الفاخرة، سيتم إرشادك من قبل فريقنا من خبراء السيارات ذوي المعرفة والشغف. بفضل الفهم العميق لأحدث اتجاهات وتقنيات السيارات، فإن موظفينا ملتزمون بمساعدتك في العثور على السيارة المثالية التي لا تلبي توقعاتك فحسب، بل تتجاوزها أيضًا.</p>\r\n<p>في شركة Precision Performance Motors، نؤمن بأن تجربة شراء السيارة يجب أن تكون ممتعة بقدر ما هي سلسة. ولهذا السبب نقدم مجموعة شاملة من وسائل الراحة المصممة لتلبية جميع احتياجاتك. سواء كنت تحتسي فنجانًا من القهوة الطازجة في منطقة الصالة المريحة لدينا، أو تتصفح الإنترنت باستخدام خدمة الواي فاي المجانية، أو تستمتع بغسيل السيارة مجانًا مع موعد الخدمة الخاص بك، فقد تم تنسيق كل جانب من جوانب زيارتك بعناية لضمان حصولك على خدمات متكاملة إشباع.</p>\r\n<p>لكن التزامنا بالتميز لا ينتهي عندما تقود سيارتك خارج المكان. من خلال مركز الخدمة المتطور الخاص بنا والذي يضم فنيين مدربين في المصنع، نحن هنا لنقدم لك خدمات الصيانة والإصلاح بأعلى مستويات الجودة للحفاظ على تشغيل سيارتك بسلاسة لسنوات قادمة. ومع وسائل الراحة مثل السيارات المستعارة وخدمة النقل المكوكية، فإننا نجعل من السهل مواكبة جدول أعمالك المزدحم أثناء وجود سيارتك في رعايتنا.</p>\r\n<p>في شركة Precision Performance Motors، نحن لا نبيع السيارات فحسب، بل ننمي الخبرات. سواء كنت من عشاق السيارات المتمرسين أو مشتريًا لأول مرة، فإننا ندعوك لاكتشاف الفخامة والخدمة التي لا مثيل لها والتي تحدد تجربة Precision Performance Motors. تفضل بزيارتنا اليوم ودعنا نساعدك على الانطلاق في رحلة العمر خلف عجلة قيادة سيارة أحلامك.</p>', 'شركة بريسيشن بيرفورمانس موتورز 1234 لوكس أفينيو، جناح 200، بيفرلي هيلز، لوس أنجلوس، كاليفورنيا 90001، الولايات المتحدة.', NULL, NULL, NULL, '2024-05-05 21:47:53', '2025-01-18 22:02:53', 'براسينجن بيرفورمانس موتورز متخصص في خدمات السيارات عالية الأداء، حيث يقدم إصلاحات وصيانة وترقيات عالية الجودة. سواء كنت ترغب في تعزيز أداء سيارتك، أو استعادتها إلى حالتها الأصلية، أو الحفاظ على سيرها بسلاسة، نقدم حلولاً خبيره مصممة وفقًا لاحتياجاتك. ثق في براسينجن بيرفورمانس موتورز للحصول على حرفية لا مثيل لها وخدمة ممتازة للحفاظ على أداء سيارتك في أفضل حالاتها.'),
(13, 20, 7, 13, 10, 7, 11, 'Blue Sky Realty Group', 'blue-sky-realty-group', '[\"8\",\"10\",\"17\"]', '<p><strong>Blue Sky Estates: Where Serenity Meets Luxury in Jacksonville</strong></p>\r\n<p>Welcome to Blue Sky Estates, an exquisite residential oasis nestled in the heart of Jacksonville, Florida. Poised majestically along the tranquil shores of the St. Johns River, this prestigious community redefines luxury living with its breathtaking vistas, unparalleled amenities, and unrivaled attention to detail.</p>\r\n<p><strong>Location and Accessibility</strong></p>\r\n<p>Conveniently located at 789 Serenity Drive, Blue Sky Estates offers residents the perfect balance of seclusion and accessibility. Situated in the prestigious Mandarin neighborhood of Jacksonville, this exclusive enclave provides easy access to major highways, premier shopping destinations, top-rated schools, and a myriad of cultural and recreational attractions. With downtown Jacksonville just a short drive away, residents enjoy the convenience of urban amenities while basking in the serenity of riverside living.</p>\r\n<p><strong>Scenic Views and Natural Beauty</strong></p>\r\n<p>Prepare to be captivated by the natural beauty that surrounds Blue Sky Estates. Set against a backdrop of lush greenery and the shimmering waters of the St. Johns River, every home in this esteemed community boasts panoramic views that showcase the stunning Florida landscape in all its glory. Whether you\'re savoring a morning cup of coffee on your private terrace or unwinding with a glass of wine as the sun sets over the river, the awe-inspiring vistas of Blue Sky Estates will leave you breathless.</p>\r\n<p><strong>Luxurious Residences</strong></p>\r\n<p>Step inside the elegant residences of Blue Sky Estates and experience a world of refined sophistication and timeless charm. Crafted with meticulous attention to detail and adorned with upscale finishes, each home exudes an aura of luxury and exclusivity. From expansive floor-to-ceiling windows that flood the interiors with natural light to gourmet kitchens equipped with state-of-the-art appliances and custom cabinetry, every aspect of these residences reflects the highest standards of quality and craftsmanship. With spacious layouts, designer fixtures, and sumptuous living spaces, Blue Sky Estates offers the epitome of modern luxury living.</p>\r\n<p><strong>World-Class Amenities</strong></p>\r\n<p>At Blue Sky Estates, luxury knows no bounds. Indulge in a wealth of world-class amenities designed to elevate every aspect of your lifestyle. Lounge by the sparkling infinity pool and soak up the Florida sun as you admire the panoramic views of the river. Stay active and energized at the fully-equipped fitness center, where state-of-the-art equipment and personalized training services await. Host unforgettable gatherings in the elegant clubhouse, complete with a catering kitchen and expansive entertainment spaces. From the meticulously landscaped gardens to the serene walking trails that wind through the community, every amenity at Blue Sky Estates is thoughtfully curated to enhance your sense of well-being and tranquility.</p>\r\n<p><strong>Community and Lifestyle</strong></p>\r\n<p>More than just a place to live, Blue Sky Estates is a vibrant community where neighbors become friends and every day is filled with possibility. Whether you\'re participating in a yoga class on the riverfront lawn or joining fellow residents for a sunset cocktail party at the outdoor terrace, you\'ll find endless opportunities to connect, relax, and unwind. With a full calendar of social events, recreational activities, and cultural experiences, life at Blue Sky Estates is anything but ordinary. Discover the true meaning of luxury living and experience the unparalleled lifestyle that awaits at this exclusive riverside retreat.</p>\r\n<p><strong>Conclusion</strong></p>\r\n<p>In conclusion, Blue Sky Estates represents the pinnacle of luxury living in Jacksonville, Florida. From its idyllic riverside location to its world-class amenities and luxurious residences, every aspect of this esteemed community is designed to exceed your expectations and elevate your lifestyle. Whether you\'re seeking a peaceful retreat from the hustle and bustle of city life or a vibrant community where every day feels like a vacation, Blue Sky Estates offers the perfect blend of serenity, sophistication, and style. Come home to Blue Sky Estates and discover the ultimate in riverside luxury living.</p>', 'Blue Sky Estates 789 Serenity Drive Jacksonville, FL 32256 United States', NULL, NULL, NULL, '2024-05-05 23:06:52', '2025-01-18 22:03:44', 'Blue Sky Realty Group is a trusted name in real estate, offering a wide range of properties for sale and rent. Whether you\'re looking for your dream home, a commercial property, or an investment opportunity, we provide expert guidance and personalized service to help you make informed decisions. Experience seamless transactions and exceptional customer care with Blue Sky Realty Group.'),
(14, 21, 7, 14, 11, 8, 12, 'مجموعة بلو سكاي العقارية', 'مجموعة-بلو-سكاي-العقارية', '[\"2\",\"6\",\"18\"]', '<p><strong>بلو سكاي إستيتس: حيث يلتقي الصفاء بالفخامة في جاكسونفيل</strong></p>\r\n<p>مرحبًا بكم في Blue Sky Estates، وهي واحة سكنية رائعة تقع في قلب مدينة جاكسونفيل بولاية فلوريدا. يقع هذا المجتمع المرموق بشكل مهيب على طول الشواطئ الهادئة لنهر سانت جونز، ويعيد تعريف الحياة الفاخرة بمناظره الخلابة ووسائل الراحة التي لا مثيل لها والاهتمام الذي لا مثيل له بالتفاصيل.</p>\r\n<p><strong>الموقع وسهولة الوصول</strong></p>\r\n<p>يقع موقع مناسب في 789 Serenity Drive، ويوفر للمقيمين التوازن المثالي بين العزلة وسهولة الوصول. يقع هذا الجيب الحصري في حي ماندارين المرموق في جاكسونفيل، ويوفر سهولة الوصول إلى الطرق السريعة الرئيسية ووجهات التسوق الرئيسية والمدارس ذات التصنيف العالي وعدد لا يحصى من المعالم الثقافية والترفيهية. مع وجود وسط مدينة جاكسونفيل على بعد مسافة قصيرة بالسيارة، يستمتع السكان براحة المرافق الحضرية بينما يستمتعون بهدوء الحياة على ضفاف النهر.</p>\r\n<p><strong>مناظر خلابة وجمال طبيعي</strong></p>\r\n<p>استعد لتنبهر بالجمال الطبيعي الذي يحيط بـ Blue Sky Estates. يقع على خلفية من المساحات الخضراء المورقة والمياه المتلألئة لنهر سانت جونز، ويتميز كل منزل في هذا المجتمع الموقر بإطلالات بانورامية تعرض المناظر الطبيعية المذهلة في فلوريدا بكل مجدها. سواء كنت تتذوق فنجانًا من القهوة في الصباح على شرفتك الخاصة أو تسترخي مع كأس من النبيذ أثناء غروب الشمس فوق النهر، فإن المناظر المذهلة في Blue Sky Estates ستجعلك تحبس الأنفاس.</p>\r\n<p><strong>مساكن فاخرة</strong></p>\r\n<p>ادخل إلى المساكن الأنيقة في Blue Sky Estates واستمتع بتجربة عالم من الرقي الراقي والسحر الخالد. تم تصميم كل منزل بعناية فائقة بالتفاصيل ومزين بتشطيبات راقية، وهو ينضح بهالة من الفخامة والتفرد. بدءًا من النوافذ الواسعة الممتدة من الأرض حتى السقف والتي تغمر المساحات الداخلية بالضوء الطبيعي إلى مطابخ الذواقة المجهزة بأحدث الأجهزة والخزائن المخصصة، يعكس كل جانب من جوانب هذه المساكن أعلى معايير الجودة والحرفية. بفضل التصميمات الفسيحة والتجهيزات المصممة ومساحات المعيشة الفخمة، تقدم Blue Sky Estates مثالًا للمعيشة الفاخرة الحديثة.</p>\r\n<p><strong>وسائل الراحة ذات المستوى العالمي</strong></p>\r\n<p>في بلو سكاي إستيتس، الفخامة لا تعرف حدودًا. انغمس في مجموعة كبيرة من وسائل الراحة ذات المستوى العالمي المصممة للارتقاء بكل جانب من جوانب نمط حياتك. استرخ بجانب المسبح اللامتناهي المتلألئ واستمتع بأشعة شمس فلوريدا بينما تستمتع بالمناظر البانورامية للنهر. حافظ على نشاطك وحيويتك في مركز اللياقة البدنية المجهز بالكامل، حيث تنتظرك أحدث المعدات وخدمات التدريب الشخصية. يمكنك استضافة تجمعات لا تُنسى في النادي الأنيق المجهز بمطبخ لتقديم الطعام ومساحات ترفيهية واسعة. بدءًا من الحدائق ذات المناظر الطبيعية الدقيقة وحتى مسارات المشي الهادئة التي تمر عبر المجتمع، تم تصميم كل وسائل الراحة في Blue Sky Estates بعناية لتعزيز إحساسك بالرفاهية والهدوء.</p>\r\n<p><strong>المجتمع وأسلوب الحياة</strong></p>\r\n<p>أكثر من مجرد مكان للعيش فيه، Blue Sky Estates هو مجتمع نابض بالحياة حيث يصبح الجيران أصدقاء وكل يوم مليء بالاحتمالات. سواء كنت تشارك في دروس اليوغا في الحديقة المطلة على النهر أو تنضم إلى زملائك المقيمين في حفل كوكتيل عند غروب الشمس في التراس الخارجي، ستجد فرصًا لا حصر لها للتواصل والاسترخاء والراحة. مع وجود تقويم كامل للمناسبات الاجتماعية والأنشطة الترفيهية والتجارب الثقافية، فإن الحياة في Blue Sky Estates ليست عادية على الإطلاق. اكتشف المعنى الحقيقي للمعيشة الفاخرة واستمتع بتجربة نمط الحياة الذي لا مثيل له الذي ينتظرك في هذا الملاذ الحصري على ضفاف النهر.</p>\r\n<p><strong>خاتمة</strong></p>\r\n<p>في الختام، تمثل Blue Sky Estates قمة المعيشة الفاخرة في جاكسونفيل، فلوريدا. بدءًا من موقعه المثالي على ضفاف النهر إلى وسائل الراحة ذات المستوى العالمي والمساكن الفاخرة، تم تصميم كل جانب من جوانب هذا المجتمع المحترم ليتجاوز توقعاتك ويرفع مستوى نمط حياتك. سواء كنت تبحث عن ملاذ هادئ من صخب الحياة في المدينة أو عن مجتمع نابض بالحياة حيث يبدو كل يوم وكأنه إجازة، فإن Blue Sky Estates تقدم مزيجًا مثاليًا من الصفاء والرقي والأناقة. عد إلى موطنك في Blue Sky Estates واكتشف أفضل مستويات المعيشة الفاخرة على ضفاف النهر.</p>', 'بلو سكاي إستيتس 789 سيرينتي درايف جاكسونفيل، فلوريدا 32256 الولايات المتحدة', NULL, NULL, NULL, '2024-05-05 23:06:52', '2025-01-18 22:03:44', 'مجموعة بلو سكاي للعقارات هي اسم موثوق في مجال العقارات، حيث تقدم مجموعة واسعة من العقارات للبيع والإيجار. سواء كنت تبحث عن منزلك المثالي، أو عقار تجاري، أو فرصة استثمارية، نقدم لك التوجيه الخبير والخدمة المخصصة لمساعدتك في اتخاذ قرارات مدروسة. استمتع بمعاملات سلسة ورعاية عملاء استثنائية مع مجموعة بلو سكاي للعقارات.'),
(17, 20, 9, 9, 6, NULL, 13, 'Wholesome Fare Diner', 'wholesome-fare-diner', '[\"5\",\"8\",\"17\"]', '<p>Welcome to Wholesome Fare Diner, where every dish tells a story of flavor, tradition, and community. Nestled in the vibrant heart of Keraniganj, Dhaka, our restaurant is a culinary oasis, offering a haven for food enthusiasts seeking authentic flavors and heartfelt hospitality.</p>\r\n<p>As you step through the doors of Wholesome Fare Diner, you\'re greeted by the tantalizing aroma of freshly prepared dishes and the warm ambiance that invites you to unwind and savor every moment. Our cozy yet chic interior reflects the rustic charm of traditional eateries, with modern touches that elevate the dining experience.</p>\r\n<p>At Wholesome Fare Diner, we take pride in curating a menu that celebrates the rich culinary heritage of Bangladesh while embracing global influences. From classic Bengali comfort food to innovative fusion creations, each dish is meticulously crafted using locally sourced ingredients, ensuring freshness and quality with every bite.</p>\r\n<p>Start your culinary journey with our signature appetizers, like the crispy Piyaju made with lentils and spices, or indulge in the savory goodness of our Chicken Tikka skewers, marinated to perfection and grilled to juicy perfection. For seafood lovers, our Prawn Bhuna and Fish Curry showcase the exquisite flavors of the Bay of Bengal, infused with aromatic spices and served with fluffy rice or warm naan bread.</p>\r\n<p>For those craving something hearty and wholesome, our selection of traditional Bengali thalis offers a taste of home-cooked goodness, featuring an assortment of flavorful curries, dal, vegetables, and fragrant rice. Vegetarian options abound, with dishes like Aloo Gobi and Palak Paneer showcasing the vibrant colors and bold flavors of seasonal produce.</p>\r\n<p>At Wholesome Fare Diner, we believe that dining is not just about nourishing the body but also feeding the soul. That\'s why we go beyond food to create an immersive dining experience that celebrates the spirit of community and togetherness. Our attentive staff is dedicated to providing personalized service, ensuring that every visit feels like a special occasion.</p>\r\n<p>Whether you\'re gathering with loved ones for a leisurely meal, celebrating a milestone, or simply seeking solace in good food, Wholesome Fare Diner welcomes you with open arms. Come join us on a culinary adventure that\'s as satisfying as it is unforgettable.</p>\r\n<p>Experience the flavors of Bangladesh and beyond at Wholesome Fare Diner – where every meal is a celebration of tradition, taste, and togetherness.</p>', 'Wholesome Fare Diner Street Address: 17, Sheikh Mujib Road, Bazar Bus Stand, Keraniganj, Dhaka-1310 Landmark: Opposite to Keraniganj High School and College City: Dhaka Postal Code: 1310 Country: Bangladesh', NULL, NULL, NULL, '2024-05-06 20:37:36', '2025-01-18 22:04:54', 'Wholesome Fare Diner offers a heartwarming dining experience with fresh, healthy, and delicious meals. Our menu features a variety of wholesome options made from quality ingredients to nourish your body and soul. Whether you\'re stopping by for breakfast, lunch, or dinner, enjoy a welcoming atmosphere, friendly service, and food that feels like home at Wholesome Fare Diner.'),
(18, 21, 9, 10, 7, NULL, 14, 'مطعم أجرة صحية', 'مطعم-أجرة-صحية', '[\"6\",\"16\",\"20\",\"22\"]', '<p>مرحبًا بكم في مطعم ، حيث يحكي كل طبق قصة عن النكهة والتقاليد والمجتمع. يقع مطعمنا في قلب مدينة كيرانيجانج النابض بالحياة في داكا، ويُعد واحة للطهي، ويوفر ملاذًا لعشاق الطعام الباحثين عن النكهات الأصيلة وكرم الضيافة.</p>\r\n<p>أثناء دخولك أبواب مطعم ، سيتم الترحيب بك بالرائحة المثيرة للأطباق الطازجة والأجواء الدافئة التي تدعوك للاسترخاء وتذوق كل لحظة. يعكس تصميمنا الداخلي المريح والأنيق السحر الريفي للمطاعم التقليدية، مع لمسات عصرية ترتقي بتجربة تناول الطعام.</p>\r\n<p>في Wholesome Fare Diner، نحن نفخر بتنظيم قائمة تحتفل بتراث الطهي الغني لبنغلاديش مع احتضان التأثيرات العالمية. بدءًا من الطعام البنغالي الكلاسيكي المريح وحتى الإبداعات المبتكرة، يتم إعداد كل طبق بدقة باستخدام مكونات من مصادر محلية، مما يضمن النضارة والجودة مع كل قضمة.</p>\r\n<p>ابدأ رحلتك الطهوية مع المقبلات المميزة لدينا، مثل بياجو المقرمشة المصنوعة من العدس والتوابل، أو انغمس في المذاق اللذيذ لأسياخ دجاج تكا، المتبلة إلى حد الكمال والمشوية إلى درجة الكمال. لمحبي المأكولات البحرية، يقدم الروبيان بهونا والسمك بالكاري النكهات الرائعة لخليج البنغال، الممزوجة بالتوابل العطرية وتقدم مع الأرز الرقيق أو خبز النان الدافئ.</p>\r\n<p>بالنسبة لأولئك الذين يتوقون إلى شيء لذيذ وصحي، تقدم مجموعتنا المختارة من أطباق التاليس البنغالية التقليدية مذاقًا لذيذًا مطبوخًا في المنزل، وتضم مجموعة متنوعة من الكاري اللذيذ، ودال، والخضروات، والأرز العطري. وتكثر الخيارات النباتية، مع أطباق مثل Aloo Gobi وPalak Paneer التي تعرض الألوان النابضة بالحياة والنكهات الجريئة للمنتجات الموسمية.</p>\r\n<p>في ، نحن نؤمن بأن تناول الطعام لا يتعلق فقط بتغذية الجسم ولكن أيضًا بتغذية الروح. ولهذا السبب فإننا نذهب إلى ما هو أبعد من الطعام لنبتكر تجربة طعام غامرة تحتفي بروح المجتمع والعمل الجماعي. يكرس موظفونا اليقظون جهودهم لتقديم خدمة شخصية، مما يضمن أن كل زيارة تبدو وكأنها مناسبة خاصة.</p>\r\n<p>سواء كنت تجتمع مع أحبائك لتناول وجبة ممتعة، أو تحتفل بحدث هام، أو تبحث ببساطة عن العزاء في طعام جيد، فإن مطعم  يرحب بك بأذرع مفتوحة. انضم إلينا في مغامرة طهي مرضية بقدر ما هي لا تُنسى.</p>\r\n<p>استمتع بتجربة نكهات بنجلاديش وخارجها في مطعم  - حيث تمثل كل وجبة احتفالًا بالتقاليد والذوق والعمل الجماعي.</p>', 'عنوان شارع Wholesome Fare Diner: 17، طريق الشيخ مجيب، موقف حافلات بازار، كيرانيجانج، دكا-1310 معلم بارز: مقابل مدرسة كيرانيجانج الثانوية والكلية المدينة: دكا الرمز البريدي: 1310 البلد: بنغلاديش', NULL, NULL, NULL, '2024-05-06 20:37:36', '2025-01-18 22:04:54', 'مطعم وولسوم فير يقدم تجربة طعام دافئة مع وجبات طازجة وصحية ولذيذة. يضم قائمتنا مجموعة متنوعة من الخيارات المغذية المحضرة من مكونات عالية الجودة لتغذية الجسم والروح. سواء كنت تزورنا لتناول الإفطار، الغداء، أو العشاء، استمتع بأجواء ترحيبية وخدمة ودودة وطعام يشعرك وكأنك في المنزل في مطعم وولسوم فير.'),
(19, 20, 10, 9, 10, 5, 15, 'Café Noir et Blanc', 'café-noir-et-blanc', '[\"5\",\"8\",\"10\",\"17\",\"19\"]', '<p>Nestled in the heart of vibrant San Diego, Café Noir et Blanc exudes an irresistible charm, inviting patrons to experience a fusion of flavors amidst a backdrop of timeless elegance. This quaint café, aptly named for its chic black and white theme, offers a delightful escape from the hustle and bustle of city life.</p>\r\n<p>Step through the inviting entrance adorned with classic bistro-style signage, and you\'ll find yourself enveloped in an ambiance that effortlessly marries sophistication with warmth. Soft jazz melodies float through the air, complementing the cozy chatter of patrons indulging in their culinary delights.</p>\r\n<p>As you settle into one of the plush seats, you\'re greeted by the aroma of freshly brewed coffee and tantalizing scents wafting from the kitchen. Café Noir et Blanc takes pride in its meticulously crafted menu, boasting an array of artisanal coffees, velvety espressos, and aromatic teas sourced from around the globe.</p>\r\n<p>Whether you\'re craving a hearty breakfast to kickstart your day, a light lunch to refuel, or a decadent dessert to satisfy your sweet tooth, Café Noir et Blanc has something to tantalize every palate. From fluffy Belgian waffles drizzled with maple syrup to savory quiches bursting with flavor, each dish is prepared with care using the finest ingredients.</p>\r\n<p>Indulge in a leisurely brunch with friends as you savor mouthwatering avocado toast topped with poached eggs, or treat yourself to a decadent slice of triple-layer chocolate cake paired with a velvety cappuccino. For those seeking healthier options, the menu also features vibrant salads brimming with seasonal produce and wholesome sandwiches made with freshly baked artisanal bread.</p>\r\n<p>In addition to its delectable fare, Café Noir et Blanc prides itself on providing exceptional service, ensuring that every visit is a memorable one. Whether you\'re popping in for a quick caffeine fix or lingering over a leisurely meal, the attentive staff are always on hand to cater to your every need with a warm smile and a personal touch.</p>\r\n<p>With its inviting ambiance, delectable cuisine, and impeccable service, Café Noir et Blanc is more than just a café – it\'s a culinary haven where every moment is savored and every palate delighted. Come and experience the magic for yourself at this charming oasis in the heart of San Diego.</p>', 'Café Noir et Blanc (Black and White Café) 1234 Pacific Avenue San Diego, CA 92101 United States', NULL, NULL, NULL, '2024-05-06 21:22:20', '2025-01-18 22:05:35', 'Café Noir et Blanc is a charming coffee spot that blends elegance and comfort. Offering expertly brewed coffee, delightful pastries, and a cozy ambiance, it\'s the perfect place to unwind, catch up with friends, or spark creativity. Whether you prefer rich espresso or a creamy latte, Café Noir et Blanc promises a memorable experience with every sip.');
INSERT INTO `listing_contents` (`id`, `language_id`, `listing_id`, `category_id`, `country_id`, `state_id`, `city_id`, `title`, `slug`, `aminities`, `description`, `address`, `meta_keyword`, `meta_description`, `features`, `created_at`, `updated_at`, `summary`) VALUES
(20, 21, 10, 10, 11, 6, 16, 'كافيه نوير إي بلان', 'كافيه-نوير-إي-بلان', '[\"16\",\"20\",\"22\"]', '<p>يقع مقهى  في قلب مدينة سان دييغو النابضة بالحياة، وهو ينضح بسحر لا يقاوم، ويدعو العملاء لتجربة مزيج من النكهات وسط خلفية من الأناقة الخالدة. يوفر هذا المقهى الجذاب، الذي سُمي على نحو مناسب لطابعه الأنيق باللونين الأبيض والأسود، ملاذًا مبهجًا من صخب الحياة في المدينة.</p>\r\n<p>قم بالدخول عبر المدخل الجذاب المزين بلافتات كلاسيكية على طراز البيسترو، وستجد نفسك محاطًا بأجواء تجمع بين الرقي والدفء بسهولة. تطفو ألحان موسيقى الجاز الناعمة في الهواء، لتكمل الأحاديث المريحة للعملاء الذين ينغمسون في المأكولات الشهية.</p>\r\n<p>عندما تستقر في أحد المقاعد الفخمة، تستقبلك رائحة القهوة الطازجة والروائح المثيرة التي تفوح من المطبخ. يفخر  بقائمة طعامه المعدة بدقة، والتي تضم مجموعة من أنواع القهوة الحرفية والإسبريسو المخملي وأنواع الشاي العطرية التي يتم الحصول عليها من جميع أنحاء العالم.</p>\r\n<p>سواء كنت ترغب في تناول وجبة إفطار شهية لبدء يومك، أو وجبة غداء خفيفة للتزود بالوقود، أو حلوى لذيذة لإرضاء شهيتك للحلويات، فإن  لديه ما يثير إعجاب جميع الأذواق. بدءًا من الفطائر البلجيكية الرقيقة المغطاة بشراب القيقب وحتى الفطائر اللذيذة المليئة بالنكهة، يتم إعداد كل طبق بعناية باستخدام أجود المكونات.</p>\r\n<p>انغمس في وجبة فطور وغداء ممتعة مع الأصدقاء بينما تتذوق خبز الأفوكادو اللذيذ المغطى بالبيض المسلوق، أو دلّل نفسك بشريحة لذيذة من كعكة الشوكولاتة ثلاثية الطبقات مع الكابتشينو المخملي. بالنسبة لأولئك الذين يبحثون عن خيارات صحية، تتميز القائمة أيضًا بالسلطات النابضة بالحياة المليئة بالمنتجات الموسمية والسندويشات الصحية المصنوعة من الخبز الطازج.</p>\r\n<p>بالإضافة إلى أطباقه اللذيذة، يفخر Café  بتقديم خدمة استثنائية، مما يضمن أن كل زيارة ستكون زيارة لا تُنسى. سواء كنت ترغب في تناول وجبة سريعة من الكافيين أو تناول وجبة ممتعة، فإن الموظفين اليقظين موجودون دائمًا لتلبية جميع احتياجاتك بابتسامة دافئة ولمسة شخصية.</p>\r\n<p>بفضل أجواءه الجذابة ومأكولاته اللذيذة وخدمة لا تشوبها شائبة، يعد Café  أكثر من مجرد مقهى - إنه ملاذ للطهي حيث يتم الاستمتاع بكل لحظة وإسعاد كل الأذواق. تعال واستمتع بتجربة السحر بنفسك في هذه الواحة الساحرة في قلب مدينة سان دييغو.</p>', 'كافيه نوير إي بلان (مقهى بلاك آند وايت) 1234 شارع باسيفيك سان دييغو، كاليفورنيا 92101 الولايات المتحدة', NULL, NULL, NULL, '2024-05-06 21:22:20', '2025-01-18 22:05:35', 'كافيه نوار إيه بلان هو مكان ساحر يجمع بين الأناقة والراحة. يقدم قهوة محضرة بإتقان، ومجموعة من المعجنات اللذيذة، وأجواء دافئة، مما يجعله المكان المثالي للاسترخاء، أو لقاء الأصدقاء، أو إلهام الإبداع. سواء كنت تفضل الإسبرسو الغني أو اللاتيه الكريمي، يعدك كافيه نوار إيه بلان بتجربة لا تُنسى مع كل رشفة.'),
(21, 20, 11, 15, 2, 1, 1, 'GymCraft Solutions', 'gymcraft-solutions', '[\"5\",\"8\",\"10\",\"17\"]', '<p>GymCraft Solutions stands as a beacon of innovation and excellence in the realm of fitness equipment retail. Nestled within the bustling streets of [City], it beckons fitness enthusiasts and gym aficionados alike with its promise of top-notch products and unparalleled service. As you step through its doors, you are greeted by a symphony of sleek machinery and cutting-edge gear, each item meticulously curated to elevate your fitness journey to new heights.</p>\r\n<p>At GymCraft Solutions, we pride ourselves on offering a comprehensive array of products designed to cater to every aspect of your workout regimen. From cardio machines to strength training equipment, we have it all under one roof. Picture rows of state-of-the-art treadmills, ellipticals, and exercise bikes, beckoning you to embark on a journey of endurance and stamina. Our selection of cardio equipment encompasses the latest advancements in technology, ensuring that you can push your limits while minimizing impact on your joints.</p>\r\n<p>For those seeking to sculpt their physique and build strength, GymCraft Solutions presents an impressive lineup of weightlifting equipment. From dumbbells and barbells to power racks and cable machines, we provide the tools you need to carve out the body of your dreams. Whether you\'re a seasoned lifter or just starting out on your fitness journey, our knowledgeable staff is on hand to guide you towards the perfect equipment tailored to your goals and abilities.</p>\r\n<p>But our commitment to excellence doesn\'t stop at the gym floor. GymCraft Solutions understands the importance of recovery and self-care in achieving optimal fitness results. That\'s why we offer a curated selection of recovery tools and accessories, including foam rollers, massage guns, and compression gear, to help you soothe sore muscles and enhance your overall well-being.</p>\r\n<p>Beyond our stellar product offerings, GymCraft Solutions prides itself on providing a shopping experience like no other. Our team of fitness enthusiasts is dedicated to delivering personalized assistance and expert advice, ensuring that you leave our store feeling confident and inspired to conquer your fitness goals. Whether you\'re a professional athlete, a weekend warrior, or simply someone striving to lead a healthier lifestyle, GymCraft Solutions is your ultimate destination for all things fitness.</p>\r\n<p>In every aspect of our business, from the products we sell to the service we provide, GymCraft Solutions is driven by a passion for empowering individuals to unlock their full potential and live their healthiest, happiest lives. Step into our store today and let us be your partner on the journey to greatness.</p>', 'GymCraft Solutions Melbourne: 1201 Fitness Avenue, Suite 301 Victoria Central Plaza, Level 3 Melbourne CBD, Victoria 3000 Australia', NULL, NULL, NULL, '2024-05-06 22:34:31', '2025-01-18 22:06:12', 'GymCraft Solutions specializes in designing and equipping cutting-edge fitness spaces. From home gyms to large commercial facilities, we provide tailored solutions, high-quality equipment, and expert consultation to meet your fitness needs. Whether you’re building from scratch or upgrading, GymCraft Solutions ensures your fitness space is functional, stylish, and optimized for peak performance.'),
(22, 21, 11, 16, 3, 2, 2, 'جيم كرافت سوليوشنز', 'جيم-كرافت-سوليوشنز', '[\"2\",\"6\",\"18\",\"20\"]', '<p>تعد شركة بمثابة منارة للابتكار والتميز في مجال بيع معدات اللياقة البدنية بالتجزئة. يقع في شوارع [] الصاخبة، وهو يغري عشاق اللياقة البدنية وعشاق الصالة الرياضية على حد سواء بوعدهم بتقديم منتجات من الدرجة الأولى وخدمة لا مثيل لها. عندما تدخل من أبوابه، يتم الترحيب بك من خلال سيمفونية من الآلات الأنيقة والمعدات المتطورة، حيث تم تصميم كل عنصر بدقة شديدة للارتقاء برحلة اللياقة البدنية الخاصة بك إلى آفاق جديدة.</p>\r\n<p>في ، نحن نفخر بتقديم مجموعة شاملة من المنتجات المصممة لتلبية كل جانب من جوانب نظام التمرين الخاص بك. من أجهزة القلب إلى معدات تدريب القوة، لدينا كل ذلك تحت سقف واحد. تصور صفوفًا من أجهزة المشي الحديثة، وأجهزة التمارين الرياضية البيضاوية، ودراجات التمرين، والتي تدعوك إلى الشروع في رحلة التحمل والقدرة على التحمل. تشتمل مجموعتنا المختارة من أجهزة تقوية القلب على أحدث التطورات في مجال التكنولوجيا، مما يضمن قدرتك على تجاوز حدودك مع تقليل التأثير على مفاصلك.</p>\r\n<p>بالنسبة لأولئك الذين يسعون إلى نحت اللياقة البدنية وبناء القوة، تقدم تشكيلة رائعة من معدات رفع الأثقال. من الدمبل والأثقال إلى رفوف الطاقة وآلات الكابلات، نحن نقدم الأدوات التي تحتاجها لنحت الجسم الذي تحلم به. سواء كنت من لاعبي رفع الأثقال المتمرسين أو بدأت للتو في رحلة اللياقة البدنية، فإن موظفينا ذوي الخبرة متواجدون لإرشادك نحو المعدات المثالية المصممة خصيصًا لأهدافك وقدراتك.</p>\r\n<p>لكن التزامنا بالتميز لا يتوقف عند صالة الألعاب الرياضية. تدرك شركة أهمية التعافي والرعاية الذاتية في تحقيق نتائج اللياقة البدنية المثالية. لهذا السبب نقدم مجموعة مختارة من أدوات وملحقات التعافي، بما في ذلك بكرات الرغوة وبنادق التدليك ومعدات الضغط، لمساعدتك على تهدئة العضلات الملتهبة وتعزيز صحتك بشكل عام.</p>\r\n<p>بالإضافة إلى عروض منتجاتنا الممتازة، تفتخر شركة بتقديم تجربة تسوق لا مثيل لها. فريقنا من عشاق اللياقة البدنية مكرس لتقديم المساعدة الشخصية ونصائح الخبراء، مما يضمن مغادرة متجرنا وأنت تشعر بالثقة والإلهام لتحقيق أهداف اللياقة البدنية الخاصة بك. سواء كنت رياضيًا محترفًا، أو محاربًا في عطلة نهاية الأسبوع، أو مجرد شخص يسعى لقيادة نمط حياة أكثر صحة، فإن هي وجهتك النهائية لكل ما يتعلق باللياقة البدنية.</p>\r\n<p>في كل جانب من جوانب أعمالنا، بدءًا من المنتجات التي نبيعها إلى الخدمة التي نقدمها، فإن مدفوعة بشغف لتمكين الأفراد من إطلاق العنان لإمكاناتهم الكاملة والعيش حياة أكثر صحة وسعادة. تفضل بزيارة متجرنا اليوم ودعنا نكون شريكك في رحلتك نحو العظمة.</p>', 'محل جيم كرافت سوليوشنز: ١٢٠١ شارع اللياقة البدنية، جناح ٣٠١ مركز فيكتوريا المركزي، الطابق الثالث مدينة ملبورن، فيكتوريا ٣٠٠٠ أستراليا', NULL, NULL, NULL, '2024-05-06 22:34:31', '2025-01-18 22:06:12', 'تتخصص جيم كرافت سوليوشنز في تصميم وتجهيز مساحات اللياقة البدنية الحديثة. من الصالات المنزلية إلى المنشآت التجارية الكبيرة، نقدم حلولاً مخصصة، ومعدات عالية الجودة، واستشارات خبراء لتلبية احتياجاتك الرياضية. سواء كنت تبني من البداية أو تقوم بالتطوير، تضمن جيم كرافت سوليوشنز أن تكون مساحتك الرياضية عملية، أنيقة، ومثالية لتحقيق الأداء الأمثل.'),
(23, 20, 12, 3, 10, 7, 11, 'EliteCare Bed Boutique', 'elitecare-bed-boutique', '[\"5\",\"8\",\"10\",\"17\"]', '<p>EliteCare Hospital Bed Boutique is a premier destination in Jacksonville, Florida, dedicated to providing top-quality hospital beds and related medical equipment to meet the diverse needs of healthcare facilities and individuals alike. Situated on the bustling Riverside Avenue, EliteCare stands as a beacon of excellence in the realm of medical bed solutions.</p>\r\n<p>At EliteCare, our mission is to prioritize comfort, functionality, and reliability in every product we offer. We understand the critical role that hospital beds play in patient care and recovery, which is why we meticulously curate our selection to ensure that each bed meets the highest standards of quality and performance. Whether it\'s for a hospital, nursing home, rehabilitation center, or home care setting, customers can trust EliteCare to deliver superior products that enhance the overall patient experience.</p>\r\n<p>What sets EliteCare apart is our commitment to personalized service and attention to detail. Our knowledgeable and friendly staff are dedicated to guiding customers through the selection process, taking into account specific needs, preferences, and budget considerations. From basic adjustable beds to advanced ICU models, we offer a comprehensive range of options to suit every requirement.</p>\r\n<p>In addition to hospital beds, EliteCare also offers a variety of accessories and supplementary equipment to complement our bed offerings. From bedside tables and overbed trays to specialized mattresses and pressure relief systems, we strive to be a one-stop destination for all medical bed needs. Our goal is to simplify the procurement process for our customers, providing them with everything they need to create a comfortable and efficient care environment.</p>\r\n<p>Beyond our product offerings, EliteCare is deeply committed to customer satisfaction and ongoing support. We understand that purchasing hospital beds is a significant investment, and we stand behind the quality and durability of our products. Our team provides comprehensive post-sales assistance, including installation services, maintenance support, and technical troubleshooting, to ensure that our customers receive the utmost value from their investment.</p>\r\n<p>Moreover, EliteCare is actively involved in the local healthcare community, partnering with hospitals, clinics, and care facilities to support their efforts in providing quality patient care. We collaborate with healthcare professionals to understand evolving industry trends and technological advancements, enabling us to continually refine our product offerings and services to better serve our customers.</p>\r\n<p>In conclusion, EliteCare Hospital Bed Boutique is more than just a showroom—it\'s a trusted partner in the provision of premium medical bed solutions. With a steadfast commitment to quality, service, and innovation, EliteCare strives to enhance the lives of patients and caregivers alike, one bed at a time.</p>', 'EliteCare Hospital Bed Boutique 1256 Riverside Avenue, Suite 210 Jacksonville, FL 32204 United States', NULL, NULL, NULL, '2024-05-07 00:07:13', '2025-01-18 22:06:47', 'EliteCare Bed Boutique offers premium-quality beds and sleep solutions designed for ultimate comfort and style. With a wide range of luxurious mattresses, bed frames, and accessories, we aim to enhance your sleep experience and transform your bedroom into a sanctuary. At EliteCare, quality meets elegance to ensure you wake up refreshed every day.'),
(24, 21, 12, 4, 11, 8, 12, 'بوتيك سرير من إليت كير', 'بوتيك-سرير-من-إليت-كير', '[\"11\",\"13\",\"18\"]', '<p>تعتبر إليت كير  وجهة رئيسية في جاكسونفيل، فلوريدا، وهي مخصصة لتوفير أسرة المستشفيات عالية الجودة والمعدات الطبية ذات الصلة لتلبية الاحتياجات المتنوعة لمرافق الرعاية الصحية والأفراد على حد سواء. تقع EliteCare في شارع ريفرسايد الصاخب، وتعد بمثابة منارة للتميز في عالم حلول الأسرة الطبية.</p>\r\n<p>في EliteCare، مهمتنا هي إعطاء الأولوية للراحة والأداء الوظيفي والموثوقية في كل منتج نقدمه. نحن نتفهم الدور الحاسم الذي تلعبه أسرة المستشفيات في رعاية المرضى وتعافيهم، ولهذا السبب نقوم بتنسيق اختياراتنا بدقة للتأكد من أن كل سرير يلبي أعلى معايير الجودة والأداء. سواء كان الأمر يتعلق بمستشفى أو دار رعاية أو مركز إعادة تأهيل أو مركز رعاية منزلية، يمكن للعملاء الوثوق في لتقديم منتجات فائقة الجودة تعزز تجربة المريض بشكل عام.</p>\r\n<p>ما يميز EliteCare هو التزامنا بالخدمة الشخصية والاهتمام بالتفاصيل. إن موظفينا ذوي المعرفة والود ملتزمون بتوجيه العملاء خلال عملية الاختيار، مع مراعاة الاحتياجات والتفضيلات المحددة واعتبارات الميزانية. بدءًا من الأسرّة الأساسية القابلة للتعديل وحتى نماذج وحدة العناية المركزة المتقدمة، نقدم مجموعة شاملة من الخيارات التي تناسب كل المتطلبات.</p>\r\n<p>بالإضافة إلى أسرة المستشفيات، تقدم أيضًا مجموعة متنوعة من الملحقات والمعدات التكميلية لتكمل عروض الأسرة لدينا. بدءًا من الطاولات الجانبية للسرير والصواني الموجودة فوق السرير وحتى المراتب المتخصصة وأنظمة تخفيف الضغط، فإننا نسعى جاهدين لنكون وجهة شاملة لجميع احتياجات الأسرة الطبية. هدفنا هو تبسيط عملية الشراء لعملائنا، وتزويدهم بكل ما يحتاجونه لخلق بيئة رعاية مريحة وفعالة.</p>\r\n<p>بالإضافة إلى عروض منتجاتنا، تلتزم بشدة برضا العملاء والدعم المستمر. نحن ندرك أن شراء أسرة المستشفيات يعد استثمارًا كبيرًا، ونحن ندعم جودة منتجاتنا ومتانتها. يقدم فريقنا مساعدة شاملة لما بعد البيع، بما في ذلك خدمات التركيب ودعم الصيانة واستكشاف الأخطاء الفنية وإصلاحها، لضمان حصول عملائنا على أقصى قيمة من استثماراتهم.</p>\r\n<p>علاوة على ذلك، تشارك بنشاط في مجتمع الرعاية الصحية المحلي، حيث تتعاون مع المستشفيات والعيادات ومرافق الرعاية لدعم جهودها في توفير رعاية عالية الجودة للمرضى. نحن نتعاون مع المتخصصين في الرعاية الصحية لفهم اتجاهات الصناعة المتطورة والتقدم التكنولوجي، مما يمكننا من تحسين عروض منتجاتنا وخدماتنا باستمرار لتقديم خدمة أفضل لعملائنا.</p>\r\n<p>في الختام، يعتبر أكثر من مجرد صالة عرض - فهو شريك موثوق به في توفير حلول الأسرة الطبية المتميزة. مع الالتزام الثابت بالجودة والخدمة والابتكار، تسعى جاهدة لتحسين حياة المرضى ومقدمي الرعاية على حد سواء، سرير واحد في كل مرة.</p>', 'متجر أسرّة المستشفى النخبة بوتيك شارع ريفرسايد 1256، مكتب 210، جاكسونفيل، فلوريدا 32204، الولايات المتحدة', NULL, NULL, NULL, '2024-05-07 00:07:13', '2025-01-18 22:06:47', 'بوتيك إيليت كير للمفروشات يقدم أسرّة وحلول نوم فاخرة مصممة لتحقيق الراحة المطلقة والأناقة. مع مجموعة واسعة من المراتب الفاخرة، وإطارات الأسرة، والإكسسوارات، نسعى لتعزيز تجربة نومك وتحويل غرفة نومك إلى ملاذ مريح. في إيليت كير، يجتمع الجودة مع الأناقة لضمان استيقاظك منتعشًا كل يوم.'),
(25, 20, 13, 1, 8, NULL, 7, 'Frontier Whiskers Saloon', 'frontier-whiskers-saloon', '[\"3\",\"5\",\"8\"]', '<p>Nestled within the rugged terrain of Peshawar Province, Pakistan, lies the enchanting Frontier Whiskers Saloon, a beacon of camaraderie and warmth amid the vast desert expanse. With its rustic charm and old-world allure, this saloon stands as a testament to the timeless spirit of the Wild West, transplanted into the heart of the Middle East.</p>\r\n<p>As you approach Frontier Whiskers Saloon along the winding Rugged Road, the whispers of adventure seem to dance in the desert breeze. The exterior, weathered by sun and sand, exudes an aura of authenticity, with swinging saloon doors beckoning travelers and locals alike to step inside and escape the harshness of the desert.</p>\r\n<p>Once through those doors, guests are transported to a bygone era, where the clinking of glasses and the twang of country tunes fill the air. The interior is a symphony of reclaimed wood, flickering lanterns, and worn leather furnishings, evoking the rugged charm of frontier life. Mounted animal heads gaze down from the walls, adding a touch of wilderness to the cozy ambiance.</p>\r\n<p>At the heart of Frontier Whiskers Saloon is the bar, a sprawling oak structure that serves as the focal point of social interaction. Behind it, shelves are lined with an impressive array of spirits, from local favorites to imported rarities, promising a libation to suit every palate. Bartenders, clad in traditional western attire, mix and pour with practiced expertise, regaling patrons with tales of the untamed frontier.</p>\r\n<p>But Frontier Whiskers Saloon is more than just a place to wet one\'s whistle; it\'s a hub of community and entertainment. Regulars gather around rough-hewn tables to swap stories of desert exploits, while newcomers are welcomed with open arms into the fold. Live music fills the air most nights, with talented local musicians taking the stage to serenade the crowd with soulful ballads and foot-stomping anthems.</p>\r\n<p>As the evening wears on and the desert sky transforms into a canvas of stars, Frontier Whiskers Saloon continues to buzz with life. Whether savoring a hearty meal crafted from locally sourced ingredients, testing their luck at a game of cards, or simply soaking in the vibrant atmosphere, guests find themselves drawn back time and again to this oasis of hospitality in the sands of Pakistan. Frontier Whiskers Saloon isn\'t just a place; it\'s an experience—a testament to the enduring allure of the Wild West, thriving halfway across the globe.</p>', 'Frontier Whiskers Saloon Rugged Road, Dusty Gulch District, Desert Oasis, Peshawar Province, Pakistan', NULL, NULL, NULL, '2024-05-07 02:40:46', '2025-01-18 22:07:21', 'Frontier Whiskers Saloon is a vibrant destination that captures the spirit of the Wild West. Offering a wide selection of craft drinks, hearty meals, and live entertainment, it’s the perfect spot to relax and enjoy rustic charm with a modern twist. Step into Frontier Whiskers Saloon for a unique and unforgettable experience.'),
(26, 21, 13, 2, 9, NULL, 8, 'صالون شعيرات الحدود', 'صالون-شعيرات-الحدود', '[\"2\",\"11\",\"20\"]', '<p>يقع صالون الساحر داخل التضاريس الوعرة لمقاطعة بيشاور في باكستان، وهو منارة للصداقة الحميمة والدفء وسط مساحة صحراوية شاسعة. بفضل سحرها الريفي وجاذبية العالم القديم، تقف هذه الصالون بمثابة شهادة على روح الغرب المتوحش الخالدة، المزروعة في قلب الشرق الأوسط.</p>\r\n<p>عندما تقترب من Frontier على طول الطريق الوعرة المتعرج، تبدو همسات المغامرة وكأنها تتراقص مع نسيم الصحراء. ينضح الجزء الخارجي، الذي تغمره الشمس والرمال، بهالة من الأصالة، مع أبواب الصالون المتأرجحة التي تدعو المسافرين والسكان المحليين على حد سواء إلى الدخول والهروب من قسوة الصحراء.</p>\r\n<p>بمجرد عبور هذه الأبواب، يتم نقل الضيوف إلى عصر ماضي، حيث يملأ الهواء قعقعة الكؤوس ونغمات الألحان الريفية. التصميم الداخلي عبارة عن سيمفونية من الخشب المستصلح، والفوانيس الوامضة، والمفروشات الجلدية البالية، مما يستحضر سحر الحياة الحدودية الوعرة. تطل رؤوس الحيوانات من على الجدران، مما يضيف لمسة من الحياة البرية إلى الأجواء المريحة.</p>\r\n<p>يقع البار في قلب Frontier ، وهو عبارة عن هيكل مترامي الأطراف من خشب البلوط يعمل كنقطة محورية للتفاعل الاجتماعي. وخلفه، تصطف الرفوف بمجموعة رائعة من المشروبات الروحية، بدءًا من المشروبات الروحية المفضلة المحلية وحتى المشروبات النادرة المستوردة، مما يَعِد باحتساء مشروب يناسب كل الأذواق. يمتزج السقاة، الذين يرتدون الملابس الغربية التقليدية، مع الخبرة العملية، ويمتعون العملاء بحكايات الحدود الجامحة.</p>\r\n<p>لكن صالون فرونتير ويسكرز هو أكثر من مجرد مكان لتبليل صافرة الشخص؛ إنها مركز للمجتمع والترفيه. يجتمع الزوار النظاميون حول طاولات منحوتة بشكل خشن لتبادل قصص مآثر الصحراء، بينما يتم الترحيب بالوافدين الجدد بأذرع مفتوحة في الحظيرة. تملأ الموسيقى الحية الهواء في معظم الليالي، حيث يعتلي الموسيقيون المحليون الموهوبون المسرح ليغنيوا الجمهور بأغاني غنائية مفعمة بالحيوية وأناشيد راقصة.</p>\r\n<p>مع حلول المساء وتحول سماء الصحراء إلى لوحة من النجوم، يستمر صالون في الحيوية. سواء كانوا يستمتعون بوجبة دسمة مصنوعة من مكونات محلية المصدر، أو يختبرون حظهم في لعبة الورق، أو ببساطة يستمتعون بالأجواء النابضة بالحياة، يجد الضيوف أنفسهم منجذبين مرارًا وتكرارًا إلى واحة الضيافة هذه في رمال باكستان. صالون فرونتير ويسكرز ليس مجرد مكان؛ إنها تجربة - شهادة على الجاذبية الدائمة للغرب المتوحش، المزدهر في منتصف الطريق عبر العالم.</p>', 'صالون فرونتير ويسكرز الطريق الوعرة، منطقة داستي جولتش، واحة الصحراء، مقاطعة بيشاور، باكستان', NULL, NULL, NULL, '2024-05-07 02:40:46', '2025-01-18 22:07:21', 'صالون فرونتير ويسكرز هو وجهة نابضة بالحياة تجسد روح الغرب الأمريكي. يقدم مجموعة واسعة من المشروبات الحرفية، والوجبات الشهية، والعروض الحية، مما يجعله المكان المثالي للاسترخاء والاستمتاع بسحر الريف مع لمسة عصرية. ادخل إلى صالون فرونتير ويسكرز لتجربة فريدة لا تُنسى.'),
(27, 20, 14, 1, 10, 7, 11, 'Outlaw Oasis Saloon', 'outlaw-oasis-saloon', '[\"3\",\"5\"]', '<p>Nestled amidst the serene ambiance of Rustic Ravine in Jacknovilla, Florida, Outlaw Oasis Saloon stands as a beacon of rustic charm and laid-back allure. Stepping into this quaint establishment feels like embarking on a journey back in time, where the echoes of the Wild West resonate through every corner. With its weathered wooden facade adorned with swinging saloon doors, Outlaw Oasis Saloon exudes an irresistible old-world charm that beckons travelers and locals alike to venture inside and experience its unique atmosphere.</p>\r\n<p>As you push through the swinging doors, you\'re greeted by the warm glow of lantern light and the lively hum of conversation. The interior transports you to a bygone era, with its rugged wooden beams, vintage memorabilia, and rustic decor that pay homage to the saloons of yesteryears. The scent of aged oak and hearty comfort food wafts through the air, tantalizing your senses and setting the stage for an unforgettable experience.</p>\r\n<p>At the heart of Outlaw Oasis Saloon lies its bustling bar, where skilled bartenders craft an impressive array of cocktails, from classic Old Fashioneds to inventive concoctions inspired by local flavors. Whether you\'re in the mood for a refreshing craft beer, a smooth bourbon, or a signature cocktail, the bar offers something to satisfy every palate. Pull up a stool and strike up a conversation with fellow patrons, or cozy up in one of the dimly lit booths and soak in the ambiance with friends and loved ones.</p>\r\n<p>But Outlaw Oasis Saloon is more than just a place to grab a drink; it\'s a destination for entertainment and camaraderie. Live music fills the air on select nights, with talented musicians taking the stage to serenade guests with toe-tapping tunes that span genres from country and blues to folk and rock. From lively hoedowns to intimate acoustic sets, there\'s always something happening at Outlaw Oasis Saloon to keep you entertained late into the night.</p>\r\n<p>And let\'s not forget about the food. The saloon boasts a mouthwatering menu of hearty comfort fare, with dishes ranging from savory barbecue ribs and juicy burgers to crispy fried chicken and cheesy loaded nachos. Whether you\'re craving a hearty meal to fuel your night or just a satisfying snack to accompany your drinks, the kitchen at Outlaw Oasis Saloon has you covered.</p>\r\n<p>In a world that\'s constantly changing, Outlaw Oasis Saloon remains a timeless haven where friends gather, stories are shared, and memories are made. So saddle up and mosey on down to this hidden gem in the heart of Jacknovilla – because at Outlaw Oasis Saloon, every visit is an adventure worth savoring.</p>', 'Outlaw Oasis Saloon 556 Rustic Road Rustic Ravine, Jacknovilla, Florida Zip Code: 33221', NULL, NULL, NULL, '2024-05-07 20:48:37', '2025-01-18 22:07:59', 'Outlaw Oasis Saloon is a haven of bold flavors and lively vibes, blending the rugged spirit of the Old West with modern flair. Savor craft cocktails, delicious comfort food, and live entertainment in a welcoming atmosphere. Whether you\'re seeking adventure or relaxation, Outlaw Oasis Saloon offers an unforgettable escape into a world of charm and excitement.'),
(28, 21, 14, 2, 11, 8, 12, 'صالون واحة الخارجة عن القانون', 'صالون-واحة-الخارجة-عن-القانون', '[\"16\"]', '<p>تقع صالون واوتلو أوازيس في قلب روستيك رافين في جاكنوفيلا، فلوريدا، وتعتبر معلماً يشع بسحره الريفي وسحره الجذاب. فور دخولك لهذا المكان الفريد تشعر وكأنك تعيش رحلة عبر الزمن، حيث يعكس صدى الغرب البري كل زاوية من زواياه. تمتلك صالون واوتلو أوازيس واجهة خشبية متهالكة تتميز بأبوابها المتأرجحة، ما يضفي عليها جاذبية فريدة تجذب المسافرين والسكان المحليين على حد سواء لاستكشاف ما بداخلها وتجربة جوها الفريد.</p>\r\n<p>عندما تدفع بأبوابها المتأرجحة، تستقبلك أجواء دافئة مضاءة بضوء الفانوس وصوت الحديث المليء بالحيوية. تأخذك الديكورات الداخلية في رحلة عبر العصور، مع أعمدة الخشب القديمة والتحف العتيقة والديكورات الريفية التي تُكرم صالونات الماضي. يملأ رائحة البلوط العتيق والطعام الشهي الهواء، محفزًا حواسك وخلق المشهد المثالي لتجربة لا تُنسى.</p>\r\n<p>في قلب صالون واوتلو أوازيس يوجد البار النابض بالحياة، حيث يقوم المشروبين الخبراء بتحضير مجموعة مذهلة من الكوكتيلات، بدءًا من الكلاسيكية مثل الأولد فاشند وحتى المزيجات الاختراعية المستوحاة من النكهات المحلية. سواء كنت تبحث عن بيرة مُنعشة، أو بوربون ناعم، أو كوكتيل مميز، يقدم البار شيئًا لتلبية كل ذوق. جلس وتحدث مع زملائك، أو استرخ في إحدى الكشكات المظلمة واستمتع بالأجواء مع الأصدقاء والأحباء.</p>\r\n<p>لكن صالون واوتلو أوازيس ليس مجرد مكان لتناول المشروبات؛ بل هو وجهة للترفيه والتآلف. تملأ الموسيقى الحية الهواء في الليالي المختارة، حيث يستولي الموسيقيون الموهوبون على المسرح ليحيوا الضيوف بألحان تجعل قلوبهم ترقص، تتراوح من الموسيقى الكانتري والبلوز إلى الموسيقى الفولكلورية والروك. من الحفلات الصاخبة إلى العروض الصوتية الحميمة، دائماً ما يحدث شيء مثير في صالون واوتلو أوازيس ليُسليك حتى وقت متأخر من الليل.</p>\r\n<p>ولا ننسى الطعام. يتميز الصالون بقائمة طعام شهية من الأطباق الريفية اللذيذة، بدءًا من ضلوع اللحم المشوية والبرجر اللذيذ إلى الدجاج المقلي المقرمش والناتشوز المحملة بالجبن. سواء كنت تتوق إلى وجبة دسمة لتمد طاقتك خلال الليل أو مجرد وجبة خفيفة لترافق مشروبك، يضمن المطبخ في صالون واوتلو أوازيس تلبية كل رغباتك.</p>\r\n<p>في عالم متغير باستمرار، يبقى صالون واوتلو أوازيس ملاذًا زمنيًا حيث يجتمع الأصدقاء، ويتبادلون القصص، ويخلقون الذكريات. فانطلق وانضم إلى هذا الجوهرة الخفية في قلب جاكنوفيلا، لأن في صالون واوتلو أوازيس، كل زيارة هي مغامرة تستحق الاستمتاع بها.</p>', 'صالون واحة الخارجة عن القانون 556 طريق ريفي، وادي ريفي، جاكنوفيلا، فلوريدا الرمز البريدي: 33221', NULL, NULL, NULL, '2024-05-07 20:48:37', '2025-01-18 22:07:59', 'صالون أوتلو أواسيز هو واحة من النكهات الجريئة والأجواء الحيوية، حيث يلتقي طابع الغرب القديم مع اللمسات العصرية. استمتع بالمشروبات الحرفية، والطعام المريح اللذيذ، والعروض الحية في أجواء ترحيبية. سواء كنت تبحث عن المغامرة أو الاسترخاء، يقدم صالون أوتلو أواسيز تجربة لا تُنسى مليئة بالسحر والإثارة.'),
(29, 20, 15, 3, 6, NULL, 13, 'Evergreen Hospital', 'evergreen-hospital', '[\"8\",\"10\",\"12\",\"14\",\"15\",\"17\"]', '<p>Evergreen Memorial Hospital stands as a beacon of compassionate care and medical excellence in the heart of Rajshahi, Bangladesh. Nestled on the picturesque Green Avenue in the bustling Lalbagh district, our hospital is dedicated to serving the diverse healthcare needs of our community with unwavering commitment and professionalism.</p>\r\n<p>At Evergreen Memorial Hospital, we pride ourselves on delivering a comprehensive range of medical services tailored to meet the needs of patients across all age groups. From routine check-ups to advanced surgical procedures, our team of highly skilled healthcare professionals is equipped with the latest medical technologies and expertise to provide top-notch care.</p>\r\n<p>Our services encompass a wide spectrum of specialties, including internal medicine, pediatrics, obstetrics and gynecology, orthopedics, cardiology, neurology, and more. Whether you require emergency medical attention or long-term management of chronic conditions, our hospital is equipped to handle it all with precision and compassion.</p>\r\n<p>Patients at Evergreen Memorial Hospital benefit from personalized treatment plans designed to address their unique health concerns and goals. Our multidisciplinary approach ensures that every aspect of their well-being is taken into consideration, fostering optimal outcomes and patient satisfaction.</p>\r\n<p>In addition to our clinical services, Evergreen Memorial Hospital is committed to promoting community health and wellness through various outreach programs and educational initiatives. We believe in empowering individuals with the knowledge and resources they need to lead healthier lives, thus contributing to the overall well-being of our society.</p>\r\n<p>At Evergreen Memorial Hospital, we understand that healthcare goes beyond just treating illnesses; it\'s about restoring hope, dignity, and quality of life. With a steadfast commitment to excellence and a compassionate approach to care, we strive to be the trusted healthcare partner for generations to come.</p>', 'Evergreen Memorial Hospital 45 Green Avenue, Lalbagh, Rajshahi-6000, Bangladesh.', NULL, NULL, NULL, '2024-05-08 02:46:04', '2025-01-18 22:08:34', 'Evergreen Hospital is dedicated to providing exceptional healthcare with compassion and expertise. Equipped with advanced medical technology and staffed by skilled professionals, we offer a wide range of services to meet your health needs. From routine check-ups to specialized treatments, Evergreen Hospital ensures quality care in a supportive and healing environment.'),
(30, 21, 15, 4, 9, NULL, 8, 'مستشفىين التذكاري', 'مستشفىين-التذكاري', '[\"6\",\"9\",\"11\",\"18\",\"20\"]', '<p>يعد مستشفى إيفرجرين التذكاري منارة للرعاية الرحيمة والتميز الطبي في قلب راجشاهي، بنغلاديش. يقع مستشفانا في الجادة الخضراء الخلابة في منطقة لالباغ الصاخبة، وهو مكرس لخدمة احتياجات الرعاية الصحية المتنوعة لمجتمعنا بالتزام واحترافية لا يتزعزعان.</p>\r\n<p>في مستشفى إيفرجرين التذكاري، نحن نفخر بتقديم مجموعة شاملة من الخدمات الطبية المصممة لتلبية احتياجات المرضى في جميع الفئات العمرية. بدءًا من الفحوصات الروتينية وحتى العمليات الجراحية المتقدمة، تم تجهيز فريقنا من المتخصصين في الرعاية الصحية ذوي المهارات العالية بأحدث التقنيات والخبرات الطبية لتقديم رعاية من الدرجة الأولى.</p>\r\n<p>تشمل خدماتنا مجموعة واسعة من التخصصات، بما في ذلك الطب الباطني، وطب الأطفال، وأمراض النساء والتوليد، وجراحة العظام، وأمراض القلب، وأمراض الأعصاب، والمزيد. سواء كنت بحاجة إلى رعاية طبية طارئة أو إدارة طويلة الأمد لحالات مزمنة، فإن مستشفانا مجهز للتعامل مع كل ذلك بدقة وتعاطف.</p>\r\n<p>يستفيد المرضى في مستشفى Evergreen Memorial من خطط العلاج الشخصية المصممة لمعالجة اهتماماتهم وأهدافهم الصحية الفريدة. يضمن نهجنا متعدد التخصصات أن يتم أخذ كل جانب من جوانب رفاهيتهم في الاعتبار، مما يعزز النتائج المثلى ورضا المرضى.</p>\r\n<p>بالإضافة إلى خدماتنا السريرية، يلتزم مستشفى Evergreen Memorial بتعزيز صحة المجتمع وعافيته من خلال برامج التوعية والمبادرات التعليمية المختلفة. نحن نؤمن بتمكين الأفراد بالمعرفة والموارد التي يحتاجونها ليعيشوا حياة أكثر صحة، وبالتالي المساهمة في الرفاهية العامة لمجتمعنا.</p>\r\n<p>في مستشفى إيفرجرين ميموريال، ندرك أن الرعاية الصحية تتجاوز مجرد علاج الأمراض؛ يتعلق الأمر باستعادة الأمل والكرامة ونوعية الحياة. من خلال الالتزام الثابت بالتميز ونهج الرعاية الرحيم، فإننا نسعى جاهدين لنكون شريك الرعاية الصحية الموثوق به للأجيال القادمة.</p>', 'مستشفى إيفرجرين التذكاري 45 جرين أفينيو، لالباغ، راجشاهي-6000، بنغلاديش.', NULL, NULL, NULL, '2024-05-08 02:46:04', '2025-01-18 22:08:34', 'مستشفى إيفرجرين ملتزم بتقديم رعاية صحية استثنائية بمزيج من التعاطف والخبرة. مجهز بأحدث التقنيات الطبية ويضم فريقًا من المحترفين المهرة، نوفر مجموعة واسعة من الخدمات لتلبية احتياجاتك الصحية. من الفحوصات الروتينية إلى العلاجات المتخصصة، يضمن مستشفى إيفرجرين رعاية عالية الجودة في بيئة داعمة وشفائية.'),
(33, 20, 17, 3, 2, 1, 1, 'Popular Special Hospital', 'popular-special-hospital', '[\"1\",\"3\"]', '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', 'sddsds,dsds,,dsds, dsdsd', NULL, NULL, NULL, '2025-10-29 04:38:48', '2025-11-03 06:03:44', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
(34, 21, 17, 4, 3, 2, 2, 'مستشفى شعبي خاص', 'مستشفى-شعبي-خاص', '[\"2\",\"4\"]', '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', 'sddsds,dsds,,dsds, dsdsd', NULL, NULL, NULL, '2025-10-29 04:38:48', '2025-11-03 06:02:50', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
(35, 20, 18, 13, 10, 5, 15, 'The Aetherium Gallery', 'the-aetherium-gallery', '[\"1\",\"3\",\"5\",\"8\",\"10\",\"12\"]', '<ul>\r\n<li>\r\n<p class=\"ds-markdown-paragraph\">A prestigious contemporary art gallery in the heart of Manhattan, showcasing groundbreaking works from established and emerging international artists.</p>\r\n</li>\r\n<li>\r\n<p class=\"ds-markdown-paragraph\"><strong>Description:</strong> The Aetherium Gallery is a cornerstone of New York\'s modern art scene. Housed in a sleek, architecturally significant building on Manhattan\'s Upper East Side, we provide a serene and inspiring environment to experience art. Our curated exhibitions rotate quarterly, featuring a diverse range of media including painting, sculpture, digital installations, and mixed media. The Aetherium is dedicated to fostering dialogue and connecting art lovers with the pulse of contemporary culture. We also offer private viewings, artist talks, and consultancy services for collectors.</p>\r\n</li>\r\n</ul>', '945 Madison Ave, san diego, California, USA', 'Obcaecati aliqua Do', 'Ullamco aliqua Qui', NULL, '2025-11-03 06:24:56', '2025-11-03 06:24:56', 'A prestigious contemporary art gallery in the heart of Manhattan, showcasing groundbreaking works from established and emerging international artists'),
(36, 21, 18, 4, 9, NULL, 8, 'معرض الأثيريوم', 'معرض-الأثيريوم', '[\"4\",\"6\",\"9\"]', '<p>معرض فني معاصر مرموق في قلب مانهاتن، يعرض أعمالًا فنية رائدة لفنانين عالميين مخضرمين وناشئين.</p>\r\n<p>الوصف: يُعد معرض إيثيريوم ركنًا أساسيًا في المشهد الفني الحديث في نيويورك. يقع في مبنى أنيق ذي طابع معماري مميز في الجانب الشرقي العلوي من مانهاتن، ويوفر بيئة هادئة وملهمة لتجربة فنية. تُقام معارضنا المُنسقة فصليًا، وتضم مجموعة متنوعة من الوسائط الفنية، بما في ذلك الرسم والنحت والتركيبات الرقمية والوسائط المتعددة. يكرس إيثيريوم جهوده لتعزيز الحوار وربط محبي الفن بنبض الثقافة المعاصرة. كما نقدم عروضًا خاصة، ومحاضرات فنية، وخدمات استشارية لهواة جمع الأعمال الفنية.</p>', '945 شارع ماديسون، نيويورك، نيويورك 10021، الولايات المتحدة الأمريكية', 'Obcaecati aliqua Do', NULL, NULL, '2025-11-03 06:24:56', '2025-11-03 06:24:56', 'معرض فني معاصر مرموق في قلب مانهاتن، يعرض أعمالًا رائدة لفنانين عالميين راسخين وناشئين');

-- --------------------------------------------------------

--
-- Table structure for table `listing_faqs`
--

CREATE TABLE `listing_faqs` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `language_id` bigint DEFAULT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `serial_number` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_faqs`
--

INSERT INTO `listing_faqs` (`id`, `listing_id`, `language_id`, `question`, `answer`, `serial_number`, `created_at`, `updated_at`) VALUES
(1, 1, 20, 'What are your salon\'s safety protocols in light of COVID-19?', 'This question addresses concerns about hygiene and safety measures implemented by the salon to protect customers and staff.', 1, '2024-05-01 21:51:22', '2026-04-07 05:06:34'),
(2, 1, 20, 'How do I book an appointment?', 'This addresses the process for scheduling appointments, whether it\'s done online, over the phone, or in person.', 2, '2024-05-01 21:51:50', '2024-05-01 21:51:50'),
(3, 1, 20, 'What should I expect during my first visit to your salon?', 'This helps new customers understand what to anticipate, such as consultations, services offered, and the overall experience.', 3, '2024-05-01 21:52:12', '2024-05-01 21:52:12'),
(4, 1, 20, 'Do you offer consultations before appointments?', 'Some clients may want to discuss their desired hairstyle or treatment beforehand, so they\'ll inquire about consultation services.', 4, '2024-05-01 21:52:37', '2024-05-01 21:52:37'),
(5, 1, 20, 'What haircare products do you recommend for my hair type?', 'This question is common among clients seeking advice on maintaining their hairstyle or color between salon visits.', 5, '2024-05-01 21:53:05', '2024-05-01 21:53:05'),
(6, 1, 20, 'How long will my appointment take?', 'Clients often want to plan their day around salon appointments, so they\'ll ask about the expected duration of their visit.', 6, '2024-05-01 21:53:26', '2024-05-01 21:53:26'),
(7, 1, 20, 'What is your cancellation policy?', 'It\'s important for clients to understand the salon\'s policy regarding cancellations, including any fees or notice requirements.', 7, '2024-05-01 21:53:47', '2024-05-01 21:53:47'),
(8, 1, 20, 'Do you offer any special promotions or loyalty programs?', 'Clients may inquire about discounts, promotions, or loyalty rewards to make their salon visits more cost-effective.', 8, '2024-05-01 21:54:10', '2024-05-01 21:54:10'),
(9, 1, 21, 'ما هي إجراءات السلامة الخاصة بصالونكم في ظل جائحة كوفيد-١٩؟', 'هذا السؤال يتعلق بالاهتمام بالنظافة والإجراءات الأمنية التي يتم تنفيذها في الصالون لحماية العملاء والموظفين.', 1, '2024-05-01 22:07:02', '2024-05-01 22:07:02'),
(10, 1, 21, 'كيف يمكنني حجز موعد؟', 'يتعلق هذا بعملية تحديد المواعيد، سواء كانت عبر الإنترنت، أو عبر الهاتف، أو شخصياً.', 2, '2024-05-01 22:07:30', '2024-05-01 22:07:30'),
(11, 1, 21, 'ما الذي يجب أن أتوقعه خلال زيارتي الأولى إلى صالونكم؟', 'يساعد هذا السؤال العملاء الجدد على فهم ما يمكن توقعه، مثل الاستشارات، والخدمات المقدمة، والتجربة العامة.', 3, '2024-05-01 22:08:00', '2024-05-01 22:08:00'),
(12, 1, 21, 'هل تقدمون استشارات قبل المواعيد؟', 'قد يرغب بعض العملاء في مناقشة القصة أو العلاج المرغوب قبل الحجز، لذلك سيسألون عن خدمات الاستشارة.', 4, '2024-05-01 22:08:25', '2024-05-01 22:08:25'),
(13, 1, 21, 'ما هي المنتجات المناسبة لنوع شعري؟', 'هذا السؤال شائع بين العملاء الذين يبحثون عن نصائح للحفاظ على قصة شعرهم أو لونهم بين الزيارات للصالون.', 5, '2024-05-01 22:08:56', '2024-05-01 22:08:56'),
(14, 1, 21, 'كم سيستغرق موعدي؟', 'يرغب العملاء غالبًا في تنظيم يومهم حول المواعيد في الصالون، لذا سيسألون عن المدة المتوقعة لزيارتهم.', 6, '2024-05-01 22:09:19', '2024-05-01 22:09:19'),
(15, 1, 21, 'ما هي سياسة الإلغاء لديكم؟', 'من المهم أن يفهم العملاء سياسة الصالون المتعلقة بالإلغاء، بما في ذلك أية رسوم أو متطلبات للإشعار.', 7, '2024-05-01 22:09:42', '2024-05-01 22:09:42'),
(16, 1, 21, 'هل تقدمون عروضًا خاصة أو برامج وفاء؟', 'قد يسأل العملاء عن الخصومات، والعروض، أو برامج الولاء لجعل زياراتهم للصالون أكثر كفاءة مالية.', 8, '2024-05-01 22:11:36', '2024-05-01 22:11:36'),
(31, 3, 20, 'How do I book a trip with Dreamscapes Travel Agency?', 'To book a trip with Dreamscapes, simply contact us through our website, email, or phone. Our experienced travel advisors will guide you through the process and assist you in creating a personalized itinerary tailored to your preferences.', 1, '2024-05-01 23:36:21', '2024-05-01 23:36:21'),
(32, 3, 20, 'What types of destinations does Dreamscapes offer?', 'Dreamscapes offers a wide range of destinations, including exotic beach getaways, adventurous wilderness expeditions, cultural explorations, urban escapes, and luxury retreats. Whether you\'re craving relaxation, adventure, or cultural immersion, we have the perfect destination for you.', 2, '2024-05-01 23:36:45', '2024-05-01 23:36:45'),
(33, 3, 20, 'Are the itineraries customizable?', 'Yes, absolutely! At Dreamscapes, we believe in the power of personalized travel. Our experienced travel advisors will work closely with you to understand your interests, preferences, and budget, and tailor your itinerary accordingly to ensure it meets your specific needs and desires.', 3, '2024-05-01 23:37:06', '2024-05-01 23:37:06'),
(34, 3, 20, 'Does Dreamscapes provide travel insurance?', 'While Dreamscapes does not directly provide travel insurance, our experienced travel advisors can assist you in selecting and purchasing a suitable travel insurance policy from reputable providers. We strongly recommend purchasing travel insurance to protect yourself against unforeseen events or emergencies during your trip.', 4, '2024-05-01 23:37:30', '2024-05-01 23:37:30'),
(35, 3, 20, 'What safety measures does Dreamscapes have in place for travelers?', 'The safety and well-being of our clients are our top priorities. Dreamscapes closely monitors travel advisories and updates from relevant authorities to ensure the safety of our travelers. We provide up-to-date information on health and safety protocols, travel restrictions, and entry requirements for each destination.', 5, '2024-05-01 23:37:53', '2024-05-01 23:37:53'),
(36, 3, 20, 'Can Dreamscapes assist with special requests or accommodations?', 'Absolutely! Whether you require special dietary accommodations, accessibility assistance, or specific room preferences, our dedicated travel advisors are here to accommodate your needs and ensure that your trip is comfortable and hassle-free.', 6, '2024-05-01 23:38:19', '2024-05-01 23:38:19'),
(37, 3, 20, 'What happens if I need to cancel or modify my trip?', 'In the event that you need to cancel or modify your trip, please contact us as soon as possible. Our flexible cancellation and modification policies vary depending on the terms and conditions of your booking, but we will do our best to accommodate your needs and minimize any associated fees or penalties.', 7, '2024-05-01 23:38:41', '2024-05-01 23:38:41'),
(38, 3, 20, 'Does Dreamscapes offer group travel options?', 'Yes, Dreamscapes offers group travel options for families, friends, corporate groups, and special interest groups. Whether you\'re planning a family reunion, a destination wedding, a corporate retreat, or a group tour, our experienced team can customize an itinerary to suit your group\'s needs and interests.', 8, '2024-05-01 23:39:02', '2024-05-01 23:39:02'),
(39, 3, 21, 'كيف يمكنني حجز رحلة مع وكالة ديمسكيبس للسفر؟', 'لحجز رحلة مع ديمسكيبس، ما عليك سوى الاتصال بنا عبر موقعنا الإلكتروني، البريد الإلكتروني، أو الهاتف. سيقوم مستشارو السفر ذوي الخبرة لدينا بإرشادك خلال العملية ومساعدتك في إنشاء جدول سفر مخصص يتماشى مع تفضيلاتك.', 1, '2024-05-01 23:40:15', '2024-05-01 23:40:15'),
(40, 3, 21, 'ما هي أنواع الوجهات التي تقدمها ديمسكيبس؟', 'تقدم ديمسكيبس مجموعة متنوعة من الوجهات، بما في ذلك رحلات الاسترخاء على الشواطئ الاستوائية، ورحلات المغامرة في البراري الوعرة، والرحلات الثقافية، والهروب الحضري، والمنتجعات الفاخرة. سواء كنت تتوق إلى الاسترخاء، أو المغامرة، أو التمتع بالثقافة، فلدينا الوجهة المثالية لك.', 2, '2024-05-01 23:41:01', '2024-05-01 23:41:01'),
(41, 3, 21, 'هل يمكن تخصيص جداول السفر؟', 'نعم، بالتأكيد! في ديمسكيبس، نؤمن بقوة السفر المخصص. سيعمل مستشارو السفر ذوو الخبرة لدينا بشكل وثيق معك لفهم اهتماماتك وتفضيلاتك وميزانيتك، وضبط جدول السفر الخاص بك وفقًا لذلك لضمان تلبية احتياجاتك ورغباتك الخاصة.', 3, '2024-05-01 23:41:31', '2024-05-01 23:41:31'),
(42, 3, 21, 'هل تقدم ديمسكيبس تأمين السفر؟', 'بالرغم من أن ديمسكيبس لا تقدم مباشرة تأمين السفر، إلا أن مستشاري السفر ذوي الخبرة لدينا يمكنهم مساعدتك في اختيار وشراء وثيقة تأمين سفر من مزودي خدمات موثوق بهم. نوصي بشدة بشراء تأمين السفر لحماية نفسك من الأحداث غير المتوقعة أو الطوارئ خلال رحلتك.', 4, '2024-05-01 23:41:57', '2024-05-01 23:41:57'),
(43, 3, 21, 'ما الإجراءات الأمنية التي تتخذها ديمسكيبس للمسافرين؟', 'السلامة وراحة عملائنا هما أولويتنا القصوى. يراقب ديمسكيبس بعناية الإرشادات السفرية والتحديثات من السلطات المختصة لضمان سلامة مسافرينا. نوفر معلومات محدثة عن البروتوكولات الصحية والسلامة،', 5, '2024-05-01 23:47:54', '2024-05-01 23:47:54'),
(44, 3, 21, 'هل يمكن لديمسكيبس مساعدتي في طلبات أو احتياجات خاصة؟', 'بالتأكيد! سواء كنت بحاجة إلى تلبية احتياجات غذائية خاصة، أو مساعدة في الوصول، أو تفضيلات غرف محددة، فإن مستشاري السفر المخصصين لدينا هنا لتلبية احتياجاتك وضمان أن رحلتك مريحة وخالية من المتاعب.', 6, '2024-05-01 23:48:25', '2024-05-01 23:48:25'),
(45, 3, 21, 'ماذا يحدث إذا كان لي الحاجة لإلغاء أو تعديل رحلتي؟', 'في حالة الحاجة إلى إلغاء أو تعديل رحلتك، يرجى الاتصال بنا في أقرب وقت ممكن. تختلف سياسات الإلغاء والتعديل لدينا اعتمادًا على الشروط والأحكام المتعلقة بحجزك، ولكننا سنبذل قصارى جهدنا لتلبية احتياجاتك وتقليل أي رسوم أو عقوبات مرتبطة بها.', 7, '2024-05-01 23:49:03', '2024-05-01 23:49:03'),
(46, 3, 21, 'هل تقدم ديمسكيبس خيارات السفر الجماعي؟', 'نعم، تقدم ديمسكيبس خيارات السفر الجماعي للعائلات والأصدقاء والم', 8, '2024-05-01 23:49:30', '2024-05-01 23:49:30'),
(47, 4, 20, 'Is parking available at Tranquil Haven Hotel?', 'Yes, the hotel offers complimentary parking facilities for guests, including both self-parking and valet services.', 1, '2024-05-02 02:45:46', '2024-05-02 02:45:46'),
(49, 4, 20, 'Does Tranquil Haven Hotel offer airport shuttle service?', 'Yes, the hotel provides airport shuttle services for guests\' convenience. Please contact the concierge desk to arrange transportation.', 2, '2024-05-02 02:46:47', '2024-05-02 02:46:47'),
(50, 4, 20, 'Are pets allowed at Tranquil Haven Hotel?', 'Yes, Tranquil Haven Hotel is pet-friendly. Guests are welcome to bring their furry companions along for the stay. Additional charges or restrictions may apply.', 3, '2024-05-02 02:50:11', '2024-05-02 02:50:11'),
(51, 4, 20, 'What dining options are available at Tranquil Haven Hotel?', 'The hotel features a fine dining restaurant serving a diverse menu of local and international cuisine, as well as a casual cafe or lounge for light bites and beverages.', 4, '2024-05-02 02:50:36', '2024-05-02 02:50:36'),
(52, 4, 20, 'Does Tranquil Haven Hotel have a spa and wellness center?', 'Yes, the hotel offers a tranquil spa and wellness center where guests can indulge in massage therapies, body treatments, yoga sessions, and more.', 5, '2024-05-02 02:51:03', '2024-05-02 02:51:03'),
(53, 4, 20, 'Are there any recreational activities available at Tranquil Haven Hotel?', 'Yes, guests can enjoy a variety of recreational amenities including an outdoor swimming pool, fitness center, and opportunities for water sports such as swimming, surfing, and beach volleyball.', 6, '2024-05-02 02:52:00', '2024-05-02 02:52:00'),
(54, 4, 20, 'What types of events can be hosted at Tranquil Haven Hotel?', 'The hotel offers event spaces suitable for weddings, conferences, meetings, and other special occasions. Catering services and audiovisual equipment are available upon request.', 7, '2024-05-02 02:52:29', '2024-05-02 02:52:29'),
(55, 4, 20, 'Does Tranquil Haven Hotel offer special packages or deals for guests?', 'Yes, the hotel often has special packages and promotions available for guests, including honeymoon packages, spa retreats, and seasonal offers. Be sure to check the hotel\'s website or contact reservations for more information.', 8, '2024-05-02 02:52:52', '2024-05-02 02:52:52'),
(56, 4, 21, 'هل يتوفر موقف للسيارات لدى ترانكويل هافن هوتل؟', 'نعم، يوفّر الفندق مرافق صف السيارات مجانًا للنزلاء، بما في ذلك صف السيارات ذاتيًا وخدمات صف السيارات.', 1, '2024-05-02 02:54:48', '2024-05-02 02:54:48'),
(57, 4, 21, 'هل يوفّر فندق ترانكويل هافن خدمة النقل من وإلى المطار؟', 'نعم، يوفّر الفندق خدمات النقل من وإلى المطار لراحة النزلاء. يرجى الاتصال بمكتب الكونسيرج لترتيب النقل.', 2, '2024-05-02 02:55:41', '2024-05-02 02:55:41'),
(58, 4, 21, 'هل يُسمح بإقامة الحيوانات الأليفة في ترانكويل هافن هوتل؟', 'نعم، فندق ترانكويل هافن يسمح بالحيوانات الأليفة. الضيوف مدعوون لإحضار رفاقهم ذوي الفراء طوال فترة الإقامة. قد يتم تطبيق رسوم أو قيود إضافية.', 3, '2024-05-02 02:56:21', '2024-05-02 02:56:21'),
(59, 4, 21, 'ما خيارات الطعام المتوفرة لدى ترانكويل هافن هوتل؟', 'يضم الفندق مطعمًا فاخرًا يقدم قائمة متنوعة من المأكولات المحلية والعالمية، بالإضافة إلى مقهى غير رسمي أو صالة لتناول الوجبات الخفيفة والمشروبات.', 4, '2024-05-02 02:58:07', '2024-05-02 02:58:07'),
(60, 4, 21, 'هل لدى فندق ترانكويل هافن سبا ومركز صحي؟', 'نعم، يوفر الفندق سبا هادئ ومركزًا صحيًا حيث يمكن للضيوف الاستمتاع بعلاجات التدليك وعلاجات الجسم وجلسات اليوغا والمزيد.', 5, '2024-05-02 02:58:43', '2024-05-02 02:58:43'),
(61, 4, 21, 'هل توجد أي أنشطة ترفيهية متوفرة لدى ترانكويل هافن هوتل؟', 'نعم، يمكن للنزلاء الاستمتاع بمجموعة متنوعة من المرافق الترفيهية بما في ذلك حمام سباحة خارجي ومركز للياقة البدنية وفرص لممارسة الرياضات المائية مثل السباحة وركوب الأمواج وكرة الطائرة الشاطئية.', 6, '2024-05-02 02:59:31', '2024-05-02 02:59:31'),
(62, 4, 21, 'ما هي أنواع الفعاليات التي يمكن استضافتها في فندق ترانكويل هافن؟', 'يوفر الفندق مساحات مناسبة لحفلات الزفاف والمؤتمرات والاجتماعات والمناسبات الخاصة الأخرى. تتوفر خدمات تقديم الطعام والمعدات السمعية والبصرية عند الطلب.', 7, '2024-05-02 03:00:07', '2024-05-02 03:00:07'),
(63, 5, 20, 'What are your opening hours?', 'FeastHaven Restaurant is open from [insert opening hours here] every day of the week.', 1, '2024-05-05 21:16:51', '2024-05-05 21:16:51'),
(64, 5, 20, 'Do you offer vegetarian/vegan options?', 'Yes, we offer a variety of vegetarian and vegan dishes on our menu. Our chefs are happy to accommodate dietary preferences and restrictions.', 2, '2024-05-05 21:17:17', '2024-05-05 21:17:17'),
(65, 5, 20, 'Is reservations required?', 'While reservations are not required, they are recommended, especially during peak hours or for larger groups, to ensure we can accommodate you promptly.', 3, '2024-05-05 21:17:42', '2024-05-05 21:17:42'),
(66, 5, 20, 'Do you cater to special events or private parties?', 'Absolutely! FeastHaven Restaurant offers catering services for special events, parties, and gatherings. Please contact us in advance to discuss your requirements.', 4, '2024-05-05 21:18:05', '2024-05-05 21:18:05'),
(67, 5, 20, 'Is parking available?', 'Yes, we provide parking facilities for our guests. Additionally, valet parking service is available during select hours.', 5, '2024-05-05 21:18:29', '2024-05-05 21:18:29'),
(68, 5, 20, 'Do you have a dress code?', 'While there is no strict dress code, we recommend smart casual attire for a comfortable dining experience.', 6, '2024-05-05 21:18:57', '2024-05-05 21:18:57'),
(69, 5, 20, 'Are gift cards available for purchase?', 'Yes, we offer gift cards that can be purchased in various denominations. They make perfect gifts for friends, family, or colleagues who appreciate great food and dining experiences.', 7, '2024-05-05 21:19:22', '2024-05-05 21:19:22'),
(70, 5, 20, 'Do you accommodate food allergies or intolerances?', 'Absolutely! Please inform your server about any allergies or intolerances, and our chefs will do their best to accommodate your needs and prepare your meal safely.', 8, '2024-05-05 21:19:51', '2024-05-05 21:19:51'),
(71, 5, 21, 'ماهو ساعات العمل لديك؟', 'يفتح مطعم FeastHaven أبوابه اعتبارًا من [أدخل ساعات العمل هنا] طوال أيام الأسبوع.', 1, '2024-05-05 21:16:51', '2024-05-05 21:21:36'),
(72, 5, 21, 'هل تقدمون خيارات نباتية/نباتية؟', 'نعم، نحن نقدم مجموعة متنوعة من الأطباق النباتية والنباتية في قائمتنا. يسعد الطهاة لدينا بتلبية التفضيلات والقيود الغذائية.', 2, '2024-05-05 21:17:17', '2024-05-05 21:24:35'),
(73, 5, 21, 'هل الحجز مطلوب؟', 'على الرغم من أن الحجز ليس مطلوبًا، إلا أنه يوصى به، خاصة خلال ساعات الذروة أو للمجموعات الكبيرة، لضمان قدرتنا على استيعابك على الفور.', 3, '2024-05-05 21:17:42', '2024-05-05 21:24:14'),
(74, 5, 21, 'هل تلبي احتياجات المناسبات الخاصة أو الحفلات الخاصة؟', 'قطعاً! يقدم مطعم  خدمات تقديم الطعام للمناسبات الخاصة والحفلات والتجمعات. يرجى الاتصال بنا مقدما لمناقشة الاحتياجات الخاصة بك.', 4, '2024-05-05 21:18:05', '2024-05-05 21:23:50'),
(75, 5, 21, 'هل تتوفر مواقف للسيارات؟', 'نعم، نحن نوفر مرافق وقوف السيارات لضيوفنا. بالإضافة إلى ذلك، تتوفر خدمة صف السيارات خلال ساعات محددة.', 5, '2024-05-05 21:18:29', '2024-05-05 21:23:21'),
(76, 5, 21, 'هل لديك قواعد اللباس؟', 'على الرغم من عدم وجود قواعد صارمة للملابس، إلا أننا نوصي بارتداء ملابس غير رسمية أنيقة لتجربة تناول طعام مريحة.', 6, '2024-05-05 21:18:57', '2024-05-05 21:22:56'),
(77, 5, 21, 'هل بطاقات الهدايا متاحة للشراء؟', 'نعم، نحن نقدم بطاقات الهدايا التي يمكن شراؤها بفئات مختلفة. إنها تمثل هدايا مثالية للأصدقاء أو العائلة أو الزملاء الذين يقدرون تجارب الطعام وتناول الطعام الرائعة.', 7, '2024-05-05 21:19:22', '2024-05-05 21:22:30'),
(78, 5, 21, 'هل تستوعب الحساسية الغذائية أو عدم تحملها؟', 'قطعاً! يرجى إبلاغ الخادم الخاص بك عن أي حساسية أو عدم تحمل، وسيبذل الطهاة لدينا قصارى جهدهم لتلبية احتياجاتك وإعداد وجبتك بأمان.', 8, '2024-05-05 21:19:51', '2024-05-05 21:22:06'),
(79, 6, 20, 'Do you offer financing options for purchasing vehicles?', 'Yes, we provide various financing options tailored to meet your needs. Our finance specialists can assist you in finding the best solution that fits your budget and preferences.', 1, '2024-05-05 22:09:28', '2024-05-05 22:09:28'),
(80, 6, 20, 'Do you accept trade-ins?', 'Absolutely, we accept trade-ins. Our team will assess your vehicle\'s value and provide a competitive offer, which can be applied towards your new purchase or used as cash.', 2, '2024-05-05 22:09:53', '2024-05-05 22:09:53'),
(81, 6, 20, 'What kind of warranty do your vehicles come with?', 'Our vehicles typically come with manufacturer warranties, and we also offer extended warranty options for additional coverage and peace of mind. Our sales team will provide detailed information about warranty coverage for specific vehicles.', 3, '2024-05-05 22:10:17', '2024-05-05 22:10:17'),
(82, 6, 20, 'Do you offer maintenance services for the vehicles you sell?', 'Yes, we have a state-of-the-art service center staffed with factory-trained technicians who specialize in servicing the types of vehicles we sell. From routine maintenance to complex repairs, we ensure your vehicle receives the highest quality care.', 4, '2024-05-05 22:10:38', '2024-05-05 22:10:38'),
(83, 6, 20, 'Can I schedule a test drive before making a purchase?', 'Of course! We encourage customers to schedule test drives to experience our vehicles firsthand. Simply contact our sales team to arrange a convenient time for your test drive.', 5, '2024-05-05 22:11:04', '2024-05-05 22:11:04'),
(84, 6, 20, 'Do you sell pre-owned vehicles as well?', 'Yes, we offer a selection of pre-owned vehicles that undergo thorough inspections to ensure they meet our quality standards. Each pre-owned vehicle comes with a detailed history report for transparency.', 6, '2024-05-05 22:11:26', '2024-05-05 22:11:26'),
(85, 6, 20, 'Can I customize or order a specific vehicle with certain features?', 'Depending on availability and manufacturer options, we may be able to customize or special order a vehicle to your specifications. Our sales team can provide more information about customization options and lead times.', 7, '2024-05-05 22:11:47', '2024-05-05 22:11:47'),
(86, 6, 20, 'What sets Precision Performance Motors apart from other dealerships?', 'At Precision Performance Motors, we prioritize customer satisfaction and offer a comprehensive range of services, including a premium vehicle selection, exceptional customer service, state-of-the-art service center, and more. Our commitment to excellence and passion for automobiles set us apart as a premier destination for automotive enthusiasts.', 8, '2024-05-05 22:12:10', '2024-05-05 22:12:10'),
(87, 6, 21, 'هل تقدمون خيارات تمويل لشراء المركبات؟', 'نعم، نحن نقدم خيارات تمويل متنوعة مصممة خصيصًا لتلبية احتياجاتك. يمكن للمتخصصين الماليين لدينا مساعدتك في العثور على أفضل الحلول التي تناسب ميزانيتك وتفضيلاتك.', 1, '2024-05-05 22:09:28', '2024-05-05 22:17:02'),
(88, 6, 21, 'هل تقبلون المقايضة؟', 'بالتأكيد، نحن نقبل المقايضة. سيقوم فريقنا بتقييم قيمة سيارتك وتقديم عرض تنافسي، والذي يمكن تطبيقه على عملية الشراء الجديدة أو استخدامه نقدًا.', 2, '2024-05-05 22:09:53', '2024-05-05 22:16:40'),
(89, 6, 21, 'ما هو نوع الضمان الذي تأتي به مركباتك؟', 'تأتي سياراتنا عادةً مع ضمانات الشركة المصنعة، كما نقدم أيضًا خيارات ضمان ممتدة لتغطية إضافية وراحة البال. سيقدم فريق المبيعات لدينا معلومات مفصلة حول تغطية الضمان لمركبات محددة.', 3, '2024-05-05 22:10:17', '2024-05-05 22:16:06'),
(90, 6, 21, 'هل تقدمون خدمات صيانة للمركبات التي تبيعونها؟', 'نعم، لدينا مركز خدمة متطور مزود بفنيين مدربين في المصنع ومتخصصين في خدمة أنواع المركبات التي نبيعها. بدءًا من الصيانة الروتينية وحتى الإصلاحات المعقدة، نضمن حصول سيارتك على أعلى مستوى من الرعاية.', 4, '2024-05-05 22:10:38', '2024-05-05 22:15:42'),
(91, 6, 21, 'هل يمكنني تحديد موعد لتجربة القيادة قبل إجراء عملية الشراء؟', 'بالطبع! نحن نشجع العملاء على تحديد موعد لاختبار القيادة لتجربة سياراتنا بشكل مباشر. ما عليك سوى الاتصال بفريق المبيعات لدينا لترتيب وقت مناسب لاختبار القيادة الخاص بك.', 5, '2024-05-05 22:11:04', '2024-05-05 22:15:19'),
(92, 6, 21, 'هل تبيعون المركبات المستعملة أيضًا؟', 'نعم، نحن نقدم مجموعة مختارة من السيارات المستعملة التي تخضع لفحوصات شاملة للتأكد من أنها تلبي معايير الجودة لدينا. تأتي كل مركبة مملوكة مسبقًا مع تقرير تاريخي مفصل من أجل الشفافية.', 6, '2024-05-05 22:11:26', '2024-05-05 22:14:33'),
(93, 6, 21, 'هل يمكنني تخصيص أو طلب سيارة معينة بميزات معينة؟', 'اعتمادًا على التوفر وخيارات الشركة المصنعة، قد نتمكن من تخصيص السيارة أو طلبها بشكل خاص وفقًا لمواصفاتك. يمكن لفريق المبيعات لدينا تقديم المزيد من المعلومات حول خيارات التخصيص والمهل الزمنية.', 7, '2024-05-05 22:11:47', '2024-05-05 22:14:56'),
(94, 6, 21, 'ما الذي يميز شركة محركات الأداء الدقيقةعن الوكلاء الآخرين؟', 'في شركة ، نعطي الأولوية لرضا العملاء ونقدم مجموعة شاملة من الخدمات، بما في ذلك اختيار السيارات المتميزة وخدمة العملاء الاستثنائية ومركز الخدمة المتطور والمزيد. إن التزامنا بالتميز والشغف بالسيارات يميزنا كوجهة رائدة لعشاق السيارات.', 8, '2024-05-05 22:12:10', '2024-05-05 22:14:08'),
(95, 7, 20, 'What types of residences are available at Blue Sky Estates?', 'Blue Sky Estates offers a variety of luxurious residences including spacious apartments, elegant condominiums, and waterfront villas, each designed to exceed the expectations of discerning residents.', 1, '2024-05-05 23:25:16', '2024-05-05 23:25:16'),
(96, 7, 20, 'Are pets allowed at Blue Sky Estates?', 'Yes, Blue Sky Estates is a pet-friendly community. We welcome residents to bring their furry companions and provide amenities such as a designated dog park and pet washing station for their convenience.', 2, '2024-05-05 23:25:39', '2024-05-05 23:25:39'),
(97, 7, 20, 'What amenities are included for residents?', 'Residents of Blue Sky Estates enjoy access to a wide range of world-class amenities including a riverside infinity pool, fully-equipped fitness center, elegant clubhouse, landscaped gardens, and more.', 3, '2024-05-05 23:26:00', '2024-05-05 23:26:00'),
(98, 7, 20, 'Is there on-site parking available for residents and guests?', 'Yes, Blue Sky Estates offers convenient on-site parking options including reserved parking spaces for residents and valet parking services for guests.', 4, '2024-05-05 23:26:20', '2024-05-05 23:26:20'),
(99, 7, 20, 'How does Blue Sky Estates prioritize safety and security?', 'The safety and security of our residents are paramount. Blue Sky Estates features gated access, 24/7 security surveillance, and on-site management to ensure a secure living environment for all.', 5, '2024-05-05 23:26:39', '2024-05-05 23:26:39'),
(100, 7, 20, 'What recreational activities are available for residents?', 'Residents of Blue Sky Estates have access to a variety of recreational activities including water sports on the St. Johns River, walking trails, community events, and social gatherings organized by our dedicated team.', 6, '2024-05-05 23:27:02', '2024-05-05 23:27:02'),
(101, 7, 20, 'Is Blue Sky Estates conveniently located near shopping and dining destinations?', 'Yes, Blue Sky Estates is situated in close proximity to premier shopping centers, fine dining restaurants, entertainment venues, and cultural attractions, providing residents with easy access to everything Jacksonville has to offer.', 7, '2024-05-05 23:27:25', '2024-05-05 23:27:25'),
(102, 7, 20, 'Does Blue Sky Estates offer concierge services for residents?', 'Yes, Blue Sky Estates provides personalized concierge services to assist residents with various tasks including package delivery, dry cleaning, restaurant reservations, and more.', 8, '2024-05-05 23:27:56', '2024-05-05 23:27:56'),
(103, 7, 21, 'ما هي أنواع المساكن المتوفرة في بلو سكاي إستيتس؟', 'تقدم بلو سكاي إستيتس مجموعة متنوعة من المساكن الفاخرة بما في ذلك الشقق الفسيحة والوحدات السكنية الأنيقة والفلل ذات الواجهة البحرية، وكل منها مصممة لتتجاوز توقعات السكان المميزين.', 1, '2024-05-05 23:25:16', '2024-05-05 23:33:00'),
(104, 7, 21, 'هل يُسمح بإقامة الحيوانات الأليفة في بلو سكاي إستيتس؟', 'نعم، بلو سكاي إستيتس مجتمع صديق للحيوانات الأليفة. نرحب بالمقيمين لإحضار رفاقهم ذوي الفراء وتوفير وسائل الراحة مثل حديقة مخصصة للكلاب ومحطة لغسيل الحيوانات الأليفة من أجل راحتهم.', 2, '2024-05-05 23:25:39', '2024-05-05 23:32:36'),
(105, 7, 21, 'ما هي وسائل الراحة المتوفرة للمقيمين؟', 'يتمتع المقيمون بإمكانية الوصول إلى مجموعة واسعة من وسائل الراحة ذات المستوى العالمي بما في ذلك مسبح لا متناهي على ضفاف النهر ومركز للياقة البدنية مجهز بالكامل ونادي أنيق وحدائق ذات مناظر طبيعية والمزيد.', 3, '2024-05-05 23:26:00', '2024-05-05 23:32:11'),
(106, 7, 21, 'هل تتوفر مواقف للسيارات في الموقع للمقيمين والضيوف؟', 'نعم، توفر بلو سكاي إستيتس خيارات مريحة لوقوف السيارات داخل الموقع بما في ذلك أماكن ركن السيارات المحجوزة للمقيمين وخدمات صف السيارات للضيوف.', 4, '2024-05-05 23:26:20', '2024-05-05 23:31:43'),
(107, 7, 21, 'كيف يتم تحديد أولويات السلامة والأمن؟', 'سلامة وأمن سكاننا لها أهمية قصوى. يتميز ببوابة دخول ومراقبة أمنية على مدار الساعة طوال أيام الأسبوع وإدارة في الموقع لضمان بيئة معيشية آمنة للجميع.', 5, '2024-05-05 23:26:39', '2024-05-05 23:31:20'),
(108, 7, 21, 'ما هي الأنشطة الترفيهية المتاحة للمقيمين؟', 'يتمتع سك بإمكانية الوصول إلى مجموعة متنوعة من الأنشطة الترفيهية بما في ذلك الرياضات المائية على نهر سانت جونز ومسارات المشي والفعاليات المجتمعية والتجمعات الاجتماعية التي ينظمها فريقنا المتخصص.', 6, '2024-05-05 23:27:02', '2024-05-05 23:30:38'),
(109, 7, 21, 'هل يقع بالقرب من وجهات التسوق وتناول الطعام؟', 'نعم، تقع على مقربة من مراكز التسوق الرائدة والمطاعم الفاخرة وأماكن الترفيه والمعالم الثقافية، مما يوفر للمقيمين سهولة الوصول إلى كل ما تقدمه جاكسونفيل.', 7, '2024-05-05 23:27:25', '2024-05-05 23:30:05'),
(110, 7, 21, 'هل تقدم شركة بلو سكاي إستيتس خدمات الكونسيرج للمقيمين؟', 'نعم، توفر شركة خدمات الكونسيرج الشخصية لمساعدة المقيمين في مختلف المهام بما في ذلك توصيل الطرود والتنظيف الجاف وحجوزات المطاعم والمزيد.', 8, '2024-05-05 23:27:56', '2024-05-05 23:29:27'),
(127, 9, 20, 'What type of cuisine does Wholesome Fare Diner serve?', 'We specialize in authentic Bengali cuisine with a focus on traditional flavors and locally sourced ingredients.', 1, '2024-05-06 20:59:36', '2024-05-06 20:59:36'),
(128, 9, 20, 'Do you offer vegetarian and vegan options?', 'Yes, we have a variety of vegetarian dishes available, and many of our menu items can be modified to accommodate vegan diets upon request.', 2, '2024-05-06 20:59:56', '2024-05-06 20:59:56'),
(129, 9, 20, 'Is there parking available at the restaurant?', 'Yes, we provide convenient parking facilities for our guests, making it easy to dine with us.', 3, '2024-05-06 21:00:18', '2024-05-06 21:00:18'),
(130, 9, 20, 'Do you offer catering services for events and parties?', 'Yes, we offer catering services for a wide range of events, including weddings, corporate gatherings, and private parties. Please contact us for more information and to discuss your specific needs.', 4, '2024-05-06 21:00:41', '2024-05-06 21:00:41'),
(131, 9, 20, 'Are reservations required, or can we walk in?', 'While reservations are not required, especially for smaller groups, we recommend making a reservation for larger parties to ensure we can accommodate you comfortably.', 5, '2024-05-06 21:01:01', '2024-05-06 21:01:01'),
(132, 9, 20, 'Do you have any special offers or promotions?', 'Yes, we regularly run special promotions and discounts. Be sure to follow us on social media or sign up for our newsletter to stay updated on our latest offers.', 6, '2024-05-06 21:01:23', '2024-05-06 21:01:23'),
(133, 9, 20, 'Can I order food for takeaway or delivery?', 'Absolutely! We offer both takeaway and delivery services for your convenience. You can place your order over the phone or through our online ordering platform.', 7, '2024-05-06 21:01:44', '2024-05-06 21:01:44'),
(134, 9, 20, 'Are you open for lunch and dinner?', 'Yes, we are open for both lunch and dinner service. Our operating hours are [insert operating hours here], so feel free to drop by anytime for a delicious meal!', 8, '2024-05-06 21:02:06', '2024-05-06 21:02:06'),
(135, 9, 21, 'ما نوع المطبخ الذي يقدمه مطعم؟', 'نحن متخصصون في المأكولات البنغالية الأصيلة مع التركيز على النكهات التقليدية والمكونات من مصادر محلية.', 1, '2024-05-06 20:59:36', '2024-05-06 21:04:54'),
(136, 9, 21, 'هل تقدمون خيارات نباتية ونباتية؟', 'نعم، لدينا مجموعة متنوعة من الأطباق النباتية المتاحة، ويمكن تعديل العديد من عناصر القائمة لدينا لاستيعاب الأنظمة الغذائية النباتية عند الطلب.', 2, '2024-05-06 20:59:56', '2024-05-06 21:05:19'),
(137, 9, 21, 'هل تتوفر مواقف للسيارات في المطعم؟', 'نعم، نحن نوفر مرافق مريحة لوقوف السيارات لضيوفنا، مما يجعل تناول الطعام معنا أمرًا سهلاً.', 3, '2024-05-06 21:00:18', '2024-05-06 21:05:44'),
(138, 9, 21, 'هل تقدمون خدمات تقديم الطعام للمناسبات والحفلات؟', 'نعم، نحن نقدم خدمات تقديم الطعام لمجموعة واسعة من المناسبات، بما في ذلك حفلات الزفاف وتجمعات الشركات والحفلات الخاصة. يرجى الاتصال بنا للحصول على مزيد من المعلومات ومناقشة احتياجاتك الخاصة.', 4, '2024-05-06 21:00:41', '2024-05-06 21:06:08'),
(139, 9, 21, 'هل الحجز ضروري أم يمكننا الدخول؟', 'على الرغم من أن الحجز غير مطلوب، خاصة للمجموعات الصغيرة، إلا أننا نوصي بإجراء حجز للحفلات الكبيرة للتأكد من أننا نستطيع استيعابك بشكل مريح.', 5, '2024-05-06 21:01:01', '2024-05-06 21:06:33'),
(140, 9, 21, 'هل لديكم أي عروض أو عروض ترويجية خاصة؟', 'نعم، نحن نجري بانتظام عروضًا ترويجية وخصومات خاصة. تأكد من متابعتنا على وسائل التواصل الاجتماعي أو الاشتراك في النشرة الإخبارية لدينا لتبقى على اطلاع بأحدث عروضنا.', 6, '2024-05-06 21:01:23', '2024-05-06 21:04:25'),
(141, 9, 21, 'هل يمكنني طلب الطعام للوجبات الجاهزة أو التوصيل؟', 'قطعاً! نحن نقدم خدمات الوجبات الجاهزة والتوصيل لراحتك. يمكنك تقديم طلبك عبر الهاتف أو من خلال منصة الطلب عبر الإنترنت.', 7, '2024-05-06 21:01:44', '2024-05-06 21:04:02'),
(142, 9, 21, 'هل أنت مفتوح لتناول طعام الغداء والعشاء؟', 'نعم، نحن منفتحون على خدمة الغداء والعشاء. ساعات العمل لدينا هي [أدخل ساعات العمل هنا]، لذا لا تتردد في الحضور في أي وقت لتناول وجبة لذيذة!', 8, '2024-05-06 21:02:06', '2024-05-06 21:03:36'),
(143, 10, 20, 'Do you take reservations?', 'Reservations are not required as we operate on a first-come, first-served basis.', 1, '2024-05-06 21:34:25', '2024-05-06 21:34:25'),
(144, 10, 20, 'Is your café pet-friendly?', 'Yes, we welcome well-behaved pets in our outdoor seating area.', 2, '2024-05-06 21:34:47', '2024-05-06 21:34:47'),
(145, 10, 20, 'Do you offer vegan or gluten-free options?', 'Yes, we have a selection of vegan and gluten-free items available on our menu.', 3, '2024-05-06 21:35:10', '2024-05-06 21:35:10'),
(146, 10, 20, 'Can I host private events or parties at your café?', 'Absolutely! Please contact us for more information on hosting your event at Café Noir et Blanc.', 4, '2024-05-06 21:35:29', '2024-05-06 21:35:29'),
(147, 10, 20, 'Do you offer Wi-Fi for customers?', 'Yes, complimentary Wi-Fi is available for our patrons.', 5, '2024-05-06 21:35:53', '2024-05-06 21:35:53'),
(148, 10, 20, 'Do you have gift cards available for purchase?', 'Yes, gift cards are available for purchase in-store.', 6, '2024-05-06 21:36:14', '2024-05-06 21:36:14'),
(149, 10, 20, 'Can I place a takeout or delivery order?', 'Yes, we offer takeout options, and delivery is available through select third-party platforms.', 7, '2024-05-06 21:36:35', '2024-05-06 21:36:35'),
(150, 10, 21, 'هل تأخذ تحفظات؟', 'الحجز غير مطلوب لأننا نعمل على أساس أسبقية الحضور.', 1, '2024-05-06 21:34:25', '2024-05-06 21:40:27'),
(151, 10, 21, 'هل المقهى الخاص بك صديق للحيوانات الأليفة؟', 'نعم، نحن نرحب بالحيوانات الأليفة حسنة السلوك في منطقة الجلوس الخارجية.', 2, '2024-05-06 21:34:47', '2024-05-06 21:40:04'),
(152, 10, 21, 'هل تقدمون خيارات نباتية أو خالية من الغلوتين؟', 'نعم، لدينا مجموعة مختارة من العناصر النباتية والخالية من الغلوتين المتوفرة في قائمتنا.', 3, '2024-05-06 21:35:10', '2024-05-06 21:39:42'),
(153, 10, 21, 'هل يمكنني استضافة مناسبات أو حفلات خاصة في المقهى الخاص بك؟', 'قطعاً! يرجى الاتصال بنا للحصول على مزيد من المعلومات حول استضافة الحدث الخاص بك في .', 4, '2024-05-06 21:35:29', '2024-05-06 21:39:17'),
(154, 10, 21, 'هل تقدمون خدمة الواي فاي للعملاء؟', 'نعم، تتوفر خدمة الواي فاي المجانية لعملائنا.', 5, '2024-05-06 21:35:53', '2024-05-06 21:38:43'),
(155, 10, 21, 'هل لديك بطاقات هدايا متاحة للشراء؟', 'نعم، بطاقات الهدايا متاحة للشراء في المتجر.', 6, '2024-05-06 21:36:14', '2024-05-06 21:38:20'),
(156, 10, 21, 'هل يمكنني تقديم طلب خارجي أو توصيل؟', 'نعم، نحن نقدم خيارات تناول الطعام خارج المنزل، والتسليم متاح من خلال منصات مختارة تابعة لجهات خارجية.', 7, '2024-05-06 21:36:35', '2024-05-06 21:37:56'),
(157, 11, 20, 'Do you offer installation services for large equipment purchases?', 'Yes, we provide professional installation services for all large equipment purchases to ensure proper setup and functionality.', 1, '2024-05-06 22:44:30', '2024-05-06 22:44:30'),
(158, 11, 20, 'What payment methods do you accept?', 'We accept various payment methods including credit/debit cards, cash, and electronic transfers for your convenience.', 2, '2024-05-06 22:44:51', '2024-05-06 22:44:51'),
(159, 11, 20, 'Do you provide warranties for your products?', 'Yes, we offer warranties on all our products to guarantee their quality and performance. Warranty durations may vary depending on the item.', 3, '2024-05-06 22:45:15', '2024-05-06 22:45:15'),
(160, 11, 20, 'Can I return or exchange an item if it doesn\'t meet my needs?', 'Yes, we have a hassle-free return and exchange policy within a specified timeframe. Please refer to our return policy for more details.', 4, '2024-05-06 22:45:38', '2024-05-06 22:45:38'),
(161, 11, 20, 'Do you offer financing options for larger purchases?', 'Yes, we provide financing options to help you make larger purchases more manageable. Our staff can assist you in exploring available financing plans.', 5, '2024-05-06 22:46:02', '2024-05-06 22:46:02'),
(162, 11, 20, 'Are there any special discounts or promotions available?', 'We frequently run special promotions and discounts on select products. Check our website or visit our store to stay updated on current offers.', 6, '2024-05-06 22:46:24', '2024-05-06 22:46:24'),
(163, 11, 20, 'Can I schedule a consultation to discuss my fitness goals and equipment needs?', 'Absolutely! We encourage customers to schedule consultations with our fitness experts who can provide personalized recommendations based on your goals and requirements.', 7, '2024-05-06 22:46:45', '2024-05-06 22:46:45'),
(164, 11, 20, 'Do you offer maintenance services for fitness equipment?', 'Yes, we offer maintenance services to keep your fitness equipment in top condition. Our technicians can perform regular maintenance checks and repairs as needed.', 8, '2024-05-06 22:47:06', '2024-05-06 22:47:06'),
(165, 11, 21, 'هل تقدمون خدمات التركيب لشراء المعدات الكبيرة؟', 'نعم، نحن نقدم خدمات تركيب احترافية لجميع مشتريات المعدات الكبيرة لضمان الإعداد والأداء المناسبين.', 1, '2024-05-06 22:44:30', '2024-05-06 22:49:30'),
(166, 11, 21, 'ما هي طرق الدفع التي تقبلونها؟', 'نحن نقبل طرق الدفع المختلفة بما في ذلك بطاقات الائتمان/الخصم والنقد والتحويلات الإلكترونية من أجل راحتك.', 2, '2024-05-06 22:44:51', '2024-05-06 22:51:02'),
(167, 11, 21, 'هل تقدمون ضمانات لمنتجاتكم؟', 'نعم، نقدم ضمانات على جميع منتجاتنا لضمان جودتها وأدائها. قد تختلف فترات الضمان حسب السلعة.', 3, '2024-05-06 22:45:15', '2024-05-06 22:49:53'),
(168, 11, 21, 'هل يمكنني إرجاع أو استبدال منتج إذا كان لا يلبي احتياجاتي؟', 'نعم، لدينا سياسة إرجاع واستبدال خالية من المتاعب خلال إطار زمني محدد. يرجى الرجوع إلى سياسة الإرجاع لدينا لمزيد من التفاصيل.', 4, '2024-05-06 22:45:38', '2024-05-06 22:51:23'),
(169, 11, 21, 'هل تقدمون خيارات تمويل للمشتريات الكبيرة؟', 'نعم، نحن نقدم خيارات التمويل لمساعدتك على إدارة عمليات الشراء الكبيرة بشكل أكثر سهولة. يمكن لموظفينا مساعدتك في استكشاف خطط التمويل المتاحة.', 5, '2024-05-06 22:46:02', '2024-05-06 22:50:39'),
(170, 11, 21, 'هل هناك أي خصومات أو عروض ترويجية خاصة متاحة؟', 'نقوم بشكل متكرر بتشغيل عروض ترويجية وخصومات خاصة على منتجات مختارة. قم بزيارة موقعنا الإلكتروني أو قم بزيارة متجرنا لتبقى على اطلاع على العروض الحالية.', 6, '2024-05-06 22:46:24', '2024-05-06 22:50:16'),
(171, 11, 21, 'هل يمكنني تحديد موعد لاستشارة لمناقشة أهداف اللياقة البدنية واحتياجاتي من المعدات؟', 'قطعاً! نحن نشجع العملاء على تحديد موعد لإجراء مشاورات مع خبراء اللياقة البدنية لدينا الذين يمكنهم تقديم توصيات مخصصة بناءً على أهدافك ومتطلباتك.', 7, '2024-05-06 22:46:45', '2024-05-06 22:49:08'),
(172, 11, 21, 'هل تقدمون خدمات صيانة أجهزة اللياقة البدنية؟', 'نعم، نحن نقدم خدمات الصيانة للحفاظ على معدات اللياقة البدنية الخاصة بك في أفضل حالة. يمكن للفنيين لدينا إجراء فحوصات الصيانة والإصلاحات الدورية حسب الحاجة.', 8, '2024-05-06 22:47:06', '2024-05-06 22:48:45'),
(173, 12, 20, 'What types of hospital beds do you offer?', 'We offer a wide range of hospital beds including basic, adjustable, specialty (such as bariatric and pediatric), and ICU models to cater to various healthcare settings and patient needs.', 1, '2024-05-07 00:23:04', '2024-05-07 00:23:04'),
(174, 12, 20, 'Do you provide installation services for the hospital beds?', 'Yes, we offer professional installation services by skilled technicians to ensure proper setup and functionality of the hospital beds.', 2, '2024-05-07 00:23:29', '2024-05-07 00:23:29'),
(175, 12, 20, 'What kind of accessories and equipment do you offer for hospital beds?', 'We provide a variety of accessories and supplementary equipment including bedside tables, overbed trays, bed rails, specialized mattresses, patient lift systems, and more to enhance patient comfort and care.', 3, '2024-05-07 00:23:53', '2024-05-07 00:23:53'),
(176, 12, 20, 'Do you offer maintenance services for the hospital beds?', 'Yes, we offer regular maintenance and inspection services to prolong the lifespan of the hospital beds and ensure their optimal performance.', 4, '2024-05-07 00:24:14', '2024-05-07 00:24:14'),
(177, 12, 20, 'What warranty coverage do you provide for your products?', 'We provide warranty coverage for all our products, with prompt resolution of any defects or malfunctions covered under the warranty terms.', 5, '2024-05-07 00:24:38', '2024-05-07 00:24:38'),
(178, 12, 20, 'Can you assist with technical support and troubleshooting if issues arise with the hospital beds?', 'Absolutely, our dedicated customer support team is available to provide prompt technical support and troubleshooting assistance to address any issues or concerns.', 6, '2024-05-07 00:25:04', '2024-05-07 00:25:04'),
(179, 12, 20, 'Do you offer personalized consultation to help customers select the right hospital bed for their needs?', 'Yes, our knowledgeable and friendly staff are here to offer personalized consultation and guidance throughout the selection process, taking into account specific needs, preferences, and budget considerations.', 7, '2024-05-07 00:25:23', '2024-05-07 00:25:23'),
(180, 12, 20, 'Are you actively involved in the local healthcare community?', 'Yes, we are actively engaged in the local healthcare community through partnerships with hospitals, clinics, and care facilities. We also participate in health fairs, seminars, and educational events to promote awareness and best practices in patient care.', 8, '2024-05-07 00:25:46', '2024-05-07 00:25:46'),
(181, 12, 21, 'ما هي أنواع أسرة المستشفيات التي تقدمها؟', 'نحن نقدم مجموعة واسعة من أسرة المستشفيات بما في ذلك نماذج أساسية وقابلة للتعديل والتخصص (مثل السمنة وطب الأطفال) ونماذج وحدة العناية المركزة لتلبية مختلف إعدادات الرعاية الصحية واحتياجات المرضى.', 1, '2024-05-07 00:23:04', '2024-05-07 00:32:12'),
(182, 12, 21, 'هل تقدمون خدمات تركيب أسرة المستشفيات؟', 'نعم، نحن نقدم خدمات التركيب الاحترافية على يد فنيين ماهرين لضمان الإعداد السليم والأداء الوظيفي لأسرة المستشفيات.', 2, '2024-05-07 00:23:29', '2024-05-07 00:31:51'),
(183, 12, 21, 'ما نوع الملحقات والمعدات التي تقدمها لأسرة المستشفيات؟', 'نحن نقدم مجموعة متنوعة من الملحقات والمعدات التكميلية بما في ذلك الطاولات الجانبية للسرير، والصواني الموجودة فوق السرير، وقضبان السرير، والمراتب المتخصصة، وأنظمة رفع المرضى، والمزيد لتعزيز راحة المرضى ورعايتهم.', 3, '2024-05-07 00:23:53', '2024-05-07 00:31:25'),
(184, 12, 21, 'هل تقدمون خدمات الصيانة لأسرة المستشفيات؟', 'نعم، نقدم خدمات الصيانة والفحص الدورية لإطالة عمر أسرة المستشفى وضمان أدائها الأمثل.', 4, '2024-05-07 00:24:14', '2024-05-07 00:31:03'),
(185, 12, 21, 'ما هي تغطية الضمان التي تقدمها لمنتجاتك؟', 'نحن نقدم تغطية الضمان لجميع منتجاتنا، مع حل سريع لأية عيوب أو أعطال تغطيها شروط الضمان.', 5, '2024-05-07 00:24:38', '2024-05-07 00:30:40'),
(186, 12, 21, 'هل يمكنك المساعدة في الدعم الفني واستكشاف الأخطاء وإصلاحها في حالة ظهور مشكلات مع أسرة المستشفى؟', 'بالتأكيد، فريق دعم العملاء المخصص لدينا متاح لتقديم الدعم الفني الفوري والمساعدة في استكشاف الأخطاء وإصلاحها لمعالجة أي مشكلات أو مخاوف.', 6, '2024-05-07 00:25:04', '2024-05-07 00:30:18'),
(187, 12, 21, 'هل تقدمون استشارات شخصية لمساعدة العملاء على اختيار سرير المستشفى المناسب لاحتياجاتهم؟', 'نعم، موظفونا الودودون وذوو المعرفة متواجدون هنا لتقديم الاستشارة والتوجيه الشخصي طوال عملية الاختيار، مع مراعاة الاحتياجات والتفضيلات المحددة واعتبارات الميزانية.', 7, '2024-05-07 00:25:23', '2024-05-07 00:29:53'),
(188, 12, 21, 'هل تشارك بنشاط في مجتمع الرعاية الصحية المحلي؟', 'نعم، نحن نشارك بنشاط في مجتمع الارك أيضًا في المعارض الصحية والندوات والفعاليات التعليمية لتعزيز الوعي وأفضل الممارسات في رعاية المرضى.', 8, '2024-05-07 00:25:46', '2024-05-07 00:29:29'),
(189, 13, 20, 'What are your salon\'s safety protocols in light of COVID-19?', 'This question addresses concerns about hygiene and safety measures implemented by the salon to protect customers and staff.', 1, '2024-05-01 21:51:22', '2024-05-01 21:51:22'),
(190, 13, 20, 'How do I book an appointment?', 'This addresses the process for scheduling appointments, whether it\'s done online, over the phone, or in person.', 2, '2024-05-01 21:51:50', '2024-05-01 21:51:50'),
(191, 13, 20, 'What should I expect during my first visit to your salon?', 'This helps new customers understand what to anticipate, such as consultations, services offered, and the overall experience.', 3, '2024-05-01 21:52:12', '2024-05-01 21:52:12'),
(192, 13, 20, 'Do you offer consultations before appointments?', 'Some clients may want to discuss their desired hairstyle or treatment beforehand, so they\'ll inquire about consultation services.', 4, '2024-05-01 21:52:37', '2024-05-01 21:52:37'),
(193, 13, 20, 'What haircare products do you recommend for my hair type?', 'This question is common among clients seeking advice on maintaining their hairstyle or color between salon visits.', 5, '2024-05-01 21:53:05', '2024-05-01 21:53:05'),
(194, 13, 20, 'How long will my appointment take?', 'Clients often want to plan their day around salon appointments, so they\'ll ask about the expected duration of their visit.', 6, '2024-05-01 21:53:26', '2024-05-01 21:53:26'),
(195, 13, 20, 'What is your cancellation policy?', 'It\'s important for clients to understand the salon\'s policy regarding cancellations, including any fees or notice requirements.', 7, '2024-05-01 21:53:47', '2024-05-01 21:53:47'),
(196, 13, 20, 'Do you offer any special promotions or loyalty programs?', 'Clients may inquire about discounts, promotions, or loyalty rewards to make their salon visits more cost-effective.', 8, '2024-05-01 21:54:10', '2024-05-01 21:54:10'),
(197, 13, 21, 'ما هي إجراءات السلامة الخاصة بصالونكم في ظل جائحة كوفيد-١٩؟', 'هذا السؤال يتعلق بالاهتمام بالنظافة والإجراءات الأمنية التي يتم تنفيذها في الصالون لحماية العملاء والموظفين.', 1, '2024-05-01 22:07:02', '2024-05-01 22:07:02'),
(198, 13, 21, 'كيف يمكنني حجز موعد؟', 'يتعلق هذا بعملية تحديد المواعيد، سواء كانت عبر الإنترنت، أو عبر الهاتف، أو شخصياً.', 2, '2024-05-01 22:07:30', '2024-05-01 22:07:30'),
(199, 13, 21, 'ما الذي يجب أن أتوقعه خلال زيارتي الأولى إلى صالونكم؟', 'يساعد هذا السؤال العملاء الجدد على فهم ما يمكن توقعه، مثل الاستشارات، والخدمات المقدمة، والتجربة العامة.', 3, '2024-05-01 22:08:00', '2024-05-01 22:08:00'),
(200, 13, 21, 'هل تقدمون استشارات قبل المواعيد؟', 'قد يرغب بعض العملاء في مناقشة القصة أو العلاج المرغوب قبل الحجز، لذلك سيسألون عن خدمات الاستشارة.', 4, '2024-05-01 22:08:25', '2024-05-01 22:08:25'),
(201, 13, 21, 'ما هي المنتجات المناسبة لنوع شعري؟', 'هذا السؤال شائع بين العملاء الذين يبحثون عن نصائح للحفاظ على قصة شعرهم أو لونهم بين الزيارات للصالون.', 5, '2024-05-01 22:08:56', '2024-05-01 22:08:56'),
(202, 13, 21, 'كم سيستغرق موعدي؟', 'يرغب العملاء غالبًا في تنظيم يومهم حول المواعيد في الصالون، لذا سيسألون عن المدة المتوقعة لزيارتهم.', 6, '2024-05-01 22:09:19', '2024-05-01 22:09:19'),
(203, 13, 21, 'ما هي سياسة الإلغاء لديكم؟', 'من المهم أن يفهم العملاء سياسة الصالون المتعلقة بالإلغاء، بما في ذلك أية رسوم أو متطلبات للإشعار.', 7, '2024-05-01 22:09:42', '2024-05-01 22:09:42'),
(204, 13, 21, 'هل تقدمون عروضًا خاصة أو برامج وفاء؟', 'قد يسأل العملاء عن الخصومات، والعروض، أو برامج الولاء لجعل زياراتهم للصالون أكثر كفاءة مالية.', 8, '2024-05-01 22:11:36', '2024-05-01 22:11:36'),
(205, 14, 20, 'What are your salon\'s safety protocols in light of COVID-19?', 'This question addresses concerns about hygiene and safety measures implemented by the salon to protect customers and staff.', 1, '2024-05-01 21:51:22', '2024-05-01 21:51:22'),
(206, 14, 20, 'How do I book an appointment?', 'This addresses the process for scheduling appointments, whether it\'s done online, over the phone, or in person.', 2, '2024-05-01 21:51:50', '2024-05-01 21:51:50'),
(207, 14, 20, 'What should I expect during my first visit to your salon?', 'This helps new customers understand what to anticipate, such as consultations, services offered, and the overall experience.', 3, '2024-05-01 21:52:12', '2024-05-01 21:52:12'),
(208, 14, 20, 'Do you offer consultations before appointments?', 'Some clients may want to discuss their desired hairstyle or treatment beforehand, so they\'ll inquire about consultation services.', 4, '2024-05-01 21:52:37', '2024-05-01 21:52:37'),
(209, 14, 20, 'What haircare products do you recommend for my hair type?', 'This question is common among clients seeking advice on maintaining their hairstyle or color between salon visits.', 5, '2024-05-01 21:53:05', '2024-05-01 21:53:05'),
(210, 14, 20, 'How long will my appointment take?', 'Clients often want to plan their day around salon appointments, so they\'ll ask about the expected duration of their visit.', 6, '2024-05-01 21:53:26', '2024-05-01 21:53:26'),
(211, 14, 20, 'What is your cancellation policy?', 'It\'s important for clients to understand the salon\'s policy regarding cancellations, including any fees or notice requirements.', 7, '2024-05-01 21:53:47', '2024-05-01 21:53:47'),
(212, 14, 20, 'Do you offer any special promotions or loyalty programs?', 'Clients may inquire about discounts, promotions, or loyalty rewards to make their salon visits more cost-effective.', 8, '2024-05-01 21:54:10', '2024-05-01 21:54:10'),
(213, 14, 21, 'ما هي إجراءات السلامة الخاصة بصالونكم في ظل جائحة كوفيد-١٩؟', 'هذا السؤال يتعلق بالاهتمام بالنظافة والإجراءات الأمنية التي يتم تنفيذها في الصالون لحماية العملاء والموظفين.', 1, '2024-05-01 22:07:02', '2024-05-01 22:07:02'),
(214, 14, 21, 'كيف يمكنني حجز موعد؟', 'يتعلق هذا بعملية تحديد المواعيد، سواء كانت عبر الإنترنت، أو عبر الهاتف، أو شخصياً.', 2, '2024-05-01 22:07:30', '2024-05-01 22:07:30'),
(215, 14, 21, 'ما الذي يجب أن أتوقعه خلال زيارتي الأولى إلى صالونكم؟', 'يساعد هذا السؤال العملاء الجدد على فهم ما يمكن توقعه، مثل الاستشارات، والخدمات المقدمة، والتجربة العامة.', 3, '2024-05-01 22:08:00', '2024-05-01 22:08:00'),
(216, 14, 21, 'هل تقدمون استشارات قبل المواعيد؟', 'قد يرغب بعض العملاء في مناقشة القصة أو العلاج المرغوب قبل الحجز، لذلك سيسألون عن خدمات الاستشارة.', 4, '2024-05-01 22:08:25', '2024-05-01 22:08:25'),
(217, 14, 21, 'ما هي المنتجات المناسبة لنوع شعري؟', 'هذا السؤال شائع بين العملاء الذين يبحثون عن نصائح للحفاظ على قصة شعرهم أو لونهم بين الزيارات للصالون.', 5, '2024-05-01 22:08:56', '2024-05-01 22:08:56'),
(218, 14, 21, 'كم سيستغرق موعدي؟', 'يرغب العملاء غالبًا في تنظيم يومهم حول المواعيد في الصالون، لذا سيسألون عن المدة المتوقعة لزيارتهم.', 6, '2024-05-01 22:09:19', '2024-05-01 22:09:19'),
(219, 14, 21, 'ما هي سياسة الإلغاء لديكم؟', 'من المهم أن يفهم العملاء سياسة الصالون المتعلقة بالإلغاء، بما في ذلك أية رسوم أو متطلبات للإشعار.', 7, '2024-05-01 22:09:42', '2024-05-01 22:09:42'),
(220, 14, 21, 'هل تقدمون عروضًا خاصة أو برامج وفاء؟', 'قد يسأل العملاء عن الخصومات، والعروض، أو برامج الولاء لجعل زياراتهم للصالون أكثر كفاءة مالية.', 8, '2024-05-01 22:11:36', '2024-05-01 22:11:36'),
(221, 15, 20, 'What are the visiting hours at Hopeview General Hospital?', 'Visiting hours at Hopeview General Hospital are from 10:00 AM to 8:00 PM. However, exceptions may be made for special circumstances or critical care units. Please check with the hospital reception for specific visiting policies.', 1, '2024-05-01 22:53:06', '2024-05-01 22:53:06');
INSERT INTO `listing_faqs` (`id`, `listing_id`, `language_id`, `question`, `answer`, `serial_number`, `created_at`, `updated_at`) VALUES
(222, 15, 20, 'Does Hopeview General Hospital accept health insurance?', 'Yes, Hopeview General Hospital accepts a wide range of health insurance plans. We recommend contacting your insurance provider or the hospital billing department to confirm coverage and any out-of-pocket expenses.', 2, '2024-05-01 22:53:32', '2024-05-01 22:53:32'),
(223, 15, 20, 'How can I schedule an appointment with a specialist at Hopeview General Hospital?', 'To schedule an appointment with a specialist at Hopeview General Hospital, you can call our appointment hotline at [insert phone number] or visit our website to book an appointment online. We strive to accommodate appointment requests promptly and efficiently.', 3, '2024-05-01 22:54:10', '2024-05-01 22:54:10'),
(224, 15, 20, 'What amenities are available for patients and visitors at Hopeview General Hospital?', 'Hopeview General Hospital offers a range of amenities for the comfort and convenience of patients and visitors, including cafeteria services, parking facilities, Wi-Fi access, and patient counseling services. Additionally, we provide information desks and concierge services to assist with any inquiries or special requests.', 4, '2024-05-01 22:54:37', '2024-05-01 22:54:37'),
(225, 15, 20, 'Does Hopeview General Hospital provide emergency medical services?', 'Yes, Hopeview General Hospital has a dedicated emergency department equipped to handle a wide range of medical emergencies 24 hours a day, 7 days a week. Our experienced emergency medical team is committed to providing timely and comprehensive care to patients in need.', 5, '2024-05-01 22:55:01', '2024-05-01 22:55:01'),
(226, 15, 20, 'What measures does Hopeview General Hospital take to ensure patient safety and infection control?', 'Hopeview General Hospital prioritizes patient safety and infection control through rigorous protocols and hygiene practices. We adhere to international standards and guidelines, regularly conducting audits and implementing measures to prevent healthcare-associated infections and ensure a safe environment for patients, visitors, and staff.', 6, '2024-05-01 22:55:22', '2024-05-01 22:55:22'),
(227, 15, 20, 'Are there financial assistance programs available for patients who cannot afford medical treatment at Hopeview General Hospital?', 'Yes, Hopeview General Hospital offers financial assistance programs and discounts for eligible patients who demonstrate financial need. Our patient financial counselors can provide information and assistance with applying for financial aid programs and exploring available options for managing healthcare costs.', 7, '2024-05-01 22:55:44', '2024-05-01 22:55:44'),
(228, 15, 20, 'Does Hopeview General Hospital offer telemedicine services for remote consultations?', 'Yes, Hopeview General Hospital offers telemedicine services, allowing patients to consult with healthcare providers remotely for non-emergency medical concerns. Virtual appointments can be scheduled through our telemedicine platform, providing convenient access to medical expertise from the comfort of your home or office.', 8, '2024-05-01 22:56:06', '2024-05-01 22:56:06'),
(229, 15, 21, 'ما هي ساعات الزيارة في مستشفى هوبفيو العام؟', 'ساعات الزيارة في مستشفى هوبفيو العام هي من الساعة ١٠:٠٠ صباحًا حتى الساعة ٨:٠٠ مساءً. ومع ذلك، قد يتم السماح بإجراء استثناءات للحالات الخاصة أو وحدات العناية المركزة. يُرجى التحقق من إدارة المستشفى لمعرفة السياسات الخاصة بالزيارات.', 1, '2024-05-01 22:56:47', '2024-05-01 22:56:47'),
(230, 15, 21, 'هل يقبل مستشفى هوبفيو العام التأمين الصحي؟', 'نعم، يقبل مستشفى هوبفيو العام مجموعة واسعة من خطط التأمين الصحي. نوصي بالاتصال بمزود التأمين الخاص بك أو قسم الفوترة في المستشفى للتأكد من التغطية وأي مصاريف شخصية.', 2, '2024-05-01 22:57:14', '2024-05-01 22:57:14'),
(231, 15, 21, 'كيف يمكنني تحديد موعد مع أخصائي في مستشفى هوبفيو العام؟', 'لتحديد موعد مع أخصائي في مستشفى هوبفيو العام، يمكنك الاتصال بخطنا الساخن لتحديد المواعيد على الرقم [أدخل رقم الهاتف] أو زيارة موقعنا على الويب لحجز موعد عبر الإنترنت. نحن نسعى لتلبية طلبات المواعيد بسرعة وفعالية.', 3, '2024-05-01 22:57:40', '2024-05-01 22:57:40'),
(232, 15, 21, 'ما هي الخدمات المتاحة للمرضى والزوار في مستشفى هوبفيو العام؟', 'يقدم مستشفى هوبفيو العام مجموعة متنوعة من الخدمات لراحة وراحة المرضى والزوار، بما في ذلك خدمات الكافتيريا ومرافق وقوف السيارات والوصول إلى الإنترنت وخدمات المشورة للمرضى. بالإضافة إلى ذلك، نقدم مكاتب معلومات وخدمات الاستقبال لمساعدتك في أي استفسارات أو طلبات خاصة.', 4, '2024-05-01 22:58:07', '2024-05-01 22:58:07'),
(233, 15, 21, 'هل يقدم مستشفى هوبفيو العام خدمات طبية طارئة؟', 'نعم، يحتوي مستشفى هوبفيو العام على قسم طوارئ مخصص مجهز للتعامل مع مجموعة واسعة من الحالات الطبية الطارئة على مدار ٢٤ ساعة في اليوم، ٧ أيام في الأسبوع. فريقنا الطبي الطارئ ذو الخبرة ملتزم بتقديم الرعاية الشاملة والفورية للمرضى الذين في حاجة.', 5, '2024-05-01 22:58:32', '2024-05-01 22:58:32'),
(234, 15, 21, 'ما الإجراءات التي يتخذها مستشفى هوبفيو العام لضمان سلامة المرضى ومراقبة العدوى؟', 'يولي مستشفى هوبفيو العام اهتمامًا خاصًا بسلامة المرضى ومراقبة العدوى من خلال بروتوكولات صارمة وممارسات النظافة. نلتزم بالمعايير والإرشادات الدولية، ونقوم بشكل منتظم بإجراء الفحوصات الدورية وتنفيذ تدابير لمنع العدوى المرتبطة بالرعاية الصحية وضمان بيئة آمنة للمرضى والزوار والموظفين.', 6, '2024-05-01 22:59:01', '2024-05-01 22:59:01');

-- --------------------------------------------------------

--
-- Table structure for table `listing_features`
--

CREATE TABLE `listing_features` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `indx` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_features`
--

INSERT INTO `listing_features` (`id`, `listing_id`, `indx`, `created_at`, `updated_at`) VALUES
(4, 1, '0', '2024-05-01 21:55:30', '2024-05-01 21:55:30'),
(5, 1, '1', '2024-05-01 21:55:30', '2024-05-01 21:55:30'),
(6, 1, '2', '2024-05-01 21:55:30', '2024-05-01 21:55:30'),
(12, 3, '0', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(13, 3, '1', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(14, 3, '2', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(15, 3, '3', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(16, 3, '4', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(17, 4, '0', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(18, 4, '1', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(19, 4, '2', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(20, 4, '3', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(21, 4, '4', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(22, 5, '0', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(23, 5, '1', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(24, 5, '2', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(25, 5, '3', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(26, 5, '4', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(27, 6, '0', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(28, 6, '1', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(29, 6, '2', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(30, 6, '3', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(31, 6, '4', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(32, 6, '5', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(33, 6, '6', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(34, 6, '7', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(35, 7, '0', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(36, 7, '1', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(37, 7, '2', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(38, 7, '3', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(39, 7, '4', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(40, 7, '5', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(41, 7, '6', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(49, 9, '0', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(50, 9, '1', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(51, 9, '2', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(52, 9, '3', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(53, 9, '4', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(54, 9, '5', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(55, 9, '6', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(56, 9, '7', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(57, 10, '0', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(58, 10, '1', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(59, 10, '2', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(60, 10, '3', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(61, 10, '4', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(62, 10, '5', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(63, 10, '6', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(64, 10, '7', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(65, 11, '0', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(66, 11, '1', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(67, 11, '2', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(68, 11, '3', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(69, 11, '4', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(70, 11, '5', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(71, 11, '6', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(72, 12, '0', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(73, 12, '1', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(74, 12, '2', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(75, 12, '3', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(76, 12, '4', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(77, 12, '5', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(78, 12, '6', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(79, 13, '0', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(80, 13, '1', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(81, 13, '2', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(82, 13, '3', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(83, 13, '4', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(84, 13, '5', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(85, 13, '6', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(86, 14, '0', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(87, 14, '1', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(88, 14, '2', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(89, 14, '3', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(90, 14, '4', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(91, 14, '5', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(103, 15, '0', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(104, 15, '1', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(105, 15, '2', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(106, 15, '3', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(107, 15, '4', '2024-05-08 02:54:02', '2024-05-08 02:54:02');

-- --------------------------------------------------------

--
-- Table structure for table `listing_feature_contents`
--

CREATE TABLE `listing_feature_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_feature_id` bigint DEFAULT NULL,
  `language_id` bigint DEFAULT NULL,
  `feature_heading` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `feature_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_feature_contents`
--

INSERT INTO `listing_feature_contents` (`id`, `listing_feature_id`, `language_id`, `feature_heading`, `feature_value`, `created_at`, `updated_at`) VALUES
(7, 4, 20, 'Quality of Services', '[\"Skill level of stylists: 9\\/10\",\"Range of services offered (haircuts, coloring, styling, etc.): 8\\/10\",\"Use of high-quality products: 9\\/10\",\"Attention to detail: 9\\/10\"]', '2024-05-01 21:55:30', '2024-05-01 21:55:30'),
(8, 5, 20, 'Customer Experience', '[\"Comfort and ambiance of the salon: 8\\/10\",\"Friendliness and professionalism of staff: 9\\/10\",\"Appointment scheduling and wait times: 8\\/10\",\"Cleanliness and hygiene: 9\\/10\"]', '2024-05-01 21:55:30', '2024-05-01 21:55:30'),
(9, 6, 20, 'Value for Money', '[\"Pricing of services compared to competitors: 8\\/10\",\"Overall satisfaction with the service received for the price paid: 8\\/10\",\"Additional amenities offered (beverage service, complimentary consultations, etc.): 7\\/10\"]', '2024-05-01 21:55:30', '2024-05-01 21:55:30'),
(10, 4, 21, 'جودة الخدمات', '[\"\\u0645\\u0633\\u062a\\u0648\\u0649 \\u0645\\u0647\\u0627\\u0631\\u0629 \\u0627\\u0644\\u0645\\u0635\\u0645\\u0645\\u064a\\u0646: 9\\/10\",\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0645\\u0642\\u062f\\u0645\\u0629 (\\u0642\\u0635 \\u0627\\u0644\\u0634\\u0639\\u0631\\u060c \\u0627\\u0644\\u062a\\u0644\\u0648\\u064a\\u0646\\u060c \\u0627\\u0644\\u062a\\u0635\\u0645\\u064a\\u0645\\u060c \\u0627\\u0644\\u062e): 8\\/10\",\"\\u0627\\u0633\\u062a\\u062e\\u062f\\u0627\\u0645 \\u0645\\u0646\\u062a\\u062c\\u0627\\u062a \\u0639\\u0627\\u0644\\u064a\\u0629 \\u0627\\u0644\\u062c\\u0648\\u062f\\u0629: 9\\/10\",\"\\u0627\\u0644\\u0627\\u0647\\u062a\\u0645\\u0627\\u0645 \\u0628\\u0627\\u0644\\u062a\\u0641\\u0627\\u0635\\u064a\\u0644: 9\\/10\"]', '2024-05-01 21:55:30', '2024-05-01 21:55:30'),
(11, 5, 21, 'تجربة الزبون', '[\"\\u0627\\u0644\\u0631\\u0627\\u062d\\u0629 \\u0648\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0635\\u0627\\u0644\\u0648\\u0646: 8\\/10\",\"\\u0627\\u0644\\u0648\\u062f \\u0648\\u0627\\u0644\\u0643\\u0641\\u0627\\u0621\\u0629 \\u0627\\u0644\\u0645\\u0647\\u0646\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646: 9\\/10\",\"\\u062c\\u062f\\u0648\\u0644\\u0629 \\u0627\\u0644\\u0645\\u0648\\u0627\\u0639\\u064a\\u062f \\u0648\\u0623\\u0648\\u0642\\u0627\\u062a \\u0627\\u0644\\u0627\\u0646\\u062a\\u0638\\u0627\\u0631: 8\\/10\",\"\\u0627\\u0644\\u0646\\u0638\\u0627\\u0641\\u0629 \\u0648\\u0627\\u0644\\u0646\\u0638\\u0627\\u0641\\u0629: 9\\/10\"]', '2024-05-01 21:55:30', '2024-05-01 21:55:30'),
(12, 6, 21, 'قيمة المال', '[\"\\u0623\\u0633\\u0639\\u0627\\u0631 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0627\\u062a \\u0645\\u0642\\u0627\\u0631\\u0646\\u0629 \\u0628\\u0627\\u0644\\u0645\\u0646\\u0627\\u0641\\u0633\\u064a\\u0646: 8\\/10\",\"\\u0623\\u0633\\u0639\\u0627\\u0631 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0627\\u062a \\u0645\\u0642\\u0627\\u0631\\u0646\\u0629 \\u0628\\u0627\\u0644\\u0645\\u0646\\u0627\\u0641\\u0633\\u064a\\u0646: 8\\/10\",\"\\u0648\\u0633\\u0627\\u0626\\u0644 \\u0627\\u0644\\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0642\\u062f\\u0645\\u0629 (\\u062e\\u062f\\u0645\\u0629 \\u0627\\u0644\\u0645\\u0634\\u0631\\u0648\\u0628\\u0627\\u062a\\u060c \\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a \\u0645\\u062c\\u0627\\u0646\\u064a\\u0629\\u060c \\u0648\\u0645\\u0627 \\u0625\\u0644\\u0649 \\u0630\\u0644\\u0643): 7\\/10\"]', '2024-05-01 21:55:30', '2024-05-01 21:55:30'),
(23, 12, 20, 'Tailored Itinerary Planning', '[\"Personalized Consultations\",\"Customized Itineraries\",\"Flexibility and Adjustments\",\"Expert Recommendations\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(24, 13, 20, 'Exceptional Customer Service', '[\"Responsive Communication\",\"Dedicated Support\",\"24\\/7 Assistance\",\"Personalized Touches\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(25, 14, 20, 'Expert Destination Knowledge', '[\"Destination Specialists\",\"Insider Access\",\"Cultural Immersion\",\"Sustainable Tourism Practices\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(26, 15, 20, 'Comprehensive Travel Resources', '[\"Destination Guides and Resources\",\"Travel Technology Integration\",\"Travel Insurance and Risk Management\",\"Multilingual Support\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(27, 16, 20, 'Community Engagement and Social Responsibility', '[\"Community Partnerships\",\"Philanthropic Initiatives\",\"Ethical Supply Chain Practices\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(28, 12, 21, 'تخطيط رحلة مصممة خصيصا', '[\"\\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a \\u0634\\u062e\\u0635\\u064a\\u0629\",\"\\u0645\\u0633\\u0627\\u0631\\u0627\\u062a \\u0645\\u062e\\u0635\\u0635\\u0629\",\"\\u0627\\u0644\\u0645\\u0631\\u0648\\u0646\\u0629 \\u0648\\u0627\\u0644\\u062a\\u0639\\u062f\\u064a\\u0644\\u0627\\u062a\",\"\\u062a\\u0648\\u0635\\u064a\\u0627\\u062a \\u0627\\u0644\\u062e\\u0628\\u0631\\u0627\\u0621\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(29, 13, 21, 'خدمة عملاء استثنائية', '[\"\\u0627\\u0644\\u062a\\u0648\\u0627\\u0635\\u0644 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062c\\u064a\\u0628\",\"\\u062f\\u0639\\u0645 \\u0645\\u062e\\u0635\\u0635\",\"\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0639\\u0644\\u0649 \\u0645\\u062f\\u0627\\u0631 24 \\u0633\\u0627\\u0639\\u0629 \\u0637\\u0648\\u0627\\u0644 \\u0623\\u064a\\u0627\\u0645 \\u0627\\u0644\\u0623\\u0633\\u0628\\u0648\\u0639\",\"\\u0627\\u0644\\u0644\\u0645\\u0633\\u0627\\u062a \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(30, 14, 21, 'معرفة وجهة الخبراء', '[\"\\u0645\\u062a\\u062e\\u0635\\u0635\\u0648\\u0646 \\u0627\\u0644\\u0648\\u062c\\u0647\\u0629\",\"\\u0645\\u062a\\u062e\\u0635\\u0635\\u0648\\u0646 \\u0627\\u0644\\u0648\\u062c\\u0647\\u0629\",\"\\u0627\\u0644\\u0627\\u0646\\u063a\\u0645\\u0627\\u0633 \\u0627\\u0644\\u062b\\u0642\\u0627\\u0641\\u064a\",\"\\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0627\\u0644\\u0633\\u064a\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062f\\u0627\\u0645\\u0629\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(31, 15, 21, 'موارد السفر الشاملة', '[\"\\u0623\\u062f\\u0644\\u0629 \\u0627\\u0644\\u0648\\u062c\\u0647\\u0629 \\u0648\\u0627\\u0644\\u0645\\u0648\\u0627\\u0631\\u062f\",\"\\u062a\\u0643\\u0627\\u0645\\u0644 \\u062a\\u0643\\u0646\\u0648\\u0644\\u0648\\u062c\\u064a\\u0627 \\u0627\\u0644\\u0633\\u0641\\u0631\",\"\\u062a\\u0623\\u0645\\u064a\\u0646 \\u0627\\u0644\\u0633\\u0641\\u0631 \\u0648\\u0625\\u062f\\u0627\\u0631\\u0629 \\u0627\\u0644\\u0645\\u062e\\u0627\\u0637\\u0631\",\"\\u062f\\u0639\\u0645 \\u0645\\u062a\\u0639\\u062f\\u062f \\u0627\\u0644\\u0644\\u063a\\u0627\\u062a\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(32, 16, 21, 'المشاركة المجتمعية والمسؤولية الاجتماعية', '[\"\\u0627\\u0644\\u0634\\u0631\\u0627\\u0643\\u0627\\u062a \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\\u064a\\u0629\",\"\\u0627\\u0644\\u0645\\u0628\\u0627\\u062f\\u0631\\u0627\\u062a \\u0627\\u0644\\u062e\\u064a\\u0631\\u064a\\u0629\",\"\\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0633\\u0644\\u0633\\u0644\\u0629 \\u0627\\u0644\\u062a\\u0648\\u0631\\u064a\\u062f \\u0627\\u0644\\u0623\\u062e\\u0644\\u0627\\u0642\\u064a\\u0629\"]', '2024-05-01 23:34:31', '2024-05-01 23:34:31'),
(33, 17, 20, 'Oceanfront Location', '[\"Spectacular views of the Bay of Bengal\",\"Direct access to Kolatoli Beach\",\"Opportunities for water sports\",\"Sunset viewing spots for guests\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(34, 18, 20, 'Luxurious Accommodations', '[\"Spacious rooms and suites with modern amenities and elegant decor.\",\"Private balconies or terraces overlooking the ocean or lush gardens.\",\"Plush bedding and comfortable furnishings for a restful night\'s sleep.\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(35, 19, 20, 'World-Class Dining', '[\"Fine dining restaurant offering a diverse menu of local and international cuisine.\",\"Fresh seafood specialties sourced from local fishermen for an authentic taste of the region.\",\"Casual cafe or lounge serving light bites, refreshing beverages, and signature cocktails.\",\"Outdoor dining options with panoramic views of the ocean or landscaped gardens.\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(36, 20, 20, 'Relaxation and Wellness Facilities', '[\"Tranquil spa and wellness center offering a range of massage therapies and body treatments.\",\"Yoga and meditation sessions held in serene outdoor spaces or dedicated studios.\",\"Outdoor swimming pool and Jacuzzi for refreshing dips and relaxation under the sun.\",\"Fitness center equipped with state-of-the-art equipment for guests to maintain their workout routines.\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(37, 21, 20, 'Exceptional Hospitality and Services', '[\"Warm and attentive staff dedicated to providing personalized service and ensuring guest satisfaction.\",\"Concierge desk to assist with arranging excursions, transportation, and restaurant reservations.\",\"24-hour room service for guests\' convenience, offering a selection of delicious meals and snacks.\",\"Special amenities for families, couples, and business travelers to enhance their stay experience.\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(38, 17, 21, 'موقع واجهة المحيط', '[\"\\u0645\\u0646\\u0627\\u0638\\u0631 \\u062e\\u0644\\u0627\\u0628\\u0629 \\u0644\\u062e\\u0644\\u064a\\u062c \\u0627\\u0644\\u0628\\u0646\\u063a\\u0627\\u0644\",\"\\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0627\\u0644\\u0645\\u0628\\u0627\\u0634\\u0631 \\u0625\\u0644\\u0649 \\u0634\\u0627\\u0637\\u0626 \\u0643\\u0648\\u0644\\u0627\\u062a\\u0648\\u0644\\u064a\",\"\\u0641\\u0631\\u0635 \\u0644\\u0645\\u0645\\u0627\\u0631\\u0633\\u0629 \\u0627\\u0644\\u0631\\u064a\\u0627\\u0636\\u0627\\u062a \\u0627\\u0644\\u0645\\u0627\\u0626\\u064a\\u0629\",\"\\u0623\\u0645\\u0627\\u0643\\u0646 \\u0644\\u0645\\u0634\\u0627\\u0647\\u062f\\u0629 \\u063a\\u0631\\u0648\\u0628 \\u0627\\u0644\\u0634\\u0645\\u0633 \\u0644\\u0644\\u0636\\u064a\\u0648\\u0641\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(39, 18, 21, 'أماكن إقامة فاخرة', '[\"\\u063a\\u0631\\u0641 \\u0648\\u0623\\u062c\\u0646\\u062d\\u0629 \\u0641\\u0633\\u064a\\u062d\\u0629 \\u0645\\u0639 \\u0648\\u0633\\u0627\\u0626\\u0644 \\u0627\\u0644\\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u062d\\u062f\\u064a\\u062b\\u0629 \\u0648\\u0627\\u0644\\u062f\\u064a\\u0643\\u0648\\u0631 \\u0627\\u0644\\u0623\\u0646\\u064a\\u0642.\",\"\\u0634\\u0631\\u0641\\u0627\\u062a \\u0623\\u0648 \\u062a\\u0631\\u0627\\u0633\\u0627\\u062a \\u062e\\u0627\\u0635\\u0629 \\u0645\\u0637\\u0644\\u0629 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u062d\\u064a\\u0637 \\u0623\\u0648 \\u0627\\u0644\\u062d\\u062f\\u0627\\u0626\\u0642 \\u0627\\u0644\\u0645\\u0648\\u0631\\u0642\\u0629.\",\"\\u0623\\u0633\\u0631\\u0629 \\u0641\\u062e\\u0645\\u0629 \\u0648\\u0645\\u0641\\u0631\\u0648\\u0634\\u0627\\u062a \\u0645\\u0631\\u064a\\u062d\\u0629 \\u0644\\u0642\\u0636\\u0627\\u0621 \\u0644\\u064a\\u0644\\u0629 \\u0646\\u0648\\u0645 \\u0645\\u0631\\u064a\\u062d\\u0629.\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(40, 19, 21, 'تناول الطعام على مستوى عالمي', '[\"\\u0645\\u0637\\u0639\\u0645 \\u0641\\u0627\\u062e\\u0631 \\u064a\\u0642\\u062f\\u0645 \\u0642\\u0627\\u0626\\u0645\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u0623\\u0643\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0639\\u0627\\u0644\\u0645\\u064a\\u0629.\",\"\\u062a\\u062e\\u0635\\u0635\\u0627\\u062a \\u0627\\u0644\\u0645\\u0623\\u0643\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u0628\\u062d\\u0631\\u064a\\u0629 \\u0627\\u0644\\u0637\\u0627\\u0632\\u062c\\u0629 \\u0627\\u0644\\u062a\\u064a \\u064a\\u062a\\u0645 \\u0627\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u064a\\u0647\\u0627 \\u0645\\u0646 \\u0627\\u0644\\u0635\\u064a\\u0627\\u062f\\u064a\\u0646 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u064a\\u0646 \\u0644\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u0630\\u0627\\u0642 \\u0627\\u0644\\u0623\\u0635\\u064a\\u0644 \\u0644\\u0644\\u0645\\u0646\\u0637\\u0642\\u0629.\",\"\\u0645\\u0642\\u0647\\u0649 \\u0623\\u0648 \\u0635\\u0627\\u0644\\u0629 \\u063a\\u064a\\u0631 \\u0631\\u0633\\u0645\\u064a\\u0629 \\u062a\\u0642\\u062f\\u0645 \\u0627\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0627\\u0644\\u062e\\u0641\\u064a\\u0641\\u0629 \\u0648\\u0627\\u0644\\u0645\\u0634\\u0631\\u0648\\u0628\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0639\\u0634\\u0629 \\u0648\\u0627\\u0644\\u0643\\u0648\\u0643\\u062a\\u064a\\u0644\\u0627\\u062a \\u0627\\u0644\\u0645\\u0645\\u064a\\u0632\\u0629.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0641\\u064a \\u0627\\u0644\\u0647\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0637\\u0644\\u0642 \\u0645\\u0639 \\u0625\\u0637\\u0644\\u0627\\u0644\\u0627\\u062a \\u0628\\u0627\\u0646\\u0648\\u0631\\u0627\\u0645\\u064a\\u0629 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u062d\\u064a\\u0637 \\u0623\\u0648 \\u0627\\u0644\\u062d\\u062f\\u0627\\u0626\\u0642 \\u0630\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0627\\u0638\\u0631 \\u0627\\u0644\\u0637\\u0628\\u064a\\u0639\\u064a\\u0629.\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(41, 20, 21, 'مرافق الاسترخاء والعافية', '[\"\\u064a\\u0642\\u062f\\u0645 \\u0627\\u0644\\u0633\\u0628\\u0627 \\u0648\\u0627\\u0644\\u0645\\u0631\\u0643\\u0632 \\u0627\\u0644\\u0635\\u062d\\u064a \\u0627\\u0644\\u0647\\u0627\\u062f\\u0626 \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0639\\u0644\\u0627\\u062c\\u0627\\u062a \\u0627\\u0644\\u062a\\u062f\\u0644\\u064a\\u0643 \\u0648\\u0639\\u0644\\u0627\\u062c\\u0627\\u062a \\u0627\\u0644\\u062c\\u0633\\u0645.\",\"\\u062a\\u064f\\u0639\\u0642\\u062f \\u062c\\u0644\\u0633\\u0627\\u062a \\u0627\\u0644\\u064a\\u0648\\u063a\\u0627 \\u0648\\u0627\\u0644\\u062a\\u0623\\u0645\\u0644 \\u0641\\u064a \\u0645\\u0633\\u0627\\u062d\\u0627\\u062a \\u062e\\u0627\\u0631\\u062c\\u064a\\u0629 \\u0647\\u0627\\u062f\\u0626\\u0629 \\u0623\\u0648 \\u0641\\u064a \\u0627\\u0633\\u062a\\u0648\\u062f\\u064a\\u0648\\u0647\\u0627\\u062a \\u0645\\u062e\\u0635\\u0635\\u0629.\",\"\\u062d\\u0645\\u0627\\u0645 \\u0633\\u0628\\u0627\\u062d\\u0629 \\u062e\\u0627\\u0631\\u062c\\u064a \\u0648\\u062c\\u0627\\u0643\\u0648\\u0632\\u064a \\u0644\\u0644\\u0633\\u0628\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0645\\u0646\\u0639\\u0634\\u0629 \\u0648\\u0627\\u0644\\u0627\\u0633\\u062a\\u0631\\u062e\\u0627\\u0621 \\u062a\\u062d\\u062a \\u0623\\u0634\\u0639\\u0629 \\u0627\\u0644\\u0634\\u0645\\u0633.\",\"\\u0645\\u0631\\u0643\\u0632 \\u0644\\u0644\\u064a\\u0627\\u0642\\u0629 \\u0627\\u0644\\u0628\\u062f\\u0646\\u064a\\u0629 \\u0645\\u062c\\u0647\\u0632 \\u0628\\u0623\\u062d\\u062f\\u062b \\u0627\\u0644\\u0645\\u0639\\u062f\\u0627\\u062a \\u0644\\u0644\\u0636\\u064a\\u0648\\u0641 \\u0644\\u0644\\u062d\\u0641\\u0627\\u0638 \\u0639\\u0644\\u0649 \\u0631\\u0648\\u062a\\u064a\\u0646 \\u062a\\u0645\\u0627\\u0631\\u064a\\u0646\\u0647\\u0645.\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(42, 21, 21, 'الضيافة والخدمات الاستثنائية', '[\"\\u0641\\u0631\\u064a\\u0642 \\u0639\\u0645\\u0644 \\u0648\\u062f\\u0648\\u062f \\u0648\\u064a\\u0642\\u0638 \\u0645\\u0643\\u0631\\u0633 \\u0644\\u062a\\u0642\\u062f\\u064a\\u0645 \\u062e\\u062f\\u0645\\u0629 \\u0634\\u062e\\u0635\\u064a\\u0629 \\u0648\\u0636\\u0645\\u0627\\u0646 \\u0631\\u0636\\u0627 \\u0627\\u0644\\u0636\\u064a\\u0648\\u0641.\",\"\\u0645\\u0643\\u062a\\u0628 \\u0643\\u0648\\u0646\\u0633\\u064a\\u0631\\u062c \\u0644\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u062a\\u0631\\u062a\\u064a\\u0628 \\u0627\\u0644\\u0631\\u062d\\u0644\\u0627\\u062a \\u0627\\u0644\\u0627\\u0633\\u062a\\u0643\\u0634\\u0627\\u0641\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0646\\u0642\\u0644 \\u0648\\u062d\\u062c\\u0648\\u0632\\u0627\\u062a \\u0627\\u0644\\u0645\\u0637\\u0627\\u0639\\u0645.\",\"\\u062e\\u062f\\u0645\\u0629 \\u0627\\u0644\\u063a\\u0631\\u0641 \\u0639\\u0644\\u0649 \\u0645\\u062f\\u0627\\u0631 24 \\u0633\\u0627\\u0639\\u0629 \\u0644\\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0636\\u064a\\u0648\\u0641\\u060c \\u062d\\u064a\\u062b \\u062a\\u0642\\u062f\\u0645 \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062e\\u062a\\u0627\\u0631\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0627\\u0644\\u0644\\u0630\\u064a\\u0630\\u0629 \\u0648\\u0627\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0627\\u0644\\u062e\\u0641\\u064a\\u0641\\u0629.\",\"\\u0648\\u0633\\u0627\\u0626\\u0644 \\u0631\\u0627\\u062d\\u0629 \\u062e\\u0627\\u0635\\u0629 \\u0644\\u0644\\u0639\\u0627\\u0626\\u0644\\u0627\\u062a \\u0648\\u0627\\u0644\\u0623\\u0632\\u0648\\u0627\\u062c \\u0648\\u0627\\u0644\\u0645\\u0633\\u0627\\u0641\\u0631\\u064a\\u0646 \\u0645\\u0646 \\u0631\\u062c\\u0627\\u0644 \\u0627\\u0644\\u0623\\u0639\\u0645\\u0627\\u0644 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u062a\\u062c\\u0631\\u0628\\u0629 \\u0625\\u0642\\u0627\\u0645\\u062a\\u0647\\u0645.\"]', '2024-05-02 02:43:26', '2024-05-02 02:43:26'),
(43, 22, 20, 'Scenic Location', '[\"Breathtaking Views\",\"Outdoor Seating\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(44, 23, 20, 'Culinary Excellence', '[\"Authentic Pakistani Cuisine\",\"Global Influences\",\"Seasonal Menus\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(45, 24, 20, 'Warm Hospitality', '[\"Attentive Service\",\"Welcoming Ambiance\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(46, 25, 20, 'Amenities for Enhanced Experience', '[\"Private Dining Rooms\",\"Live Entertainment\",\"Free Wi-Fi\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(47, 26, 20, 'Commitment to Sustainability', '[\"Locally Sourced Ingredients\",\"Waste Reduction Initiatives\",\"Community Engagement\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(48, 22, 21, 'الموقع ذو المناظر الخلابة', '[\"\\u0645\\u0646\\u0627\\u0638\\u0631 \\u062e\\u0644\\u0627\\u0628\\u0629\",\"\\u062c\\u0644\\u0648\\u0633 \\u0641\\u064a \\u0627\\u0644\\u0647\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0637\\u0644\\u0642\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(49, 23, 21, 'التميز الطهي', '[\"\\u0627\\u0644\\u0645\\u0637\\u0628\\u062e \\u0627\\u0644\\u0628\\u0627\\u0643\\u0633\\u062a\\u0627\\u0646\\u064a \\u0627\\u0644\\u0623\\u0635\\u064a\\u0644\",\"\\u0627\\u0644\\u062a\\u0623\\u062b\\u064a\\u0631\\u0627\\u062a \\u0627\\u0644\\u0639\\u0627\\u0644\\u0645\\u064a\\u0629\",\"\\u0627\\u0644\\u0642\\u0648\\u0627\\u0626\\u0645 \\u0627\\u0644\\u0645\\u0648\\u0633\\u0645\\u064a\\u0629\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(50, 24, 21, 'كرم الضيافة', '[\"\\u062e\\u062f\\u0645\\u0629 \\u0627\\u0644\\u064a\\u0642\\u0638\\u0629\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0627\\u0644\\u062a\\u0631\\u062d\\u064a\\u0628\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(51, 25, 21, 'وسائل الراحة لتجربة محسنة', '[\"\\u063a\\u0631\\u0641 \\u0637\\u0639\\u0627\\u0645 \\u062e\\u0627\\u0635\\u0629\",\"\\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u062a\\u0631\\u0641\\u0647\\u064a\\u0647 \\u062d\\u064a\\u0629\",\"\\u0648\\u0627\\u0649 \\u0641\\u0627\\u0649 \\u0645\\u062c\\u0627\\u0646\\u0649\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(52, 26, 21, 'الالتزام بالاستدامة', '[\"\\u0627\\u0644\\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629\",\"\\u0645\\u0628\\u0627\\u062f\\u0631\\u0627\\u062a \\u0627\\u0644\\u062d\\u062f \\u0645\\u0646 \\u0627\\u0644\\u0646\\u0641\\u0627\\u064a\\u0627\\u062a\",\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\\u064a\\u0629\"]', '2024-05-05 21:08:51', '2024-05-05 21:08:51'),
(53, 27, 20, 'Premium Vehicle Selection', '[\"Wide range of luxury and performance vehicles from renowned brands.\",\"Constantly updated inventory to offer the latest models and variants.\",\"Rigorous inspection and quality assurance processes to ensure the highest standards.\",\"Exclusive access to limited edition and special edition models.\",\"Varied options including sports cars, sedans, SUVs, and exotic vehicles.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(54, 28, 20, 'Exceptional Customer Service', '[\"Knowledgeable and attentive sales staff to assist customers throughout the purchasing process.\",\"Personalized consultations to understand each customer\'s needs and preferences.\",\"Transparent pricing and financing options with clear explanations.\",\"Post-sale support and assistance with vehicle maintenance and upgrades.\",\"Prompt responses to inquiries and inquiries via multiple communication channels.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(55, 29, 20, 'State-of-the-Art Service Center', '[\"Factory-trained technicians with expertise in servicing luxury and high-performance vehicles.\",\"Advanced diagnostic equipment and tools to accurately identify and resolve issues.\",\"Comprehensive maintenance packages tailored to different vehicle models and mileage intervals.\",\"Genuine OEM parts and accessories to maintain original performance and reliability.\",\"Efficient turnaround times to minimize inconvenience for customers.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(56, 30, 20, 'Luxurious Showroom and Facilities', '[\"Elegant showroom ambiance with modern design and comfortable seating areas.\",\"Impeccably maintained facilities showcasing vehicles in a visually appealing manner.\",\"Interactive displays and multimedia presentations to highlight key features and technologies.\",\"Private VIP lounge for exclusive consultations and demonstrations.\",\"Accessible location with ample parking and convenient amenities nearby.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(57, 31, 20, 'Comprehensive Warranty and Coverage', '[\"Extensive warranty options covering various components and systems of the vehicle.\",\"Additional protection plans available for extended peace of mind.\",\"Clear terms and conditions with no hidden fees or surprises.\",\"Assistance with warranty claims and service coordination for hassle-free repairs.\",\"Regular updates and reminders about warranty expiration and renewal options.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(58, 32, 20, 'Community Engagement and Events', '[\"Participation in local automotive events and car shows to engage with enthusiasts.\",\"Sponsorship of charity drives, fundraisers, and community outreach programs.\",\"Exclusive owner\'s clubs and enthusiast gatherings to foster a sense of community.\",\"Educational workshops and seminars on vehicle maintenance, performance tuning, and driving techniques.\",\"Social media presence with behind-the-scenes insights, customer spotlights, and event coverage.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(59, 33, 20, 'Technology Integration and Innovation', '[\"Integration of cutting-edge technology features in showroom displays and customer interactions.\",\"Virtual showroom tours and online configurators for remote browsing and customization.\",\"Mobile apps for scheduling service appointments, tracking vehicle maintenance, and accessing exclusive offers.\",\"Implementation of digital marketing strategies to reach a broader audience and enhance customer engagement.\",\"Investment in research and development to anticipate future trends and customer preferences.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(60, 34, 20, 'Environmental Sustainability Initiatives', '[\"Commitment to eco-friendly practices such as energy-efficient lighting and recycling programs.\",\"Promotion of hybrid and electric vehicle options to reduce carbon footprint.\",\"Collaboration with environmentally conscious suppliers and partners.\",\"Education and advocacy for sustainable driving habits and vehicle maintenance.\",\"Continuous improvement efforts to minimize environmental impact across all aspects of operations.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(61, 27, 21, 'اختيار السيارة المتميزة', '[\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0641\\u0627\\u062e\\u0631\\u0629 \\u0648\\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0645\\u0646 \\u0627\\u0644\\u0639\\u0644\\u0627\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u062c\\u0627\\u0631\\u064a\\u0629 \\u0627\\u0644\\u0634\\u0647\\u064a\\u0631\\u0629.\",\"\\u064a\\u062a\\u0645 \\u062a\\u062d\\u062f\\u064a\\u062b \\u0627\\u0644\\u0645\\u062e\\u0632\\u0648\\u0646 \\u0628\\u0627\\u0633\\u062a\\u0645\\u0631\\u0627\\u0631 \\u0644\\u062a\\u0642\\u062f\\u064a\\u0645 \\u0623\\u062d\\u062f\\u062b \\u0627\\u0644\\u0645\\u0648\\u062f\\u064a\\u0644\\u0627\\u062a \\u0648\\u0627\\u0644\\u0645\\u062a\\u063a\\u064a\\u0631\\u0627\\u062a.\",\"\\u0639\\u0645\\u0644\\u064a\\u0627\\u062a \\u062a\\u0641\\u062a\\u064a\\u0634 \\u0635\\u0627\\u0631\\u0645\\u0629 \\u0648\\u0636\\u0645\\u0627\\u0646 \\u0627\\u0644\\u062c\\u0648\\u062f\\u0629 \\u0644\\u0636\\u0645\\u0627\\u0646 \\u0623\\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u0639\\u0627\\u064a\\u064a\\u0631.\",\"\\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0627\\u0644\\u062d\\u0635\\u0631\\u064a \\u0625\\u0644\\u0649 \\u0637\\u0628\\u0639\\u0629 \\u0645\\u062d\\u062f\\u0648\\u062f\\u0629 \\u0648\\u0646\\u0645\\u0627\\u0630\\u062c \\u0637\\u0628\\u0639\\u0629 \\u062e\\u0627\\u0635\\u0629.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u062a\\u0634\\u0645\\u0644 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0631\\u064a\\u0627\\u0636\\u064a\\u0629 \\u0648\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0633\\u064a\\u062f\\u0627\\u0646 \\u0648\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u062f\\u0641\\u0639 \\u0627\\u0644\\u0631\\u0628\\u0627\\u0639\\u064a \\u0648\\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0627\\u0644\\u063a\\u0631\\u064a\\u0628\\u0629.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(62, 28, 21, 'خدمة عملاء استثنائية', '[\"\\u0645\\u0648\\u0638\\u0641\\u0648 \\u0627\\u0644\\u0645\\u0628\\u064a\\u0639\\u0627\\u062a \\u0630\\u0648\\u064a \\u0627\\u0644\\u0645\\u0639\\u0631\\u0641\\u0629 \\u0648\\u0627\\u0644\\u064a\\u0642\\u0638\\u0629 \\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0637\\u0648\\u0627\\u0644 \\u0639\\u0645\\u0644\\u064a\\u0629 \\u0627\\u0644\\u0634\\u0631\\u0627\\u0621.\",\"\\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a \\u0634\\u062e\\u0635\\u064a\\u0629 \\u0644\\u0641\\u0647\\u0645 \\u0627\\u062d\\u062a\\u064a\\u0627\\u062c\\u0627\\u062a \\u0648\\u062a\\u0641\\u0636\\u064a\\u0644\\u0627\\u062a \\u0643\\u0644 \\u0639\\u0645\\u064a\\u0644.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u062a\\u0633\\u0639\\u064a\\u0631 \\u0648\\u062a\\u0645\\u0648\\u064a\\u0644 \\u0634\\u0641\\u0627\\u0641\\u0629 \\u0645\\u0639 \\u062a\\u0641\\u0633\\u064a\\u0631\\u0627\\u062a \\u0648\\u0627\\u0636\\u062d\\u0629.\",\"\\u062f\\u0639\\u0645 \\u0645\\u0627 \\u0628\\u0639\\u062f \\u0627\\u0644\\u0628\\u064a\\u0639 \\u0648\\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u0635\\u064a\\u0627\\u0646\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0648\\u062a\\u0631\\u0642\\u064a\\u0627\\u062a\\u0647\\u0627.\",\"\\u0631\\u062f\\u0648\\u062f \\u0633\\u0631\\u064a\\u0639\\u0629 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0627\\u0633\\u062a\\u0641\\u0633\\u0627\\u0631\\u0627\\u062a \\u0648\\u0627\\u0644\\u0627\\u0633\\u062a\\u0641\\u0633\\u0627\\u0631\\u0627\\u062a \\u0639\\u0628\\u0631 \\u0642\\u0646\\u0648\\u0627\\u062a \\u0627\\u0644\\u0627\\u062a\\u0635\\u0627\\u0644 \\u0627\\u0644\\u0645\\u062a\\u0639\\u062f\\u062f\\u0629.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(63, 29, 21, 'مركز خدمة على أحدث طراز', '[\"\\u0641\\u0646\\u064a\\u0648\\u0646 \\u0645\\u062f\\u0631\\u0628\\u0648\\u0646 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0635\\u0646\\u0639 \\u0648\\u0630\\u0648\\u0648 \\u062e\\u0628\\u0631\\u0629 \\u0641\\u064a \\u062e\\u062f\\u0645\\u0629 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0641\\u0627\\u062e\\u0631\\u0629 \\u0648\\u0639\\u0627\\u0644\\u064a\\u0629 \\u0627\\u0644\\u0623\\u062f\\u0627\\u0621.\",\"\\u0645\\u0639\\u062f\\u0627\\u062a \\u0648\\u0623\\u062f\\u0648\\u0627\\u062a \\u062a\\u0634\\u062e\\u064a\\u0635\\u064a\\u0629 \\u0645\\u062a\\u0642\\u062f\\u0645\\u0629 \\u0644\\u062a\\u062d\\u062f\\u064a\\u062f \\u0627\\u0644\\u0645\\u0634\\u0643\\u0644\\u0627\\u062a \\u0648\\u062d\\u0644\\u0647\\u0627 \\u0628\\u062f\\u0642\\u0629.\",\"\\u062d\\u0632\\u0645 \\u0635\\u064a\\u0627\\u0646\\u0629 \\u0634\\u0627\\u0645\\u0644\\u0629 \\u0645\\u0635\\u0645\\u0645\\u0629 \\u062e\\u0635\\u064a\\u0635\\u064b\\u0627 \\u0644\\u0645\\u062e\\u062a\\u0644\\u0641 \\u0637\\u0631\\u0627\\u0632\\u0627\\u062a \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0648\\u0627\\u0644\\u0641\\u062a\\u0631\\u0627\\u062a \\u0627\\u0644\\u0645\\u0642\\u0637\\u0648\\u0639\\u0629.\",\"\\u0642\\u0637\\u0639 \\u063a\\u064a\\u0627\\u0631 \\u0648\\u0645\\u0644\\u062d\\u0642\\u0627\\u062a \\u0623\\u0635\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0635\\u0627\\u0646\\u0639\\u064a \\u0627\\u0644\\u0642\\u0637\\u0639 \\u0627\\u0644\\u0623\\u0635\\u0644\\u064a\\u0629 \\u0644\\u0644\\u062d\\u0641\\u0627\\u0638 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0627\\u0644\\u0623\\u0635\\u0644\\u064a \\u0648\\u0627\\u0644\\u0645\\u0648\\u062b\\u0648\\u0642\\u064a\\u0629.\",\"\\u0623\\u0648\\u0642\\u0627\\u062a \\u062a\\u0633\\u0644\\u064a\\u0645 \\u0641\\u0639\\u0627\\u0644\\u0629 \\u0644\\u062a\\u0642\\u0644\\u064a\\u0644 \\u0627\\u0644\\u0625\\u0632\\u0639\\u0627\\u062c \\u0644\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(64, 30, 21, 'صالة عرض ومرافق فاخرة', '[\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0635\\u0627\\u0644\\u0629 \\u0639\\u0631\\u0636 \\u0623\\u0646\\u064a\\u0642\\u0629 \\u0630\\u0627\\u062a \\u062a\\u0635\\u0645\\u064a\\u0645 \\u0639\\u0635\\u0631\\u064a \\u0648\\u0645\\u0646\\u0627\\u0637\\u0642 \\u062c\\u0644\\u0648\\u0633 \\u0645\\u0631\\u064a\\u062d\\u0629.\",\"\\u0645\\u0631\\u0627\\u0641\\u0642 \\u062a\\u0645\\u062a \\u0635\\u064a\\u0627\\u0646\\u062a\\u0647\\u0627 \\u0628\\u062f\\u0642\\u0629 \\u0648\\u062a\\u0639\\u0631\\u0636 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0628\\u0637\\u0631\\u064a\\u0642\\u0629 \\u062c\\u0630\\u0627\\u0628\\u0629 \\u0628\\u0635\\u0631\\u064a\\u064b\\u0627.\",\"\\u0634\\u0627\\u0634\\u0627\\u062a \\u062a\\u0641\\u0627\\u0639\\u0644\\u064a\\u0629 \\u0648\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0648\\u0633\\u0627\\u0626\\u0637 \\u0627\\u0644\\u0645\\u062a\\u0639\\u062f\\u062f\\u0629 \\u0644\\u062a\\u0633\\u0644\\u064a\\u0637 \\u0627\\u0644\\u0636\\u0648\\u0621 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u0648\\u0627\\u0644\\u062a\\u0642\\u0646\\u064a\\u0627\\u062a \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629.\",\"\\u0635\\u0627\\u0644\\u0629 \\u062e\\u0627\\u0635\\u0629 \\u0644\\u0643\\u0628\\u0627\\u0631 \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0627\\u062a \\u0644\\u0644\\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a \\u0648\\u0627\\u0644\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u062d\\u0635\\u0631\\u064a\\u0629.\",\"\\u0645\\u0648\\u0642\\u0639 \\u064a\\u0633\\u0647\\u0644 \\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u064a\\u0647 \\u0645\\u0639 \\u0645\\u0648\\u0642\\u0641 \\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0648\\u0627\\u0633\\u0639 \\u0648\\u0648\\u0633\\u0627\\u0626\\u0644 \\u0631\\u0627\\u062d\\u0629 \\u0645\\u0631\\u064a\\u062d\\u0629 \\u0628\\u0627\\u0644\\u062c\\u0648\\u0627\\u0631.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(65, 31, 21, 'ضمان وتغطية شاملة', '[\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0636\\u0645\\u0627\\u0646 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0627\\u0644\\u0646\\u0637\\u0627\\u0642 \\u062a\\u063a\\u0637\\u064a \\u0645\\u062e\\u062a\\u0644\\u0641 \\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0648\\u0623\\u0646\\u0638\\u0645\\u0629 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0629.\",\"\\u062a\\u062a\\u0648\\u0641\\u0631 \\u062e\\u0637\\u0637 \\u062d\\u0645\\u0627\\u064a\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 \\u0644\\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0628\\u0627\\u0644 \\u0627\\u0644\\u0645\\u0645\\u062a\\u062f\\u0629.\",\"\\u0634\\u0631\\u0648\\u0637 \\u0648\\u0623\\u062d\\u0643\\u0627\\u0645 \\u0648\\u0627\\u0636\\u062d\\u0629 \\u0628\\u062f\\u0648\\u0646 \\u0623\\u064a \\u0631\\u0633\\u0648\\u0645 \\u0623\\u0648 \\u0645\\u0641\\u0627\\u062c\\u0622\\u062a \\u0645\\u062e\\u0641\\u064a\\u0629.\",\"\\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u0645\\u0637\\u0627\\u0644\\u0628\\u0627\\u062a \\u0627\\u0644\\u0636\\u0645\\u0627\\u0646 \\u0648\\u062a\\u0646\\u0633\\u064a\\u0642 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0629 \\u0644\\u0625\\u062c\\u0631\\u0627\\u0621 \\u0625\\u0635\\u0644\\u0627\\u062d\\u0627\\u062a \\u062e\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u062a\\u0627\\u0639\\u0628.\",\"\\u062a\\u062d\\u062f\\u064a\\u062b\\u0627\\u062a \\u0648\\u062a\\u0630\\u0643\\u064a\\u0631\\u0627\\u062a \\u0645\\u0646\\u062a\\u0638\\u0645\\u0629 \\u062d\\u0648\\u0644 \\u0627\\u0646\\u062a\\u0647\\u0627\\u0621 \\u0627\\u0644\\u0636\\u0645\\u0627\\u0646 \\u0648\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u062a\\u062c\\u062f\\u064a\\u062f.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(66, 32, 21, 'المشاركة المجتمعية والأحداث', '[\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0641\\u064a \\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u0629 \\u0648\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0644\\u0644\\u062a\\u0648\\u0627\\u0635\\u0644 \\u0645\\u0639 \\u0627\\u0644\\u0645\\u062a\\u062d\\u0645\\u0633\\u064a\\u0646.\",\"\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u062d\\u0645\\u0644\\u0627\\u062a \\u0627\\u0644\\u062e\\u064a\\u0631\\u064a\\u0629 \\u0648\\u062c\\u0645\\u0639 \\u0627\\u0644\\u062a\\u0628\\u0631\\u0639\\u0627\\u062a \\u0648\\u0628\\u0631\\u0627\\u0645\\u062c \\u0627\\u0644\\u062a\\u0648\\u0639\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\\u064a\\u0629.\",\"\\u0646\\u0648\\u0627\\u062f\\u064a \\u0627\\u0644\\u0645\\u0627\\u0644\\u0643 \\u0627\\u0644\\u062d\\u0635\\u0631\\u064a\\u0629 \\u0648\\u062a\\u062c\\u0645\\u0639\\u0627\\u062a \\u0627\\u0644\\u0645\\u062a\\u062d\\u0645\\u0633\\u064a\\u0646 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0627\\u0644\\u0634\\u0639\\u0648\\u0631 \\u0628\\u0627\\u0644\\u0627\\u0646\\u062a\\u0645\\u0627\\u0621 \\u0644\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639.\",\"\\u0648\\u0631\\u0634 \\u0639\\u0645\\u0644 \\u0648\\u0646\\u062f\\u0648\\u0627\\u062a \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u062d\\u0648\\u0644 \\u0635\\u064a\\u0627\\u0646\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0648\\u0636\\u0628\\u0637 \\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0648\\u062a\\u0642\\u0646\\u064a\\u0627\\u062a \\u0627\\u0644\\u0642\\u064a\\u0627\\u062f\\u0629.\",\"\\u0627\\u0644\\u062a\\u0648\\u0627\\u062c\\u062f \\u0639\\u0644\\u0649 \\u0648\\u0633\\u0627\\u0626\\u0644 \\u0627\\u0644\\u062a\\u0648\\u0627\\u0635\\u0644 \\u0627\\u0644\\u0627\\u062c\\u062a\\u0645\\u0627\\u0639\\u064a \\u0645\\u0639 \\u0631\\u0624\\u0649 \\u0645\\u0646 \\u0648\\u0631\\u0627\\u0621 \\u0627\\u0644\\u0643\\u0648\\u0627\\u0644\\u064a\\u0633 \\u0648\\u0623\\u0636\\u0648\\u0627\\u0621 \\u0643\\u0627\\u0634\\u0641\\u0629 \\u0644\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0648\\u062a\\u063a\\u0637\\u064a\\u0629 \\u0627\\u0644\\u0623\\u062d\\u062f\\u0627\\u062b.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(67, 33, 21, 'التكامل التكنولوجي والابتكار', '[\"\\u062f\\u0645\\u062c \\u0645\\u064a\\u0632\\u0627\\u062a \\u0627\\u0644\\u062a\\u0643\\u0646\\u0648\\u0644\\u0648\\u062c\\u064a\\u0627 \\u0627\\u0644\\u0645\\u062a\\u0637\\u0648\\u0631\\u0629 \\u0641\\u064a \\u0634\\u0627\\u0634\\u0627\\u062a \\u0627\\u0644\\u0639\\u0631\\u0636 \\u0648\\u062a\\u0641\\u0627\\u0639\\u0644\\u0627\\u062a \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621.\",\"\\u062c\\u0648\\u0644\\u0627\\u062a \\u0635\\u0627\\u0644\\u0629 \\u0627\\u0644\\u0639\\u0631\\u0636 \\u0627\\u0644\\u0627\\u0641\\u062a\\u0631\\u0627\\u0636\\u064a\\u0629 \\u0648\\u0623\\u062f\\u0648\\u0627\\u062a \\u0627\\u0644\\u062a\\u0643\\u0648\\u064a\\u0646 \\u0639\\u0628\\u0631 \\u0627\\u0644\\u0625\\u0646\\u062a\\u0631\\u0646\\u062a \\u0644\\u0644\\u062a\\u0635\\u0641\\u062d \\u0648\\u0627\\u0644\\u062a\\u062e\\u0635\\u064a\\u0635 \\u0639\\u0646 \\u0628\\u0639\\u062f.\",\"\\u062a\\u0637\\u0628\\u064a\\u0642\\u0627\\u062a \\u0627\\u0644\\u0647\\u0627\\u062a\\u0641 \\u0627\\u0644\\u0645\\u062d\\u0645\\u0648\\u0644 \\u0644\\u062c\\u062f\\u0648\\u0644\\u0629 \\u0645\\u0648\\u0627\\u0639\\u064a\\u062f \\u0627\\u0644\\u062e\\u062f\\u0645\\u0629 \\u0648\\u062a\\u062a\\u0628\\u0639 \\u0635\\u064a\\u0627\\u0646\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0648\\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0627\\u0644\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u062d\\u0635\\u0631\\u064a\\u0629.\",\"\\u062a\\u0646\\u0641\\u064a\\u0630 \\u0627\\u0633\\u062a\\u0631\\u0627\\u062a\\u064a\\u062c\\u064a\\u0627\\u062a \\u0627\\u0644\\u062a\\u0633\\u0648\\u064a\\u0642 \\u0627\\u0644\\u0631\\u0642\\u0645\\u064a \\u0644\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u062c\\u0645\\u0647\\u0648\\u0631 \\u0623\\u0648\\u0633\\u0639 \\u0648\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621.\",\"\\u0627\\u0644\\u0627\\u0633\\u062a\\u062b\\u0645\\u0627\\u0631 \\u0641\\u064a \\u0627\\u0644\\u0628\\u062d\\u062b \\u0648\\u0627\\u0644\\u062a\\u0637\\u0648\\u064a\\u0631 \\u0644\\u062a\\u0648\\u0642\\u0639 \\u0627\\u0644\\u0627\\u062a\\u062c\\u0627\\u0647\\u0627\\u062a \\u0627\\u0644\\u0645\\u0633\\u062a\\u0642\\u0628\\u0644\\u064a\\u0629 \\u0648\\u062a\\u0641\\u0636\\u064a\\u0644\\u0627\\u062a \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(68, 34, 21, 'مبادرات الاستدامة البيئية', '[\"\\u0627\\u0644\\u0627\\u0644\\u062a\\u0632\\u0627\\u0645 \\u0628\\u0627\\u0644\\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0627\\u0644\\u0635\\u062f\\u064a\\u0642\\u0629 \\u0644\\u0644\\u0628\\u064a\\u0626\\u0629 \\u0645\\u062b\\u0644 \\u0627\\u0644\\u0625\\u0636\\u0627\\u0621\\u0629 \\u0627\\u0644\\u0645\\u0648\\u0641\\u0631\\u0629 \\u0644\\u0644\\u0637\\u0627\\u0642\\u0629 \\u0648\\u0628\\u0631\\u0627\\u0645\\u062c \\u0625\\u0639\\u0627\\u062f\\u0629 \\u0627\\u0644\\u062a\\u062f\\u0648\\u064a\\u0631.\",\"\\u0627\\u0644\\u062a\\u0631\\u0648\\u064a\\u062c \\u0644\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0647\\u062c\\u064a\\u0646\\u0629 \\u0648\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0626\\u064a\\u0629 \\u0644\\u062a\\u0642\\u0644\\u064a\\u0644 \\u0627\\u0644\\u0628\\u0635\\u0645\\u0629 \\u0627\\u0644\\u0643\\u0631\\u0628\\u0648\\u0646\\u064a\\u0629.\",\"\\u0627\\u0644\\u062a\\u0639\\u0627\\u0648\\u0646 \\u0645\\u0639 \\u0627\\u0644\\u0645\\u0648\\u0631\\u062f\\u064a\\u0646 \\u0648\\u0627\\u0644\\u0634\\u0631\\u0643\\u0627\\u0621 \\u0627\\u0644\\u0645\\u0647\\u062a\\u0645\\u064a\\u0646 \\u0628\\u0627\\u0644\\u0628\\u064a\\u0626\\u0629.\",\"\\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645 \\u0648\\u0627\\u0644\\u062f\\u0639\\u0648\\u0629 \\u0644\\u0639\\u0627\\u062f\\u0627\\u062a \\u0627\\u0644\\u0642\\u064a\\u0627\\u062f\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062f\\u0627\\u0645\\u0629 \\u0648\\u0635\\u064a\\u0627\\u0646\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a.\",\"\\u062c\\u0647\\u0648\\u062f \\u0627\\u0644\\u062a\\u062d\\u0633\\u064a\\u0646 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0645\\u0631 \\u0644\\u062a\\u0642\\u0644\\u064a\\u0644 \\u0627\\u0644\\u062a\\u0623\\u062b\\u064a\\u0631 \\u0627\\u0644\\u0628\\u064a\\u0626\\u064a \\u0641\\u064a \\u062c\\u0645\\u064a\\u0639 \\u062c\\u0648\\u0627\\u0646\\u0628 \\u0627\\u0644\\u0639\\u0645\\u0644\\u064a\\u0627\\u062a.\"]', '2024-05-05 22:08:08', '2024-05-05 22:08:08'),
(69, 35, 20, 'Riverside Luxury Living', '[\"Prime location along the scenic shores of the St. Johns River.\",\"Unobstructed panoramic views of the river and surrounding natural beauty.\",\"Serene and tranquil atmosphere away from the hustle and bustle of city life.\",\"Access to recreational water activities such as boating, kayaking, and fishing.\",\"Opportunities for waterfront dining and entertainment within close proximity.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(70, 36, 20, 'Exquisite Residences', '[\"Spacious floor plans with open layouts and abundant natural light.\",\"High-end finishes including hardwood floors, granite countertops, and designer fixtures.\",\"Expansive windows and private balconies offering breathtaking views of the river.\",\"Gourmet kitchens equipped with top-of-the-line appliances and custom cabinetry.\",\"Luxurious master suites with walk-in closets and spa-inspired bathrooms.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(71, 37, 20, 'World-Class Amenities', '[\"Infinity-edge pool overlooking the river with expansive sundeck and cabanas.\",\"Fully-equipped fitness center with cardio machines, weights, and yoga studio.\",\"Elegant clubhouse with catering kitchen, lounge area, and billiards room.\",\"Professionally landscaped gardens, walking trails, and outdoor recreation areas.\",\"On-site concierge services offering assistance with reservations, event planning, and more.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(72, 38, 20, 'Community Engagement', '[\"Regularly scheduled social events and gatherings for residents to connect and mingle.\",\"Community-focused initiatives such as volunteer opportunities and charity drives.\",\"Resident-led clubs and interest groups catering to a variety of hobbies and interests.\",\"On-site management team dedicated to fostering a sense of community and belonging.\",\"Pet-friendly policies and amenities including a designated dog park and pet washing station.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(73, 39, 20, 'Convenient Location', '[\"Easy access to major highways, shopping centers, dining options, and entertainment venues.\",\"Proximity to top-rated schools, medical facilities, and recreational amenities.\",\"Close-knit neighborhood with a strong sense of community and camaraderie.\",\"Public transportation options nearby for convenient travel throughout the city.\",\"Peaceful and secure environment with gated access and 24\\/7 security surveillance.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(74, 40, 20, 'Luxury Lifestyle Services', '[\"Personalized concierge services including package delivery, dry cleaning, and grocery shopping.\",\"In-home spa treatments, personal training sessions, and private chef services available upon request.\",\"Complimentary valet parking for residents and guests.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(75, 41, 20, 'Sustainable Living Initiatives', '[\"Energy-efficient building design and eco-friendly construction materials.\",\"On-site electric vehicle charging stations and bike storage facilities to promote alternative transportation.\",\"Educational workshops and resources focused on sustainable living practices for residents.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(76, 35, 21, 'ريفرسايد للمعيشة الفاخرة', '[\"\\u0645\\u0648\\u0642\\u0639 \\u0645\\u062a\\u0645\\u064a\\u0632 \\u0639\\u0644\\u0649 \\u0637\\u0648\\u0644 \\u0627\\u0644\\u0634\\u0648\\u0627\\u0637\\u0626 \\u0630\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0627\\u0638\\u0631 \\u0627\\u0644\\u062e\\u0644\\u0627\\u0628\\u0629 \\u0644\\u0646\\u0647\\u0631 \\u0633\\u0627\\u0646\\u062a \\u062c\\u0648\\u0646\\u0632.\",\"\\u0625\\u0637\\u0644\\u0627\\u0644\\u0627\\u062a \\u0628\\u0627\\u0646\\u0648\\u0631\\u0627\\u0645\\u064a\\u0629 \\u062f\\u0648\\u0646 \\u0639\\u0627\\u0626\\u0642 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0646\\u0647\\u0631 \\u0648\\u0627\\u0644\\u062c\\u0645\\u0627\\u0644 \\u0627\\u0644\\u0637\\u0628\\u064a\\u0639\\u064a \\u0627\\u0644\\u0645\\u062d\\u064a\\u0637.\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0647\\u0627\\u062f\\u0626\\u0629 \\u0648\\u0647\\u0627\\u062f\\u0626\\u0629 \\u0628\\u0639\\u064a\\u062f\\u064b\\u0627 \\u0639\\u0646 \\u0635\\u062e\\u0628 \\u0627\\u0644\\u062d\\u064a\\u0627\\u0629 \\u0641\\u064a \\u0627\\u0644\\u0645\\u062f\\u064a\\u0646\\u0629.\",\"\\u0625\\u0645\\u0643\\u0627\\u0646\\u064a\\u0629 \\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0627\\u0644\\u0623\\u0646\\u0634\\u0637\\u0629 \\u0627\\u0644\\u0645\\u0627\\u0626\\u064a\\u0629 \\u0627\\u0644\\u062a\\u0631\\u0641\\u064a\\u0647\\u064a\\u0629 \\u0645\\u062b\\u0644 \\u0631\\u0643\\u0648\\u0628 \\u0627\\u0644\\u0642\\u0648\\u0627\\u0631\\u0628 \\u0648\\u0627\\u0644\\u062a\\u062c\\u062f\\u064a\\u0641 \\u0628\\u0627\\u0644\\u0643\\u0627\\u064a\\u0627\\u0643 \\u0648\\u0635\\u064a\\u062f \\u0627\\u0644\\u0623\\u0633\\u0645\\u0627\\u0643.\",\"\\u0641\\u0631\\u0635 \\u0644\\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0648\\u0627\\u0644\\u062a\\u0631\\u0641\\u064a\\u0647 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0648\\u0627\\u062c\\u0647\\u0629 \\u0627\\u0644\\u0628\\u062d\\u0631\\u064a\\u0629 \\u0639\\u0644\\u0649 \\u0645\\u0642\\u0631\\u0628\\u0629.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(77, 36, 21, 'مساكن رائعة', '[\"\\u0645\\u062e\\u0637\\u0637\\u0627\\u062a \\u0623\\u0631\\u0636\\u064a\\u0629 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0628\\u0645\\u062e\\u0637\\u0637\\u0627\\u062a \\u0645\\u0641\\u062a\\u0648\\u062d\\u0629 \\u0648\\u0625\\u0636\\u0627\\u0621\\u0629 \\u0637\\u0628\\u064a\\u0639\\u064a\\u0629 \\u0648\\u0641\\u064a\\u0631\\u0629.\",\"\\u062a\\u0634\\u0637\\u064a\\u0628\\u0627\\u062a \\u0631\\u0627\\u0642\\u064a\\u0629 \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u0627\\u0644\\u0623\\u0631\\u0636\\u064a\\u0627\\u062a \\u0627\\u0644\\u0635\\u0644\\u0628\\u0629 \\u0648\\u0623\\u0633\\u0637\\u062d \\u0627\\u0644\\u062c\\u0631\\u0627\\u0646\\u064a\\u062a \\u0648\\u0627\\u0644\\u062a\\u0631\\u0643\\u064a\\u0628\\u0627\\u062a \\u0627\\u0644\\u0645\\u0635\\u0645\\u0645\\u0629.\",\"\\u0646\\u0648\\u0627\\u0641\\u0630 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0648\\u0634\\u0631\\u0641\\u0627\\u062a \\u062e\\u0627\\u0635\\u0629 \\u062a\\u0648\\u0641\\u0631 \\u0625\\u0637\\u0644\\u0627\\u0644\\u0627\\u062a \\u062e\\u0644\\u0627\\u0628\\u0629 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0646\\u0647\\u0631.\",\"\\u0645\\u0637\\u0627\\u0628\\u062e \\u0630\\u0648\\u0627\\u0642\\u0629 \\u0645\\u062c\\u0647\\u0632\\u0629 \\u0628\\u0623\\u062d\\u062f\\u062b \\u0627\\u0644\\u0623\\u062c\\u0647\\u0632\\u0629 \\u0648\\u0627\\u0644\\u062e\\u0632\\u0627\\u0626\\u0646 \\u0627\\u0644\\u0645\\u062e\\u0635\\u0635\\u0629.\",\"\\u0623\\u062c\\u0646\\u062d\\u0629 \\u0631\\u0626\\u064a\\u0633\\u064a\\u0629 \\u0641\\u0627\\u062e\\u0631\\u0629 \\u0645\\u0639 \\u062d\\u062c\\u0631\\u0629 \\u0645\\u0644\\u0627\\u0628\\u0633 \\u0648\\u062d\\u0645\\u0627\\u0645\\u0627\\u062a \\u0645\\u0633\\u062a\\u0648\\u062d\\u0627\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0633\\u0628\\u0627.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11');
INSERT INTO `listing_feature_contents` (`id`, `listing_feature_id`, `language_id`, `feature_heading`, `feature_value`, `created_at`, `updated_at`) VALUES
(78, 37, 21, 'وسائل الراحة ذات المستوى العالمي', '[\"\\u062d\\u0645\\u0627\\u0645 \\u0633\\u0628\\u0627\\u062d\\u0629 \\u0644\\u0627 \\u0645\\u062a\\u0646\\u0627\\u0647\\u064a \\u064a\\u0637\\u0644 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0646\\u0647\\u0631 \\u0645\\u0639 \\u062a\\u0631\\u0627\\u0633 \\u0634\\u0645\\u0633\\u064a \\u0648\\u0627\\u0633\\u0639 \\u0648\\u0643\\u0628\\u0627\\u0626\\u0646.\",\"\\u0645\\u0631\\u0643\\u0632 \\u0644\\u064a\\u0627\\u0642\\u0629 \\u0628\\u062f\\u0646\\u064a\\u0629 \\u0645\\u062c\\u0647\\u0632 \\u0628\\u0627\\u0644\\u0643\\u0627\\u0645\\u0644 \\u0628\\u0623\\u062c\\u0647\\u0632\\u0629 \\u062a\\u0645\\u0627\\u0631\\u064a\\u0646 \\u0627\\u0644\\u0642\\u0644\\u0628 \\u0648\\u0627\\u0644\\u0623\\u0648\\u0632\\u0627\\u0646 \\u0648\\u0627\\u0633\\u062a\\u0648\\u062f\\u064a\\u0648 \\u0627\\u0644\\u064a\\u0648\\u063a\\u0627.\",\"\\u0646\\u0627\\u062f\\u064a \\u0623\\u0646\\u064a\\u0642 \\u064a\\u0636\\u0645 \\u0645\\u0637\\u0628\\u062e\\u064b\\u0627 \\u0644\\u062a\\u0642\\u062f\\u064a\\u0645 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0648\\u0645\\u0646\\u0637\\u0642\\u0629 \\u0635\\u0627\\u0644\\u0629 \\u0648\\u063a\\u0631\\u0641\\u0629 \\u0628\\u0644\\u064a\\u0627\\u0631\\u062f\\u0648.\",\"\\u062d\\u062f\\u0627\\u0626\\u0642 \\u0630\\u0627\\u062a \\u0645\\u0646\\u0627\\u0638\\u0631 \\u0637\\u0628\\u064a\\u0639\\u064a\\u0629 \\u0627\\u062d\\u062a\\u0631\\u0627\\u0641\\u064a\\u0629 \\u0648\\u0645\\u0633\\u0627\\u0631\\u0627\\u062a \\u0644\\u0644\\u0645\\u0634\\u064a \\u0648\\u0645\\u0646\\u0627\\u0637\\u0642 \\u062a\\u0631\\u0641\\u064a\\u0647\\u064a\\u0629 \\u062e\\u0627\\u0631\\u062c\\u064a\\u0629.\",\"\\u062a\\u0642\\u062f\\u0645 \\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0643\\u0648\\u0646\\u0633\\u064a\\u0631\\u062c \\u0641\\u064a \\u0627\\u0644\\u0645\\u0648\\u0642\\u0639 \\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u0627\\u0644\\u062d\\u062c\\u0648\\u0632\\u0627\\u062a \\u0648\\u062a\\u062e\\u0637\\u064a\\u0637 \\u0627\\u0644\\u0623\\u062d\\u062f\\u0627\\u062b \\u0648\\u0627\\u0644\\u0645\\u0632\\u064a\\u062f.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(79, 38, 21, 'المشاركة المجتمعية', '[\"\\u0627\\u0644\\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u0648\\u0627\\u0644\\u062a\\u062c\\u0645\\u0639\\u0627\\u062a \\u0627\\u0644\\u0627\\u062c\\u062a\\u0645\\u0627\\u0639\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062c\\u062f\\u0648\\u0644\\u0629 \\u0628\\u0627\\u0646\\u062a\\u0638\\u0627\\u0645 \\u0644\\u0644\\u0645\\u0642\\u064a\\u0645\\u064a\\u0646 \\u0644\\u0644\\u062a\\u0648\\u0627\\u0635\\u0644 \\u0648\\u0627\\u0644\\u0627\\u062e\\u062a\\u0644\\u0627\\u0637.\",\"\\u0627\\u0644\\u0645\\u0628\\u0627\\u062f\\u0631\\u0627\\u062a \\u0627\\u0644\\u062a\\u064a \\u062a\\u0631\\u0643\\u0632 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639 \\u0645\\u062b\\u0644 \\u0641\\u0631\\u0635 \\u0627\\u0644\\u062a\\u0637\\u0648\\u0639 \\u0648\\u0627\\u0644\\u062d\\u0645\\u0644\\u0627\\u062a \\u0627\\u0644\\u062e\\u064a\\u0631\\u064a\\u0629.\",\"\\u0627\\u0644\\u0646\\u0648\\u0627\\u062f\\u064a \\u0627\\u0644\\u062a\\u064a \\u064a\\u0642\\u0648\\u062f\\u0647\\u0627 \\u0627\\u0644\\u0645\\u0642\\u064a\\u0645\\u0648\\u0646 \\u0648\\u0645\\u062c\\u0645\\u0648\\u0639\\u0627\\u062a \\u0627\\u0644\\u0627\\u0647\\u062a\\u0645\\u0627\\u0645 \\u0627\\u0644\\u062a\\u064a \\u062a\\u0644\\u0628\\u064a \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0647\\u0648\\u0627\\u064a\\u0627\\u062a \\u0648\\u0627\\u0644\\u0627\\u0647\\u062a\\u0645\\u0627\\u0645\\u0627\\u062a.\",\"\\u0641\\u0631\\u064a\\u0642 \\u0625\\u062f\\u0627\\u0631\\u0629 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0648\\u0642\\u0639 \\u0645\\u062e\\u0635\\u0635 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0627\\u0644\\u0634\\u0639\\u0648\\u0631 \\u0628\\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639 \\u0648\\u0627\\u0644\\u0627\\u0646\\u062a\\u0645\\u0627\\u0621.\",\"\\u0627\\u0644\\u0633\\u064a\\u0627\\u0633\\u0627\\u062a \\u0648\\u0627\\u0644\\u0645\\u0631\\u0627\\u0641\\u0642 \\u0627\\u0644\\u0635\\u062f\\u064a\\u0642\\u0629 \\u0644\\u0644\\u062d\\u064a\\u0648\\u0627\\u0646\\u0627\\u062a \\u0627\\u0644\\u0623\\u0644\\u064a\\u0641\\u0629 \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u062d\\u062f\\u064a\\u0642\\u0629 \\u0645\\u062e\\u0635\\u0635\\u0629 \\u0644\\u0644\\u0643\\u0644\\u0627\\u0628 \\u0648\\u0645\\u062d\\u0637\\u0629 \\u0644\\u063a\\u0633\\u064a\\u0644 \\u0627\\u0644\\u062d\\u064a\\u0648\\u0627\\u0646\\u0627\\u062a \\u0627\\u0644\\u0623\\u0644\\u064a\\u0641\\u0629.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(80, 39, 21, 'موقع ملائم', '[\"\\u0633\\u0647\\u0648\\u0644\\u0629 \\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0627\\u0644\\u0637\\u0631\\u0642 \\u0627\\u0644\\u0633\\u0631\\u064a\\u0639\\u0629 \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629 \\u0648\\u0645\\u0631\\u0627\\u0643\\u0632 \\u0627\\u0644\\u062a\\u0633\\u0648\\u0642 \\u0648\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0648\\u0623\\u0645\\u0627\\u0643\\u0646 \\u0627\\u0644\\u062a\\u0631\\u0641\\u064a\\u0647.\",\"\\u0627\\u0644\\u0642\\u0631\\u0628 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u062f\\u0627\\u0631\\u0633 \\u0630\\u0627\\u062a \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641 \\u0627\\u0644\\u0639\\u0627\\u0644\\u064a \\u0648\\u0627\\u0644\\u0645\\u0631\\u0627\\u0641\\u0642 \\u0627\\u0644\\u0637\\u0628\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0645\\u0631\\u0627\\u0641\\u0642 \\u0627\\u0644\\u062a\\u0631\\u0641\\u064a\\u0647\\u064a\\u0629.\",\"\\u062d\\u064a \\u0645\\u062a\\u0645\\u0627\\u0633\\u0643 \\u064a\\u062a\\u0645\\u062a\\u0639 \\u0628\\u0625\\u062d\\u0633\\u0627\\u0633 \\u0642\\u0648\\u064a \\u0628\\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639 \\u0648\\u0627\\u0644\\u0635\\u062f\\u0627\\u0642\\u0629 \\u0627\\u0644\\u062d\\u0645\\u064a\\u0645\\u0629.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0646\\u0642\\u0644 \\u0627\\u0644\\u0639\\u0627\\u0645 \\u0627\\u0644\\u0642\\u0631\\u064a\\u0628\\u0629 \\u0644\\u0644\\u0633\\u0641\\u0631 \\u0627\\u0644\\u0645\\u0631\\u064a\\u062d \\u0641\\u064a \\u062c\\u0645\\u064a\\u0639 \\u0623\\u0646\\u062d\\u0627\\u0621 \\u0627\\u0644\\u0645\\u062f\\u064a\\u0646\\u0629.\",\"\\u0628\\u064a\\u0626\\u0629 \\u0633\\u0644\\u0645\\u064a\\u0629 \\u0648\\u0622\\u0645\\u0646\\u0629 \\u0645\\u0639 \\u0628\\u0648\\u0627\\u0628\\u0629 \\u062f\\u062e\\u0648\\u0644 \\u0648\\u0645\\u0631\\u0627\\u0642\\u0628\\u0629 \\u0623\\u0645\\u0646\\u064a\\u0629 \\u0639\\u0644\\u0649 \\u0645\\u062f\\u0627\\u0631 \\u0627\\u0644\\u0633\\u0627\\u0639\\u0629 \\u0637\\u0648\\u0627\\u0644 \\u0623\\u064a\\u0627\\u0645 \\u0627\\u0644\\u0623\\u0633\\u0628\\u0648\\u0639.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(81, 40, 21, 'خدمات نمط الحياة الفاخرة', '[\"\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0643\\u0648\\u0646\\u0633\\u064a\\u0631\\u062c \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629 \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u062a\\u0648\\u0635\\u064a\\u0644 \\u0627\\u0644\\u0637\\u0631\\u0648\\u062f \\u0648\\u0627\\u0644\\u062a\\u0646\\u0638\\u064a\\u0641 \\u0627\\u0644\\u062c\\u0627\\u0641 \\u0648\\u062a\\u0633\\u0648\\u0642 \\u0627\\u0644\\u0628\\u0642\\u0627\\u0644\\u0629.\",\"\\u062a\\u062a\\u0648\\u0641\\u0631 \\u0639\\u0644\\u0627\\u062c\\u0627\\u062a \\u0627\\u0644\\u0633\\u0628\\u0627 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0646\\u0632\\u0644 \\u0648\\u062c\\u0644\\u0633\\u0627\\u062a \\u0627\\u0644\\u062a\\u062f\\u0631\\u064a\\u0628 \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629 \\u0648\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0637\\u0647\\u0627\\u0629 \\u0627\\u0644\\u062e\\u0627\\u0635\\u0629 \\u0639\\u0646\\u062f \\u0627\\u0644\\u0637\\u0644\\u0628.\",\"\\u062e\\u062f\\u0645\\u0629 \\u0635\\u0641 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0645\\u062c\\u0627\\u0646\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0642\\u064a\\u0645\\u064a\\u0646 \\u0648\\u0627\\u0644\\u0636\\u064a\\u0648\\u0641.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(82, 41, 21, 'مبادرات المعيشة المستدامة', '[\"\\u062a\\u0635\\u0645\\u064a\\u0645 \\u0627\\u0644\\u0645\\u0628\\u0627\\u0646\\u064a \\u0627\\u0644\\u0645\\u0648\\u0641\\u0631\\u0629 \\u0644\\u0644\\u0637\\u0627\\u0642\\u0629 \\u0648\\u0645\\u0648\\u0627\\u062f \\u0627\\u0644\\u0628\\u0646\\u0627\\u0621 \\u0627\\u0644\\u0635\\u062f\\u064a\\u0642\\u0629 \\u0644\\u0644\\u0628\\u064a\\u0626\\u0629.\",\"\\u0645\\u062d\\u0637\\u0627\\u062a \\u0634\\u062d\\u0646 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0626\\u064a\\u0629 \\u0648\\u0645\\u0631\\u0627\\u0641\\u0642 \\u062a\\u062e\\u0632\\u064a\\u0646 \\u0627\\u0644\\u062f\\u0631\\u0627\\u062c\\u0627\\u062a \\u0641\\u064a \\u0627\\u0644\\u0645\\u0648\\u0642\\u0639 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0648\\u0633\\u0627\\u0626\\u0644 \\u0627\\u0644\\u0646\\u0642\\u0644 \\u0627\\u0644\\u0628\\u062f\\u064a\\u0644\\u0629.\",\"\\u062a\\u0631\\u0643\\u0632 \\u0648\\u0631\\u0634 \\u0627\\u0644\\u0639\\u0645\\u0644 \\u0648\\u0627\\u0644\\u0645\\u0648\\u0627\\u0631\\u062f \\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0639\\u0644\\u0649 \\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0627\\u0644\\u0645\\u0639\\u064a\\u0634\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062f\\u0627\\u0645\\u0629 \\u0644\\u0644\\u0645\\u0642\\u064a\\u0645\\u064a\\u0646.\"]', '2024-05-05 23:24:11', '2024-05-05 23:24:11'),
(97, 49, 20, 'Authentic Bengali Cuisine', '[\"Traditional recipes passed down through generations.\",\"Freshly ground spices for authentic flavors.\",\"Locally sourced ingredients for freshness.\",\"Menu showcases the diverse culinary heritage of Bangladesh.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(98, 50, 20, 'Warm Hospitality', '[\"Friendly and attentive staff.\",\"Welcoming ambiance with a cozy atmosphere.\",\"Personalized service for a memorable dining experience.\",\"Staff knowledgeable about the menu and able to make recommendations.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(99, 51, 20, 'Global Fusion Creations', '[\"Innovative dishes that blend Bengali flavors with global influences.\",\"Fusion cuisine inspired by international culinary trends.\",\"Creative reinterpretation of traditional favorites.\",\"Diverse menu caters to varied tastes and preferences.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(100, 52, 20, 'Fresh Seafood Selection', '[\"Daily deliveries of the freshest seafood from local markets.\",\"Expertly prepared dishes highlight the natural flavors of the sea.\",\"Extensive seafood menu featuring prawns, fish, and more.\",\"Options for grilled, fried, or curry preparations.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(101, 53, 20, 'Vegetarian Specialties', '[\"Abundant selection of vegetarian dishes.\",\"Fresh and flavorful vegetable curries and stir-fries.\",\"Paneer dishes showcasing homemade cheese and bold spices.\",\"Veggie thalis with a variety of sides for a complete meal.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(102, 54, 20, 'Cozy Ambiance', '[\"Rustic decor with modern touches.\",\"Comfortable seating arrangements for individuals and groups.\",\"Soft lighting creates a warm and inviting atmosphere.\",\"Relaxed setting perfect for casual dining or special occasions.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(103, 55, 20, 'Thali Meals', '[\"Generous portions of assorted dishes served on a platter.\",\"Ideal for those wanting to sample a variety of flavors.\",\"Vegetarian and non-vegetarian options available.\",\"Perfect for sharing with family and friends.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(104, 56, 20, 'Takeaway and Delivery Services', '[\"Convenient takeaway options for on-the-go meals.\",\"Delivery services available for those dining at home.\",\"Packaging designed to maintain food quality and freshness.\",\"Easy ordering process via phone or online platforms.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(105, 49, 21, 'المطبخ البنغالي الأصيل', '[\"\\u0648\\u0635\\u0641\\u0627\\u062a \\u062a\\u0642\\u0644\\u064a\\u062f\\u064a\\u0629 \\u062a\\u0646\\u062a\\u0642\\u0644 \\u0639\\u0628\\u0631 \\u0627\\u0644\\u0623\\u062c\\u064a\\u0627\\u0644.\",\"\\u0628\\u0647\\u0627\\u0631\\u0627\\u062a \\u0645\\u0637\\u062d\\u0648\\u0646\\u0629 \\u0637\\u0627\\u0632\\u062c\\u0629 \\u0644\\u0646\\u0643\\u0647\\u0627\\u062a \\u0623\\u0635\\u064a\\u0644\\u0629.\",\"\\u0627\\u0644\\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629 \\u0644\\u0644\\u0646\\u0636\\u0627\\u0631\\u0629.\",\"\\u062a\\u0639\\u0631\\u0636 \\u0627\\u0644\\u0642\\u0627\\u0626\\u0645\\u0629 \\u062a\\u0631\\u0627\\u062b \\u0627\\u0644\\u0637\\u0647\\u064a \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639 \\u0641\\u064a \\u0628\\u0646\\u063a\\u0644\\u0627\\u062f\\u064a\\u0634.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(106, 50, 21, 'كرم الضيافة', '[\"\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646 \\u0648\\u062f\\u064a\\u0629 \\u0648\\u0627\\u0644\\u064a\\u0642\\u0638\\u0629.\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u062a\\u0631\\u062d\\u064a\\u0628\\u064a\\u0629 \\u0645\\u0639 \\u062c\\u0648 \\u0645\\u0631\\u064a\\u062d.\",\"\\u062e\\u062f\\u0645\\u0629 \\u0634\\u062e\\u0635\\u064a\\u0629 \\u0644\\u062a\\u062c\\u0631\\u0628\\u0629 \\u0637\\u0639\\u0627\\u0645 \\u0644\\u0627 \\u062a\\u0646\\u0633\\u0649.\",\"\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u0648\\u0646 \\u0639\\u0644\\u0649 \\u062f\\u0631\\u0627\\u064a\\u0629 \\u0628\\u0627\\u0644\\u0642\\u0627\\u0626\\u0645\\u0629 \\u0648\\u0642\\u0627\\u062f\\u0631\\u0648\\u0646 \\u0639\\u0644\\u0649 \\u062a\\u0642\\u062f\\u064a\\u0645 \\u0627\\u0644\\u062a\\u0648\\u0635\\u064a\\u0627\\u062a.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(107, 51, 21, 'إبداعات الانصهار العالمية', '[\"\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0645\\u0628\\u062a\\u0643\\u0631\\u0629 \\u062a\\u0645\\u0632\\u062c \\u0627\\u0644\\u0646\\u0643\\u0647\\u0627\\u062a \\u0627\\u0644\\u0628\\u0646\\u063a\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0639 \\u0627\\u0644\\u062a\\u0623\\u062b\\u064a\\u0631\\u0627\\u062a \\u0627\\u0644\\u0639\\u0627\\u0644\\u0645\\u064a\\u0629.\",\"\\u0627\\u0644\\u0645\\u0637\\u0628\\u062e \\u0627\\u0644\\u0645\\u0646\\u062f\\u0645\\u062c \\u0645\\u0633\\u062a\\u0648\\u062d\\u0649 \\u0645\\u0646 \\u0627\\u062a\\u062c\\u0627\\u0647\\u0627\\u062a \\u0627\\u0644\\u0637\\u0647\\u064a \\u0627\\u0644\\u0639\\u0627\\u0644\\u0645\\u064a\\u0629.\",\"\\u0625\\u0639\\u0627\\u062f\\u0629 \\u062a\\u0641\\u0633\\u064a\\u0631 \\u0625\\u0628\\u062f\\u0627\\u0639\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0641\\u0636\\u0644\\u0627\\u062a \\u0627\\u0644\\u062a\\u0642\\u0644\\u064a\\u062f\\u064a\\u0629.\",\"\\u0642\\u0627\\u0626\\u0645\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u062a\\u0644\\u0628\\u064a \\u0627\\u0644\\u0623\\u0630\\u0648\\u0627\\u0642 \\u0648\\u0627\\u0644\\u062a\\u0641\\u0636\\u064a\\u0644\\u0627\\u062a \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(108, 52, 21, 'اختيار المأكولات البحرية الطازجة', '[\"\\u062a\\u0648\\u0635\\u064a\\u0644\\u0627\\u062a \\u064a\\u0648\\u0645\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0623\\u0643\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u0628\\u062d\\u0631\\u064a\\u0629 \\u0627\\u0644\\u0637\\u0627\\u0632\\u062c\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0623\\u0633\\u0648\\u0627\\u0642 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u0629.\",\"\\u0648\\u062a\\u0633\\u0644\\u0637 \\u0627\\u0644\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0627\\u0644\\u0645\\u0639\\u062f\\u0629 \\u0628\\u062e\\u0628\\u0631\\u0629 \\u0627\\u0644\\u0636\\u0648\\u0621 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0646\\u0643\\u0647\\u0627\\u062a \\u0627\\u0644\\u0637\\u0628\\u064a\\u0639\\u064a\\u0629 \\u0644\\u0644\\u0628\\u062d\\u0631.\",\"\\u0642\\u0627\\u0626\\u0645\\u0629 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u0623\\u0643\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u0628\\u062d\\u0631\\u064a\\u0629 \\u062a\\u0636\\u0645 \\u0627\\u0644\\u0642\\u0631\\u064a\\u062f\\u0633 \\u0648\\u0627\\u0644\\u0623\\u0633\\u0645\\u0627\\u0643 \\u0648\\u0623\\u0643\\u062b\\u0631 \\u0645\\u0646 \\u0630\\u0644\\u0643.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0644\\u062a\\u062d\\u0636\\u064a\\u0631\\u0627\\u062a \\u0627\\u0644\\u0645\\u0634\\u0648\\u064a\\u0629 \\u0623\\u0648 \\u0627\\u0644\\u0645\\u0642\\u0644\\u064a\\u0629 \\u0623\\u0648 \\u0627\\u0644\\u0643\\u0627\\u0631\\u064a.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(109, 53, 21, 'التخصصات النباتية', '[\"\\u062a\\u0634\\u0643\\u064a\\u0644\\u0629 \\u0648\\u0641\\u064a\\u0631\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0627\\u0644\\u0646\\u0628\\u0627\\u062a\\u064a\\u0629.\",\"\\u0643\\u0627\\u0631\\u064a \\u0646\\u0628\\u0627\\u062a\\u064a \\u0637\\u0627\\u0632\\u062c \\u0648\\u0644\\u0630\\u064a\\u0630 \\u0648\\u0645\\u0642\\u0644\\u064a.\",\"\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0628\\u0627\\u0646\\u064a\\u0631 \\u062a\\u0639\\u0631\\u0636 \\u0627\\u0644\\u062c\\u0628\\u0646 \\u0645\\u062d\\u0644\\u064a \\u0627\\u0644\\u0635\\u0646\\u0639 \\u0648\\u0627\\u0644\\u062a\\u0648\\u0627\\u0628\\u0644 \\u0627\\u0644\\u062c\\u0631\\u064a\\u0626\\u0629.\",\"\\u062b\\u0627\\u0644\\u064a\\u0633 \\u0646\\u0628\\u0627\\u062a\\u064a \\u0645\\u0639 \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u062c\\u0648\\u0627\\u0646\\u0628 \\u0644\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u0649 \\u0648\\u062c\\u0628\\u0629 \\u0643\\u0627\\u0645\\u0644\\u0629.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(110, 54, 21, 'أجواء مريحة', '[\"\\u062f\\u064a\\u0643\\u0648\\u0631 \\u0631\\u064a\\u0641\\u064a \\u0645\\u0639 \\u0644\\u0645\\u0633\\u0627\\u062a \\u062d\\u062f\\u064a\\u062b\\u0629.\",\"\\u062a\\u0631\\u062a\\u064a\\u0628\\u0627\\u062a \\u062c\\u0644\\u0648\\u0633 \\u0645\\u0631\\u064a\\u062d\\u0629 \\u0644\\u0644\\u0623\\u0641\\u0631\\u0627\\u062f \\u0648\\u0627\\u0644\\u0645\\u062c\\u0645\\u0648\\u0639\\u0627\\u062a.\",\"\\u0627\\u0644\\u0625\\u0636\\u0627\\u0621\\u0629 \\u0627\\u0644\\u0646\\u0627\\u0639\\u0645\\u0629 \\u062a\\u062e\\u0644\\u0642 \\u062c\\u0648\\u064b\\u0627 \\u062f\\u0627\\u0641\\u0626\\u064b\\u0627 \\u0648\\u062c\\u0630\\u0627\\u0628\\u064b\\u0627.\",\"\\u0645\\u0643\\u0627\\u0646 \\u0645\\u0631\\u064a\\u062d \\u0645\\u062b\\u0627\\u0644\\u064a \\u0644\\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u063a\\u064a\\u0631 \\u0627\\u0644\\u0631\\u0633\\u0645\\u064a \\u0623\\u0648 \\u0627\\u0644\\u0645\\u0646\\u0627\\u0633\\u0628\\u0627\\u062a \\u0627\\u0644\\u062e\\u0627\\u0635\\u0629.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(111, 55, 21, 'وجبات ثالي', '[\"\\u064a\\u062a\\u0645 \\u062a\\u0642\\u062f\\u064a\\u0645 \\u0623\\u062c\\u0632\\u0627\\u0621 \\u0633\\u062e\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0639\\u0644\\u0649 \\u0637\\u0628\\u0642.\",\"\\u0645\\u062b\\u0627\\u0644\\u064a\\u0629 \\u0644\\u0623\\u0648\\u0644\\u0626\\u0643 \\u0627\\u0644\\u0630\\u064a\\u0646 \\u064a\\u0631\\u064a\\u062f\\u0648\\u0646 \\u062a\\u0630\\u0648\\u0642 \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0646\\u0643\\u0647\\u0627\\u062a.\",\"\\u062a\\u062a\\u0648\\u0641\\u0631 \\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0646\\u0628\\u0627\\u062a\\u064a\\u0629 \\u0648\\u063a\\u064a\\u0631 \\u0646\\u0628\\u0627\\u062a\\u064a\\u0629.\",\"\\u0645\\u062b\\u0627\\u0644\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0645\\u0639 \\u0627\\u0644\\u0639\\u0627\\u0626\\u0644\\u0629 \\u0648\\u0627\\u0644\\u0623\\u0635\\u062f\\u0642\\u0627\\u0621.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(112, 56, 21, 'خدمات الوجبات الجاهزة والتوصيل', '[\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0627\\u0644\\u062c\\u0627\\u0647\\u0632\\u0629 \\u0645\\u0631\\u064a\\u062d\\u0629 \\u0644\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0623\\u062b\\u0646\\u0627\\u0621 \\u0627\\u0644\\u062a\\u0646\\u0642\\u0644.\",\"\\u062a\\u062a\\u0648\\u0641\\u0631 \\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u0648\\u0635\\u064a\\u0644 \\u0644\\u0623\\u0648\\u0644\\u0626\\u0643 \\u0627\\u0644\\u0630\\u064a\\u0646 \\u064a\\u062a\\u0646\\u0627\\u0648\\u0644\\u0648\\u0646 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0646\\u0632\\u0644.\",\"\\u0627\\u0644\\u062a\\u0639\\u0628\\u0626\\u0629 \\u0648\\u0627\\u0644\\u062a\\u063a\\u0644\\u064a\\u0641 \\u0645\\u0635\\u0645\\u0645\\u0629 \\u0644\\u0644\\u062d\\u0641\\u0627\\u0638 \\u0639\\u0644\\u0649 \\u062c\\u0648\\u062f\\u0629 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0648\\u0646\\u0636\\u0627\\u0631\\u062a\\u0647.\",\"\\u0639\\u0645\\u0644\\u064a\\u0629 \\u0627\\u0644\\u0637\\u0644\\u0628 \\u0633\\u0647\\u0644\\u0629 \\u0639\\u0628\\u0631 \\u0627\\u0644\\u0647\\u0627\\u062a\\u0641 \\u0623\\u0648 \\u0627\\u0644\\u0645\\u0646\\u0635\\u0627\\u062a \\u0639\\u0628\\u0631 \\u0627\\u0644\\u0625\\u0646\\u062a\\u0631\\u0646\\u062a.\"]', '2024-05-06 20:58:16', '2024-05-06 20:58:16'),
(113, 57, 20, 'Chic Black and White Décor', '[\"Elegant monochromatic theme\",\"Stylish bistro-style furnishings\",\"Artistic wall accents\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(114, 58, 20, 'Artisanal Coffee Selection', '[\"Locally sourced beans\",\"Diverse brewing methods\",\"Signature house blends\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(115, 59, 20, 'Seasonal Menu Offerings', '[\"Fresh, locally sourced ingredients\",\"Rotating specials\",\"Emphasis on seasonal produce\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(116, 60, 20, 'Cozy Ambiance', '[\"Soft jazz music\",\"Warm lighting\",\"Comfortable seating\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(117, 61, 20, 'Exceptional Service', '[\"Friendly and attentive staff\",\"Personalized recommendations\",\"Prompt and efficient service\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(118, 62, 20, 'Varied Menu Options', '[\"Breakfast, lunch, and dessert offerings\",\"Vegetarian and gluten-free options\",\"International influences\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(119, 63, 20, 'Community Engagement', '[\"Support of local artists\",\"Participation in neighborhood events\",\"Collaboration with nearby businesses\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(120, 64, 20, 'Outdoor Seating', '[\"Al fresco dining option\",\"Charming sidewalk caf\\u00e9 atmosphere\",\"Ideal for people-watching\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(121, 57, 21, 'ديكور أنيق باللونين الأبيض والأسود', '[\"\\u0645\\u0648\\u0636\\u0648\\u0639 \\u0623\\u062d\\u0627\\u062f\\u064a \\u0627\\u0644\\u0644\\u0648\\u0646 \\u0623\\u0646\\u064a\\u0642\",\"\\u0645\\u0641\\u0631\\u0648\\u0634\\u0627\\u062a \\u0623\\u0646\\u064a\\u0642\\u0629 \\u0639\\u0644\\u0649 \\u0637\\u0631\\u0627\\u0632 \\u0627\\u0644\\u0628\\u064a\\u0633\\u062a\\u0631\\u0648\",\"\\u0644\\u0647\\u062c\\u0627\\u062a \\u0627\\u0644\\u062c\\u062f\\u0627\\u0631 \\u0627\\u0644\\u0641\\u0646\\u064a\\u0629\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(122, 58, 21, 'اختيار القهوة الحرفية', '[\"\\u0627\\u0644\\u0641\\u0648\\u0644 \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629\",\"\\u0637\\u0631\\u0642 \\u0627\\u0644\\u062a\\u062e\\u0645\\u064a\\u0631 \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629\",\"\\u064a\\u0645\\u0632\\u062c \\u0627\\u0644\\u0628\\u064a\\u062a \\u0627\\u0644\\u0645\\u0645\\u064a\\u0632\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(123, 59, 21, 'عروض القائمة الموسمية', '[\"\\u0627\\u0644\\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0627\\u0644\\u0637\\u0627\\u0632\\u062c\\u0629 \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629\",\"\\u0639\\u0631\\u0648\\u0636 \\u062e\\u0627\\u0635\\u0629 \\u062f\\u0648\\u0627\\u0631\\u0629\",\"\\u0627\\u0644\\u062a\\u0631\\u0643\\u064a\\u0632 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u0646\\u062a\\u062c\\u0627\\u062a \\u0627\\u0644\\u0645\\u0648\\u0633\\u0645\\u064a\\u0629\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(124, 60, 21, 'أجواء مريحة', '[\"\\u0645\\u0648\\u0633\\u064a\\u0642\\u0649 \\u0627\\u0644\\u062c\\u0627\\u0632 \\u0627\\u0644\\u0646\\u0627\\u0639\\u0645\\u0629\",\"\\u0627\\u0644\\u0625\\u0636\\u0627\\u0621\\u0629 \\u0627\\u0644\\u062f\\u0627\\u0641\\u0626\\u0629\",\"\\u0645\\u0642\\u0627\\u0639\\u062f \\u0645\\u0631\\u064a\\u062d\\u0629\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(125, 61, 21, 'خدمة استثنائية', '[\"\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646 \\u0648\\u062f\\u064a\\u0629 \\u0648\\u0627\\u0644\\u064a\\u0642\\u0638\\u0629\",\"\\u062a\\u0648\\u0635\\u064a\\u0627\\u062a \\u0634\\u062e\\u0635\\u064a\\u0629\",\"\\u062e\\u062f\\u0645\\u0629 \\u0633\\u0631\\u064a\\u0639\\u0629 \\u0648\\u0641\\u0639\\u0627\\u0644\\u0629\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(126, 62, 21, 'خيارات القائمة المتنوعة', '[\"\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0625\\u0641\\u0637\\u0627\\u0631 \\u0648\\u0627\\u0644\\u063a\\u062f\\u0627\\u0621 \\u0648\\u0627\\u0644\\u062d\\u0644\\u0648\\u064a\\u0627\\u062a\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0646\\u0628\\u0627\\u062a\\u064a\\u0629 \\u0648\\u062e\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u063a\\u0644\\u0648\\u062a\\u064a\\u0646\",\"\\u0627\\u0644\\u062a\\u0623\\u062b\\u064a\\u0631\\u0627\\u062a \\u0627\\u0644\\u062f\\u0648\\u0644\\u064a\\u0629\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(127, 63, 21, 'المشاركة المجتمعية', '[\"\\u062f\\u0639\\u0645 \\u0627\\u0644\\u0641\\u0646\\u0627\\u0646\\u064a\\u0646 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u064a\\u0646\",\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0641\\u064a \\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u0627\\u0644\\u062d\\u064a\",\"\\u0627\\u0644\\u062a\\u0639\\u0627\\u0648\\u0646 \\u0645\\u0639 \\u0627\\u0644\\u0634\\u0631\\u0643\\u0627\\u062a \\u0627\\u0644\\u0642\\u0631\\u064a\\u0628\\u0629\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(128, 64, 21, 'جلوس في الهواء الطلق', '[\"\\u062e\\u064a\\u0627\\u0631 \\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0641\\u064a \\u0627\\u0644\\u0647\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0637\\u0644\\u0642\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0645\\u0642\\u0647\\u0649 \\u0627\\u0644\\u0631\\u0635\\u064a\\u0641 \\u0627\\u0644\\u0633\\u0627\\u062d\\u0631\\u0629\",\"\\u0645\\u062b\\u0627\\u0644\\u064a\\u0629 \\u0644\\u0645\\u0634\\u0627\\u0647\\u062f\\u0629 \\u0627\\u0644\\u0646\\u0627\\u0633\"]', '2024-05-06 21:33:13', '2024-05-06 21:33:13'),
(129, 65, 20, 'Wide Range, Top Brands', '[\"Diverse Equipment Selection\",\"Premium Brands Available\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(130, 66, 20, 'Expert Guidance', '[\"Personalized Assistance\",\"Knowledgeable Staff\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(131, 67, 20, 'Knowledgeable Staff', '[\"CBD Accessibility\",\"Parking Available\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(132, 68, 20, 'Community Engagement', '[\"Events & Workshops\",\"Lively Fitness Community\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(133, 69, 20, 'Cutting-Edge Tech', '[\"Latest Features\",\"User-Friendly Design\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(134, 70, 20, 'Customer Satisfaction', '[\"Hassle-Free Returns\",\"Responsive Support Team\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(135, 71, 20, 'Health & Safety Priority', '[\"Clean Environment\",\"Social Distancing Measures\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(136, 65, 21, 'مجموعة واسعة، أعلى العلامات التجارية', '[\"\\u0627\\u062e\\u062a\\u064a\\u0627\\u0631 \\u0627\\u0644\\u0645\\u0639\\u062f\\u0627\\u062a \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629\",\"\\u0627\\u0644\\u0639\\u0644\\u0627\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u062c\\u0627\\u0631\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062a\\u0645\\u064a\\u0632\\u0629 \\u0627\\u0644\\u0645\\u062a\\u0627\\u062d\\u0629\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(137, 66, 21, 'إرشادات الخبراء', '[\"\\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629\",\"\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646 \\u0630\\u0648\\u064a \\u0627\\u0644\\u0645\\u0639\\u0631\\u0641\\u0629\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(138, 67, 21, 'الموظفين ذوي المعرفة', '[\"\\u0625\\u0645\\u0643\\u0627\\u0646\\u064a\\u0629 \\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0627\\u062a\\u0641\\u0627\\u0642\\u064a\\u0629 \\u0627\\u0644\\u062a\\u0646\\u0648\\u0639 \\u0627\\u0644\\u0628\\u064a\\u0648\\u0644\\u0648\\u062c\\u064a\",\"\\u0645\\u0648\\u0627\\u0642\\u0641 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0645\\u062a\\u0627\\u062d\\u0629\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(139, 68, 21, 'المشاركة المجتمعية', '[\"\\u0627\\u0644\\u0623\\u062d\\u062f\\u0627\\u062b \\u0648\\u0648\\u0631\\u0634 \\u0627\\u0644\\u0639\\u0645\\u0644\",\"\\u0645\\u062c\\u062a\\u0645\\u0639 \\u0627\\u0644\\u0644\\u064a\\u0627\\u0642\\u0629 \\u0627\\u0644\\u0628\\u062f\\u0646\\u064a\\u0629 \\u0627\\u0644\\u062d\\u064a\\u0648\\u064a\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(140, 69, 21, 'أحدث التقنيات', '[\"\\u0623\\u062d\\u062f\\u062b \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a\",\"\\u062a\\u0635\\u0645\\u064a\\u0645 \\u0633\\u0647\\u0644 \\u0627\\u0644\\u0627\\u0633\\u062a\\u062e\\u062f\\u0627\\u0645\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(141, 70, 21, 'رضا العملاء', '[\"\\u0639\\u0648\\u0627\\u0626\\u062f \\u062e\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u062a\\u0627\\u0639\\u0628\",\"\\u0641\\u0631\\u064a\\u0642 \\u0627\\u0644\\u062f\\u0639\\u0645 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062c\\u064a\\u0628\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(142, 71, 21, 'أولوية الصحة والسلامة', '[\"\\u0628\\u064a\\u0626\\u0629 \\u0646\\u0638\\u064a\\u0641\\u0629\",\"\\u0625\\u062c\\u0631\\u0627\\u0621\\u0627\\u062a \\u0627\\u0644\\u0625\\u0628\\u0639\\u0627\\u062f \\u0627\\u0644\\u0627\\u062c\\u062a\\u0645\\u0627\\u0639\\u064a\"]', '2024-05-06 22:42:58', '2024-05-06 22:42:58'),
(143, 72, 20, 'Wide Selection of High-Quality Hospital Beds', '[\"Comprehensive range of hospital beds including basic, adjustable, specialty, and ICU models.\",\"Beds sourced from reputable manufacturers known for their reliability and durability.\",\"Options available for various healthcare settings including hospitals, nursing homes, rehabilitation centers, and home care.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(144, 73, 20, 'Personalized Consultation and Guidance', '[\"Knowledgeable and friendly staff offering personalized assistance throughout the selection process.\",\"Understanding of specific needs, preferences, and budget constraints to recommend suitable products.\",\"Expert advice on features, functionalities, and accessories to optimize patient comfort and care.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(145, 74, 20, 'Complementary Accessories and Equipment', '[\"Extensive selection of accessories including bedside tables, overbed trays, bed rails, and patient lift systems.\",\"Specialized mattresses and pressure relief systems to prevent bedsores and enhance patient comfort.\",\"Supplementary equipment such as IV poles, bedside commodes, and patient monitoring devices available to create a complete care environment.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(146, 75, 20, 'Installation Services and Technical Support', '[\"Professional installation services provided by skilled technicians to ensure proper setup and functionality.\",\"Comprehensive training and guidance for caregivers on operating and maintaining hospital beds.\",\"Prompt technical support and troubleshooting assistance to address any issues or concerns.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(147, 76, 20, 'Post-Sales Maintenance and Warranty Coverage', '[\"Regular maintenance and inspection services offered to prolong the lifespan of hospital beds and ensure optimal performance.\",\"Warranty coverage provided for all products, with prompt resolution of any defects or malfunctions.\",\"Hassle-free repair and replacement process facilitated by dedicated customer support team.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(148, 77, 20, 'Community Engagement and Industry Collaboration', '[\"Active involvement in the local healthcare community through partnerships with hospitals, clinics, and care facilities.\",\"Collaboration with healthcare professionals to stay abreast of industry trends and technological advancements.\",\"Participation in health fairs, seminars, and educational events to promote awareness and best practices in patient care.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(149, 78, 20, 'Commitment to Customer Satisfaction and Feedback', '[\"Continuous commitment to exceeding customer expectations through exceptional service and support.\",\"Regular solicitation of feedback and testimonials to gauge customer satisfaction and identify areas for improvement.\",\"Implementation of customer suggestions and recommendations to enhance product offerings and service delivery.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(150, 72, 21, 'مجموعة واسعة من أسرة المستشفيات عالية الجودة', '[\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0634\\u0627\\u0645\\u0644\\u0629 \\u0645\\u0646 \\u0623\\u0633\\u0631\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u0627\\u0644\\u0646\\u0645\\u0627\\u0630\\u062c \\u0627\\u0644\\u0623\\u0633\\u0627\\u0633\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0642\\u0627\\u0628\\u0644\\u0629 \\u0644\\u0644\\u062a\\u0639\\u062f\\u064a\\u0644 \\u0648\\u0627\\u0644\\u062a\\u062e\\u0635\\u0635 \\u0648\\u0648\\u062d\\u062f\\u0629 \\u0627\\u0644\\u0639\\u0646\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0632\\u0629.\",\"\\u064a\\u062a\\u0645 \\u0627\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0623\\u0633\\u0631\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0634\\u0631\\u0643\\u0627\\u062a \\u0627\\u0644\\u0645\\u0635\\u0646\\u0639\\u0629 \\u0630\\u0627\\u062a \\u0627\\u0644\\u0633\\u0645\\u0639\\u0629 \\u0627\\u0644\\u0637\\u064a\\u0628\\u0629 \\u0648\\u0627\\u0644\\u0645\\u0639\\u0631\\u0648\\u0641\\u0629 \\u0628\\u0645\\u0648\\u062b\\u0648\\u0642\\u064a\\u062a\\u0647\\u0627 \\u0648\\u0645\\u062a\\u0627\\u0646\\u062a\\u0647\\u0627.\",\"\\u0627\\u0644\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0645\\u062a\\u0627\\u062d\\u0629 \\u0644\\u0645\\u062e\\u062a\\u0644\\u0641 \\u0625\\u0639\\u062f\\u0627\\u062f\\u0627\\u062a \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0635\\u062d\\u064a\\u0629 \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a \\u0648\\u062f\\u0648\\u0631 \\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0633\\u0646\\u064a\\u0646 \\u0648\\u0645\\u0631\\u0627\\u0643\\u0632 \\u0625\\u0639\\u0627\\u062f\\u0629 \\u0627\\u0644\\u062a\\u0623\\u0647\\u064a\\u0644 \\u0648\\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0646\\u0632\\u0644\\u064a\\u0629.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(151, 73, 21, 'التشاور والتوجيه الشخصي', '[\"\\u064a\\u0642\\u062f\\u0645 \\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u0648\\u0646 \\u0630\\u0648\\u0648 \\u0627\\u0644\\u0645\\u0639\\u0631\\u0641\\u0629 \\u0648\\u0627\\u0644\\u0648\\u062f \\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629 \\u0637\\u0648\\u0627\\u0644 \\u0639\\u0645\\u0644\\u064a\\u0629 \\u0627\\u0644\\u0627\\u062e\\u062a\\u064a\\u0627\\u0631.\",\"\\u0641\\u0647\\u0645 \\u0627\\u0644\\u0627\\u062d\\u062a\\u064a\\u0627\\u062c\\u0627\\u062a \\u0648\\u0627\\u0644\\u062a\\u0641\\u0636\\u064a\\u0644\\u0627\\u062a \\u0627\\u0644\\u0645\\u062d\\u062f\\u062f\\u0629 \\u0648\\u0642\\u064a\\u0648\\u062f \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u0646\\u064a\\u0629 \\u0644\\u0644\\u062a\\u0648\\u0635\\u064a\\u0629 \\u0628\\u0627\\u0644\\u0645\\u0646\\u062a\\u062c\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0627\\u0633\\u0628\\u0629.\",\"\\u0646\\u0635\\u064a\\u062d\\u0629 \\u0627\\u0644\\u062e\\u0628\\u0631\\u0627\\u0621 \\u0628\\u0634\\u0623\\u0646 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u0648\\u0627\\u0644\\u0648\\u0638\\u0627\\u0626\\u0641 \\u0648\\u0627\\u0644\\u0645\\u0644\\u062d\\u0642\\u0627\\u062a \\u0644\\u062a\\u062d\\u0633\\u064a\\u0646 \\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0645\\u0631\\u064a\\u0636 \\u0648\\u0631\\u0639\\u0627\\u064a\\u062a\\u0647.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(152, 74, 21, 'الملحقات والمعدات التكميلية', '[\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u0644\\u062d\\u0642\\u0627\\u062a \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u0627\\u0644\\u0637\\u0627\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u062c\\u0627\\u0646\\u0628\\u064a\\u0629 \\u0644\\u0644\\u0633\\u0631\\u064a\\u0631\\u060c \\u0648\\u0627\\u0644\\u0635\\u0648\\u0627\\u0646\\u064a \\u0627\\u0644\\u0645\\u0648\\u062c\\u0648\\u062f\\u0629 \\u0641\\u0648\\u0642 \\u0627\\u0644\\u0633\\u0631\\u064a\\u0631\\u060c \\u0648\\u0642\\u0636\\u0628\\u0627\\u0646 \\u0627\\u0644\\u0633\\u0631\\u064a\\u0631\\u060c \\u0648\\u0623\\u0646\\u0638\\u0645\\u0629 \\u0631\\u0641\\u0639 \\u0627\\u0644\\u0645\\u0631\\u0636\\u0649.\",\"\\u0645\\u0631\\u0627\\u062a\\u0628 \\u0645\\u062a\\u062e\\u0635\\u0635\\u0629 \\u0648\\u0623\\u0646\\u0638\\u0645\\u0629 \\u062a\\u062e\\u0641\\u064a\\u0641 \\u0627\\u0644\\u0636\\u063a\\u0637 \\u0644\\u0645\\u0646\\u0639 \\u062a\\u0642\\u0631\\u062d\\u0627\\u062a \\u0627\\u0644\\u0641\\u0631\\u0627\\u0634 \\u0648\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0645\\u0631\\u064a\\u0636.\",\"\\u0627\\u0644\\u0645\\u0639\\u062f\\u0627\\u062a \\u0627\\u0644\\u062a\\u0643\\u0645\\u064a\\u0644\\u064a\\u0629 \\u0645\\u062b\\u0644 \\u0627\\u0644\\u0623\\u0639\\u0645\\u062f\\u0629 \\u0627\\u0644\\u0648\\u0631\\u064a\\u062f\\u064a\\u0629\\u060c \\u0648\\u0627\\u0644\\u0643\\u0648\\u0645\\u0648\\u062f\\u0627\\u062a \\u0628\\u062c\\u0627\\u0646\\u0628 \\u0627\\u0644\\u0633\\u0631\\u064a\\u0631\\u060c \\u0648\\u0623\\u062c\\u0647\\u0632\\u0629 \\u0645\\u0631\\u0627\\u0642\\u0628\\u0629 \\u0627\\u0644\\u0645\\u0631\\u064a\\u0636 \\u0645\\u062a\\u0627\\u062d\\u0629 \\u0644\\u062e\\u0644\\u0642 \\u0628\\u064a\\u0626\\u0629 \\u0631\\u0639\\u0627\\u064a\\u0629 \\u0643\\u0627\\u0645\\u0644\\u0629.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(153, 75, 21, 'خدمات التثبيت والدعم الفني', '[\"\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u0631\\u0643\\u064a\\u0628 \\u0627\\u0644\\u0627\\u062d\\u062a\\u0631\\u0627\\u0641\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0642\\u062f\\u0645\\u0629 \\u0645\\u0646 \\u0642\\u0628\\u0644 \\u0641\\u0646\\u064a\\u064a\\u0646 \\u0645\\u0627\\u0647\\u0631\\u064a\\u0646 \\u0644\\u0636\\u0645\\u0627\\u0646 \\u0627\\u0644\\u0625\\u0639\\u062f\\u0627\\u062f \\u0648\\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0627\\u0644\\u0645\\u0646\\u0627\\u0633\\u0628\\u064a\\u0646.\",\"\\u0627\\u0644\\u062a\\u062f\\u0631\\u064a\\u0628 \\u0627\\u0644\\u0634\\u0627\\u0645\\u0644 \\u0648\\u0627\\u0644\\u062a\\u0648\\u062c\\u064a\\u0647 \\u0644\\u0645\\u0642\\u062f\\u0645\\u064a \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0628\\u0634\\u0623\\u0646 \\u062a\\u0634\\u063a\\u064a\\u0644 \\u0648\\u0635\\u064a\\u0627\\u0646\\u0629 \\u0623\\u0633\\u0631\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a.\",\"\\u0627\\u0644\\u062f\\u0639\\u0645 \\u0627\\u0644\\u0641\\u0646\\u064a \\u0627\\u0644\\u0641\\u0648\\u0631\\u064a \\u0648\\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u0627\\u0633\\u062a\\u0643\\u0634\\u0627\\u0641 \\u0627\\u0644\\u0623\\u062e\\u0637\\u0627\\u0621 \\u0648\\u0625\\u0635\\u0644\\u0627\\u062d\\u0647\\u0627 \\u0644\\u0645\\u0639\\u0627\\u0644\\u062c\\u0629 \\u0623\\u064a \\u0645\\u0634\\u0627\\u0643\\u0644 \\u0623\\u0648 \\u0645\\u062e\\u0627\\u0648\\u0641.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(154, 76, 21, 'صيانة ما بعد البيع وتغطية الضمان', '[\"\\u064a\\u062a\\u0645 \\u062a\\u0642\\u062f\\u064a\\u0645 \\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0635\\u064a\\u0627\\u0646\\u0629 \\u0648\\u0627\\u0644\\u0641\\u062d\\u0635 \\u0627\\u0644\\u062f\\u0648\\u0631\\u064a\\u0629 \\u0644\\u0625\\u0637\\u0627\\u0644\\u0629 \\u0639\\u0645\\u0631 \\u0623\\u0633\\u0631\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a \\u0648\\u0636\\u0645\\u0627\\u0646 \\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0627\\u0644\\u0623\\u0645\\u062b\\u0644.\",\"\\u062a\\u063a\\u0637\\u064a\\u0629 \\u0627\\u0644\\u0636\\u0645\\u0627\\u0646 \\u0645\\u062a\\u0648\\u0641\\u0631\\u0629 \\u0644\\u062c\\u0645\\u064a\\u0639 \\u0627\\u0644\\u0645\\u0646\\u062a\\u062c\\u0627\\u062a\\u060c \\u0645\\u0639 \\u062d\\u0644 \\u0633\\u0631\\u064a\\u0639 \\u0644\\u0623\\u064a\\u0629 \\u0639\\u064a\\u0648\\u0628 \\u0623\\u0648 \\u0623\\u0639\\u0637\\u0627\\u0644.\",\"\\u0639\\u0645\\u0644\\u064a\\u0629 \\u0625\\u0635\\u0644\\u0627\\u062d \\u0648\\u0627\\u0633\\u062a\\u0628\\u062f\\u0627\\u0644 \\u062e\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u062a\\u0627\\u0639\\u0628 \\u064a\\u062a\\u0645 \\u062a\\u0633\\u0647\\u064a\\u0644\\u0647\\u0627 \\u0628\\u0648\\u0627\\u0633\\u0637\\u0629 \\u0641\\u0631\\u064a\\u0642 \\u062f\\u0639\\u0645 \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0627\\u0644\\u0645\\u062e\\u0635\\u0635.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(155, 77, 21, 'المشاركة المجتمعية والتعاون الصناعي', '[\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0627\\u0644\\u0641\\u0639\\u0627\\u0644\\u0629 \\u0641\\u064a \\u0645\\u062c\\u062a\\u0645\\u0639 \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0635\\u062d\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a \\u0645\\u0646 \\u062e\\u0644\\u0627\\u0644 \\u0627\\u0644\\u0634\\u0631\\u0627\\u0643\\u0627\\u062a \\u0645\\u0639 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a \\u0648\\u0627\\u0644\\u0639\\u064a\\u0627\\u062f\\u0627\\u062a \\u0648\\u0645\\u0631\\u0627\\u0641\\u0642 \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629.\",\"\\u0627\\u0644\\u062a\\u0639\\u0627\\u0648\\u0646 \\u0645\\u0639 \\u0627\\u0644\\u0645\\u062a\\u062e\\u0635\\u0635\\u064a\\u0646 \\u0641\\u064a \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0635\\u062d\\u064a\\u0629 \\u0644\\u0645\\u0648\\u0627\\u0643\\u0628\\u0629 \\u0627\\u062a\\u062c\\u0627\\u0647\\u0627\\u062a \\u0627\\u0644\\u0635\\u0646\\u0627\\u0639\\u0629 \\u0648\\u0627\\u0644\\u062a\\u0642\\u062f\\u0645 \\u0627\\u0644\\u062a\\u0643\\u0646\\u0648\\u0644\\u0648\\u062c\\u064a.\",\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0639\\u0627\\u0631\\u0636 \\u0627\\u0644\\u0635\\u062d\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0646\\u062f\\u0648\\u0627\\u062a \\u0648\\u0627\\u0644\\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0627\\u0644\\u0648\\u0639\\u064a \\u0648\\u0623\\u0641\\u0636\\u0644 \\u0627\\u0644\\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0641\\u064a \\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0636\\u0649.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(156, 78, 21, 'الالتزام برضا العملاء وردود الفعل', '[\"\\u0627\\u0644\\u0627\\u0644\\u062a\\u0632\\u0627\\u0645 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0645\\u0631 \\u0628\\u062a\\u062c\\u0627\\u0648\\u0632 \\u062a\\u0648\\u0642\\u0639\\u0627\\u062a \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0645\\u0646 \\u062e\\u0644\\u0627\\u0644 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0629 \\u0648\\u0627\\u0644\\u062f\\u0639\\u0645 \\u0627\\u0644\\u0627\\u0633\\u062a\\u062b\\u0646\\u0627\\u0626\\u064a\\u064a\\u0646.\",\"\\u0627\\u0644\\u062a\\u0645\\u0627\\u0633 \\u0645\\u0646\\u062a\\u0638\\u0645 \\u0644\\u0644\\u062a\\u0639\\u0644\\u064a\\u0642\\u0627\\u062a \\u0648\\u0627\\u0644\\u0634\\u0647\\u0627\\u062f\\u0627\\u062a \\u0644\\u0642\\u064a\\u0627\\u0633 \\u0631\\u0636\\u0627 \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0648\\u062a\\u062d\\u062f\\u064a\\u062f \\u0645\\u062c\\u0627\\u0644\\u0627\\u062a \\u0627\\u0644\\u062a\\u062d\\u0633\\u064a\\u0646.\",\"\\u062a\\u0646\\u0641\\u064a\\u0630 \\u0627\\u0642\\u062a\\u0631\\u0627\\u062d\\u0627\\u062a \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0648\\u062a\\u0648\\u0635\\u064a\\u0627\\u062a\\u0647\\u0645 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0645\\u0646\\u062a\\u062c\\u0627\\u062a \\u0648\\u062a\\u0642\\u062f\\u064a\\u0645 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0627\\u062a.\"]', '2024-05-07 00:20:16', '2024-05-07 00:20:16'),
(157, 79, 20, 'Authentic Western Atmosphere', '[\"Weathered d\\u00e9cor\",\"Swinging saloon doors\",\"Mounted animal heads\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(158, 80, 20, 'Extensive Spirits Selection', '[\"Local and imported\",\"Varied whiskey collection\",\"Expert bartenders\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(159, 81, 20, 'Live Music Entertainment', '[\"Talented local musicians\",\"Soulful ballads\",\"Foot-stomping anthems\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(160, 82, 20, 'Community Hub', '[\"Welcoming atmosphere\",\"Regulars\' camaraderie\",\"Newcomer-friendly\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(161, 83, 20, 'Rustic Dining Experience', '[\"Hearty meals\",\"Locally sourced ingredients\",\"Western-themed dishes\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(162, 84, 20, 'Games and Activities', '[\"Card games\",\"Darts\",\"Billiards\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(163, 85, 20, 'Outdoor Seating', '[\"Desert views\",\"Starlit evenings\",\"Cozy campfire area\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(164, 79, 21, 'الجو الغربي الأصيل', '[\"\\u062f\\u064a\\u0643\\u0648\\u0631 \\u0645\\u062a\\u0623\\u062b\\u0631 \\u0628\\u0627\\u0644\\u0637\\u0642\\u0633\",\"\\u0623\\u0628\\u0648\\u0627\\u0628 \\u0627\\u0644\\u0635\\u0627\\u0644\\u0648\\u0646 \\u0627\\u0644\\u0645\\u062a\\u0623\\u0631\\u062c\\u062d\\u0629\",\"\\u0631\\u0624\\u0648\\u0633 \\u062d\\u064a\\u0648\\u0627\\u0646\\u0627\\u062a \\u0645\\u062b\\u0628\\u062a\\u0629\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(165, 80, 21, 'اختيار المشروبات الروحية واسعة النطاق', '[\"\\u0645\\u062d\\u0644\\u064a \\u0648\\u0645\\u0633\\u062a\\u0648\\u0631\\u062f\",\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0648\\u064a\\u0633\\u0643\\u064a\",\"\\u0627\\u0644\\u0633\\u0642\\u0627\\u0629 \\u0627\\u0644\\u062e\\u0628\\u0631\\u0627\\u0621\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(166, 81, 21, 'الترفيه الموسيقي الحي', '[\"\\u0627\\u0644\\u0645\\u0648\\u0633\\u064a\\u0642\\u064a\\u064a\\u0646 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u064a\\u0646 \\u0627\\u0644\\u0645\\u0648\\u0647\\u0648\\u0628\\u064a\\u0646\",\"\\u0627\\u0644\\u0623\\u063a\\u0627\\u0646\\u064a \\u0627\\u0644\\u0631\\u0648\\u062d\\u064a\\u0629\",\"\\u0623\\u0646\\u0627\\u0634\\u064a\\u062f \\u0627\\u0644\\u062f\\u0648\\u0633 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0623\\u0642\\u062f\\u0627\\u0645\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(167, 82, 21, 'مركز المجتمع', '[\"\\u062c\\u0648 \\u062a\\u0631\\u062d\\u0627\\u0628\",\"\\u0627\\u0644\\u0635\\u062f\\u0627\\u0642\\u0629 \\u0627\\u0644\\u062d\\u0645\\u064a\\u0645\\u0629 \\u0627\\u0644\\u0646\\u0638\\u0627\\u0645\\u064a\\u064a\\u0646\",\"\\u0635\\u062f\\u064a\\u0642\\u0629 \\u0644\\u0644\\u0648\\u0627\\u0641\\u062f\\u064a\\u0646 \\u0627\\u0644\\u062c\\u062f\\u062f\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(168, 83, 21, 'تجربة تناول الطعام الريفية', '[\"\\u0648\\u062c\\u0628\\u0627\\u062a \\u062f\\u0633\\u0645\\u0629\",\"\\u0627\\u0644\\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629\",\"\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0630\\u0627\\u062a \\u0637\\u0627\\u0628\\u0639 \\u063a\\u0631\\u0628\\u064a\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02');
INSERT INTO `listing_feature_contents` (`id`, `listing_feature_id`, `language_id`, `feature_heading`, `feature_value`, `created_at`, `updated_at`) VALUES
(169, 84, 21, 'الألعاب والأنشطة', '[\"\\u0644\\u0639\\u0628 \\u0627\\u0644\\u0648\\u0631\\u0642\",\"\\u0627\\u0644\\u0633\\u0647\\u0627\\u0645\",\"\\u0627\\u0644\\u0628\\u0644\\u064a\\u0627\\u0631\\u062f\\u0648\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(170, 85, 21, 'جلوس في الهواء الطلق', '[\"\\u0645\\u0646\\u0627\\u0638\\u0631 \\u0635\\u062d\\u0631\\u0627\\u0648\\u064a\\u0629\",\"\\u0623\\u0645\\u0633\\u064a\\u0627\\u062a \\u0645\\u0636\\u0627\\u0621\\u0629 \\u0628\\u0627\\u0644\\u0646\\u062c\\u0648\\u0645\",\"\\u0645\\u0646\\u0637\\u0642\\u0629 \\u0646\\u0627\\u0631 \\u0627\\u0644\\u0645\\u0639\\u0633\\u0643\\u0631 \\u0627\\u0644\\u0645\\u0631\\u064a\\u062d\\u0629\"]', '2024-05-07 02:56:02', '2024-05-07 02:56:02'),
(171, 86, 20, 'Live Music Nights', '[\"Weekly performances\",\"Diverse musical genres\",\"Talented local artists\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(172, 87, 20, 'Vintage Decor', '[\"Old-world charm\",\"Authentic memorabilia.\",\"Rustic ambiance\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(173, 88, 20, 'Craft Cocktail Bar', '[\"Skilled bartenders\",\"Unique concoctions\",\"Local flavor inspiration\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(174, 89, 20, 'Hearty Comfort Food', '[\"Delicious BBQ ribs.\",\"Juicy burgers\",\"Crispy fried chicken\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(175, 90, 20, 'Friendly Atmosphere', '[\"Welcoming staff\",\"Lively conversations\",\"Community vibe\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(176, 91, 20, 'Outdoor Seating', '[\"Scenic patio area\",\"Relaxing atmosphere\",\"Ideal for warm evenings\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(178, 86, 21, 'ليالي الموسيقى الحية', '[\"\\u0627\\u0644\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0623\\u0633\\u0628\\u0648\\u0639\\u064a\\u0629\",\"\\u0627\\u0644\\u0623\\u0646\\u0648\\u0627\\u0639 \\u0627\\u0644\\u0645\\u0648\\u0633\\u064a\\u0642\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629\",\"\\u0627\\u0644\\u0641\\u0646\\u0627\\u0646\\u064a\\u0646 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u064a\\u0646 \\u0627\\u0644\\u0645\\u0648\\u0647\\u0648\\u0628\\u064a\\u0646\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(179, 87, 21, 'ديكور عتيق', '[\"\\u0633\\u062d\\u0631 \\u0627\\u0644\\u0639\\u0627\\u0644\\u0645 \\u0627\\u0644\\u0642\\u062f\\u064a\\u0645\",\"\\u062a\\u0630\\u0643\\u0627\\u0631\\u0627\\u062a \\u0623\\u0635\\u064a\\u0644\\u0629.\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0631\\u064a\\u0641\\u064a\\u0629\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(180, 88, 21, 'بار كوكتيل كرافت', '[\"\\u0627\\u0644\\u0633\\u0642\\u0627\\u0629 \\u0627\\u0644\\u0645\\u0647\\u0631\\u0629\",\"\\u0627\\u062e\\u062a\\u0631\\u0627\\u0639\\u0627\\u062a \\u0641\\u0631\\u064a\\u062f\\u0629 \\u0645\\u0646 \\u0646\\u0648\\u0639\\u0647\\u0627\",\"\\u0625\\u0644\\u0647\\u0627\\u0645 \\u0627\\u0644\\u0646\\u0643\\u0647\\u0629 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u0629\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(181, 89, 21, 'طعام مريح شهي', '[\"\\u0623\\u0636\\u0644\\u0627\\u0639 \\u0634\\u0648\\u0627\\u0621 \\u0644\\u0630\\u064a\\u0630\\u0629.\",\"\\u0627\\u0644\\u0628\\u0631\\u063a\\u0631 \\u0627\\u0644\\u0639\\u0635\\u064a\\u0631\",\"\\u062f\\u062c\\u0627\\u062c \\u0645\\u0642\\u0644\\u064a \\u0645\\u0642\\u0631\\u0645\\u0634\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(182, 90, 21, 'أجواء ودية', '[\"\\u0627\\u0644\\u062a\\u0631\\u062d\\u064a\\u0628 \\u0628\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646\",\"\\u0645\\u062d\\u0627\\u062f\\u062b\\u0627\\u062a \\u062d\\u064a\\u0629\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(183, 91, 21, 'جلوس في الهواء الطلق', '[\"\\u0645\\u0646\\u0637\\u0642\\u0629 \\u0627\\u0644\\u0641\\u0646\\u0627\\u0621 \\u0630\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0627\\u0638\\u0631 \\u0627\\u0644\\u062e\\u0644\\u0627\\u0628\\u0629\",\"\\u062c\\u0648 \\u0645\\u0646 \\u0627\\u0644\\u0627\\u0633\\u062a\\u0631\\u062e\\u0627\\u0621\",\"\\u0645\\u062b\\u0627\\u0644\\u064a\\u0629 \\u0644\\u0644\\u0623\\u0645\\u0633\\u064a\\u0627\\u062a \\u0627\\u0644\\u062f\\u0627\\u0641\\u0626\\u0629\"]', '2024-05-07 21:01:02', '2024-05-07 21:01:02'),
(205, 103, 20, 'Advanced Medical Facilities', '[\"Cutting-edge Diagnostic Equipment\",\"Modern Operating Theatres\",\"Intensive Care Units (ICUs)\",\"Telemedicine Services\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(206, 104, 20, 'Comprehensive Specialties', '[\"Multidisciplinary Approach\",\"Subspecialty Clinics\",\"Rehabilitation Services\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(207, 105, 20, 'Patient-Centered Care', '[\"Holistic Approach\",\"Patient Advocacy\",\"Language and Cultural Sensitivity\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(208, 106, 20, 'Community Engagement', '[\"Health Education Programs\",\"Community Health Screenings\",\"Collaborative Partnerships\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(209, 107, 20, 'Quality and Safety', '[\"Accreditation and Certifications\",\"Continuous Quality Improvemen\",\"Infection Control Measures\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(210, 103, 21, 'المرافق الطبية المتقدمة', '[\"\\u0645\\u0639\\u062f\\u0627\\u062a \\u0627\\u0644\\u062a\\u0634\\u062e\\u064a\\u0635 \\u0627\\u0644\\u0645\\u062a\\u0637\\u0648\\u0631\\u0629\",\"\\u063a\\u0631\\u0641 \\u0627\\u0644\\u0639\\u0645\\u0644\\u064a\\u0627\\u062a \\u0627\\u0644\\u062d\\u062f\\u064a\\u062b\\u0629\",\"\\u0648\\u062d\\u062f\\u0627\\u062a \\u0627\\u0644\\u0639\\u0646\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0632\\u0629 (ICUs)\",\"\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u0637\\u0628\\u064a\\u0628 \\u0639\\u0646 \\u0628\\u0639\\u062f\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(211, 104, 21, 'التخصصات الشاملة', '[\"\\u0646\\u0647\\u062c \\u0645\\u062a\\u0639\\u062f\\u062f \\u0627\\u0644\\u062a\\u062e\\u0635\\u0635\\u0627\\u062a\",\"\\u0639\\u064a\\u0627\\u062f\\u0627\\u062a \\u0627\\u0644\\u062a\\u062e\\u0635\\u0635 \\u0627\\u0644\\u062f\\u0642\\u064a\\u0642\",\"\\u062e\\u062f\\u0645\\u0627\\u062a \\u0625\\u0639\\u0627\\u062f\\u0629 \\u0627\\u0644\\u062a\\u0623\\u0647\\u064a\\u0644\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(212, 105, 21, 'الرعاية التي تركز على المريض', '[\"\\u0646\\u0647\\u062c \\u0634\\u0645\\u0648\\u0644\\u064a\",\"\\u0627\\u0644\\u062f\\u0641\\u0627\\u0639 \\u0639\\u0646 \\u0627\\u0644\\u0645\\u0631\\u0636\\u0649\",\"\\u0627\\u0644\\u0644\\u063a\\u0629 \\u0648\\u0627\\u0644\\u062d\\u0633\\u0627\\u0633\\u064a\\u0629 \\u0627\\u0644\\u062b\\u0642\\u0627\\u0641\\u064a\\u0629\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(213, 106, 21, 'المشاركة المجتمعية', '[\"\\u0628\\u0631\\u0627\\u0645\\u062c \\u0627\\u0644\\u062a\\u062b\\u0642\\u064a\\u0641 \\u0627\\u0644\\u0635\\u062d\\u064a\",\"\\u0641\\u062d\\u0648\\u0635\\u0627\\u062a \\u0635\\u062d\\u0629 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\",\"\\u0627\\u0644\\u0634\\u0631\\u0627\\u0643\\u0627\\u062a \\u0627\\u0644\\u062a\\u0639\\u0627\\u0648\\u0646\\u064a\\u0629\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02'),
(214, 107, 21, 'الجودة والسلامة', '[\"\\u0627\\u0644\\u0627\\u0639\\u062a\\u0645\\u0627\\u062f \\u0648\\u0627\\u0644\\u0634\\u0647\\u0627\\u062f\\u0627\\u062a\",\"\\u0627\\u0644\\u062a\\u062d\\u0633\\u064a\\u0646 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0645\\u0631 \\u0644\\u0644\\u062c\\u0648\\u062f\\u0629\",\"\\u062a\\u062f\\u0627\\u0628\\u064a\\u0631 \\u0645\\u0643\\u0627\\u0641\\u062d\\u0629 \\u0627\\u0644\\u0639\\u062f\\u0648\\u0649\"]', '2024-05-08 02:54:02', '2024-05-08 02:54:02');

-- --------------------------------------------------------

--
-- Table structure for table `listing_images`
--

CREATE TABLE `listing_images` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_images`
--

INSERT INTO `listing_images` (`id`, `listing_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, '663303c0686b9.jpg', '2024-05-01 21:08:48', '2024-05-01 21:11:39'),
(2, 1, '663303c0686ae.jpg', '2024-05-01 21:08:48', '2024-05-01 21:11:39'),
(3, 1, '663303c0917ac.jpg', '2024-05-01 21:08:48', '2024-05-01 21:11:39'),
(4, 1, '663303c091d22.jpg', '2024-05-01 21:08:48', '2024-05-01 21:11:39'),
(5, 1, '663303c0b55d8.jpg', '2024-05-01 21:08:48', '2024-05-01 21:11:39'),
(11, 3, '663321672525b.jpg', '2024-05-01 23:15:19', '2024-05-01 23:18:29'),
(12, 3, '6633216725271.jpg', '2024-05-01 23:15:19', '2024-05-01 23:18:29'),
(13, 3, '663321674e34b.jpg', '2024-05-01 23:15:19', '2024-05-01 23:18:29'),
(14, 3, '6633216752563.jpg', '2024-05-01 23:15:19', '2024-05-01 23:18:29'),
(15, 3, '663321677a161.jpg', '2024-05-01 23:15:19', '2024-05-01 23:18:29'),
(16, 4, '66334eaa734e5.jpg', '2024-05-02 02:28:26', '2024-05-02 02:33:34'),
(17, 4, '66334eaa742f6.jpg', '2024-05-02 02:28:26', '2024-05-02 02:33:34'),
(18, 4, '66334eaaab007.jpg', '2024-05-02 02:28:26', '2024-05-02 02:33:34'),
(19, 4, '66334eaaac55e.jpg', '2024-05-02 02:28:26', '2024-05-02 02:33:34'),
(20, 4, '66334eaae51cc.jpg', '2024-05-02 02:28:26', '2024-05-02 02:33:34'),
(21, 5, '6638469558198.jpg', '2024-05-05 20:55:17', '2024-05-05 20:59:19'),
(22, 5, '6638469560ab7.jpg', '2024-05-05 20:55:17', '2024-05-05 20:59:19'),
(23, 5, '663846958a097.jpg', '2024-05-05 20:55:17', '2024-05-05 20:59:19'),
(24, 5, '6638469591b96.jpg', '2024-05-05 20:55:17', '2024-05-05 20:59:19'),
(25, 5, '66384695aff7f.jpg', '2024-05-05 20:55:17', '2024-05-05 20:59:19'),
(26, 6, '66385162bfca7.jpg', '2024-05-05 21:41:22', '2024-05-05 21:47:53'),
(27, 6, '66385162c3bd2.jpg', '2024-05-05 21:41:22', '2024-05-05 21:47:53'),
(28, 6, '66385162f33cf.jpg', '2024-05-05 21:41:22', '2024-05-05 21:47:53'),
(29, 6, '663851630692f.jpg', '2024-05-05 21:41:23', '2024-05-05 21:47:53'),
(30, 6, '66385163280df.jpg', '2024-05-05 21:41:23', '2024-05-05 21:47:53'),
(31, 7, '663863db61c60.jpg', '2024-05-05 23:00:11', '2024-05-05 23:06:52'),
(32, 7, '663863db6bcbc.jpg', '2024-05-05 23:00:11', '2024-05-05 23:06:52'),
(33, 7, '663863db88804.jpg', '2024-05-05 23:00:11', '2024-05-05 23:06:52'),
(34, 7, '663863db951e9.jpg', '2024-05-05 23:00:11', '2024-05-05 23:06:52'),
(35, 7, '663863dbb515b.jpg', '2024-05-05 23:00:11', '2024-05-05 23:06:52'),
(41, 9, '66399335a42a0.jpg', '2024-05-06 20:34:29', '2024-05-06 20:37:35'),
(42, 9, '66399335a42a0.jpg', '2024-05-06 20:34:29', '2024-05-06 20:37:35'),
(43, 9, '66399335cef34.jpg', '2024-05-06 20:34:29', '2024-05-06 20:37:35'),
(44, 9, '66399335daa26.jpg', '2024-05-06 20:34:29', '2024-05-06 20:37:35'),
(45, 9, '6639933605387.jpg', '2024-05-06 20:34:30', '2024-05-06 20:37:35'),
(46, 10, '66399d5bbe8cf.jpg', '2024-05-06 21:17:47', '2024-05-06 21:22:20'),
(47, 10, '66399d5bc409d.jpg', '2024-05-06 21:17:47', '2024-05-06 21:22:20'),
(48, 10, '66399d5bed80e.jpg', '2024-05-06 21:17:47', '2024-05-06 21:22:20'),
(49, 10, '66399d5bf07ce.jpg', '2024-05-06 21:17:47', '2024-05-06 21:22:20'),
(50, 10, '66399d5c23332.jpg', '2024-05-06 21:17:48', '2024-05-06 21:22:20'),
(51, 11, '6639adcd305bb.jpg', '2024-05-06 22:27:57', '2024-05-06 22:34:31'),
(52, 11, '6639adcd3bb02.jpg', '2024-05-06 22:27:57', '2024-05-06 22:34:31'),
(53, 11, '6639adcd5a415.jpg', '2024-05-06 22:27:57', '2024-05-06 22:34:31'),
(54, 11, '6639adcd6e6bf.jpg', '2024-05-06 22:27:57', '2024-05-06 22:34:31'),
(55, 11, '6639adcd818f6.jpg', '2024-05-06 22:27:57', '2024-05-06 22:34:31'),
(56, 12, '6639c38d900ac.jpg', '2024-05-07 00:00:45', '2024-05-07 00:07:13'),
(57, 12, '6639c3929e89d.jpg', '2024-05-07 00:00:50', '2024-05-07 00:07:13'),
(58, 12, '6639c392a0f8e.jpg', '2024-05-07 00:00:50', '2024-05-07 00:07:13'),
(59, 12, '6639c392ccbd2.jpg', '2024-05-07 00:00:50', '2024-05-07 00:07:13'),
(60, 12, '6639c392ce66c.jpg', '2024-05-07 00:00:50', '2024-05-07 00:07:13'),
(65, NULL, '6639e7c4d3d72.jpg', '2024-05-07 02:35:16', '2024-05-07 02:35:16'),
(66, 13, '6639e7db2420a.jpg', '2024-05-07 02:35:39', '2024-05-07 02:40:46'),
(67, 13, '6639e7db29ac4.jpg', '2024-05-07 02:35:39', '2024-05-07 02:40:46'),
(68, 13, '6639e7db51eee.jpg', '2024-05-07 02:35:39', '2024-05-07 02:40:46'),
(69, 13, '6639e7db546b4.jpg', '2024-05-07 02:35:39', '2024-05-07 02:40:46'),
(70, 13, '6639e7db76aa1.jpg', '2024-05-07 02:35:39', '2024-05-07 02:40:46'),
(76, 14, '663af05188f79.jpg', '2024-05-07 21:24:01', '2024-05-07 21:24:07'),
(77, 14, '663af05188fa5.jpg', '2024-05-07 21:24:01', '2024-05-07 21:24:07'),
(78, 14, '663af051b1beb.jpg', '2024-05-07 21:24:01', '2024-05-07 21:24:07'),
(79, 14, '663af051b60b6.jpg', '2024-05-07 21:24:01', '2024-05-07 21:24:07'),
(80, 14, '663af051d6688.jpg', '2024-05-07 21:24:01', '2024-05-07 21:24:07'),
(86, 15, '663b4b6a1da7a.jpg', '2024-05-08 03:52:42', '2024-05-08 03:52:45'),
(87, NULL, '6784864de9162.jpg', '2025-01-12 21:19:41', '2025-01-12 21:19:41'),
(88, NULL, '6784866f29a72.jpg', '2025-01-12 21:20:15', '2025-01-12 21:20:15'),
(89, NULL, '678486710d185.jpg', '2025-01-12 21:20:17', '2025-01-12 21:20:17'),
(90, NULL, '67848675e24c6.jpg', '2025-01-12 21:20:21', '2025-01-12 21:20:21'),
(91, NULL, '67848675ed4a0.jpg', '2025-01-12 21:20:21', '2025-01-12 21:20:21'),
(92, NULL, '6784867618643.jpg', '2025-01-12 21:20:22', '2025-01-12 21:20:22'),
(93, NULL, '6784867620b56.jpg', '2025-01-12 21:20:22', '2025-01-12 21:20:22'),
(94, NULL, '678486763d31e.jpg', '2025-01-12 21:20:22', '2025-01-12 21:20:22'),
(95, NULL, '6784867649464.jpg', '2025-01-12 21:20:22', '2025-01-12 21:20:22'),
(96, NULL, '6784867a1f57e.jpg', '2025-01-12 21:20:26', '2025-01-12 21:20:26'),
(97, NULL, '68f0ebfc0f005.jpg', '2025-10-16 06:58:36', '2025-10-16 06:58:36'),
(98, NULL, '68f0ebfc191e4.jpg', '2025-10-16 06:58:36', '2025-10-16 06:58:36'),
(101, NULL, '68fc694d38836.jpg', '2025-10-25 00:08:13', '2025-10-25 00:08:13'),
(102, NULL, '68fc704b085f8.jpg', '2025-10-25 00:38:03', '2025-10-25 00:38:03'),
(103, NULL, '68fc717677aa4.jpg', '2025-10-25 00:43:02', '2025-10-25 00:43:02'),
(106, NULL, '69089ac413644.jpg', '2025-11-03 06:06:28', '2025-11-03 06:06:28'),
(107, NULL, '69089ac41345c.jpg', '2025-11-03 06:06:28', '2025-11-03 06:06:28'),
(108, 17, '69089accd9a65.jpg', '2025-11-03 06:06:36', '2025-11-03 06:08:23'),
(109, 17, '69089acce30dc.jpg', '2025-11-03 06:06:36', '2025-11-03 06:08:23'),
(110, 18, '69089eb21d2dc.jpg', '2025-11-03 06:23:14', '2025-11-03 06:24:56'),
(111, 18, '69089eb21e2ea.jpg', '2025-11-03 06:23:14', '2025-11-03 06:24:56'),
(112, NULL, '69abe8e20516d.jpg', '2026-03-07 02:59:14', '2026-03-07 02:59:14');

-- --------------------------------------------------------

--
-- Table structure for table `listing_messages`
--

CREATE TABLE `listing_messages` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_messages`
--

INSERT INTO `listing_messages` (`id`, `listing_id`, `vendor_id`, `name`, `email`, `phone`, `message`, `created_at`, `updated_at`) VALUES
(1, 3, 204, 'Jack', 'jack234534@gmail.com', '35475465345', 'What inspired you to start Dreamscapes Travel Agency, and what sets it apart from other travel agencies?', '2024-05-07 23:33:50', '2024-05-07 23:33:50'),
(2, 3, 204, 'Jack jos', 'jack234534@gmail.com', '35463546356', 'How does Dreamscapes handle unforeseen circumstances or emergencies during travel?', '2024-05-07 23:34:48', '2024-05-07 23:34:48'),
(3, 14, 204, 'test', 'daspobin027@gmail.com', '34579854354679', 'Could you share any memorable or unique travel packages or experiences that Dreamscapes has curated for clients?', '2024-05-07 23:37:11', '2024-05-07 23:37:11'),
(4, 1, 204, 'المثالية مع', 'fgwergert3450354@gmail.com', '23458354635465478', 'Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?', '2024-05-07 23:37:51', '2024-05-07 23:37:51'),
(5, 14, 204, 'المثالية مع', 'a@gmail.com', '3546354654', 'Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?', '2024-05-07 23:43:16', '2024-05-07 23:43:16'),
(8, 11, NULL, 'saiful islam sharif', 'saifislamfci@gmail.co', '0187233757', 'Ki re kemon acos', '2025-11-17 23:51:13', '2025-11-17 23:51:13'),
(10, 14, 204, 'May Knight', 'zezexo@mailinator.com', '92', 'Veniam rerum in del', '2026-05-13 01:17:28', '2026-05-13 01:17:28');

-- --------------------------------------------------------

--
-- Table structure for table `listing_products`
--

CREATE TABLE `listing_products` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `feature_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previous_price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_products`
--

INSERT INTO `listing_products` (`id`, `listing_id`, `vendor_id`, `feature_image`, `status`, `current_price`, `previous_price`, `created_at`, `updated_at`) VALUES
(1, 1, 204, '1714619767.png', '1', '67', '78', '2024-05-01 21:16:07', '2024-05-01 21:16:07'),
(2, 1, 204, '1714619849.png', '1', '899', '993', '2024-05-01 21:17:29', '2024-05-01 21:17:29'),
(3, 1, 204, '1714619950.png', '1', '98', '189', '2024-05-01 21:19:10', '2024-05-01 21:19:10'),
(10, 11, 202, '1715058151.png', '1', '900', '1167', '2024-05-06 23:02:31', '2024-05-06 23:02:31'),
(11, 11, 202, '1715058236.png', '1', '789', '990', '2024-05-06 23:03:56', '2024-05-06 23:03:56'),
(12, 11, 202, '1715059193.png', '1', '999', '1200', '2024-05-06 23:19:53', '2024-05-06 23:19:53'),
(13, 11, 202, '1715059291.png', '1', '699', '987', '2024-05-06 23:21:31', '2024-05-06 23:21:31'),
(14, 5, 207, '1758432281.png', '1', '2', '5', '2025-09-20 23:24:41', '2025-09-20 23:24:41');

-- --------------------------------------------------------

--
-- Table structure for table `listing_product_contents`
--

CREATE TABLE `listing_product_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` int DEFAULT NULL,
  `listing_id` bigint DEFAULT NULL,
  `listing_product_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keyword` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_product_contents`
--

INSERT INTO `listing_product_contents` (`id`, `language_id`, `listing_id`, `listing_product_id`, `title`, `slug`, `content`, `meta_keyword`, `meta_description`, `created_at`, `updated_at`) VALUES
(1, 20, 1, 1, 'Salon Chair', 'salon-chair', '<ul>\r\n<li>Color: Black, Coffee<br />Material: Artificial Leather, Plastic, SS<br />Value Addition: Non-Hydraulic<br />Place of Origin: Bangladesh<br />Height: Adjustable<br />Care Instructions: Wipe with Soft Dry Brush After Use.<br />Features: Durable &amp; Comfortable.</li>\r\n</ul>', NULL, NULL, '2024-05-01 21:16:07', '2024-05-01 21:16:07'),
(2, 21, 1, 1, 'كرسي صالون', 'كرسي-صالون', '<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">اللون: أسود، قهوة\r\nالمواد: جلد صناعي، بلاستيك، SS\r\nإضافة القيمة: غير هيدروليكي\r\nمكان المنشأ: بنجلاديش\r\nالارتفاع: قابل للتعديل\r\nتعليمات العناية: امسحي بفرشاة جافة ناعمة بعد الاستخدام.\r\nالميزات: متين ومريح.</span></pre>', NULL, NULL, '2024-05-01 21:16:07', '2024-05-01 21:16:07'),
(3, 20, 1, 2, 'Hair Curler', 'hair-curler', '<p>A hair roller or hair curler is a small tube that is rolled into a person\'s hair in order to curl it, or to straighten curly hair, making a new hairstyle.[1]</p>\r\n<p>The diameter of a roller varies from approximately 0.8 inches (20 mm) to 1.5 inches (38 mm). The hair is heated, and the rollers strain and break the hydrogen bonds[citation needed] of each hair\'s cortex, which causes the hair to curl. The hydrogen bonds reform after the hair is moistened.</p>\r\n<p>A hot roller or hot curler is designed to be heated in an electric chamber before one rolls it into the hair.[2] Alternatively, a hair dryer heats the hair after the rolls are in place. Hair spray can temporarily fix curled hair in place.</p>\r\n<p>In 1930, Solomon Harper created the first electrically heated hair rollers, then creating a better design in 1953.</p>\r\n<p>In 1968 at the feminist Miss America protest, protesters symbolically threw a number of feminine products into a \"Freedom Trash Can\". These included hair rollers,[3] which were among items the protesters called \"instruments of female torture\"[4] and accoutrements of what they perceived to be enforced femininity.</p>', NULL, NULL, '2024-05-01 21:17:29', '2024-05-01 21:17:29'),
(4, 21, 1, 2, 'مجعد الشعر', 'مجعد-الشعر', '<p>بكرة الشعر أو أداة تجعيد الشعر عبارة عن أنبوب صغير يتم لفه في شعر الشخص من أجل تجعيده، أو تنعيم الشعر المجعد، وعمل تسريحة شعر جديدة.</p>\r\n<p>يتراوح قطر الأسطوانة من حوالي 0.8 بوصة (20 ملم) إلى 1.5 بوصة (38 ملم). يتم تسخين الشعر، وتقوم البكرات بإجهاد وكسر الروابط الهيدروجينية لقشرة كل شعرة، مما يتسبب في تجعد الشعر. يتم إصلاح الروابط الهيدروجينية بعد ترطيب الشعر.</p>\r\n<p>تم تصميم الأسطوانة الساخنة أو أداة تجعيد الشعر الساخنة بحيث يتم تسخينها في غرفة كهربائية قبل لفها في الشعر. بدلًا من ذلك، يقوم مجفف الشعر بتسخين الشعر بعد وضع اللفائف في مكانها. يمكن لرذاذ الشعر تثبيت الشعر المجعد في مكانه بشكل مؤقت.</p>\r\n<p>في عام 1930، ابتكر سولومون هاربر أول بكرات شعر يتم تسخينها كهربائيًا، ثم ابتكر تصميمًا أفضل في عام 1953.</p>\r\n<p>في عام 1968، أثناء احتجاج ملكة جمال أمريكا النسوية، ألقى المتظاهرون بشكل رمزي عددًا من المنتجات النسائية في \"سلة مهملات الحرية\". وشملت هذه بكرات الشعر، والتي كانت من بين العناصر التي أطلق عليها المتظاهرون \"أدوات تعذيب الإناث\" ومستلزمات ما اعتبروه أنوثة قسرية.</p>', NULL, NULL, '2024-05-01 21:17:29', '2024-05-01 21:17:29'),
(5, 20, 1, 3, 'Shampoo Bowl', 'shampoo-bowl', '<p>Minerva Beauty offers a variety of shampoo bowls and wet stations for salons and barbershops, including standalone shampoo bowls you can pair with your existing shampoo cabinet or wall unit, pedestal shampoo bowls, barber wet stations, and barber sinks paired with a cabinet and mirror. Minerva shampoo bowls come with mounting hardware and all the parts your plumber needs to install them, and we also provide shampoo bowl replacement parts and accessories. Add more storage to your professional shampoo stations with lower and upper cabinets, available in a wide range of colors and finishes including custom options. Don’t forget to pick up a shampoo chair to pair with your hair wash bowl, or browse our shampoo backwash units for ready-made setups. We also have a helpful guide to choosing the best shampoo bowl and chair that covers dimensions, accessibility and more.</p>', NULL, NULL, '2024-05-01 21:19:10', '2024-05-01 21:19:10'),
(6, 21, 1, 3, 'وعاء الشامبو', 'وعاء-الشامبو', '<p>تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.<br /><br /></p>', NULL, NULL, '2024-05-01 21:19:10', '2024-05-01 21:19:10'),
(19, 20, 11, 10, 'Pull-Up Bar', 'pull-up-bar', '<p>A pull-up bar is a simple yet versatile piece of exercise equipment designed for upper body workouts. Typically mounted on a doorframe or installed as a standalone unit, it allows users to perform various exercises targeting muscles like the back, arms, and shoulders. By gripping the bar and lifting one\'s body weight, pull-ups and chin-ups engage multiple muscle groups, promoting strength and endurance. Portable options exist for home use, while gym-grade bars offer durability and stability for intensive workouts.</p>', NULL, NULL, '2024-05-06 23:02:32', '2024-05-06 23:02:32'),
(20, 21, 11, 10, 'اسحب الشريط', 'اسحب-الشريط', '<p>شريط السحب عبارة عن قطعة بسيطة ومتعددة الاستخدامات من معدات التمارين المصممة لتدريبات الجزء العلوي من الجسم. يتم تركيبه عادةً على إطار الباب أو تثبيته كوحدة مستقلة، وهو يسمح للمستخدمين بأداء تمارين مختلفة تستهدف العضلات مثل الظهر والذراعين والكتفين. من خلال الإمساك بالقضيب ورفع وزن الجسم، تعمل عمليات السحب والذقن على إشراك مجموعات عضلية متعددة، مما يعزز القوة والتحمل. توجد خيارات محمولة للاستخدام المنزلي، بينما توفر القضبان المخصصة للصالة الرياضية المتانة والثبات للتمرينات المكثفة.</p>', NULL, NULL, '2024-05-06 23:02:32', '2024-05-06 23:02:32'),
(21, 20, 11, 11, 'Stationary Bike', 'stationary-bike', '<p>Introducing the Stationary Bike, your ultimate companion in fitness journey and wellness. Designed to bring the exhilaration of cycling into the comfort of your home, this sleek and sturdy exercise bike offers a dynamic workout experience tailored to your needs.</p>\r\n<p>Crafted with premium materials and cutting-edge engineering, our Stationary Bike ensures durability and stability, providing a secure platform for your workouts. Whether you\'re a beginner looking to kickstart your fitness routine or a seasoned athlete aiming to push your limits, this bike is built to accommodate users of all fitness levels.</p>', NULL, NULL, '2024-05-06 23:03:56', '2024-05-06 23:03:56'),
(22, 21, 11, 11, 'دراجة ثابتة', 'دراجة-ثابتة', '<p>نقدم لكم الدراجة الثابتة، رفيقكم المثالي في رحلة اللياقة البدنية والعافية. صُممت هذه الدراجة الرياضية الأنيقة والمتينة لجلب متعة ركوب الدراجات إلى راحة منزلك، وتوفر تجربة تمرين ديناميكية مصممة خصيصًا لتلبية احتياجاتك.</p>\r\n<p>تضمن دراجتنا الثابتة، المصنوعة من مواد فاخرة وهندسة متطورة، المتانة والثبات، وتوفر منصة آمنة لتدريباتك. سواء كنت مبتدئًا يتطلع إلى بدء روتين اللياقة البدنية الخاص بك أو رياضيًا متمرسًا يهدف إلى تجاوز حدودك، فقد تم تصميم هذه الدراجة لاستيعاب المستخدمين من جميع مستويات اللياقة البدنية.</p>', NULL, NULL, '2024-05-06 23:03:56', '2024-05-06 23:03:56'),
(23, 20, 11, 12, 'Treadmill', 'treadmill', '<p>Healthfit Foldable Semi Commercial Motorized Treadmill 586DS Price In Bangladesh When it comes to buying a treadmill make sure the treadmill has all the features for your needs. Our Asian Sky Shop offers you a semi-commercial motorized treadmill that has so many features and specifications. It\'s manufactured by Healthfit. This foldable treadmill is easy to carry and user comfortable. We are giving you an affordable price range and lots of facilities.</p>', NULL, NULL, '2024-05-06 23:19:53', '2024-05-06 23:19:53'),
(24, 21, 11, 12, 'جهاز المشي', 'جهاز-المشي', '<p>جهاز المشي الكهربائي القابل للطي شبه التجاري من السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian Sky Shop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.</p>', NULL, NULL, '2024-05-06 23:19:53', '2024-05-06 23:19:53'),
(25, 20, 11, 13, 'Kettlebells', 'kettlebells', '<p>A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying supine on the floor to standing, and back again. Get-ups are sometimes modified into get-up presses, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.</p>', NULL, NULL, '2024-05-06 23:21:31', '2024-05-06 23:21:31'),
(26, 21, 11, 13, 'أجراس كيتل', 'أجراس-كيتل', '<p>تمرين كيتل بيل الذي يجمع بين تمرين الاندفاع والجسر واللوح الجانبي في حركة بطيئة ومنضبطة. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات الاستيقاظ أحيانًا إلى مكابس الاستيقاظ، مع الضغط على كل موضع من موضع الاستيقاظ؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي.</p>', NULL, NULL, '2024-05-06 23:21:31', '2024-05-06 23:21:31'),
(27, 20, 5, 14, 'product under the listing', 'product-under-the-listing', '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham</p>', NULL, NULL, '2025-09-20 23:24:42', '2025-09-20 23:24:42'),
(28, 21, 5, 14, 'product under the listing', 'product-under-the-listing', '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham</p>', NULL, NULL, '2025-09-20 23:24:42', '2025-09-20 23:24:42');

-- --------------------------------------------------------

--
-- Table structure for table `listing_product_images`
--

CREATE TABLE `listing_product_images` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `listing_product_id` int DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_product_images`
--

INSERT INTO `listing_product_images` (`id`, `listing_id`, `listing_product_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '66330541d4350.jpg', '2024-05-01 21:15:13', '2024-05-01 21:16:07'),
(2, 1, 1, '66330541dd559.jpg', '2024-05-01 21:15:13', '2024-05-01 21:16:07'),
(3, 1, 1, '663305420e68a.jpg', '2024-05-01 21:15:14', '2024-05-01 21:16:07'),
(4, 1, 2, '663305987e915.jpg', '2024-05-01 21:16:40', '2024-05-01 21:17:29'),
(5, 1, 2, '6633059882453.jpg', '2024-05-01 21:16:40', '2024-05-01 21:17:29'),
(6, 1, 2, '66330598ae19e.jpg', '2024-05-01 21:16:40', '2024-05-01 21:17:29'),
(7, 1, 3, '6633060932edb.jpg', '2024-05-01 21:18:33', '2024-05-01 21:19:10'),
(8, 1, 3, '6633060dd0733.jpg', '2024-05-01 21:18:37', '2024-05-01 21:19:10'),
(9, 1, 3, '6633060dd5ae9.jpg', '2024-05-01 21:18:37', '2024-05-01 21:19:10'),
(22, NULL, NULL, '663899b0c01f2.jpg', '2024-05-06 02:49:52', '2024-05-06 02:49:52'),
(23, NULL, NULL, '663899b0c0228.jpg', '2024-05-06 02:49:52', '2024-05-06 02:49:52'),
(24, NULL, NULL, '663899b0eb65c.jpg', '2024-05-06 02:49:52', '2024-05-06 02:49:52'),
(32, 11, 10, '6639b5b4c018e.jpg', '2024-05-06 23:01:40', '2024-05-06 23:02:31'),
(33, 11, 10, '6639b5b6aad44.jpg', '2024-05-06 23:01:42', '2024-05-06 23:02:31'),
(34, 11, 10, '6639b5b8a2fba.jpg', '2024-05-06 23:01:44', '2024-05-06 23:02:31'),
(35, 11, 11, '6639b60dbbe09.jpg', '2024-05-06 23:03:09', '2024-05-06 23:03:56'),
(36, 11, 11, '6639b6115f8b2.jpg', '2024-05-06 23:03:13', '2024-05-06 23:03:56'),
(37, 11, 11, '6639b6116d089.jpg', '2024-05-06 23:03:13', '2024-05-06 23:03:56'),
(38, 11, 12, '6639b6cd51b10.jpg', '2024-05-06 23:06:21', '2024-05-06 23:19:53'),
(39, 11, 12, '6639b6cd51b1d.jpg', '2024-05-06 23:06:21', '2024-05-06 23:19:53'),
(40, 11, 12, '6639b6cd791f8.jpg', '2024-05-06 23:06:21', '2024-05-06 23:19:53'),
(41, 11, 13, '6639ba3fdb5f0.jpg', '2024-05-06 23:21:03', '2024-05-06 23:21:31'),
(42, 11, 13, '6639ba3fe5509.jpg', '2024-05-06 23:21:03', '2024-05-06 23:21:31'),
(43, 11, 13, '6639ba400fea7.jpg', '2024-05-06 23:21:04', '2024-05-06 23:21:31'),
(44, NULL, NULL, '68cf8bcac2b42.jpg', '2025-09-20 23:23:22', '2025-09-20 23:23:22'),
(45, NULL, NULL, '68cf8bcb272b2.jpg', '2025-09-20 23:23:23', '2025-09-20 23:23:23'),
(46, NULL, NULL, '68cf8bcb59196.jpg', '2025-09-20 23:23:23', '2025-09-20 23:23:23'),
(47, NULL, NULL, '68cf8bcb5cd0e.jpg', '2025-09-20 23:23:23', '2025-09-20 23:23:23'),
(48, NULL, NULL, '68cf8bcb9561e.jpg', '2025-09-20 23:23:23', '2025-09-20 23:23:23'),
(49, NULL, NULL, '68cf8bcb979f2.jpg', '2025-09-20 23:23:23', '2025-09-20 23:23:23'),
(50, NULL, NULL, '68cf8bcbe2843.jpg', '2025-09-20 23:23:23', '2025-09-20 23:23:23'),
(51, NULL, NULL, '68cf8bcbe3761.jpg', '2025-09-20 23:23:23', '2025-09-20 23:23:23'),
(52, NULL, NULL, '68cf8bcc1bc77.jpg', '2025-09-20 23:23:24', '2025-09-20 23:23:24'),
(53, 5, 14, '68cf8bdcd395e.jpg', '2025-09-20 23:23:40', '2025-09-20 23:24:41'),
(54, 5, 14, '68cff667a714f.jpg', '2025-09-21 06:58:15', '2025-09-21 06:58:18'),
(55, 5, 14, '68cff667a92f0.jpg', '2025-09-21 06:58:15', '2025-09-21 06:58:18'),
(56, 5, 14, '68cff667db3fe.jpg', '2025-09-21 06:58:15', '2025-09-21 06:58:18');

-- --------------------------------------------------------

--
-- Table structure for table `listing_reviews`
--

CREATE TABLE `listing_reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `listing_id` bigint DEFAULT NULL,
  `rating` bigint DEFAULT NULL,
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_reviews`
--

INSERT INTO `listing_reviews` (`id`, `user_id`, `listing_id`, `rating`, `review`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 5, 'Visiting Saddle & Sip Saloon was an absolute delight from start to finish. Stepping into the salon, I was immediately impressed by the sleek and modern ambiance. The cleanliness and attention to detail were evident, which was particularly reassuring given the ongoing concerns about safety during the pandemic.', '2024-05-01 22:16:02', '2024-05-01 22:16:02'),
(2, 1, 1, 4, 'My recent visit to Saddle & Sip Saloon was an indulgent experience from start to finish. As I entered the salon, I was greeted by an atmosphere of sophistication and tranquility. The chic décor and soothing ambiance instantly set the tone for what promised to be a pampering session unlike any other.', '2024-05-01 22:18:55', '2024-05-01 22:18:55'),
(5, 2, 4, 3, 'My stay at Tranquil Haven Hotel was absolutely delightful. The oceanfront location provided stunning views, and the sound of the waves was incredibly soothing. The room was spacious, elegantly decorated, and equipped with all the modern amenities I needed for a comfortable stay. The staff were attentive and friendly, always ready to assist with any requests. I particularly enjoyed the dining experience at the hotel\'s restaurant; the food was exquisite and the ambiance was perfect for a relaxing meal. Overall, I highly recommend Tranquil Haven Hotel to anyone looking for a peaceful retreat by the sea.', '2024-05-02 03:02:23', '2024-05-02 03:02:23'),
(6, 1, 4, 4, 'Tranquil Haven Hotel exceeded all my expectations. From the moment I arrived, I was greeted with warmth and hospitality. The hotel\'s facilities, including the spa and fitness center, were top-notch and provided the perfect opportunity for relaxation and rejuvenation. The room was tastefully decorated, with a comfortable bed and a balcony overlooking the ocean. I also appreciated the attention to detail in the amenities provided. Whether it was enjoying a leisurely swim in the pool or savoring a delicious meal at the restaurant, every moment spent at Tranquil Haven was truly enjoyable. I can\'t wait to return for another stay.', '2024-05-02 03:03:28', '2024-05-02 03:03:28'),
(8, 2, 14, 4, 'Excellent service and very professional communication. The work was completed on time with great attention to detail. Everything was handled smoothly and exactly as expected. Highly recommended for anyone looking for reliable and quality service.', '2026-05-12 08:20:08', '2026-05-12 08:20:08');

-- --------------------------------------------------------

--
-- Table structure for table `listing_sections`
--

CREATE TABLE `listing_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_sections`
--

INSERT INTO `listing_sections` (`id`, `language_id`, `title`, `subtitle`, `button_text`, `created_at`, `updated_at`) VALUES
(3, 20, 'Trending Latest Listing', NULL, 'All Listings', '2023-10-18 21:37:18', '2024-05-06 03:07:01'),
(4, 21, 'فئات السيارات الشعبية', 'فئات السيارات الشعبيةفئات السيارات الشعبيةفئات السيارات الشعبيةفئات السيارات الشعبيةفئات السيارات الشعبية', 'فئات السيارات الشعبية', '2023-10-18 21:38:06', '2023-12-12 22:23:21');

-- --------------------------------------------------------

--
-- Table structure for table `listing_socail_medias`
--

CREATE TABLE `listing_socail_medias` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_socail_medias`
--

INSERT INTO `listing_socail_medias` (`id`, `listing_id`, `icon`, `link`, `created_at`, `updated_at`) VALUES
(3, 1, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-01 21:38:35', '2024-05-01 21:38:35'),
(4, 1, 'fab fa-youtube', 'https://www.example.com', '2024-05-01 21:38:35', '2024-05-01 21:38:35'),
(5, 1, 'fab fa-linkedin-in', 'https://www.example.com', '2024-05-01 21:38:35', '2024-05-01 21:38:35'),
(45, 3, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-05 23:10:30', '2024-05-05 23:10:30'),
(46, 3, 'fab fa-youtube-square iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:30', '2024-05-05 23:10:30'),
(47, 3, 'fab fa-twitter iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:30', '2024-05-05 23:10:30'),
(48, 3, 'fab fa-linkedin-in iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:30', '2024-05-05 23:10:30'),
(49, 4, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-05 23:10:38', '2024-05-05 23:10:38'),
(50, 4, 'fab fa-twitter iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:38', '2024-05-05 23:10:38'),
(51, 4, 'fab fa-youtube iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:38', '2024-05-05 23:10:38'),
(52, 4, 'fab fa-instagram iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:38', '2024-05-05 23:10:38'),
(53, 5, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-05 23:10:46', '2024-05-05 23:10:46'),
(54, 5, 'fab fa-youtube iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:46', '2024-05-05 23:10:46'),
(55, 5, 'fas fa-times iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:46', '2024-05-05 23:10:46'),
(56, 5, 'fab fa-linkedin-in iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:46', '2024-05-05 23:10:46'),
(57, 6, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-05 23:10:53', '2024-05-05 23:10:53'),
(58, 6, 'fab fa-youtube iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:53', '2024-05-05 23:10:53'),
(59, 6, 'fab fa-linkedin-in iconpicker-component', 'https://www.example.com', '2024-05-05 23:10:53', '2024-05-05 23:10:53'),
(60, 7, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-05 23:11:02', '2024-05-05 23:11:02'),
(61, 7, 'fab fa-twitter iconpicker-component', 'https://www.example.com', '2024-05-05 23:11:02', '2024-05-05 23:11:02'),
(62, 7, 'fab fa-linkedin-in iconpicker-component', 'https://www.example.com', '2024-05-05 23:11:02', '2024-05-05 23:11:02'),
(63, 7, 'fab fa-youtube iconpicker-component', 'https://www.example.com', '2024-05-05 23:11:02', '2024-05-05 23:11:02'),
(68, 9, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-06 20:46:06', '2024-05-06 20:46:06'),
(69, 9, 'fab fa-youtube-square', 'https://www.example.com', '2024-05-06 20:46:06', '2024-05-06 20:46:06'),
(70, 9, 'fab fa-twitter', 'https://www.example.com', '2024-05-06 20:46:06', '2024-05-06 20:46:06'),
(71, 9, 'fab fa-linkedin-in', 'https://www.example.com', '2024-05-06 20:46:06', '2024-05-06 20:46:06'),
(72, 10, 'fab fa-facebook-messenger', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-06 21:23:10', '2024-05-06 21:23:10'),
(73, 10, 'fab fa-twitter-square', 'https://www.example.com', '2024-05-06 21:23:10', '2024-05-06 21:23:10'),
(74, 10, 'fab fa-linkedin', 'https://www.example.com', '2024-05-06 21:23:10', '2024-05-06 21:23:10'),
(75, 10, 'fab fa-youtube', 'https://www.example.com', '2024-05-06 21:23:10', '2024-05-06 21:23:10'),
(76, 11, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-06 22:36:32', '2024-05-06 22:36:32'),
(77, 11, 'fab fa-facebook-square iconpicker-component', 'https://www.example.com', '2024-05-06 22:36:32', '2024-05-06 22:36:32'),
(78, 11, 'fab fa-facebook-square iconpicker-component', 'https://www.example.com', '2024-05-06 22:36:32', '2024-05-06 22:36:32'),
(79, 11, 'fab fa-facebook-square iconpicker-component', 'https://www.example.com', '2024-05-06 22:36:32', '2024-05-06 22:36:32'),
(80, 12, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-07 00:10:23', '2024-05-07 00:10:23'),
(81, 12, 'fab fa-twitter', 'https://www.example.com', '2024-05-07 00:10:23', '2024-05-07 00:10:23'),
(82, 12, 'fab fa-youtube', 'https://www.example.com', '2024-05-07 00:10:23', '2024-05-07 00:10:23'),
(83, 12, 'fas fa-anchor', 'https://www.example.com', '2024-05-07 00:10:23', '2024-05-07 00:10:23'),
(84, 13, 'fab fa-facebook-messenger', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-07 02:42:31', '2024-05-07 02:42:31'),
(85, 13, 'fab fa-twitter', 'https://www.example.com', '2024-05-07 02:42:31', '2024-05-07 02:42:31'),
(86, 13, 'fab fa-linkedin-in', 'https://www.example.com', '2024-05-07 02:42:31', '2024-05-07 02:42:31'),
(87, 13, 'fab fa-youtube', 'https://www.example.com', '2024-05-07 02:42:31', '2024-05-07 02:42:31'),
(88, 14, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-07 20:51:48', '2024-05-07 20:51:48'),
(89, 14, 'fab fa-youtube', 'https://www.example.com', '2024-05-07 20:51:48', '2024-05-07 20:51:48'),
(90, 14, 'fab fa-twitter-square', 'https://www.example.com', '2024-05-07 20:51:48', '2024-05-07 20:51:48'),
(91, 14, 'fab fa-instagram', 'https://www.example.com', '2024-05-07 20:51:48', '2024-05-07 20:51:48'),
(92, 15, 'fab fa-facebook-square iconpicker-component', 'https://www.facebook.com/azim.ahmed.9237245', '2024-05-08 02:46:52', '2024-05-08 02:46:52'),
(93, 15, 'fab fa-youtube', 'https://www.example.com', '2024-05-08 02:46:52', '2024-05-08 02:46:52'),
(94, 15, 'fab fa-twitter', 'https://www.example.com', '2024-05-08 02:46:52', '2024-05-08 02:46:52'),
(95, 15, 'fab fa-linkedin', 'https://www.example.com', '2024-05-08 02:46:52', '2024-05-08 02:46:52');

-- --------------------------------------------------------

--
-- Table structure for table `location_sections`
--

CREATE TABLE `location_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `location_sections`
--

INSERT INTO `location_sections` (`id`, `language_id`, `title`, `created_at`, `updated_at`) VALUES
(1, 20, 'Explore Most Popo', '2023-12-13 04:04:00', '2024-03-19 23:34:45'),
(2, 21, 'اقرأ أحدث مدوناتنا', '2023-12-13 04:04:18', '2023-12-13 04:04:18');

-- --------------------------------------------------------

--
-- Table structure for table `mail_templates`
--

CREATE TABLE `mail_templates` (
  `id` int NOT NULL,
  `mail_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_subject` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_body` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `mail_templates`
--

INSERT INTO `mail_templates` (`id`, `mail_type`, `mail_subject`, `mail_body`) VALUES
(1, 'verify_email', 'Verify Your Email Address', 0x3c703e44656172203c7374726f6e673e7b757365726e616d657d3c2f7374726f6e673e2c3c2f703e0d0a3c703e5765206a757374206e65656420746f2076657269667920796f757220656d61696c2061646472657373206265666f726520796f752063616e2061636365737320746f20796f75722064617368626f6172642e3c2f703e0d0a3c703e56657269667920796f757220656d61696c20616464726573732c207b766572696669636174696f6e5f6c696e6b7d2e3c2f703e0d0a3c703e5468616e6b20796f752e3c62723e7b776562736974655f7469746c657d3c2f703e),
(2, 'reset_password', 'Recover Password of Your Account', 0x3c703e4869207b637573746f6d65725f6e616d657d2c3c2f703e3c703e576520686176652072656365697665642061207265717565737420746f20726573657420796f75722070617373776f72642e20496620796f7520646964206e6f74206d616b652074686520726571756573742c2069676e6f7265207468697320656d61696c2e204f74686572776973652c20796f752063616e20726573657420796f75722070617373776f7264207573696e67207468652062656c6f77206c696e6b2e3c2f703e3c703e7b70617373776f72645f72657365745f6c696e6b7d3c2f703e3c703e5468616e6b732c3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(3, 'product_order', 'Product Order Has Been Placed', 0x3c703e4869c2a07b637573746f6d65725f6e616d657d2c3c2f703e3c703e596f7572206f7264657220686173206265656e20706c61636564207375636365737366756c6c792e205765206861766520617474616368656420616e20696e766f69636520696e2074686973206d61696c2e3c6272202f3e4f72646572204e6f3a20237b6f726465725f6e756d6265727d3c2f703e3c703e7b6f726465725f6c696e6b7d3c6272202f3e3c2f703e3c703e4265737420726567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(4, 'package_purchase', 'Your Package Purchase is successful.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7520686176652050757263686173656420796f7572206d656d626572736869702e3c6272202f3e3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(8, 'membership_expiry_reminder', 'Your membership will be expired soon', 0x4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a596f7572206d656d626572736869702077696c6c206265206578706972656420736f6f6e2e3c6272202f3e0d0a596f7572206d656d626572736869702069732076616c69642074696c6c203c7374726f6e673e7b6c6173745f6461795f6f665f6d656d626572736869707d3c2f7374726f6e673e3c6272202f3e0d0a506c6561736520636c69636b2068657265202d207b6c6f67696e5f6c696e6b7d20746f206c6f6720696e746f207468652064617368626f61726420746f2070757263686173652061206e6577207061636b616765202f20657874656e64207468652063757272656e74207061636b61676520746f20657874656e6420796f7572206d656d626572736869702e3c6272202f3e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e),
(9, 'membership_expired', 'Your membership is expired', 0x4869207b757365726e616d657d2c3c62723e3c62723e0d0a0d0a596f7572206d656d6265727368697020697320657870697265642e3c62723e0d0a506c6561736520636c69636b2068657265202d207b6c6f67696e5f6c696e6b7d20746f206c6f6720696e746f207468652064617368626f61726420746f2070757263686173652061206e6577207061636b616765202f20657874656e64207468652063757272656e74207061636b61676520746f20636f6e74696e756520746865206d656d626572736869702e3c62723e3c62723e0d0a0d0a4265737420526567617264732c3c62723e0d0a7b776562736974655f7469746c657d2e),
(10, 'payment_accepted_for_membership_offline_gateway', 'Your payment for registration is approved', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f7720796f752063616e206c6f67696e20746f20796f757220757365722064617368626f61726420746f206275696c6420796f757220706f7274666f6c696f20776562736974652e3c6272202f3e3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(12, 'payment_rejected_for_membership_offline_gateway', 'Your payment for membership extension is rejected', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a57652061726520736f72727920746f20696e666f726d20796f75207468617420796f7572207061796d656e7420686173206265656e2072656a65637465643c6272202f3e0d0a0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(14, 'admin_changed_current_package', 'Admin has changed your current package', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e20686173206368616e67656420796f75722063757272656e74207061636b616765203c623e287b7265706c616365645f7061636b6167657d293c2f623e3c2f703e0d0a3c703e3c623e4e6577205061636b61676520496e666f726d6174696f6e3a3c2f623e3c2f703e0d0a3c703e0d0a3c7374726f6e673e5061636b6167653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(15, 'admin_added_current_package', 'Admin has added current package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e206861732061646465642063757272656e74207061636b61676520666f7220796f753c2f703e3c703e3c623e3c7370616e207374796c653d22666f6e742d73697a653a313870783b223e43757272656e74204d656d6265727368697020496e666f726d6174696f6e3a3c2f7370616e3e3c2f623e3c6272202f3e0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(16, 'admin_changed_next_package', 'Admin has changed your next package', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e20686173206368616e67656420796f7572206e657874207061636b616765203c623e287b7265706c616365645f7061636b6167657d293c2f623e3c2f703e3c703e3c623e3c7370616e207374796c653d22666f6e742d73697a653a313870783b223e4e657874204d656d6265727368697020496e666f726d6174696f6e3a3c2f7370616e3e3c2f623e3c6272202f3e0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(17, 'admin_added_next_package', 'Admin has added next package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e20686173206164646564206e657874207061636b61676520666f7220796f753c2f703e3c703e3c623e3c7370616e207374796c653d22666f6e742d73697a653a313870783b223e4e657874204d656d6265727368697020496e666f726d6174696f6e3a3c2f7370616e3e3c2f623e3c6272202f3e0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(18, 'admin_removed_current_package', 'Admin has removed current package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e206861732072656d6f7665642063757272656e74207061636b616765202d203c7374726f6e673e7b72656d6f7665645f7061636b6167655f7469746c657d3c2f7374726f6e673e3c62723e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e),
(19, 'admin_removed_next_package', 'Admin has removed next package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e206861732072656d6f766564206e657874207061636b616765202d203c7374726f6e673e7b72656d6f7665645f7061636b6167655f7469746c657d3c2f7374726f6e673e3c62723e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e),
(26, 'inquiry_about_listing', 'Inquiry About Listing', 0x3c64697620636c6173733d22223e0d0a3c64697620636c6173733d226969206774223e0d0a3c64697620636c6173733d226133732061694c223e0d0a3c703ec2a03c2f703e0d0a3c646976207374796c653d226d617267696e3a20303b20626f782d73697a696e673a20626f726465722d626f783b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b206d696e2d77696474683a20313030253b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b2077696474683a203130302521696d706f7274616e743b223e0d0a3c7461626c65207374796c653d226d617267696e3a20303b206261636b67726f756e643a20236633663566383b20626f726465722d636f6c6c617073653a20636f6c6c617073653b20626f726465722d73706163696e673a20303b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206865696768743a20313030253b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b2077696474683a20313030253b223e0d0a3c74626f64793e0d0a3c7472207374796c653d2270616464696e673a303b746578742d616c69676e3a6c6566743b223e0d0a3c7464207374796c653d226d617267696e3a20303b20626f726465722d636f6c6c617073653a20636f6c6c6170736521696d706f7274616e743b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b20776f72642d777261703a20627265616b2d776f72643b223e0d0a3c646976207374796c653d2270616464696e672d6c6566743a203136707821696d706f7274616e743b2070616464696e672d72696768743a203136707821696d706f7274616e743b223e3c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a0c2a03c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a00d0a3c7461626c65207374796c653d226d617267696e3a2030206175746f3b206261636b67726f756e643a20236635663566663b20626f726465723a2031707820736f6c696420236434646365323b20626f726465722d636f6c6c617073653a20636f6c6c617073653b20626f726465722d73706163696e673a20303b206d696e2d77696474683a2035303070783b2070616464696e673a20303b20746578742d616c69676e3a20696e68657269743b20766572746963616c2d616c69676e3a20746f703b2077696474683a2035383070783b223e0d0a3c74626f64793e0d0a3c7472207374796c653d2270616464696e673a303b746578742d616c69676e3a6c6566743b223e0d0a3c7464207374796c653d226d617267696e3a20303b20626f726465722d636f6c6c617073653a20636f6c6c6170736521696d706f7274616e743b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b20776f72642d777261703a20627265616b2d776f72643b223e3c6272202f3e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e44656172207b757365726e616d657d2c3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e5468697320656d61696c20696e666f726d7320796f75207468617420616e20656e71756972657220697320747279696e6720746f20636f6e7461637420796f752e20486572652069732074686520696e666f726d6174696f6e2061626f75742074686520656e7175697265722e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e3c7374726f6e673e4c697374696e673c2f7374726f6e673e3a207b6c697374696e675f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e717569726572204e616d653a207b656e7175697265725f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e71756972657220456d61696c3a207b656e7175697265725f656d61696c7d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e7175697265722050686f6e653a207b656e7175697265725f70686f6e657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e4d6573736167653a3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e7b656e7175697265725f6d6573736167657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e4265737420526567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e0d0ac2a03c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a020c2a03c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a03c2f74643e0d0a3c2f74723e0d0a3c2f74626f64793e0d0a3c2f7461626c653e0d0ac2a03c2f6469763e0d0ac2a020c2a020c2a020c2a03c2f74643e0d0a3c2f74723e0d0a3c2f74626f64793e0d0a3c2f7461626c653e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c703ec2a03c2f703e),
(27, 'payment_accepted_for_featured_offline_gateway', 'Your payment for Feature is approved', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f77207761697420666f722073746174757320617070726f76652e3c2f703e0d0a3c703e3c7374726f6e673e4c697374696e67203a3c2f7374726f6e673e207b6c697374696e675f6e616d657d3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c2f703e0d0a3c703e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e),
(28, 'payment_rejected_for_buy_feature_offline_gateway', 'Your payment for Active Listing Feature  is rejected', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e57652061726520736f72727920746f20696e666f726d20796f75207468617420796f7572207061796d656e7420686173206265656e2072656a65637465642e3c2f703e0d0a3c703e3c7374726f6e673e4c697374696e67203a3c2f7374726f6e673e207b6c697374696e675f6e616d657d3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(29, 'listing_feature_active', 'Your request to feature listing is approved.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e5765206861766520617070726f76656420796f757220726571756573742e3c2f703e0d0a3c703e596f7572206c697374696e6720697320666561747572656420666f72207b646179737d20646179732e20c2a03c2f703e0d0a3c703e3c7374726f6e673e4c697374696e67205469746c653c2f7374726f6e673e3a207b6c697374696e675f6e616d657d2e3c2f703e0d0a3c703e3c7374726f6e673e53746172742044617465203a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e456e6420446174653a3c2f7374726f6e673e207b656e645f646174657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(30, 'listing_feature_reject', 'Your Request to Feature Listing is Rejected.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e3c2f703e0d0a3c703e57652061726520736f727279202e3c2f703e0d0a3c703e596f7572207265717565737420686173206265656e2072656a65637465643c2f703e0d0a3c703e506c6561736520637265617465206120737570706f7274207469636b65742e3c2f703e0d0a3c703e3c7374726f6e673e4c697374696e67205469746c653c2f7374726f6e673e3a207b6c697374696e675f6e616d657d2e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(31, 'payment_accepted_for_featured_online_gateway', 'Your payment to Feature your business is successful.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f77207761697420666f722073746174757320617070726f76652e3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c2f703e0d0a3c703e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e),
(32, 'inquiry_about_product', 'Inquiry About Product', 0x3c703ec2a03c2f703e0d0a3c646976207374796c653d226d617267696e3a20303b20626f782d73697a696e673a20626f726465722d626f783b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b206d696e2d77696474683a20313030253b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b2077696474683a203130302521696d706f7274616e743b223e0d0a3c7461626c65207374796c653d226d617267696e3a20303b206261636b67726f756e643a20236633663566383b20626f726465722d636f6c6c617073653a20636f6c6c617073653b20626f726465722d73706163696e673a20303b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206865696768743a20313030253b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b2077696474683a20313030253b223e0d0a3c74626f64793e0d0a3c7472207374796c653d2270616464696e673a303b746578742d616c69676e3a6c6566743b223e0d0a3c7464207374796c653d226d617267696e3a20303b20626f726465722d636f6c6c617073653a20636f6c6c6170736521696d706f7274616e743b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b20776f72642d777261703a20627265616b2d776f72643b223e0d0a3c646976207374796c653d2270616464696e672d6c6566743a203136707821696d706f7274616e743b2070616464696e672d72696768743a203136707821696d706f7274616e743b223e3c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a0c2a03c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a00d0a3c7461626c65207374796c653d226d617267696e3a2030206175746f3b206261636b67726f756e643a20236635663566663b20626f726465723a2031707820736f6c696420236434646365323b20626f726465722d636f6c6c617073653a20636f6c6c617073653b20626f726465722d73706163696e673a20303b206d696e2d77696474683a2035303070783b2070616464696e673a20303b20746578742d616c69676e3a20696e68657269743b20766572746963616c2d616c69676e3a20746f703b2077696474683a2035383070783b223e0d0a3c74626f64793e0d0a3c7472207374796c653d2270616464696e673a303b746578742d616c69676e3a6c6566743b223e0d0a3c7464207374796c653d226d617267696e3a20303b20626f726465722d636f6c6c617073653a20636f6c6c6170736521696d706f7274616e743b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b20776f72642d777261703a20627265616b2d776f72643b223e3c6272202f3e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e44656172207b757365726e616d657d2c3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e5468697320656d61696c20696e666f726d7320796f75207468617420616e20656e71756972657220697320747279696e6720746f20636f6e7461637420796f752e20486572652069732074686520696e666f726d6174696f6e2061626f75742074686520656e7175697265722e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e3c7374726f6e673e4c697374696e673c2f7374726f6e673e3a207b6c697374696e675f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e3c7374726f6e673e50726f647563743c2f7374726f6e673e3a207b70726f647563745f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e717569726572204e616d653a207b656e7175697265725f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e71756972657220456d61696c3a207b656e7175697265725f656d61696c7d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e4d6573736167653a3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e7b656e7175697265725f6d6573736167657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e4265737420526567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e0d0a3c2f74643e0d0a3c2f74723e0d0a3c2f74626f64793e0d0a3c2f7461626c653e0d0a3c2f6469763e0d0a3c2f74643e0d0a3c2f74723e0d0a3c2f74626f64793e0d0a3c2f7461626c653e0d0a3c2f6469763e),
(33, 'withdraw_approve', 'Confirmation of Withdraw Approve', 0x3c703e4869207b76656e646f725f757365726e616d657d2c3c2f703e0a3c703e5468697320656d61696c20697320636f6e6669726d207468617420796f75722077697468647261772072657175657374207b77697468647261775f69647d20697320617070726f7665642e203c2f703e0a3c703e596f75722063757272656e742062616c616e6365206973207b63757272656e745f62616c616e63657d2c20776974686472617720616d6f756e74207b77697468647261775f616d6f756e747d2c20636861726765203a207b6368617267657d2c70617961626c6520616d6f756e74207b70617961626c655f616d6f756e747d3c2f703e0a3c703e7769746864726177206d6574686f64203a207b77697468647261775f6d6574686f647d2c3c2f703e0a3c703e203c2f703e0a3c703e4265737420526567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(34, 'withdraw_rejected', 'Withdraw Request Rejected', 0x3c703e4869207b76656e646f725f757365726e616d657d2c3c2f703e0a3c703e5468697320656d61696c20697320746f20636f6e6669726d207468617420796f7572207769746864726177616c2072657175657374207b77697468647261775f69647d2069732072656a656374656420616e64207468652062616c616e636520616464656420746f20796f7572206163636f756e742e203c2f703e0a3c703e596f75722063757272656e742062616c616e6365206973207b63757272656e745f62616c616e63657d3c2f703e0a3c703e203c2f703e0a3c703e4265737420526567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(39, 'verify_email_app', 'Verify Your Email Address', 0x3c703e44656172203c7374726f6e673e7b757365726e616d657d3c2f7374726f6e673e2c3c2f703e0d0a3c703e5765206a757374206e65656420746f2076657269667920796f757220656d61696c2061646472657373206265666f726520796f752063616e2061636365737320746f20796f75722064617368626f6172642e3c2f703e0d0a3c703e566572696669636174696f6e20436f64653a7b766572696669636174696f6e5f636f64657d2e3c2f703e0d0a3c703e5468616e6b20796f752e3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(40, 'reset_password_app', 'Recover Password of Your Account', 0x3c703e4869207b757365726e616d657d2c3c2f703e0d0a3c703e576520686176652072656365697665642061207265717565737420746f20726573657420796f75722070617373776f72642e20496620796f7520646964206e6f74206d616b652074686520726571756573742c2069676e6f7265207468697320656d61696c2e204f74686572776973652c20796f752063616e20726573657420796f75722070617373776f7264207573696e67207468652062656c6f77206c696e6b2e3c2f703e0d0a3c703e566572696669636174696f6e20436f64653a207b766572696669636174696f6e5f636f64657d2e3c2f703e0d0a3c703e5468616e6b732c3c6272202f3e7b776562736974655f7469746c657d3c2f703e);

-- --------------------------------------------------------

--
-- Table structure for table `memberships`
--

CREATE TABLE `memberships` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `price` double DEFAULT NULL,
  `currency` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `is_trial` tinyint NOT NULL DEFAULT '0',
  `trial_days` int NOT NULL DEFAULT '0',
  `receipt` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `transaction_details` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `settings` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `package_id` bigint DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `modified` tinyint DEFAULT NULL COMMENT '1 - modified by Admin, 0 - not modified by Admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conversation_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `claim_id` smallint UNSIGNED DEFAULT NULL,
  `ai_engine` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ai_token_limit` bigint UNSIGNED NOT NULL DEFAULT '0',
  `ai_image_limit` int UNSIGNED NOT NULL DEFAULT '0',
  `ai_used_tokens` bigint UNSIGNED NOT NULL DEFAULT '0',
  `ai_used_images` int UNSIGNED NOT NULL DEFAULT '0',
  `ai_token_purchased` bigint UNSIGNED NOT NULL DEFAULT '0',
  `ai_image_purchased` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `memberships`
--

INSERT INTO `memberships` (`id`, `vendor_id`, `price`, `currency`, `currency_symbol`, `payment_method`, `transaction_id`, `status`, `is_trial`, `trial_days`, `receipt`, `transaction_details`, `settings`, `package_id`, `start_date`, `expire_date`, `modified`, `created_at`, `updated_at`, `conversation_id`, `invoice`, `claim_id`, `ai_engine`, `ai_token_limit`, `ai_image_limit`, `ai_used_tokens`, `ai_used_images`, `ai_token_purchased`, `ai_image_purchased`) VALUES
(1, 204, 999, 'TRY', '$', 'Stripe', '18803cf5', 1, 0, 0, NULL, '{\"id\":\"ch_3QipRsJlIV5dN9n71yEMY10K\",\"object\":\"charge\",\"amount\":99900,\"amount_captured\":99900,\"amount_refunded\":0,\"application\":null,\"application_fee\":null,\"application_fee_amount\":null,\"balance_transaction\":\"txn_3QipRsJlIV5dN9n71U7q2aZA\",\"billing_details\":{\"address\":{\"city\":null,\"country\":null,\"line1\":null,\"line2\":null,\"postal_code\":\"12345\",\"state\":null},\"email\":null,\"name\":null,\"phone\":null},\"calculated_statement_descriptor\":\"Stripe\",\"captured\":true,\"created\":1737258320,\"currency\":\"usd\",\"customer\":null,\"description\":\"You are extending your membership\",\"destination\":null,\"dispute\":null,\"disputed\":false,\"failure_balance_transaction\":null,\"failure_code\":null,\"failure_message\":null,\"fraud_details\":[],\"invoice\":null,\"livemode\":false,\"metadata\":{\"customer_name\":\"Jackson Lee\"},\"on_behalf_of\":null,\"order\":null,\"outcome\":{\"advice_code\":null,\"network_advice_code\":null,\"network_decline_code\":null,\"network_status\":\"approved_by_network\",\"reason\":null,\"risk_level\":\"normal\",\"risk_score\":57,\"seller_message\":\"Payment complete.\",\"type\":\"authorized\"},\"paid\":true,\"payment_intent\":null,\"payment_method\":\"card_1QipRrJlIV5dN9n7HFRhBWrM\",\"payment_method_details\":{\"card\":{\"amount_authorized\":99900,\"authorization_code\":null,\"brand\":\"visa\",\"checks\":{\"address_line1_check\":null,\"address_postal_code_check\":\"pass\",\"cvc_check\":\"pass\"},\"country\":\"US\",\"exp_month\":12,\"exp_year\":2026,\"extended_authorization\":{\"status\":\"disabled\"},\"fingerprint\":\"WXDgVUSzrY61Nnm6\",\"funding\":\"credit\",\"incremental_authorization\":{\"status\":\"unavailable\"},\"installments\":null,\"last4\":\"4242\",\"mandate\":null,\"multicapture\":{\"status\":\"unavailable\"},\"network\":\"visa\",\"network_token\":{\"used\":false},\"network_transaction_id\":\"878868103868583\",\"overcapture\":{\"maximum_amount_capturable\":99900,\"status\":\"unavailable\"},\"regulated_status\":\"unregulated\",\"three_d_secure\":null,\"wallet\":null},\"type\":\"card\"},\"receipt_email\":\"superBusiness47@example.com\",\"receipt_number\":null,\"receipt_url\":\"https:\\/\\/pay.stripe.com\\/receipts\\/payment\\/CAcaFwoVYWNjdF8xQXplbzNKbElWNWROOW43KNHqsbwGMgYeKuNnKnM6LBYHdnjekioLzgcMxS0glISCRW3acVQMQJBLbVTRUXZ4RKy1Y1YKdCELqsZ_\",\"refunded\":false,\"refunds\":{\"object\":\"list\",\"data\":[],\"has_more\":false,\"total_count\":0,\"url\":\"\\/v1\\/charges\\/ch_3QipRsJlIV5dN9n71yEMY10K\\/refunds\"},\"review\":null,\"shipping\":null,\"source\":{\"id\":\"card_1QipRrJlIV5dN9n7HFRhBWrM\",\"object\":\"card\",\"address_city\":null,\"address_country\":null,\"address_line1\":null,\"address_line1_check\":null,\"address_line2\":null,\"address_state\":null,\"address_zip\":\"12345\",\"address_zip_check\":\"pass\",\"allow_redisplay\":\"unspecified\",\"brand\":\"Visa\",\"country\":\"US\",\"customer\":null,\"cvc_check\":\"pass\",\"dynamic_last4\":null,\"exp_month\":12,\"exp_year\":2026,\"fingerprint\":\"WXDgVUSzrY61Nnm6\",\"funding\":\"credit\",\"last4\":\"4242\",\"metadata\":[],\"name\":null,\"regulated_status\":\"unregulated\",\"tokenization_method\":null,\"wallet\":null},\"source_transfer\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"TRY\",\"base_currency_text_position\":\"left\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}', 93, '2025-01-19', '2026-03-08', 1, '2025-01-18 21:45:21', '2026-03-09 01:51:55', NULL, 'extend678c755184855.pdf', NULL, NULL, 0, 0, 0, 0, 0, 0),
(2, 207, 999, 'TRY', '$', 'PayPal', '3f3f366c', 1, 0, 0, NULL, '{\n    \"id\": \"PAYID-M6GHLPQ5FC20223YN353592V\",\n    \"intent\": \"sale\",\n    \"state\": \"approved\",\n    \"cart\": \"9S965919VD0346436\",\n    \"payer\": {\n        \"payment_method\": \"paypal\",\n        \"status\": \"VERIFIED\",\n        \"payer_info\": {\n            \"email\": \"megasoft.envato@gmail.com\",\n            \"first_name\": \"Samiul Alim\",\n            \"last_name\": \"Pratik\",\n            \"payer_id\": \"8C5NYJ7EZ7QSS\",\n            \"shipping_address\": {\n                \"recipient_name\": \"Samiul Alim Pratik\",\n                \"id\": \"7157040345310252769\",\n                \"line1\": \"1 Main St\",\n                \"city\": \"San Jose\",\n                \"state\": \"CA\",\n                \"postal_code\": \"95131\",\n                \"country_code\": \"US\",\n                \"type\": \"HOME_OR_WORK\",\n                \"default_address\": false,\n                \"preferred_address\": true,\n                \"primary_address\": true,\n                \"disable_for_transaction\": false\n            },\n            \"country_code\": \"US\"\n        }\n    },\n    \"transactions\": [\n        {\n            \"amount\": {\n                \"total\": \"999.00\",\n                \"currency\": \"USD\",\n                \"details\": {\n                    \"subtotal\": \"999.00\",\n                    \"shipping\": \"0.00\",\n                    \"insurance\": \"0.00\",\n                    \"handling_fee\": \"0.00\",\n                    \"shipping_discount\": \"0.00\",\n                    \"discount\": \"0.00\"\n                }\n            },\n            \"payee\": {\n                \"merchant_id\": \"BKNWZYE3MAUNU\",\n                \"email\": \"megasoft.envato-facilitator@gmail.com\"\n            },\n            \"description\": \"You are extending your membership Via Paypal\",\n            \"item_list\": {\n                \"items\": [\n                    {\n                        \"name\": \"You are extending your membership\",\n                        \"price\": \"999.00\",\n                        \"currency\": \"USD\",\n                        \"tax\": \"0.00\",\n                        \"quantity\": 1\n                    }\n                ],\n                \"shipping_address\": {\n                    \"recipient_name\": \"Samiul Alim Pratik\",\n                    \"id\": \"7157040345310252769\",\n                    \"line1\": \"1 Main St\",\n                    \"city\": \"San Jose\",\n                    \"state\": \"CA\",\n                    \"postal_code\": \"95131\",\n                    \"country_code\": \"US\",\n                    \"type\": \"HOME_OR_WORK\",\n                    \"default_address\": false,\n                    \"preferred_address\": true,\n                    \"primary_address\": true,\n                    \"disable_for_transaction\": false\n                }\n            },\n            \"related_resources\": [\n                {\n                    \"sale\": {\n                        \"id\": \"8KL55362P3264215Y\",\n                        \"state\": \"completed\",\n                        \"amount\": {\n                            \"total\": \"999.00\",\n                            \"currency\": \"USD\",\n                            \"details\": {\n                                \"subtotal\": \"999.00\",\n                                \"shipping\": \"0.00\",\n                                \"insurance\": \"0.00\",\n                                \"handling_fee\": \"0.00\",\n                                \"shipping_discount\": \"0.00\",\n                                \"discount\": \"0.00\"\n                            }\n                        },\n                        \"payment_mode\": \"INSTANT_TRANSFER\",\n                        \"protection_eligibility\": \"ELIGIBLE\",\n                        \"protection_eligibility_type\": \"ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE\",\n                        \"transaction_fee\": {\n                            \"value\": \"35.36\",\n                            \"currency\": \"USD\"\n                        },\n                        \"parent_payment\": \"PAYID-M6GHLPQ5FC20223YN353592V\",\n                        \"create_time\": \"2025-01-19T03:47:43Z\",\n                        \"update_time\": \"2025-01-19T03:47:43Z\",\n                        \"links\": [\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/8KL55362P3264215Y\",\n                                \"rel\": \"self\",\n                                \"method\": \"GET\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/8KL55362P3264215Y/refund\",\n                                \"rel\": \"refund\",\n                                \"method\": \"POST\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHLPQ5FC20223YN353592V\",\n                                \"rel\": \"parent_payment\",\n                                \"method\": \"GET\"\n                            }\n                        ]\n                    }\n                }\n            ]\n        }\n    ],\n    \"create_time\": \"2025-01-19T03:47:09Z\",\n    \"update_time\": \"2025-01-19T03:47:43Z\",\n    \"links\": [\n        {\n            \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHLPQ5FC20223YN353592V\",\n            \"rel\": \"self\",\n            \"method\": \"GET\"\n        }\n    ],\n    \"failed_transactions\": []\n}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"TRY\",\"base_currency_text_position\":\"left\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}', 93, '2025-01-19', '2026-03-08', 1, '2025-01-18 21:48:46', '2026-03-09 01:49:10', NULL, 'extend678c761ed7f79.pdf', NULL, NULL, 0, 0, 0, 0, 0, 0),
(3, 206, 999, 'USD', '$', 'Authorize.net', '382dacae', 1, 0, 0, NULL, '{}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}', 93, '2025-01-19', '2026-03-08', 1, '2025-01-18 21:50:54', '2026-03-09 01:51:21', NULL, 'extend678c769ebbfb4.pdf', NULL, NULL, 0, 0, 0, 0, 0, 0),
(4, 205, 999, 'USD', '$', 'Bank of America', '1473d634', 1, 0, 0, '1737258725.jpg', '\"offline\"', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}', 93, '2025-01-19', '2026-03-08', 1, '2025-01-18 21:52:05', '2026-03-09 01:53:22', NULL, 'membership678c76f03c454.pdf', NULL, NULL, 0, 0, 0, 0, 0, 0),
(5, 201, 999, 'USD', '$', 'PayPal', '191ae1e3', 1, 0, 0, NULL, '{\n    \"id\": \"PAYID-M6GHOKI9X122956293229900\",\n    \"intent\": \"sale\",\n    \"state\": \"approved\",\n    \"cart\": \"6D735369TT745435S\",\n    \"payer\": {\n        \"payment_method\": \"paypal\",\n        \"status\": \"VERIFIED\",\n        \"payer_info\": {\n            \"email\": \"megasoft.envato@gmail.com\",\n            \"first_name\": \"Samiul Alim\",\n            \"last_name\": \"Pratik\",\n            \"payer_id\": \"8C5NYJ7EZ7QSS\",\n            \"shipping_address\": {\n                \"recipient_name\": \"Samiul Alim Pratik\",\n                \"id\": \"7157040345310252769\",\n                \"line1\": \"1 Main St\",\n                \"city\": \"San Jose\",\n                \"state\": \"CA\",\n                \"postal_code\": \"95131\",\n                \"country_code\": \"US\",\n                \"type\": \"HOME_OR_WORK\",\n                \"default_address\": false,\n                \"preferred_address\": true,\n                \"primary_address\": true,\n                \"disable_for_transaction\": false\n            },\n            \"country_code\": \"US\"\n        }\n    },\n    \"transactions\": [\n        {\n            \"amount\": {\n                \"total\": \"999.00\",\n                \"currency\": \"USD\",\n                \"details\": {\n                    \"subtotal\": \"999.00\",\n                    \"shipping\": \"0.00\",\n                    \"insurance\": \"0.00\",\n                    \"handling_fee\": \"0.00\",\n                    \"shipping_discount\": \"0.00\",\n                    \"discount\": \"0.00\"\n                }\n            },\n            \"payee\": {\n                \"merchant_id\": \"BKNWZYE3MAUNU\",\n                \"email\": \"megasoft.envato-facilitator@gmail.com\"\n            },\n            \"description\": \"You are extending your membership Via Paypal\",\n            \"item_list\": {\n                \"items\": [\n                    {\n                        \"name\": \"You are extending your membership\",\n                        \"price\": \"999.00\",\n                        \"currency\": \"USD\",\n                        \"tax\": \"0.00\",\n                        \"quantity\": 1\n                    }\n                ],\n                \"shipping_address\": {\n                    \"recipient_name\": \"Samiul Alim Pratik\",\n                    \"id\": \"7157040345310252769\",\n                    \"line1\": \"1 Main St\",\n                    \"city\": \"San Jose\",\n                    \"state\": \"CA\",\n                    \"postal_code\": \"95131\",\n                    \"country_code\": \"US\",\n                    \"type\": \"HOME_OR_WORK\",\n                    \"default_address\": false,\n                    \"preferred_address\": true,\n                    \"primary_address\": true,\n                    \"disable_for_transaction\": false\n                }\n            },\n            \"related_resources\": [\n                {\n                    \"sale\": {\n                        \"id\": \"5HT849373G2733944\",\n                        \"state\": \"completed\",\n                        \"amount\": {\n                            \"total\": \"999.00\",\n                            \"currency\": \"USD\",\n                            \"details\": {\n                                \"subtotal\": \"999.00\",\n                                \"shipping\": \"0.00\",\n                                \"insurance\": \"0.00\",\n                                \"handling_fee\": \"0.00\",\n                                \"shipping_discount\": \"0.00\",\n                                \"discount\": \"0.00\"\n                            }\n                        },\n                        \"payment_mode\": \"INSTANT_TRANSFER\",\n                        \"protection_eligibility\": \"ELIGIBLE\",\n                        \"protection_eligibility_type\": \"ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE\",\n                        \"transaction_fee\": {\n                            \"value\": \"35.36\",\n                            \"currency\": \"USD\"\n                        },\n                        \"parent_payment\": \"PAYID-M6GHOKI9X122956293229900\",\n                        \"create_time\": \"2025-01-19T03:53:23Z\",\n                        \"update_time\": \"2025-01-19T03:53:23Z\",\n                        \"links\": [\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/5HT849373G2733944\",\n                                \"rel\": \"self\",\n                                \"method\": \"GET\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/5HT849373G2733944/refund\",\n                                \"rel\": \"refund\",\n                                \"method\": \"POST\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHOKI9X122956293229900\",\n                                \"rel\": \"parent_payment\",\n                                \"method\": \"GET\"\n                            }\n                        ]\n                    }\n                }\n            ]\n        }\n    ],\n    \"redirect_urls\": {\n        \"return_url\": \"https://bulistio.test/vendor/membership/paypal/success?paymentId=PAYID-M6GHOKI9X122956293229900\",\n        \"cancel_url\": \"https://bulistio.test/vendor/membership/paypal/cancel\"\n    },\n    \"create_time\": \"2025-01-19T03:53:12Z\",\n    \"update_time\": \"2025-01-19T03:53:23Z\",\n    \"links\": [\n        {\n            \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHOKI9X122956293229900\",\n            \"rel\": \"self\",\n            \"method\": \"GET\"\n        }\n    ],\n    \"failed_transactions\": []\n}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}', 93, '2025-01-19', '9999-12-31', NULL, '2025-01-18 21:53:23', '2025-01-18 21:53:23', NULL, 'extend678c7733bdee5.pdf', NULL, NULL, 0, 0, 0, 0, 0, 0),
(6, 203, 999, 'USD', '$', 'Citibank', 'e8fa55c6', 1, 0, 0, NULL, '\"offline\"', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}', 93, '2025-01-19', '2026-04-01', 1, '2025-01-18 21:53:56', '2026-04-02 00:58:59', NULL, 'membership678c77595f0e0.pdf', NULL, NULL, 0, 0, 0, 0, 0, 0),
(7, 202, 999, 'USD', '$', 'PayPal', 'e17ae7cc', 1, 0, 0, NULL, '{\n    \"id\": \"PAYID-M6GHO7A5JB73275VY033110H\",\n    \"intent\": \"sale\",\n    \"state\": \"approved\",\n    \"cart\": \"44U651594K3749149\",\n    \"payer\": {\n        \"payment_method\": \"paypal\",\n        \"status\": \"VERIFIED\",\n        \"payer_info\": {\n            \"email\": \"megasoft.envato@gmail.com\",\n            \"first_name\": \"Samiul Alim\",\n            \"last_name\": \"Pratik\",\n            \"payer_id\": \"8C5NYJ7EZ7QSS\",\n            \"shipping_address\": {\n                \"recipient_name\": \"Samiul Alim Pratik\",\n                \"id\": \"7157040345310252769\",\n                \"line1\": \"1 Main St\",\n                \"city\": \"San Jose\",\n                \"state\": \"CA\",\n                \"postal_code\": \"95131\",\n                \"country_code\": \"US\",\n                \"type\": \"HOME_OR_WORK\",\n                \"default_address\": false,\n                \"preferred_address\": true,\n                \"primary_address\": true,\n                \"disable_for_transaction\": false\n            },\n            \"country_code\": \"US\"\n        }\n    },\n    \"transactions\": [\n        {\n            \"amount\": {\n                \"total\": \"999.00\",\n                \"currency\": \"USD\",\n                \"details\": {\n                    \"subtotal\": \"999.00\",\n                    \"shipping\": \"0.00\",\n                    \"insurance\": \"0.00\",\n                    \"handling_fee\": \"0.00\",\n                    \"shipping_discount\": \"0.00\",\n                    \"discount\": \"0.00\"\n                }\n            },\n            \"payee\": {\n                \"merchant_id\": \"BKNWZYE3MAUNU\",\n                \"email\": \"megasoft.envato-facilitator@gmail.com\"\n            },\n            \"description\": \"You are extending your membership Via Paypal\",\n            \"item_list\": {\n                \"items\": [\n                    {\n                        \"name\": \"You are extending your membership\",\n                        \"price\": \"999.00\",\n                        \"currency\": \"USD\",\n                        \"tax\": \"0.00\",\n                        \"quantity\": 1\n                    }\n                ],\n                \"shipping_address\": {\n                    \"recipient_name\": \"Samiul Alim Pratik\",\n                    \"id\": \"7157040345310252769\",\n                    \"line1\": \"1 Main St\",\n                    \"city\": \"San Jose\",\n                    \"state\": \"CA\",\n                    \"postal_code\": \"95131\",\n                    \"country_code\": \"US\",\n                    \"type\": \"HOME_OR_WORK\",\n                    \"default_address\": false,\n                    \"preferred_address\": true,\n                    \"primary_address\": true,\n                    \"disable_for_transaction\": false\n                }\n            },\n            \"related_resources\": [\n                {\n                    \"sale\": {\n                        \"id\": \"27B842984G4918334\",\n                        \"state\": \"completed\",\n                        \"amount\": {\n                            \"total\": \"999.00\",\n                            \"currency\": \"USD\",\n                            \"details\": {\n                                \"subtotal\": \"999.00\",\n                                \"shipping\": \"0.00\",\n                                \"insurance\": \"0.00\",\n                                \"handling_fee\": \"0.00\",\n                                \"shipping_discount\": \"0.00\",\n                                \"discount\": \"0.00\"\n                            }\n                        },\n                        \"payment_mode\": \"INSTANT_TRANSFER\",\n                        \"protection_eligibility\": \"ELIGIBLE\",\n                        \"protection_eligibility_type\": \"ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE\",\n                        \"transaction_fee\": {\n                            \"value\": \"35.36\",\n                            \"currency\": \"USD\"\n                        },\n                        \"parent_payment\": \"PAYID-M6GHO7A5JB73275VY033110H\",\n                        \"create_time\": \"2025-01-19T03:54:46Z\",\n                        \"update_time\": \"2025-01-19T03:54:46Z\",\n                        \"links\": [\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/27B842984G4918334\",\n                                \"rel\": \"self\",\n                                \"method\": \"GET\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/27B842984G4918334/refund\",\n                                \"rel\": \"refund\",\n                                \"method\": \"POST\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHO7A5JB73275VY033110H\",\n                                \"rel\": \"parent_payment\",\n                                \"method\": \"GET\"\n                            }\n                        ]\n                    }\n                }\n            ]\n        }\n    ],\n    \"redirect_urls\": {\n        \"return_url\": \"https://bulistio.test/vendor/membership/paypal/success?paymentId=PAYID-M6GHO7A5JB73275VY033110H\",\n        \"cancel_url\": \"https://bulistio.test/vendor/membership/paypal/cancel\"\n    },\n    \"create_time\": \"2025-01-19T03:54:35Z\",\n    \"update_time\": \"2025-01-19T03:54:46Z\",\n    \"links\": [\n        {\n            \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHO7A5JB73275VY033110H\",\n            \"rel\": \"self\",\n            \"method\": \"GET\"\n        }\n    ],\n    \"failed_transactions\": []\n}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}', 93, '2025-01-19', '9999-12-31', NULL, '2025-01-18 21:54:46', '2025-01-18 21:54:46', NULL, 'extend678c778694962.pdf', NULL, NULL, 0, 0, 0, 0, 0, 0),
(34, 207, 999, 'USD', '$', 'PayPal', '69ae7b9b338a3', 1, 0, 0, NULL, NULL, NULL, 93, '2026-03-09', '9999-12-31', NULL, '2026-03-09 01:49:47', '2026-03-09 01:49:47', NULL, NULL, NULL, 'gemini', 60000, 60, 20723, 10, 0, 0);
INSERT INTO `memberships` (`id`, `vendor_id`, `price`, `currency`, `currency_symbol`, `payment_method`, `transaction_id`, `status`, `is_trial`, `trial_days`, `receipt`, `transaction_details`, `settings`, `package_id`, `start_date`, `expire_date`, `modified`, `created_at`, `updated_at`, `conversation_id`, `invoice`, `claim_id`, `ai_engine`, `ai_token_limit`, `ai_image_limit`, `ai_used_tokens`, `ai_used_images`, `ai_token_purchased`, `ai_image_purchased`) VALUES
(35, 206, 999, 'USD', '$', 'Xendit', '69ae7c05b6ffe', 1, 0, 0, NULL, NULL, NULL, 93, '2026-03-09', '9999-12-31', NULL, '2026-03-09 01:51:33', '2026-03-09 01:51:33', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 15, 0, 0),
(36, 204, 999, 'USD', '$', 'Xendit', '69ae7c28aefe7', 1, 0, 0, NULL, NULL, NULL, 93, '2026-03-09', '2026-04-05', 1, '2026-03-09 01:52:08', '2026-04-06 02:45:16', NULL, NULL, NULL, 'gemini', 60000, 60, 10544, 5, 0, 0),
(37, 205, 699, 'USD', '$', 'Perfect Money', '69ae7c7e009f0', 1, 0, 0, NULL, NULL, NULL, 92, '2026-03-09', '9999-12-31', NULL, '2026-03-09 01:53:34', '2026-03-09 01:53:34', NULL, NULL, NULL, 'openai', 40000, 40, 7055, 25, 0, 0),
(39, 203, 999, 'USD', '$', 'Xendit', '69ce14b6e7e88', 1, 0, 0, NULL, NULL, NULL, 93, '2026-04-02', '9999-12-31', NULL, '2026-04-02 01:03:18', '2026-04-02 01:07:01', NULL, NULL, NULL, 'gemini', 60000, 60, 453, 22, 0, 0),
(40, 204, 29.99, 'USD', '$', 'Xendit', '69d372ac25943', 1, 0, 0, NULL, NULL, NULL, 87, '2026-04-06', '2026-04-05', 1, '2026-04-06 02:45:32', '2026-04-06 03:02:21', NULL, NULL, NULL, 'gemini', 35000, 30, 0, 0, 0, 0),
(41, 204, 999, 'USD', '$', 'Xendit', '69d376ac13f24', 1, 0, 0, NULL, NULL, NULL, 93, '2026-04-06', '2026-04-06', 1, '2026-04-06 03:02:36', '2026-04-07 00:06:50', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 0, 0, 0),
(42, 204, 999, 'USD', '$', 'Perfect Money', '69d4a3c607366', 1, 0, 0, NULL, NULL, NULL, 93, '2026-04-07', '2026-04-11', 1, '2026-04-07 00:27:18', '2026-04-12 04:16:13', NULL, NULL, NULL, 'gemini', 60000, 60, 2249, 0, 0, 0),
(43, 204, 699, 'USD', '$', 'Citibank', '5e80625e', 0, 0, 0, NULL, '\"offline\"', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"google-api-key\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}', 92, '9999-12-31', '9999-12-31', 1, '2026-04-12 04:15:52', '2026-04-12 04:16:06', NULL, NULL, NULL, 'openai', 40000, 40, 0, 0, 0, 0),
(44, 204, 999, 'USD', '$', 'Citibank', '36145108', 1, 0, 0, NULL, '\"offline\"', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"google-api-key\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}', 93, '2026-04-12', '2026-04-19', 1, '2026-04-12 04:17:22', '2026-04-19 22:43:10', NULL, 'membership69db713893b6c.pdf', NULL, 'gemini', 60000, 60, 4830, 4, 0, 0),
(46, 204, 999, 'USD', '$', 'PayPal', '6UW88667CJ765174G', 1, 0, 0, NULL, '{\"paypal_order_id\":\"6UW88667CJ765174G\",\"paypal_capture_status\":\"COMPLETED\",\"paypal_capture_response\":{\"status\":\"COMPLETED\",\"raw\":{\"id\":\"6UW88667CJ765174G\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"megasoft.envato@gmail.com\",\"account_id\":\"8C5NYJ7EZ7QSS\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"address\":{\"country_code\":\"US\"}}},\"purchase_units\":[{\"reference_id\":\"default\",\"shipping\":{\"name\":{\"full_name\":\"Samiul Alim Pratik\"},\"address\":{\"address_line_1\":\"1 Main St\",\"admin_area_2\":\"San Jose\",\"admin_area_1\":\"CA\",\"postal_code\":\"95131\",\"country_code\":\"US\"}},\"payments\":{\"captures\":[{\"id\":\"4RW91909MX576104V\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"35.36\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"963.64\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4RW91909MX576104V\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4RW91909MX576104V\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/6UW88667CJ765174G\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-20T04:43:38Z\",\"update_time\":\"2026-04-20T04:43:38Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"email_address\":\"megasoft.envato@gmail.com\",\"payer_id\":\"8C5NYJ7EZ7QSS\",\"address\":{\"country_code\":\"US\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/6UW88667CJ765174G\",\"rel\":\"self\",\"method\":\"GET\"}]}},\"gateway\":\"paypal\",\"payment_state\":\"completed\"}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}', 93, '2026-04-20', '2026-04-19', 1, '2026-04-19 22:43:45', '2026-04-19 22:46:24', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 0, 0, 0),
(47, 204, 999, 'USD', '$', 'PayPal', '4HY982028C6056123', 1, 0, 0, NULL, '{\"paypal_order_id\":\"4HY982028C6056123\",\"paypal_capture_status\":\"COMPLETED\",\"paypal_capture_response\":{\"status\":\"COMPLETED\",\"raw\":{\"id\":\"4HY982028C6056123\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"megasoft.envato@gmail.com\",\"account_id\":\"8C5NYJ7EZ7QSS\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"address\":{\"country_code\":\"US\"}}},\"purchase_units\":[{\"reference_id\":\"default\",\"shipping\":{\"name\":{\"full_name\":\"Samiul Alim Pratik\"},\"address\":{\"address_line_1\":\"1 Main St\",\"admin_area_2\":\"San Jose\",\"admin_area_1\":\"CA\",\"postal_code\":\"95131\",\"country_code\":\"US\"}},\"payments\":{\"captures\":[{\"id\":\"4UY74085H80422231\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"35.36\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"963.64\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4UY74085H80422231\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4UY74085H80422231\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/4HY982028C6056123\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-20T04:46:34Z\",\"update_time\":\"2026-04-20T04:46:34Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"email_address\":\"megasoft.envato@gmail.com\",\"payer_id\":\"8C5NYJ7EZ7QSS\",\"address\":{\"country_code\":\"US\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/4HY982028C6056123\",\"rel\":\"self\",\"method\":\"GET\"}]}},\"gateway\":\"paypal\",\"payment_state\":\"completed\"}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}', 93, '2026-04-20', '2026-04-19', 1, '2026-04-19 22:46:40', '2026-04-19 23:07:01', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 0, 0, 0),
(49, 204, 999, 'INR', '₹', 'PhonePe', 'txn_20260420050750_4081d152', 1, 0, 0, NULL, '{\"phonepe_merchant_txn_id\":\"txn_20260420050750_4081d152\",\"phonepe_status\":\"COMPLETED\",\"phonepe_verify_response\":{\"status\":\"COMPLETED\",\"raw\":{\"code\":\"PAYMENT_SUCCESS\"}},\"gateway\":\"phonepe\",\"payment_state\":\"completed\"}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"\\u20b9\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"INR\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}', 93, '2026-04-20', '2026-04-19', 1, '2026-04-19 23:08:12', '2026-04-19 23:36:09', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 0, 0, 0),
(50, 204, 999, 'INR', '₹', 'PayPal', '51L57987CH954384F', 1, 0, 0, NULL, '{\"paypal_order_id\":\"51L57987CH954384F\",\"paypal_capture_status\":\"COMPLETED\",\"paypal_capture_response\":{\"status\":\"COMPLETED\",\"raw\":{\"id\":\"51L57987CH954384F\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"megasoft.envato@gmail.com\",\"account_id\":\"8C5NYJ7EZ7QSS\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"address\":{\"country_code\":\"US\"}}},\"purchase_units\":[{\"reference_id\":\"default\",\"shipping\":{\"name\":{\"full_name\":\"Samiul Alim Pratik\"},\"address\":{\"address_line_1\":\"1 Main St\",\"admin_area_2\":\"San Jose\",\"admin_area_1\":\"CA\",\"postal_code\":\"95131\",\"country_code\":\"US\"}},\"payments\":{\"captures\":[{\"id\":\"26B360064L288035U\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"35.36\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"963.64\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/26B360064L288035U\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/26B360064L288035U\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/51L57987CH954384F\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-20T05:36:34Z\",\"update_time\":\"2026-04-20T05:36:34Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"email_address\":\"megasoft.envato@gmail.com\",\"payer_id\":\"8C5NYJ7EZ7QSS\",\"address\":{\"country_code\":\"US\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/51L57987CH954384F\",\"rel\":\"self\",\"method\":\"GET\"}]}},\"gateway\":\"paypal\",\"payment_state\":\"completed\"}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"\\u20b9\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"INR\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}', 93, '2026-04-20', '2026-04-19', 1, '2026-04-19 23:36:41', '2026-04-19 23:36:58', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 0, 0, 0),
(51, 204, 999, 'INR', '₹', 'PhonePe', 'txn_20260420053707_9862baaa', 1, 0, 0, NULL, '{\"phonepe_merchant_txn_id\":\"txn_20260420053707_9862baaa\",\"phonepe_status\":\"COMPLETED\",\"phonepe_verify_response\":{\"status\":\"COMPLETED\",\"raw\":{\"code\":\"PAYMENT_SUCCESS\"}},\"gateway\":\"phonepe\",\"payment_state\":\"completed\"}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"\\u20b9\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"INR\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}', 93, '2026-04-20', '2026-04-19', 1, '2026-04-19 23:37:20', '2026-04-19 23:37:29', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 0, 0, 0),
(52, 204, 999, 'NGN', '₦', 'PayPal', '8EM27060E97485437', 1, 0, 0, NULL, '{\"paypal_order_id\":\"8EM27060E97485437\",\"paypal_capture_status\":\"COMPLETED\",\"paypal_capture_response\":{\"status\":\"COMPLETED\",\"raw\":{\"id\":\"8EM27060E97485437\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"megasoft.envato@gmail.com\",\"account_id\":\"8C5NYJ7EZ7QSS\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"address\":{\"country_code\":\"US\"}}},\"purchase_units\":[{\"reference_id\":\"default\",\"shipping\":{\"name\":{\"full_name\":\"Samiul Alim Pratik\"},\"address\":{\"address_line_1\":\"1 Main St\",\"admin_area_2\":\"San Jose\",\"admin_area_1\":\"CA\",\"postal_code\":\"95131\",\"country_code\":\"US\"}},\"payments\":{\"captures\":[{\"id\":\"8YX7870979381842G\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"12.49\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"12.49\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"0.93\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"11.56\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/8YX7870979381842G\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/8YX7870979381842G\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/8EM27060E97485437\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-20T06:14:26Z\",\"update_time\":\"2026-04-20T06:14:26Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"email_address\":\"megasoft.envato@gmail.com\",\"payer_id\":\"8C5NYJ7EZ7QSS\",\"address\":{\"country_code\":\"US\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/8EM27060E97485437\",\"rel\":\"self\",\"method\":\"GET\"}]}},\"payment_verifier\":{\"source_amount\":999,\"source_currency\":\"NGN\",\"verified_amount\":12.49,\"verified_currency\":\"USD\",\"verified_amount_minor\":1249},\"gateway\":\"paypal\",\"payment_state\":\"completed\"}', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"\\u20a6\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"NGN\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"80.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}', 93, '2026-04-20', '2026-05-11', NULL, '2026-04-20 00:14:33', '2026-05-12 07:58:56', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 0, 0, 0),
(55, 204, 19.99, 'USD', '$', 'Flutterwave', '6a03332158b0a', 1, 0, 0, NULL, NULL, NULL, 86, '2026-05-12', '2026-05-11', 1, '2026-05-12 08:03:13', '2026-05-12 08:03:52', NULL, NULL, NULL, 'openai', 20000, 25, 0, 0, 0, 0),
(56, 204, 999, 'USD', '$', 'PayPal', '6a03334854f51', 1, 0, 0, NULL, NULL, NULL, 93, '2026-05-12', '2026-05-11', 1, '2026-05-12 08:03:52', '2026-05-12 08:04:23', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 0, 0, 0),
(57, 204, 19.99, 'USD', '$', NULL, '6a0333674ae36', 1, 0, 0, NULL, NULL, NULL, 86, '2026-05-12', '2026-05-12', 1, '2026-05-12 08:04:23', '2026-05-12 23:32:17', NULL, NULL, NULL, 'openai', 20000, 25, 0, 0, 0, 0);
INSERT INTO `memberships` (`id`, `vendor_id`, `price`, `currency`, `currency_symbol`, `payment_method`, `transaction_id`, `status`, `is_trial`, `trial_days`, `receipt`, `transaction_details`, `settings`, `package_id`, `start_date`, `expire_date`, `modified`, `created_at`, `updated_at`, `conversation_id`, `invoice`, `claim_id`, `ai_engine`, `ai_token_limit`, `ai_image_limit`, `ai_used_tokens`, `ai_used_images`, `ai_token_purchased`, `ai_image_purchased`) VALUES
(58, 204, 29.99, 'USD', '$', NULL, '6a033376ad26b', 1, 0, 0, NULL, NULL, NULL, 87, '9999-12-31', '2026-07-13', 1, '2026-05-12 08:04:38', '2026-05-12 23:32:03', NULL, NULL, NULL, 'gemini', 35000, 30, 0, 0, 0, 0),
(59, 204, 999, 'USD', '$', NULL, '6a040ce1a744c', 1, 0, 0, NULL, NULL, NULL, 93, '2026-05-13', '9999-12-31', NULL, '2026-05-12 23:32:17', '2026-05-12 23:32:17', NULL, NULL, NULL, 'gemini', 60000, 60, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `menu_builders`
--

CREATE TABLE `menu_builders` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `menus` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `menu_builders`
--

INSERT INTO `menu_builders` (`id`, `language_id`, `menus`, `created_at`, `updated_at`) VALUES
(7, 20, '[{\"text\":\"Home\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"type\":\"listings\",\"text\":\"Listings\",\"target\":\"_self\"},{\"text\":\"Pricing\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"Vendors\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"vendors\"},{\"text\":\"Shop\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"shop\",\"children\":[{\"text\":\"Cart\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"cart\"},{\"text\":\"Checkout\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"checkout\"}]},{\"text\":\"Pages\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"custom\",\"children\":[{\"text\":\"Blog\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"blog\"},{\"text\":\"FAQ\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"About Us\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"about-us\"},{\"text\":\"Terms & Condition\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"terms-&-condition\"},{\"text\":\"Privacy Policy\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"privacy-policy\"}]},{\"text\":\"Contact\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"}]', '2023-08-17 03:19:12', '2025-05-14 06:25:29'),
(8, 21, '[{\"text\":\"بيت\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"text\":\"القوائم\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"listings\"},{\"text\":\"التسعير\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"الباعة\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"vendors\"},{\"text\":\"محل\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"shop\",\"children\":[{\"text\":\"عربة التسوق\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"cart\"},{\"text\":\"الدفع\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"checkout\"}]},{\"text\":\"الصفحات\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_blank\",\"title\":\"\",\"type\":\"custom\",\"children\":[{\"text\":\"مدونة\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"blog\"},{\"text\":\"التعليمات\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"معلومات عنا\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"about-us\"},{\"text\":\"سياسة الخصوصية\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"سياسة-الخصوصية\"},{\"text\":\"الأحكام والشروط\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"الأحكام-والشروط\"}]},{\"text\":\"اتصال\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"}]', '2023-08-17 03:19:32', '2025-01-19 23:05:03');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2023_10_19_031727_create_listing_sections_table', 1),
(2, '2023_10_19_035156_pacakge_section', 2),
(3, '2023_11_13_042845_v', 3),
(4, '2023_11_13_042942_listing_category', 3),
(5, '2023_11_13_044154_create_settings_table', 3),
(6, '2023_11_13_071453_aminites', 4),
(7, '2023_11_14_025059_listing_images', 5),
(8, '2023_11_15_025019_listings', 6),
(9, '2023_11_15_025156_listing_contents', 6),
(10, '2023_11_16_033741_listing_features', 7),
(11, '2023_11_20_062648_listing_reviews', 8),
(12, '2023_11_21_090259_messages', 9),
(13, '2023_11_21_091821_listing_messages', 10),
(14, '2023_11_22_040920_listing_social_media', 11),
(15, '2023_11_23_034340_listing_products', 12),
(16, '2023_11_23_034430_listing_products_content', 12),
(17, '2023_11_23_034512_listingproductimages', 12),
(18, '2023_11_26_031913_business_hours', 13),
(19, '2023_12_02_045705_listing_faq', 14),
(20, '2023_12_05_033837_listing_feature_charges', 15),
(21, '2023_12_05_081415_feature_orders', 16),
(22, '2023_12_13_050545_video_sections', 17),
(23, '2023_12_13_095353_location_section', 18),
(24, '2023_12_17_033638_countries', 19),
(25, '2023_12_17_044738_states', 20),
(26, '2023_12_17_064230_cities', 21),
(27, '2023_12_24_031950_product_messages', 22),
(28, '2024_01_10_033406_listingspecificationcontents', 23),
(29, '2024_03_27_022811_herosections', 24),
(33, '2024_09_21_023134_add_new_9_payment_gateways_into_payment_gateways_table', 25),
(34, '2021_02_01_030511_create_payment_invoices_table', 26),
(35, '2024_10_02_054621_colum_change_type_in_listing_contents_table', 27),
(36, '2024_10_02_055839_chang_colum_type_in_seos_table', 28),
(37, '2024_10_14_062259_add_a_colum_to_the_memberships_table', 29),
(38, '2024_10_14_083647_add_conversation_id_to_product_orders_table', 30),
(39, '2024_10_15_035325_add_a_colum_cities', 31),
(40, '2024_10_15_064417_add_a_colum_listing_contents', 32),
(42, '2024_10_15_083427_add_a_colum_to_basic_settings', 33),
(43, '2024_10_28_043254_three_colum_added_basic_settings', 34),
(44, '2024_11_07_081919_add_invoice_colum_in_memberships_table', 35),
(45, '2024_11_07_084745_add_colum_vendors_table_and_admins_table', 36),
(46, '2025_01_14_041000_add_conversation_id_to_feature_orders_table', 37),
(47, '2025_09_23_090816_create_forms_table', 38),
(48, '2025_09_23_091028_create_form_inputs_table', 39),
(49, '2025_09_23_112845_create_forms_table', 40),
(50, '2025_09_23_082541_create_claim_listings_table', 41),
(51, '2025_10_10_055102_modify_product_id_foreign_on_product_contents_table', 42),
(52, '2025_10_10_063904_alter_product_contents_make_product_category_id_nullable', 43),
(53, '2025_10_14_072622_create_withdraws_table', 44),
(54, '2025_10_14_073517_create_withdraw_method_inputs_table', 45),
(55, '2025_10_14_074202_create_withdraw_method_options_table', 46),
(56, '2025_10_14_080023_create_withdraw_payment_methods_table', 47),
(57, '2025_10_23_064107_add_redemption_fields_to_claim_listings_table', 48),
(58, '2019_12_14_000001_create_personal_access_tokens_table', 49),
(59, '2025_11_03_080928_add_columns_to_existing_tables', 49),
(60, '2025_11_03_112159_transfer_listing_products_to_products', 50),
(62, '2025_11_11_130153_add_column_to_basic_settings', 51),
(63, '2025_11_11_123006_create_mobile_interface_settings_table', 52),
(64, '2025_11_15_102259_add_column_online_gateways', 53),
(67, '2025_11_18_090332_add_column_to_mobile_interface', 54),
(68, '2025_10_18_124132_create_fcm_tokens_table', 55),
(69, '2025_12_04_081914_add_three_colum_to_fcm_tokens', 55),
(70, '2025_12_04_090431_add_a_colum_to_product_orders_table', 55),
(71, '2025_12_07_091718_add_a_colum_to_listing_categories_table', 56),
(72, '2026_03_04_064304_create_token_wallets_table', 57),
(73, '2026_03_04_074027_add_ai_columns_to_packages_table', 58),
(74, '2026_03_04_074729_add_ai_provider_columns_to_basic_settings_table', 59),
(75, '2026_03_07_054612_add_columns_to_memberships_table', 60),
(76, '2026_05_11_113337_create_vendor_devices_table', 61),
(77, '2026_05_11_114519_create_vendor_notifications_table', 61);

-- --------------------------------------------------------

--
-- Table structure for table `mobile_interface_settings`
--

CREATE TABLE `mobile_interface_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `category_listing_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured_listing_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_background_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_button_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mobile_interface_settings`
--

INSERT INTO `mobile_interface_settings` (`id`, `language_id`, `category_listing_section_title`, `featured_listing_section_title`, `banner_background_image`, `banner_image`, `banner_title`, `banner_button_text`, `banner_button_url`, `created_at`, `updated_at`) VALUES
(1, 20, 'Categories', 'Featured Listings', '6918478ed97df.png', '691847a0c9b2e.png', 'Explore Most Popular Listing Items', 'Listings', '/listing', NULL, NULL),
(2, 21, 'فئات', 'القوائم المميزة', '693644a142a3e.png', '693644a142f81.png', 'استكشف العناصر الأكثر شعبية في القائمة', 'القوائم', '/listing', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `offline_gateways`
--

CREATE TABLE `offline_gateways` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `short_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `instructions` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 -> gateway is deactive, 1 -> gateway is active.',
  `has_attachment` tinyint(1) NOT NULL COMMENT '0 -> do not need attachment, 1 -> need attachment.',
  `serial_number` mediumint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `offline_gateways`
--

INSERT INTO `offline_gateways` (`id`, `name`, `short_description`, `instructions`, `status`, `has_attachment`, `serial_number`, `created_at`, `updated_at`) VALUES
(14, 'Citibank', 'A pioneer of both the credit card industry and automated teller machines, Citibank – formerly the City Bank of New York.', '', 1, 0, 1, '2024-05-07 22:05:24', '2024-05-07 22:05:24'),
(15, 'Bank of America', 'Bank of America has 4,265 branches in the country, only about 700 fewer than Chase. It started as a small institution serving immigrants in San Francisco.', '', 1, 1, 2, '2024-05-07 22:06:01', '2024-05-07 22:06:01');

-- --------------------------------------------------------

--
-- Table structure for table `online_gateways`
--

CREATE TABLE `online_gateways` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `keyword` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `information` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `mobile_status` tinyint NOT NULL DEFAULT '0',
  `mobile_information` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `online_gateways`
--

INSERT INTO `online_gateways` (`id`, `name`, `keyword`, `information`, `status`, `mobile_status`, `mobile_information`) VALUES
(1, 'PayPal', 'paypal', '{\"sandbox_status\":\"1\",\"client_id\":\"xxxxx\",\"client_secret\":\"xxxxx\"}', 1, 1, '{\"sandbox_status\":\"1\",\"client_id\":\"fdffd\",\"client_secret\":\"fdfdfdfdf\"}'),
(2, 'Instamojo', 'instamojo', '{\"sandbox_status\":\"0\",\"key\":\"t\",\"token\":\"t\"}', 0, 1, '{\"sandbox_status\":\"1\",\"key\":\"fdfdfd\",\"token\":\"fdfdf\"}'),
(3, 'Paystack', 'paystack', '{\"key\":\"t\"}', 0, 1, '{\"key\":\"rr\"}'),
(4, 'Flutterwave', 'flutterwave', '{\"public_key\":\"t\",\"secret_key\":\"t\"}', 1, 1, '{\"public_key\":\"fdfdfdf\",\"secret_key\":\"fdfdfdf\"}'),
(5, 'Razorpay', 'razorpay', '{\"key\":\"t\",\"secret\":\"t\"}', 0, 1, '{\"key\":\"Quia commodi perfere\",\"secret\":\"Consequatur ut poss\"}'),
(6, 'MercadoPago', 'mercadopago', '{\"sandbox_status\":\"0\",\"token\":\"t\"}', 0, 1, '{\"sandbox_status\":\"1\",\"token\":\"Sed quos fugiat in s\"}'),
(7, 'Mollie', 'mollie', '{\"key\":\"xxxxx\"}', 1, 1, '{\"key\":\"fdfdfdff\"}'),
(10, 'Stripe', 'stripe', '{\"key\":\"t\",\"secret\":\"t\"}', 0, 1, '{\"key\":\"11\",\"secret\":\"11\"}'),
(11, 'Paytm', 'paytm', '{\"environment\":\"production\",\"merchant_key\":\"t\",\"merchant_mid\":\"t\",\"merchant_website\":\"t\",\"industry_type\":\"t\"}', 0, 1, '{\"environment\":\"test\",\"merchant_key\":\"fggfgfg\",\"merchant_mid\":\"gfgfggf\",\"merchant_website\":\"gfgfgf\",\"industry_type\":\"gfgfgfg\"}'),
(21, 'Authorize.net', 'authorize.net', '{\"login_id\":\"t\",\"transaction_key\":\"t\",\"public_key\":\"t\",\"sandbox_check\":\"0\",\"text\":\"Pay via your Authorize.net account.\"}', 0, 1, '{\"login_id\":\"11\",\"transaction_key\":\"11\",\"public_key\":\"11\",\"sandbox_check\":\"1\",\"text\":\"Pay via your Authorize.net account.\"}'),
(49, 'PhonePe', 'phonepe', '{\"merchant_id\":\"xxxx\",\"sandbox_status\":\"1\",\"salt_key\":\"xxx\",\"salt_index\":\"1\"}', 1, 1, '{\"merchant_id\":\"dfdfdf\",\"sandbox_status\":\"1\",\"salt_key\":\"dfdfdf\",\"salt_index\":\"1\"}'),
(50, 'Perfect Money', 'perfect_money', '{\"perfect_money_wallet_id\":\"t\"}', 1, 1, '{\"perfect_money_wallet_id\":\"rrr\",\"perfect_money_password\":\"trtrt\",\"perfect_money_name\":\"trtrt\"}'),
(51, 'Xendit', 'xendit', '{\"secret_key\":\"1\"}', 1, 1, '{\"secret_key\":\"Consequatur alias ex\"}'),
(52, 'Myfatoorah', 'myfatoorah', '{\"token\":\"t\",\"sandbox_status\":\"0\"}', 0, 1, '{\"token\":\"11\",\"sandbox_status\":\"1\"}'),
(53, 'Yoco', 'yoco', '{\"secret_key\":\"t\"}', 0, 1, '{\"secret_key\":\"fdfdffd\"}'),
(54, 'Toyyibpay', 'toyyibpay', '{\"sandbox_status\":\"0\",\"secret_key\":\"t\",\"category_code\":\"t\"}', 0, 1, '{\"sandbox_status\":\"1\",\"secret_key\":\"11\",\"category_code\":\"11\"}'),
(55, 'Paytabs', 'paytabs', '{\"server_key\":\"t\",\"profile_id\":\"t\",\"country\":\"global\",\"api_endpoint\":\"t\"}', 0, 1, '{\"server_key\":\"fggffg\",\"profile_id\":\"gfgfggf\",\"country\":\"global\",\"api_endpoint\":\"gfgfg\"}'),
(56, 'Iyzico', 'iyzico', '{\"api_key\":\"t\",\"secrect_key\":\"t\",\"iyzico_mode\":\"0\"}', 0, 1, '{\"api_key\":\"fdfdf\",\"secrect_key\":\"fdfdfdf\",\"iyzico_mode\":\"1\"}'),
(57, 'Midtrans', 'midtrans', '{\"is_production\":\"1\",\"server_key\":\"t\"}', 0, 1, '{\"is_production\":\"1\",\"server_key\":\"11\"}'),
(58, 'Authorize.net', 'authorize.net', '', 0, 0, ''),
(59, 'Monnify', 'monnify', '', 0, 1, '{\"sandbox_status\":\"1\",\"api_key\":\"11\",\"secret_key\":\"11\",\"wallet_account_number\":\"11\"}'),
(60, 'NowPayments', 'now_payments', '', 0, 1, '{\"api_key\":\"fdffdffd\"}');

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price` double NOT NULL DEFAULT '0',
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `term` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `number_of_listing` int DEFAULT '0',
  `recommended` int DEFAULT NULL,
  `number_of_images_per_listing` int DEFAULT '0',
  `number_of_products` int DEFAULT '0',
  `number_of_images_per_products` int DEFAULT '0',
  `number_of_amenities_per_listing` int DEFAULT '0',
  `number_of_additional_specification` int DEFAULT '0',
  `number_of_social_links` int DEFAULT '0',
  `number_of_faq` int DEFAULT '0',
  `custom_features` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` int NOT NULL DEFAULT '1',
  `features` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `ai_engine` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ai_token_limit` bigint UNSIGNED NOT NULL DEFAULT '0',
  `ai_image_limit` bigint UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `title`, `slug`, `price`, `icon`, `term`, `number_of_listing`, `recommended`, `number_of_images_per_listing`, `number_of_products`, `number_of_images_per_products`, `number_of_amenities_per_listing`, `number_of_additional_specification`, `number_of_social_links`, `number_of_faq`, `custom_features`, `status`, `features`, `ai_engine`, `ai_token_limit`, `ai_image_limit`, `created_at`, `updated_at`) VALUES
(85, 'Silver', 'silver', 9, 'fas fa-gift iconpicker-component', 'monthly', 3, 0, 3, 3, 3, 3, 3, 3, 3, '', 1, '[\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"AI Content & Image Generator\"]', 'gemini', 10000, 10, '2024-04-30 23:00:29', '2026-03-09 01:45:47'),
(86, 'Gold', 'gold', 19.99, 'fas fa-gift iconpicker-component', 'monthly', 5, 1, 5, 5, 5, 5, 5, 5, 5, '', 1, '[\"Listing Enquiry Form\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"WhatsApp\",\"AI Content & Image Generator\"]', 'openai', 20000, 25, '2024-04-30 23:01:21', '2026-03-09 01:22:01'),
(87, 'Platinum', 'platinum', 29.99, 'fas fa-gift iconpicker-component', 'monthly', 10, 0, 10, 10, 10, 10, 10, 10, 10, '', 1, '[\"Listing Enquiry Form\",\"Video\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"Messenger\",\"WhatsApp\",\"Telegram\",\"Tawk.To\",\"AI Content & Image Generator\"]', 'gemini', 35000, 30, '2024-04-30 23:02:16', '2026-03-09 01:22:43'),
(88, 'Silver', 'silver', 99, 'fas fa-gift iconpicker-component', 'yearly', 3, 0, 3, 3, 10, 3, 3, 3, 3, '', 1, '[\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Product Enquiry Form\",\"AI Content & Image Generator\"]', 'gemini', 25000, 25, '2024-04-30 23:03:30', '2026-03-09 01:24:13'),
(89, 'Gold', 'gold', 199, 'fas fa-gift iconpicker-component', 'yearly', 5, 1, 5, 5, 5, 5, 5, 5, 5, '', 1, '[\"Listing Enquiry Form\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"WhatsApp\",\"AI Content & Image Generator\"]', 'openai', 35000, 33, '2024-04-30 23:04:31', '2026-03-09 01:25:13'),
(90, 'Platinum', 'platinum', 299, 'fas fa-gift iconpicker-component', 'yearly', 10, 0, 10, 10, 10, 10, 10, 10, 10, '', 1, '[\"Listing Enquiry Form\",\"Video\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"Messenger\",\"WhatsApp\",\"Telegram\",\"Tawk.To\",\"AI Content & Image Generator\"]', 'gemini', 50000, 48, '2024-04-30 23:05:31', '2026-03-09 01:26:08'),
(91, 'Silver', 'silver', 399, 'fas fa-gift iconpicker-component', 'lifetime', 3, 0, 3, 3, 3, 3, 3, 3, 3, '', 1, '[\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"AI Content & Image Generator\"]', 'openai', 30000, 30, '2024-04-30 23:08:56', '2026-03-09 01:29:30'),
(92, 'Gold', 'gold', 699, 'fas fa-gift iconpicker-component', 'lifetime', 5, 1, 5, 5, 5, 5, 5, 5, 5, '', 1, '[\"Listing Enquiry Form\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"WhatsApp\",\"AI Content & Image Generator\"]', 'openai', 40000, 40, '2024-04-30 23:10:57', '2026-03-09 01:27:47'),
(93, 'Platinum', 'platinum', 999, 'fas fa-gift iconpicker-component', 'lifetime', 10, 0, 10, 10, 10, 10, 10, 10, 10, '', 1, '[\"Listing Enquiry Form\",\"Video\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"Messenger\",\"WhatsApp\",\"Telegram\",\"Tawk.To\",\"AI Content & Image Generator\"]', 'gemini', 60000, 60, '2024-04-30 23:11:40', '2026-03-09 01:28:15');

-- --------------------------------------------------------

--
-- Table structure for table `package_sections`
--

CREATE TABLE `package_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `package_sections`
--

INSERT INTO `package_sections` (`id`, `language_id`, `title`, `subtitle`, `button_text`, `created_at`, `updated_at`) VALUES
(1, 20, 'Most Affordable Package', NULL, NULL, '2023-10-18 22:02:00', '2024-05-06 03:16:31'),
(2, 21, 'الحزمة الأكثر بأسعار معقولة', NULL, NULL, '2023-10-18 22:02:18', '2024-05-06 03:16:42');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint UNSIGNED NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `status`, `created_at`, `updated_at`) VALUES
(21, 1, '2023-08-19 23:52:10', '2023-08-19 23:52:10'),
(22, 1, '2023-08-19 23:56:10', '2023-08-19 23:56:10');

-- --------------------------------------------------------

--
-- Table structure for table `page_contents`
--

CREATE TABLE `page_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `page_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` blob NOT NULL,
  `meta_keywords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `page_contents`
--

INSERT INTO `page_contents` (`id`, `language_id`, `page_id`, `title`, `slug`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(45, 20, 21, 'Terms & Condition', 'terms-&-condition', 0x3c703e57656c636f6d6520746f203c7374726f6e673e42756c697374696f3c2f7374726f6e673e213c2f703e0d0a3c703e5468657365207465726d7320616e6420636f6e646974696f6e73206f75746c696e65207468652072756c657320616e6420726567756c6174696f6e7320666f722074686520757365206f662042756c697374696f277320576562736974652e3c2f703e0d0a3c703e427920616363657373696e672074686973207765627369746520776520617373756d6520796f7520616363657074207468657365207465726d7320616e6420636f6e646974696f6e732e20446f206e6f7420636f6e74696e756520746f207573652042756c697374696f20696620796f7520646f206e6f7420616772656520746f2074616b6520616c6c206f6620746865207465726d7320616e6420636f6e646974696f6e7320737461746564206f6e207468697320706167652e3c2f703e0d0a3c703e54686520666f6c6c6f77696e67207465726d696e6f6c6f6779206170706c69657320746f207468657365205465726d7320616e6420436f6e646974696f6e732c20507269766163792053746174656d656e7420616e6420446973636c61696d6572204e6f7469636520616e6420616c6c2041677265656d656e74733a2022436c69656e74222c2022596f752220616e642022596f7572222072656665727320746f20796f752c2074686520706572736f6e206c6f67206f6e2074686973207765627369746520616e6420636f6d706c69616e7420746f2074686520436f6d70616e792773207465726d7320616e6420636f6e646974696f6e732e202254686520436f6d70616e79222c20224f757273656c766573222c20225765222c20224f75722220616e6420225573222c2072656665727320746f206f757220436f6d70616e792e20225061727479222c202250617274696573222c206f7220225573222c2072656665727320746f20626f74682074686520436c69656e7420616e64206f757273656c7665732e20416c6c207465726d7320726566657220746f20746865206f666665722c20616363657074616e636520616e6420636f6e73696465726174696f6e206f66207061796d656e74206e656365737361727920746f20756e64657274616b65207468652070726f63657373206f66206f757220617373697374616e636520746f2074686520436c69656e7420696e20746865206d6f737420617070726f707269617465206d616e6e657220666f7220746865206578707265737320707572706f7365206f66206d656574696e672074686520436c69656e742773206e6565647320696e2072657370656374206f662070726f766973696f6e206f662074686520436f6d70616e792773207374617465642073657276696365732c20696e206163636f7264616e6365207769746820616e64207375626a65637420746f2c207072657661696c696e67206c6177206f662075732e20416e7920757365206f66207468652061626f7665207465726d696e6f6c6f6779206f72206f7468657220776f72647320696e207468652073696e67756c61722c20706c7572616c2c206361706974616c697a6174696f6e20616e642f6f722068652f736865206f7220746865792c206172652074616b656e20617320696e7465726368616e676561626c6520616e64207468657265666f726520617320726566657272696e6720746f2073616d652e3c2f703e0d0a3c68343e3c7374726f6e673e436f6f6b6965733c2f7374726f6e673e3c2f68343e0d0a3c703e576520656d706c6f792074686520757365206f6620636f6f6b6965732e20427920616363657373696e672042756c697374696f2c20796f752061677265656420746f2075736520636f6f6b69657320696e2061677265656d656e742077697468207468652042756c697374696f2773205072697661637920506f6c6963792e3c2f703e0d0a3c703e4d6f737420696e7465726163746976652077656273697465732075736520636f6f6b69657320746f206c657420757320726574726965766520746865207573657227732064657461696c7320666f7220656163682076697369742e20436f6f6b696573206172652075736564206279206f7572207765627369746520746f20656e61626c65207468652066756e6374696f6e616c697479206f66206365727461696e20617265617320746f206d616b652069742065617369657220666f722070656f706c65207669736974696e67206f757220776562736974652e20536f6d65206f66206f757220616666696c696174652f6164766572746973696e6720706172746e657273206d617920616c736f2075736520636f6f6b6965732e3c2f703e0d0a3c68343e3c7374726f6e673e4c6963656e73653c2f7374726f6e673e3c2f68343e0d0a3c703e556e6c657373206f7468657277697365207374617465642c2042756c697374696f20616e642f6f7220697473206c6963656e736f7273206f776e2074686520696e74656c6c65637475616c2070726f70657274792072696768747320666f7220616c6c206d6174657269616c206f6e2042756c697374696f2e20416c6c20696e74656c6c65637475616c2070726f706572747920726967687473206172652072657365727665642e20596f75206d61792061636365737320746869732066726f6d2042756c697374696f20666f7220796f7572206f776e20706572736f6e616c20757365207375626a656374656420746f207265737472696374696f6e732073657420696e207468657365207465726d7320616e6420636f6e646974696f6e732e3c2f703e0d0a3c703e596f75206d757374206e6f743a3c2f703e0d0a3c756c3e0d0a3c6c693e52657075626c697368206d6174657269616c2066726f6d2042756c697374696f3c2f6c693e0d0a3c6c693e53656c6c2c2072656e74206f72207375622d6c6963656e7365206d6174657269616c2066726f6d2042756c697374696f3c2f6c693e0d0a3c6c693e526570726f647563652c206475706c6963617465206f7220636f7079206d6174657269616c2066726f6d2042756c697374696f3c2f6c693e0d0a3c6c693e52656469737472696275746520636f6e74656e742066726f6d2042756c697374696f3c2f6c693e0d0a3c2f756c3e0d0a3c703e546869732041677265656d656e74207368616c6c20626567696e206f6e20746865206461746520686572656f662e204f7572205465726d7320616e6420436f6e646974696f6e73207765726520637265617465642077697468207468652068656c70206f6620746865c2a03c6120687265663d2268747470733a2f2f7777772e7465726d73616e64636f6e646974696f6e7367656e657261746f722e636f6d2f223e46726565205465726d7320616e6420436f6e646974696f6e732047656e657261746f723c2f613e2e3c2f703e0d0a3c703e5061727473206f6620746869732077656273697465206f6666657220616e206f70706f7274756e69747920666f7220757365727320746f20706f737420616e642065786368616e6765206f70696e696f6e7320616e6420696e666f726d6174696f6e20696e206365727461696e206172656173206f662074686520776562736974652e2042756c697374696f20646f6573206e6f742066696c7465722c20656469742c207075626c697368206f722072657669657720436f6d6d656e7473207072696f7220746f2074686569722070726573656e6365206f6e2074686520776562736974652e20436f6d6d656e747320646f206e6f74207265666c6563742074686520766965777320616e64206f70696e696f6e73206f662042756c697374696f2c697473206167656e747320616e642f6f7220616666696c69617465732e20436f6d6d656e7473207265666c6563742074686520766965777320616e64206f70696e696f6e73206f662074686520706572736f6e2077686f20706f737420746865697220766965777320616e64206f70696e696f6e732e20546f2074686520657874656e74207065726d6974746564206279206170706c696361626c65206c6177732c2042756c697374696f207368616c6c206e6f74206265206c6961626c6520666f722074686520436f6d6d656e7473206f7220666f7220616e79206c696162696c6974792c2064616d61676573206f7220657870656e7365732063617573656420616e642f6f72207375666665726564206173206120726573756c74206f6620616e7920757365206f6620616e642f6f7220706f7374696e67206f6620616e642f6f7220617070656172616e6365206f662074686520436f6d6d656e7473206f6e207468697320776562736974652e3c2f703e0d0a3c703e42756c697374696f2072657365727665732074686520726967687420746f206d6f6e69746f7220616c6c20436f6d6d656e747320616e6420746f2072656d6f766520616e7920436f6d6d656e74732077686963682063616e20626520636f6e7369646572656420696e617070726f7072696174652c206f6666656e73697665206f722063617573657320627265616368206f66207468657365205465726d7320616e6420436f6e646974696f6e732e3c2f703e0d0a3c703e596f752077617272616e7420616e6420726570726573656e7420746861743a3c2f703e0d0a3c756c3e0d0a3c6c693e596f752061726520656e7469746c656420746f20706f73742074686520436f6d6d656e7473206f6e206f7572207765627369746520616e64206861766520616c6c206e6563657373617279206c6963656e73657320616e6420636f6e73656e747320746f20646f20736f3b3c2f6c693e0d0a3c6c693e54686520436f6d6d656e747320646f206e6f7420696e7661646520616e7920696e74656c6c65637475616c2070726f70657274792072696768742c20696e636c7564696e6720776974686f7574206c696d69746174696f6e20636f707972696768742c20706174656e74206f722074726164656d61726b206f6620616e792074686972642070617274793b3c2f6c693e0d0a3c6c693e54686520436f6d6d656e747320646f206e6f7420636f6e7461696e20616e7920646566616d61746f72792c206c6962656c6f75732c206f6666656e736976652c20696e646563656e74206f72206f746865727769736520756e6c617766756c206d6174657269616c20776869636820697320616e20696e766173696f6e206f6620707269766163793c2f6c693e0d0a3c6c693e54686520436f6d6d656e74732077696c6c206e6f74206265207573656420746f20736f6c69636974206f722070726f6d6f746520627573696e657373206f7220637573746f6d206f722070726573656e7420636f6d6d65726369616c2061637469766974696573206f7220756e6c617766756c2061637469766974792e3c2f6c693e0d0a3c2f756c3e0d0a3c703e596f7520686572656279206772616e742042756c697374696f2061206e6f6e2d6578636c7573697665206c6963656e736520746f207573652c20726570726f647563652c206564697420616e6420617574686f72697a65206f746865727320746f207573652c20726570726f6475636520616e64206564697420616e79206f6620796f757220436f6d6d656e747320696e20616e7920616e6420616c6c20666f726d732c20666f726d617473206f72206d656469612e3c2f703e0d0a3c68343e3c7374726f6e673e48797065726c696e6b696e6720746f206f757220436f6e74656e743c2f7374726f6e673e3c2f68343e0d0a3c703e54686520666f6c6c6f77696e67206f7267616e697a6174696f6e73206d6179206c696e6b20746f206f7572205765627369746520776974686f7574207072696f72207772697474656e20617070726f76616c3a3c2f703e0d0a3c756c3e0d0a3c6c693e476f7665726e6d656e74206167656e636965733b3c2f6c693e0d0a3c6c693e53656172636820656e67696e65733b3c2f6c693e0d0a3c6c693e4e657773206f7267616e697a6174696f6e733b3c2f6c693e0d0a3c6c693e4f6e6c696e65206469726563746f7279206469737472696275746f7273206d6179206c696e6b20746f206f7572205765627369746520696e207468652073616d65206d616e6e657220617320746865792068797065726c696e6b20746f20746865205765627369746573206f66206f74686572206c697374656420627573696e65737365733b20616e643c2f6c693e0d0a3c6c693e53797374656d2077696465204163637265646974656420427573696e65737365732065786365707420736f6c69636974696e67206e6f6e2d70726f666974206f7267616e697a6174696f6e732c20636861726974792073686f7070696e67206d616c6c732c20616e6420636861726974792066756e6472616973696e672067726f757073207768696368206d6179206e6f742068797065726c696e6b20746f206f75722057656220736974652e3c2f6c693e0d0a3c2f756c3e0d0a3c703e5468657365206f7267616e697a6174696f6e73206d6179206c696e6b20746f206f757220686f6d6520706167652c20746f207075626c69636174696f6e73206f7220746f206f74686572205765627369746520696e666f726d6174696f6e20736f206c6f6e6720617320746865206c696e6b3a20286129206973206e6f7420696e20616e7920776179206465636570746976653b2028622920646f6573206e6f742066616c73656c7920696d706c792073706f6e736f72736869702c20656e646f7273656d656e74206f7220617070726f76616c206f6620746865206c696e6b696e6720706172747920616e64206974732070726f647563747320616e642f6f722073657276696365733b20616e642028632920666974732077697468696e2074686520636f6e74657874206f6620746865206c696e6b696e67207061727479277320736974652e3c2f703e0d0a3c703e5765206d617920636f6e736964657220616e6420617070726f7665206f74686572206c696e6b2072657175657374732066726f6d2074686520666f6c6c6f77696e67207479706573206f66206f7267616e697a6174696f6e733a3c2f703e0d0a3c756c3e0d0a3c6c693e636f6d6d6f6e6c792d6b6e6f776e20636f6e73756d657220616e642f6f7220627573696e65737320696e666f726d6174696f6e20736f75726365733b3c2f6c693e0d0a3c6c693e646f742e636f6d20636f6d6d756e6974792073697465733b3c2f6c693e0d0a3c6c693e6173736f63696174696f6e73206f72206f746865722067726f75707320726570726573656e74696e67206368617269746965733b3c2f6c693e0d0a3c6c693e6f6e6c696e65206469726563746f7279206469737472696275746f72733b3c2f6c693e0d0a3c6c693e696e7465726e657420706f7274616c733b3c2f6c693e0d0a3c6c693e6163636f756e74696e672c206c617720616e6420636f6e73756c74696e67206669726d733b20616e643c2f6c693e0d0a3c6c693e656475636174696f6e616c20696e737469747574696f6e7320616e64207472616465206173736f63696174696f6e732e3c2f6c693e0d0a3c2f756c3e0d0a3c703e57652077696c6c20617070726f7665206c696e6b2072657175657374732066726f6d207468657365206f7267616e697a6174696f6e732069662077652064656369646520746861743a2028612920746865206c696e6b20776f756c64206e6f74206d616b65207573206c6f6f6b20756e6661766f7261626c7920746f206f757273656c766573206f7220746f206f7572206163637265646974656420627573696e65737365733b2028622920746865206f7267616e697a6174696f6e20646f6573206e6f74206861766520616e79206e65676174697665207265636f72647320776974682075733b20286329207468652062656e6566697420746f2075732066726f6d20746865207669736962696c697479206f66207468652068797065726c696e6b20636f6d70656e73617465732074686520616273656e6365206f662042756c697374696f3b20616e642028642920746865206c696e6b20697320696e2074686520636f6e74657874206f662067656e6572616c207265736f7572636520696e666f726d6174696f6e2e3c2f703e0d0a3c703e5468657365206f7267616e697a6174696f6e73206d6179206c696e6b20746f206f757220686f6d65207061676520736f206c6f6e6720617320746865206c696e6b3a20286129206973206e6f7420696e20616e7920776179206465636570746976653b2028622920646f6573206e6f742066616c73656c7920696d706c792073706f6e736f72736869702c20656e646f7273656d656e74206f7220617070726f76616c206f6620746865206c696e6b696e6720706172747920616e64206974732070726f6475637473206f722073657276696365733b20616e642028632920666974732077697468696e2074686520636f6e74657874206f6620746865206c696e6b696e67207061727479277320736974652e3c2f703e0d0a3c703e496620796f7520617265206f6e65206f6620746865206f7267616e697a6174696f6e73206c697374656420696e2070617261677261706820322061626f766520616e642061726520696e746572657374656420696e206c696e6b696e6720746f206f757220776562736974652c20796f75206d75737420696e666f726d2075732062792073656e64696e6720616e20652d6d61696c20746f2042756c697374696f2e20506c6561736520696e636c75646520796f7572206e616d652c20796f7572206f7267616e697a6174696f6e206e616d652c20636f6e7461637420696e666f726d6174696f6e2061732077656c6c206173207468652055524c206f6620796f757220736974652c2061206c697374206f6620616e792055524c732066726f6d20776869636820796f7520696e74656e6420746f206c696e6b20746f206f757220576562736974652c20616e642061206c697374206f66207468652055524c73206f6e206f7572207369746520746f20776869636820796f7520776f756c64206c696b6520746f206c696e6b2e205761697420322d33207765656b7320666f72206120726573706f6e73652e3c2f703e0d0a3c703e417070726f766564206f7267616e697a6174696f6e73206d61792068797065726c696e6b20746f206f7572205765627369746520617320666f6c6c6f77733a3c2f703e0d0a3c756c3e0d0a3c6c693e427920757365206f66206f757220636f72706f72617465206e616d653b206f723c2f6c693e0d0a3c6c693e427920757365206f662074686520756e69666f726d207265736f75726365206c6f6361746f72206265696e67206c696e6b656420746f3b206f723c2f6c693e0d0a3c6c693e427920757365206f6620616e79206f74686572206465736372697074696f6e206f66206f75722057656273697465206265696e67206c696e6b656420746f2074686174206d616b65732073656e73652077697468696e2074686520636f6e7465787420616e6420666f726d6174206f6620636f6e74656e74206f6e20746865206c696e6b696e67207061727479277320736974652e3c2f6c693e0d0a3c2f756c3e0d0a3c703e4e6f20757365206f662042756c697374696f2773206c6f676f206f72206f7468657220617274776f726b2077696c6c20626520616c6c6f77656420666f72206c696e6b696e6720616273656e7420612074726164656d61726b206c6963656e73652061677265656d656e742e3c2f703e0d0a3c68343e3c7374726f6e673e694672616d65733c2f7374726f6e673e3c2f68343e0d0a3c703e576974686f7574207072696f7220617070726f76616c20616e64207772697474656e207065726d697373696f6e2c20796f75206d6179206e6f7420637265617465206672616d65732061726f756e64206f7572205765627061676573207468617420616c74657220696e20616e7920776179207468652076697375616c2070726573656e746174696f6e206f7220617070656172616e6365206f66206f757220576562736974652e3c2f703e0d0a3c68343e3c7374726f6e673e436f6e74656e74204c696162696c6974793c2f7374726f6e673e3c2f68343e0d0a3c703e5765207368616c6c206e6f7420626520686f6c6420726573706f6e7369626c6520666f7220616e7920636f6e74656e7420746861742061707065617273206f6e20796f757220576562736974652e20596f7520616772656520746f2070726f7465637420616e6420646566656e6420757320616761696e737420616c6c20636c61696d73207468617420697320726973696e67206f6e20796f757220576562736974652e204e6f206c696e6b2873292073686f756c6420617070656172206f6e20616e7920576562736974652074686174206d617920626520696e746572707265746564206173206c6962656c6f75732c206f627363656e65206f72206372696d696e616c2c206f7220776869636820696e6672696e6765732c206f74686572776973652076696f6c617465732c206f72206164766f63617465732074686520696e6672696e67656d656e74206f72206f746865722076696f6c6174696f6e206f662c20616e79207468697264207061727479207269676874732e3c2f703e0d0a3c68343e3c7374726f6e673e5265736572766174696f6e206f66205269676874733c2f7374726f6e673e3c2f68343e0d0a3c703e576520726573657276652074686520726967687420746f2072657175657374207468617420796f752072656d6f766520616c6c206c696e6b73206f7220616e7920706172746963756c6172206c696e6b20746f206f757220576562736974652e20596f7520617070726f766520746f20696d6d6564696174656c792072656d6f766520616c6c206c696e6b7320746f206f757220576562736974652075706f6e20726571756573742e20576520616c736f20726573657276652074686520726967687420746f20616d656e207468657365207465726d7320616e6420636f6e646974696f6e7320616e642069742773206c696e6b696e6720706f6c69637920617420616e792074696d652e20427920636f6e74696e756f75736c79206c696e6b696e6720746f206f757220576562736974652c20796f7520616772656520746f20626520626f756e6420746f20616e6420666f6c6c6f77207468657365206c696e6b696e67207465726d7320616e6420636f6e646974696f6e732e3c2f703e0d0a3c68343e3c7374726f6e673e52656d6f76616c206f66206c696e6b732066726f6d206f757220776562736974653c2f7374726f6e673e3c2f68343e0d0a3c703e496620796f752066696e6420616e79206c696e6b206f6e206f757220576562736974652074686174206973206f6666656e7369766520666f7220616e7920726561736f6e2c20796f7520617265206672656520746f20636f6e7461637420616e6420696e666f726d20757320616e79206d6f6d656e742e2057652077696c6c20636f6e736964657220726571756573747320746f2072656d6f7665206c696e6b732062757420776520617265206e6f74206f626c69676174656420746f206f7220736f206f7220746f20726573706f6e6420746f20796f75206469726563746c792e3c2f703e0d0a3c703e576520646f206e6f7420656e7375726520746861742074686520696e666f726d6174696f6e206f6e2074686973207765627369746520697320636f72726563742c20776520646f206e6f742077617272616e742069747320636f6d706c6574656e657373206f722061636375726163793b206e6f7220646f2077652070726f6d69736520746f20656e7375726520746861742074686520776562736974652072656d61696e7320617661696c61626c65206f72207468617420746865206d6174657269616c206f6e207468652077656273697465206973206b65707420757020746f20646174652e3c2f703e0d0a3c68343e3c7374726f6e673e446973636c61696d65723c2f7374726f6e673e3c2f68343e0d0a3c703e546f20746865206d6178696d756d20657874656e74207065726d6974746564206279206170706c696361626c65206c61772c207765206578636c75646520616c6c20726570726573656e746174696f6e732c2077617272616e7469657320616e6420636f6e646974696f6e732072656c6174696e6720746f206f7572207765627369746520616e642074686520757365206f66207468697320776562736974652e204e6f7468696e6720696e207468697320646973636c61696d65722077696c6c3a3c2f703e0d0a3c756c3e0d0a3c6c693e6c696d6974206f72206578636c756465206f7572206f7220796f7572206c696162696c69747920666f72206465617468206f7220706572736f6e616c20696e6a7572793b3c2f6c693e0d0a3c6c693e6c696d6974206f72206578636c756465206f7572206f7220796f7572206c696162696c69747920666f72206672617564206f72206672617564756c656e74206d6973726570726573656e746174696f6e3b3c2f6c693e0d0a3c6c693e6c696d697420616e79206f66206f7572206f7220796f7572206c696162696c697469657320696e20616e79207761792074686174206973206e6f74207065726d697474656420756e646572206170706c696361626c65206c61773b206f723c2f6c693e0d0a3c6c693e6578636c75646520616e79206f66206f7572206f7220796f7572206c696162696c69746965732074686174206d6179206e6f74206265206578636c7564656420756e646572206170706c696361626c65206c61772e3c2f6c693e0d0a3c2f756c3e0d0a3c703e546865206c696d69746174696f6e7320616e642070726f6869626974696f6e73206f66206c696162696c6974792073657420696e20746869732053656374696f6e20616e6420656c7365776865726520696e207468697320646973636c61696d65723a2028612920617265207375626a65637420746f2074686520707265636564696e67207061726167726170683b20616e642028622920676f7665726e20616c6c206c696162696c69746965732061726973696e6720756e6465722074686520646973636c61696d65722c20696e636c7564696e67206c696162696c69746965732061726973696e6720696e20636f6e74726163742c20696e20746f727420616e6420666f7220627265616368206f66207374617475746f727920647574792e3c2f703e0d0a3c703e4173206c6f6e6720617320746865207765627369746520616e642074686520696e666f726d6174696f6e20616e64207365727669636573206f6e207468652077656273697465206172652070726f76696465642066726565206f66206368617267652c2077652077696c6c206e6f74206265206c6961626c6520666f7220616e79206c6f7373206f722064616d616765206f6620616e79206e61747572652e3c2f703e, NULL, NULL, '2023-08-19 23:52:10', '2024-05-23 04:53:47'),
(46, 21, 21, 'الأحكام والشروط', 'الأحكام-والشروط', 0x3c703ed985d8b1d8add8a8d98bd8a720d8a8d98320d981d98a20d982d8a7d8a6d985d8a920d8a7d984d8b3d98ad8a7d8b1d8a7d8aa213c2f703e0d0a3c703ed8aad8add8afd8af20d987d8b0d98720d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d98520d8a7d984d982d988d8a7d8b9d8af20d988d8a7d984d984d988d8a7d8a6d8ad20d8a7d984d8aed8a7d8b5d8a920d8a8d8a7d8b3d8aad8aed8afd8a7d98520d985d988d982d8b920d8a7d984d988d98ad8a820d8a7d984d8aed8a7d8b520d8a8d982d8a7d8a6d985d8a920d8a7d984d8b3d98ad8a7d8b1d8a7d8aa2e3c2f703e0d0a3c703ed985d98620d8aed984d8a7d98420d8a7d984d988d8b5d988d98420d8a5d984d98920d987d8b0d8a720d8a7d984d985d988d982d8b920d88c20d986d981d8aad8b1d8b620d8a3d986d98320d8aad982d8a8d98420d987d8b0d98720d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d9852e20d984d8a720d8aad8b3d8aad985d8b120d981d98a20d8a7d8b3d8aad8aed8afd8a7d98520d982d8a7d8a6d985d8a920d8a7d984d8b3d98ad8a7d8b1d8a7d8aa20d8a5d8b0d8a720d983d986d8aa20d984d8a720d8aad988d8a7d981d98220d8b9d984d98920d8a3d8aed8b020d8acd985d98ad8b920d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d98520d8a7d984d985d8b0d983d988d8b1d8a920d981d98a20d987d8b0d98720d8a7d984d8b5d981d8add8a92e3c2f703e0d0a3c703ed8aad986d8b7d8a8d98220d8a7d984d985d8b5d8b7d984d8add8a7d8aa20d8a7d984d8aad8a7d984d98ad8a920d8b9d984d98920d987d8b0d98720d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d98520d988d8a8d98ad8a7d98620d8a7d984d8aed8b5d988d8b5d98ad8a920d988d8a5d8b4d8b9d8a7d8b120d8a5d8aed984d8a7d8a120d8a7d984d985d8b3d8a4d988d984d98ad8a920d988d8acd985d98ad8b920d8a7d984d8a7d8aad981d8a7d982d98ad8a7d8aa3a20d98ad8b4d98ad8b120d985d8b5d8b7d984d8ad2022d8a7d984d8b9d985d98ad9842220d9882022d8a3d986d8aa2220d9882022d8a7d984d8aed8a7d8b520d8a8d9832220d8a5d984d98ad98320d88c20d988d8a7d984d8b4d8aed8b520d8a7d984d8b0d98a20d98ad982d988d98520d8a8d8aad8b3d8acd98ad98420d8a7d984d8afd8aed988d98420d8a5d984d98920d987d8b0d8a720d8a7d984d985d988d982d8b920d8a7d984d8a5d984d983d8aad8b1d988d986d98a20d988d985d8aad988d8a7d981d98220d985d8b920d8b4d8b1d988d8b720d988d8a3d8add983d8a7d98520d8a7d984d8b4d8b1d983d8a92e20d8aad8b4d98ad8b12022d8a7d984d8b4d8b1d983d8a92220d9882022d8a3d986d981d8b3d986d8a72220d9882022d986d8add9862220d9882022d984d986d8a72220d9882022d986d8add9862220d8a5d984d98920d8b4d8b1d983d8aad986d8a72e20d98ad8b4d98ad8b12022d8a7d984d8b7d8b1d9812220d8a3d9882022d8a7d984d8a3d8b7d8b1d8a7d9812220d8a3d9882022d986d8add9862220d8a5d984d98920d983d98420d985d98620d8a7d984d8b9d985d98ad98420d988d8a3d986d981d8b3d986d8a72e20d8aad8b4d98ad8b120d8acd985d98ad8b920d8a7d984d8b4d8b1d988d8b720d8a5d984d98920d8a7d984d8b9d8b1d8b620d988d8a7d984d982d8a8d988d98420d988d8a7d984d986d8b8d8b120d981d98a20d8a7d984d8afd981d8b920d8a7d984d984d8a7d8b2d98520d984d984d8a7d8b6d8b7d984d8a7d8b920d8a8d8b9d985d984d98ad8a920d985d8b3d8a7d8b9d8afd8aad986d8a720d984d984d8b9d985d98ad98420d8a8d8a7d984d8b7d8b1d98ad982d8a920d8a7d984d8a3d986d8b3d8a820d984d984d8bad8b1d8b620d8a7d984d8b5d8b1d98ad8ad20d8a7d984d985d8aad985d8abd98420d981d98a20d8aad984d8a8d98ad8a920d8a7d8add8aad98ad8a7d8acd8a7d8aa20d8a7d984d8b9d985d98ad98420d981d98ad985d8a720d98ad8aad8b9d984d98220d8a8d8aad988d981d98ad8b120d8aed8afd985d8a7d8aa20d8a7d984d8b4d8b1d983d8a920d8a7d984d985d8b9d984d986d8a920d88c20d988d981d982d98bd8a720d984d98020d988d8aad8aed8b6d8b920d984d984d982d8a7d986d988d98620d8a7d984d8b3d8a7d8a6d8af20d985d986d8a72e20d8a3d98a20d8a7d8b3d8aad8aed8afd8a7d98520d984d984d985d8b5d8b7d984d8add8a7d8aa20d8a7d984d985d8b0d983d988d8b1d8a920d8a3d8b9d984d8a7d98720d8a3d98820d8bad98ad8b1d987d8a720d985d98620d8a7d984d983d984d985d8a7d8aa20d981d98a20d8b5d98ad8bad8a920d8a7d984d985d981d8b1d8af20d988d8a7d984d8acd985d8b920d988202f20d8a3d98820d987d988202f20d987d98a20d8a3d98820d987d98520d88c20d98ad8aad98520d8a7d8b9d8aad8a8d8a7d8b1d98720d982d8a7d8a8d984d8a7d98b20d984d984d8aad8a8d8a7d8afd98420d988d8a8d8a7d984d8aad8a7d984d98a20d98ad8b4d98ad8b120d8a5d984d98920d986d981d8b3d9872e3c2f703e0d0a3c703ed8a8d8b3d983d988d98ad8aa3c2f703e0d0a3c703ed986d8add98620d986d988d8b8d98120d8a7d8b3d8aad8aed8afd8a7d98520d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b72e20d985d98620d8aed984d8a7d98420d8a7d984d988d8b5d988d98420d8a5d984d98920d982d8a7d8a6d985d8a920d8a7d984d8b3d98ad8a7d8b1d8a7d8aa20d88c20d981d8a5d986d98320d8aad988d8a7d981d98220d8b9d984d98920d8a7d8b3d8aad8aed8afd8a7d98520d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b720d8a8d8a7d984d8a7d8aad981d8a7d98220d985d8b920d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d982d8a7d8a6d985d8a920d8a7d984d8b3d98ad8a7d8b1d8a7d8aa2e3c2f703e0d0a3c703ed8aad8b3d8aad8aed8afd98520d985d8b9d8b8d98520d985d988d8a7d982d8b920d8a7d984d988d98ad8a820d8a7d984d8aad981d8a7d8b9d984d98ad8a920d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b720d984d984d8b3d985d8a7d8ad20d984d986d8a720d8a8d8a7d8b3d8aad8b1d8afd8a7d8af20d8aad981d8a7d8b5d98ad98420d8a7d984d985d8b3d8aad8aed8afd98520d984d983d98420d8b2d98ad8a7d8b1d8a92e20d98ad8b3d8aad8aed8afd98520d985d988d982d8b9d986d8a720d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b720d984d8aad985d983d98ad98620d988d8b8d8a7d8a6d98120d985d986d8a7d8b7d98220d985d8b9d98ad986d8a920d984d8aad8b3d987d98ad98420d8b2d98ad8a7d8b1d8a920d8a7d984d8a3d8b4d8aed8a7d8b520d984d985d988d982d8b9d986d8a72e20d982d8af20d98ad8b3d8aad8aed8afd98520d8a8d8b9d8b620d8a7d984d8b4d8b1d983d8a7d8a120d8a7d984d8aad8a7d8a8d8b9d98ad986202f20d8a7d984d985d8b9d984d986d98ad98620d8a3d98ad8b6d98bd8a720d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b72e3c2f703e, NULL, NULL, '2023-08-19 23:52:10', '2023-08-19 23:52:10'),
(47, 20, 22, 'Privacy Policy', 'privacy-policy', 0x3c703e41742042756c697374696f2c2061636365737369626c652066726f6d203c6120687265663d2268747470733a2f2f636f646563616e796f6e2e6b7265617469766465762e636f6d2f6361726c697374696e67223e68747470733a2f2f636f646563616e796f6e2e6b7265617469766465762e636f6d2f62756c697374696f3c2f613e2c206f6e65206f66206f7572206d61696e207072696f726974696573206973207468652070726976616379206f66206f75722076697369746f72732e2054686973205072697661637920506f6c69637920646f63756d656e7420636f6e7461696e73207479706573206f6620696e666f726d6174696f6e207468617420697320636f6c6c656374656420616e64207265636f726465642062792042756c697374696f20616e6420686f77207765207573652069742e3c2f703e0d0a3c703e496620796f752068617665206164646974696f6e616c207175657374696f6e73206f722072657175697265206d6f726520696e666f726d6174696f6e2061626f7574206f7572205072697661637920506f6c6963792c20646f206e6f7420686573697461746520746f20636f6e746163742075732e3c2f703e0d0a3c703e54686973205072697661637920506f6c696379206170706c696573206f6e6c7920746f206f7572206f6e6c696e65206163746976697469657320616e642069732076616c696420666f722076697369746f727320746f206f757220776562736974652077697468207265676172647320746f2074686520696e666f726d6174696f6e207468617420746865792073686172656420616e642f6f7220636f6c6c65637420696e2042756c697374696f2e205468697320706f6c696379206973206e6f74206170706c696361626c6520746f20616e7920696e666f726d6174696f6e20636f6c6c6563746564206f66666c696e65206f7220766961206368616e6e656c73206f74686572207468616e207468697320776562736974652e3c2f703e0d0a3c703e3c7374726f6e673e436f6e73656e743c2f7374726f6e673e3c2f703e0d0a3c703e4279207573696e67206f757220776562736974652c20796f752068657265627920636f6e73656e7420746f206f7572205072697661637920506f6c69637920616e6420616772656520746f20697473207465726d732e3c2f703e0d0a3c703e3c7374726f6e673e496e666f726d6174696f6e20576520436f6c6c6563743c2f7374726f6e673e3c2f703e0d0a3c703e54686520706572736f6e616c20696e666f726d6174696f6e207468617420796f75206172652061736b656420746f2070726f766964652c20616e642074686520726561736f6e732077687920796f75206172652061736b656420746f2070726f766964652069742c2077696c6c206265206d61646520636c65617220746f20796f752061742074686520706f696e742077652061736b20796f7520746f2070726f7669646520796f757220706572736f6e616c20696e666f726d6174696f6e2e3c2f703e0d0a3c703e496620796f7520636f6e74616374207573206469726563746c792c207765206d61792072656365697665206164646974696f6e616c20696e666f726d6174696f6e2061626f757420796f75207375636820617320796f7572206e616d652c20656d61696c20616464726573732c2070686f6e65206e756d6265722c2074686520636f6e74656e7473206f6620746865206d65737361676520616e642f6f72206174746163686d656e747320796f75206d61792073656e642075732c20616e6420616e79206f7468657220696e666f726d6174696f6e20796f75206d61792063686f6f736520746f2070726f766964652e3c2f703e0d0a3c703e5768656e20796f7520726567697374657220666f7220616e206163636f756e742c207765206d61792061736b20666f7220796f757220636f6e7461637420696e666f726d6174696f6e2c20696e636c7564696e67206974656d732073756368206173206e616d652c20636f6d70616e79206e616d652c20616464726573732c20656d61696c20616464726573732c20616e642074656c6570686f6e65206e756d6265722e3c2f703e0d0a3c703e3c7374726f6e673e486f772057652055736520596f757220496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a3c703e5765207573652074686520696e666f726d6174696f6e20776520636f6c6c65637420696e20766172696f757320776179732c20696e636c7564696e6720746f3a3c2f703e0d0a3c756c3e0d0a3c6c693e50726f766964652c206f7065726174652c20616e64206d61696e7461696e206f757220776562736974653c2f6c693e0d0a3c6c693e496d70726f76652c20706572736f6e616c697a652c20616e6420657870616e64206f757220776562736974653c2f6c693e0d0a3c6c693e556e6465727374616e6420616e6420616e616c797a6520686f7720796f7520757365206f757220776562736974653c2f6c693e0d0a3c6c693e446576656c6f70206e65772070726f64756374732c2073657276696365732c2066656174757265732c20616e642066756e6374696f6e616c6974793c2f6c693e0d0a3c6c693e436f6d6d756e6963617465207769746820796f752c20656974686572206469726563746c79206f72207468726f756768206f6e65206f66206f757220706172746e6572732c20696e636c7564696e6720666f7220637573746f6d657220736572766963652c20746f2070726f7669646520796f752077697468207570646174657320616e64206f7468657220696e666f726d6174696f6e2072656c6174696e6720746f2074686520776562736974652c20616e6420666f72206d61726b6574696e6720616e642070726f6d6f74696f6e616c20707572706f7365733c2f6c693e0d0a3c6c693e53656e6420796f7520656d61696c733c2f6c693e0d0a3c6c693e46696e6420616e642070726576656e742066726175643c2f6c693e0d0a3c2f756c3e0d0a3c703e3c7374726f6e673e4c6f672046696c65733c2f7374726f6e673e3c2f703e0d0a3c703e42756c697374696f20666f6c6c6f77732061207374616e646172642070726f636564757265206f66207573696e67206c6f672066696c65732e2054686573652066696c6573206c6f672076697369746f7273207768656e20746865792076697369742077656273697465732e20416c6c20686f7374696e6720636f6d70616e69657320646f207468697320616e6420612070617274206f6620686f7374696e672073657276696365732720616e616c79746963732e2054686520696e666f726d6174696f6e20636f6c6c6563746564206279206c6f672066696c657320696e636c7564657320696e7465726e65742070726f746f636f6c2028495029206164647265737365732c2062726f7773657220747970652c20496e7465726e657420536572766963652050726f76696465722028495350292c206461746520616e642074696d65207374616d702c20726566657272696e672f657869742070616765732c20616e6420706f737369626c7920746865206e756d626572206f6620636c69636b732e20546865736520617265206e6f74206c696e6b656420746f20616e7920696e666f726d6174696f6e207468617420697320706572736f6e616c6c79206964656e7469666961626c652e2054686520707572706f7365206f662074686520696e666f726d6174696f6e20697320666f7220616e616c797a696e67207472656e64732c2061646d696e6973746572696e672074686520736974652c20747261636b696e6720757365727327206d6f76656d656e74206f6e2074686520776562736974652c20616e6420676174686572696e672064656d6f6772617068696320696e666f726d6174696f6e2e3c2f703e0d0a3c703e3c7374726f6e673e436f6f6b69657320616e642057656220426561636f6e733c2f7374726f6e673e3c2f703e0d0a3c703e4c696b6520616e79206f7468657220776562736974652c2042756c697374696f20757365732022636f6f6b696573222e20546865736520636f6f6b69657320617265207573656420746f2073746f726520696e666f726d6174696f6e20696e636c7564696e672076697369746f72732720707265666572656e6365732c20616e6420746865207061676573206f6e2074686520776562736974652074686174207468652076697369746f72206163636573736564206f7220766973697465642e2054686520696e666f726d6174696f6e206973207573656420746f206f7074696d697a65207468652075736572732720657870657269656e636520627920637573746f6d697a696e67206f757220776562207061676520636f6e74656e74206261736564206f6e2076697369746f7273272062726f77736572207479706520616e642f6f72206f7468657220696e666f726d6174696f6e2e3c2f703e0d0a3c703e3c7374726f6e673e476f6f676c6520446f75626c65436c69636b204441525420436f6f6b69653c2f7374726f6e673e3c2f703e0d0a3c703e476f6f676c65206973206f6e65206f6620612074686972642d70617274792076656e646f72206f6e206f757220736974652e20497420616c736f207573657320636f6f6b6965732c206b6e6f776e206173204441525420636f6f6b6965732c20746f2073657276652061647320746f206f757220736974652076697369746f72732062617365642075706f6e20746865697220766973697420746fc2a0616e64206f74686572207369746573206f6e2074686520696e7465726e65742e20486f77657665722c2076697369746f7273206d61792063686f6f736520746f206465636c696e6520746865207573653c2f703e, 'privacy policy', 'privacy policy', '2023-08-19 23:56:10', '2024-05-23 04:48:39'),
(48, 21, 22, 'سياسة الخصوصية', 'سياسة-الخصوصية', 0x3c703ed981d98a2042756c697374696fd88c20d8a7d984d8b0d98a20d98ad985d983d98620d8a7d984d988d8b5d988d98420d8a5d984d98ad98720d985d9862068747470733a2f2f636f646563616e796f6e2e6b7265617469766465762e636f6d2f62756c697374696fd88c20d8a5d8add8afd98920d8a3d988d984d988d98ad8a7d8aad986d8a720d8a7d984d8b1d8a6d98ad8b3d98ad8a920d987d98a20d8aed8b5d988d8b5d98ad8a920d8b2d988d8a7d8b1d986d8a72e20d8aad8add8aad988d98a20d988d8abd98ad982d8a920d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d987d8b0d98720d8b9d984d98920d8a3d986d988d8a7d8b920d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d98ad8aad98520d8acd985d8b9d987d8a720d988d8aad8b3d8acd98ad984d987d8a720d8a8d988d8a7d8b3d8b7d8a9203c7374726f6e673e42756c697374696f203c2f7374726f6e673ed988d983d98ad981d98ad8a920d8a7d8b3d8aad8aed8afd8a7d985d987d8a72e3c2f703e0d0a3c703ed8a5d8b0d8a720d983d8a7d986d8aa20d984d8afd98ad98320d8a3d8b3d8a6d984d8a920d8a5d8b6d8a7d981d98ad8a920d8a3d98820d983d986d8aa20d8a8d8add8a7d8acd8a920d8a5d984d98920d985d8b2d98ad8af20d985d98620d8a7d984d985d8b9d984d988d985d8a7d8aa20d8add988d98420d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d986d8a7d88c20d981d984d8a720d8aad8aad8b1d8afd8af20d981d98a20d8a7d984d8a7d8aad8b5d8a7d98420d8a8d986d8a72e3c2f703e0d0a3c703ed8aad986d8b7d8a8d98220d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d987d8b0d98720d981d982d8b720d8b9d984d98920d8a3d986d8b4d8b7d8aad986d8a720d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aa20d988d987d98a20d8b5d8a7d984d8add8a920d984d8b2d988d8a7d8b120d985d988d982d8b9d986d8a720d981d98ad985d8a720d98ad8aad8b9d984d98220d8a8d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d8b4d8a7d8b1d983d988d987d8a720d9882fd8a3d98820d8acd985d8b9d988d987d8a720d981d98a203c7374726f6e673e42756c697374696f3c2f7374726f6e673e2e20d984d8a720d8aad986d8b7d8a8d98220d987d8b0d98720d8a7d984d8b3d98ad8a7d8b3d8a920d8b9d984d98920d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d98ad8aad98520d8acd985d8b9d987d8a720d8afd988d98620d8a7d8aad8b5d8a7d98420d8a8d8a7d984d8a5d986d8aad8b1d986d8aa20d8a3d98820d8b9d8a8d8b120d982d986d988d8a7d8aa20d8a3d8aed8b1d98920d8bad98ad8b120d987d8b0d8a720d8a7d984d985d988d982d8b92e3c2f703e0d0a3c703ed8a5d8b0d8a720d983d8a7d986d8aa20d984d8afd98ad98320d8a3d8b3d8a6d984d8a920d8a5d8b6d8a7d981d98ad8a920d8a3d98820d983d986d8aa20d8a8d8add8a7d8acd8a920d8a5d984d98920d985d8b2d98ad8af20d985d98620d8a7d984d985d8b9d984d988d985d8a7d8aa20d8add988d98420d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d986d8a7d88c20d981d984d8a720d8aad8aad8b1d8afd8af20d981d98a20d8a7d984d8a7d8aad8b5d8a7d98420d8a8d986d8a72e3c2f703e0d0a3c703ed8aad986d8b7d8a8d98220d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d987d8b0d98720d981d982d8b720d8b9d984d98920d8a3d986d8b4d8b7d8aad986d8a720d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aa20d988d987d98a20d8b5d8a7d984d8add8a920d984d8b2d988d8a7d8b120d985d988d982d8b9d986d8a720d981d98ad985d8a720d98ad8aad8b9d984d98220d8a8d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d8b4d8a7d8b1d983d988d987d8a720d9882fd8a3d98820d8acd985d8b9d988d987d8a720d981d98a2042756c697374696f2e20d984d8a720d8aad986d8b7d8a8d98220d987d8b0d98720d8a7d984d8b3d98ad8a7d8b3d8a920d8b9d984d98920d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d98ad8aad98520d8acd985d8b9d987d8a720d8afd988d98620d8a7d8aad8b5d8a7d98420d8a8d8a7d984d8a5d986d8aad8b1d986d8aa20d8a3d98820d8b9d8a8d8b120d982d986d988d8a7d8aa20d8a3d8aed8b1d98920d8bad98ad8b120d987d8b0d8a720d8a7d984d985d988d982d8b92e3c2f703e0d0a3c703e3c7374726f6e673ed985d988d8a7d981d982d8a93c2f7374726f6e673e3c2f703e0d0a3c703ed8a8d8a7d8b3d8aad8aed8afd8a7d98520d985d988d982d8b9d986d8a7d88c20d981d8a5d986d98320d8aad988d8a7d981d98220d8a8d985d988d8acd8a8d98720d8b9d984d98920d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d986d8a720d988d8aad988d8a7d981d98220d8b9d984d98920d8b4d8b1d988d8b7d987d8a72e3c2f703e0d0a3c703e3c7374726f6e673ed8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d986d8acd985d8b9d987d8a73c2f7374726f6e673e3c2f703e0d0a3c703ed8b3d98ad8aad98520d8aad988d8b6d98ad8ad20d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8b4d8aed8b5d98ad8a920d8a7d984d8aad98a20d98ad98fd8b7d984d8a820d985d986d98320d8aad982d8afd98ad985d987d8a7d88c20d988d8a3d8b3d8a8d8a7d8a820d985d8b7d8a7d984d8a8d8aad98320d8a8d8aad982d8afd98ad985d987d8a7d88c20d984d98320d8b9d986d8afd985d8a720d986d8b7d984d8a820d985d986d98320d8aad982d8afd98ad98520d985d8b9d984d988d985d8a7d8aad98320d8a7d984d8b4d8aed8b5d98ad8a92e3c2f703e0d0a3c703ed8a5d8b0d8a720d8a7d8aad8b5d984d8aa20d8a8d986d8a720d985d8a8d8a7d8b4d8b1d8a9d88c20d981d982d8af20d986d8aad984d982d98920d985d8b9d984d988d985d8a7d8aa20d8a5d8b6d8a7d981d98ad8a920d8b9d986d98320d985d8abd98420d8a7d8b3d985d98320d988d8b9d986d988d8a7d98620d8a8d8b1d98ad8afd98320d8a7d984d8a5d984d983d8aad8b1d988d986d98a20d988d8b1d982d98520d987d8a7d8aad981d98320d988d985d8add8aad988d98ad8a7d8aa20d8a7d984d8b1d8b3d8a7d984d8a920d9882fd8a3d98820d8a7d984d985d8b1d981d982d8a7d8aa20d8a7d984d8aad98a20d982d8af20d8aad8b1d8b3d984d987d8a720d8a5d984d98ad986d8a7d88c20d988d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d8a3d8aed8b1d98920d982d8af20d8aad8aed8aad8a7d8b120d8aad982d8afd98ad985d987d8a72e3c2f703e0d0a3c703ed8b9d986d8afd985d8a720d8aad982d988d98520d8a8d8a7d984d8aad8b3d8acd98ad98420d984d984d8add8b5d988d98420d8b9d984d98920d8add8b3d8a7d8a8d88c20d982d8af20d986d8b7d984d8a820d985d8b9d984d988d985d8a7d8aa20d8a7d984d8a7d8aad8b5d8a7d98420d8a7d984d8aed8a7d8b5d8a920d8a8d983d88c20d8a8d985d8a720d981d98a20d8b0d984d98320d8b9d986d8a7d8b5d8b120d985d8abd98420d8a7d984d8a7d8b3d98520d988d8a7d8b3d98520d8a7d984d8b4d8b1d983d8a920d988d8a7d984d8b9d986d988d8a7d98620d988d8b9d986d988d8a7d98620d8a7d984d8a8d8b1d98ad8af20d8a7d984d8a5d984d983d8aad8b1d988d986d98a20d988d8b1d982d98520d8a7d984d987d8a7d8aad9812e3c2f703e0d0a3c703e3c7374726f6e673ed983d98ad98120d986d8b3d8aad8aed8afd98520d985d8b9d984d988d985d8a7d8aad9833c2f7374726f6e673e3c2f703e0d0a3c703ed986d8add98620d986d8b3d8aad8aed8afd98520d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d986d8acd985d8b9d987d8a720d8a8d8b7d8b1d98220d985d8aed8aad984d981d8a9d88c20d8a8d985d8a720d981d98a20d8b0d984d9833a3c2f703e0d0a3c756c3e0d0a3c6c693ed8aad988d981d98ad8b120d988d8aad8b4d8bad98ad98420d988d8b5d98ad8a7d986d8a920d985d988d982d8b9d986d8a73c2f6c693e0d0a3c6c693ed8aad988d981d98ad8b120d988d8aad8b4d8bad98ad98420d988d8b5d98ad8a7d986d8a920d985d988d982d8b9d986d8a73c2f6c693e0d0a3c6c693ed8aad988d981d98ad8b120d988d8aad8b4d8bad98ad98420d988d8b5d98ad8a7d986d8a920d985d988d982d8b9d986d8a73c2f6c693e0d0a3c6c693ed8aad988d981d98ad8b120d988d8aad8b4d8bad98ad98420d988d8b5d98ad8a7d986d8a920d985d988d982d8b9d986d8a73c2f6c693e0d0a3c6c693ed8aad988d981d98ad8b120d988d8aad8b4d8bad98ad98420d988d8b5d98ad8a7d986d8a920d985d988d982d8b9d986d8a7d8aad988d981d98ad8b120d988d8aad8b4d8bad98ad98420d988d8b5d98ad8a7d986d8a920d985d988d982d8b9d986d8a73c2f6c693e0d0a3c6c693ed8aad988d981d98ad8b120d988d8aad8b4d8bad98ad98420d988d8b5d98ad8a7d986d8a920d985d988d982d8b9d986d8a73c2f6c693e0d0a3c6c693ed8aad988d981d98ad8b120d988d8aad8b4d8bad98ad98420d988d8b5d98ad8a7d986d8a920d985d988d982d8b9d986d8a73c2f6c693e0d0a3c2f756c3e0d0a3c703e3c7374726f6e673ed985d984d981d8a7d8aa20d8a7d984d8b3d8acd9843c2f7374726f6e673e3c2f703e0d0a3c703ed98ad8aad8a8d8b92042756c697374696f20d8a7d984d8a5d8acd8b1d8a7d8a120d8a7d984d982d98ad8a7d8b3d98a20d984d8a7d8b3d8aad8aed8afd8a7d98520d985d984d981d8a7d8aa20d8a7d984d8b3d8acd9842e20d8aad982d988d98520d987d8b0d98720d8a7d984d985d984d981d8a7d8aa20d8a8d8aad8b3d8acd98ad98420d8a7d984d8b2d988d8a7d8b120d8b9d986d8af20d8b2d98ad8a7d8b1d8aad987d98520d984d985d988d8a7d982d8b920d8a7d984d988d98ad8a82e20d8acd985d98ad8b920d8b4d8b1d983d8a7d8aa20d8a7d984d8a7d8b3d8aad8b6d8a7d981d8a920d8aad981d8b9d98420d8b0d984d98320d988d8acd8b2d8a120d985d98620d8aad8add984d98ad984d8a7d8aa20d8aed8afd985d8a7d8aa20d8a7d984d8a7d8b3d8aad8b6d8a7d981d8a92e20d8aad8aad8b6d985d98620d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d8aad98520d8acd985d8b9d987d8a720d8a8d988d8a7d8b3d8b7d8a920d985d984d981d8a7d8aa20d8a7d984d8b3d8acd98420d8b9d986d8a7d988d98ad98620d8a8d8b1d988d8aad988d983d988d98420d8a7d984d8a5d986d8aad8b1d986d8aa2028495029d88c20d988d986d988d8b920d8a7d984d985d8aad8b5d981d8add88c20d988d985d988d981d8b120d8aed8afd985d8a920d8a7d984d8a5d986d8aad8b1d986d8aa202849535029d88c20d988d8aed8aad98520d8a7d984d8aad8a7d8b1d98ad8ae20d988d8a7d984d988d982d8aad88c20d988d8b5d981d8add8a7d8aa20d8a7d984d8a5d8add8a7d984d8a92fd8a7d984d8aed8b1d988d8acd88c20d988d8b1d8a8d985d8a720d8b9d8afd8af20d8a7d984d986d982d8b1d8a7d8aa2e20d988d984d8a720d8aad8b1d8aad8a8d8b720d987d8b0d98720d8a8d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d8aad8add8afd8af20d987d988d98ad8aad98320d8a7d984d8b4d8aed8b5d98ad8a92e20d8a7d984d8bad8b1d8b620d985d98620d8a7d984d985d8b9d984d988d985d8a7d8aa20d987d98820d8aad8add984d98ad98420d8a7d984d8a7d8aad8acd8a7d987d8a7d8aa20d988d8a5d8afd8a7d8b1d8a920d8a7d984d985d988d982d8b920d988d8aad8aad8a8d8b920d8add8b1d983d8a920d8a7d984d985d8b3d8aad8aed8afd985d98ad98620d8b9d984d98920d8a7d984d985d988d982d8b920d988d8acd985d8b920d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8afd98ad985d988d8bad8b1d8a7d981d98ad8a92e3c2f703e0d0a3c703ec2a03c2f703e, NULL, NULL, '2023-08-19 23:56:10', '2024-05-23 04:53:13');

-- --------------------------------------------------------

--
-- Table structure for table `page_headings`
--

CREATE TABLE `page_headings` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `listing_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `blog_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `contact_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `products_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `error_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `pricing_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `faq_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `forget_password_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_forget_password_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `login_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `signup_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_login_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_signup_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cart_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `checkout_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `about_us_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `wishlist_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `dashboard_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `orders_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `support_ticket_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `support_ticket_create_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `change_password_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `edit_profile_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `page_headings`
--

INSERT INTO `page_headings` (`id`, `language_id`, `listing_page_title`, `blog_page_title`, `contact_page_title`, `products_page_title`, `error_page_title`, `pricing_page_title`, `faq_page_title`, `forget_password_page_title`, `vendor_forget_password_page_title`, `login_page_title`, `signup_page_title`, `vendor_login_page_title`, `vendor_signup_page_title`, `cart_page_title`, `checkout_page_title`, `vendor_page_title`, `about_us_title`, `wishlist_page_title`, `dashboard_page_title`, `orders_page_title`, `support_ticket_page_title`, `support_ticket_create_page_title`, `change_password_page_title`, `edit_profile_page_title`, `created_at`, `updated_at`) VALUES
(9, 20, 'Listings', 'Blog', 'Contact', 'Products', '404', 'Pricing', 'FAQ', 'Forget Password', 'Forget Password', 'Login', 'Signup', 'Vendor Login', 'Vendor Signup', 'Cart', 'Checkout', 'Vendors', 'About Us', 'Wishlists', 'Dashboard', 'Orders', 'Support Tickets', 'Create a Support Ticket', 'Change Password', 'Edit Profile', '2023-08-27 01:23:22', '2024-01-01 04:49:59'),
(10, 21, 'القوائم', 'مدونة', 'اتصال', 'منتجات', '404', 'التسعير', 'التعليمات', 'نسيت كلمة المرور', 'نسيت كلمة المرور', 'تسجيل الدخول', 'اشتراك', 'تسجيل دخول البائع', 'تسجيل البائع', 'عربة التسوق', 'الدفع', 'الباعة', 'معلومات عنا', 'قوائم الامنيات', 'لوحة القيادة', 'طلبات', 'تذاكر الدعم الفني', 'إنشاء تذكرة دعم', 'تغيير كلمة المرور', 'تعديل الملف الشخصي', '2024-02-06 02:49:35', '2024-02-06 02:49:35');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` bigint NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `created_at`) VALUES
(8, 'fahadahmadshemul@gmail.com', 'ktTRmy3rfZBfonez2MM80l9jZvEwYbaS', NULL),
(9, 'fahadahmadshemul@gmail.com', 'LqksSbBPKGXCNF3hJ9a5Ghri3aX5973G', NULL),
(11, 'divaf87260@canvect.com', '$2y$10$SRL7m.QMdyayL5SFe8awLeL.CBBj0F.uOKmXUMycAxYI6eOut5UKW', '2025-11-25 01:06:09'),
(12, 'xisex41713@bablace.com', '$2y$10$.hZ2zgB0UimYcM5v.Qs3V.PNnebEUkFl01uDQaU6Dg4nUY5qIfO3i', '2025-11-25 03:52:47');

-- --------------------------------------------------------

--
-- Table structure for table `payment_invoices`
--

CREATE TABLE `payment_invoices` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `InvoiceId` bigint UNSIGNED NOT NULL,
  `InvoiceStatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `InvoiceValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `InvoiceDisplayValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TransactionId` bigint UNSIGNED NOT NULL,
  `TransactionStatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `PaymentGateway` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `PaymentId` bigint UNSIGNED NOT NULL,
  `CardNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 12, 'unknown-device', 'c8006acf0bb4d6a329ad9a59532a63f568418e25866a64fcb5e8ff85cadae412', '[\"*\"]', NULL, NULL, '2025-11-18 04:31:47', '2025-11-18 04:31:47'),
(2, 'App\\Models\\User', 12, 'unknown-device', '4c9fc374d335fa93bd3a5727dea14cf0243bbbb2a51e65d9b97d5e68a8ceabd5', '[\"*\"]', NULL, NULL, '2025-11-18 04:43:34', '2025-11-18 04:43:34'),
(3, 'App\\Models\\User', 12, 'unknown-device', 'eb5425f744d5864f276d379a60c3cea1416f05736f2bc90d26005f03471a8e4b', '[\"*\"]', NULL, NULL, '2025-11-18 04:45:48', '2025-11-18 04:45:48'),
(4, 'App\\Models\\User', 12, 'unknown-device', 'd9248005bf545bba0b63be991488fc054980d6435ed18308f1dc1d34e017cbea', '[\"*\"]', NULL, NULL, '2025-11-18 23:06:39', '2025-11-18 23:06:39'),
(5, 'App\\Models\\User', 12, 'unknown-device', 'ecd6e5802e44310da2847f0ffc343e67a2c2e94aafe141074d048ee619c5a5fe', '[\"*\"]', NULL, NULL, '2025-11-19 00:22:19', '2025-11-19 00:22:19'),
(7, 'App\\Models\\User', 12, 'unknown-device', '16de36e885d5b0db9f7769475cc17cb67513721a9525d6f4697b00c7f99c87e3', '[\"*\"]', '2025-11-24 02:19:51', NULL, '2025-11-19 05:24:26', '2025-11-24 02:19:51'),
(8, 'App\\Models\\User', 12, 'unknown-device', 'dfbdac84def64c35e7e0e33f4d79ebfe2a77eaffe41d4a640e504fb5c39aac79', '[\"*\"]', '2025-11-24 02:09:58', NULL, '2025-11-19 22:21:12', '2025-11-24 02:09:58'),
(9, 'App\\Models\\User', 12, 'unknown-device', '22fa453ca7035f298cb0074be66fd616057836a46636503e0e02b7de1a82d9d0', '[\"*\"]', NULL, NULL, '2025-11-23 22:54:42', '2025-11-23 22:54:42'),
(10, 'App\\Models\\User', 12, 'unknown-device', '6b9268577ace09830b67ee9b86a39e562f3b6ae6b597d118215005187320c591', '[\"*\"]', '2025-11-23 23:33:27', NULL, '2025-11-23 23:13:05', '2025-11-23 23:33:27'),
(11, 'App\\Models\\User', 12, 'unknown-device', '6fdfa599d1f3cebcdcbbcb9581faeccaa666d649162cc6b06427103ac46d06ff', '[\"*\"]', '2025-11-24 03:41:23', NULL, '2025-11-24 01:44:57', '2025-11-24 03:41:23'),
(12, 'App\\Models\\User', 12, 'unknown-device', '81b45c2b07bb4f0f96c1c52bc78ed1123f63e671a75ee6863e2dbca00eb2494d', '[\"*\"]', NULL, NULL, '2025-11-24 02:08:17', '2025-11-24 02:08:17'),
(13, 'App\\Models\\User', 12, 'unknown-device', 'a6caf8ce5ff380fe5bb2e346ff0ee0c1e8c545ed0edb7771d0080abf92f63c23', '[\"*\"]', NULL, NULL, '2025-11-24 02:10:03', '2025-11-24 02:10:03'),
(14, 'App\\Models\\User', 12, 'unknown-device', 'de627959d542d602018de7f5381ca8a5c33dfa14fae1d407fdd3975e64eb690b', '[\"*\"]', NULL, NULL, '2025-11-24 02:19:42', '2025-11-24 02:19:42'),
(15, 'App\\Models\\User', 12, 'unknown-device', '401499b2e42b81477a9e02d2b9d11a50122a0a5c120acc1a64405a3287156abe', '[\"*\"]', '2025-11-24 03:38:18', NULL, '2025-11-24 03:27:09', '2025-11-24 03:38:18'),
(16, 'App\\Models\\User', 12, 'unknown-device', 'bc9679c9031f82b4285edd6e18f18ee8455cc6b7aea1ff13fac22e6764f396bc', '[\"*\"]', '2025-11-25 00:21:32', NULL, '2025-11-24 22:58:16', '2025-11-25 00:21:32'),
(17, 'App\\Models\\User', 12, 'unknown-device', '3ec74aa08015eddfd5508de6105d2bca210b604157fe0fe66048bea9b1aeb2b3', '[\"*\"]', '2025-11-26 02:05:59', NULL, '2025-11-24 23:59:11', '2025-11-26 02:05:59'),
(18, 'App\\Models\\User', 12, 'unknown-device', '0bc68b19595bd57773e871f398e40e90cbb836201e16079e1254c2aa94f5f6c6', '[\"*\"]', NULL, NULL, '2025-11-26 01:57:38', '2025-11-26 01:57:38'),
(19, 'App\\Models\\User', 12, 'unknown-device', '65ea6ce29a033da476bacbc0a56e547bfc0fdf0d886249c9f4167e2aeec9fb06', '[\"*\"]', '2025-12-06 22:55:05', NULL, '2025-12-06 22:53:17', '2025-12-06 22:55:05'),
(20, 'App\\Models\\User', 12, 'unknown-device', '45102cf62127d5a58c4e010847beb289a9e26eaa738217f5d7bf9d072009a7a9', '[\"*\"]', '2025-12-07 22:01:17', NULL, '2025-12-07 22:00:59', '2025-12-07 22:01:17'),
(21, 'App\\Models\\User', 12, 'unknown-device', 'fadbfe50d37cdb98319b1679096d077e691edd152fc845c732024698958e4574', '[\"*\"]', '2025-12-12 21:47:01', NULL, '2025-12-12 21:44:16', '2025-12-12 21:47:01'),
(22, 'App\\Models\\Vendor', 204, 'vendor-token', '185e2f7a3fd8da3ad869dbd5c9f3bf392f08c214f0f7b1ab5062048db25d4e06', '[\"*\"]', NULL, NULL, '2026-04-05 01:01:00', '2026-04-05 01:01:00'),
(23, 'App\\Models\\Vendor', 204, 'vendor-token', '3d47034dc4c9dc7b7d1c168d3401331e70e4317ab66159329d9d6726e63c3bc1', '[\"*\"]', NULL, NULL, '2026-04-05 01:02:12', '2026-04-05 01:02:12'),
(24, 'App\\Models\\Vendor', 204, 'vendor-token', 'a6080342a4733eeab84b86deff1f5d437b8ac11bf3ebd79149a3e1b438ae6404', '[\"*\"]', NULL, NULL, '2026-04-05 01:02:42', '2026-04-05 01:02:42'),
(25, 'App\\Models\\Vendor', 204, 'vendor-token', 'e21cd83554ed1e9b0b2c3188736bed62068378a903b8a6cadeafad4c4e6f848d', '[\"*\"]', NULL, NULL, '2026-04-05 01:02:52', '2026-04-05 01:02:52'),
(26, 'App\\Models\\Vendor', 204, 'vendor-token', '6af46222b7de737fbc470ab91cd21e5d802a247e044cdccc32ca99d659e1f23d', '[\"*\"]', '2026-04-05 03:49:48', NULL, '2026-04-05 01:03:46', '2026-04-05 03:49:48'),
(27, 'App\\Models\\Vendor', 204, 'vendor-token', '7d78e15c4572c85f74f626006559e62dc223bd6e1736bf02f2fa7d60d2fce637', '[\"*\"]', NULL, NULL, '2026-04-05 01:04:49', '2026-04-05 01:04:49'),
(28, 'App\\Models\\Vendor', 204, 'vendor-token', 'bd5c0e22ff1bd1fefe31d48399db741f75e5d4c0e8f780cc188225fa1e0ba6e0', '[\"*\"]', NULL, NULL, '2026-04-05 01:05:04', '2026-04-05 01:05:04'),
(29, 'App\\Models\\Vendor', 204, 'vendor-token', '1763e6f18dc389f9c9589fa866b20933e653d2e4b0fbab449af98ecce2f0201a', '[\"*\"]', NULL, NULL, '2026-04-05 01:08:10', '2026-04-05 01:08:10'),
(30, 'App\\Models\\Vendor', 204, 'vendor-token', 'ad5ee75888e02a3c5c6339cded0513bbc6eb3529cf1e1679269a291d4de1b495', '[\"*\"]', NULL, NULL, '2026-04-05 01:09:22', '2026-04-05 01:09:22'),
(31, 'App\\Models\\Vendor', 204, 'vendor-token', '80cdbf199febc65979f057e77edda170a0813874cb99af943a4a80786c260a88', '[\"*\"]', '2026-04-05 01:37:27', NULL, '2026-04-05 01:12:05', '2026-04-05 01:37:27'),
(32, 'App\\Models\\Vendor', 204, 'vendor-token', '5616a3666bc7a148303517443b103224c6a67a91d8d4eb0dd3902acf69240e06', '[\"*\"]', NULL, NULL, '2026-04-05 02:42:19', '2026-04-05 02:42:19'),
(33, 'App\\Models\\Vendor', 204, 'vendor-token', 'ed8944f9aed3c86a2d58a896672d4adc66964c82f1158701c34299c989c9c491', '[\"*\"]', '2026-04-05 02:44:13', NULL, '2026-04-05 02:44:11', '2026-04-05 02:44:13'),
(34, 'App\\Models\\Vendor', 204, 'vendor-token', 'ef7ffa52b94cc05fb3fbee2acc6500096506d4f6f790bcc89f2cccac215086de', '[\"*\"]', '2026-04-05 03:50:37', NULL, '2026-04-05 02:45:03', '2026-04-05 03:50:37'),
(35, 'App\\Models\\Vendor', 204, 'vendor-token', 'f8bf537cfbe80346751a5c28b9e88ddbdd83b7ca12843325889f9385fb67a5a4', '[\"*\"]', '2026-04-05 23:30:41', NULL, '2026-04-05 23:10:45', '2026-04-05 23:30:41'),
(36, 'App\\Models\\Vendor', 204, 'vendor-token', 'e5f69d9be7d0d792301eaa3b65e5e3c230b5f0951b0cd2206816fe155a04037b', '[\"*\"]', NULL, NULL, '2026-04-06 01:52:32', '2026-04-06 01:52:32'),
(37, 'App\\Models\\Vendor', 204, 'vendor-token', '50338d181a66afe1b429f21f2f53dbcf0b80562e6d84157fd2935ba5721007ef', '[\"*\"]', '2026-04-06 05:09:49', NULL, '2026-04-06 01:54:23', '2026-04-06 05:09:49'),
(38, 'App\\Models\\Vendor', 204, 'vendor-token', '0993a4bbf8421971bf58aa5af91519164f21402aa2b4c4248b6d5c027cd78a42', '[\"*\"]', '2026-04-07 05:06:34', NULL, '2026-04-06 02:10:08', '2026-04-07 05:06:34'),
(39, 'App\\Models\\Vendor', 204, 'vendor-token', '4556f95238f6383e1df52e731eec6e8abafc3816fcd0833ac4ca9f8dffc38808', '[\"*\"]', '2026-04-07 00:32:58', NULL, '2026-04-06 22:53:34', '2026-04-07 00:32:58'),
(40, 'App\\Models\\Vendor', 204, 'vendor-token', '81b5be7432e4bbf840b478c4e61651018983f81ec1ba3d20cb12b7178e4f6908', '[\"*\"]', '2026-04-07 00:05:44', NULL, '2026-04-06 22:55:05', '2026-04-07 00:05:44'),
(41, 'App\\Models\\Vendor', 204, 'vendor-token', 'a1e59eae1f9031c276878e2e92a9d3500d0a775e94957dbaf5cee4ee0ad56272', '[\"*\"]', '2026-04-07 01:06:11', NULL, '2026-04-07 00:31:03', '2026-04-07 01:06:11'),
(42, 'App\\Models\\Vendor', 204, 'vendor-token', '745da79996146fa457c857535fe2e1724ee68b6366711d8efff9bcb296947d93', '[\"*\"]', '2026-04-13 00:28:11', NULL, '2026-04-07 01:06:34', '2026-04-13 00:28:11'),
(43, 'App\\Models\\Vendor', 204, 'vendor-token', '0a218977a71179f2a537e3e3ec4f48b63849ed1645f927999dba75591969e88c', '[\"*\"]', '2026-04-07 03:40:34', NULL, '2026-04-07 01:07:17', '2026-04-07 03:40:34'),
(44, 'App\\Models\\Vendor', 204, 'vendor-token', '8c2c5c97b94b6a332ca52286dce9619cdd0b24d64118f86def85bf8d80e7785a', '[\"*\"]', '2026-04-07 04:32:26', NULL, '2026-04-07 04:32:24', '2026-04-07 04:32:26'),
(45, 'App\\Models\\Vendor', 204, 'vendor-token', 'd3cd5957b08c2c0fc57895b0ee9932c2685326f9a49e038864b236f31e1f47d6', '[\"*\"]', '2026-04-12 04:59:51', NULL, '2026-04-12 00:20:30', '2026-04-12 04:59:51'),
(46, 'App\\Models\\Vendor', 204, 'vendor-token', 'aca0d8836205a6af82b4d1f9aaec65e42041423d7a5dcc2d17125a460ea184fc', '[\"*\"]', '2026-04-13 04:21:59', NULL, '2026-04-12 23:01:06', '2026-04-13 04:21:59'),
(48, 'App\\Models\\Vendor', 204, 'vendor-token', 'c1f3e8289b7ca59695122d8122d7dba57ba7872e8d60fb2d472abb016a9a7a3f', '[\"*\"]', NULL, NULL, '2026-04-14 22:55:21', '2026-04-14 22:55:21'),
(49, 'App\\Models\\Vendor', 204, 'vendor-token', '618bc03a9cfc66c25aef57e3c7836f5111c0d80b4f0235eb002e69cc22ceea09', '[\"*\"]', '2026-04-14 22:58:42', NULL, '2026-04-14 22:57:15', '2026-04-14 22:58:42'),
(50, 'App\\Models\\Vendor', 204, 'vendor-token', '0db67c4cca7815ed9b9478c0a7947b1b73a0d3e0196b62d3a2cc8df6a0913999', '[\"*\"]', '2026-04-14 22:58:54', NULL, '2026-04-14 22:57:33', '2026-04-14 22:58:54'),
(51, 'App\\Models\\Vendor', 204, 'vendor-token', '2007624d57bd3ae8dc1e03e45acaf909f66de93505cb05893cbb0ed23b5295a7', '[\"*\"]', '2026-04-15 00:47:26', NULL, '2026-04-14 23:54:39', '2026-04-15 00:47:26'),
(52, 'App\\Models\\Vendor', 204, 'vendor-token', 'caeac5bd0b4ed7f8157f5d4c23a701562d8dc12fbf4ac9aa1e283f923b43fe75', '[\"*\"]', '2026-04-15 05:20:42', NULL, '2026-04-15 04:03:52', '2026-04-15 05:20:42'),
(53, 'App\\Models\\Vendor', 204, 'vendor-token', '6ea1f7fa1c89f9fa89d85329ef8ae41a8f6a8c222605f0207f8558e296c180c9', '[\"*\"]', '2026-04-19 22:27:02', NULL, '2026-04-15 21:59:39', '2026-04-19 22:27:02'),
(54, 'App\\Models\\Vendor', 204, 'vendor-token', 'b921c526def29557c2f33f6841283f5afe123570dc9ff385456a66db97c0f187', '[\"*\"]', '2026-04-19 22:34:34', NULL, '2026-04-19 22:31:24', '2026-04-19 22:34:34'),
(55, 'App\\Models\\Vendor', 204, 'vendor-token', '963f75372b005aafaa19713229edc1ff156f75f94bc9032966874dacf2fa4d1c', '[\"*\"]', '2026-04-20 00:12:01', NULL, '2026-04-19 22:40:22', '2026-04-20 00:12:01'),
(56, 'App\\Models\\Vendor', 204, 'vendor-token', '4c3ec7e2082b76bdac3ab8594907d1f5f3f55846d1729d49106c31510a4ab055', '[\"*\"]', '2026-04-22 01:09:18', NULL, '2026-04-20 00:14:07', '2026-04-22 01:09:18'),
(57, 'App\\Models\\Vendor', 204, 'vendor-token', '79e43b81910021ce366dd8fbaf13625291fdad1f7ab9126fbab75ab55c97c347', '[\"*\"]', '2026-05-13 03:24:07', NULL, '2026-05-13 01:53:22', '2026-05-13 03:24:07'),
(58, 'App\\Models\\Vendor', 204, 'vendor-token', '9c016576c09c2f4c46b877da7069086920d1f5c9dae0aa3510c4a6d39bc0ce10', '[\"*\"]', '2026-05-14 02:09:10', NULL, '2026-05-13 23:19:37', '2026-05-14 02:09:10'),
(59, 'App\\Models\\Vendor', 204, 'vendor-token', '614614d4d222a464e4cfb1750840649cf947eb33320cdb3bb348c2b5e2aad4a5', '[\"*\"]', '2026-05-16 02:45:23', NULL, '2026-05-16 02:43:10', '2026-05-16 02:45:23');

-- --------------------------------------------------------

--
-- Table structure for table `popups`
--

CREATE TABLE `popups` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `type` smallint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `background_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `background_color_opacity` decimal(3,2) UNSIGNED DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `delay` int UNSIGNED NOT NULL COMMENT 'value will be in milliseconds',
  `serial_number` mediumint UNSIGNED NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0 => deactive, 1 => active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `popups`
--

INSERT INTO `popups` (`id`, `language_id`, `type`, `image`, `name`, `background_color`, `background_color_opacity`, `title`, `text`, `button_text`, `button_color`, `button_url`, `end_date`, `end_time`, `delay`, `serial_number`, `status`, `created_at`, `updated_at`) VALUES
(20, 20, 1, '64e1aff148d67.png', 'Black Friday', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1500, 1, 0, '2023-08-20 00:17:21', '2024-03-28 02:12:16'),
(21, 20, 2, '64e1b8074e80b.png', 'Month End Sale', 'EE1243', 0.80, 'ENJOY 10% OFF', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.', 'Get Offer', 'EE1243', 'https://codecanyon8.kreativdev.com/carlisting', NULL, NULL, 2000, 2, 0, '2023-08-20 00:51:51', '2024-03-28 02:12:13'),
(22, 20, 3, '64e1b8ba1a7a7.jpg', 'Summer Offer', 'EE1243', 0.70, 'Newsletter', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.', 'Subscribe', 'EE1243', NULL, NULL, NULL, 2000, 3, 0, '2023-08-20 00:54:50', '2024-03-28 02:12:09'),
(23, 20, 4, '64e1b95adbe02.jpg', 'Winter Offer', NULL, NULL, 'Get 10% off your sign up', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt', 'Sign up', 'EE1243', 'https://codecanyon8.kreativdev.com/carlisting', NULL, NULL, 2000, 4, 0, '2023-08-20 00:57:30', '2024-03-28 02:12:06'),
(24, 20, 5, '64e1b9ca02dbb.png', 'Email Popup', NULL, NULL, 'Get 10% off your first package purchase', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt', 'Subscribe', 'EE1243', NULL, NULL, NULL, 2000, 2, 0, '2023-08-20 00:59:22', '2024-03-28 02:06:24'),
(25, 20, 6, '64e1ba4d0151d.png', 'Countdown Popup', NULL, NULL, 'Hurry, Sale Ends This Friday', 'This is your last chance to save 30%', 'Yes,I Want to Save 30%', 'EE1243', 'https://codecanyon8.kreativdev.com/carlisting', '2029-12-27', '12:30:00', 2000, 6, 0, '2023-08-20 01:00:55', '2024-03-28 02:06:15'),
(26, 20, 7, '690991a33d7fb.png', 'Flash Deal', 'EE1243', NULL, 'Hurry, Sale Ends This Friday', 'This is your last chance to save 30%', 'Yes, I Want to Save 30%', 'A50C2E', 'https://codecanyon8.kreativdev.com/carlisting', '2029-11-29', '01:00:00', 2000, 7, 1, '2023-08-20 01:03:34', '2026-05-13 01:25:59');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `product_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `featured_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slider_images` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `input_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `file` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `stock` int UNSIGNED DEFAULT NULL,
  `sku` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `current_price` decimal(8,2) UNSIGNED NOT NULL,
  `previous_price` decimal(8,2) UNSIGNED DEFAULT NULL,
  `average_rating` decimal(4,2) UNSIGNED DEFAULT '0.00',
  `is_featured` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `listing_id` bigint UNSIGNED DEFAULT NULL,
  `placement_type` tinyint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `vendor_id`, `product_type`, `featured_image`, `slider_images`, `status`, `input_type`, `file`, `link`, `stock`, `sku`, `current_price`, `previous_price`, `average_rating`, `is_featured`, `created_at`, `updated_at`, `listing_id`, `placement_type`) VALUES
(71, NULL, 'physical', '663208aeee8ae.png', '[\"663208523e32f.png\",\"663208523ffda.png\",\"663208526872b.png\"]', 'show', NULL, NULL, NULL, 39, NULL, 43.00, 47.00, 4.00, 'no', '2024-05-01 03:17:34', '2024-05-07 22:14:55', NULL, 2),
(72, NULL, 'physical', '6632090876c5f.png', '[\"663208dabbbd5.png\",\"663208dabd2a2.png\",\"663208dae7c85.png\"]', 'show', NULL, NULL, NULL, 8, NULL, 600.00, 644.00, 0.00, 'no', '2024-05-01 03:19:04', '2024-05-01 03:19:04', NULL, 3),
(73, NULL, 'physical', '663209687d71d.png', '[\"663209245592a.png\",\"6632092459264.png\",\"66320924783ba.png\"]', 'show', NULL, NULL, NULL, 95, NULL, 35.00, 47.00, 0.00, 'no', '2024-05-01 03:20:40', '2024-05-07 22:08:04', NULL, 2),
(74, NULL, 'physical', '66320a695d7ea.png', '[\"66320a0adff84.png\",\"66320a0ae0056.png\",\"66320a0b0e4f8.png\"]', 'show', NULL, NULL, NULL, 25, NULL, 699.00, 799.00, 0.00, 'no', '2024-05-01 03:24:57', '2024-05-07 22:12:29', NULL, 1),
(75, NULL, 'physical', '66320af23b9b6.png', '[\"66320a9a1ec48.png\",\"66320a9a26422.png\",\"66320a9a41485.png\"]', 'show', NULL, NULL, NULL, 66, NULL, 89.00, 110.00, 0.00, 'no', '2024-05-01 03:27:14', '2024-05-01 03:27:14', NULL, 3),
(76, NULL, 'physical', '66320b8f7a357.png', '[\"66320b02cd39e.png\",\"66320b02d3fd2.png\",\"66320b02f340e.png\"]', 'show', NULL, NULL, NULL, 89, NULL, 79.00, 90.00, 0.00, 'no', '2024-05-01 03:29:51', '2024-05-01 03:29:51', NULL, 1),
(77, NULL, 'physical', '66320d5766a3b.png', '[\"66320c9a01b68.png\",\"66320c9a1c8a3.png\",\"66320c9a24c5e.png\"]', 'show', NULL, NULL, NULL, 6, NULL, 89.00, 99.00, 0.00, 'no', '2024-05-01 03:37:27', '2024-05-07 22:29:30', NULL, 2),
(78, 201, 'physical', '66320dafa3260.png', '[\"66320d73d2c0b.png\",\"66320d73df90d.png\",\"66320d74052c2.png\"]', 'show', NULL, NULL, NULL, 83, NULL, 399.00, 459.00, 4.00, 'no', '2024-05-01 03:38:55', '2026-05-12 08:21:33', 9, 3),
(79, NULL, 'physical', '66320e321610c.png', '[\"66320dbc806dd.png\",\"66320dc0279aa.png\",\"66320dc027729.png\"]', 'show', NULL, NULL, NULL, 97, NULL, 99.00, 132.00, 0.00, 'no', '2024-05-01 03:41:06', '2025-11-03 06:58:42', NULL, 1),
(80, NULL, 'digital', '6638a8537ee17.png', '[\"6638a79b5d573.png\",\"6638a79b5d573.png\",\"6638a79b8616f.png\"]', 'show', 'link', NULL, 'https://www.example.com', NULL, NULL, 9.00, 12.00, 2.00, 'no', '2024-05-06 03:52:19', '2024-05-07 22:16:04', NULL, 1),
(81, NULL, 'physical', '6638a939927da.png', '[\"6638a8aa141eb.png\",\"6638a8adb5806.png\",\"6638a8adb580d.png\"]', 'show', NULL, NULL, NULL, 98, NULL, 789.00, 889.00, 0.00, 'no', '2024-05-06 03:56:09', '2024-05-07 22:29:30', NULL, 2),
(82, NULL, 'physical', '6638aa9f37c81.png', '[\"6638a9cc3683a.png\",\"6638a9cc3693c.png\",\"6638a9cc5d916.png\"]', 'show', NULL, NULL, NULL, 798, NULL, 1200.00, 1347.00, 0.00, 'no', '2024-05-06 04:02:07', '2024-10-14 02:46:59', NULL, 2),
(83, NULL, 'physical', '6638abba21391.png', '[\"6638ab131b6c1.png\",\"6638ab132f113.png\",\"6638ab134494c.png\"]', 'show', NULL, NULL, NULL, 56780, NULL, 799.00, 899.00, 4.00, 'no', '2024-05-06 04:06:50', '2025-10-12 09:28:29', NULL, 1),
(84, NULL, 'physical', '6638ac9768c09.png', '[\"6638abe99c5c4.png\",\"6638abe99d19e.png\",\"6638abe9c7136.png\"]', 'show', NULL, NULL, NULL, 5461, NULL, 1700.00, 2490.00, 0.00, 'no', '2024-05-06 04:10:31', '2025-11-19 22:27:57', NULL, 3),
(85, NULL, 'digital', '663af45576e1f.png', '[\"663af383cd7c8.png\",\"663af38904fd9.png\",\"663af389072fa.png\"]', 'show', 'upload', '663af45577213.zip', NULL, NULL, NULL, 70.00, 99.00, 5.00, 'no', '2024-05-07 21:41:09', '2024-05-07 22:14:31', NULL, 2),
(118, 204, 'physical', '6908a5e13c04e.jpg', '[\"6908a5d9bde1f.jpg\",\"6908a5d9bd76d.jpg\"]', 'show', NULL, NULL, NULL, 20, NULL, 55.00, 55.00, 0.00, 'no', '2025-11-03 06:53:53', '2026-05-12 23:34:48', 1, 2),
(121, 228, 'digital', '69abf52b14774.jpg', '[\"69abf4f42018b.jpg\",\"69abf4f448e3b.jpg\"]', 'show', 'link', NULL, 'https://bulistio-4.0.test/vendor/vendor/shop-management/create-product/digital', NULL, NULL, 132.00, 456.00, 0.00, 'no', '2026-03-07 03:51:39', '2026-03-07 03:51:39', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `language_id`, `name`, `slug`, `status`, `serial_number`, `created_at`, `updated_at`) VALUES
(61, 20, 'Hospital Equipment', 'hospital-equipment', 1, 1, '2024-05-01 03:14:30', '2024-05-01 03:14:30'),
(62, 21, 'معدات المستشفيات', 'معدات-المستشفيات', 1, 1, '2024-05-01 03:15:10', '2024-11-09 22:02:18'),
(63, 20, 'Gym Equipment', 'gym-equipment', 1, 2, '2024-05-01 03:22:17', '2024-05-01 03:22:17'),
(64, 21, 'معدات النادي الرياضي', 'معدات-النادي-الرياضي', 1, 2, '2024-05-01 03:22:39', '2024-11-09 22:02:12'),
(65, 20, 'Saloon Equipment', 'saloon-equipment', 1, 3, '2024-05-01 03:33:30', '2024-05-01 03:33:30'),
(66, 21, 'معدات الصالون', 'معدات-الصالون', 1, 3, '2024-05-01 03:33:51', '2024-11-09 22:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `product_contents`
--

CREATE TABLE `product_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `product_category_id` bigint UNSIGNED DEFAULT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `list_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `meta_keywords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_contents`
--

INSERT INTO `product_contents` (`id`, `language_id`, `product_category_id`, `product_id`, `list_id`, `title`, `slug`, `summary`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(143, 20, 61, 71, NULL, 'Surgical Lights', 'surgical-lights', 'Surgical lights, also known as surgical lighting or operating lights, are mainly used in hospital operating rooms and ambulatory surgery centers, but can also be used in various locations throughout the facility to provide high quality lighting for procedures. Examples include emergency rooms, labor and delivery, examination rooms, and anywhere where procedures are completed. They are used by clinicians, surgeons and proceduralists', '<p>Surgical lights, also known as  or operating lights, are mainly used in hospital operating rooms and ambulatory surgery centers, but can also be used in various locations throughout the facility to provide high quality lighting for procedures. Examples include emergency rooms, labor and delivery, examination rooms, and anywhere where procedures are completed. They are used by clinicians, surgeons and proceduralistsSurgical lights, also known as or operating lights, are mainly used in hospital operating rooms and ambulatory surgery centers, but can also be used in various locations throughout the facility to provide high quality lighting for procedures. Examples include emergency rooms, labor and delivery, examination rooms, and anywhere where procedures are completed. They are used by clinicians, surgeons and proceduralists</p>', NULL, NULL, '2024-05-01 03:17:35', '2024-05-01 03:17:35'),
(144, 21, 62, 71, NULL, 'أضواء جراحية', 'أضواء-جراحية', 'تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين', '<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>', NULL, NULL, '2024-05-01 03:17:35', '2024-05-01 03:45:52'),
(145, 20, 61, 72, NULL, 'MRI', 'mri', 'Magnetic resonance imaging, or MRI, is a noninvasive medical imaging test that produces detailed images of almost every internal structure in the human body, including the organs, bones, muscles and blood vessels. MRI scanners create images of the body using a large magnet and radio waves.', '<p><span class=\"c5aZPb\"><span class=\"JPfdse\">Magnetic resonance</span></span> imaging, or MRI, is <strong>a noninvasive medical imaging test that produces detailed images of almost every internal structure in the human body, including the organs, bones, muscles and blood vessels</strong>. MRI scanners create images of the body using a large magnet and radio waves.<span class=\"c5aZPb\"><span class=\"JPfdse\">Magnetic resonance</span></span> imaging, or MRI, is <strong>a noninvasive medical imaging test that produces detailed images of almost every internal structure in the human body, including the organs, bones, muscles and blood vessels</strong>. MRI scanners create images of the body using a large magnet and radio waves.</p>', NULL, NULL, '2024-05-01 03:19:04', '2024-05-01 03:49:01'),
(146, 21, 62, 72, NULL, 'التصوير بالرنين المغناطيسي', 'التصوير-بالرنين-المغناطيسي', 'التصوير بالرنين المغناطيسي، أو التصوير بالرنين المغناطيسي، هو اختبار تصوير طبي غير جراحي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا في جسم الإنسان، بما في ذلك الأعضاء والعظام والعضلات والأوعية الدموية. تقوم ماسحات التصوير بالرنين المغناطيسي بإنشاء صور للجسم باستخدام مغناطيس كبير وموجات الراديو.', '<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">التصوير بالرنين المغناطيسي، أو MRI، هو اختبار تصوير طبي غير جرا<br />حي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا في جسم الإنسان، بما في <br />ذلك الأعضاء والعظام والعضلات والأوعية الدموية. تنشئ ماسحات التصوير بالرنين المغناطيسي صورًا لل<br />جسم باستخدام مغناطيس كبير وموجات راديو. التصوير بالرنين المغناطيسي، أو التصوير بالرنين المغناطيسي، هو اختبار تصوي<br />ر طبي غير جراحي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا في جسم الإنسان، بما في <br />ذلك الأعضاء والعظام والعضلات والأعصاب. الأوعية الدموية. تنشئ ماسحات التصوير بالرنين المغناطيسي صورًا للجسم باستخدام م<br />غناطيس كبير وموجات راديو. التصوير بالرنين المغناطيسي، أو التصوير<br /> بالرنين المغناطيسي، هو اختبار تصوير طبي غير جراحي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا ف<br />ي جسم الإنسان، بما في ذلك الأعضاء والعظام والعضلات والأعصاب. الأوعية الدموية. تنشئ ماسحات التصوير بالرنين ال<br />مغناطيسي صورًا للجسم باستخدام مغناطي<br />س كبير وموجات راديو. التصوير بالرنين المغناطيسي، أو التصوير بالرنين المغناطيسي، هو اخ<br />تبار تصوير طبي غير جراحي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا في جسم الإنسان، بما في ذلك الأعضاء والعظا<br />م والعضلات والأعصاب. الأوعية الدموية. تقوم ماسحات التصوير بالرنين ال<br />مغناطيسي بإنشاء صور للجسم باستخدام مغناطيس كبير وموجات الراديو.</span></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"> </div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"> </div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"> </div>', NULL, NULL, '2024-05-01 03:19:04', '2024-05-01 03:50:07'),
(147, 20, 61, 73, NULL, 'Infusion Pump', 'infusion-pump', 'Infusion pumps allow for high viscous medications to be administered through small catheters into the veins. Medication is usually administered this way through the dorsal veins of the hand, the forearm, the arm, the dorsal veins of the foot, the inguinal region and the antecubital fossa.', '<p>Infusion pumps <strong>allow for high viscous medications to be administered through small catheters into the veins</strong>. Medication is usually administered this way through the dorsal veins of the hand, the forearm, the arm, the dorsal veins of the foot, the inguinal region and the antecubital fossa.Infusion pumps <strong>allow for high viscous medications to be administered through small catheters into the veins</strong>. Medication is usually administered this way through the dorsal veins of the hand, the forearm, the arm, the dorsal veins of the foot, the inguinal region and the antecubital fossa.</p>', NULL, NULL, '2024-05-01 03:20:40', '2024-05-01 03:20:40'),
(148, 21, 62, 73, NULL, 'مضخة التصريف', 'مضخة-التصريف', 'تسمح مضخات التسريب بإدخال الأدوية عالية اللزوجة من خلال القسطرة الصغيرة إلى الأوردة. يتم إعطاء الدواء عادة بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود.', '<p>تتيح مضخات التسريب إمكانية إعطاء الأدوية عالية اللزوجة من خلال القسطرة الصغيرة في الأوردة. يتم عادةً إعطاء الدواء بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود. وتسمح مضخات التسريب بإدخال الأدوية عالية اللزوجة من خلال قسطرات صغيرة إلى داخل الأوردة. الأوردة. يتم عادةً إعطاء الدواء بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود. وتسمح مضخات التسريب بإدخال الأدوية عالية اللزوجة من خلال قسطرات صغيرة إلى داخل الأوردة. الأوردة. يتم عادةً إعطاء الدواء بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود. وتسمح مضخات التسريب بإدخال الأدوية عالية اللزوجة من خلال قسطرات صغيرة إلى داخل الأوردة. الأوردة. يتم إعطاء الدواء عادة بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود.</p>', NULL, NULL, '2024-05-01 03:20:40', '2024-05-01 03:55:30'),
(149, 20, 63, 74, NULL, 'Treadmill', 'treadmill', 'Healthfit Foldable Semi Commercial Motorized Treadmill 586DS Price In Bangladesh When it comes to buying a treadmill make sure the treadmill has all the features for your needs. Our Asian Sky Shop offers you a semi-commercial motorized treadmill that has so many features and specifications. It\'s manufactured by Healthfit. This foldable treadmill is easy to carry and user comfortable. We are giving you an affordable price range and lots of facilities.', '<p>Healthfit Foldable Semi Commercial Motorized Treadmill 586DS Price In Bangladesh When it comes to buying a treadmill make sure the treadmill has all the features for your needs. Our Asian Sky Shop offers you a semi-commercial motorized treadmill that has so many features and specifications. It\'s manufactured by Healthfit. This foldable treadmill is easy to carry and user comfortable. We are giving you an affordable price range and lots of facilities.</p>\r\n<p>Healthfit Foldable Semi Commercial Motorized Treadmill 586DS Price In Bangladesh When it comes to buying a treadmill make sure the treadmill has all the features for your needs. Our Asian Sky Shop offers you a semi-commercial motorized treadmill that has so many features and specifications. It\'s manufactured by Healthfit. This foldable treadmill is easy to carry and user comfortable. We are giving you an affordable price range and lots of facilities.</p>', NULL, NULL, '2024-05-01 03:24:57', '2024-05-01 03:24:57'),
(150, 21, 64, 74, NULL, 'جهاز المشي', 'جهاز-المشي', 'جهاز المشي الكهربائي القابل للطي شبه التجاري من السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian Sky Shop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.', '<p>جهاز المشي الكهربائي القابل للطي شبه التجاري من السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian SkyShop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.جهاز المشي الكهربائي القابل للطي شبه التجاري من Healthfit 586DS السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian Sky Shop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.جهاز المشي الكهربائي القابل للطي شبه التجاري من Healthfit 586DS السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian Sky Shop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.</p>', NULL, NULL, '2024-05-01 03:24:57', '2024-05-01 03:54:40'),
(151, 20, 63, 75, NULL, 'Kettlebells', 'kettlebells', 'A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying supine on the floor to standing, and back again. Get-ups are sometimes modified into get-up presses, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.', '<p>A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying on the floor to standing, and back again. Get-ups are sometimes modified into <em>get-up presses</em>, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.<sup class=\"reference\"><a href=\"https://en.wikipedia.org/wiki/Kettlebell#cite_note-14\">]</a></sup>A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying on the floor to standing, and back again. Get-ups are sometimes modified into <em>get-up presses</em>, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying on the floor to standing, and back again. Get-ups are sometimes modified into <em>get-up presses</em>, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.</p>', NULL, NULL, '2024-05-01 03:27:14', '2024-05-01 03:53:50'),
(152, 21, 64, 75, NULL, 'أجراس كيتل', 'أجراس-كيتل', 'تمرين كيتل بيل الذي يجمع بين تمرين الاندفاع والجسر واللوح الجانبي في حركة بطيئة ومنضبطة. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات الاستيقاظ أحيانًا إلى مكابس الاستيقاظ، مع الضغط على كل موضع من موضع الاستيقاظ؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي.', '<p>تمرين كيتل بيل الذي يجمع بين تمرين الاندفاع والجسر واللوح الجانبي في حركة بطيئة ومنضبطة. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات النهوض أحيانًا إلى ضغطات النهوض، مع الضغط على كل موضع من موضع النهوض؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي.] تمرين كيتل بيل الذي يجمع بين الاندفاع، الجسر واللوح الجانبي في حركة بطيئة ومسيطر عليها. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات النهوض أحيانًا إلى ضغطات النهوض، مع الضغط على كل موضع من موضع النهوض؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي. واللوح الجانبي بحركة بطيئة ومسيطر عليها. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات النهوض أحيانًا إلى ضغطات النهوض، مع الضغط على كل موضع من موضع النهوض؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي.</p>', NULL, NULL, '2024-05-01 03:27:14', '2024-05-01 03:53:50'),
(153, 20, 63, 76, NULL, 'Dumbbells', 'dumbbells', 'There are many variations possible while using the same basic concept of reducing the weight used. One way is to do a specified number of repetitions at each weight (without necessarily reaching the point of muscle failure) with an increase in the number of repetitions each time the weight is reduced. The amount or percentage of weight reduced at each step is also one aspect of the method with much variety. A wide drop set method is one in which a large percentage (usually 30% or more) of the starting weight is shed with each weight reduction. A tight drop set would remove anywhere from 10% to 25%.\r\n\r\nDrop sets may be performed either with or without rest periods between sets. Some make a distinction between the two: if the lifter does not rest then these sets are referred to as drop sets, whereas if the lifter does rest between sets then these sets are usually referred to as down sets.\r\n\r\nThese definitions are somewhat arbitrary, of course, and not everyone will agree on the exact definitions.', '<p>There are many variations possible while using the same basic concept of reducing the weight used. One way is to do a specified number of repetitions at each weight (without necessarily reaching the point of )with an increase in the number of repetitions each time the weight is reduced. The amount or percentage of weight reduced at each step is also one aspect of the method with much variety. A <strong>wide drop set</strong> method is one in which a large percentage (usually 30% or more) of the starting weight is shed with each weight reduction. A <strong>tight drop set</strong> would remove anywhere from 10% to 25%.</p>\r\n<p>Drop sets may be performed either with or without rest periods between sets. Some make a distinction between the two: if the lifter does not rest then these sets are referred to as drop sets, whereas if the lifter does rest between sets then these sets are usually referred to as <strong>down sets</strong>.</p>\r\n<p>These definitions are somewhat arbitrary, of course, and not everyone will agree on the exact definitions.</p>\r\n<p>There are many variations possible while using the same basic concept of reducing the weight used. One way is to do a specified number of repetitions at each weight (without necessarily reaching the point ofwith an increase in the number of repetitions each time the weight is reduced. The amount or percentage of weight reduced at each step is also one aspect of the method with much variety. A <strong>wide drop set</strong> method is one in which a large percentage (usually 30% or more) of the starting weight is shed with each weight reduction. A <strong>tight drop set</strong> would remove anywhere from 10% to 25%.</p>\r\n<p>Drop sets may be performed either with or without rest periods between sets. Some make a distinction between the two: if the lifter does not rest then these sets are referred to as drop sets, whereas if the lifter does rest between sets then these sets are usually referred to as <strong>down sets</strong>.</p>\r\n<p>These definitions are somewhat arbitrary, of course, and not everyone will agree on the exact definitions.</p>', NULL, NULL, '2024-05-01 03:29:51', '2024-05-01 03:29:51'),
(154, 21, 64, 76, NULL, 'اجراس صماء', 'اجراس-صماء', 'هناك العديد من الاختلافات الممكنة أثناء استخدام نفس المفهوم الأساسي لتقليل الوزن المستخدم. إحدى الطرق هي القيام بعدد محدد من التكرارات عند كل وزن (دون الوصول بالضرورة إلى نقطة الفشل العضلي) مع زيادة عدد التكرارات في كل مرة ينقص فيها الوزن. يعد مقدار أو نسبة الوزن المنخفض في كل خطوة أيضًا أحد جوانب الطريقة مع تنوع كبير. طريقة مجموعة الإسقاط الواسعة هي الطريقة التي يتم فيها التخلص من نسبة كبيرة (عادة 30٪ أو أكثر) من الوزن الأولي مع كل تخفيض للوزن. ستؤدي مجموعة الإسقاط الضيقة إلى إزالة أي مكان من 10٪ إلى 25٪.\r\n\r\nيمكن إجراء مجموعات الإسقاط إما مع أو بدون فترات راحة بين المجموعات. يميز البعض بين الاثنين: إذا لم يستريح الرافع فيشار إلى هذه المجموعات بمجموعات الهبوط، بينما إذا استراح الرافع بين المجموعات فيشار إلى هذه المجموعات عادةً باسم المجموعات السفلية.\r\n\r\nهذه التعريفات تعسفية إلى حد ما، بطبيعة الحال، ولن يتفق الجميع على التعريفات الدقيقة.', '<p>هناك العديد من الاختلافات الممكنة أثناء استخدام نفس المفهوم الأساسي لتقليل الوزن المستخدم. إحدى الطرق هي القيام بعدد محدد من التكرارات عند كل وزن (دون الوصول بالضرورة إلى النقطة ) مع زيادة عدد التكرارات في كل مرة ينقص فيها الوزن. يعد مقدار أو نسبة الوزن المنخفض في كل خطوة أيضًا أحد جوانب الطريقة مع تنوع كبير. طريقة مجموعة الإسقاط الواسعة هي الطريقة التي يتم فيها التخلص من نسبة كبيرة (عادةً 30% أو أكثر) من الوزن الأولي مع كل عملية تخفيض للوزن. ستؤدي مجموعة الإسقاط الضيقة إلى إزالة أي مكان من 10% إلى 25%.</p>\r\n<p>يمكن إجراء مجموعات الإسقاط إما مع أو بدون فترات راحة بين المجموعات. يميز البعض بين الاثنين: إذا لم يستريح الرافع، تتم الإشارة إلى هذه المجموعات باسم مجموعات الإسقاط، بينما إذا كان الرافع يستريح بين المجموعات، فيُشار إلى هذه المجموعات عادةً باسم المجموعات السفلية.</p>\r\n<p>هذه التعريفات تعسفية إلى حد ما، بطبيعة الحال، ولن يتفق الجميع على التعريفات الدقيقة.</p>\r\n<p>هناك العديد من الاختلافات الممكنة أثناء استخدام نفس المفهوم الأساسي لتقليل الوزن المستخدم. إحدى الطرق هي القيام بعدد محدد من التكرارات عند كل وزن (دون الوصول بالضرورة إلى نقطة زيادة عدد التكرارات في كل مرة يتم فيها تقليل الوزن. كما أن مقدار أو نسبة الوزن المخفض في كل خطوة هو أيضًا أحد جوانب الهدف). طريقة ذات تنوع كبير. طريقة مجموعة الإسقاط الواسعة هي الطريقة التي يتم فيها التخلص من نسبة كبيرة (عادةً 30% أو أكثر) من الوزن الأولي مع كل تخفيض في الوزن.</p>\r\n<p>يمكن إجراء مجموعات الإسقاط إما مع أو بدون فترات راحة بين المجموعات. يميز البعض بين الاثنين: إذا لم يستريح الرافع، تتم الإشارة إلى هذه المجموعات باسم مجموعات الإسقاط، بينما إذا كان الرافع يستريح بين المجموعات، فيُشار إلى هذه المجموعات عادةً باسم المجموعات السفلية.</p>\r\n<p>هذه التعريفات تعسفية إلى حد ما، بطبيعة الحال، ولن يتفق الجميع على التعريفات الدقيقة.</p>', NULL, NULL, '2024-05-01 03:29:51', '2024-05-01 03:52:51'),
(155, 20, 65, 77, NULL, 'Hair Curler', 'hair-curler', 'A hair roller or hair curler is a small tube that is rolled into a person\'s hair in order to curl it, or to straighten curly hair, making a new hairstyle.[1]\r\n\r\nThe diameter of a roller varies from approximately 0.8 inches (20 mm) to 1.5 inches (38 mm). The hair is heated, and the rollers strain and break the hydrogen bonds[citation needed] of each hair\'s cortex, which causes the hair to curl. The hydrogen bonds reform after the hair is moistened.\r\n\r\nA hot roller or hot curler is designed to be heated in an electric chamber before one rolls it into the hair.[2] Alternatively, a hair dryer heats the hair after the rolls are in place. Hair spray can temporarily fix curled hair in place.\r\n\r\nIn 1930, Solomon Harper created the first electrically heated hair rollers, then creating a better design in 1953.\r\n\r\nIn 1968 at the feminist Miss America protest, protesters symbolically threw a number of feminine products into a \"Freedom Trash Can\". These included hair rollers,[3] which were among items the protesters called \"instruments of female torture\"[4] and accoutrements of what they perceived to be enforced femininity.', '<p>A <strong>hair roller</strong> or <strong>hair curler</strong> is a small tube that is rolled into a person\'s in order to it, or to curly hair, making a new .</p>\r\n<p>The diameter of a roller varies from approximately 0.8 inches (20 mm) to 1.5 inches (38 mm). The hair is heated, and the rollers strain and break the of each hair\'s cortex, which causes the hair to curl. The hydrogen bonds reform after the hair is moistened.</p>\r\n<p>A <strong>hot roller</strong> or <strong>hot curler</strong> is designed to be heated in an electric chamber before one rolls it into the hair.Alternatively, a heats the hair after the rolls are in place.can temporarily fix curled hair in place.</p>\r\n<p>In 1930, created the first electrically heated hair rollers, then creating a better design in 1953.</p>\r\n<p>In 1968 at the feminist, protesters symbolically threw a number of feminine products into a \"Freedom Trash Can\". These included hair rollers, which were among items the protesters called \"instruments of female torture\" and accoutrements of what they perceived to be enforced .</p>\r\n<p>A <strong>hair roller</strong> or <strong>hair curler</strong> is a small tube that is rolled into a person\'s in order to it, or to curly hair, making a new .</p>\r\n<p>The diameter of a roller varies from approximately 0.8 inches (20 mm) to 1.5 inches (38 mm). The hair is heated, and the rollers strain and break the  of each hair\'s cortex, which causes the hair to curl. The hydrogen bonds reform after the hair is moistened.</p>\r\n<p>A <strong>hot roller</strong> or <strong>hot curler</strong> is designed to be heated in an electric chamber before one rolls it into the hair. Alternatively, a heats the hair after the rolls are in place. can temporarily fix curled hair in place.</p>\r\n<p>In 1930, created the first electrically heated hair rollers, then creating a better design in 1953.</p>\r\n<p>In 1968 at the feminist, protesters symbolically threw a number of feminine products into a \"Freedom Trash Can\". These included hair rollers, which were among items the protesters called \"instruments of female torture\" and accoutrements of what they perceived to be enforced .</p>', NULL, NULL, '2024-05-01 03:37:27', '2024-05-01 03:51:49'),
(156, 21, 66, 77, NULL, 'مجعد الشعر', 'مجعد-الشعر', 'بكرة الشعر أو أداة تجعيد الشعر عبارة عن أنبوب صغير يتم لفه في شعر الشخص من أجل تجعيده، أو تنعيم الشعر المجعد، وعمل تسريحة شعر جديدة.\r\n\r\nيتراوح قطر الأسطوانة من حوالي 0.8 بوصة (20 ملم) إلى 1.5 بوصة (38 ملم). يتم تسخين الشعر، وتقوم البكرات بإجهاد وكسر الروابط الهيدروجينية لقشرة كل شعرة، مما يتسبب في تجعد الشعر. يتم إصلاح الروابط الهيدروجينية بعد ترطيب الشعر.\r\n\r\nتم تصميم الأسطوانة الساخنة أو أداة تجعيد الشعر الساخنة بحيث يتم تسخينها في غرفة كهربائية قبل لفها في الشعر. بدلًا من ذلك، يقوم مجفف الشعر بتسخين الشعر بعد وضع اللفائف في مكانها. يمكن لرذاذ الشعر تثبيت الشعر المجعد في مكانه بشكل مؤقت.\r\n\r\nفي عام 1930، ابتكر سولومون هاربر أول بكرات شعر يتم تسخينها كهربائيًا، ثم ابتكر تصميمًا أفضل في عام 1953.\r\n\r\nفي عام 1968، أثناء احتجاج ملكة جمال أمريكا النسوية، ألقى المتظاهرون بشكل رمزي عددًا من المنتجات النسائية في \"سلة مهملات الحرية\". وشملت هذه بكرات الشعر، والتي كانت من بين العناصر التي أطلق عليها المتظاهرون \"أدوات تعذيب الإناث\" ومستلزمات ما اعتبروه أنوثة قسرية.', '<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">بكرة الشعر أو أداة تجعيد الشعر عبارة عن أنبوب صغير يتم لفه داخل شعر الشخص أو تجعيده، مما يؤدي إلى تكوين شعر جديد.\r\n\r\nيتراوح قطر الأسطوانة من حوالي 0.8 بوصة (20 ملم) إلى 1.5 بوصة (38 ملم). يتم تسخين الشعر، وتجهد البكرات وتكسر قشرة كل شعرة، مما يتسبب في تجعد الشعر. يتم إصلاح الروابط الهيدروجينية بعد ترطيب الشعر.\r\n\r\nتم تصميم الأسطوانة الساخنة أو أداة تجعيد الشعر الساخنة بحيث يتم تسخينها في غرفة كهربائية قبل لفها في الشعر. وبدلاً من ذلك، يتم تسخين الشعر بعد وضع اللفائف في مكانها. ويمكن تثبيت الشعر المجعد في مكانه بشكل مؤقت.\r\n\r\nفي عام 1930، ابتكر أول بكرات شعر يتم تسخينها كهربائيًا، ثم ابتكر تصميمًا أفضل في عام 1953.\r\n\r\nفي عام 1968، قامت الناشطة النسوية بإلقاء المتظاهرات بشكل رمزي عددًا من المنتجات النسائية في \"سلة مهملات الحرية\". وشملت هذه بكرات الشعر، والتي كانت من بين العناصر التي وصفها المتظاهرون بأنها \"أدوات تعذيب للإناث\" ومعدات ما اعتقدوا أنه يتم فرضها.\r\n\r\nبكرة الشعر أو أداة تجعيد الشعر عبارة عن أنبوب صغير يتم لفه داخل شعر الشخص أو تجعيده، مما يؤدي إلى تكوين شعر جديد.\r\n\r\nيتراوح قطر الأسطوانة من حوالي 0.8 بوصة (20 ملم) إلى 1.5 بوصة (38 ملم). يتم تسخين الشعر، وتجهد البكرات وتكسر قشرة كل شعرة، مما يتسبب في تجعد الشعر. يتم إصلاح الروابط الهيدروجينية بعد ترطيب الشعر.\r\n\r\nتم تصميم الأسطوانة الساخنة أو أداة تجعيد الشعر الساخنة بحيث يتم تسخينها في غرفة كهربائية قبل لفها في الشعر. وبدلاً من ذلك، يتم تسخين الشعر بعد وضع اللفائف في مكانها. يمكن تثبيت الشعر المجعد مؤقتًا في مكانه.\r\n\r\nفي عام 1930، ابتكر أول بكرات شعر يتم تسخينها كهربائيًا، ثم ابتكر تصميمًا أفضل في عام 1953.\r\n\r\nفي عام 1968، قامت الناشطة النسوية بإلقاء المتظاهرات بشكل رمزي عددًا من المنتجات النسائية في \"سلة مهملات الحرية\". وشملت هذه بكرات الشعر، والتي كانت من بين العناصر التي وصفها المتظاهرون بأنها \"أدوات تعذيب للإناث\" ومعدات ما اعتقدوا أنه يتم فرضها.</span></pre>', NULL, NULL, '2024-05-01 03:37:27', '2024-05-01 03:51:49'),
(157, 20, 65, 78, NULL, 'Salon Chair', 'salon-chair', 'Color: Black, Coffee\r\nMaterial: Artificial Leather, Plastic, SS\r\nValue Addition: Non-Hydraulic\r\nPlace of Origin: Bangladesh\r\nHeight: Adjustable\r\nCare Instructions: Wipe with Soft Dry Brush After Use.\r\nFeatures: Durable & Comfortable.', '<ul>\r\n<li>Color: Black, Coffee<br />Material: Artificial Leather, Plastic, SS<br />Value Addition: Non-Hydraulic<br />Place of Origin: Bangladesh<br />Height: Adjustable<br />Care Instructions: Wipe with Soft Dry Brush After Use.<br />Features: Durable &amp; Comfortable.</li>\r\n</ul>', NULL, NULL, '2024-05-01 03:38:55', '2024-05-01 03:38:55'),
(158, 21, 66, 78, NULL, 'كرسي صالون', 'كرسي-صالون', 'اللون: أسود، قهوة\r\nالمواد: جلد صناعي، بلاستيك، SS\r\nإضافة القيمة: غير هيدروليكي\r\nمكان المنشأ: بنجلاديش\r\nالارتفاع: قابل للتعديل\r\nتعليمات العناية: امسحي بفرشاة جافة ناعمة بعد الاستخدام.\r\nالميزات: متين ومريح.', '<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">اللون: أسود، قهوة\r\nالمواد: جلد صناعي، بلاستيك، SS\r\nإضافة القيمة: غير هيدروليكي\r\nمكان المنشأ: بنجلاديش\r\nالارتفاع: قابل للتعديل\r\nتعليمات العناية: امسحي بفرشاة جافة ناعمة بعد الاستخدام.\r\nالميزات: متين ومريح.</span></pre>', NULL, NULL, '2024-05-01 03:38:55', '2024-05-01 03:46:46'),
(159, 20, 65, 79, NULL, 'Shampoo Bowl', 'shampoo-bowl', 'Minerva Beauty offers a variety of shampoo bowls and wet stations for salons and barbershops, including standalone shampoo bowls you can pair with your existing shampoo cabinet or wall unit, pedestal shampoo bowls, barber wet stations, and barber sinks paired with a cabinet and mirror. Minerva shampoo bowls come with mounting hardware and all the parts your plumber needs to install them, and we also provide shampoo bowl replacement parts and accessories. Add more storage to your professional shampoo stations with lower and upper cabinets, available in a wide range of colors and finishes including custom options. Don’t forget to pick up a shampoo chair to pair with your hair wash bowl, or browse our shampoo backwash units for ready-made setups. We also have a helpful guide to choosing the best shampoo bowl and chair that covers dimensions, accessibility and more.', '<p>Minerva Beauty offers a variety of shampoo bowls and wet stations for salons and barbershops, including standalone shampoo bowls you can pair with your existing shampoo cabinet or wall unit, pedestal shampoo bowls, barber wet stations, and barber sinks paired with a cabinet and mirror. Minerva shampoo bowls come with mounting hardware and all the parts your plumber needs to install them, and we also provide . Add more storage to your professional with lower and upper cabinets, available in a wide range of colors and finishes including custom options. Don’t forget to pick up a to pair with your hair wash bowl, or browse our for ready-made setups. We also have a helpful guide to <a href=\"https://www.minervabeauty.com/blog/post/shampoo-system-buying-guide\"> </a>that covers dimensions, accessibility and more.</p>\r\n<p>Minerva Beauty offers a variety of shampoo bowls and wet stations for salons and barbershops, including standalone shampoo bowls you can pair with your existing shampoo cabinet or wall unit, pedestal shampoo bowls, barber wet stations, and barber sinks paired with a cabinet and mirror. Minerva shampoo bowls come with mounting hardware and all the parts your plumber needs to install them, and we also provide . Add more storage to your professional with lower and upper cabinets, available in a wide range of colors and finishes including custom options. Don’t forget to pick up a to pair with your hair wash bowl, or browse our for ready-made setups. We also have a helpful guide to <a href=\"https://www.minervabeauty.com/blog/post/shampoo-system-buying-guide\"> </a>that covers dimensions, accessibility and more.</p>', NULL, NULL, '2024-05-01 03:41:06', '2024-05-01 03:41:06'),
(160, 21, 66, 79, NULL, 'وعاء الشامبو', 'وعاء-الشامبو', 'تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.', '<p>تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.<br /><br /></p>', NULL, NULL, '2024-05-01 03:41:06', '2024-05-01 03:44:59'),
(161, 20, 61, 80, NULL, 'Do not Distrub', 'do-not-distrub', '\"Do Not Disturb\" is a mystery thriller novel written by British author Claire Douglas. The story revolves around a group of friends who decide to spend a weekend away at a remote lodge in the Scottish Highlands. However, their peaceful retreat turns into a nightmare when they discover a woman\'s body in the hot tub.\r\n\r\nAs the friends grapple with shock and fear, tensions rise, and they realize that each of them harbors secrets that could unravel their lives. With suspicion and paranoia mounting, they must confront their pasts and untangle the web of lies surrounding them to uncover the truth about what happened that fateful night.\r\n\r\nFilled with twists, suspense, and psychological depth, \"Do Not Disturb\" explores themes of trust, betrayal, and the consequences of buried secrets. It keeps readers on the edge of their seats as they race to unravel the mystery alongside the characters.', '<p>\"Do Not Disturb\" is a mystery thriller novel written by British author Claire Douglas. The story revolves around a group of friends who decide to spend a weekend away at a remote lodge in the Scottish Highlands. However, their peaceful retreat turns into a nightmare when they discover a woman\'s body in the hot tub.</p>\r\n<p>As the friends grapple with shock and fear, tensions rise, and they realize that each of them harbors secrets that could unravel their lives. With suspicion and paranoia mounting, they must confront their pasts and untangle the web of lies surrounding them to uncover the truth about what happened that fateful night.</p>\r\n<p>Filled with twists, suspense, and psychological depth, \"Do Not Disturb\" explores themes of trust, betrayal, and the consequences of buried secrets. It keeps readers on the edge of their seats as they race to unravel the mystery alongside the characters.</p>', NULL, NULL, '2024-05-06 03:52:19', '2024-05-06 03:52:19'),
(162, 21, 62, 80, NULL, 'لا تخل', 'لا-تخل', '\"لا تزعج\" هي رواية غامضة ومثيرة من تأليف الكاتبة البريطانية كلير دوجلاس. تدور القصة حول مجموعة من الأصدقاء الذين قرروا قضاء عطلة نهاية الأسبوع بعيدًا في نزل بعيد في المرتفعات الاسكتلندية. ومع ذلك، يتحول ملاذهم الهادئ إلى كابوس عندما يكتشفون جثة امرأة في حوض الاستحمام الساخن.\r\n\r\nبينما يتصارع الأصدقاء مع الصدمة والخوف، ترتفع التوترات، ويدركون أن كل واحد منهم يحمل أسرارًا يمكن أن تكشف حياتهم. ومع تزايد الشك والبارانويا، يجب عليهم مواجهة ماضيهم وفك شبكة الأكاذيب المحيطة بهم لكشف حقيقة ما حدث في تلك الليلة المشؤومة.\r\n\r\nيستكشف فيلم \"عدم الإزعاج\" المليء بالتقلبات والتشويق والعمق النفسي موضوعات الثقة والخيانة وعواقب الأسرار المدفونة. إنه يبقي القراء على حافة مقاعدهم وهم يتسابقون لكشف الغموض إلى جانب الشخصيات.', '<p>\"لا تزعج\" هي رواية غامضة ومثيرة من تأليف الكاتبة البريطانية كلير دوجلاس. تدور القصة حول مجموعة من الأصدقاء الذين قرروا قضاء عطلة نهاية الأسبوع بعيدًا في نزل بعيد في المرتفعات الاسكتلندية. ومع ذلك، يتحول ملاذهم الهادئ إلى كابوس عندما يكتشفون جثة امرأة في حوض الاستحمام الساخن.</p>\r\n<p>بينما يتصارع الأصدقاء مع الصدمة والخوف، ترتفع التوترات، ويدركون أن كل واحد منهم يحمل أسرارًا يمكن أن تكشف حياتهم. ومع تزايد الشك والبارانويا، يجب عليهم مواجهة ماضيهم وفك شبكة الأكاذيب المحيطة بهم لكشف حقيقة ما حدث في تلك الليلة المشؤومة.</p>\r\n<p>يستكشف فيلم \"عدم الإزعاج\" المليء بالتقلبات والتشويق والعمق النفسي موضوعات الثقة والخيانة وعواقب الأسرار المدفونة. إنه يبقي القراء على حافة مقاعدهم وهم يتسابقون لكشف الغموض إلى جانب الشخصيات.</p>\r\n<p>\"لا تزعج\" هي رواية غامضة ومثيرة من تأليف الكاتبة البريطانية كلير دوجلاس. تدور القصة حول مجموعة من الأصدقاء الذين قرروا قضاء عطلة نهاية الأسبوع بعيدًا في نزل بعيد في المرتفعات الاسكتلندية. ومع ذلك، يتحول ملاذهم الهادئ إلى كابوس عندما يكتشفون جثة امرأة في حوض الاستحمام الساخن.</p>\r\n<p>بينما يتصارع الأصدقاء مع الصدمة والخوف، ترتفع التوترات، ويدركون أن كل واحد منهم يحمل أسرارًا يمكن أن تكشف حياتهم. ومع تزايد الشك والبارانويا، يجب عليهم مواجهة ماضيهم وفك شبكة الأكاذيب المحيطة بهم لكشف حقيقة ما حدث في تلك الليلة المشؤومة.</p>\r\n<p>يستكشف فيلم \"عدم الإزعاج\" المليء بالتقلبات والتشويق والعمق النفسي موضوعات الثقة والخيانة وعواقب الأسرار المدفونة. إنه يبقي القراء على حافة مقاعدهم وهم يتسابقون لكشف الغموض إلى جانب الشخصيات.</p>', NULL, NULL, '2024-05-06 03:52:19', '2024-05-06 03:52:19'),
(163, 20, 63, 81, NULL, 'Stationary Bike', 'stationary-bike', 'Introducing the Stationary Bike, your ultimate companion in fitness journey and wellness. Designed to bring the exhilaration of cycling into the comfort of your home, this sleek and sturdy exercise bike offers a dynamic workout experience tailored to your needs.\r\n\r\nCrafted with premium materials and cutting-edge engineering, our Stationary Bike ensures durability and stability, providing a secure platform for your workouts. Whether you\'re a beginner looking to kickstart your fitness routine or a seasoned athlete aiming to push your limits, this bike is built to accommodate users of all fitness levels.', '<p>Introducing the Stationary Bike, your ultimate companion in fitness journey and wellness. Designed to bring the exhilaration of cycling into the comfort of your home, this sleek and sturdy exercise bike offers a dynamic workout experience tailored to your needs.</p>\r\n<p>Crafted with premium materials and cutting-edge engineering, our Stationary Bike ensures durability and stability, providing a secure platform for your workouts. Whether you\'re a beginner looking to kickstart your fitness routine or a seasoned athlete aiming to push your limits, this bike is built to accommodate users of all fitness levels.</p>\r\n<p>Equipped with customizable resistance levels, the Stationary Bike allows you to tailor each session to your desired intensity, helping you achieve your fitness goals effectively. Its smooth and silent operation ensures a seamless ride, allowing you to focus on your workout without any distractions.</p>\r\n<p>Featuring an adjustable seat and handlebars, this bike offers optimal comfort and ergonomics, ensuring proper posture and minimizing strain during extended workouts. The intuitive LCD display keeps you informed of essential metrics such as speed, distance, time, and calories burned, empowering you to track your progress and stay motivated.</p>\r\n<p>Compact and space-saving, the Stationary Bike seamlessly integrates into any home environment, allowing you to enjoy convenient workouts without sacrificing precious space. Its lightweight yet robust construction makes it easy to move around, so you can find the perfect spot for your fitness endeavors.</p>\r\n<p>Experience the joy of cycling year-round, rain or shine, with the Stationary Bike. Whether you\'re aiming to improve your cardiovascular health, build strength, or simply stay active, this versatile exercise bike is your gateway to a healthier, happier lifestyle.</p>', NULL, NULL, '2024-05-06 03:56:09', '2024-05-06 03:56:09'),
(164, 21, 64, 81, NULL, 'دراجة ثابتة', 'دراجة-ثابتة', 'نقدم لكم الدراجة الثابتة، رفيقكم المثالي في رحلة اللياقة البدنية والعافية. صُممت هذه الدراجة الرياضية الأنيقة والمتينة لجلب متعة ركوب الدراجات إلى راحة منزلك، وتوفر تجربة تمرين ديناميكية مصممة خصيصًا لتلبية احتياجاتك.\r\n\r\nتضمن دراجتنا الثابتة، المصنوعة من مواد فاخرة وهندسة متطورة، المتانة والثبات، وتوفر منصة آمنة لتدريباتك. سواء كنت مبتدئًا يتطلع إلى بدء روتين اللياقة البدنية الخاص بك أو رياضيًا متمرسًا يهدف إلى تجاوز حدودك، فقد تم تصميم هذه الدراجة لاستيعاب المستخدمين من جميع مستويات اللياقة البدنية.', '<p>نقدم لكم الدراجة الثابتة، رفيقكم المثالي في رحلة اللياقة البدنية والعافية. صُممت هذه الدراجة الرياضية الأنيقة والمتينة لجلب متعة ركوب الدراجات إلى راحة منزلك، وتوفر تجربة تمرين ديناميكية مصممة خصيصًا لتلبية احتياجاتك.</p>\r\n<p>تضمن دراجتنا الثابتة، المصنوعة من مواد فاخرة وهندسة متطورة، المتانة والثبات، وتوفر منصة آمنة لتدريباتك. سواء كنت مبتدئًا يتطلع إلى بدء روتين اللياقة البدنية الخاص بك أو رياضيًا متمرسًا يهدف إلى تجاوز حدودك، فقد تم تصميم هذه الدراجة لاستيعاب المستخدمين من جميع مستويات اللياقة البدنية.</p>\r\n<p>تتيح لك الدراجة الثابتة، المجهزة بمستويات مقاومة قابلة للتخصيص، تصميم كل جلسة وفقًا للكثافة المرغوبة، مما يساعدك على تحقيق أهداف اللياقة البدنية الخاصة بك بفعالية. يضمن تشغيلها السلس والصامت قيادة سلسة، مما يسمح لك بالتركيز على تمرينك دون أي تشتيت.</p>\r\n<p>تتميز هذه الدراجة بمقعد ومقود قابلين للتعديل، وتوفر الراحة المثالية وبيئة العمل، مما يضمن الوضع المناسب وتقليل الضغط أثناء التدريبات الطويلة. تبقيك شاشة LCD البديهية على علم بالمقاييس الأساسية مثل السرعة والمسافة والوقت والسعرات الحرارية المحروقة، مما يتيح لك تتبع تقدمك والبقاء متحفزًا.</p>\r\n<p>مدمجة وموفرة للمساحة، تندمج الدراجة الثابتة بسلاسة في أي بيئة منزلية، مما يسمح لك بالاستمتاع بتمارين مريحة دون التضحية بالمساحة الثمينة. إن بنيتها خفيفة الوزن ولكنها قوية تجعل من السهل تحريكها، لذلك يمكنك العثور على المكان المثالي لمساعيك في اللياقة البدنية.</p>\r\n<p>استمتع بمتعة ركوب الدراجات على مدار العام، سواء كان الطقس ممطرًا أو مشمسًا، مع الدراجة الثابتة. سواء كنت تهدف إلى تحسين صحة القلب والأوعية الدموية، أو بناء القوة، أو ببساطة البقاء نشيطًا، فإن دراجة التمرين متعددة الاستخدامات هذه هي بوابتك إلى نمط حياة أكثر صحة وسعادة.</p>', NULL, NULL, '2024-05-06 03:56:09', '2024-05-06 03:56:09'),
(165, 20, 61, 82, NULL, 'Ultrasound Machine', 'ultrasound-machine', 'An ultrasound machine is a crucial medical imaging tool that employs high-frequency sound waves to generate images of internal body structures. It comprises a transducer, which emits and receives the sound waves, a console for control and processing, and a display screen for image visualization. Operators manipulate the device by adjusting settings via a keyboard and controls on the console. Before scanning, a gel is applied to the skin to aid in sound wave transmission. These machines are widely used across medical settings for diagnostics, such as examining organs, monitoring pregnancies, and guiding procedures, offering real-time insights into the body\'s internal workings in a non-invasive and safe manner.', '<p>Welcome to the cutting-edge world of medical imaging with our state-of-the-art Ultrasound Machine. Revolutionizing healthcare diagnostics, our Ultrasound Machine offers unparalleled clarity, precision, and versatility, empowering healthcare professionals to deliver exceptional patient care.</p>\r\n<p>Designed with the latest technological advancements, our Ultrasound Machine delivers high-definition imaging, providing detailed insights into anatomical structures with remarkable clarity. From superficial to deep tissue imaging, this advanced system offers exceptional resolution and contrast, enabling accurate diagnosis and treatment planning across a wide range of medical specialties.</p>\r\n<p>With an intuitive user interface and customizable imaging settings, our Ultrasound Machine offers a seamless and efficient workflow, enhancing productivity and reducing scan times. Its ergonomic design and user-friendly controls ensure ease of use for healthcare providers of all skill levels, facilitating confident and precise examinations.</p>\r\n<p>Equipped with a comprehensive suite of imaging modes and advanced features, including Doppler imaging and elastography, our Ultrasound Machine enables comprehensive diagnostic capabilities for a diverse range of clinical applications. Whether it\'s obstetrics, cardiology, musculoskeletal, or vascular imaging, this versatile system delivers exceptional performance and reliability.</p>\r\n<p>Compact yet powerful, our Ultrasound Machine is designed to adapt to diverse clinical environments, from busy hospital settings to remote clinics. Its lightweight and portable design facilitate easy maneuverability, allowing healthcare professionals to bring advanced imaging capabilities directly to the point of care.</p>\r\n<p>Experience the future of medical imaging with our Ultrasound Machine. Engineered for excellence, reliability, and innovation, it represents the pinnacle of diagnostic imaging technology, empowering healthcare providers to make confident diagnoses and improve patient outcomes with precision and efficiency.</p>', NULL, NULL, '2024-05-06 04:02:07', '2024-05-06 04:02:07');
INSERT INTO `product_contents` (`id`, `language_id`, `product_category_id`, `product_id`, `list_id`, `title`, `slug`, `summary`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(166, 21, 62, 82, NULL, 'آلة الموجات فوق الصوتية', 'آلة-الموجات-فوق-الصوتية', 'يعد جهاز الموجات فوق الصوتية أداة تصوير طبية مهمة تستخدم موجات صوتية عالية التردد لإنشاء صور لهياكل الجسم الداخلية. وهو يشتمل على محول طاقة، الذي يرسل ويستقبل الموجات الصوتية، ووحدة تحكم للتحكم والمعالجة، وشاشة عرض لتصور الصورة. يتلاعب المشغلون بالجهاز عن طريق ضبط الإعدادات عبر لوحة المفاتيح وعناصر التحكم الموجودة على وحدة التحكم. قبل المسح، يتم وضع مادة هلامية على الجلد للمساعدة في نقل الموجات الصوتية. تُستخدم هذه الآلات على نطاق واسع عبر الإعدادات الطبية للتشخيص، مثل فحص الأعضاء، ومراقبة حالات الحمل، وتوجيه الإجراءات، مما يوفر رؤى في الوقت الفعلي حول الأعمال الداخلية للجسم بطريقة غير جراحية وآمنة.', '<p>مرحبًا بكم في عالم التصوير الطبي المتطور من خلال جهاز الموجات فوق الصوتية الحديث لدينا. أحدث ثورة في تشخيص الرعاية الصحية، حيث توفر آلة الموجات فوق الصوتية لدينا وضوحًا ودقة وتنوعًا لا مثيل له، مما يمكّن المتخصصين في الرعاية الصحية من تقديم رعاية استثنائية للمرضى.</p>\r\n<p>تم تصميم جهاز الموجات فوق الصوتية الخاص بنا بأحدث التطورات التكنولوجية، ويوفر تصويرًا عالي الدقة، مما يوفر رؤى تفصيلية للهياكل التشريحية بوضوح ملحوظ. من تصوير الأنسجة السطحية إلى العميقة، يوفر هذا النظام المتقدم دقة وتباينًا استثنائيين، مما يتيح التشخيص الدقيق والتخطيط للعلاج عبر مجموعة واسعة من التخصصات الطبية.</p>\r\n<p>بفضل واجهة المستخدم البديهية وإعدادات التصوير القابلة للتخصيص، يوفر جهاز الموجات فوق الصوتية الخاص بنا سير عمل سلسًا وفعالاً، مما يعزز الإنتاجية ويقلل أوقات المسح. يضمن تصميمه المريح وعناصر التحكم سهلة الاستخدام سهولة الاستخدام لمقدمي الرعاية الصحية من جميع مستويات المهارة، مما يسهل إجراء فحوصات موثوقة ودقيقة.</p>\r\n<p>مجهزة بمجموعة شاملة من أوضاع التصوير والميزات المتقدمة، بما في ذلك تصوير دوبلر وتصوير المرونة، تتيح آلة الموجات فوق الصوتية الخاصة بنا إمكانات تشخيصية شاملة لمجموعة متنوعة من التطبيقات السريرية. سواء كان الأمر يتعلق بالتوليد أو أمراض القلب أو تصوير العضلات والعظام أو تصوير الأوعية الدموية، فإن هذا النظام متعدد الاستخدامات يوفر أداءً وموثوقية استثنائيين.</p>\r\n<p>تم تصميم جهاز الموجات فوق الصوتية الخاص بنا، صغير الحجم ولكنه قوي، للتكيف مع البيئات السريرية المتنوعة، بدءًا من إعدادات المستشفيات المزدحمة وحتى العيادات البعيدة. ويسهل تصميمه خفيف الوزن والمحمول سهولة المناورة، مما يسمح لمتخصصي الرعاية الصحية بتوفير إمكانات التصوير المتقدمة مباشرة إلى نقطة الرعاية.</p>\r\n<p>اكتشف مستقبل التصوير الطبي مع جهاز الموجات فوق الصوتية الخاص بنا. تم تصميمه لتحقيق التميز والموثوقية والابتكار، وهو يمثل قمة تكنولوجيا التصوير التشخيصي، مما يمكّن مقدمي الرعاية الصحية من إجراء تشخيصات موثوقة وتحسين نتائج المرضى بدقة وكفاءة.</p>', NULL, NULL, '2024-05-06 04:02:07', '2024-05-06 04:02:07'),
(167, 20, 61, 83, NULL, 'Defibrillator', 'defibrillator', 'A defibrillator is a medical device that delivers an electric shock to the heart to restore its normal rhythm during sudden cardiac arrest. It works by sending a high-energy pulse through the chest, momentarily stopping the heart\'s electrical activity, allowing it to reset and resume its normal beating pattern.', '<p>A defibrillator is a crucial medical device designed to address life-threatening cardiac arrhythmias, particularly ventricular fibrillation (VF) and pulseless ventricular tachycardia (VT), which can lead to sudden cardiac arrest (SCA). SCA occurs when the heart\'s electrical system malfunctions, causing it to beat irregularly or stop altogether. Without prompt intervention, SCA can result in death within minutes.</p>\r\n<p>Defibrillators operate on the principle of delivering an electric shock to the heart to restore its normal rhythm. There are two main types of defibrillators: automated external defibrillators (AEDs) and implantable cardioverter-defibrillators (ICDs).</p>\r\n<p>AEDs are portable devices commonly found in public spaces, workplaces, and healthcare facilities. They are user-friendly and designed to be operated by laypeople with minimal training. A typical AED consists of adhesive electrode pads, which are placed on the patient\'s chest, and a control unit that analyzes the heart rhythm and delivers a shock if necessary. A voice prompt guides the user through the process, providing instructions on when to administer CPR and when to stand clear during shock delivery.</p>\r\n<p>ICDs, on the other hand, are implantable devices surgically placed under the skin, usually in the chest area. They continuously monitor the heart\'s rhythm and automatically deliver shocks if dangerous arrhythmias are detected. ICDs are recommended for individuals at high risk of recurrent arrhythmias, such as those with a history of cardiac arrest or certain cardiac conditions.</p>\r\n<p>The mechanism of action of defibrillation involves delivering a high-energy electrical pulse to the heart, momentarily depolarizing the cardiac cells and allowing the heart\'s natural pacemaker to reestablish a normal rhythm. This process, known as cardioversion, interrupts the chaotic electrical activity in the heart and enables it to resume coordinated contractions, restoring blood flow to vital organs.</p>\r\n<p>Prompt defibrillation is crucial for improving the chances of survival in SCA cases. For every minute that passes without defibrillation, the likelihood of successful resuscitation decreases by approximately 7-10%. Therefore, widespread access to defibrillators in public spaces, along with public awareness and training in cardiopulmonary resuscitation (CPR), plays a vital role in saving lives during cardiac</p>', NULL, NULL, '2024-05-06 04:06:50', '2024-05-06 04:06:50'),
(168, 21, 62, 83, NULL, 'جهاز الصدمات الكهربائية', 'جهاز-الصدمات-الكهربائية', 'مزيل الرجفان هو جهاز طبي يقوم بتوصيل صدمة كهربائية للقلب لاستعادة إيقاعه الطبيعي أثناء السكتة القلبية المفاجئة. وهو يعمل عن طريق إرسال نبض عالي الطاقة عبر الصدر، مما يؤدي إلى إيقاف النشاط الكهربائي للقلب مؤقتًا، مما يسمح له بإعادة ضبط واستئناف نمط الضرب الطبيعي.', '<p>مزيل الرجفان هو جهاز طبي مهم مصمم لمعالجة عدم انتظام ضربات القلب الذي يهدد الحياة، وخاصة الرجفان البطيني (VF) وعدم انتظام دقات القلب البطيني غير النبضي (VT)، والذي يمكن أن يؤدي إلى توقف القلب المفاجئ (SCA). يحدث SCA عندما يتعطل النظام الكهربائي للقلب، مما يؤدي إلى نبضه بشكل غير منتظم أو توقفه تمامًا. وبدون التدخل الفوري، يمكن أن يؤدي مرض SCA إلى الوفاة في غضون دقائق.</p>\r\n<p>تعمل أجهزة تنظيم ضربات القلب على مبدأ توصيل صدمة كهربائية إلى القلب لاستعادة إيقاعه الطبيعي. هناك نوعان رئيسيان من أجهزة تنظيم ضربات القلب: أجهزة تنظيم ضربات القلب الخارجية الآلية (AEDs) وأجهزة تنظيم ضربات القلب القابلة للزرع (ICDs).</p>\r\n<p>أجهزة AED هي أجهزة محمولة توجد عادة في الأماكن العامة وأماكن العمل ومرافق الرعاية الصحية. فهي سهلة الاستخدام ومصممة ليتم تشغيلها بواسطة أشخاص عاديين بأقل قدر من التدريب. يتكون جهاز AED النموذجي من وسادات قطبية لاصقة، يتم وضعها على صدر المريض، ووحدة تحكم تقوم بتحليل إيقاع القلب وتوجيه الصدمة إذا لزم الأمر. يقوم موجه صوتي بتوجيه المستخدم خلال العملية، ويوفر إرشادات حول متى يجب إدارة الإنعاش القلبي الرئوي ومتى يجب الوقوف بوضوح أثناء توصيل الصدمة.</p>\r\n<p>من ناحية أخرى، أجهزة ICD هي أجهزة قابلة للزرع يتم وضعها جراحياً تحت الجلد، عادة في منطقة الصدر. إنهم يراقبون إيقاع القلب بشكل مستمر ويوجهون الصدمات تلقائيًا في حالة اكتشاف حالات عدم انتظام ضربات القلب الخطيرة. يوصى باستخدام أجهزة ICD للأفراد المعرضين لخطر كبير من عدم انتظام ضربات القلب المتكررة، مثل أولئك الذين لديهم تاريخ من السكتة القلبية أو بعض حالات القلب.</p>\r\n<p>تتضمن آلية عمل إزالة الرجفان توصيل نبض كهربائي عالي الطاقة إلى القلب، وإزالة استقطاب خلايا القلب مؤقتًا والسماح لجهاز تنظيم ضربات القلب الطبيعي بالقلب باستعادة الإيقاع الطبيعي. هذه العملية، المعروفة باسم تقويم نظم القلب، تقطع النشاط الكهربائي الفوضوي في القلب وتمكنه من استئناف الانقباضات المنسقة، واستعادة تدفق الدم إلى الأعضاء الحيوية.</p>\r\n<p>يعد إزالة الرجفان الفوري أمرًا بالغ الأهمية لتحسين فرص البقاء على قيد الحياة في حالات SCA. لكل دقيقة تمر دون إزالة الرجفان، تقل احتمالية نجاح الإنعاش بنسبة 7-10٪ تقريبًا. ولذلك، فإن الوصول على نطاق واسع إلى أجهزة تنظيم ضربات القلب في الأماكن العامة، إلى جانب الوعي العام والتدريب على الإنعاش القلبي الرئوي (CPR)، يلعب دورًا حيويًا في إنقاذ الأرواح أثناء أمراض القلب.</p>', NULL, NULL, '2024-05-06 04:06:50', '2024-05-06 04:06:50'),
(169, 20, 63, 84, NULL, 'Pull-Up Bar', 'pull-up-bar', 'A pull-up bar is a simple yet versatile piece of exercise equipment designed for upper body workouts. Typically mounted on a doorframe or installed as a standalone unit, it allows users to perform various exercises targeting muscles like the back, arms, and shoulders. By gripping the bar and lifting one\'s body weight, pull-ups and chin-ups engage multiple muscle groups, promoting strength and endurance. Portable options exist for home use, while gym-grade bars offer durability and stability for intensive workouts.', '<p>Welcome to Pull-Up Pro, your premier destination for high-quality pull-up bars and home fitness equipment! At Pull-Up Pro, we are passionate about helping you achieve your fitness goals and build a stronger, healthier you from the comfort of your own home.</p>\r\n<p>Our extensive selection of pull-up bars caters to fitness enthusiasts of all levels, whether you\'re a beginner looking to kickstart your fitness journey or a seasoned athlete aiming to take your workouts to the next level. From doorway-mounted bars to freestanding power towers, we offer a variety of options to suit your space and training needs.</p>\r\n<p>Each pull-up bar in our collection is meticulously crafted from durable materials to ensure long-lasting performance and safety during your workouts. Our products undergo rigorous quality control measures to guarantee reliability and stability, giving you peace of mind as you focus on your fitness routine.</p>\r\n<p>But we\'re not just about pull-up bars – we\'re dedicated to providing a comprehensive home fitness experience. Explore our range of accessories, including resistance bands, ab straps, and suspension trainers, to enhance your workouts and target different muscle groups effectively.</p>\r\n<p>At Pull-Up Pro, customer satisfaction is our top priority. Our knowledgeable team is here to assist you every step of the way, from selecting the perfect equipment for your needs to offering expert advice on exercise techniques and training programs. We strive to create a seamless shopping experience, with fast shipping and hassle-free returns, so you can start working out sooner rather than later.</p>\r\n<p>Join the Pull-Up Pro community today and unlock your full fitness potential. Whether you\'re striving for strength, endurance, or overall wellness, we\'ve got the tools you need to succeed. Transform your home into a personal gym and make every workout count with Pull-Up Pro – because when it comes to fitness, excellence is non-negotiable.</p>', NULL, NULL, '2024-05-06 04:10:31', '2024-05-06 04:10:31'),
(170, 21, 64, 84, NULL, 'اسحب الشريط', 'اسحب-الشريط', 'شريط السحب عبارة عن قطعة بسيطة ومتعددة الاستخدامات من معدات التمارين المصممة لتدريبات الجزء العلوي من الجسم. يتم تركيبه عادةً على إطار الباب أو تثبيته كوحدة مستقلة، وهو يسمح للمستخدمين بأداء تمارين مختلفة تستهدف العضلات مثل الظهر والذراعين والكتفين. من خلال الإمساك بالقضيب ورفع وزن الجسم، تعمل عمليات السحب والذقن على إشراك مجموعات عضلية متعددة، مما يعزز القوة والتحمل. توجد خيارات محمولة للاستخدام المنزلي، بينما توفر القضبان المخصصة للصالة الرياضية المتانة والثبات للتمرينات المكثفة.', '<p>مرحبًا بك في  وجهتك الأولى لقضبان السحب ومعدات اللياقة البدنية المنزلية عالية الجودة! في  نحن متحمسون لمساعدتك على تحقيق أهداف اللياقة البدنية الخاصة بك وبناء جسم أقوى وأكثر صحة وأنت مرتاح في منزلك.</p>\r\n<p>تلبي مجموعتنا الواسعة من قضبان السحب احتياجات عشاق اللياقة البدنية من جميع المستويات، سواء كنت مبتدئًا يتطلع إلى بدء رحلة اللياقة البدنية الخاصة بك أو رياضيًا متمرسًا يهدف إلى الارتقاء بتدريباتك إلى المستوى التالي. بدءًا من القضبان المثبتة على المداخل وحتى أبراج الطاقة القائمة بذاتها، نقدم مجموعة متنوعة من الخيارات التي تناسب المساحة الخاصة بك واحتياجاتك التدريبية.</p>\r\n<p>تم تصميم كل شريط سحب في مجموعتنا بدقة من مواد متينة لضمان الأداء والسلامة طويل الأمد أثناء التدريبات. تخضع منتجاتنا لإجراءات صارمة لمراقبة الجودة لضمان الموثوقية والثبات، مما يمنحك راحة البال أثناء التركيز على روتين اللياقة البدنية الخاص بك.</p>\r\n<p>ولكننا لا نهتم فقط بقضبان السحب - فنحن ملتزمون بتقديم تجربة شاملة للياقة البدنية في المنزل. استكشف مجموعتنا من الملحقات، بما في ذلك أشرطة المقاومة، وأشرطة البطن، وأجهزة التدريب المعلقة، لتعزيز تدريباتك واستهداف مجموعات العضلات المختلفة بفعالية.</p>\r\n<p>في Pull-Up Pro، رضا العملاء هو أولويتنا القصوى. فريقنا واسع المعرفة موجود هنا لمساعدتك في كل خطوة على الطريق، بدءًا من اختيار المعدات المثالية التي تلبي احتياجاتك ووصولاً إلى تقديم مشورة الخبراء بشأن تقنيات التمارين وبرامج التدريب. نحن نسعى جاهدين لخلق تجربة تسوق سلسة، مع الشحن السريع والإرجاع بدون متاعب، حتى تتمكن من البدء في ممارسة التمارين الرياضية عاجلاً وليس آجلاً.</p>\r\n<p>انضم إلى مجتمع Pull-Up Pro اليوم واطلق العنان لإمكاناتك الكاملة في اللياقة البدنية. سواء كنت تسعى جاهدة للحصول على القوة أو القدرة على التحمل أو الصحة العامة، فلدينا الأدوات التي تحتاجها لتحقيق النجاح. قم بتحويل منزلك إلى صالة ألعاب رياضية شخصية واجعل كل تمرين مهمًا مع Pull-Up Pro - لأنه عندما يتعلق الأمر باللياقة البدنية، فإن التميز غير قابل للتفاوض.</p>', NULL, NULL, '2024-05-06 04:10:31', '2024-05-06 04:10:31'),
(171, 20, 63, 85, NULL, 'Gym book Guidence', 'gym-book-guidence', '\"Gym Book Guidance\" offers comprehensive advice on maximizing your fitness journey. From tailored workout plans to nutritional tips, it serves as a roadmap to achieving your fitness goals. Detailed exercise demonstrations ensure proper form and safety. Additionally, it provides insights into mental well-being, emphasizing the importance of motivation and consistency. With expert guidance on setting realistic targets and tracking progress, this book equips you with the knowledge and tools needed for a successful fitness transformation.', '<p>\"Gym Book Guidance\" is a comprehensive manual designed to be your trusted companion on your fitness journey. Within its pages, you\'ll find a wealth of knowledge curated to empower you with the tools and strategies necessary to achieve your fitness aspirations.</p>\r\n<p>The book begins by delving into the fundamental principles of fitness, laying a solid foundation for understanding the intricate relationship between exercise, nutrition, and mental well-being. It then seamlessly transitions into practical guidance, offering customized workout plans tailored to different fitness levels and goals. Whether you\'re a beginner looking to establish a consistent exercise routine or a seasoned athlete aiming to break through plateaus, you\'ll find targeted exercises and routines to suit your needs.</p>\r\n<p>What sets \"Gym Book Guidance\" apart is its emphasis on proper form and technique. Detailed instructions and illustrations accompany each exercise, ensuring that you perform movements safely and effectively, minimizing the risk of injury while maximizing results. Additionally, the book provides invaluable insights into nutrition, offering practical advice on fueling your body for optimal performance and recovery.</p>\r\n<p>But \"Gym Book Guidance\" is more than just a compilation of exercises and meal plans; it\'s a holistic approach to fitness that recognizes the importance of mental well-being. Throughout the book, you\'ll find motivational tips and strategies to overcome obstacles and stay committed to your goals.</p>\r\n<p>Whether you\'re striving to build muscle, lose weight, or improve overall health and vitality, \"Gym Book Guidance\" equips you with the knowledge and support you need to succeed on your fitness journey.</p>', NULL, NULL, '2024-05-07 21:41:09', '2024-05-07 21:41:09'),
(172, 21, 64, 85, NULL, 'إرشادات كتاب الصالة الرياضية-', 'إرشادات-كتاب-الصالة-الرياضية-', 'يقدم \"إرشادات كتاب الصالة الرياضية-\" نصيحة شاملة حول تحقيق أقصى قدر من رحلة اللياقة البدنية الخاصة بك. بدءًا من خطط التمارين المصممة خصيصًا وحتى النصائح الغذائية، فهو بمثابة خريطة طريق لتحقيق أهداف اللياقة البدنية الخاصة بك. تضمن العروض التوضيحية التفصيلية للتمرين الشكل والسلامة المناسبين. بالإضافة إلى ذلك، فإنه يوفر نظرة ثاقبة للصحة العقلية، مع التركيز على أهمية الدافع والاتساق. بفضل إرشادات الخبراء حول تحديد أهداف واقعية وتتبع التقدم، يزودك هذا الكتاب بالمعرفة والأدوات اللازمة لتحقيق تحول ناجح في اللياقة البدنية.', '<p>\"إرشادات كتاب الصالة الرياضية\" هو دليل شامل مصمم ليكون رفيقك الموثوق به في رحلة اللياقة البدنية الخاصة بك. ستجد ضمن صفحاته ثروة من المعرفة تم إعدادها لتمكينك من خلال الأدوات والاستراتيجيات اللازمة لتحقيق تطلعاتك في اللياقة البدنية.</p>\r\n<p>يبدأ الكتاب بالتعمق في المبادئ الأساسية للياقة البدنية، ووضع أساس متين لفهم العلاقة المعقدة بين التمارين الرياضية والتغذية والصحة العقلية. ثم ينتقل بسلاسة إلى التوجيه العملي، حيث يقدم خطط تمرين مخصصة مصممة خصيصًا لمستويات وأهداف اللياقة البدنية المختلفة. سواء كنت مبتدئًا يتطلع إلى إنشاء روتين تمرين ثابت أو رياضيًا متمرسًا يهدف إلى اختراق حالة الاستقرار، ستجد تمارين وروتينية مستهدفة تناسب احتياجاتك.</p>\r\n<p>ما يميز \"\"إرشادات كتاب الصالة الرياضية\" هو تركيزه على الشكل والتقنية المناسبين. تعليمات مفصلة ورسوم توضيحية تصاحب كل تمرين، مما يضمن أداء الحركات بأمان وفعالية، ويقلل من خطر الإصابة مع تحقيق أقصى قدر من النتائج. بالإضافة إلى ذلك، يقدم الكتاب رؤى لا تقدر بثمن في مجال التغذية، ويقدم نصائح عملية حول تزويد جسمك بالطاقة لتحقيق الأداء الأمثل والتعافي.</p>\r\n<p>لكن \"إرشادات كتاب الصالة الرياضية\" هو أكثر من مجرد مجموعة من التمارين وخطط الوجبات؛ إنه نهج شامل للياقة البدنية يدرك أهمية الصحة العقلية. ستجد في جميع أنحاء الكتاب نصائح واستراتيجيات تحفيزية للتغلب على العقبات والبقاء ملتزمًا بأهدافك.</p>\r\n<p>سواء كنت تسعى جاهدة لبناء العضلات، أو إنقاص الوزن، أو تحسين الصحة والحيوية بشكل عام، فإن \"Gym Book Guidance\" يزودك بالمعرفة والدعم الذي تحتاجه للنجاح في رحلة اللياقة البدنية الخاصة بك.</p>', NULL, NULL, '2024-05-07 21:41:09', '2024-05-07 21:41:09'),
(200, 20, 65, 118, NULL, 'Trade mill', 'trade-mill', '', '<p>A treadmill is one of the most popular and useful fitness machines used for walking, jogging, and running indoors. It is designed with a moving belt that allows a person to exercise in one place without going outside. A treadmill is suitable for people of almost all fitness levels, from beginners to professional athletes. It is commonly used at homes, gyms, fitness centers, hospitals, and rehabilitation centers.</p>\r\n<p>The main purpose of a treadmill is to improve physical fitness, burn calories, strengthen muscles, and support a healthy lifestyle. It helps increase heart rate, improve blood circulation, and build stamina. Regular treadmill exercise can also help reduce body fat, control weight, improve lung capacity, and maintain overall health. For people who cannot go outside because of bad weather, lack of time, or unsafe roads, a treadmill is a very convenient option.</p>\r\n<p>Most modern treadmills come with different speed levels, incline settings, heart rate sensors, calorie counters, distance trackers, and workout programs. The speed can be adjusted according to the user’s comfort. Beginners can start with slow walking, while experienced users can increase the speed for jogging or running. The incline feature makes the workout more challenging by creating the feeling of walking or running uphill. This helps burn more calories and strengthen the legs.</p>\r\n<p>A treadmill is also useful because it allows users to track their progress. The display screen usually shows time, speed, distance, calories burned, and heart rate. This information helps users understand their performance and set fitness goals. Some advanced treadmills also include Bluetooth, speakers, touchscreens, app connectivity, and pre-set training programs.</p>\r\n<p>Using a treadmill regularly can have many health benefits. It helps improve cardiovascular health, increases energy levels, reduces stress, and supports better sleep. It is also helpful for people who want to maintain a daily exercise routine. Since treadmill workouts can be done indoors, users can exercise at any time of the day.</p>\r\n<p>However, safety is very important while using a treadmill. Users should start slowly, wear proper shoes, keep their body balanced, and avoid sudden speed changes. Many treadmills have emergency stop buttons or safety clips to prevent accidents. Proper maintenance is also necessary to keep the treadmill working smoothly. The belt should be cleaned, checked, and lubricated when needed.</p>\r\n<p>In conclusion, a treadmill is an excellent fitness machine for indoor exercise. It is easy to use, effective, and suitable for different fitness goals. Whether someone wants to lose weight, improve stamina, stay active, or maintain good health, a treadmill can be a very helpful exercise equipment.</p>', NULL, NULL, '2025-11-03 06:53:53', '2026-05-12 23:34:50'),
(201, 21, 64, 118, NULL, 'مطحنة التجارة', 'مطحنة-التجارة', '', '<p>جهاز المشي الكهربائي، أو ما يُعرف بالتريدميل، هو واحد من أشهر أجهزة اللياقة البدنية وأكثرها استخدامًا لممارسة المشي والركض والجري داخل المنزل أو في صالات الرياضة. يتميز هذا الجهاز بوجود حزام متحرك يساعد المستخدم على ممارسة التمارين في مكان ثابت دون الحاجة إلى الخروج إلى الشارع أو الحديقة.</p>\r\n<p>يُستخدم جهاز المشي لتحسين اللياقة البدنية، حرق السعرات الحرارية، تقوية عضلات الجسم، والمحافظة على نمط حياة صحي. كما يساعد على تحسين صحة القلب، تنشيط الدورة الدموية، زيادة القدرة على التحمل، وتقليل الدهون في الجسم. ويُعد خيارًا مناسبًا للأشخاص الذين لا يستطيعون ممارسة الرياضة في الخارج بسبب سوء الطقس أو ضيق الوقت أو عدم توفر مكان مناسب للمشي.</p>\r\n<p>تتوفر في معظم أجهزة المشي الحديثة عدة مميزات مثل التحكم في السرعة، ضبط مستوى الميل، قياس نبضات القلب، حساب السعرات الحرارية، عرض المسافة المقطوعة، وتحديد مدة التمرين. يستطيع المبتدئ أن يبدأ بالمشي البطيء، بينما يمكن للشخص المتقدم زيادة السرعة للركض أو الجري. كما أن خاصية الميل تجعل التمرين أكثر صعوبة وتشبه المشي على طريق مرتفع، مما يساعد على حرق سعرات حرارية أكثر وتقوية عضلات الساقين.</p>\r\n<p>يساعد جهاز المشي المستخدم على متابعة تقدمه بشكل واضح، حيث تعرض الشاشة معلومات مهمة مثل الوقت، السرعة، المسافة، السعرات المحروقة، ومعدل ضربات القلب. وبعض الأجهزة المتطورة تحتوي أيضًا على تقنيات حديثة مثل البلوتوث، السماعات، الشاشة اللمسية، والاتصال بتطبيقات اللياقة البدنية.</p>\r\n<p>إن استخدام جهاز المشي بانتظام له فوائد صحية عديدة، فهو يساعد على تقوية القلب، زيادة النشاط والطاقة، تقليل التوتر، تحسين النوم، والمحافظة على الوزن المثالي. كما أنه مناسب للأشخاص من مختلف الأعمار ومستويات اللياقة، بشرط استخدامه بطريقة صحيحة وآمنة.</p>\r\n<p>ومن المهم عند استخدام جهاز المشي ارتداء حذاء رياضي مناسب، البدء بسرعة منخفضة، الحفاظ على توازن الجسم، وعدم تغيير السرعة بشكل مفاجئ. كما تحتوي العديد من الأجهزة على زر إيقاف طارئ أو مفتاح أمان لحماية المستخدم من الحوادث. ويجب أيضًا الاهتمام بتنظيف الجهاز وصيانته بانتظام حتى يعمل بشكل جيد لفترة طويلة.</p>\r\n<p>في الختام، يُعتبر جهاز المشي الكهربائي من أفضل أجهزة التمارين المنزلية والرياضية، لأنه سهل الاستخدام وفعّال ومناسب لتحقيق أهداف صحية مختلفة مثل إنقاص الوزن، تحسين اللياقة، زيادة القدرة على التحمل، والمحافظة على</p>', NULL, NULL, '2025-11-03 06:53:53', '2026-05-12 23:34:50');

-- --------------------------------------------------------

--
-- Table structure for table `product_coupons`
--

CREATE TABLE `product_coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `value` decimal(8,2) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `minimum_spend` decimal(8,2) UNSIGNED DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_coupons`
--

INSERT INTO `product_coupons` (`id`, `name`, `code`, `type`, `value`, `start_date`, `end_date`, `minimum_spend`, `vendor_id`, `created_at`, `updated_at`) VALUES
(12, 'Hot Sell', 'hotsell', 'fixed', 70.00, '2024-03-09', '2028-07-26', 100.00, NULL, '2023-07-12 00:29:49', '2024-05-01 03:57:30'),
(19, 'Flash Discount', 'F0080', 'percentage', 10.00, '2024-04-30', '2025-09-28', 0.00, NULL, '2024-05-01 03:56:55', '2025-11-22 03:23:07'),
(21, 'low price', 'low', 'fixed', 34.00, '2025-09-01', '2025-10-09', 33.00, 207, '2025-09-17 03:57:38', '2025-09-17 04:01:04');

-- --------------------------------------------------------

--
-- Table structure for table `product_messages`
--

CREATE TABLE `product_messages` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_messages`
--

INSERT INTO `product_messages` (`id`, `product_id`, `vendor_id`, `name`, `email`, `message`, `created_at`, `updated_at`) VALUES
(1, 2, 204, 'Azim Ahmed', 'daspobin027@gmail.com', 'Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?', '2024-05-07 23:39:58', '2024-05-07 23:39:58'),
(2, 3, 204, 'المثالية مع', 'azimahmed11040@gmail.com', 'Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?', '2024-05-07 23:40:17', '2024-05-07 23:40:17'),
(3, 2, 204, 'Flash Discount', 'daspobin027@gmail.com', 'Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?', '2024-05-07 23:40:42', '2024-05-07 23:40:42'),
(5, 113, 222, 'Ashton Burns', 'xobeca@mailinator.com', 'Dolores ut earum dol', '2025-10-25 06:30:30', '2025-10-25 06:30:30'),
(6, 117, 207, 'Bevis Bishop', 'cejope8172@hh7f.com', '{\"phone_number\":{\"value\":\"+1 (903) 568-5323\",\"type\":1},\"product_name\":{\"value\":\"Todd Guerrero\",\"type\":1},\"quantity_needed\":{\"value\":\"326\",\"type\":1},\"product_details\":{\"value\":\"Sit repellendus Ut\",\"type\":5},\"delivery_location\":{\"value\":\"Rerum suscipit at qu\",\"type\":1},\"expected_delivery_date\":{\"value\":\"1977-04-29\",\"type\":6},\"expected_budget_(optional)\":{\"value\":\"79\",\"type\":2},\"additional_comments\\/note\":{\"value\":\"Beatae dolorum conse\",\"type\":1}}', '2025-10-27 06:01:49', '2025-10-27 06:01:49'),
(7, 117, 207, 'Quinlan Burnett', 'cejope8172@hh7f.com', '{\"phone_number\":{\"value\":\"+1 (358) 386-2379\",\"type\":1},\"product_name\":{\"value\":\"Mary Nash\",\"type\":1},\"quantity_needed\":{\"value\":\"930\",\"type\":1},\"product_details\":{\"value\":\"Nulla culpa sed sed\",\"type\":5},\"delivery_location\":{\"value\":\"Vel velit eveniet\",\"type\":1},\"expected_delivery_date\":{\"value\":\"1990-10-16\",\"type\":6},\"expected_budget_(optional)\":{\"value\":\"24\",\"type\":2},\"additional_comments\\/note\":{\"value\":\"Velit tempore sapie\",\"type\":1}}', '2025-10-27 06:07:19', '2025-10-27 06:07:19');

-- --------------------------------------------------------

--
-- Table structure for table `product_orders`
--

CREATE TABLE `product_orders` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `order_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `billing_country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `shipping_country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `total` decimal(8,2) UNSIGNED NOT NULL,
  `discount` decimal(8,2) UNSIGNED DEFAULT NULL,
  `product_shipping_charge_id` bigint UNSIGNED DEFAULT NULL,
  `shipping_cost` decimal(8,2) UNSIGNED DEFAULT NULL,
  `tax` decimal(8,2) UNSIGNED NOT NULL,
  `grand_total` decimal(8,2) UNSIGNED NOT NULL,
  `currency_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `currency_text_position` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `currency_symbol_position` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `gateway_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `payment_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `order_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conversation_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_id` bigint UNSIGNED DEFAULT NULL,
  `total_commission` decimal(12,2) DEFAULT NULL,
  `admin_amount_with_commission` decimal(16,2) DEFAULT NULL,
  `vendor_net_amount` json DEFAULT NULL,
  `per_vendor_discount_and_commission` json DEFAULT NULL,
  `fcm_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_orders`
--

INSERT INTO `product_orders` (`id`, `user_id`, `order_number`, `billing_name`, `billing_email`, `billing_phone`, `billing_address`, `billing_city`, `billing_state`, `billing_country`, `shipping_name`, `shipping_email`, `shipping_phone`, `shipping_address`, `shipping_city`, `shipping_state`, `shipping_country`, `total`, `discount`, `product_shipping_charge_id`, `shipping_cost`, `tax`, `grand_total`, `currency_text`, `currency_text_position`, `currency_symbol`, `currency_symbol_position`, `payment_method`, `gateway_type`, `payment_status`, `order_status`, `attachment`, `invoice`, `created_at`, `updated_at`, `conversation_id`, `vendor_id`, `total_commission`, `admin_amount_with_commission`, `vendor_net_amount`, `per_vendor_discount_and_commission`, `fcm_token`) VALUES
(42, 1, '663af98139f93', 'Azim Ahmed', 'azimahmed11040@gmail.com', '01775891798', 'uttara', 'Dhaka', NULL, 'Bangladesh', 'Azim Ahmed', 'azimahmed11040@gmail.com', '01775891798', 'uttara', 'Dhaka', NULL, 'Bangladesh', 3046.00, 0.00, 13, 0.00, 152.30, 3198.30, 'USD', 'left', '$', 'left', 'Stripe', 'online', 'completed', 'completed', NULL, '663af98139f93.pdf', '2024-05-07 22:03:13', '2024-05-07 22:04:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 1, '663afaa4b22fd', 'Azim Ahmed', 'azimahmed11040@gmail.com', '01775891798', 'uttara', 'Dhaka', NULL, 'Bangladesh', 'Azim Ahmed', 'azimahmed11040@gmail.com', '01775891798', 'uttara', 'Dhaka', NULL, 'Bangladesh', 4178.00, 0.00, 14, 5.00, 208.90, 4391.90, 'USD', 'left', '$', 'left', 'PayPal', 'online', 'completed', 'processing', NULL, '663afaa4b22fd.pdf', '2024-05-07 22:08:04', '2024-05-07 22:08:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 1, '663afba4ed827', 'Azim Ahmed', 'azimahmed11040@gmail.com', '01775891798', 'uttara', 'Dhaka', NULL, 'Bangladesh', 'Azim Ahmed', 'azimahmed11040@gmail.com', '01775891798', 'uttara', 'Dhaka', NULL, 'Bangladesh', 1597.00, 0.00, 14, 5.00, 79.85, 1681.85, 'USD', 'left', '$', 'left', 'Citibank', 'offline', 'rejected', 'rejected', NULL, NULL, '2024-05-07 22:12:20', '2024-05-07 22:12:36', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(45, 1, '663affaad00a4', 'Azim Ahmed', 'azimahmed11040@gmail.com', '01775891798', 'uttara', 'Dhaka', NULL, 'Bangladesh', 'Azim Ahmed', 'azimahmed11040@gmail.com', '01775891798', 'uttara', 'Dhaka', NULL, 'Bangladesh', 977.00, 0.00, 14, 5.00, 48.85, 1030.85, 'USD', 'left', '$', 'left', 'Bank of America', 'offline', 'pending', 'pending', '663affaace58d.jpg', NULL, '2024-05-07 22:29:30', '2024-05-07 22:29:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(63, 2, '6908a702bb478', 'Bill Gates', 'daspobin027@gmail.com', '9932323232', '945 Madison Ave, New York, NY 10021, USA', 'New York', 'New York', 'United States', 'Bill Gates', 'daspobin027@gmail.com', '9932323232', '945 Madison Ave, New York, NY 10021, USA', 'New York', 'New York', 'United States', 222.00, 0.00, 15, 10.00, 12.00, 244.00, 'PHP', 'right', '$', 'left', 'Xendit', 'online', 'completed', 'pending', NULL, '6908a702bb478.pdf', '2025-11-03 06:58:42', '2025-11-03 06:58:43', NULL, NULL, 12.30, 111.30, '{\"204\": 110.7}', '{\"204\": {\"tax_share\": 6.65, \"cart_total\": 123, \"commission\": 12.3, \"discount_share\": 0, \"net_total_after_subtract\": 110.7}}', NULL),
(65, NULL, '6921a28de4689', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', '', 'bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', NULL, 'bangladesh', 9.00, 0.00, NULL, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'PayPal', 'online', 'completed', 'pending', NULL, '6921a28de4689.pdf', '2025-11-22 05:46:21', '2025-11-22 05:46:22', NULL, NULL, 0.00, 9.00, '[]', '[]', NULL),
(66, NULL, '6921a2b859de5', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', '', 'bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', NULL, 'bangladesh', 9.00, 2.00, NULL, 0.00, 0.00, 7.00, 'USD', 'right', '$', 'left', 'PayPal', 'online', 'completed', 'pending', NULL, '6921a2b859de5.pdf', '2025-11-22 05:47:04', '2025-11-22 05:47:04', NULL, NULL, 0.00, 7.00, '[]', '[]', NULL),
(67, NULL, '6921a3801d3fc', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', '', 'bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', NULL, 'bangladesh', 9.00, 2.00, NULL, 0.00, 0.00, 7.00, 'USD', 'right', '$', 'left', 'PayPal', 'online', 'completed', 'pending', NULL, '6921a3801d3fc.pdf', '2025-11-22 05:50:24', '2025-11-22 05:50:24', NULL, NULL, 0.00, 7.00, '[]', '[]', NULL),
(68, NULL, '6921a58048e87', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', '', 'bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', NULL, 'bangladesh', 9.00, 2.00, NULL, 0.00, 0.00, 7.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'completed', 'pending', NULL, '6921a58048e87.pdf', '2025-11-22 05:58:56', '2025-11-22 05:59:07', NULL, NULL, 0.00, 7.00, '[]', '[]', NULL),
(69, NULL, '6921a633196dc', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', '', 'bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'uttarra', 'dhaka', NULL, 'bangladesh', 9.00, 2.00, NULL, 0.00, 0.00, 7.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6921a633196dc.pdf', '2025-11-22 06:01:55', '2025-11-22 06:01:55', NULL, NULL, 0.00, 7.00, '[]', '[]', NULL),
(70, NULL, '6921a7cca0a85', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, NULL, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6921a7cca0a85.pdf', '2025-11-22 06:08:44', '2025-11-22 06:08:45', NULL, NULL, 0.00, 9.00, '[]', '[]', NULL),
(71, NULL, '6921aff574842', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, NULL, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6921aff574842.pdf', '2025-11-22 06:43:33', '2025-11-22 06:43:33', NULL, NULL, 0.00, 9.00, '[]', '[]', NULL),
(72, NULL, '6926b28c3fe83', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, NULL, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6926b28c3fe83.pdf', '2025-11-26 01:55:56', '2025-11-26 01:55:58', NULL, NULL, 0.00, 9.00, '[]', '[]', NULL),
(73, NULL, '6933d8eb3266c', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, 13, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6933d8eb3266c.pdf', '2025-12-06 01:19:07', '2025-12-06 01:19:08', NULL, NULL, 0.00, 9.00, '[]', '[]', NULL),
(74, NULL, '6933ed740c25d', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, 13, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6933ed740c25d.pdf', '2025-12-06 02:46:44', '2025-12-06 02:46:44', NULL, NULL, 0.00, 9.00, '[]', '[]', 'bkash'),
(75, NULL, '6933ef23370ac', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, 13, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6933ef23370ac.pdf', '2025-12-06 02:53:55', '2025-12-06 02:53:55', NULL, NULL, 0.00, 9.00, '[]', '[]', 'bkash'),
(76, NULL, '6933ef41e2e7f', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, 13, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6933ef41e2e7f.pdf', '2025-12-06 02:54:25', '2025-12-06 02:54:26', NULL, NULL, 0.00, 9.00, '[]', '[]', 'bk jfghjash'),
(77, NULL, '6933ef5c70001', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, 13, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6933ef5c70001.pdf', '2025-12-06 02:54:52', '2025-12-06 02:54:52', NULL, NULL, 0.00, 9.00, '[]', '[]', 'bk jfghjash'),
(78, NULL, '6933ef6a09965', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, 13, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6933ef6a09965.pdf', '2025-12-06 02:55:06', '2025-12-06 02:55:06', NULL, NULL, 0.00, 9.00, '[]', '[]', 'bk jfghjash'),
(79, NULL, '6933ef79ece53', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', '', 'Bangladesh', 'saiful islam sharif', 'saifislamfci@gmail.com', '01872330757', 'Bangladesh', 'Dhaka', NULL, 'Bangladesh', 9.00, 0.00, 13, 0.00, 0.00, 9.00, 'USD', 'right', '$', 'left', 'bkash', 'offline', 'pending', 'pending', NULL, '6933ef79ece53.pdf', '2025-12-06 02:55:21', '2025-12-06 02:55:22', NULL, NULL, 0.00, 9.00, '[]', '[]', 'bk jfghjash'),
(84, 2, '6a01d36991d7e', 'Bill Gates', 'daspobin027@gmail.com', '11112', 'sasasasassasasasa', 'asasasas', 'sasasa', 'sasassa', 'Bill Gates', 'daspobin027@gmail.com', '11112', 'sasasasassasasasa', 'asasasas', 'sasasa', 'sasassa', 399.00, 0.00, 13, 0.00, 20.00, 419.00, 'USD', 'right', '$', 'left', 'Bank of America', 'offline', 'completed', 'completed', '6a01d3698fa3a.png', '6a01d36991d7e.pdf', '2026-05-11 07:02:33', '2026-05-11 07:05:20', NULL, NULL, 39.90, 39.90, '{\"201\": 359.1}', '{\"201\": {\"tax_share\": 20, \"cart_total\": 399, \"commission\": 39.900000000000006, \"discount_share\": 0, \"net_total_after_subtract\": 359.1}}', NULL),
(90, 2, '6a01e73d9ab9a', 'xagovynuk@mailinator.com', 'kefeqeni@mailinator.com', 'wyqesom@mailinator.com', 'Iusto architecto dis', 'jeqylofyx@mailinator.com', 'jaxunugodo@mailinator.com', 'jaqegovaqa@mailinator.com', 'xagovynuk@mailinator.com', 'kefeqeni@mailinator.com', 'wyqesom@mailinator.com', 'Iusto architecto dis', 'jeqylofyx@mailinator.com', 'jaxunugodo@mailinator.com', 'jaqegovaqa@mailinator.com', 399.00, 0.00, 13, 0.00, 20.00, 419.00, 'USD', 'right', '$', 'left', 'Bank of America', 'offline', 'pending', 'pending', '6a01e73d99247.png', NULL, '2026-05-11 08:27:09', '2026-05-11 08:27:09', NULL, NULL, 39.90, 39.90, '{\"201\": 359.1}', '{\"201\": {\"tax_share\": 20, \"cart_total\": 399, \"commission\": 39.900000000000006, \"discount_share\": 0, \"net_total_after_subtract\": 359.1}}', NULL),
(91, 2, '6a01e7cb04262', 'vepah@mailinator.com', 'nesywurojy@mailinator.com', 'rypa@mailinator.com', 'Magni sunt voluptate', 'mazudov@mailinator.com', 'miqawe@mailinator.com', 'vonipe@mailinator.com', 'vepah@mailinator.com', 'nesywurojy@mailinator.com', 'rypa@mailinator.com', 'Magni sunt voluptate', 'mazudov@mailinator.com', 'miqawe@mailinator.com', 'vonipe@mailinator.com', 399.00, 0.00, 13, 0.00, 20.00, 419.00, 'USD', 'right', '$', 'left', 'Bank of America', 'offline', 'pending', 'pending', '6a01e7cb02442.png', NULL, '2026-05-11 08:29:31', '2026-05-11 08:29:31', NULL, NULL, 39.90, 39.90, '{\"201\": 359.1}', '{\"201\": {\"tax_share\": 20, \"cart_total\": 399, \"commission\": 39.900000000000006, \"discount_share\": 0, \"net_total_after_subtract\": 359.1}}', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_purchase_items`
--

CREATE TABLE `product_purchase_items` (
  `id` bigint UNSIGNED NOT NULL,
  `product_order_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `quantity` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `vendor_id` bigint UNSIGNED DEFAULT NULL,
  `vendor_net_amount` decimal(16,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_purchase_items`
--

INSERT INTO `product_purchase_items` (`id`, `product_order_id`, `product_id`, `title`, `quantity`, `created_at`, `updated_at`, `vendor_id`, `vendor_net_amount`) VALUES
(61, 42, 85, 'Gym book Guidence', 1, '2024-05-07 22:03:13', '2024-05-07 22:03:13', NULL, NULL),
(62, 42, 83, 'Defibrillator', 1, '2024-05-07 22:03:13', '2024-05-07 22:03:13', NULL, NULL),
(63, 42, 84, 'Pull-Up Bar', 1, '2024-05-07 22:03:13', '2024-05-07 22:03:13', NULL, NULL),
(64, 42, 78, 'Salon Chair', 1, '2024-05-07 22:03:13', '2024-05-07 22:03:13', NULL, NULL),
(65, 42, 71, 'Surgical Lights', 1, '2024-05-07 22:03:13', '2024-05-07 22:03:13', NULL, NULL),
(66, 42, 73, 'Infusion Pump', 1, '2024-05-07 22:03:13', '2024-05-07 22:03:13', NULL, NULL),
(67, 43, 85, 'Gym book Guidence', 1, '2024-05-07 22:08:04', '2024-05-07 22:08:04', NULL, NULL),
(68, 43, 80, 'Do not Distrub', 1, '2024-05-07 22:08:04', '2024-05-07 22:08:04', NULL, NULL),
(69, 43, 83, 'Defibrillator', 4, '2024-05-07 22:08:04', '2024-05-07 22:08:04', NULL, NULL),
(70, 43, 78, 'Salon Chair', 2, '2024-05-07 22:08:04', '2024-05-07 22:08:04', NULL, NULL),
(71, 43, 73, 'Infusion Pump', 3, '2024-05-07 22:08:04', '2024-05-07 22:08:04', NULL, NULL),
(72, 44, 83, 'Defibrillator', 1, '2024-05-07 22:12:20', '2024-05-07 22:12:20', NULL, NULL),
(73, 44, 79, 'Shampoo Bowl', 1, '2024-05-07 22:12:21', '2024-05-07 22:12:21', NULL, NULL),
(74, 44, 74, 'Treadmill', 1, '2024-05-07 22:12:21', '2024-05-07 22:12:21', NULL, NULL),
(75, 45, 77, 'Hair Curler', 1, '2024-05-07 22:29:30', '2024-05-07 22:29:30', NULL, NULL),
(76, 45, 79, 'Shampoo Bowl', 1, '2024-05-07 22:29:30', '2024-05-07 22:29:30', NULL, NULL),
(77, 45, 81, 'Stationary Bike', 1, '2024-05-07 22:29:30', '2024-05-07 22:29:30', NULL, NULL),
(112, 63, 118, 'Exercise Bike', 1, '2025-11-03 06:58:42', '2025-11-03 06:58:42', 204, NULL),
(113, 63, 79, 'Shampoo Bowl', 1, '2025-11-03 06:58:42', '2025-11-03 06:58:42', NULL, NULL),
(116, 65, 80, 'Do not Distrub', 2, '2025-11-22 05:46:21', '2025-11-22 05:46:21', NULL, NULL),
(117, 66, 80, 'Do not Distrub', 2, '2025-11-22 05:47:04', '2025-11-22 05:47:04', NULL, NULL),
(118, 67, 80, 'Do not Distrub', 2, '2025-11-22 05:50:24', '2025-11-22 05:50:24', NULL, NULL),
(119, 68, 80, 'Do not Distrub', 2, '2025-11-22 05:58:56', '2025-11-22 05:58:56', NULL, NULL),
(120, 69, 80, 'Do not Distrub', 2, '2025-11-22 06:01:55', '2025-11-22 06:01:55', NULL, NULL),
(121, 70, 80, 'Do not Distrub', 2, '2025-11-22 06:08:44', '2025-11-22 06:08:44', NULL, NULL),
(122, 71, 80, 'Do not Distrub', 2, '2025-11-22 06:43:33', '2025-11-22 06:43:33', NULL, NULL),
(123, 72, 80, 'Do not Distrub', 2, '2025-11-26 01:55:56', '2025-11-26 01:55:56', NULL, NULL),
(124, 73, 80, 'Do not Distrub', 2, '2025-12-06 01:19:07', '2025-12-06 01:19:07', NULL, NULL),
(125, 74, 80, 'Do not Distrub', 2, '2025-12-06 02:46:44', '2025-12-06 02:46:44', NULL, NULL),
(126, 75, 80, 'Do not Distrub', 2, '2025-12-06 02:53:55', '2025-12-06 02:53:55', NULL, NULL),
(127, 76, 80, 'Do not Distrub', 2, '2025-12-06 02:54:25', '2025-12-06 02:54:25', NULL, NULL),
(128, 77, 80, 'Do not Distrub', 2, '2025-12-06 02:54:52', '2025-12-06 02:54:52', NULL, NULL),
(129, 78, 80, 'Do not Distrub', 2, '2025-12-06 02:55:06', '2025-12-06 02:55:06', NULL, NULL),
(130, 79, 80, 'Do not Distrub', 2, '2025-12-06 02:55:21', '2025-12-06 02:55:21', NULL, NULL),
(135, 84, 78, 'Salon Chair', 1, '2026-05-11 07:02:33', '2026-05-11 07:02:33', 201, NULL),
(141, 90, 78, 'Salon Chair', 1, '2026-05-11 08:27:09', '2026-05-11 08:27:09', 201, NULL),
(142, 91, 78, 'Salon Chair', 1, '2026-05-11 08:29:31', '2026-05-11 08:29:31', 201, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `rating` smallint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_reviews`
--

INSERT INTO `product_reviews` (`id`, `user_id`, `product_id`, `comment`, `rating`, `created_at`, `updated_at`) VALUES
(2, 1, 85, '\"Guidance\" is not just a book; it\'s a personal trainer, a nutritionist, and a motivator, all bound within its pages. From the moment I cracked it open, I knew I had found the ultimate companion for my fitness journey.\r\n\r\nWhat sets \"Guidance\" apart is its holistic approach to health and fitness. It doesn\'t just focus on workouts; it delves deep into the science behind exercise, nutrition, and mindset. The explanations are clear and concise, making complex concepts easy to understand for beginners and seasoned gym-goers alike.', 5, '2024-05-07 22:13:49', '2024-05-07 22:14:31'),
(3, 1, 71, 'df', 4, '2024-05-07 22:14:55', '2024-05-07 22:14:55'),
(4, 1, 78, NULL, 3, '2024-05-07 22:15:29', '2024-05-07 22:15:29'),
(5, 1, 83, NULL, 4, '2024-05-07 22:15:47', '2024-05-07 22:15:47'),
(6, 1, 80, NULL, 2, '2024-05-07 22:16:04', '2024-05-07 22:16:04'),
(7, 2, 78, 'Excellent service and very professional communication. The work was completed on time with great attention to detail. Everything was handled smoothly and exactly as expected. Highly recommended for anyone looking for reliable and quality service.', 5, '2026-05-12 08:21:33', '2026-05-12 08:21:33');

-- --------------------------------------------------------

--
-- Table structure for table `product_shipping_charges`
--

CREATE TABLE `product_shipping_charges` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `short_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_charge` decimal(8,2) UNSIGNED NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_shipping_charges`
--

INSERT INTO `product_shipping_charges` (`id`, `language_id`, `title`, `short_text`, `shipping_charge`, `serial_number`, `created_at`, `updated_at`) VALUES
(13, 20, 'Free Shipping', 'Shipment will be within 10-15 Days.', 0.00, 1, '2023-08-19 23:13:03', '2023-08-19 23:13:03'),
(14, 20, 'Standard Shipping', 'Shipment will be within 5-10 Day.', 5.00, 2, '2023-08-19 23:13:30', '2023-08-19 23:13:30'),
(15, 20, '2-Day Shipping', 'Shipment will be within 2 Days.', 10.00, 3, '2023-08-19 23:13:56', '2023-08-19 23:13:56'),
(16, 20, 'Same Day Shipping', 'Shipment will be within 1 Day.', 20.00, 4, '2023-08-19 23:14:17', '2023-08-19 23:14:17'),
(17, 21, 'الشحن مجانا', 'ستكون الشحنة في غضون 10-15 يومًا.', 0.00, 1, '2023-08-19 23:14:44', '2023-08-19 23:14:44'),
(18, 21, 'شحن قياسي', 'سيتم الشحن في غضون 5-10 يوم.', 5.00, 2, '2023-08-19 23:15:04', '2023-08-19 23:15:04'),
(19, 21, 'شحن لمدة يومين', 'ستكون الشحنة في غضون يومين.', 10.00, 3, '2023-08-19 23:15:23', '2023-08-19 23:15:23'),
(20, 21, 'نفس الشحن يوم', 'ستكون الشحنة في غضون يوم واحد.', 20.00, 4, '2023-08-19 23:15:40', '2023-08-19 23:15:40');

-- --------------------------------------------------------

--
-- Table structure for table `push_subscriptions`
--

CREATE TABLE `push_subscriptions` (
  `id` bigint UNSIGNED NOT NULL,
  `subscribable_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `subscribable_id` bigint UNSIGNED NOT NULL,
  `endpoint` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `public_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `auth_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `content_encoding` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `push_subscriptions`
--

INSERT INTO `push_subscriptions` (`id`, `subscribable_type`, `subscribable_id`, `endpoint`, `public_key`, `auth_token`, `content_encoding`, `created_at`, `updated_at`) VALUES
(4, 'App\\Models\\Guest', 4, 'https://fcm.googleapis.com/fcm/send/flEhRYIHDVo:APA91bFQITwjEf1JiVAzyMs2BnJcRFc51Jwq9HaueeV3sVg0x3KTBVnAjeagfVeJyV_Z9HOrye_ySB9nVOb7zilXBej-K-zBTYpWbkb-bWfuGOY6U0fQPA0hamXkg4b4t6pfjm_E7ZiT', 'BC-1oU5LYywIix1iUwzOhoz56hXX1F0G24WiHUSdUzvSnsWMTV4mMAA-P-jbI1c4CisYkw21e0L5PKM_Mse9zcY', 'LC_QKytx_tApJyxn_vi_-w', NULL, '2024-05-21 04:06:22', '2024-05-21 04:06:22'),
(7, 'App\\Models\\Guest', 7, 'https://fcm.googleapis.com/fcm/send/c8XVe3f_tJc:APA91bHzoWoarafQ9yN0NvWJ40vPWyDeLnaw_Wqbm85Xrc1QlXcxS0Qa3oDiQc7Y6f9Pmyj6b7c2FnNz9b6uHRqwfYGfWO7lRaZxO-8_T2w6JXKV3aTXF0uFrLSs4sDseMn3blEB0iDc', 'BM88u6U9zASUsaomE0POvoLjG3lrtmZBJvNnKQ0oOiHhIhXI0JZH_8iaB9oOYaoPRfm-4edxdgmcEJAftk0S-4c', 'jfE6BBQ9J-wrG1-5uu3hlg', NULL, '2024-05-22 02:58:11', '2024-05-22 02:58:11'),
(10, 'App\\Models\\Guest', 10, 'https://fcm.googleapis.com/fcm/send/dnSze7t5tAs:APA91bHjfo1pSMafpV2cHXURCr1zbheCWNEFUOhdzEtsQkb2o0xWi6knO1ovl4KgSE0AY2r26csSiWKf5pZQzP1f43VzOlFfh-8lSdNZAuRioIgV_dJV2On7uoGGfwuot_FiMwnq_DUA', 'BJzxI8TEHnY2hbyEpyzpmuOvhAuINoy9yMROiNUegJbYrubYaGzs7rv379QHMDmkQi6LHe9KB8MwgHtKE8vGy98', 'edWOhIs2qxcZUJRNoWHyPw', NULL, '2024-06-23 00:30:12', '2024-06-23 00:30:12'),
(11, 'App\\Models\\Guest', 11, 'https://fcm.googleapis.com/fcm/send/dqTWShBKda4:APA91bEj6e7yaguVik1fJdOfZxZwWzkjIbtCPuzCtFhmbi3g1TmSvmZUvwcdPurox4XT9hatxpe4W8fD-uqfbCu2eH1pNBZL_ZOiOmuPyp6Kn4a4ln84MIPP4RSsTxVsGiuaLyKhDFZj', 'BJzxI8TEHnY2hbyEpyzpmuOvhAuINoy9yMROiNUegJbYrubYaGzs7rv379QHMDmkQi6LHe9KB8MwgHtKE8vGy98', 'edWOhIs2qxcZUJRNoWHyPw', NULL, '2024-09-30 21:33:54', '2024-09-30 21:33:54'),
(12, 'App\\Models\\Guest', 12, 'https://fcm.googleapis.com/fcm/send/cxzkYsgQ2oU:APA91bGNLPJwyzbqRFyTqfe_r_dHjfJYsSHaZ5vGF1S1cRMBkbRTai203yvsoUNv5vsJD_IJJLwPaCeVW0o9C0HRHRMWkAVkGTnlOUMCWeXadSkR-4PbuSEn6aDgDpGucZ_CcUytx3nJ', 'BJzxI8TEHnY2hbyEpyzpmuOvhAuINoy9yMROiNUegJbYrubYaGzs7rv379QHMDmkQi6LHe9KB8MwgHtKE8vGy98', 'edWOhIs2qxcZUJRNoWHyPw', NULL, '2024-10-08 23:07:30', '2024-10-08 23:07:30'),
(13, 'App\\Models\\Guest', 13, 'https://fcm.googleapis.com/fcm/send/d4SZbcDK9tI:APA91bHTCBrS6YZekpkTxh-iqTsqD68JWIP4Sx28PIutRWRuGHvwf714CFiq5R1Q87KcN0dVbcIoyb2RT2Jxzq9k8zmZwnnerd4ELoHClVlrpsv1VKY2U2E1NcY6suFrm2ob6xkLExJQ', 'BJqKEr4sUJYtWnf8I-_nJu1KZGa2XNNjzxCTDx8NHDOrIg7ph6CuPg2PayMF9J6X2yQ3zRDHWsQKrCYlzCio8js', '9i1KhIrhVADR-WcEQPmSpQ', NULL, '2025-03-26 22:37:02', '2025-03-26 22:37:02');

-- --------------------------------------------------------

--
-- Table structure for table `quick_links`
--

CREATE TABLE `quick_links` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` smallint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `quick_links`
--

INSERT INTO `quick_links` (`id`, `language_id`, `title`, `url`, `serial_number`, `created_at`, `updated_at`) VALUES
(11, 20, 'About Us', 'https://codecanyon8.kreativdev.com/carlist/about-us', 1, '2023-08-19 23:46:05', '2023-08-28 04:16:52'),
(12, 20, 'Contact', 'https://codecanyon8.kreativdev.com/carlist/contact', 2, '2023-08-19 23:46:32', '2023-08-28 04:16:45'),
(13, 20, 'FAQ', 'https://codecanyon8.kreativdev.com/carlist/faq', 3, '2023-08-19 23:46:51', '2023-08-28 04:16:38'),
(15, 21, 'معلومات عنا', 'https://codecanyon8.kreativdev.com/carlist/about-us', 1, '2023-08-20 00:12:46', '2023-08-28 04:17:13'),
(16, 21, 'اتصال', 'https://codecanyon8.kreativdev.com/carlist/contact', 2, '2023-08-20 00:13:18', '2023-08-28 04:17:08'),
(17, 21, 'التعليمات', 'https://codecanyon8.kreativdev.com/carlist/faq', 3, '2023-08-20 00:13:43', '2023-08-28 04:17:02');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `permissions` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `name`, `permissions`, `created_at`, `updated_at`) VALUES
(4, 'Admin', '[\"Menu Builder\",\"Payment Log\",\"Advertisements\",\"Announcement Popups\",\"Support Tickets\",\"Language Management\"]', '2021-08-06 22:42:38', '2024-03-19 22:47:59'),
(6, 'Moderator', '[\"Payment Log\",\"Home Page\",\"Footer\",\"Blog Management\",\"FAQ Management\",\"Basic Settings\"]', '2021-08-07 22:14:34', '2023-07-22 21:02:33'),
(14, 'Supervisor', 'null', '2021-11-24 22:48:53', '2025-12-06 22:32:52');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint UNSIGNED NOT NULL,
  `work_process_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `category_section_status` tinyint DEFAULT '0',
  `featured_listing_section_status` tinyint NOT NULL DEFAULT '1',
  `feature_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `latest_listing_section_status` tinyint DEFAULT NULL,
  `counter_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `package_section_status` tinyint NOT NULL DEFAULT '1',
  `video_section` tinyint DEFAULT '0',
  `testimonial_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `call_to_action_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `location_section_status` tinyint DEFAULT NULL,
  `blog_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `subscribe_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `footer_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `work_process_section_status`, `category_section_status`, `featured_listing_section_status`, `feature_section_status`, `latest_listing_section_status`, `counter_section_status`, `package_section_status`, `video_section`, `testimonial_section_status`, `call_to_action_section_status`, `location_section_status`, `blog_section_status`, `subscribe_section_status`, `footer_section_status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, '2024-03-21 00:17:28');

-- --------------------------------------------------------

--
-- Table structure for table `seos`
--

CREATE TABLE `seos` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `meta_keyword_home` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_home` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_pricing` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_pricing` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_listings` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_listings` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_products` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_products` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_blog` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_blog` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_faq` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_faq` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_contact` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_contact` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_login` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_login` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_signup` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_signup` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_forget_password` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_forget_password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_vendor_login` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_vendor_login` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_vendor_signup` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_vendor_signup` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_vendor_forget_password` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_descriptions_vendor_forget_password` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_vendor_page` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_vendor_page` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_about_page` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_about_page` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `seos`
--

INSERT INTO `seos` (`id`, `language_id`, `meta_keyword_home`, `meta_description_home`, `meta_keyword_pricing`, `meta_description_pricing`, `meta_keyword_listings`, `meta_description_listings`, `meta_keyword_products`, `meta_description_products`, `meta_keyword_blog`, `meta_description_blog`, `meta_keyword_faq`, `meta_description_faq`, `meta_keyword_contact`, `meta_description_contact`, `meta_keyword_login`, `meta_description_login`, `meta_keyword_signup`, `meta_description_signup`, `meta_keyword_forget_password`, `meta_description_forget_password`, `meta_keywords_vendor_login`, `meta_description_vendor_login`, `meta_keywords_vendor_signup`, `meta_description_vendor_signup`, `meta_keywords_vendor_forget_password`, `meta_descriptions_vendor_forget_password`, `meta_keywords_vendor_page`, `meta_description_vendor_page`, `meta_keywords_about_page`, `meta_description_about_page`, `created_at`, `updated_at`) VALUES
(5, 20, 'Home', 'Home Descriptions', 'Pricimg', 'Pricing descriptions', 'Listings', 'Listings Description', 'products', 'Product descriptions', 'Blog', 'Blog descriptions', 'Faq', 'faq descriptions', 'contact', 'contact descriptions', 'Login', 'Login descriptions', 'Signup', 'signup descriptions', 'Forget Password', 'Forget Password descriptions', 'Vendor Login', 'Vendor Login descriptions', 'Vendor Signup', 'Vendor Signup descriptions', 'Vendor Forget Password', 'vendor forget password descriptions', 'vendors', 'vendors descriptions', 'About us', 'about us descriptions', '2023-08-27 01:03:33', '2024-01-01 21:20:39'),
(6, 21, 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', '2024-01-02 03:34:05', '2024-01-02 03:34:05');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_medias`
--

CREATE TABLE `social_medias` (
  `id` bigint UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `social_medias`
--

INSERT INTO `social_medias` (`id`, `icon`, `url`, `serial_number`, `created_at`, `updated_at`) VALUES
(36, 'fab fa-facebook-f', 'http://example.com/', 1, '2021-11-20 03:01:42', '2021-11-20 03:01:42'),
(37, 'fab fa-twitter', 'http://example.com/', 3, '2021-11-20 03:03:22', '2021-11-20 03:03:22'),
(38, 'fab fa-linkedin-in', 'http://example.com/', 2, '2021-11-20 03:04:29', '2021-11-20 03:04:29');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `country_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `language_id`, `country_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 20, 2, 'Victoria', '2024-05-01 21:02:06', '2024-05-01 21:02:06'),
(2, 21, 3, 'فيكتوريا', '2024-05-01 21:02:35', '2024-05-07 23:29:02'),
(3, 20, 4, 'Andhra Pradesh', '2024-05-01 22:32:59', '2024-05-01 22:35:14'),
(4, 21, 5, 'ولاية اندرا براديش', '2024-05-01 22:34:05', '2024-05-07 23:28:58'),
(5, 20, 10, 'California', '2024-05-05 21:38:02', '2024-05-05 21:38:02'),
(6, 21, 11, 'كاليفورنيا', '2024-05-05 21:38:25', '2024-05-07 23:28:50'),
(7, 20, 10, 'Florida', '2024-05-05 21:38:55', '2024-05-05 21:38:55'),
(8, 21, 11, 'فلوريدا', '2024-05-05 21:39:12', '2024-05-07 23:28:44');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint UNSIGNED NOT NULL,
  `email_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `subscribers`
--

INSERT INTO `subscribers` (`id`, `email_id`, `created_at`, `updated_at`) VALUES
(5, 'azimahmed11041@gmail.com', '2024-11-10 22:10:30', '2024-11-10 22:10:30');

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL,
  `user_type` varchar(20) DEFAULT NULL,
  `admin_id` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` longtext,
  `attachment` varchar(255) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1-pending, 2-open, 3-closed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_message` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `support_tickets`
--

INSERT INTO `support_tickets` (`id`, `user_id`, `user_type`, `admin_id`, `email`, `subject`, `description`, `attachment`, `status`, `created_at`, `updated_at`, `last_message`) VALUES
(1, 201, 'vendor', NULL, 'listingspot56@example.com', 'Support Text Ticket', '<p>Support Text Ticket</p>', NULL, 1, '2026-04-05 01:16:00', '2026-04-05 01:16:00', NULL),
(5, 204, 'vendor', NULL, 'superBusiness47@example.com', 'Support Text Ticket', '<p>test giflwe</p>', NULL, 1, '2026-04-07 01:15:30', '2026-04-07 01:29:07', '2026-04-07 01:29:07'),
(6, 204, 'vendor', NULL, 'superBusiness47@example.com', 'Test ticket', 'Test ticket', '69d4c45158672.zip', 1, '2026-04-07 02:46:09', '2026-04-07 02:46:09', NULL),
(7, 204, 'vendor', NULL, 'superBusiness47@example.com', 'Need help with your product listings?', '<p>Hi there! Are you finding it challenging to get your product listings just right? We understand that creating compelling and accurate listings can be time-consuming, and sometimes a little tricky. Our team is here to help you optimize your product pages so they shine and attract more customers. Whether it\'s improving descriptions, adding better images, or navigating our listing tools, we\'ve got resources to guide you. Don\'t let listing hurdles slow you down – reach out to our support team today and let us assist you in making your products stand out!</p>', NULL, 1, '2026-04-12 03:39:11', '2026-04-12 03:39:11', NULL),
(8, 204, 'vendor', 3, 'superBusiness47@example.com', 'test', '<p>Hi there! Are you finding it challenging to get your product listings just right? We understand that creating compelling and accurate listings can be time-consuming, and sometimes a little tricky. Our team is here to help you optimize your product pages so they shine and attract more customers. Whether it\'s improving descriptions, adding better images, or navigating our listing tools, we\'ve got resources to guide you. Don\'t let listing hurdles slow you down – reach out to our support team today and let us assist you in making your products stand out!</p>', NULL, 3, '2026-05-12 08:10:45', '2026-05-12 08:13:03', '2026-05-12 08:12:03');

-- --------------------------------------------------------

--
-- Table structure for table `support_ticket_statuses`
--

CREATE TABLE `support_ticket_statuses` (
  `id` bigint UNSIGNED NOT NULL,
  `support_ticket_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `support_ticket_statuses`
--

INSERT INTO `support_ticket_statuses` (`id`, `support_ticket_status`, `created_at`, `updated_at`) VALUES
(1, 'active', '2022-06-25 03:52:18', '2024-03-21 00:50:57');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `occupation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `rating` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `language_id`, `image`, `name`, `occupation`, `comment`, `rating`, `created_at`, `updated_at`) VALUES
(25, 20, '663c43857a830.png', 'Hames Rodrigo', 'Marketing Executive', 'Regular updates and accurate contact details ensure the information is current. An essential tool for anyone needing quick access to local services.', '5', '2023-08-19 03:51:32', '2024-05-24 22:23:24'),
(26, 20, '663c437f271c3.png', 'John Martinez', 'IT Consultant', 'The review and rating system adds transparency, making it easier to choose reputable businesses. Very helpful for new residents.', '4.5', '2023-08-19 03:52:23', '2024-05-24 22:23:11'),
(27, 20, '663c437896de6.png', 'Emily Parker', 'Teacher', 'Efficient search filters and categories specific business types. A valuable resource for both consumers and business owners.', '5', '2023-08-19 03:53:54', '2024-05-24 22:24:11'),
(28, 20, '663c43702294e.png', 'Michael Collins', 'Marketing Manager', 'Comprehensive listings with detailed information and reviews help in making informed decisions. A must-use for discovering trusted local businesses.', '4.3', '2023-08-19 03:55:02', '2024-05-24 22:22:38'),
(29, 20, '663c43676a110.png', 'Jennifer Lee', 'Freelance Photographer', 'User-friendly interface makes finding local businesses a breeze. Highly recommend for  services or products nearby.', '5', '2023-08-19 03:55:59', '2024-05-24 22:23:49'),
(30, 21, '663c43a9b4af0.png', 'هاميس رودريجو', 'تنفيذي تسويق', 'لقد حظيت بتجربة مدهشة باستخدام موقع قائمة السيارات هذا. جعلت الواجهة سهلة الاستخدام من السهل جدًا علي العثور على السيارة المثالية التي تناسب احتياجاتي. كان تنوع الخيارات المتاحة مثيرًا للإعجاب ، وأنا سعيد بعملية الشراء السلسة. ينصح به بشده!', '5', '2023-08-19 04:48:15', '2024-05-08 21:31:53'),
(32, 21, '663c43a137eac.png', 'جون مارتينيز', 'مستشار تكنولوجيا المعلومات', 'لقد وجدت أن موقع قائمة السيارات مفيد جدًا بشكل عام. لقد ساعدني في العثور  ، واجهت بعض الأخطاء الفنية أثناء البحث ، مما أثر قليلاً على تجربتي. مع مزيد من الصقل قليلاً ، يمكن أن يصبح هذا بسهولة منصة الذهاب إلى التسوق في السيارات.', '4.5', '2023-08-19 04:50:14', '2024-05-24 22:25:51'),
(33, 21, '663c439ad8654.png', 'إميلي باركر', 'مدرس', 'عادةً ما أكون متشككًا جدًا بشأن عمليات الشراء عبر الإنترنت ، لكن موقع قائمة السيارات هذا تجاوز توقعاتي. أعطتني الشفافية في تقديم تاريخ المركبات والأوصاف الدقيقة الثقة في اختياراتي. بفضل هذه المنصة ، وجدت سيارة موثوقة تناسب ميزانيتي تمامًا', '5', '2023-08-19 04:50:59', '2024-05-08 21:31:38'),
(34, 21, '663c43949f349.png', 'مايكل كولينز', 'مدير تسويق', '\"كنت أخشى عملية البحث عن سيارة جديدة ، ل التصميم البديهي التنقل نسيمًا ، وكان دعم الدردشة في الوقت الفعلي مفيدًا بشكل لا يصدق عندما كانت لدي أسئلة. سيارتي الجديدة هي كل شيء كنت أتمنى ، وأنا ممتن لهذه المنصة', '4.3', '2023-08-19 04:51:37', '2024-05-24 22:25:14'),
(35, 21, '663c438e42d3f.png', 'جينيفر لي', 'مصور فوتوغرافي مستقل', 'لقد وجدت أن موقع قائمة السيارات مفيد جدًا بشكل عام. لقد ساعدني في العثور  ، واجهت بعض الأخطاء الفنية أثناء البحث ، مما أثر قليلاً على تجربتي. مع مزيد من الصقل قليلاً ، يمكن أن يصبح هذا بسهولة منصة الذهاب إلى التسوق في السيارات.', '5', '2023-08-19 04:52:25', '2024-05-24 22:25:28');

-- --------------------------------------------------------

--
-- Table structure for table `testimonial_sections`
--

CREATE TABLE `testimonial_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `clients` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `testimonial_sections`
--

INSERT INTO `testimonial_sections` (`id`, `language_id`, `subtitle`, `title`, `clients`, `created_at`, `updated_at`) VALUES
(7, 20, NULL, 'What Clients Say About Bulistio Packages', '10k+ Active Client’s', '2023-08-19 03:45:43', '2023-12-13 21:06:27'),
(8, 21, NULL, 'ماذا يقول عملاؤنا عنا', 'k2 كيلوعملاؤن', '2023-08-19 03:47:29', '2023-12-13 21:07:11');

-- --------------------------------------------------------

--
-- Table structure for table `timezones`
--

CREATE TABLE `timezones` (
  `country_code` char(3) NOT NULL,
  `timezone` varchar(125) NOT NULL DEFAULT '',
  `gmt_offset` float(10,2) DEFAULT NULL,
  `dst_offset` float(10,2) DEFAULT NULL,
  `raw_offset` float(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `timezones`
--

INSERT INTO `timezones` (`country_code`, `timezone`, `gmt_offset`, `dst_offset`, `raw_offset`) VALUES
('AD', 'Europe/Andorra', 1.00, 2.00, 1.00),
('AE', 'Asia/Dubai', 4.00, 4.00, 4.00),
('AF', 'Asia/Kabul', 4.50, 4.50, 4.50),
('AG', 'America/Antigua', -4.00, -4.00, -4.00),
('AI', 'America/Anguilla', -4.00, -4.00, -4.00),
('AL', 'Europe/Tirane', 1.00, 2.00, 1.00),
('AM', 'Asia/Yerevan', 4.00, 4.00, 4.00),
('AO', 'Africa/Luanda', 1.00, 1.00, 1.00),
('AQ', 'Antarctica/Casey', 8.00, 8.00, 8.00),
('AQ', 'Antarctica/Davis', 7.00, 7.00, 7.00),
('AQ', 'Antarctica/DumontDUrville', 10.00, 10.00, 10.00),
('AQ', 'Antarctica/Mawson', 5.00, 5.00, 5.00),
('AQ', 'Antarctica/McMurdo', 13.00, 12.00, 12.00),
('AQ', 'Antarctica/Palmer', -3.00, -4.00, -4.00),
('AQ', 'Antarctica/Rothera', -3.00, -3.00, -3.00),
('AQ', 'Antarctica/South_Pole', 13.00, 12.00, 12.00),
('AQ', 'Antarctica/Syowa', 3.00, 3.00, 3.00),
('AQ', 'Antarctica/Vostok', 6.00, 6.00, 6.00),
('AR', 'America/Argentina/Buenos_Aires', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Catamarca', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Cordoba', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Jujuy', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/La_Rioja', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Mendoza', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Rio_Gallegos', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Salta', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/San_Juan', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/San_Luis', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Tucuman', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Ushuaia', -3.00, -3.00, -3.00),
('AS', 'Pacific/Pago_Pago', -11.00, -11.00, -11.00),
('AT', 'Europe/Vienna', 1.00, 2.00, 1.00),
('AU', 'Antarctica/Macquarie', 11.00, 11.00, 11.00),
('AU', 'Australia/Adelaide', 10.50, 9.50, 9.50),
('AU', 'Australia/Brisbane', 10.00, 10.00, 10.00),
('AU', 'Australia/Broken_Hill', 10.50, 9.50, 9.50),
('AU', 'Australia/Currie', 11.00, 10.00, 10.00),
('AU', 'Australia/Darwin', 9.50, 9.50, 9.50),
('AU', 'Australia/Eucla', 8.75, 8.75, 8.75),
('AU', 'Australia/Hobart', 11.00, 10.00, 10.00),
('AU', 'Australia/Lindeman', 10.00, 10.00, 10.00),
('AU', 'Australia/Lord_Howe', 11.00, 10.50, 10.50),
('AU', 'Australia/Melbourne', 11.00, 10.00, 10.00),
('AU', 'Australia/Perth', 8.00, 8.00, 8.00),
('AU', 'Australia/Sydney', 11.00, 10.00, 10.00),
('AW', 'America/Aruba', -4.00, -4.00, -4.00),
('AX', 'Europe/Mariehamn', 2.00, 3.00, 2.00),
('AZ', 'Asia/Baku', 4.00, 5.00, 4.00),
('BA', 'Europe/Sarajevo', 1.00, 2.00, 1.00),
('BB', 'America/Barbados', -4.00, -4.00, -4.00),
('BD', 'Asia/Dhaka', 6.00, 6.00, 6.00),
('BE', 'Europe/Brussels', 1.00, 2.00, 1.00),
('BF', 'Africa/Ouagadougou', 0.00, 0.00, 0.00),
('BG', 'Europe/Sofia', 2.00, 3.00, 2.00),
('BH', 'Asia/Bahrain', 3.00, 3.00, 3.00),
('BI', 'Africa/Bujumbura', 2.00, 2.00, 2.00),
('BJ', 'Africa/Porto-Novo', 1.00, 1.00, 1.00),
('BL', 'America/St_Barthelemy', -4.00, -4.00, -4.00),
('BM', 'Atlantic/Bermuda', -4.00, -3.00, -4.00),
('BN', 'Asia/Brunei', 8.00, 8.00, 8.00),
('BO', 'America/La_Paz', -4.00, -4.00, -4.00),
('BQ', 'America/Kralendijk', -4.00, -4.00, -4.00),
('BR', 'America/Araguaina', -3.00, -3.00, -3.00),
('BR', 'America/Bahia', -3.00, -3.00, -3.00),
('BR', 'America/Belem', -3.00, -3.00, -3.00),
('BR', 'America/Boa_Vista', -4.00, -4.00, -4.00),
('BR', 'America/Campo_Grande', -3.00, -4.00, -4.00),
('BR', 'America/Cuiaba', -3.00, -4.00, -4.00),
('BR', 'America/Eirunepe', -5.00, -5.00, -5.00),
('BR', 'America/Fortaleza', -3.00, -3.00, -3.00),
('BR', 'America/Maceio', -3.00, -3.00, -3.00),
('BR', 'America/Manaus', -4.00, -4.00, -4.00),
('BR', 'America/Noronha', -2.00, -2.00, -2.00),
('BR', 'America/Porto_Velho', -4.00, -4.00, -4.00),
('BR', 'America/Recife', -3.00, -3.00, -3.00),
('BR', 'America/Rio_Branco', -5.00, -5.00, -5.00),
('BR', 'America/Santarem', -3.00, -3.00, -3.00),
('BR', 'America/Sao_Paulo', -2.00, -3.00, -3.00),
('BS', 'America/Nassau', -5.00, -4.00, -5.00),
('BT', 'Asia/Thimphu', 6.00, 6.00, 6.00),
('BW', 'Africa/Gaborone', 2.00, 2.00, 2.00),
('BY', 'Europe/Minsk', 3.00, 3.00, 3.00),
('BZ', 'America/Belize', -6.00, -6.00, -6.00),
('CA', 'America/Atikokan', -5.00, -5.00, -5.00),
('CA', 'America/Blanc-Sablon', -4.00, -4.00, -4.00),
('CA', 'America/Cambridge_Bay', -7.00, -6.00, -7.00),
('CA', 'America/Creston', -7.00, -7.00, -7.00),
('CA', 'America/Dawson', -8.00, -7.00, -8.00),
('CA', 'America/Dawson_Creek', -7.00, -7.00, -7.00),
('CA', 'America/Edmonton', -7.00, -6.00, -7.00),
('CA', 'America/Glace_Bay', -4.00, -3.00, -4.00),
('CA', 'America/Goose_Bay', -4.00, -3.00, -4.00),
('CA', 'America/Halifax', -4.00, -3.00, -4.00),
('CA', 'America/Inuvik', -7.00, -6.00, -7.00),
('CA', 'America/Iqaluit', -5.00, -4.00, -5.00),
('CA', 'America/Moncton', -4.00, -3.00, -4.00),
('CA', 'America/Montreal', -5.00, -4.00, -5.00),
('CA', 'America/Nipigon', -5.00, -4.00, -5.00),
('CA', 'America/Pangnirtung', -5.00, -4.00, -5.00),
('CA', 'America/Rainy_River', -6.00, -5.00, -6.00),
('CA', 'America/Rankin_Inlet', -6.00, -5.00, -6.00),
('CA', 'America/Regina', -6.00, -6.00, -6.00),
('CA', 'America/Resolute', -6.00, -5.00, -6.00),
('CA', 'America/St_Johns', -3.50, -2.50, -3.50),
('CA', 'America/Swift_Current', -6.00, -6.00, -6.00),
('CA', 'America/Thunder_Bay', -5.00, -4.00, -5.00),
('CA', 'America/Toronto', -5.00, -4.00, -5.00),
('CA', 'America/Vancouver', -8.00, -7.00, -8.00),
('CA', 'America/Whitehorse', -8.00, -7.00, -8.00),
('CA', 'America/Winnipeg', -6.00, -5.00, -6.00),
('CA', 'America/Yellowknife', -7.00, -6.00, -7.00),
('CC', 'Indian/Cocos', 6.50, 6.50, 6.50),
('CD', 'Africa/Kinshasa', 1.00, 1.00, 1.00),
('CD', 'Africa/Lubumbashi', 2.00, 2.00, 2.00),
('CF', 'Africa/Bangui', 1.00, 1.00, 1.00),
('CG', 'Africa/Brazzaville', 1.00, 1.00, 1.00),
('CH', 'Europe/Zurich', 1.00, 2.00, 1.00),
('CI', 'Africa/Abidjan', 0.00, 0.00, 0.00),
('CK', 'Pacific/Rarotonga', -10.00, -10.00, -10.00),
('CL', 'America/Santiago', -3.00, -4.00, -4.00),
('CL', 'Pacific/Easter', -5.00, -6.00, -6.00),
('CM', 'Africa/Douala', 1.00, 1.00, 1.00),
('CN', 'Asia/Chongqing', 8.00, 8.00, 8.00),
('CN', 'Asia/Harbin', 8.00, 8.00, 8.00),
('CN', 'Asia/Kashgar', 8.00, 8.00, 8.00),
('CN', 'Asia/Shanghai', 8.00, 8.00, 8.00),
('CN', 'Asia/Urumqi', 8.00, 8.00, 8.00),
('CO', 'America/Bogota', -5.00, -5.00, -5.00),
('CR', 'America/Costa_Rica', -6.00, -6.00, -6.00),
('CU', 'America/Havana', -5.00, -4.00, -5.00),
('CV', 'Atlantic/Cape_Verde', -1.00, -1.00, -1.00),
('CW', 'America/Curacao', -4.00, -4.00, -4.00),
('CX', 'Indian/Christmas', 7.00, 7.00, 7.00),
('CY', 'Asia/Nicosia', 2.00, 3.00, 2.00),
('CZ', 'Europe/Prague', 1.00, 2.00, 1.00),
('DE', 'Europe/Berlin', 1.00, 2.00, 1.00),
('DE', 'Europe/Busingen', 1.00, 2.00, 1.00),
('DJ', 'Africa/Djibouti', 3.00, 3.00, 3.00),
('DK', 'Europe/Copenhagen', 1.00, 2.00, 1.00),
('DM', 'America/Dominica', -4.00, -4.00, -4.00),
('DO', 'America/Santo_Domingo', -4.00, -4.00, -4.00),
('DZ', 'Africa/Algiers', 1.00, 1.00, 1.00),
('EC', 'America/Guayaquil', -5.00, -5.00, -5.00),
('EC', 'Pacific/Galapagos', -6.00, -6.00, -6.00),
('EE', 'Europe/Tallinn', 2.00, 3.00, 2.00),
('EG', 'Africa/Cairo', 2.00, 2.00, 2.00),
('EH', 'Africa/El_Aaiun', 0.00, 0.00, 0.00),
('ER', 'Africa/Asmara', 3.00, 3.00, 3.00),
('ES', 'Africa/Ceuta', 1.00, 2.00, 1.00),
('ES', 'Atlantic/Canary', 0.00, 1.00, 0.00),
('ES', 'Europe/Madrid', 1.00, 2.00, 1.00),
('ET', 'Africa/Addis_Ababa', 3.00, 3.00, 3.00),
('FI', 'Europe/Helsinki', 2.00, 3.00, 2.00),
('FJ', 'Pacific/Fiji', 13.00, 12.00, 12.00),
('FK', 'Atlantic/Stanley', -3.00, -3.00, -3.00),
('FM', 'Pacific/Chuuk', 10.00, 10.00, 10.00),
('FM', 'Pacific/Kosrae', 11.00, 11.00, 11.00),
('FM', 'Pacific/Pohnpei', 11.00, 11.00, 11.00),
('FO', 'Atlantic/Faroe', 0.00, 1.00, 0.00),
('FR', 'Europe/Paris', 1.00, 2.00, 1.00),
('GA', 'Africa/Libreville', 1.00, 1.00, 1.00),
('GB', 'Europe/London', 0.00, 1.00, 0.00),
('GD', 'America/Grenada', -4.00, -4.00, -4.00),
('GE', 'Asia/Tbilisi', 4.00, 4.00, 4.00),
('GF', 'America/Cayenne', -3.00, -3.00, -3.00),
('GG', 'Europe/Guernsey', 0.00, 1.00, 0.00),
('GH', 'Africa/Accra', 0.00, 0.00, 0.00),
('GI', 'Europe/Gibraltar', 1.00, 2.00, 1.00),
('GL', 'America/Danmarkshavn', 0.00, 0.00, 0.00),
('GL', 'America/Godthab', -3.00, -2.00, -3.00),
('GL', 'America/Scoresbysund', -1.00, 0.00, -1.00),
('GL', 'America/Thule', -4.00, -3.00, -4.00),
('GM', 'Africa/Banjul', 0.00, 0.00, 0.00),
('GN', 'Africa/Conakry', 0.00, 0.00, 0.00),
('GP', 'America/Guadeloupe', -4.00, -4.00, -4.00),
('GQ', 'Africa/Malabo', 1.00, 1.00, 1.00),
('GR', 'Europe/Athens', 2.00, 3.00, 2.00),
('GS', 'Atlantic/South_Georgia', -2.00, -2.00, -2.00),
('GT', 'America/Guatemala', -6.00, -6.00, -6.00),
('GU', 'Pacific/Guam', 10.00, 10.00, 10.00),
('GW', 'Africa/Bissau', 0.00, 0.00, 0.00),
('GY', 'America/Guyana', -4.00, -4.00, -4.00),
('HK', 'Asia/Hong_Kong', 8.00, 8.00, 8.00),
('HN', 'America/Tegucigalpa', -6.00, -6.00, -6.00),
('HR', 'Europe/Zagreb', 1.00, 2.00, 1.00),
('HT', 'America/Port-au-Prince', -5.00, -4.00, -5.00),
('HU', 'Europe/Budapest', 1.00, 2.00, 1.00),
('ID', 'Asia/Jakarta', 7.00, 7.00, 7.00),
('ID', 'Asia/Jayapura', 9.00, 9.00, 9.00),
('ID', 'Asia/Makassar', 8.00, 8.00, 8.00),
('ID', 'Asia/Pontianak', 7.00, 7.00, 7.00),
('IE', 'Europe/Dublin', 0.00, 1.00, 0.00),
('IL', 'Asia/Jerusalem', 2.00, 3.00, 2.00),
('IM', 'Europe/Isle_of_Man', 0.00, 1.00, 0.00),
('IN', 'Asia/Kolkata', 5.50, 5.50, 5.50),
('IO', 'Indian/Chagos', 6.00, 6.00, 6.00),
('IQ', 'Asia/Baghdad', 3.00, 3.00, 3.00),
('IR', 'Asia/Tehran', 3.50, 4.50, 3.50),
('IS', 'Atlantic/Reykjavik', 0.00, 0.00, 0.00),
('IT', 'Europe/Rome', 1.00, 2.00, 1.00),
('JE', 'Europe/Jersey', 0.00, 1.00, 0.00),
('JM', 'America/Jamaica', -5.00, -5.00, -5.00),
('JO', 'Asia/Amman', 2.00, 3.00, 2.00),
('JP', 'Asia/Tokyo', 9.00, 9.00, 9.00),
('KE', 'Africa/Nairobi', 3.00, 3.00, 3.00),
('KG', 'Asia/Bishkek', 6.00, 6.00, 6.00),
('KH', 'Asia/Phnom_Penh', 7.00, 7.00, 7.00),
('KI', 'Pacific/Enderbury', 13.00, 13.00, 13.00),
('KI', 'Pacific/Kiritimati', 14.00, 14.00, 14.00),
('KI', 'Pacific/Tarawa', 12.00, 12.00, 12.00),
('KM', 'Indian/Comoro', 3.00, 3.00, 3.00),
('KN', 'America/St_Kitts', -4.00, -4.00, -4.00),
('KP', 'Asia/Pyongyang', 9.00, 9.00, 9.00),
('KR', 'Asia/Seoul', 9.00, 9.00, 9.00),
('KW', 'Asia/Kuwait', 3.00, 3.00, 3.00),
('KY', 'America/Cayman', -5.00, -5.00, -5.00),
('KZ', 'Asia/Almaty', 6.00, 6.00, 6.00),
('KZ', 'Asia/Aqtau', 5.00, 5.00, 5.00),
('KZ', 'Asia/Aqtobe', 5.00, 5.00, 5.00),
('KZ', 'Asia/Oral', 5.00, 5.00, 5.00),
('KZ', 'Asia/Qyzylorda', 6.00, 6.00, 6.00),
('LA', 'Asia/Vientiane', 7.00, 7.00, 7.00),
('LB', 'Asia/Beirut', 2.00, 3.00, 2.00),
('LC', 'America/St_Lucia', -4.00, -4.00, -4.00),
('LI', 'Europe/Vaduz', 1.00, 2.00, 1.00),
('LK', 'Asia/Colombo', 5.50, 5.50, 5.50),
('LR', 'Africa/Monrovia', 0.00, 0.00, 0.00),
('LS', 'Africa/Maseru', 2.00, 2.00, 2.00),
('LT', 'Europe/Vilnius', 2.00, 3.00, 2.00),
('LU', 'Europe/Luxembourg', 1.00, 2.00, 1.00),
('LV', 'Europe/Riga', 2.00, 3.00, 2.00),
('LY', 'Africa/Tripoli', 2.00, 2.00, 2.00),
('MA', 'Africa/Casablanca', 0.00, 0.00, 0.00),
('MC', 'Europe/Monaco', 1.00, 2.00, 1.00),
('MD', 'Europe/Chisinau', 2.00, 3.00, 2.00),
('ME', 'Europe/Podgorica', 1.00, 2.00, 1.00),
('MF', 'America/Marigot', -4.00, -4.00, -4.00),
('MG', 'Indian/Antananarivo', 3.00, 3.00, 3.00),
('MH', 'Pacific/Kwajalein', 12.00, 12.00, 12.00),
('MH', 'Pacific/Majuro', 12.00, 12.00, 12.00),
('MK', 'Europe/Skopje', 1.00, 2.00, 1.00),
('ML', 'Africa/Bamako', 0.00, 0.00, 0.00),
('MM', 'Asia/Rangoon', 6.50, 6.50, 6.50),
('MN', 'Asia/Choibalsan', 8.00, 8.00, 8.00),
('MN', 'Asia/Hovd', 7.00, 7.00, 7.00),
('MN', 'Asia/Ulaanbaatar', 8.00, 8.00, 8.00),
('MO', 'Asia/Macau', 8.00, 8.00, 8.00),
('MP', 'Pacific/Saipan', 10.00, 10.00, 10.00),
('MQ', 'America/Martinique', -4.00, -4.00, -4.00),
('MR', 'Africa/Nouakchott', 0.00, 0.00, 0.00),
('MS', 'America/Montserrat', -4.00, -4.00, -4.00),
('MT', 'Europe/Malta', 1.00, 2.00, 1.00),
('MU', 'Indian/Mauritius', 4.00, 4.00, 4.00),
('MV', 'Indian/Maldives', 5.00, 5.00, 5.00),
('MW', 'Africa/Blantyre', 2.00, 2.00, 2.00),
('MX', 'America/Bahia_Banderas', -6.00, -5.00, -6.00),
('MX', 'America/Cancun', -6.00, -5.00, -6.00),
('MX', 'America/Chihuahua', -7.00, -6.00, -7.00),
('MX', 'America/Hermosillo', -7.00, -7.00, -7.00),
('MX', 'America/Matamoros', -6.00, -5.00, -6.00),
('MX', 'America/Mazatlan', -7.00, -6.00, -7.00),
('MX', 'America/Merida', -6.00, -5.00, -6.00),
('MX', 'America/Mexico_City', -6.00, -5.00, -6.00),
('MX', 'America/Monterrey', -6.00, -5.00, -6.00),
('MX', 'America/Ojinaga', -7.00, -6.00, -7.00),
('MX', 'America/Santa_Isabel', -8.00, -7.00, -8.00),
('MX', 'America/Tijuana', -8.00, -7.00, -8.00),
('MY', 'Asia/Kuala_Lumpur', 8.00, 8.00, 8.00),
('MY', 'Asia/Kuching', 8.00, 8.00, 8.00),
('MZ', 'Africa/Maputo', 2.00, 2.00, 2.00),
('NA', 'Africa/Windhoek', 2.00, 1.00, 1.00),
('NC', 'Pacific/Noumea', 11.00, 11.00, 11.00),
('NE', 'Africa/Niamey', 1.00, 1.00, 1.00),
('NF', 'Pacific/Norfolk', 11.50, 11.50, 11.50),
('NG', 'Africa/Lagos', 1.00, 1.00, 1.00),
('NI', 'America/Managua', -6.00, -6.00, -6.00),
('NL', 'Europe/Amsterdam', 1.00, 2.00, 1.00),
('NO', 'Europe/Oslo', 1.00, 2.00, 1.00),
('NP', 'Asia/Kathmandu', 5.75, 5.75, 5.75),
('NR', 'Pacific/Nauru', 12.00, 12.00, 12.00),
('NU', 'Pacific/Niue', -11.00, -11.00, -11.00),
('NZ', 'Pacific/Auckland', 13.00, 12.00, 12.00),
('NZ', 'Pacific/Chatham', 13.75, 12.75, 12.75),
('OM', 'Asia/Muscat', 4.00, 4.00, 4.00),
('PA', 'America/Panama', -5.00, -5.00, -5.00),
('PE', 'America/Lima', -5.00, -5.00, -5.00),
('PF', 'Pacific/Gambier', -9.00, -9.00, -9.00),
('PF', 'Pacific/Marquesas', -9.50, -9.50, -9.50),
('PF', 'Pacific/Tahiti', -10.00, -10.00, -10.00),
('PG', 'Pacific/Port_Moresby', 10.00, 10.00, 10.00),
('PH', 'Asia/Manila', 8.00, 8.00, 8.00),
('PK', 'Asia/Karachi', 5.00, 5.00, 5.00),
('PL', 'Europe/Warsaw', 1.00, 2.00, 1.00),
('PM', 'America/Miquelon', -3.00, -2.00, -3.00),
('PN', 'Pacific/Pitcairn', -8.00, -8.00, -8.00),
('PR', 'America/Puerto_Rico', -4.00, -4.00, -4.00),
('PS', 'Asia/Gaza', 2.00, 3.00, 2.00),
('PS', 'Asia/Hebron', 2.00, 3.00, 2.00),
('PT', 'Atlantic/Azores', -1.00, 0.00, -1.00),
('PT', 'Atlantic/Madeira', 0.00, 1.00, 0.00),
('PT', 'Europe/Lisbon', 0.00, 1.00, 0.00),
('PW', 'Pacific/Palau', 9.00, 9.00, 9.00),
('PY', 'America/Asuncion', -3.00, -4.00, -4.00),
('QA', 'Asia/Qatar', 3.00, 3.00, 3.00),
('RE', 'Indian/Reunion', 4.00, 4.00, 4.00),
('RO', 'Europe/Bucharest', 2.00, 3.00, 2.00),
('RS', 'Europe/Belgrade', 1.00, 2.00, 1.00),
('RU', 'Asia/Anadyr', 12.00, 12.00, 12.00),
('RU', 'Asia/Irkutsk', 9.00, 9.00, 9.00),
('RU', 'Asia/Kamchatka', 12.00, 12.00, 12.00),
('RU', 'Asia/Khandyga', 10.00, 10.00, 10.00),
('RU', 'Asia/Krasnoyarsk', 8.00, 8.00, 8.00),
('RU', 'Asia/Magadan', 12.00, 12.00, 12.00),
('RU', 'Asia/Novokuznetsk', 7.00, 7.00, 7.00),
('RU', 'Asia/Novosibirsk', 7.00, 7.00, 7.00),
('RU', 'Asia/Omsk', 7.00, 7.00, 7.00),
('RU', 'Asia/Sakhalin', 11.00, 11.00, 11.00),
('RU', 'Asia/Ust-Nera', 11.00, 11.00, 11.00),
('RU', 'Asia/Vladivostok', 11.00, 11.00, 11.00),
('RU', 'Asia/Yakutsk', 10.00, 10.00, 10.00),
('RU', 'Asia/Yekaterinburg', 6.00, 6.00, 6.00),
('RU', 'Europe/Kaliningrad', 3.00, 3.00, 3.00),
('RU', 'Europe/Moscow', 4.00, 4.00, 4.00),
('RU', 'Europe/Samara', 4.00, 4.00, 4.00),
('RU', 'Europe/Volgograd', 4.00, 4.00, 4.00),
('RW', 'Africa/Kigali', 2.00, 2.00, 2.00),
('SA', 'Asia/Riyadh', 3.00, 3.00, 3.00),
('SB', 'Pacific/Guadalcanal', 11.00, 11.00, 11.00),
('SC', 'Indian/Mahe', 4.00, 4.00, 4.00),
('SD', 'Africa/Khartoum', 3.00, 3.00, 3.00),
('SE', 'Europe/Stockholm', 1.00, 2.00, 1.00),
('SG', 'Asia/Singapore', 8.00, 8.00, 8.00),
('SH', 'Atlantic/St_Helena', 0.00, 0.00, 0.00),
('SI', 'Europe/Ljubljana', 1.00, 2.00, 1.00),
('SJ', 'Arctic/Longyearbyen', 1.00, 2.00, 1.00),
('SK', 'Europe/Bratislava', 1.00, 2.00, 1.00),
('SL', 'Africa/Freetown', 0.00, 0.00, 0.00),
('SM', 'Europe/San_Marino', 1.00, 2.00, 1.00),
('SN', 'Africa/Dakar', 0.00, 0.00, 0.00),
('SO', 'Africa/Mogadishu', 3.00, 3.00, 3.00),
('SR', 'America/Paramaribo', -3.00, -3.00, -3.00),
('SS', 'Africa/Juba', 3.00, 3.00, 3.00),
('ST', 'Africa/Sao_Tome', 0.00, 0.00, 0.00),
('SV', 'America/El_Salvador', -6.00, -6.00, -6.00),
('SX', 'America/Lower_Princes', -4.00, -4.00, -4.00),
('SY', 'Asia/Damascus', 2.00, 3.00, 2.00),
('SZ', 'Africa/Mbabane', 2.00, 2.00, 2.00),
('TC', 'America/Grand_Turk', -5.00, -4.00, -5.00),
('TD', 'Africa/Ndjamena', 1.00, 1.00, 1.00),
('TF', 'Indian/Kerguelen', 5.00, 5.00, 5.00),
('TG', 'Africa/Lome', 0.00, 0.00, 0.00),
('TH', 'Asia/Bangkok', 7.00, 7.00, 7.00),
('TJ', 'Asia/Dushanbe', 5.00, 5.00, 5.00),
('TK', 'Pacific/Fakaofo', 13.00, 13.00, 13.00),
('TL', 'Asia/Dili', 9.00, 9.00, 9.00),
('TM', 'Asia/Ashgabat', 5.00, 5.00, 5.00),
('TN', 'Africa/Tunis', 1.00, 1.00, 1.00),
('TO', 'Pacific/Tongatapu', 13.00, 13.00, 13.00),
('TR', 'Europe/Istanbul', 2.00, 3.00, 2.00),
('TT', 'America/Port_of_Spain', -4.00, -4.00, -4.00),
('TV', 'Pacific/Funafuti', 12.00, 12.00, 12.00),
('TW', 'Asia/Taipei', 8.00, 8.00, 8.00),
('TZ', 'Africa/Dar_es_Salaam', 3.00, 3.00, 3.00),
('UA', 'Europe/Kiev', 2.00, 3.00, 2.00),
('UA', 'Europe/Simferopol', 2.00, 4.00, 4.00),
('UA', 'Europe/Uzhgorod', 2.00, 3.00, 2.00),
('UA', 'Europe/Zaporozhye', 2.00, 3.00, 2.00),
('UG', 'Africa/Kampala', 3.00, 3.00, 3.00),
('UM', 'Pacific/Johnston', -10.00, -10.00, -10.00),
('UM', 'Pacific/Midway', -11.00, -11.00, -11.00),
('UM', 'Pacific/Wake', 12.00, 12.00, 12.00),
('US', 'America/Adak', -10.00, -9.00, -10.00),
('US', 'America/Anchorage', -9.00, -8.00, -9.00),
('US', 'America/Boise', -7.00, -6.00, -7.00),
('US', 'America/Chicago', -6.00, -5.00, -6.00),
('US', 'America/Denver', -7.00, -6.00, -7.00),
('US', 'America/Detroit', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Indianapolis', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Knox', -6.00, -5.00, -6.00),
('US', 'America/Indiana/Marengo', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Petersburg', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Tell_City', -6.00, -5.00, -6.00),
('US', 'America/Indiana/Vevay', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Vincennes', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Winamac', -5.00, -4.00, -5.00),
('US', 'America/Juneau', -9.00, -8.00, -9.00),
('US', 'America/Kentucky/Louisville', -5.00, -4.00, -5.00),
('US', 'America/Kentucky/Monticello', -5.00, -4.00, -5.00),
('US', 'America/Los_Angeles', -8.00, -7.00, -8.00),
('US', 'America/Menominee', -6.00, -5.00, -6.00),
('US', 'America/Metlakatla', -8.00, -8.00, -8.00),
('US', 'America/New_York', -5.00, -4.00, -5.00),
('US', 'America/Nome', -9.00, -8.00, -9.00),
('US', 'America/North_Dakota/Beulah', -6.00, -5.00, -6.00),
('US', 'America/North_Dakota/Center', -6.00, -5.00, -6.00),
('US', 'America/North_Dakota/New_Salem', -6.00, -5.00, -6.00),
('US', 'America/Phoenix', -7.00, -7.00, -7.00),
('US', 'America/Shiprock', -7.00, -6.00, -7.00),
('US', 'America/Sitka', -9.00, -8.00, -9.00),
('US', 'America/Yakutat', -9.00, -8.00, -9.00),
('US', 'Pacific/Honolulu', -10.00, -10.00, -10.00),
('UY', 'America/Montevideo', -2.00, -3.00, -3.00),
('UZ', 'Asia/Samarkand', 5.00, 5.00, 5.00),
('UZ', 'Asia/Tashkent', 5.00, 5.00, 5.00),
('VA', 'Europe/Vatican', 1.00, 2.00, 1.00),
('VC', 'America/St_Vincent', -4.00, -4.00, -4.00),
('VE', 'America/Caracas', -4.50, -4.50, -4.50),
('VG', 'America/Tortola', -4.00, -4.00, -4.00),
('VI', 'America/St_Thomas', -4.00, -4.00, -4.00),
('VN', 'Asia/Ho_Chi_Minh', 7.00, 7.00, 7.00),
('VU', 'Pacific/Efate', 11.00, 11.00, 11.00),
('WF', 'Pacific/Wallis', 12.00, 12.00, 12.00),
('WS', 'Pacific/Apia', 14.00, 13.00, 13.00),
('YE', 'Asia/Aden', 3.00, 3.00, 3.00),
('YT', 'Indian/Mayotte', 3.00, 3.00, 3.00),
('ZA', 'Africa/Johannesburg', 2.00, 2.00, 2.00),
('ZM', 'Africa/Lusaka', 2.00, 2.00, 2.00),
('ZW', 'Africa/Harare', 2.00, 2.00, 2.00);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 -> banned or deactive, 1 -> active',
  `verification_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `provider` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `provider_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `image`, `email_verified_at`, `password`, `status`, `verification_token`, `remember_token`, `provider`, `provider_id`, `created_at`, `updated_at`, `phone`, `country`, `city`, `state`, `zip_code`, `address`) VALUES
(1, 'Azim Ahmed', 'user', 'azimahmed11040@gmail.com', '6631e2b762822.png', '2024-05-01 00:35:35', '$2y$10$vswyd.6bx/iuuCpgu4Z7eu9FvEHbIDt7Fj3xjPdP8gaRpA4sRx7WW', 1, NULL, NULL, NULL, NULL, '2024-05-01 00:35:35', '2024-10-01 02:04:59', '01775991798', 'Bangladesh', 'uttara-1230', NULL, '12', 'house-32,road-3,sector-11,uttara,dhaka'),
(2, 'Bill Gates', 'userbill', 'daspobin027@gmail.com', '6631e2f22dd2e.png', '2024-05-01 00:36:34', '$2y$10$MzX2odn0k616LMnMWLTXBORAkRRrJrVekZGp.u/INC69Ct/LdqgPu', 1, NULL, NULL, NULL, NULL, '2024-05-01 00:36:34', '2024-05-01 00:36:34', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint UNSIGNED NOT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `to_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `amount` decimal(16,2) DEFAULT '0.00',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `avg_rating` float(8,2) NOT NULL DEFAULT '0.00',
  `show_email_addresss` tinyint NOT NULL DEFAULT '1',
  `show_phone_number` tinyint NOT NULL DEFAULT '1',
  `show_contact_form` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `lang_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `photo`, `email`, `to_mail`, `phone`, `username`, `password`, `status`, `amount`, `email_verified_at`, `avg_rating`, `show_email_addresss`, `show_phone_number`, `show_contact_form`, `created_at`, `updated_at`, `code`, `lang_code`) VALUES
(201, '6631d85340e8e.png', 'listingspot56@example.com', 'listingspot56@example.com', '+1 (555) 123-4567', 'listingspot', '$2y$10$hEv/VEkvf6XYApROrv/aeupjgwToTwpmLNVXXDaT1hgkdEOfXsmiC', 1, 3231.90, '2024-04-30 23:51:15', 0.00, 1, 1, 1, '2024-04-30 23:51:15', '2026-05-11 08:33:41', 'en', 'admin_en'),
(202, '6631d9ec106be.png', 'biznexus22@example.com', 'biznexus22@example.com', '+44 20 1234 5678', 'biznexus', '$2y$10$sGrrareqewDdQa0QrJ9EeOIk5h.WrpNy2B.ZOty6y4iXif4Wn3ub.', 1, 0.00, '2024-04-30 23:58:04', 0.00, 1, 1, 1, '2024-04-30 23:58:04', '2025-01-18 21:54:21', 'en', 'admin_en'),
(203, '6631da9d0c952.png', 'tradetrail9@example.com', 'tradetrail9@example.com', '+91 98765 43210', 'tradetrail', '$2y$10$hcBv0idegTuqzD67pwzEoelHJWERLWfLccmrF.Z1rae1FgEhLUtfe', 1, 0.00, '2024-05-01 00:01:01', 0.00, 1, 1, 1, '2024-05-01 00:01:01', '2024-05-24 22:55:06', NULL, NULL),
(204, '6631db1720b0b.png', 'superBusiness47@example.com', 'superBusiness47@example.com', '+61 2 8765 4321', 'superbusiness47', '$2y$10$8C2WPdPe2E4Vfq.gHnp4nuKrUzvpcv/zCk/aJgmNggAgoj/HG8CKC', 1, 987949.00, '2024-05-01 00:03:03', 0.00, 1, 1, 1, '2024-05-01 00:03:03', '2026-05-21 06:05:17', 'en', 'admin_en'),
(205, '6631db62bf160.png', 'bizroster@example.com', 'bizroster@example.com', '+1 (555) 987-6543', 'bizroster', '$2y$10$EHWzz3h66.zfYNtkJeMyu.p1RAdxyjrPYgIpaY8bF1x6P8VGHv0lS', 1, 0.00, '2024-05-01 00:04:18', 0.00, 1, 1, 1, '2024-05-01 00:04:18', '2024-05-24 22:53:22', NULL, NULL),
(206, '6631dbc785e95.png', 'marketlinks@example.com', 'marketlinks@example.com', '+33 1 2345 6789', 'marketlink', '$2y$10$UOCqKpMHdIoxqazFNFRzc.jHVab0nkROby6ituAOps1t9uh6Kk1Ju', 1, 196.72, '2024-05-01 00:05:59', 0.00, 1, 1, 1, '2024-05-01 00:05:59', '2025-10-31 05:57:07', 'en', 'admin_en'),
(207, '6631dca4e15a7.png', 'marketmapper99@example.com', 'marketmapper99@example.com', '+61 3 9876 5432', 'marketmapper', '$2y$10$H.YwWKx8s4KAkTFWWL.3..aLKEfQJBJy61dzGzIUut4q8lPhv5GVq', 1, 44.47, '2024-05-01 00:09:40', 0.00, 1, 1, 1, '2024-05-01 00:09:40', '2025-10-31 07:58:09', 'en', 'admin_en');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_devices`
--

CREATE TABLE `vendor_devices` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint UNSIGNED NOT NULL,
  `fcm_token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_seen_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_infos`
--

CREATE TABLE `vendor_infos` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `language_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `details` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `vendor_infos`
--

INSERT INTO `vendor_infos` (`id`, `vendor_id`, `language_id`, `name`, `country`, `city`, `state`, `zip_code`, `address`, `details`, `created_at`, `updated_at`) VALUES
(1, 201, 20, 'Samantha Johnson', 'United States', 'San Francisco', NULL, '94107', '321 Willow Way, House 8, Chicago, Illinois, USA, 60601', 'Design Skills: Samantha possesses a deep understanding of design principles and aesthetics. She excels in creating visually appealing and intuitive user interfaces (UI) that enhance user experience.\r\n\r\nUser-Centric Approach: Samantha prioritizes user needs and behavior while crafting interfaces. Her designs focus on simplicity, functionality, and ease of navigation, ensuring a positive user experience.\r\n\r\nWeb Development Proficiency: Alongside her design skills, Samantha is proficient in web development. She has expertise in various programming languages, frameworks, and technologies essential for creating responsive and dynamic websites.', '2024-04-30 23:51:15', '2024-05-23 04:33:58'),
(2, 201, 21, 'سامانثا جونسون', 'United States', 'سان فرانسيسكو', NULL, '94107', '321 ، 8، شيكاغو، إلينوي، الولايات المتحدة الأمريكية، 60601', 'سامانثا هي مصممة ماهرة متخصصة في إنشاء واجهات سهلة الاستخدام وحلول فعالة لتطوير الويب.', '2024-04-30 23:51:15', '2024-05-23 04:33:58'),
(3, 202, 20, 'Oliver Patel', 'United Kingdom', 'London', NULL, 'EC1A 1BB', '654 Cedar Road, Building 6, Austin, Texas, USA, 73301', 'Oliver is a seasoned content writer known for his exceptional skills in crafting engaging and polished written content. With years of experience in the industry, Oliver has honed his abilities to create compelling narratives across various platforms and industries. His expertise extends beyond merely stringing words together; he possesses a deep understanding of how to tailor content to resonate with specific audiences while meeting clients\' objectives.', '2024-04-30 23:58:04', '2024-05-23 04:33:27'),
(4, 202, 21, 'أوليفر باتيل', 'المملكة المتحدة', 'لندن', NULL, 'EC1A 1BB', '654 طريق سيدار، مبنى 6، أوستن، تكساس، الولايات المتحدة الأمريكية، 73301', 'أوليفر هو كاتب محتوى ذو خبرة ويهتم بالتفاصيل والقواعد.', '2024-04-30 23:58:04', '2024-05-23 04:33:27'),
(5, 203, 20, 'Priya Sharma', NULL, NULL, NULL, NULL, '987 Birch Boulevard, Room 402, Miami, Florida, USA, 33101', NULL, '2024-05-01 00:01:01', '2024-05-23 04:33:01'),
(6, 203, 21, 'بنغالوربنغالور', NULL, NULL, NULL, NULL, '987 شارع بيرش، غرفة 402، ميامي، فلوريدا، الولايات المتحدة الأمريكية، 33101', NULL, '2024-05-01 00:01:01', '2024-05-23 04:33:01'),
(7, 204, 20, 'Jackson Lee', 'India', 'kolkata', NULL, NULL, '1010 Pine Lane, Floor 3, Seattle, Washington, USA, 98101', 'details', '2024-05-01 00:03:03', '2026-04-06 05:01:49'),
(8, 204, 21, 'جاكسون لي', 'الهند', 'كولكاتا', NULL, NULL, '1010 باين لين، الطابق 3، سياتل، واشنطن، الولايات المتحدة الأمريكية، 98101', 'تفاصيل', '2024-05-01 00:03:03', '2026-04-06 05:09:46'),
(9, 205, 20, 'Rachel Carter', NULL, NULL, NULL, NULL, '456 Oak Drive, Unit 12, San Francisco, CA, 94102', NULL, '2024-05-01 00:04:18', '2024-05-23 04:31:55'),
(10, 205, 21, 'نعمنعم', NULL, NULL, NULL, NULL, '456 أوك درايف، الوحدة 12، سان فرانسيسكو، كاليفورنيا، 94102', NULL, '2024-05-01 00:04:18', '2024-05-23 04:31:55'),
(11, 206, 20, 'Sofia Rousseau', 'France', NULL, NULL, '75001', '789 Maple Avenue, Suite 101, New York, NY, 10001', NULL, '2024-05-01 00:05:59', '2024-05-23 04:31:26'),
(12, 206, 21, 'صوفيا روسو', 'فرنسا', NULL, NULL, '75001', '789 شارع مابل، جناح 101، نيويورك، نيويورك، 10001', NULL, '2024-05-01 00:05:59', '2024-05-23 04:31:26'),
(13, 207, 20, 'Lily Chen', 'Australia', 'city', 'state', '3000', '1234 Elm Street, Apartment 5B, Springfield, Illinois, USA, 62704', 'Lily provides top-notch administrative and customer support as a virtual assistant.', '2024-05-01 00:09:40', '2025-10-30 07:40:03'),
(14, 207, 21, 'ليلي تشين', 'أستراليا', 'ملبورن', 'state', '3000', '1234 , 5B, سبرينجفيلد, إلينوي, الولايات المتحدة الأمريكية, 62704', 'توفر Lily دعمًا إداريًا ودعمًا للعملاء من الدرجة الأولى كمساعد افتراضي.', '2024-05-01 00:09:40', '2025-10-30 07:40:30');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_notifications`
--

CREATE TABLE `vendor_notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint UNSIGNED DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `video_sections`
--

CREATE TABLE `video_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `video_sections`
--

INSERT INTO `video_sections` (`id`, `language_id`, `subtitle`, `title`, `video_url`, `button_name`, `button_url`, `created_at`, `updated_at`) VALUES
(1, 20, 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusa ntium doloremque.  Start From: $200.00', 'Explore Your Favorite Restaurant Listsss', 'https://www.youtube.com/watch?v=QSwvg9Rv2EI', 'Browse moreee', 'https://www.youtube.com/', '2023-12-12 23:15:10', '2023-12-12 23:29:03'),
(2, 21, 'هل تريد أن تكون بائعًا لقائمة السيارات؟', 'افتح متجرك في سوق البلد', 'https://www.youtube.com/watch?v=QSwvg9Rv2EI', 'سجل الان', 'https://codecanyon8.kreativdev.com/carlist/vendor/signup', '2023-12-12 23:16:35', '2023-12-12 23:31:13');

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `visitors`
--

INSERT INTO `visitors` (`id`, `listing_id`, `vendor_id`, `ip_address`, `date`, `created_at`, `updated_at`) VALUES
(1, 1, 204, '127.0.0.1', '2024-05-02', '2024-05-01 21:12:05', '2024-05-01 21:12:05'),
(3, 3, 204, '127.0.0.1', '2024-05-02', '2024-05-01 23:49:53', '2024-05-01 23:49:53'),
(4, 4, 204, '127.0.0.1', '2024-05-02', '2024-05-02 02:43:32', '2024-05-02 02:43:32'),
(5, 1, 204, '127.0.0.1', '2024-05-06', '2024-05-05 20:40:04', '2024-05-05 20:40:04'),
(7, 4, 204, '127.0.0.1', '2024-05-06', '2024-05-05 20:40:26', '2024-05-05 20:40:26'),
(8, 5, 207, '127.0.0.1', '2024-05-06', '2024-05-05 21:00:12', '2024-05-05 21:00:12'),
(9, 6, 206, '127.0.0.1', '2024-05-06', '2024-05-05 22:08:15', '2024-05-05 22:08:15'),
(10, 7, 205, '127.0.0.1', '2024-05-06', '2024-05-05 23:24:17', '2024-05-05 23:24:17'),
(12, 5, 207, '127.0.0.1', '2024-05-07', '2024-05-06 20:38:05', '2024-05-06 20:38:05'),
(13, 9, 201, '127.0.0.1', '2024-05-07', '2024-05-06 20:58:24', '2024-05-06 20:58:24'),
(14, 10, 203, '127.0.0.1', '2024-05-07', '2024-05-06 21:33:19', '2024-05-06 21:33:19'),
(15, 11, 202, '127.0.0.1', '2024-05-07', '2024-05-06 22:34:41', '2024-05-06 22:34:41'),
(16, 12, 205, '127.0.0.1', '2024-05-07', '2024-05-07 00:20:21', '2024-05-07 00:20:21'),
(17, 13, 207, '127.0.0.1', '2024-05-07', '2024-05-07 02:56:24', '2024-05-07 02:56:24'),
(18, 1, 204, '127.0.0.1', '2024-05-07', '2024-05-07 02:57:57', '2024-05-07 02:57:57'),
(19, 4, 204, '127.0.0.1', '2024-05-08', '2024-05-07 21:30:27', '2024-05-07 21:30:27'),
(20, 1, 204, '127.0.0.1', '2024-05-08', '2024-05-07 22:31:14', '2024-05-07 22:31:14'),
(22, 11, 202, '127.0.0.1', '2024-05-08', '2024-05-07 22:36:24', '2024-05-07 22:36:24'),
(23, 10, 203, '127.0.0.1', '2024-05-08', '2024-05-07 22:45:38', '2024-05-07 22:45:38'),
(24, 3, 204, '127.0.0.1', '2024-05-08', '2024-05-07 23:33:14', '2024-05-07 23:33:14'),
(25, 14, 204, '127.0.0.1', '2024-05-08', '2024-05-07 23:36:42', '2024-05-07 23:36:42'),
(26, 15, 204, '127.0.0.1', '2024-05-08', '2024-05-08 03:00:30', '2024-05-08 03:00:30'),
(27, 13, 207, '127.0.0.1', '2024-05-08', '2024-05-08 03:33:43', '2024-05-08 03:33:43'),
(28, 12, 205, '127.0.0.1', '2024-05-08', '2024-05-08 03:37:20', '2024-05-08 03:37:20'),
(30, 9, 201, '127.0.0.1', '2024-05-08', '2024-05-08 03:43:31', '2024-05-08 03:43:31'),
(31, 5, 207, '127.0.0.1', '2024-05-08', '2024-05-08 03:44:02', '2024-05-08 03:44:02'),
(32, 6, 206, '127.0.0.1', '2024-05-08', '2024-05-08 03:46:15', '2024-05-08 03:46:15'),
(33, 7, 205, '127.0.0.1', '2024-05-08', '2024-05-08 03:47:30', '2024-05-08 03:47:30'),
(34, 5, 207, '127.0.0.1', '2024-05-11', '2024-05-10 23:26:54', '2024-05-10 23:26:54'),
(36, 1, 204, '127.0.0.1', '2024-05-15', '2024-05-15 04:01:53', '2024-05-15 04:01:53'),
(37, 4, 204, '127.0.0.1', '2024-05-16', '2024-05-16 03:46:08', '2024-05-16 03:46:08'),
(40, 15, 204, '127.0.0.1', '2024-06-02', '2024-06-02 03:01:03', '2024-06-02 03:01:03'),
(41, 15, 204, '127.0.0.1', '2024-07-08', '2024-07-08 04:04:12', '2024-07-08 04:04:12'),
(42, 1, 204, '127.0.0.1', '2024-08-10', '2024-08-10 02:13:34', '2024-08-10 02:13:34'),
(43, 10, 203, '127.0.0.1', '2024-10-01', '2024-09-30 22:00:59', '2024-09-30 22:00:59'),
(44, 15, 204, '127.0.0.1', '2024-10-15', '2024-10-15 01:07:41', '2024-10-15 01:07:41'),
(45, 10, 203, '127.0.0.1', '2024-10-15', '2024-10-15 01:11:11', '2024-10-15 01:11:11'),
(46, 15, 204, '127.0.0.1', '2024-10-29', '2024-10-28 23:53:36', '2024-10-28 23:53:36'),
(47, 15, 204, '127.0.0.1', '2024-11-09', '2024-11-08 23:06:53', '2024-11-08 23:06:53'),
(48, 15, 204, '127.0.0.1', '2024-11-20', '2024-11-20 00:37:18', '2024-11-20 00:37:18'),
(49, 4, 204, '127.0.0.1', '2024-11-30', '2024-11-30 00:33:57', '2024-11-30 00:33:57'),
(52, 1, 204, '127.0.0.1', '2025-01-19', '2025-01-18 21:57:56', '2025-01-18 21:57:56'),
(53, 1, 204, '127.0.0.1', '2025-09-17', '2025-09-17 02:00:22', '2025-09-17 02:00:22'),
(54, 13, 207, '127.0.0.1', '2025-09-17', '2025-09-17 04:16:11', '2025-09-17 04:16:11'),
(56, 10, 203, '127.0.0.1', '2025-09-20', '2025-09-20 01:42:48', '2025-09-20 01:42:48'),
(57, 3, 204, '127.0.0.1', '2025-09-20', '2025-09-20 01:43:05', '2025-09-20 01:43:05'),
(58, 1, 204, '127.0.0.1', '2025-09-20', '2025-09-20 01:43:21', '2025-09-20 01:43:21'),
(59, 5, 207, '127.0.0.1', '2025-09-21', '2025-09-21 02:29:37', '2025-09-21 02:29:37'),
(60, 13, 207, '127.0.0.1', '2025-09-21', '2025-09-21 06:58:57', '2025-09-21 06:58:57'),
(61, 10, 203, '127.0.0.1', '2025-09-21', '2025-09-21 07:11:16', '2025-09-21 07:11:16'),
(62, 12, 205, '127.0.0.1', '2025-09-21', '2025-09-21 07:11:27', '2025-09-21 07:11:27'),
(63, 14, 204, '127.0.0.1', '2025-09-21', '2025-09-21 07:11:40', '2025-09-21 07:11:40'),
(64, 15, 204, '127.0.0.1', '2025-09-21', '2025-09-21 07:11:57', '2025-09-21 07:11:57'),
(66, 1, 204, '127.0.0.1', '2025-09-22', '2025-09-22 07:00:19', '2025-09-22 07:00:19'),
(68, 1, 204, '127.0.0.1', '2025-09-30', '2025-09-30 01:41:33', '2025-09-30 01:41:33'),
(69, 13, 207, '127.0.0.1', '2025-10-04', '2025-10-04 05:01:46', '2025-10-04 05:01:46'),
(70, 13, 207, '127.0.0.1', '2025-10-10', '2025-10-10 07:18:10', '2025-10-10 07:18:10'),
(71, 5, 207, '127.0.0.1', '2025-10-10', '2025-10-10 07:18:42', '2025-10-10 07:18:42'),
(73, 13, 207, '127.0.0.1', '2025-10-15', '2025-10-14 23:16:23', '2025-10-14 23:16:23'),
(74, 15, 204, '127.0.0.1', '2025-10-21', '2025-10-20 22:23:27', '2025-10-20 22:23:27'),
(75, 1, 204, '127.0.0.1', '2025-10-21', '2025-10-21 04:07:24', '2025-10-21 04:07:24'),
(76, 10, 203, '127.0.0.1', '2025-10-23', '2025-10-22 23:02:08', '2025-10-22 23:02:08'),
(78, 1, 204, '127.0.0.1', '2025-10-24', '2025-10-24 06:15:17', '2025-10-24 06:15:17'),
(79, 13, 207, '127.0.0.1', '2025-10-25', '2025-10-25 05:20:42', '2025-10-25 05:20:42'),
(80, 15, 204, '127.0.0.1', '2025-10-25', '2025-10-25 06:13:12', '2025-10-25 06:13:12'),
(82, 5, 207, '127.0.0.1', '2025-10-27', '2025-10-27 00:09:31', '2025-10-27 00:09:31'),
(84, 5, 207, '127.0.0.1', '2025-10-28', '2025-10-27 22:36:03', '2025-10-27 22:36:03'),
(85, 13, 207, '127.0.0.1', '2025-10-29', '2025-10-29 06:58:44', '2025-10-29 06:58:44'),
(86, 17, 0, '127.0.0.1', '2025-10-29', '2025-10-29 06:59:08', '2025-10-29 06:59:08'),
(87, 12, 205, '127.0.0.1', '2025-10-30', '2025-10-30 00:18:18', '2025-10-30 00:18:18'),
(88, 1, 204, '127.0.0.1', '2025-10-30', '2025-10-30 02:10:14', '2025-10-30 02:10:14'),
(89, 4, 204, '127.0.0.1', '2025-10-30', '2025-10-30 02:10:23', '2025-10-30 02:10:23'),
(90, 11, 202, '127.0.0.1', '2025-10-30', '2025-10-30 08:16:00', '2025-10-30 08:16:00'),
(91, 13, 207, '127.0.0.1', '2025-10-31', '2025-10-31 05:53:02', '2025-10-31 05:53:02'),
(92, 17, 0, '127.0.0.1', '2025-11-03', '2025-11-03 00:00:06', '2025-11-03 00:00:06'),
(93, 11, 202, '127.0.0.1', '2025-11-03', '2025-11-03 00:00:52', '2025-11-03 00:00:52'),
(94, 15, 204, '127.0.0.1', '2025-11-03', '2025-11-03 00:03:16', '2025-11-03 00:03:16'),
(95, 14, 204, '127.0.0.1', '2025-11-03', '2025-11-03 07:28:08', '2025-11-03 07:28:08'),
(96, 12, 205, '127.0.0.1', '2025-11-03', '2025-11-03 07:30:30', '2025-11-03 07:30:30'),
(97, 14, 204, '127.0.0.1', '2025-11-04', '2025-11-03 22:52:56', '2025-11-03 22:52:56'),
(98, 15, 204, '127.0.0.1', '2025-11-04', '2025-11-03 22:55:03', '2025-11-03 22:55:03'),
(99, 1, 204, '127.0.0.1', '2025-11-04', '2025-11-03 23:01:50', '2025-11-03 23:01:50'),
(100, 10, 203, '127.0.0.1', '2025-11-17', '2025-11-17 04:21:53', '2025-11-17 04:21:53'),
(101, 7, 205, '127.0.0.1', '2025-11-17', '2025-11-17 06:16:34', '2025-11-17 06:16:34'),
(102, 11, 202, '127.0.0.1', '2025-11-18', '2025-11-17 23:13:51', '2025-11-17 23:13:51'),
(103, 10, 203, '127.0.0.1', '2025-11-20', '2025-11-20 00:28:23', '2025-11-20 00:28:23'),
(104, 15, 204, '127.0.0.1', '2025-11-22', '2025-11-22 06:21:43', '2025-11-22 06:21:43'),
(105, 10, 203, '127.0.0.1', '2025-11-22', '2025-11-22 06:21:52', '2025-11-22 06:21:52'),
(106, 14, 204, '127.0.0.1', '2025-11-24', '2025-11-23 22:56:48', '2025-11-23 22:56:48'),
(107, 14, 204, '127.0.0.1', '2025-11-25', '2025-11-25 02:57:28', '2025-11-25 02:57:28'),
(108, 15, 204, '127.0.0.1', '2025-11-25', '2025-11-25 03:28:02', '2025-11-25 03:28:02'),
(109, 9, 201, '127.0.0.1', '2025-11-25', '2025-11-25 04:00:12', '2025-11-25 04:00:12'),
(110, 15, 204, '127.0.0.1', '2025-11-26', '2025-11-26 01:16:25', '2025-11-26 01:16:25'),
(111, 14, 204, '127.0.0.1', '2025-12-06', '2025-12-06 04:28:14', '2025-12-06 04:28:14'),
(112, 14, 204, '127.0.0.1', '2025-12-07', '2025-12-06 20:51:31', '2025-12-06 20:51:31'),
(113, 17, 0, '127.0.0.1', '2025-12-07', '2025-12-06 22:02:21', '2025-12-06 22:02:21'),
(114, 11, 202, '127.0.0.1', '2025-12-07', '2025-12-06 22:03:29', '2025-12-06 22:03:29'),
(115, 10, 203, '127.0.0.1', '2025-12-07', '2025-12-06 22:58:19', '2025-12-06 22:58:19'),
(116, 1, 204, '127.0.0.1', '2025-12-07', '2025-12-06 23:02:19', '2025-12-06 23:02:19'),
(118, 4, 204, '127.0.0.1', '2026-04-05', '2026-04-05 03:51:48', '2026-04-05 03:51:48'),
(119, 14, 204, '127.0.0.1', '2026-04-07', '2026-04-07 04:39:55', '2026-04-07 04:39:55'),
(120, 15, 204, '127.0.0.1', '2026-04-07', '2026-04-07 04:39:55', '2026-04-07 04:39:55'),
(121, 4, 204, '127.0.0.1', '2026-04-07', '2026-04-07 04:39:55', '2026-04-07 04:39:55'),
(122, 3, 204, '127.0.0.1', '2026-04-07', '2026-04-07 04:39:56', '2026-04-07 04:39:56'),
(123, 1, 204, '127.0.0.1', '2026-04-07', '2026-04-07 04:39:57', '2026-04-07 04:39:57'),
(124, 15, 204, '127.0.0.1', '2026-04-22', '2026-04-21 22:16:04', '2026-04-21 22:16:04'),
(125, 1, 204, '127.0.0.1', '2026-04-22', '2026-04-21 23:50:00', '2026-04-21 23:50:00'),
(126, 14, 204, '127.0.0.1', '2026-04-22', '2026-04-21 23:51:57', '2026-04-21 23:51:57'),
(127, 4, 204, '127.0.0.1', '2026-04-22', '2026-04-21 23:51:58', '2026-04-21 23:51:58'),
(128, 14, 204, '127.0.0.1', '2026-05-12', '2026-05-12 08:19:09', '2026-05-12 08:19:09'),
(129, 13, 207, '127.0.0.1', '2026-05-12', '2026-05-12 08:20:50', '2026-05-12 08:20:50'),
(130, 18, 0, '127.0.0.1', '2026-05-12', '2026-05-12 08:20:59', '2026-05-12 08:20:59'),
(131, 12, 205, '127.0.0.1', '2026-05-12', '2026-05-12 08:21:06', '2026-05-12 08:21:06'),
(132, 1, 204, '127.0.0.1', '2026-05-12', '2026-05-12 08:23:23', '2026-05-12 08:23:23'),
(133, 1, 204, '127.0.0.1', '2026-05-13', '2026-05-12 23:42:03', '2026-05-12 23:42:03'),
(134, 14, 204, '127.0.0.1', '2026-05-13', '2026-05-13 01:17:19', '2026-05-13 01:17:19'),
(135, 18, 0, '127.0.0.1', '2026-05-21', '2026-05-21 05:40:43', '2026-05-21 05:40:43'),
(136, 17, 0, '127.0.0.1', '2026-05-21', '2026-05-21 05:48:43', '2026-05-21 05:48:43'),
(137, 1, 204, '127.0.0.1', '2026-05-21', '2026-05-21 06:07:52', '2026-05-21 06:07:52');

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint NOT NULL,
  `listing_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `wishlists`
--

INSERT INTO `wishlists` (`id`, `user_id`, `listing_id`, `created_at`, `updated_at`) VALUES
(1, 1, 14, '2024-05-07 21:29:55', '2024-05-07 21:29:55'),
(3, 1, 6, '2024-05-07 21:30:04', '2024-05-07 21:30:04'),
(4, 1, 2, '2024-05-07 21:30:15', '2024-05-07 21:30:15'),
(7, 12, 9, '2025-11-19 05:31:27', '2025-11-19 05:31:27'),
(12, 12, 10, '2025-11-25 00:20:42', '2025-11-25 00:20:42');

-- --------------------------------------------------------

--
-- Table structure for table `withdraws`
--

CREATE TABLE `withdraws` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint UNSIGNED DEFAULT NULL,
  `withdraw_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_id` int DEFAULT NULL,
  `amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payable_amount` double(8,2) NOT NULL DEFAULT '0.00',
  `total_charge` double(8,2) NOT NULL DEFAULT '0.00',
  `additional_reference` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `feilds` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `withdraws`
--

INSERT INTO `withdraws` (`id`, `vendor_id`, `withdraw_id`, `method_id`, `amount`, `payable_amount`, `total_charge`, `additional_reference`, `feilds`, `status`, `created_at`, `updated_at`) VALUES
(2, 207, '68ee487aba6b1', 2, '10', 7.60, 2.40, 'test', '{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"3434344343\",\"bKash_Account_Holder_Name\":\"jonh doe\"}', 2, '2025-10-14 06:56:26', '2025-10-14 06:58:36'),
(8, 204, '69d228497bccc', 2, '1000', 948.10, 51.90, NULL, '{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"01403818435\",\"bKash_Account_Holder_Name\":\"Goutam\"}', 1, '2026-04-05 03:15:53', '2026-04-12 04:46:17'),
(9, 204, '69d2284a8d00b', 2, '1000', 948.10, 51.90, NULL, '{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"01403818435\",\"bKash_Account_Holder_Name\":\"Goutam\"}', 2, '2026-04-05 03:15:54', '2026-04-12 04:46:22'),
(16, 204, '69db77d718e8e', 2, '1000', 948.10, 51.90, NULL, '{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"0151828826\",\"bKash_Account_Holder_Name\":\"Goutam Sharma\"}', 1, '2026-04-12 04:45:43', '2026-04-12 04:45:59'),
(17, 204, '69db78a39ebde', 2, '1000', 948.10, 51.90, NULL, '{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"15728281991\",\"bKash_Account_Holder_Name\":\"Super Business\"}', 0, '2026-04-12 04:49:07', '2026-04-12 04:49:07'),
(18, 204, '6a03361d47187', 2, '50', 45.60, 4.40, 'nkjkk', '{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"1313\",\"bKash_Account_Holder_Name\":\"jhjhjh\"}', 1, '2026-05-12 08:15:57', '2026-05-12 08:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_method_inputs`
--

CREATE TABLE `withdraw_method_inputs` (
  `id` bigint UNSIGNED NOT NULL,
  `withdraw_payment_method_id` bigint UNSIGNED DEFAULT NULL,
  `type` tinyint DEFAULT NULL COMMENT '1-text, 2-select, 3-checkbox, 4-textarea, 5-datepicker, 6-timepicker, 7-number',
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placeholder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required` tinyint NOT NULL DEFAULT '0' COMMENT '1-required, 0-optional',
  `order_number` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `withdraw_method_inputs`
--

INSERT INTO `withdraw_method_inputs` (`id`, `withdraw_payment_method_id`, `type`, `label`, `name`, `placeholder`, `required`, `order_number`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'fdfd', 'fdfd', 'fdfd', 1, 1, '2025-10-14 02:55:54', '2025-10-14 02:55:54'),
(2, 1, 2, 'test12', 'test12', 'test2', 0, 2, '2025-10-14 04:14:54', '2025-10-14 04:15:08'),
(3, 1, 6, 'time', 'time', 'time', 1, 3, '2025-10-14 04:15:47', '2025-10-14 04:15:47'),
(4, 1, 5, 'date', 'date', 'date', 1, 4, '2025-10-14 04:16:01', '2025-10-14 04:16:01'),
(5, 1, 3, 'fdfdf', 'fdfdf', NULL, 1, 5, '2025-10-14 04:24:37', '2025-10-14 04:24:37'),
(6, 1, 4, 'fdfdfdfdfdd', 'fdfdfdfdfdd', 'fdf', 1, 6, '2025-10-14 04:24:50', '2025-10-14 04:24:50'),
(7, 2, 2, 'bKash Account Type', 'bKash_Account_Type', 'Select a  Type', 1, 1, '2025-10-14 05:04:12', '2025-10-14 05:04:12'),
(8, 2, 1, 'bKash Mobile Number', 'bKash_Mobile_Number', 'Enter number', 1, 2, '2025-10-14 05:04:41', '2025-10-14 05:04:41'),
(9, 2, 1, 'bKash Account Holder Name', 'bKash_Account_Holder_Name', 'Enter name', 1, 3, '2025-10-14 05:05:01', '2025-10-14 05:05:01');

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_method_options`
--

CREATE TABLE `withdraw_method_options` (
  `id` bigint UNSIGNED NOT NULL,
  `withdraw_method_input_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `withdraw_method_options`
--

INSERT INTO `withdraw_method_options` (`id`, `withdraw_method_input_id`, `name`, `created_at`, `updated_at`) VALUES
(2, 2, 'test2', '2025-10-14 04:15:08', '2025-10-14 04:15:08'),
(3, 5, 'fdffd', '2025-10-14 04:24:37', '2025-10-14 04:24:37'),
(4, 5, 'fdfdfddf', '2025-10-14 04:24:37', '2025-10-14 04:24:37'),
(5, 7, 'Personal', '2025-10-14 05:04:12', '2025-10-14 05:04:12'),
(6, 7, 'Agent', '2025-10-14 05:04:12', '2025-10-14 05:04:12'),
(7, 7, 'Merchant', '2025-10-14 05:04:12', '2025-10-14 05:04:12');

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_payment_methods`
--

CREATE TABLE `withdraw_payment_methods` (
  `id` bigint UNSIGNED NOT NULL,
  `min_limit` double(12,2) DEFAULT NULL,
  `max_limit` double(12,2) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `fixed_charge` double(12,2) NOT NULL DEFAULT '0.00',
  `percentage_charge` double(12,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `withdraw_payment_methods`
--

INSERT INTO `withdraw_payment_methods` (`id`, `min_limit`, `max_limit`, `name`, `status`, `fixed_charge`, `percentage_charge`, `created_at`, `updated_at`) VALUES
(2, 10.00, 1000.00, 'bkash', 1, 2.00, 5.00, '2025-10-14 04:58:14', '2026-04-05 03:12:48');

-- --------------------------------------------------------

--
-- Table structure for table `work_processes`
--

CREATE TABLE `work_processes` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` int UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `work_processes`
--

INSERT INTO `work_processes` (`id`, `language_id`, `icon`, `serial_number`, `title`, `text`, `created_at`, `updated_at`) VALUES
(14, 20, 'fas fa-suitcase', 3, 'Explore Selected Place', 'They are definitely recommend them if you are looking for a good car service. always on time, and they\'re very professional.', '2023-08-19 04:06:12', '2024-05-09 02:45:00'),
(15, 20, 'fas fa-map-marker-alt', 2, 'Select Favorite Place', 'They definitely recommend them if you are looking for a good car service. always on time, and they\'re very professional.', '2023-08-19 04:06:46', '2024-05-09 02:45:23'),
(16, 20, 'fas fa-th', 1, 'Choose A Category', 'They definitely recommend them if you are looking for a good car service. always on time, and they\'re very professional.', '2023-08-19 04:07:22', '2024-05-09 02:46:06'),
(17, 21, 'fas fa-search', 1, 'ابحث عن سيارة أحلامك', 'إنهم بالتأكيد يوصون بهم إذا كنت تبحث عن خدمة سيارات جيدة. دائمًا في الوقت المحدد، وهم محترفون جدًا.', '2023-08-28 03:00:33', '2023-08-28 03:00:33'),
(18, 21, 'fas fa-file-invoice-dollar', 2, 'التحقق من السعر مع الميزات', 'إنهم يوصون بهم بالتأكيد إذا كنت تبحث عن خدمة سيارات جيدة. دائمًا في الوقت المحدد، وهم محترفون جدًا.', '2023-08-28 03:01:12', '2023-08-28 03:01:12'),
(19, 21, 'fas fa-headphones-alt', 3, 'تواصل مع التاجر', 'إنهم يوصون بهم بالتأكيد إذا كنت تبحث عن خدمة سيارات جيدة. دائمًا في الوقت المحدد، وهم محترفون جدًا.', '2023-08-28 03:02:15', '2023-08-28 03:02:15');

-- --------------------------------------------------------

--
-- Table structure for table `work_process_sections`
--

CREATE TABLE `work_process_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `button_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `work_process_sections`
--

INSERT INTO `work_process_sections` (`id`, `language_id`, `button_text`, `title`, `created_at`, `updated_at`) VALUES
(3, 20, 'Explore Listings', 'How Bulistio Works', '2023-08-19 04:05:15', '2024-05-06 03:07:43'),
(4, 21, 'استكشاف القوائم', 'كيف يعمل بوليستيو', '2023-08-28 02:59:46', '2024-05-06 03:15:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_username_unique` (`username`),
  ADD UNIQUE KEY `admins_email_unique` (`email`),
  ADD KEY `admins_role_id_foreign` (`role_id`);

--
-- Indexes for table `advertisements`
--
ALTER TABLE `advertisements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `aminites`
--
ALTER TABLE `aminites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `basic_settings`
--
ALTER TABLE `basic_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_categories_language_id_foreign` (`language_id`);

--
-- Indexes for table `blog_informations`
--
ALTER TABLE `blog_informations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_informations_language_id_foreign` (`language_id`),
  ADD KEY `blog_informations_blog_category_id_foreign` (`blog_category_id`),
  ADD KEY `blog_informations_blog_id_foreign` (`blog_id`);

--
-- Indexes for table `blog_sections`
--
ALTER TABLE `blog_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_hours`
--
ALTER TABLE `business_hours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `call_to_action_sections`
--
ALTER TABLE `call_to_action_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_sections`
--
ALTER TABLE `category_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `claim_listings`
--
ALTER TABLE `claim_listings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cookie_alerts`
--
ALTER TABLE `cookie_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cookie_alerts_language_id_foreign` (`language_id`);

--
-- Indexes for table `counter_informations`
--
ALTER TABLE `counter_informations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `counter_sections`
--
ALTER TABLE `counter_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faqs_language_id_foreign` (`language_id`);

--
-- Indexes for table `fcm_tokens`
--
ALTER TABLE `fcm_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `featured_listing_charges`
--
ALTER TABLE `featured_listing_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature_orders`
--
ALTER TABLE `feature_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature_sections`
--
ALTER TABLE `feature_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `footer_contents`
--
ALTER TABLE `footer_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `footer_texts_language_id_foreign` (`language_id`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `form_inputs`
--
ALTER TABLE `form_inputs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hero_sections`
--
ALTER TABLE `hero_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listings`
--
ALTER TABLE `listings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `average_rating` (`average_rating`);

--
-- Indexes for table `listing_categories`
--
ALTER TABLE `listing_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_contents`
--
ALTER TABLE `listing_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_faqs`
--
ALTER TABLE `listing_faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_features`
--
ALTER TABLE `listing_features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_feature_contents`
--
ALTER TABLE `listing_feature_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_images`
--
ALTER TABLE `listing_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_messages`
--
ALTER TABLE `listing_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_products`
--
ALTER TABLE `listing_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_product_contents`
--
ALTER TABLE `listing_product_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_product_images`
--
ALTER TABLE `listing_product_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_reviews`
--
ALTER TABLE `listing_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_sections`
--
ALTER TABLE `listing_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_socail_medias`
--
ALTER TABLE `listing_socail_medias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `location_sections`
--
ALTER TABLE `location_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_templates`
--
ALTER TABLE `mail_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memberships`
--
ALTER TABLE `memberships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_builders`
--
ALTER TABLE `menu_builders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mobile_interface_settings`
--
ALTER TABLE `mobile_interface_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offline_gateways`
--
ALTER TABLE `offline_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `online_gateways`
--
ALTER TABLE `online_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `package_sections`
--
ALTER TABLE `package_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page_contents`
--
ALTER TABLE `page_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_contents_language_id_foreign` (`language_id`),
  ADD KEY `page_contents_page_id_foreign` (`page_id`);

--
-- Indexes for table `page_headings`
--
ALTER TABLE `page_headings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_headings_language_id_foreign` (`language_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payment_invoices`
--
ALTER TABLE `payment_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `popups`
--
ALTER TABLE `popups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `popups_language_id_foreign` (`language_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_categories_language_id_foreign` (`language_id`);

--
-- Indexes for table `product_contents`
--
ALTER TABLE `product_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_contents_language_id_foreign` (`language_id`),
  ADD KEY `product_contents_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_coupons`
--
ALTER TABLE `product_coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_messages`
--
ALTER TABLE `product_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_orders`
--
ALTER TABLE `product_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `product_purchase_items`
--
ALTER TABLE `product_purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_purchase_items_product_order_id_foreign` (`product_order_id`),
  ADD KEY `product_purchase_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_reviews_user_id_foreign` (`user_id`),
  ADD KEY `product_reviews_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_shipping_charges`
--
ALTER TABLE `product_shipping_charges`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shipping_charges_language_id_foreign` (`language_id`);

--
-- Indexes for table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `push_subscriptions_endpoint_unique` (`endpoint`),
  ADD KEY `push_subscriptions_subscribable_type_subscribable_id_index` (`subscribable_type`,`subscribable_id`);

--
-- Indexes for table `quick_links`
--
ALTER TABLE `quick_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quick_links_language_id_foreign` (`language_id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seos`
--
ALTER TABLE `seos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seos_language_id_foreign` (`language_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_medias`
--
ALTER TABLE `social_medias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscribers_email_id_unique` (`email_id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_ticket_statuses`
--
ALTER TABLE `support_ticket_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonial_sections`
--
ALTER TABLE `testimonial_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `timezones`
--
ALTER TABLE `timezones`
  ADD PRIMARY KEY (`country_code`,`timezone`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor_devices`
--
ALTER TABLE `vendor_devices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendor_devices_fcm_token_unique` (`fcm_token`);

--
-- Indexes for table `vendor_infos`
--
ALTER TABLE `vendor_infos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor_notifications`
--
ALTER TABLE `vendor_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `video_sections`
--
ALTER TABLE `video_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraws`
--
ALTER TABLE `withdraws`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_method_inputs`
--
ALTER TABLE `withdraw_method_inputs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_method_options`
--
ALTER TABLE `withdraw_method_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_payment_methods`
--
ALTER TABLE `withdraw_payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work_processes`
--
ALTER TABLE `work_processes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work_process_sections`
--
ALTER TABLE `work_process_sections`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `advertisements`
--
ALTER TABLE `advertisements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `aminites`
--
ALTER TABLE `aminites`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `basic_settings`
--
ALTER TABLE `basic_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `blog_informations`
--
ALTER TABLE `blog_informations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `blog_sections`
--
ALTER TABLE `blog_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `business_hours`
--
ALTER TABLE `business_hours`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `call_to_action_sections`
--
ALTER TABLE `call_to_action_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `category_sections`
--
ALTER TABLE `category_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `claim_listings`
--
ALTER TABLE `claim_listings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `cookie_alerts`
--
ALTER TABLE `cookie_alerts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `counter_informations`
--
ALTER TABLE `counter_informations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `counter_sections`
--
ALTER TABLE `counter_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `fcm_tokens`
--
ALTER TABLE `fcm_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `featured_listing_charges`
--
ALTER TABLE `featured_listing_charges`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `feature_orders`
--
ALTER TABLE `feature_orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `feature_sections`
--
ALTER TABLE `feature_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `footer_contents`
--
ALTER TABLE `footer_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `form_inputs`
--
ALTER TABLE `form_inputs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `guests`
--
ALTER TABLE `guests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `hero_sections`
--
ALTER TABLE `hero_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `listings`
--
ALTER TABLE `listings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `listing_categories`
--
ALTER TABLE `listing_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `listing_contents`
--
ALTER TABLE `listing_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `listing_faqs`
--
ALTER TABLE `listing_faqs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=235;

--
-- AUTO_INCREMENT for table `listing_features`
--
ALTER TABLE `listing_features`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `listing_feature_contents`
--
ALTER TABLE `listing_feature_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- AUTO_INCREMENT for table `listing_images`
--
ALTER TABLE `listing_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `listing_messages`
--
ALTER TABLE `listing_messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `listing_products`
--
ALTER TABLE `listing_products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `listing_product_contents`
--
ALTER TABLE `listing_product_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `listing_product_images`
--
ALTER TABLE `listing_product_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `listing_reviews`
--
ALTER TABLE `listing_reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `listing_sections`
--
ALTER TABLE `listing_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `listing_socail_medias`
--
ALTER TABLE `listing_socail_medias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `location_sections`
--
ALTER TABLE `location_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mail_templates`
--
ALTER TABLE `mail_templates`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `menu_builders`
--
ALTER TABLE `menu_builders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `mobile_interface_settings`
--
ALTER TABLE `mobile_interface_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `offline_gateways`
--
ALTER TABLE `offline_gateways`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `online_gateways`
--
ALTER TABLE `online_gateways`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `package_sections`
--
ALTER TABLE `package_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `page_contents`
--
ALTER TABLE `page_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `page_headings`
--
ALTER TABLE `page_headings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `payment_invoices`
--
ALTER TABLE `payment_invoices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `popups`
--
ALTER TABLE `popups`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `product_contents`
--
ALTER TABLE `product_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;

--
-- AUTO_INCREMENT for table `product_coupons`
--
ALTER TABLE `product_coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `product_messages`
--
ALTER TABLE `product_messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `product_orders`
--
ALTER TABLE `product_orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `product_purchase_items`
--
ALTER TABLE `product_purchase_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `product_shipping_charges`
--
ALTER TABLE `product_shipping_charges`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `quick_links`
--
ALTER TABLE `quick_links`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `seos`
--
ALTER TABLE `seos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_medias`
--
ALTER TABLE `social_medias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `support_ticket_statuses`
--
ALTER TABLE `support_ticket_statuses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `testimonial_sections`
--
ALTER TABLE `testimonial_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=235;

--
-- AUTO_INCREMENT for table `vendor_devices`
--
ALTER TABLE `vendor_devices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vendor_infos`
--
ALTER TABLE `vendor_infos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `vendor_notifications`
--
ALTER TABLE `vendor_notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `video_sections`
--
ALTER TABLE `video_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `withdraws`
--
ALTER TABLE `withdraws`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `withdraw_method_inputs`
--
ALTER TABLE `withdraw_method_inputs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `withdraw_method_options`
--
ALTER TABLE `withdraw_method_options`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `withdraw_payment_methods`
--
ALTER TABLE `withdraw_payment_methods`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `work_processes`
--
ALTER TABLE `work_processes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `work_process_sections`
--
ALTER TABLE `work_process_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `role_permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD CONSTRAINT `blog_categories_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blog_informations`
--
ALTER TABLE `blog_informations`
  ADD CONSTRAINT `blog_informations_blog_category_id_foreign` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_informations_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_informations_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cookie_alerts`
--
ALTER TABLE `cookie_alerts`
  ADD CONSTRAINT `cookie_alerts_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `faqs_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `footer_contents`
--
ALTER TABLE `footer_contents`
  ADD CONSTRAINT `footer_texts_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `popups`
--
ALTER TABLE `popups`
  ADD CONSTRAINT `popups_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_contents`
--
ALTER TABLE `product_contents`
  ADD CONSTRAINT `product_contents_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_contents_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_orders`
--
ALTER TABLE `product_orders`
  ADD CONSTRAINT `product_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_purchase_items`
--
ALTER TABLE `product_purchase_items`
  ADD CONSTRAINT `product_purchase_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_purchase_items_product_order_id_foreign` FOREIGN KEY (`product_order_id`) REFERENCES `product_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_shipping_charges`
--
ALTER TABLE `product_shipping_charges`
  ADD CONSTRAINT `shipping_charges_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quick_links`
--
ALTER TABLE `quick_links`
  ADD CONSTRAINT `quick_links_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seos`
--
ALTER TABLE `seos`
  ADD CONSTRAINT `seos_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
