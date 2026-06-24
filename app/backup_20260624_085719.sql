/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.18-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: bulistio
-- ------------------------------------------------------
-- Server version	10.11.18-MariaDB-ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `show_email_address` int(11) DEFAULT 0,
  `phone` varchar(255) DEFAULT NULL,
  `show_phone_number` int(11) NOT NULL DEFAULT 0,
  `password` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `lang_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_username_unique` (`username`),
  UNIQUE KEY `admins_email_unique` (`email`),
  KEY `admins_role_id_foreign` (`role_id`),
  CONSTRAINT `admins_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `role_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES
(1,NULL,'Azim','Ahmed','65c20e674bd34.png','admin','leonardbourne@example.com',1,'+39 02 1234 5678',1,'$2y$10$7rcuMv8LG9adF09JnRjt.O35YL/3dkFWA7EBhBT.LOZvS07OaeDFm','House no 3, Road 5/c, sector 11, Uttara, Dhaka, Bangladesh','Lorem ipsum, dolor sit amet consectetur adipisicing elit. Molestiae blanditiis minus tempora quibusdam quas quo magni, repellat sit? Adipisci accusantium quasi autem tempora nemo aspernatur tenetur repellat numquam sed cupiditate.',1,NULL,'2026-06-24 02:52:37','ru','admin_ru'),
(3,4,'Azim','superBusiness47','673ade9473c42.png','superBusiness47','user@gmail.com',0,NULL,0,'$2y$10$l4T0/Q8/TJOpO9IDFgrdTOt6tdxH4DCU/XSZc9B1xixZz1lxHr68.',NULL,NULL,1,'2024-11-18 00:28:36','2024-11-18 00:28:36',NULL,NULL);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertisements`
--

DROP TABLE IF EXISTS `advertisements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisements` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ad_type` varchar(255) NOT NULL,
  `resolution_type` smallint(5) unsigned NOT NULL COMMENT '1 => 300 x 250, 2 => 300 x 600, 3 => 728 x 90',
  `image` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `slot` varchar(50) DEFAULT NULL,
  `views` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisements`
--

LOCK TABLES `advertisements` WRITE;
/*!40000 ALTER TABLE `advertisements` DISABLE KEYS */;
INSERT INTO `advertisements` VALUES
(7,'banner',3,'664f0a5c79248.png','http://example.com/',NULL,7,'2021-08-15 22:44:47','2024-05-23 03:20:28'),
(8,'banner',2,'664f0fea4e4ed.png','http://example.com/',NULL,0,'2021-08-15 22:45:21','2024-05-23 03:44:10'),
(10,'banner',1,'664f100d7ac6d.png','http://example.com/',NULL,2,'2021-08-15 23:13:44','2024-05-23 03:44:45'),
(11,'banner',2,'664f0a7a71f21.png','http://example.com/',NULL,3,'2021-08-15 23:15:14','2024-05-23 03:20:58'),
(12,'banner',1,'664f0a68e96a7.png','http://example.com/',NULL,1,'2021-08-15 23:16:41','2024-05-23 03:20:40'),
(13,'banner',3,'664f0a365d199.png','http://example.com/',NULL,3,'2021-08-17 04:52:09','2025-01-15 23:49:34');
/*!40000 ALTER TABLE `advertisements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aminites`
--

DROP TABLE IF EXISTS `aminites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `aminites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aminites`
--

LOCK TABLES `aminites` WRITE;
/*!40000 ALTER TABLE `aminites` DISABLE KEYS */;
INSERT INTO `aminites` VALUES
(1,20,'fas fa-swimming-pool','Swimming Pool','2024-05-01 20:55:17','2024-05-01 20:55:17'),
(2,21,'fas fa-swimming-pool','حمام السباحة','2024-05-01 20:55:56','2024-05-01 20:55:56'),
(3,20,'fas fa-chair','Comfortable Seating','2024-05-01 20:57:48','2024-05-01 20:57:48'),
(4,21,'fas fa-chair','مقاعد مريحة','2024-05-01 20:58:12','2024-05-01 20:58:12'),
(5,20,'fas fa-wifi','Free Wifi','2024-05-01 20:58:37','2024-05-01 20:58:37'),
(6,21,'fas fa-wifi','واى فاى مجانى','2024-05-01 20:58:58','2024-05-01 20:58:58'),
(8,20,'fas fa-parking','Parking Facilities','2024-05-01 22:25:49','2024-05-01 22:25:49'),
(9,21,'fas fa-parking','مرافق وقوف السيارات','2024-05-01 22:28:18','2024-05-01 22:28:18'),
(10,20,'fas fa-pray','Prayer Room','2024-05-01 22:29:08','2024-05-01 22:29:08'),
(11,21,'fas fa-pray','غرفة الصلاة','2024-05-01 22:29:32','2024-05-01 22:29:32'),
(12,20,'fas fa-file-prescription','Pharmacy','2024-05-01 22:31:31','2024-05-01 22:31:31'),
(13,21,'fas fa-file-prescription','مقابل','2024-05-01 22:31:53','2024-05-01 22:31:53'),
(14,20,'fas fa-stamp','Multilingual Staff','2024-05-01 23:22:01','2024-05-01 23:22:01'),
(15,20,'fas fa-utensils','Resturant','2024-05-02 02:24:15','2024-05-02 02:24:15'),
(16,21,'fas fa-utensils','مطعم','2024-05-02 02:24:53','2024-05-02 02:24:53'),
(17,20,'fab fa-cc-diners-club','Private Dining Room','2024-05-05 20:45:41','2024-05-05 20:45:41'),
(18,21,'fab fa-cc-diners-club','غرفة طعام خاصة','2024-05-05 20:46:03','2024-05-05 20:46:03'),
(19,20,'fas fa-dumbbell','Group Exercise Studios','2024-05-06 02:26:04','2024-05-06 02:26:04'),
(20,21,'fas fa-dumbbell','استوديوهات التمارين الجماعية','2024-05-06 02:26:29','2024-05-07 23:27:58'),
(21,20,'fas fa-lock','Locker Rooms','2024-05-06 02:26:56','2024-05-06 02:26:56'),
(22,21,'fas fa-lock','غرف خلع الملابس','2024-05-06 02:27:18','2024-11-08 21:03:15');
/*!40000 ALTER TABLE `aminites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `basic_settings`
--

DROP TABLE IF EXISTS `basic_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `basic_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uniqid` int(10) unsigned NOT NULL DEFAULT 12345,
  `favicon` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `logo_two` varchar(255) DEFAULT NULL,
  `website_title` varchar(255) DEFAULT NULL,
  `redeem_token_expire_days` smallint(5) unsigned NOT NULL DEFAULT 3,
  `email_address` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `theme_version` smallint(5) unsigned NOT NULL,
  `base_currency_symbol` varchar(255) DEFAULT NULL,
  `base_currency_symbol_position` varchar(20) DEFAULT NULL,
  `base_currency_text` varchar(20) DEFAULT NULL,
  `base_currency_text_position` varchar(20) DEFAULT NULL,
  `base_currency_rate` decimal(8,2) DEFAULT NULL,
  `primary_color` varchar(30) DEFAULT NULL,
  `smtp_status` tinyint(4) DEFAULT NULL,
  `smtp_host` varchar(255) DEFAULT NULL,
  `smtp_port` int(11) DEFAULT NULL,
  `encryption` varchar(50) DEFAULT NULL,
  `smtp_username` varchar(255) DEFAULT NULL,
  `smtp_password` varchar(255) DEFAULT NULL,
  `from_mail` varchar(255) DEFAULT NULL,
  `from_name` varchar(255) DEFAULT NULL,
  `to_mail` varchar(255) DEFAULT NULL,
  `breadcrumb` varchar(255) DEFAULT NULL,
  `disqus_status` tinyint(3) unsigned DEFAULT NULL,
  `disqus_short_name` varchar(255) DEFAULT NULL,
  `google_recaptcha_status` tinyint(4) DEFAULT NULL,
  `google_recaptcha_site_key` varchar(255) DEFAULT NULL,
  `google_recaptcha_secret_key` varchar(255) DEFAULT NULL,
  `whatsapp_status` tinyint(3) unsigned DEFAULT NULL,
  `whatsapp_number` varchar(20) DEFAULT NULL,
  `whatsapp_header_title` varchar(255) DEFAULT NULL,
  `whatsapp_popup_status` tinyint(3) unsigned DEFAULT NULL,
  `whatsapp_popup_message` text DEFAULT NULL,
  `maintenance_img` varchar(255) DEFAULT NULL,
  `maintenance_status` tinyint(4) DEFAULT NULL,
  `maintenance_msg` text DEFAULT NULL,
  `bypass_token` varchar(255) DEFAULT NULL,
  `footer_logo` varchar(255) DEFAULT NULL,
  `footer_background_image` varchar(255) DEFAULT NULL,
  `admin_theme_version` varchar(10) NOT NULL DEFAULT 'light',
  `notification_image` varchar(255) DEFAULT NULL,
  `counter_section_image` varchar(255) DEFAULT NULL,
  `call_to_action_section_image` varchar(255) DEFAULT NULL,
  `call_to_action_section_highlight_image` varchar(255) DEFAULT NULL,
  `video_section_image` varchar(255) DEFAULT NULL,
  `testimonial_section_image` varchar(255) DEFAULT NULL,
  `category_section_background` varchar(255) DEFAULT NULL,
  `google_adsense_publisher_id` varchar(255) DEFAULT NULL,
  `equipment_tax_amount` decimal(5,2) unsigned DEFAULT NULL,
  `product_tax_amount` decimal(5,2) unsigned DEFAULT NULL,
  `self_pickup_status` tinyint(3) unsigned DEFAULT NULL,
  `two_way_delivery_status` tinyint(3) unsigned DEFAULT NULL,
  `guest_checkout_status` tinyint(3) unsigned NOT NULL,
  `shop_status` int(11) DEFAULT 1,
  `admin_approve_status` int(11) NOT NULL DEFAULT 0,
  `listing_view` int(11) DEFAULT NULL,
  `facebook_login_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '1 -> enable, 0 -> disable',
  `facebook_app_id` varchar(255) DEFAULT NULL,
  `facebook_app_secret` varchar(255) DEFAULT NULL,
  `google_login_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '1 -> enable, 0 -> disable',
  `google_client_id` varchar(255) DEFAULT NULL,
  `google_client_secret` varchar(255) DEFAULT NULL,
  `tawkto_status` tinyint(3) unsigned NOT NULL COMMENT '1 -> enable, 0 -> disable',
  `hero_section_background_img` varchar(255) DEFAULT NULL,
  `tawkto_direct_chat_link` varchar(255) NOT NULL,
  `vendor_admin_approval` int(11) NOT NULL DEFAULT 0 COMMENT '1 active, 2 deactive',
  `vendor_email_verification` int(11) NOT NULL DEFAULT 0 COMMENT '1 active, 2 deactive',
  `admin_approval_notice` text DEFAULT NULL,
  `expiration_reminder` int(11) DEFAULT 3,
  `timezone` varchar(255) DEFAULT NULL,
  `hero_section_video_url` text DEFAULT NULL,
  `contact_title` varchar(255) DEFAULT NULL,
  `contact_subtile` varchar(255) DEFAULT NULL,
  `contact_details` longtext DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `preloader_status` int(11) DEFAULT 1,
  `preloader` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_format` int(11) DEFAULT 12,
  `google_map_api_key_status` int(11) DEFAULT 0,
  `google_map_api_key` varchar(255) DEFAULT NULL,
  `radius` int(11) DEFAULT 0,
  `commission_amount` decimal(8,2) DEFAULT NULL,
  `app_logo` varchar(255) DEFAULT NULL,
  `app_fav` varchar(255) DEFAULT NULL,
  `app_url` varchar(255) DEFAULT NULL,
  `app_primary_color` varchar(255) DEFAULT NULL,
  `app_breadcrumb_color` varchar(255) DEFAULT NULL,
  `app_breadcrumb_overlay_opacity` decimal(8,2) NOT NULL DEFAULT 0.00,
  `app_google_map_status` tinyint(4) NOT NULL DEFAULT 0,
  `app_firebase_json_file` varchar(255) DEFAULT NULL,
  `openai_api_key` varchar(255) DEFAULT NULL,
  `openai_text_model` varchar(255) DEFAULT NULL,
  `openai_image_model` varchar(255) DEFAULT NULL,
  `gemini_api_key` varchar(255) DEFAULT NULL,
  `gemini_text_model` varchar(255) DEFAULT NULL,
  `gemini_image_model` varchar(255) DEFAULT NULL,
  `pollinations_secret_key` varchar(255) DEFAULT NULL,
  `pollinations_text_model` varchar(255) DEFAULT NULL,
  `pollinations_image_model` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basic_settings`
--

LOCK TABLES `basic_settings` WRITE;
/*!40000 ALTER TABLE `basic_settings` DISABLE KEYS */;
INSERT INTO `basic_settings` VALUES
(2,12345,'66321327155b0.png','65b9bb8f98dd7.png','64ed7071b1844.png','Bulistio',364,'bulistio@example.com','+701 - 1111 - 2222 - 333','450 Young Road, New York, USA',2,'$','left','USD','right',1.00,'F9725F',1,'smtp.gmail.com',587,'TLS','xxxxxx','xxxxxxxxxxxxxx','xxx@example.com','Bulistio','demo@example.com','65c200e4ea394.png',0,'test',0,'1','1',0,'+880111111111','Hi,there!',0,'If you have any issues, let us know.','1632725312.png',0,'We are upgrading our site. We will come back soon. \r\nPlease stay with us.\r\nThank you.','azim','690978719ca9e.png','638db9bf3f92a.jpg','light','619b7d5e5e9df.png','6530b4b2c6984.jpg','663c8354ee10d.jpg','663c8354ef694.jpg','663efd5b5134b.jpg','657a7500bb6c1.jpg','63c92601cb853.jpg','dvf',5.00,5.00,1,1,0,1,1,1,0,'1','1',1,'dsds','dsdsdsd',1,'664af3245b2b4.png','xxxxx',1,1,'Your account is deactive or pending now. Please Contact with admin!',3,'Asia/Dhaka','https://www.youtube.com/watch?v=9l6RywtDlKA','Get Connected','How Can We Help You?','Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\r\n\r\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.','23.8587','90.4001',1,'65e7f2608a3c1.gif','2023-08-24 00:02:42',12,1,'google-api-key',500,10.00,'693504171db56.png','69350407b717e.png',NULL,'FF8000','AC68FF',0.00,0,'69185257de210.json','sdsdsddsdsd','gpt-4o','dall-e-3','hh','gemini-2.5-flash','imagen-4.0-generat-001','dsdsds','gemini-fast','flux');
/*!40000 ALTER TABLE `basic_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_categories`
--

DROP TABLE IF EXISTS `blog_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `serial_number` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_categories_language_id_foreign` (`language_id`),
  CONSTRAINT `blog_categories_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_categories`
--

LOCK TABLES `blog_categories` WRITE;
/*!40000 ALTER TABLE `blog_categories` DISABLE KEYS */;
INSERT INTO `blog_categories` VALUES
(50,20,'Business Optimization','business-optimization',1,1,'2024-05-07 22:52:58','2024-05-07 22:52:58'),
(51,21,'تحسين الأعمال','تحسين-الأعمال',1,1,'2024-05-07 22:53:22','2024-05-07 22:53:22'),
(52,20,'Local Business Tips','local-business-tips',1,2,'2024-05-07 22:58:14','2024-05-07 22:58:14'),
(53,21,'نصائح الأعمال المحلية','نصائح-الأعمال-المحلية',1,2,'2024-05-07 22:58:39','2024-05-07 23:27:08'),
(54,20,'Small Business Growth','small-business-growth',1,3,'2024-05-07 23:05:10','2024-05-07 23:05:10'),
(55,21,'نمو الأعمال الصغيرة','نمو-الأعمال-الصغيرة',1,3,'2024-05-07 23:05:30','2024-05-07 23:27:02'),
(56,20,'Online Presence','online-presence',1,4,'2024-05-07 23:18:57','2024-05-07 23:18:57'),
(57,21,'التواجد على الشبكة','التواجد-على-الشبكة',1,4,'2024-05-07 23:19:20','2024-05-07 23:19:20');
/*!40000 ALTER TABLE `blog_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_informations`
--

DROP TABLE IF EXISTS `blog_informations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_informations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `blog_category_id` bigint(20) unsigned NOT NULL,
  `blog_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `content` blob NOT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_informations_language_id_foreign` (`language_id`),
  KEY `blog_informations_blog_category_id_foreign` (`blog_category_id`),
  KEY `blog_informations_blog_id_foreign` (`blog_id`),
  CONSTRAINT `blog_informations_blog_category_id_foreign` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_informations_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_informations_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_informations`
--

LOCK TABLES `blog_informations` WRITE;
/*!40000 ALTER TABLE `blog_informations` DISABLE KEYS */;
INSERT INTO `blog_informations` VALUES
(3,20,50,32,'10 Essential Tips for Optimizing Your Business Listing on Bulistio','10-essential-tips-for-optimizing-your-business-listing-on-bulistio','Admin','<p>In today\'s digital age, having a strong online presence is crucial for the success of any business. One of the most effective ways to enhance your visibility and attract potential customers is by optimizing your business listing on [Your Website Name]. Whether you\'re a local service provider, a retailer, or an online entrepreneur, optimizing your business listing can significantly boost your online visibility and drive more traffic to your website. Here are ten essential tips to help you make the most out of your business listing:</p>\r\n<ol>\r\n<li>\r\n<p><strong>Complete Your Profile</strong>: The first step to optimizing your business listing is to ensure that all the necessary information about your business is complete and up-to-date. This includes your business name, address, phone number, website URL, hours of operation, and a brief description of your products or services.</p>\r\n</li>\r\n<li>\r\n<p><strong>Choose the Right Categories</strong>: Selecting the most relevant categories for your business will help potential customers find you more easily when they search for related products or services. Be as specific as possible to ensure that your business appears in the right search results.</p>\r\n</li>\r\n<li>\r\n<p><strong>Optimize Your Business Description</strong>: Use your business description to highlight what makes your business unique and why customers should choose you over your competitors. Incorporate relevant keywords to improve your search engine visibility.</p>\r\n</li>\r\n<li>\r\n<p><strong>Add High-Quality Photos and Videos</strong>: Visual content plays a crucial role in attracting and engaging potential customers. Upload high-quality photos and videos that showcase your products, services, and premises to give customers a better idea of what to expect.</p>\r\n</li>\r\n<li>\r\n<p><strong>Encourage Customer Reviews</strong>: Positive reviews can significantly impact your business\'s reputation and credibility. Encourage your satisfied customers to leave reviews on your business listing, and always respond promptly and professionally to any feedback, whether positive or negative.</p>\r\n</li>\r\n<li>\r\n<p><strong>Include Contact Information</strong>: Make it easy for customers to get in touch with you by providing multiple contact options, such as phone numbers, email addresses, and social media profiles. This helps build trust and accessibility.</p>\r\n</li>\r\n<li>\r\n<p><strong>Update Your Business Hours</strong>: Keep your business hours updated to reflect any changes, especially during holidays or special occasions. This prevents potential customers from showing up when you\'re closed and helps manage expectations.</p>\r\n</li>\r\n<li>\r\n<p><strong>Utilize Keywords Strategically</strong>: Incorporate relevant keywords throughout your business listing to improve your search engine rankings. Focus on long-tail keywords that are specific to your niche and target audience.</p>\r\n</li>\r\n<li>\r\n<p><strong>Link to Your Website and Social Media Profiles</strong>: Include links to your website and social media profiles in your business listing to drive traffic and encourage engagement. This provides customers with additional avenues to learn more about your business and stay connected.</p>\r\n</li>\r\n<li>\r\n<p><strong>Monitor and Analyze Your Performance</strong>: Regularly monitor the performance of your business listing to track views, clicks, and customer interactions. Use analytics tools to gain insights into what\'s working well and where there\'s room for improvement.</p>\r\n</li>\r\n</ol>\r\n<p>By following these ten essential tips, you can optimize your business listing on [Your Website Name] to maximize your online visibility, attract more customers, and ultimately grow your business. Stay proactive and continue to refine your listing based on customer feedback and changing market trends to ensure long-term success.</p>\r\n<p>Remember, your business listing is often the first impression potential customers have of your business, so make it count!</p>',NULL,NULL,'2024-05-07 22:55:16','2024-05-07 22:55:16'),
(4,21,51,32,'10 نصائح أساسية لتحسين قائمة أعمالك على بوليستيو','10-نصائح-أساسية-لتحسين-قائمة-أعمالك-على-بوليستيو','مسؤل','<p>في العصر الرقمي الذي نعيشه اليوم، يعد التواجد القوي عبر الإنترنت أمرًا بالغ الأهمية لنجاح أي عمل تجاري. إحدى الطرق الأكثر فعالية لتعزيز ظهورك وجذب العملاء المحتملين هي تحسين قائمة أعمالك على [اسم موقع الويب الخاص بك]. سواء كنت مزود خدمة محليًا، أو بائع تجزئة، أو رائد أعمال عبر الإنترنت، فإن تحسين قائمة أعمالك يمكن أن يعزز بشكل كبير ظهورك عبر الإنترنت ويجذب المزيد من الزيارات إلى موقع الويب الخاص بك. فيما يلي عشر نصائح أساسية لمساعدتك في تحقيق أقصى استفادة من قائمة أعمالك:</p>\r\n<ol>\r\n<li>\r\n<p>أكمل ملفك الشخصي: : الخطوة الأولى لتحسين قائمة أعمالك هي التأكد من أن جميع المعلومات الضرورية عن عملك كاملة وحديثة. يتضمن ذلك اسم عملك وعنوانك ورقم هاتفك وعنوان URL لموقع الويب وساعات العمل ووصفًا موجزًا ​​لمنتجاتك أو خدماتك.</p>\r\n</li>\r\n<li>\r\n<p>اختر الفئات المناسبة: إن تحديد الفئات الأكثر صلة بنشاطك التجاري سيساعد العملاء المحتملين في العثور عليك بسهولة أكبر عندما يبحثون عن المنتجات أو الخدمات ذات الصلة. كن محددًا قدر الإمكان لضمان ظهور نشاطك التجاري في نتائج البحث الصحيحة.</p>\r\n<p>تحسين وصف عملك: استخدم وصف عملك لتسليط الضوء على ما يجعل عملك فريدًا ولماذا يجب على العملاء اختيارك على منافسيك. قم بدمج الكلمات الرئيسية ذات الصلة لتحسين ظهور محرك البحث الخاص بك.</p>\r\n<p>إضافة صور ومقاطع فيديو عالية الجودة: يلعب المحتوى المرئي دورًا حاسمًا في جذب العملاء المحتملين وإشراكهم. قم بتحميل صور ومقاطع فيديو عالية الجودة تعرض منتجاتك وخدماتك ومبانيك لمنح العملاء فكرة أفضل عما يمكن توقعه.</p>\r\n<p>تشجيع تقييمات العملاء: يمكن أن تؤثر التقييمات الإيجابية بشكل كبير على سمعة عملك ومصداقيته. شجع عملائك الراضين على ترك تعليقاتهم على قائمة أعمالك، والرد دائمًا بسرعة ومهنية على أي تعليقات، سواء كانت إيجابية أو سلبية.</p>\r\n<p>تضمين معلومات الاتصال: اجعل من السهل على العملاء التواصل معك من خلال توفير خيارات اتصال متعددة، مثل أرقام الهواتف وعناوين البريد الإلكتروني وملفات تعريف الوسائط الاجتماعية. وهذا يساعد على بناء الثقة وإمكانية الوصول.</p>\r\n<p>قم بتحديث ساعات عملك: حافظ على تحديث ساعات عملك لتعكس أي تغييرات، خاصة أثناء العطلات أو المناسبات الخاصة. وهذا يمنع العملاء المحتملين من الظهور عندما تكون مغلقًا ويساعد في إدارة التوقعات.</p>\r\n<p>استخدم الكلمات الرئيسية بشكل استراتيجي: قم بدمج الكلمات الرئيسية ذات الصلة في قائمة أعمالك لتحسين تصنيفات محرك البحث الخاص بك. ركز على الكلمات الرئيسية الطويلة المخصصة لقطاعك والجمهور المستهدف.</p>\r\n<p>رابط إلى موقع الويب الخاص بك وملفات تعريف الوسائط الاجتماعية: قم بتضمين روابط إلى موقع الويب الخاص بك وملفات تعريف الوسائط الاجتماعية في قائمة أعمالك لزيادة حركة المرور وتشجيع المشاركة. وهذا يوفر للعملاء سبلًا إضافية لمعرفة المزيد عن عملك والبقاء على اتصال.</p>\r\n<p>مراقبة وتحليل أدائك: راقب أداء قائمة أعمالك بانتظام لتتبع مرات المشاهدة والنقرات وتفاعلات العملاء. استخدم أدوات التحليلات للحصول على رؤى حول ما يعمل بشكل جيد وأين يوجد مجال للتحسين.</p>\r\n<p>باتباع هذه النصائح العشر الأساسية، يمكنك تحسين قائمة أعمالك على [اسم موقع الويب الخاص بك] لزيادة ظهورك على الإنترنت، وجذب المزيد من العملاء، وتنمية أعمالك في نهاية المطاف. كن استباقيًا واستمر في تحسين قائمتك بناءً على تعليقات العملاء واتجاهات السوق المتغيرة لضمان النجاح على المدى الطويل.</p>\r\n<p>تذكر أن قائمة نشاطك التجاري غالبًا ما تكون أول انطباع لدى العملاء المحتملين عن نشاطك التجاري، لذا اجعله مهمًا!</p>\r\n</li>\r\n</ol>',NULL,NULL,'2024-05-07 22:55:16','2024-05-07 22:57:08'),
(5,20,52,33,'Unlocking Success: Top 7 Local Business Tips for Thriving in Your Community','unlocking-success:-top-7-local-business-tips-for-thriving-in-your-community','Admin','<p>Local businesses are the lifeblood of communities, offering unique products, personalized services, and a sense of belonging that big-box stores simply can\'t match. However, succeeding as a local business owner requires more than just passion and dedication—it also requires strategic planning and savvy decision-making. Whether you\'re a seasoned entrepreneur or just starting out, these seven local business tips will help you thrive in your community:</p>\r\n<ol>\r\n<li>\r\n<p><strong>Embrace Your Local Identity</strong>: One of the key advantages of being a local business is your connection to the community. Embrace your local identity by participating in community events, supporting local charities, and forming partnerships with other businesses in your area. This not only strengthens your brand but also fosters loyalty among local customers.</p>\r\n</li>\r\n<li>\r\n<p><strong>Optimize Your Online Presence</strong>: In today\'s digital age, having a strong online presence is essential for attracting new customers and staying competitive. Make sure your business is listed accurately on local directories, review sites, and social media platforms. Regularly update your website with fresh content and engage with your audience through social media to keep them informed and engaged.</p>\r\n</li>\r\n<li>\r\n<p><strong>Provide Excellent Customer Service</strong>: Exceptional customer service is the cornerstone of any successful business, especially in a local setting where word-of-mouth referrals can make or break your reputation. Train your staff to prioritize customer satisfaction, resolve issues promptly, and go above and beyond to exceed customer expectations. Happy customers are more likely to become repeat customers and recommend your business to others.</p>\r\n</li>\r\n<li>\r\n<p><strong>Focus on Local SEO</strong>: Local search engine optimization (SEO) is critical for ensuring that your business appears in local search results when potential customers are looking for products or services like yours. Optimize your website and online listings with relevant keywords, local identifiers (such as your city or neighborhood), and accurate contact information. Encourage satisfied customers to leave positive reviews, as they can boost your local search rankings.</p>\r\n</li>\r\n<li>\r\n<p><strong>Offer Personalized Experiences</strong>: One of the advantages of being a local business is your ability to offer personalized experiences that larger corporations can\'t match. Get to know your customers on a first-name basis, anticipate their needs, and tailor your products or services to meet their preferences. Building strong relationships with your customers not only fosters loyalty but also sets you apart from the competition.</p>\r\n</li>\r\n<li>\r\n<p><strong>Stay Flexible and Adapt to Change</strong>: The business landscape is constantly evolving, and successful local businesses are those that can adapt to change quickly and effectively. Stay abreast of industry trends, monitor your competitors, and be willing to experiment with new ideas and strategies. Whether it\'s embracing new technology, adjusting your pricing strategy, or expanding your product offerings, staying flexible is key to long-term success.</p>\r\n</li>\r\n<li>\r\n<p><strong>Measure and Analyze Your Performance</strong>: To ensure that your business is on the right track, it\'s important to regularly measure and analyze your performance. Track key metrics such as sales, customer satisfaction, website traffic, and social media engagement to identify areas for improvement and make data-driven decisions. Use this information to refine your strategies, allocate resources more effectively, and drive continued growth.</p>\r\n</li>\r\n</ol>\r\n<p>By following these seven local business tips, you can position your business for success and become a valued member of your community. Remember, success doesn\'t happen overnight, but with dedication, perseverance, and a commitment to excellence, you can build a thriving local business that stands the test of time.</p>',NULL,NULL,'2024-05-07 23:03:31','2024-05-07 23:03:31'),
(6,21,53,33,'استراتيجيات لتعزيز الإقبال المحلي: ٧ نصائح لنجاح الأعمال المحلية','استراتيجيات-لتعزيز-الإقبال-المحلي:-٧-نصائح-لنجاح-الأعمال-المحلية','مسؤل','<p>Title: \"استراتيجيات لتعزيز الإقبال المحلي: ٧ نصائح لنجاح الأعمال المحلية\"</p>\r\n<p>الأعمال المحلية هي عماد المجتمعات، حيث تقدم منتجات فريدة، وخدمات شخصية، وشعورًا بالانتماء الذي لا يمكن للمتاجر الكبيرة المضادة. ومع ذلك، يتطلب النجاح كصاحب عمل محلي المزيد من الشغف والتفاني، بل ويتطلب أيضًا تخطيطًا استراتيجيًا واتخاذ قرارات ذكية. سواء كنت رائد أعمال متمرسًا أو مبتدئًا فإليك سبع نصائح لتعزيز نجاحك في مجتمعك:</p>\r\n<p>١. **اعتنق هويتك المحلية**: إحدى المزايا الرئيسية لكونك عمل محلي هو ارتباطك بالمجتمع. اعتنق هويتك المحلية من خلال المشاركة في الفعاليات المجتمعية، ودعم الجمعيات الخيرية المحلية، وتشكيل شراكات مع الأعمال الأخرى في منطقتك. هذا ليس فقط يعزز علامتك التجارية ولكنه يعزز أيضًا الولاء بين العملاء المحليين.</p>\r\n<p>٢. **قم بتحسين وجودك على الإنترنت**: في عصر اليوم الرقمي، يعتبر وجود قوي على الإنترنت أمرًا ضروريًا لجذب عملاء جدد والبقاء تنافسيًا. تأكد من أن عملك مدرج بدقة على الدلائل المحلية ومواقع المراجعات ومنصات التواصل الاجتماعي. قم بتحديث موقع الويب الخاص بك بشكل منتظم بمحتوى جديد وتفاعل مع جمهورك من خلال وسائل التواصل الاجتماعي لإبقائهم على اطلاع ومشاركتهم.</p>\r\n<p>٣. **قدم خدمة عملاء ممتازة**: الخدمة العملاء الاستثنائية هي ركن أي عمل ناجح، خاصة في إعداد محلي حيث يمكن أن تكون الإحالات عن طريق الكلمة الفموية مصدرًا كبيرًا للسمعة الجيدة أو السيئة. قم بتدريب موظفيك على إعطاء الأولوية لرضا العملاء، وحل المشكلات بسرعة، والذهاب إلى الأبعد لتجاوز توقعات العملاء. العملاء السعداء هم الأكثر احتمالاً لأن يصبحوا عملاء متكررين ويوصوا بعملك للآخرين.</p>\r\n<p>٤. **ركز على تحسين محركات البحث المحلية**: تحسين محركات البحث المحلية (SEO) أمر حيوي لضمان ظهور عملك في نتائج البحث المحلي عندما يبحث المستخدمون عن منتجات أو خدمات مثل تلك التي تقدمها. قم بتحسين موقع الويب الخاص بك والقوائم الخاصة بك على الإنترنت بكلمات مفتاحية ذات صلة ومعرفات محلية (مثل مدينتك أو حيك) ومعلومات اتصال دقيقة. شجع العملاء المرتاحين على ترك تقييمات إيجابية، حيث يمكن أن تعزز تقييماتهم مرتبات البحث المحلية الخاصة بك.</p>\r\n<p>٥. **قدم تجارب شخصية**: إحدى المزايا لكونك عمل محلي هو قدرتك على تقديم تجارب شخصية لا يمكن للشركات الكبرى المضادة منافستك. تعرف على عملائك باسمائهم، وتوقعات احتياجاتهم، وعد منتجاتك أو خدماتك لتلبية تفضيلاتهم. بناء علاقات قوية مع عملائك لا يزيد فقط من الولاء ولكنه أيضًا يفصلك عن المنافس</p>',NULL,NULL,'2024-05-07 23:03:31','2024-05-07 23:03:31'),
(7,20,54,34,'Nurturing Growth: Strategies for Small Business Success','nurturing-growth:-strategies-for-small-business-success','Admin','<p>In the vast and ever-evolving landscape of commerce, small businesses represent the heartbeat of entrepreneurship. They are the engines that drive innovation, creativity, and economic vitality in communities worldwide. However, navigating the path to sustainable growth in a competitive market can be a daunting challenge. Yet, with the right strategies and mindset, small businesses can thrive and expand their footprint. In this blog, we\'ll explore some key strategies for fostering the growth of small businesses.</p>\r\n<ol>\r\n<li>\r\n<p><strong>Define Your Unique Value Proposition</strong>: At the core of every successful business lies a clear and compelling value proposition. Define what sets your business apart from the competition. What unique products, services, or experiences do you offer to your customers? Understanding and effectively communicating your value proposition will not only attract new customers but also foster loyalty and repeat business.</p>\r\n</li>\r\n<li>\r\n<p><strong>Focus on Customer Experience</strong>: In today\'s hyper-connected world, delivering exceptional customer experiences is paramount. Every interaction a customer has with your business, whether online or offline, shapes their perception and influences their decision to return. Invest in building strong relationships with your customers by providing personalized service, addressing their needs promptly, and soliciting feedback to continually improve.</p>\r\n</li>\r\n<li>\r\n<p><strong>Embrace Innovation</strong>: Innovation is the lifeblood of growth. Stay abreast of industry trends, emerging technologies, and evolving consumer preferences. Be willing to adapt and embrace change to remain relevant in a dynamic market. Encourage a culture of creativity and experimentation within your organization, empowering your team to explore new ideas and solutions.</p>\r\n</li>\r\n<li>\r\n<p><strong>Harness the Power of Digital Marketing</strong>: In today\'s digital age, an effective online presence is essential for small businesses to reach and engage their target audience. Leverage digital marketing channels such as social media, email marketing, and search engine optimization (SEO) to expand your reach, drive traffic to your website, and generate leads. Invest in robust analytics tools to measure the performance of your digital marketing efforts and optimize your strategies accordingly.</p>\r\n</li>\r\n<li>\r\n<p><strong>Build Strategic Partnerships</strong>: Collaboration can be a powerful catalyst for growth. Identify potential partners, suppliers, or complementary businesses that share your values and target market. By forging strategic partnerships, you can tap into new markets, access resources and expertise, and create mutually beneficial opportunities for growth.</p>\r\n</li>\r\n<li>\r\n<p><strong>Invest in Your Team</strong>: Your employees are your most valuable asset. Invest in their training, development, and well-being to foster a culture of excellence and drive organizational growth. Provide opportunities for learning and career advancement, cultivate a supportive work environment, and recognize and reward their contributions.</p>\r\n</li>\r\n<li>\r\n<p><strong>Diversify Revenue Streams</strong>: Relying too heavily on a single product, service, or customer segment can leave your business vulnerable to fluctuations in the market. Diversify your revenue streams by expanding your product or service offerings, targeting new customer segments, or exploring additional sales channels. This not only reduces risk but also creates opportunities for revenue growth.</p>\r\n</li>\r\n<li>\r\n<p><strong>Stay Financially Savvy</strong>: Sound financial management is critical for the long-term success of any business. Keep a close eye on your finances, monitor cash flow, and maintain accurate records. Develop and regularly review your business budget and financial projections to ensure you\'re on track to meet your growth objectives. Consider seeking advice from financial professionals or mentors to help you make informed decisions.</p>\r\n</li>\r\n<li>\r\n<p><strong>Cultivate a Strong Brand Identity</strong>: Your brand is more than just a logo or a tagline—it\'s the essence of your business and what it stands for. Invest in building a strong brand identity that resonates with your target audience and sets you apart from competitors. Consistently communicate your brand values, voice, and personality across all touchpoints to create a cohesive and memorable brand experience.</p>\r\n</li>\r\n<li>\r\n<p><strong>Stay Agile and Adaptive</strong>: Finally, in a rapidly changing business environment, agility and adaptability are key to staying ahead of the curve. Be prepared to pivot your strategies, seize new opportunities, and navigate challenges with resilience and determination. Embrace a growth mindset that views obstacles as opportunities for learning and innovation.</p>\r\n</li>\r\n</ol>\r\n<p>In conclusion, while the journey to small business growth may be fraught with challenges, it\'s also filled with endless possibilities. By embracing these strategies and committing to continuous improvement, small businesses can unlock their full potential, expand their reach, and achieve sustainable growth in the long run.</p>',NULL,NULL,'2024-05-07 23:07:53','2024-05-07 23:07:53'),
(8,21,55,34,'عنوان: بناء النمو: استراتيجيات نجاح الأعمال الصغيرة','عنوان:-بناء-النمو:-استراتيجيات-نجاح-الأعمال-الصغيرة','مسؤل','<div class=\"flex-1 overflow-hidden\">\r\n<div class=\"react-scroll-to-bottom--css-kedrj-79elbk h-full\">\r\n<div class=\"react-scroll-to-bottom--css-kedrj-1n7m0yu\">\r\n<div>\r\n<div class=\"flex flex-col text-sm\">\r\n<div class=\"w-full text-token-text-primary\">\r\n<div class=\"py-2 px-3 text-base md:px-4 m-auto md:px-5 lg:px-1 xl:px-5\">\r\n<div class=\"mx-auto flex flex-1 gap-3 text-base juice:gap-4 juice:md:gap-6 md:max-w-3xl lg:max-w-[40rem] xl:max-w-[48rem]\">\r\n<div class=\"relative flex w-full min-w-0 flex-col agent-turn\">\r\n<div class=\"flex-col gap-1 md:gap-3\">\r\n<div class=\"flex flex-grow flex-col max-w-full\">\r\n<div class=\"min-h-[20px] text-message flex flex-col items-start whitespace-pre-wrap break-words [.text-message+&amp;]:mt-5 overflow-x-auto gap-3\">\r\n<div class=\"markdown prose w-full break-words dark:prose-invert light\">\r\n<p>في الساحة الشاسعة والمتطورة دائمًا للتجارة، تمثل الأعمال الصغيرة نبض ريادة الأعمال. إنها المحركات التي تدفع الابتكار والإبداع والحيوية الاقتصادية في المجتمعات في جميع أنحاء العالم. ومع ذلك، يمكن أن يكون التنقل في طريق النمو المستدام في سوق تنافسي تحديًا مرعبًا. ومع ذلك، مع الاستراتيجيات والعقلية الصحيحة، يمكن للشركات الصغيرة أن تزدهر وتوسع منطقتها. في هذا المدونة، سوف نستكشف بعض الاستراتيجيات الرئيسية لتعزيز نمو الشركات الصغيرة.</p>\r\n<ol>\r\n<li>\r\n<p><strong>تحديد عرضك الفريد من نوعه</strong>: في جوهر كل عمل ناجح يكمن عرض قيمة واضح وجذاب. حدد ما يميز شركتك عن المنافسة. ما هي المنتجات أو الخدمات أو التجارب الفريدة التي تقدمها لعملائك؟ فهم القيمة المضافة والتواصل بشكل فعال بعرضك الفريد لن يجذب فقط عملاء جدد ولكن سيعزز أيضًا الولاء والعمل المتكرر.</p>\r\n</li>\r\n<li>\r\n<p><strong>التركيز على تجربة العميل</strong>: في عالم اليوم المتصل بشكل فائق، تقديم تجارب عملاء استثنائية أمر بالغ الأهمية. كل تفاعل للعميل مع عملك، سواء عبر الإنترنت أو خارجه، يشكل إدراكهم ويؤثر في قرارهم بالعودة. قم بالاستثمار في بناء علاقات قوية مع عملائك من خلال تقديم خدمة شخصية، والتعامل مع احتياجاتهم بسرعة، والتماس ملاحظاتهم لتحسينها باستمرار.</p>\r\n</li>\r\n<li>\r\n<p><strong>اعتناق الابتكار</strong>: الابتكار هو دم النمو. كن على اطلاع بالاتجاهات الصناعية، والتقنيات الناشئة، وتفضيلات المستهلكين المتطورة. كن مستعدًا للتكيف وقبول التغيير لتظل ذات صلة في سوق ديناميكي. شجع على ثقافة الإبداع والتجريب داخل منظمتك، مما يمكّن فريقك من استكشاف أفكار وحلول جديدة.</p>\r\n</li>\r\n<li>\r\n<p><strong>استغلال قوة التسويق الرقمي</strong>: في عصرنا الرقمي اليوم، تمثل الوجود الإلكتروني الفعال أمرًا ضروريًا للشركات الصغيرة للوصول إلى جمهورها المستهدف وجذبهم. استفد من قنوات التسويق الرقمي مثل وسائل التواصل الاجتماعي، والتسويق عبر البريد الإلكتروني، وتحسين محركات البحث لتوسيع نطاقك، وزيادة حركة المرور إلى موقعك الإلكتروني، وتوليد العملاء المحتملين.</p>\r\n</li>\r\n<li>\r\n<p><strong>بناء شراكات استراتيجية</strong>: التعاون يمكن أن يكون عاملاً قويًا للنمو. حدد الشركاء المحتملين، أو الموردين، أو الشركات المكملة التي تشترك في قيمك وسوقك المستهدف. من خلال تكوين شراكات استراتيجية، يمكنك الولوج إلى أسواق جديدة، والوصول إلى الموارد والخبرات، وخلق فرص متبادلة للنمو.</p>\r\n</li>\r\n<li>\r\n<p><strong>استثمار في فريقك</strong>: موظفوك هم أكثر أصولك قيمة. قم بالاستثمار في تدريبهم وتطويرهم ورفاهيتهم لبناء ثقافة التميز ودفع النمو التنظيمي. قدم فرص التعلم والتقدم المهني، وعزز البيئة العملية الداعم</p>\r\n</li>\r\n</ol>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"mt-1 flex gap-3 empty:hidden\">\r\n<div class=\"text-gray-400 flex self-end lg:self-center items-center justify-center lg:justify-start mt-0 -ml-1 h-7 gap-[2px] visible\">\r\n<div class=\"flex items-center gap-1.5 text-xs\"> </div>\r\n<div class=\"flex\"> </div>\r\n</div>\r\n</div>\r\n<div class=\"pr-2 lg:pr-0\"> </div>\r\n</div>\r\n<div class=\"absolute\">\r\n<div class=\"flex w-full gap-2 items-center justify-center\"> </div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"w-full md:pt-0 dark:border-white/20 md:border-transparent md:dark:border-transparent md:w-[calc(100%-.5rem)] juice:w-full\">\r\n<div class=\"px-3 text-base md:px-4 m-auto md:px-5 lg:px-1 xl:px-5\">\r\n<div class=\"mx-auto flex flex-1 gap-3 text-base juice:gap-4 juice:md:gap-6 md:max-w-3xl lg:max-w-[40rem] xl:max-w-[48rem]\">\r\n<div class=\"relative flex h-full max-w-full flex-1 flex-col\">\r\n<div class=\"absolute bottom-full left-0 right-0\">\r\n<div class=\"relative h-full w-full\">\r\n<div class=\"flex flex-col gap-3.5 pb-3.5 pt-2\">\r\n<div class=\"flex h-full w-full items-center justify-end gap-0 py-4 md:gap-2\">\r\n<div> </div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>',NULL,NULL,'2024-05-07 23:07:53','2024-05-07 23:07:53'),
(9,20,50,35,'Unleashing the Power of Business Optimization: Elevate Your Success','unleashing-the-power-of-business-optimization:-elevate-your-success','Admin','<p>In today\'s rapidly evolving business landscape, the quest for optimization has become paramount. Every organization, regardless of size or industry, seeks to streamline operations, maximize efficiency, and drive sustainable growth. Welcome to the realm of Business Optimization – a strategic imperative that can redefine your business\'s trajectory.</p>\r\n<h2>Understanding Business Optimization</h2>\r\n<p>Business Optimization isn\'t merely about cutting costs or increasing productivity; it\'s about orchestrating a harmonious symphony of processes, people, and technology to achieve peak performance. It involves identifying inefficiencies, leveraging data insights, and implementing tailored solutions to enhance overall effectiveness.</p>\r\n<h2>The Pillars of Business Optimization</h2>\r\n<h3>Data-Driven Insights</h3>\r\n<p>Data is the lifeblood of optimization. By harnessing the power of data analytics, businesses can gain invaluable insights into customer behavior, market trends, and operational inefficiencies. From predictive analytics to real-time reporting, data-driven decision-making forms the cornerstone of successful optimization strategies.</p>\r\n<h3>Process Improvement</h3>\r\n<p>Optimization begins at the grassroots level – your business processes. By conducting thorough process audits and reengineering workflows, organizations can eliminate bottlenecks, reduce cycle times, and enhance overall agility. Whether it\'s through Lean Six Sigma methodologies or agile frameworks, continuous process improvement is essential for staying ahead of the curve.</p>\r\n<h3>Technology Integration</h3>\r\n<p>In today\'s digital age, technology serves as a catalyst for optimization. From enterprise resource planning (ERP) systems to robotic process automation (RPA), integrating cutting-edge technologies can revolutionize how businesses operate. Automation, in particular, can streamline repetitive tasks, minimize errors, and free up resources for more strategic endeavors.</p>\r\n<h3>Talent Optimization</h3>\r\n<p>People are the driving force behind every successful business. Talent optimization involves aligning your workforce\'s skills, passions, and aspirations with organizational goals. By fostering a culture of continuous learning, empowerment, and collaboration, businesses can unlock their employees\' full potential and drive innovation from within.</p>\r\n<h2>The Benefits of Business Optimization</h2>\r\n<h3>Enhanced Efficiency</h3>\r\n<p>Optimized processes lead to streamlined operations, reduced waste, and increased productivity. By eliminating redundant tasks and optimizing resource allocation, businesses can accomplish more with fewer resources, ultimately boosting their bottom line.</p>\r\n<h3>Improved Agility</h3>\r\n<p>In today\'s fast-paced business environment, agility is non-negotiable. Optimization enables organizations to adapt swiftly to changing market dynamics, customer demands, and competitive pressures. Whether it\'s scaling operations or pivoting strategies, agility equips businesses with the resilience needed to thrive in uncertain times.</p>\r\n<h3>Greater Customer Satisfaction</h3>\r\n<p>At the heart of every optimization endeavor lies the customer. By optimizing processes, products, and services to meet customer needs and expectations, businesses can foster long-lasting relationships and drive brand loyalty. Satisfied customers not only become repeat buyers but also serve as brand advocates, amplifying your reach and reputation.</p>\r\n<h3>Sustainable Growth</h3>\r\n<p>Business optimization isn\'t just about short-term gains; it\'s about laying the groundwork for sustainable growth. By continuously refining operations, adapting to market changes, and investing in innovation, organizations can position themselves for long-term success in an ever-evolving landscape.</p>\r\n<h2>Embracing the Journey of Optimization</h2>\r\n<p>In conclusion, business optimization isn\'t a destination; it\'s a journey – a journey toward excellence, efficiency, and enduring success. By embracing the pillars of data-driven insights, process improvement, technology integration, and talent optimization, businesses can unlock their full potential and thrive in the face of adversity.</p>',NULL,NULL,'2024-05-07 23:10:14','2024-05-07 23:10:14'),
(10,21,51,35,'إطلاق العنان لقوة تحسين الأعمال: ارفع مستوى نجاحك','إطلاق-العنان-لقوة-تحسين-الأعمال:-ارفع-مستوى-نجاحك','مسؤل','<p>بغض النظر عن حجمها أو قطاعها، إلى تبسيط العمليات، وزيادة الكفاءة، ودفع النمو المستدام. مرحبًا بكم في ميدان تحسين الأعمال - الضرورة الاستراتيجية التي يمكن أن تعيد تعريف مسار عملك.</p>\r\n<h2>فهم تحسين الأعمال</h2>\r\n<p>لا يتعلق تحسين الأعمال فقط بتقليل التكاليف أو زيادة الإنتاجية؛ بل يتعلق بتنظيم سيمفونية متناغمة من العمليات والأشخاص والتكنولوجيا لتحقيق أقصى قدر من الأداء. يتضمن التحسين تحديد الفجوات في الكفاءة واستغلال البيانات لتحقيق تحسينات شاملة.</p>\r\n<h2>أركان تحسين الأعمال</h2>\r\n<h3>التحليل القائم على البيانات</h3>\r\n<p>البيانات هي الدم الحيوي للتحسين. من خلال استغلال قوة تحليل البيانات، يمكن للشركات الحصول على رؤى لا تقدر بثمن حول سلوك العملاء واتجاهات السوق والفجوات التشغيلية. من التحليل التنبؤي إلى التقارير في الوقت الحقيقي، يشكل اتخاذ القرارات استنادًا إلى البيانات الحجر الأساسي لاستراتيجيات التحسين الناجحة.</p>\r\n<h3>تحسين العمليات</h3>\r\n<p>يبدأ التحسين من الأساس - عمليات عملك. من خلال إجراء تدقيقات عمليات شاملة وإعادة هندسة العمليات، يمكن للمؤسسات القضاء على العقبات وتقليل أوقات الدورة وتعزيز الرشاقة العامة. سواء كان ذلك من خلال منهجيات Lean Six Sigma أو الإطارات الرشيقة، فإن التحسين المستمر ضروري للبقاء على رأس السلم.</p>\r\n<h3>دمج التكنولوجيا</h3>\r\n<p>في عصرنا الرقمي، تعد التكنولوجيا حافزًا للتحسين. من نظم تخطيط الموارد المؤسسية (ERP) إلى الأتمتة الروبوتية للعمليات (RPA)، يمكن لتكامل التقنيات الحديثة أن يحدث ثورة في كيفية عمل الشركات. يمكن للأتمتة، بشكل خاص، تبسيط المهام المتكررة، وتقليل الأخطاء، وتحرير الموارد لأغراض أكثر استراتيجية.</p>\r\n<h3>تحسين الكفاءة البشرية</h3>\r\n<p>الأشخاص هم القوة الدافعة وراء كل نجاح عملي. ينطوي تحسين الكفاءة البشرية على توجيه مهارات فريق العمل وشغفهم وطموحاتهم مع أهداف المؤسسة. من خلال تعزيز ثقافة الفعالية المستمرة والتمكين والتعاون، يمكن للشركات استخلاص الكفاءة الكاملة لموظفيها ودفع الابتكار من الداخل.</p>\r\n<h2>فوائد تحسين الأعمال</h2>\r\n<h3>زيادة الكفاءة</h3>\r\n<p>تؤدي العمليات المحسنة إلى تيسير العمليات وتقليل الفاقد وزيادة الإنتاجية. من خلال القضاء على المهام الزائدة وتحسين توزيع الموارد، يمكن للشركات إنجاز المزيد باستخدام موارد أقل، مما يعزز في النهاية خط الأساس.</p>\r\n<h3>زيادة الرشاقة</h3>\r\n<p>في البيئة العملية السريعة الخطى التي نعيشها اليوم، الرشاقة ليست قابلة للتفاوض. يمكن للتحسين أن يمكن المؤسسات من التكيف بسرعة مع التغيرات في ديناميات ال</p>',NULL,NULL,'2024-05-07 23:10:14','2024-05-07 23:10:14'),
(11,20,52,36,'Boost Your Local Business: Essential Tips for Success','boost-your-local-business:-essential-tips-for-success','Admin','<p>In today\'s competitive market, local businesses face numerous challenges in attracting and retaining customers. With the rise of e-commerce and big-box retailers, it\'s more important than ever for local businesses to stand out and thrive in their communities. Whether you\'re a small boutique, a cozy cafe, or a neighborhood hardware store, implementing the right strategies can make all the difference. Here are some essential tips to help your local business succeed:</p>\r\n<ol>\r\n<li>\r\n<p><strong>Embrace Your Community</strong>: One of the greatest advantages of being a local business is your connection to the community. Engage with your neighbors by sponsoring local events, participating in community fundraisers, or hosting workshops and classes. Building strong relationships with your community can create loyal customers who will support your business for years to come.</p>\r\n</li>\r\n<li>\r\n<p><strong>Offer Personalized Experiences</strong>: What sets local businesses apart from larger corporations is their ability to provide personalized experiences. Get to know your customers by name, remember their preferences, and tailor your products or services to meet their needs. Whether it\'s a customized recommendation or a thoughtful gesture, personalized experiences go a long way in fostering customer loyalty.</p>\r\n</li>\r\n<li>\r\n<p><strong>Focus on Customer Service</strong>: Exceptional customer service can turn first-time visitors into loyal patrons. Train your staff to greet customers with a smile, actively listen to their concerns, and go above and beyond to ensure their satisfaction. Respond promptly to inquiries and feedback, whether it\'s in person, over the phone, or through social media channels. By prioritizing customer service, you\'ll create a positive reputation that attracts new customers and keeps existing ones coming back.</p>\r\n</li>\r\n<li>\r\n<p><strong>Utilize Online Platforms</strong>: While maintaining a strong presence in the local community is crucial, don\'t underestimate the power of online platforms. Create a user-friendly website that showcases your products or services, and optimize it for local search engine optimization (SEO) to improve your visibility in local search results. Utilize social media platforms like Facebook, Instagram, and Twitter to connect with customers, share updates and promotions, and showcase your brand\'s personality.</p>\r\n</li>\r\n<li>\r\n<p><strong>Collaborate with Other Businesses</strong>: Partnering with complementary businesses in your area can expand your reach and attract new customers. Consider cross-promotions, joint events, or co-branded products/services to leverage each other\'s customer base. By collaborating with other local businesses, you can tap into new markets and strengthen your position within the community.</p>\r\n</li>\r\n<li>\r\n<p><strong>Stay Flexible and Adapt</strong>: In today\'s fast-paced business environment, it\'s essential to stay flexible and adapt to changing trends and customer preferences. Keep an eye on industry developments, monitor your competitors, and be willing to adjust your strategies accordingly. Whether it\'s introducing new products, updating your menu, or implementing innovative marketing tactics, staying ahead of the curve will help your business thrive in the long run.</p>\r\n</li>\r\n<li>\r\n<p><strong>Solicit and Act on Feedback</strong>: Your customers\' feedback is invaluable in helping you improve your business. Encourage customers to leave reviews, participate in surveys, or provide feedback directly. Take constructive criticism seriously and use it as an opportunity to make necessary improvements. By actively soliciting and acting on feedback, you demonstrate your commitment to providing the best possible experience for your customers.</p>\r\n</li>\r\n</ol>\r\n<p>In conclusion, succeeding as a local business requires a combination of community engagement, personalized service, online presence, collaboration, adaptability, and a relentless focus on customer satisfaction. By implementing these essential tips, you can differentiate your business, attract loyal customers, and thrive in your local market.</p>',NULL,NULL,'2024-05-07 23:13:27','2024-05-07 23:13:27'),
(12,21,53,36,'تعزيز عملك المحلي: نصائح أساسية للنجاح','تعزيز-عملك-المحلي:-نصائح-أساسية-للنجاح','مسؤل','<p>ي السوق التنافسية الحالية، تواجه الشركات المحلية تحديات عديدة في جذب واستبقاء العملاء. مع ارتفاع التجارة الإلكترونية والشركات الكبيرة، من المهم أكثر من أي وقت مضى للشركات المحلية أن تبرز وتزدهر في مجتمعاتها. سواء كنت متجرًا صغيرًا، أو مقهىً مريحًا، أو متجرًا للأدوات في الحي، يمكن أن تحقق تطبيق الاستراتيجيات الصحيحة فارقًا كبيرًا. فيما يلي بعض النصائح الأساسية لمساعدة عملك المحلي على النجاح:</p>\r\n<ol>\r\n<li>\r\n<p><strong>تبنَّ عملك المجتمعي</strong>: أحد أكبر المزايا لتشغيل عمل محلي هو ارتباطك بالمجتمع. تفاعل مع جيرانك من خلال رعاية الفعاليات المحلية، والمشاركة في حملات التمويل، أو تنظيم ورش العمل والدورات. بناء علاقات قوية مع مجتمعك يمكن أن يخلق عملاء مخلصين سيدعمون عملك لسنوات قادمة.</p>\r\n</li>\r\n<li>\r\n<p><strong>قدم تجارب مخصصة</strong>: ما يميز الشركات المحلية عن الشركات الكبيرة هو قدرتها على تقديم تجارب مخصصة. تعرف على عملائك بالاسم، وتذكر تفضيلاتهم، وحدد منتجاتك أو خدماتك لتلبية احتياجاتهم. سواء كانت توصية مخصصة أو لفتة مدروسة، فإن التجارب المخصصة تلعب دورًا كبيرًا في تعزيز ولاء العملاء.</p>\r\n</li>\r\n<li>\r\n<p><strong>ركز على خدمة العملاء</strong>: يمكن لخدمة العملاء الاستثنائية تحويل الزوار لأول مرة إلى زبائن مخلصين. قم بتدريب موظفيك على الترحيب بالعملاء بابتسامة، والاستماع بانتباه لمشاكلهم، والذهاب إلى الأمام لضمان رضاهم. استجب بسرعة للاستفسارات والتعليقات، سواء كان ذلك شخصيًا، عبر الهاتف، أو من خلال وسائل التواصل الاجتماعي. من خلال إعطاء الأولوية لخدمة العملاء، ستخلق سمعة إيجابية تجذب عملاء جددًا وتحتفظ بالقدامى.</p>\r\n</li>\r\n<li>\r\n<p><strong>استخدم النُسخ الإلكترونية</strong>: بينما يحافظ التواجد القوي في المجتمع المحلي على أهمية كبيرة، لا تستهن بقوة النُسخ الإلكترونية. قم بإنشاء موقع ويب سهل الاستخدام يعرض منتجاتك أو خدماتك، وقم بتحسينه لتحسين ظهورك في نتائج البحث المحلية. استخدم منصات التواصل الاجتماعي مثل الفيسبوك وإنستغرام وتويتر للتواصل مع العملاء، ومشاركة التحديثات والعروض وعرض شخصية علامتك.</p>\r\n</li>\r\n<li>\r\n<p><strong>تعاون مع الشركات الأخرى</strong>: التعاون مع الشركات المكملة في منطقتك يمكن أن يوسع نطاقك ويجذب عملاء جددًا. افكر في الترويج المشترك، والفعاليات المشتركة، أو المنتجات/الخدمات المشتركة للاستفادة من قاعدة عملاء بعضكم البعض. من خلال التعاون مع الشركات المحلية الأخرى، يمكنك الوصول إلى أسواق جديدة وتعزيز موقعك ضمن المجتمع.</p>\r\n</li>\r\n<li>\r\n<p><strong>كن مرنًا وتكيف</strong>: في البيئة التجارية السريعة التغير الحالية، من الضروري البقاء مرنًا والتكيف مع التغيرات في الاتجاهات وتفضيلات العملاء. انظر إ</p>\r\n</li>\r\n</ol>',NULL,NULL,'2024-05-07 23:13:27','2024-05-07 23:13:27'),
(13,20,54,37,'From Seedling to Skyline: Nurturing Small Business Growth','from-seedling-to-skyline:-nurturing-small-business-growth','Admin','<p>In the vast landscape of commerce, small businesses stand as beacons of innovation, perseverance, and the embodiment of the entrepreneurial spirit. These enterprises, often born out of a singular vision and fueled by unwavering determination, contribute significantly to the economic tapestry of societies worldwide. Yet, amidst their humble beginnings and modest scales, lies a profound potential for growth, evolution, and impact.</p>\r\n<p>The journey of a small business is akin to nurturing a seedling into a mighty oak tree. It requires meticulous care, strategic planning, and a willingness to adapt to ever-changing environments. What sets successful small businesses apart is not merely their ability to survive but their relentless pursuit of growth in all its facets.</p>\r\n<h3>Cultivating Vision and Passion</h3>\r\n<p>At the heart of every small business is a visionary individual or a group of like-minded individuals driven by passion and purpose. This vision serves as the guiding star, illuminating the path forward through the murky waters of uncertainty. It is this clarity of purpose that fuels the initial spark and ignites the flames of entrepreneurship.</p>\r\n<h3>Planting the Seeds of Innovation</h3>\r\n<p>Innovation lies at the core of sustainable growth. Small businesses must continuously innovate to stay relevant in dynamic markets. Whether it\'s embracing cutting-edge technologies, reimagining traditional practices, or pioneering novel solutions to age-old problems, innovation serves as the catalyst for expansion and differentiation.</p>\r\n<h3>Navigating Challenges with Resilience</h3>\r\n<p>The road to growth is rarely smooth, peppered with obstacles and challenges at every turn. Economic downturns, fierce competition, regulatory hurdles – these are but a few of the formidable adversaries small businesses encounter along their journey. Yet, it is precisely during these tumultuous times that resilience shines brightest. Small businesses must weather the storms with fortitude, learning from setbacks, and emerging stronger and wiser.</p>\r\n<h3>Fostering Relationships and Community</h3>\r\n<p>No business exists in isolation. Cultivating strong relationships with customers, suppliers, and the community at large is paramount for sustained growth. These connections not only foster loyalty and trust but also serve as a source of invaluable feedback and support. In a world inundated with choices, it\'s the human touch and personalized experiences that set small businesses apart.</p>\r\n<h3>Scaling Responsibly and Sustainably</h3>\r\n<p>As small businesses gain momentum, the temptation to scale rapidly can be alluring. However, growth must be approached with caution and foresight. Scaling too quickly without adequate resources or infrastructure can lead to operational inefficiencies and dilution of quality. Sustainable growth entails striking a delicate balance between ambition and prudence, scaling at a pace that ensures long-term viability and stability.</p>\r\n<h3>Embracing Digital Transformation</h3>\r\n<p>In an increasingly digitized world, embracing technology is no longer a choice but a necessity for small businesses looking to thrive. From establishing a robust online presence to leveraging data analytics for informed decision-making, digital transformation opens up a world of opportunities for growth and expansion. Embracing technology not only enhances operational efficiency but also enables small businesses to reach new markets and demographics.</p>\r\n<h3>Celebrating Milestones and Acknowledging Progress</h3>\r\n<p>Amidst the hustle and bustle of daily operations, it\'s essential for small business owners to pause, reflect, and celebrate milestones along the journey. Whether it\'s reaching a revenue target, expanding into new territories, or receiving accolades for exemplary service, these milestones serve as markers of progress and reminders of the distance traveled. Celebrating achievements not only boosts morale but also instills a sense of pride and motivation to continue pushing the boundaries of what\'s possible.</p>\r\n<p>In conclusion, the growth journey of a small business is a testament to the indomitable spirit of entrepreneurship. It\'s a journey characterized by resilience, innovation, and unwavering determination. As small businesses continue to evolve and flourish, they not only contribute to the vibrancy of local economies but also inspire future generations of dreamers and doers to embark on their own entrepreneurial odyssey.</p>',NULL,NULL,'2024-05-07 23:15:49','2024-05-07 23:15:49'),
(14,21,55,37,'من بذرة صغيرة إلى سماء النجاح: تنمية نمو الأعمال الصغيرة','من-بذرة-صغيرة-إلى-سماء-النجاح:-تنمية-نمو-الأعمال-الصغيرة','مسؤل','<p>في الساحة الواسعة للتجارة، تقف الشركات الصغيرة كمصابيح يبلغها الإبداع والمثابرة، وتجسد روح الرواد الرياديين. تلك المشاريع، التي غالباً ما تولد من رؤية فردية وتحتضنها إرادة ثابتة، تسهم بشكل كبير في نسيج الاقتصاد في المجتمعات حول العالم. ومع ذلك، تكمن وراء بداياتها المتواضعة وحجمها المتواضع، إمكانية عميقة للنمو والتطور والتأثير.</p>\r\n<p>رحلة العمل الصغيرة شبيهة بتربية شتلة حتى تنمو إلى شجرة عظيمة. إنها تتطلب عناية دقيقة وتخطيط استراتيجي واستعداد للتكيف مع البيئات المتغيرة باستمرار. ما يميز الشركات الصغيرة الناجحة ليس فقط قدرتها على البقاء وإنما مطاردتها للنمو بجميع جوانبه.</p>\r\n<h3>بزرع الرؤية والشغف</h3>\r\n<p>في قلب كل شركة صغيرة شخص رؤوي أو مجموعة من الأفراد ذوي الرؤية المشتركة الذين يتحركون بالشغف والغرض. هذه الرؤية تكون كالنجم الموجِّه، تضيء الطريق إلى الأمام من خلال مياه الشك والغموض. إنه هذا الوضوح في الغرض الذي يغذي الشرارة الأولى ويشعل لهب روح الرواد.</p>\r\n<h3>زراعة بذور الابتكار</h3>\r\n<p>الابتكار هو العنصر الأساسي في النمو المستدام. يجب على الشركات الصغيرة الابتكار باستمرار للبقاء متميزة في الأسواق الديناميكية. سواء كان ذلك باعتناق التقنيات الحديثة، أو إعادة تصوير الممارسات التقليدية، أو رسم الحلول الجديدة لمشاكل قديمة، فإن الابتكار يعمل كمحفز للتوسع والتميز.</p>\r\n<h3>التعامل مع التحديات بالمرونة</h3>\r\n<p>الطريق إلى النمو نادراً ما يكون سلساً، بل يحمل تحديات وعراقيل في كل مكان. الانكماش الاقتصادي، والمنافسة الشرسة، والعقبات التنظيمية - هذه بعض من الخصوم القويّة التي تواجهها الشركات الصغيرة خلال رحلتها. ومع ذلك، فمن خلال هذه الأوقات العصيبة يتألق الصمود. يجب على الشركات الصغيرة التغلب على العواقب بحزم، والتعلم من الانتكاسات، والظهور بقوة وحكمة.</p>\r\n<h3>تعزيز العلاقات والمجتمع</h3>\r\n<p>لا توجد أعمال تعمل على انفراد. إن بناء علاقات قوية مع العملاء والموردين والمجتمع بشكل عام أمر بالغ الأهمية للنمو المستدام. تلك العلاقات ليست فقط تعزز الولاء والثقة، بل تكون أيضاً مصدراً للتغذية الراجعة القيمة والدعم. في عالم مليء بالخيارات، إنما هو اللمسة الإنسانية والتجارب المخصصة التي تميز الشركات الصغيرة.</p>\r\n<h3>التوسع بشكل مسؤول ومستدام</h3>\r\n<p>مع اكتساب الزخم، قد تكون إغراءات التوسع بسرعة مغرية. ومع ذلك، يجب التعامل مع النمو بحذر وتبصر. التوسع بسرعة دون موارد أو هيكل تحتية كافية يمكن أن يؤدي إلى عدم الكفاءة التشغيلية وتضييع الجودة. يتطلب النمو المستدام إيجاد توازن حساس بين الطموح والحذر، والتوسع بوتيرة تض</p>',NULL,NULL,'2024-05-07 23:15:49','2024-05-07 23:15:49');
/*!40000 ALTER TABLE `blog_informations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_sections`
--

DROP TABLE IF EXISTS `blog_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `button_text` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_sections`
--

LOCK TABLES `blog_sections` WRITE;
/*!40000 ALTER TABLE `blog_sections` DISABLE KEYS */;
INSERT INTO `blog_sections` VALUES
(5,20,'Mores','Read our latest blogs','2023-08-19 00:44:01','2023-12-13 21:29:05'),
(6,21,'المدونات','اقرأ أحدث مدوناتنا','2023-08-28 03:06:59','2023-08-28 03:06:59');
/*!40000 ALTER TABLE `blog_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  `serial_number` mediumint(8) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` VALUES
(32,'663b3fa55cb46.png',1,'2024-05-07 22:55:16','2024-05-08 03:02:29'),
(33,'663b3fb1052e5.png',2,'2024-05-07 23:03:31','2024-05-08 03:02:41'),
(34,'663b3fc9a3c11.png',3,'2024-05-07 23:07:53','2024-05-08 03:03:05'),
(35,'663b3fdcf2d29.png',4,'2024-05-07 23:10:14','2024-05-08 03:03:24'),
(36,'663b4016d8f69.png',5,'2024-05-07 23:13:27','2024-05-08 03:04:22'),
(37,'663b40207f13d.png',6,'2024-05-07 23:15:48','2024-05-08 03:04:32');
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_hours`
--

DROP TABLE IF EXISTS `business_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_hours` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `day` varchar(255) DEFAULT NULL,
  `start_time` varchar(255) DEFAULT NULL,
  `end_time` varchar(255) DEFAULT NULL,
  `holiday` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_hours`
--

LOCK TABLES `business_hours` WRITE;
/*!40000 ALTER TABLE `business_hours` DISABLE KEYS */;
INSERT INTO `business_hours` VALUES
(1,1,'Saturday','08:00 AM','07:00 PM',1,'2024-05-01 21:11:40','2024-05-01 21:19:39'),
(2,1,'Sunday','08:00 AM','07:00 PM',1,'2024-05-01 21:11:40','2024-05-01 21:20:04'),
(3,1,'Monday','08:00 AM','07:00 PM',1,'2024-05-01 21:11:40','2024-05-01 21:20:04'),
(4,1,'Tuesday','08:00 AM','07:00 PM',1,'2024-05-01 21:11:40','2024-05-01 21:20:04'),
(5,1,'Wednesday',NULL,NULL,0,'2024-05-01 21:11:40','2024-05-01 21:20:04'),
(6,1,'Thursday','08:00 AM','07:00 PM',1,'2024-05-01 21:11:40','2024-05-01 21:20:04'),
(7,1,'Friday','08:00 AM','07:00 PM',1,'2024-05-01 21:11:40','2024-05-01 21:20:04'),
(15,3,'Saturday','10:00 AM','07:00 PM',1,'2024-05-01 23:18:29','2024-05-01 23:18:29'),
(16,3,'Sunday','10:00 AM','07:00 PM',1,'2024-05-01 23:18:29','2024-05-01 23:18:29'),
(17,3,'Monday','10:00 AM','07:00 PM',1,'2024-05-01 23:18:29','2024-05-01 23:18:29'),
(18,3,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-01 23:18:29','2024-05-01 23:18:29'),
(19,3,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-01 23:18:29','2024-05-01 23:18:29'),
(20,3,'Thursday','10:00 AM','07:00 PM',1,'2024-05-01 23:18:29','2024-05-01 23:18:29'),
(21,3,'Friday',NULL,NULL,0,'2024-05-01 23:18:29','2024-05-01 23:24:37'),
(22,4,'Saturday','10:00 AM','07:00 PM',1,'2024-05-02 02:33:34','2024-05-02 02:33:34'),
(23,4,'Sunday','10:00 AM','07:00 PM',1,'2024-05-02 02:33:34','2024-05-02 02:33:34'),
(24,4,'Monday','10:00 AM','07:00 PM',1,'2024-05-02 02:33:34','2024-05-02 02:33:34'),
(25,4,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-02 02:33:34','2024-05-02 02:33:34'),
(26,4,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-02 02:33:34','2024-05-02 02:33:34'),
(27,4,'Thursday','10:00 AM','07:00 PM',1,'2024-05-02 02:33:34','2024-05-02 02:33:34'),
(28,4,'Friday','10:00 AM','07:00 PM',1,'2024-05-02 02:33:34','2024-05-02 02:33:34'),
(29,5,'Saturday',NULL,NULL,0,'2024-05-05 20:59:20','2024-05-08 04:04:10'),
(30,5,'Sunday','10:00 AM','07:00 PM',1,'2024-05-05 20:59:20','2024-05-05 20:59:20'),
(31,5,'Monday','10:00 AM','07:00 PM',1,'2024-05-05 20:59:20','2024-05-05 20:59:20'),
(32,5,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-05 20:59:20','2024-05-05 20:59:20'),
(33,5,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-05 20:59:20','2024-05-05 20:59:20'),
(34,5,'Thursday','10:00 AM','07:00 PM',1,'2024-05-05 20:59:20','2024-05-05 20:59:20'),
(35,5,'Friday','10:00 AM','07:00 PM',1,'2024-05-05 20:59:20','2024-05-05 20:59:20'),
(36,6,'Saturday','10:00 AM','07:00 PM',1,'2024-05-05 21:47:53','2024-05-05 21:47:53'),
(37,6,'Sunday','10:00 AM','07:00 PM',1,'2024-05-05 21:47:53','2024-05-05 21:47:53'),
(38,6,'Monday','10:00 AM','07:00 PM',1,'2024-05-05 21:47:53','2024-05-05 21:47:53'),
(39,6,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-05 21:47:53','2024-05-05 21:47:53'),
(40,6,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-05 21:47:53','2024-05-05 21:47:53'),
(41,6,'Thursday',NULL,NULL,0,'2024-05-05 21:47:53','2024-05-08 04:04:26'),
(42,6,'Friday','10:00 AM','07:00 PM',1,'2024-05-05 21:47:53','2024-05-05 21:47:53'),
(43,7,'Saturday',NULL,NULL,0,'2024-05-05 23:06:52','2024-05-08 04:04:53'),
(44,7,'Sunday',NULL,NULL,0,'2024-05-05 23:06:52','2024-05-08 04:04:59'),
(45,7,'Monday','10:00 AM','07:00 PM',1,'2024-05-05 23:06:52','2024-05-05 23:06:52'),
(46,7,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-05 23:06:52','2024-05-05 23:06:52'),
(47,7,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-05 23:06:52','2024-05-05 23:06:52'),
(48,7,'Thursday','10:00 AM','07:00 PM',1,'2024-05-05 23:06:52','2024-05-05 23:06:52'),
(49,7,'Friday','10:00 AM','07:00 PM',1,'2024-05-05 23:06:52','2024-05-05 23:06:52'),
(57,9,'Saturday','10:00 AM','07:00 PM',1,'2024-05-06 20:37:36','2024-05-06 20:37:36'),
(58,9,'Sunday',NULL,NULL,0,'2024-05-06 20:37:36','2024-05-08 04:05:24'),
(59,9,'Monday',NULL,NULL,0,'2024-05-06 20:37:36','2024-05-08 04:05:24'),
(60,9,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-06 20:37:36','2024-05-06 20:37:36'),
(61,9,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-06 20:37:36','2024-05-06 20:37:36'),
(62,9,'Thursday','10:00 AM','07:00 PM',1,'2024-05-06 20:37:36','2024-05-06 20:37:36'),
(63,9,'Friday','10:00 AM','07:00 PM',1,'2024-05-06 20:37:36','2024-05-06 20:37:36'),
(64,10,'Saturday','10:00 AM','07:00 PM',1,'2024-05-06 21:22:20','2024-05-06 21:22:20'),
(65,10,'Sunday','10:00 AM','07:00 PM',1,'2024-05-06 21:22:20','2024-05-06 21:22:20'),
(66,10,'Monday','10:00 AM','07:00 PM',1,'2024-05-06 21:22:20','2024-05-06 21:22:20'),
(67,10,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-06 21:22:20','2024-05-06 21:22:20'),
(68,10,'Wednesday',NULL,NULL,0,'2024-05-06 21:22:20','2024-05-08 04:05:35'),
(69,10,'Thursday','10:00 AM','07:00 PM',1,'2024-05-06 21:22:20','2024-05-06 21:22:20'),
(70,10,'Friday','10:00 AM','07:00 PM',1,'2024-05-06 21:22:20','2024-05-06 21:22:20'),
(71,11,'Saturday',NULL,NULL,0,'2024-05-06 22:34:31','2024-05-08 04:05:46'),
(72,11,'Sunday','10:00 AM','07:00 PM',1,'2024-05-06 22:34:31','2024-05-06 22:34:31'),
(73,11,'Monday','10:00 AM','07:00 PM',1,'2024-05-06 22:34:31','2024-05-06 22:34:31'),
(74,11,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-06 22:34:31','2024-05-06 22:34:31'),
(75,11,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-06 22:34:31','2024-05-06 22:34:31'),
(76,11,'Thursday','10:00 AM','07:00 PM',1,'2024-05-06 22:34:31','2024-05-06 22:34:31'),
(77,11,'Friday','10:00 AM','07:00 PM',1,'2024-05-06 22:34:31','2024-05-06 22:34:31'),
(78,12,'Saturday','10:00 AM','07:00 PM',1,'2024-05-07 00:07:13','2024-05-07 00:07:13'),
(79,12,'Sunday','10:00 AM','07:00 PM',1,'2024-05-07 00:07:13','2024-05-07 00:07:13'),
(80,12,'Monday','10:00 AM','07:00 PM',1,'2024-05-07 00:07:13','2024-05-07 00:07:13'),
(81,12,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-07 00:07:13','2024-05-07 00:07:13'),
(82,12,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-07 00:07:13','2024-05-07 00:07:13'),
(83,12,'Thursday','10:00 AM','07:00 PM',1,'2024-05-07 00:07:13','2024-05-07 00:07:13'),
(84,12,'Friday','10:00 AM','07:00 PM',1,'2024-05-07 00:07:13','2024-05-07 00:07:13'),
(85,13,'Saturday',NULL,NULL,0,'2024-05-07 02:40:46','2024-05-08 04:06:06'),
(86,13,'Sunday',NULL,NULL,0,'2024-05-07 02:40:46','2024-05-08 04:06:06'),
(87,13,'Monday','10:00 AM','07:00 PM',1,'2024-05-07 02:40:46','2024-05-07 02:40:46'),
(88,13,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-07 02:40:46','2024-05-07 02:40:46'),
(89,13,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-07 02:40:46','2024-05-07 02:40:46'),
(90,13,'Thursday','10:00 AM','07:00 PM',1,'2024-05-07 02:40:46','2024-05-07 02:40:46'),
(91,13,'Friday','10:00 AM','07:00 PM',1,'2024-05-07 02:40:46','2024-05-07 02:40:46'),
(92,14,'Saturday','10:00 AM','07:00 PM',1,'2024-05-07 20:48:37','2024-05-07 20:48:37'),
(93,14,'Sunday','10:00 AM','07:00 PM',1,'2024-05-07 20:48:37','2024-05-07 20:48:37'),
(94,14,'Monday',NULL,NULL,0,'2024-05-07 20:48:37','2024-05-08 04:06:22'),
(95,14,'Tuesday','10:00 AM','07:00 PM',1,'2024-05-07 20:48:37','2024-05-07 20:48:37'),
(96,14,'Wednesday','10:00 AM','07:00 PM',1,'2024-05-07 20:48:37','2024-05-07 20:48:37'),
(97,14,'Thursday',NULL,NULL,0,'2024-05-07 20:48:37','2024-05-08 04:06:22'),
(98,14,'Friday','10:00 AM','07:00 PM',1,'2024-05-07 20:48:37','2024-05-07 20:48:37'),
(99,15,'Saturday','06:06','07:00',1,'2024-05-08 02:46:04','2024-10-27 20:28:30'),
(100,15,'Sunday','10:00','07:00',1,'2024-05-08 02:46:04','2024-10-27 20:28:30'),
(101,15,'Monday','10:00','07:00',1,'2024-05-08 02:46:04','2024-10-27 20:28:30'),
(102,15,'Tuesday','10:00','07:00',1,'2024-05-08 02:46:04','2024-10-27 20:28:30'),
(103,15,'Wednesday','10:00','07:00',1,'2024-05-08 02:46:04','2024-10-27 20:28:30'),
(104,15,'Thursday','10:00','07:00',1,'2024-05-08 02:46:04','2024-10-27 20:28:30'),
(105,15,'Friday','10:00','07:00',1,'2024-05-08 02:46:04','2024-10-27 20:28:30'),
(113,17,'Saturday','10:00 AM','07:00 PM',1,'2025-10-29 04:38:48','2025-10-29 04:38:48'),
(114,17,'Sunday','10:00 AM','07:00 PM',1,'2025-10-29 04:38:48','2025-10-29 04:38:48'),
(115,17,'Monday','10:00 AM','07:00 PM',1,'2025-10-29 04:38:48','2025-10-29 04:38:48'),
(116,17,'Tuesday','10:00 AM','07:00 PM',1,'2025-10-29 04:38:48','2025-10-29 04:38:48'),
(117,17,'Wednesday','10:00 AM','07:00 PM',1,'2025-10-29 04:38:48','2025-10-29 04:38:48'),
(118,17,'Thursday','10:00 AM','07:00 PM',1,'2025-10-29 04:38:48','2025-10-29 04:38:48'),
(119,17,'Friday','10:00 AM','07:00 PM',1,'2025-10-29 04:38:48','2025-10-29 04:38:48'),
(120,18,'Saturday','10:00 AM','07:00 PM',1,'2025-11-03 06:24:56','2025-11-03 06:24:56'),
(121,18,'Sunday','10:00 AM','07:00 PM',1,'2025-11-03 06:24:56','2025-11-03 06:24:56'),
(122,18,'Monday','10:00 AM','07:00 PM',1,'2025-11-03 06:24:56','2025-11-03 06:24:56'),
(123,18,'Tuesday','10:00 AM','07:00 PM',1,'2025-11-03 06:24:56','2025-11-03 06:24:56'),
(124,18,'Wednesday','10:00 AM','07:00 PM',1,'2025-11-03 06:24:56','2025-11-03 06:24:56'),
(125,18,'Thursday','10:00 AM','07:00 PM',1,'2025-11-03 06:24:56','2025-11-03 06:24:56'),
(126,18,'Friday','10:00 AM','07:00 PM',1,'2025-11-03 06:24:56','2025-11-03 06:24:56');
/*!40000 ALTER TABLE `business_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_to_action_sections`
--

DROP TABLE IF EXISTS `call_to_action_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_to_action_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `button_name` varchar(255) DEFAULT NULL,
  `button_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_to_action_sections`
--

LOCK TABLES `call_to_action_sections` WRITE;
/*!40000 ALTER TABLE `call_to_action_sections` DISABLE KEYS */;
INSERT INTO `call_to_action_sections` VALUES
(4,20,'pe earum totam minima aperiam repellendus possimus molestias optio sapiente, quam               repudiandae voluptatum accusantium.','Find Your Favorite Traveling Place','We highly recommend Carlist. We\'ve used them several times and have always been impressed with their excellent and awesome service.',NULL,'Register Now','https://www.youtube.com/','2023-08-28 02:47:29','2024-05-09 02:03:42'),
(5,21,'هل تريد أن تكون بائعًا لقائمة السيارات؟','ابحث عن مكان السفر المفضل لديك','ونحن نوصي بشدة كارليست. لقد استخدمناها عدة مرات وقد أعجبنا دائمًا بخدمتهم الممتازة والرائعة.',NULL,'سجل الان','https://codecanyon8.kreativdev.com/carlist/vendor/signup','2023-08-28 02:52:05','2024-05-06 03:17:01');
/*!40000 ALTER TABLE `call_to_action_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_sections`
--

DROP TABLE IF EXISTS `category_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `button_text` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_sections`
--

LOCK TABLES `category_sections` WRITE;
/*!40000 ALTER TABLE `category_sections` DISABLE KEYS */;
INSERT INTO `category_sections` VALUES
(1,'8','Popular Car Categories',NULL,'','View All','2023-01-19 05:15:30','2023-08-12 23:44:50'),
(2,'9','فئات السيارات الشعبية','تصفح حسب فئات السيارات الأكثر شهرة','إذا كنت في السوق لشراء سيارة جديدة ، فمن المحتمل أنك أجريت حصتك العادلة من البحث حول خدمات السيارات.',NULL,'2023-01-19 05:16:21','2023-01-19 05:16:21'),
(3,'20','Most Popular Categories','Sed ut perspiciatis unde omnis iste nat um doloremque laudantium.','','All Categories','2023-08-19 00:11:48','2024-05-09 02:13:32'),
(4,'21','اكتشف الفئات الشائعة','اكتشف الفئات الشائعةاكتشف الفئات الشائعةاكتشف الفئات الشائعةاكتشف الفئات الشائعةاكتشف الفئات الشائعة','','عرض الكل','2023-08-28 02:54:03','2023-12-13 04:26:02');
/*!40000 ALTER TABLE `category_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `country_id` bigint(20) DEFAULT NULL,
  `feature_image` varchar(255) DEFAULT NULL,
  `state_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES
(1,20,2,'1714619111.png',1,'Melbourne','2024-05-01 21:05:11','2024-10-14 22:00:32','melbourne'),
(2,21,3,'66330314045e9.jpg',2,'ملبورن','2024-05-01 21:05:41','2024-10-14 22:00:57','ملبورن'),
(3,20,4,'1714624599.png',3,'Anantapuram','2024-05-01 22:36:39','2024-10-14 22:01:39','anantapuram'),
(4,21,5,'1714624623.png',4,'أنانتابور','2024-05-01 22:37:03','2024-10-14 22:00:54','أنانتابور'),
(5,20,6,'663b4310a25d4.jpg',NULL,'Cox\'s Bazar','2024-05-02 02:27:07','2024-10-14 22:00:29','cox\'s-bazar'),
(6,21,7,'663b431a4fa77.jpg',NULL,'كوكس بازار','2024-05-02 02:27:44','2024-05-08 03:17:14','كوكس بازار'),
(7,20,8,'663845c341299.jpg',NULL,'Skardu','2024-05-05 20:51:12','2024-10-14 22:01:16','skardu'),
(8,21,9,'1714963933.png',NULL,'سكاردو','2024-05-05 20:52:13','2024-10-14 22:00:51','سكاردو'),
(9,20,10,'1714966820.png',5,'Los Angeles','2024-05-05 21:40:20','2024-10-14 22:00:25','los-angeles'),
(10,21,11,'1714966853.png',6,'لوس أنجلوس','2024-05-05 21:40:53','2024-10-14 22:00:48','لوس-أنجلوس'),
(11,20,10,'1714971495.png',7,'Jacksonville','2024-05-05 22:58:15','2024-10-14 22:00:22','jacksonville'),
(12,21,11,'1714971519.png',8,'جاكسونفيل','2024-05-05 22:58:39','2024-10-14 22:00:46','جاكسونفيل'),
(13,20,6,'663b42f87da7c.jpg',NULL,'Dhaka','2024-05-06 02:29:30','2024-10-14 22:00:07','dhaka'),
(14,21,7,'663b4302a138a.jpg',NULL,'دكا','2024-05-06 02:30:01','2024-10-14 22:00:43','دكا'),
(15,20,10,'670e07914c51e.jpg',5,'San Diego','2024-05-06 21:15:50','2024-10-15 00:11:29','san-diego'),
(16,21,11,'672edbc5d0826.jpg',6,'سان دييغو','2024-05-06 21:16:26','2024-11-08 21:49:25','سان-دييغو');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `claim_listings`
--

DROP TABLE IF EXISTS `claim_listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `claim_listings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `vendor_id` bigint(20) unsigned DEFAULT NULL,
  `language_id` bigint(20) unsigned DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `redemption_token` varchar(64) DEFAULT NULL,
  `raw_redemption_token` varchar(255) DEFAULT NULL,
  `redemption_expires_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(255) DEFAULT NULL,
  `information` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claim_listings`
--

LOCK TABLES `claim_listings` WRITE;
/*!40000 ALTER TABLE `claim_listings` DISABLE KEYS */;
INSERT INTO `claim_listings` VALUES
(11,17,2,NULL,20,'approved','ecc6db5883cdb75b6aca489cd6d444cfb77f3d78f2260d3fbe3f05e5a980fa02','7ddf4487-0639-4fcd-8735-12c30fd7b1be','2026-11-02 06:11:09','2025-11-03 06:11:09','Mercedes Ellison','mitefa@mailinator.com','+1 (982) 597-9874','{\"phone\":{\"value\":\"+1 (982) 597-9874\",\"type\":1},\"content\":{\"value\":\"Vel autem eu commodo\",\"type\":5},\"date\":{\"value\":\"2002-05-18\",\"type\":6},\"time\":{\"value\":\"10:19\",\"type\":7},\"zip_file\":{\"originalName\":\"list_s1 (1).zip\",\"value\":\"69089b8b54307.zip\",\"type\":8}}','2025-11-03 06:09:47','2025-11-03 06:11:09'),
(12,18,12,NULL,20,'pending',NULL,NULL,NULL,NULL,'saiful islam',NULL,'0187233075','{\"phone\":{\"value\":\"0187233075\",\"type\":1},\"date\":{\"value\":\"2024-02-25\",\"type\":6},\"time\":{\"value\":\"10:25\",\"type\":7},\"zip_file\":{\"originalName\":\"chart-line.zip\",\"value\":\"6925528610b16.zip\",\"type\":8}}','2025-11-25 00:53:58','2025-11-25 00:53:58');
/*!40000 ALTER TABLE `claim_listings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1=user, 2=admin, 3=vendor',
  `support_ticket_id` int(11) DEFAULT NULL,
  `reply` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES
(9,204,3,5,'<p>test</p>','69d4af3185ea6.zip','2026-04-07 01:16:01','2026-04-07 01:16:01'),
(10,204,3,5,'<p>test</p>','69d4af519c21b.zip','2026-04-07 01:16:33','2026-04-07 01:16:33'),
(11,204,3,5,'test','69d4b24352d38.zip','2026-04-07 01:29:07','2026-04-07 01:29:07'),
(12,1,2,8,'<p>fdfdfdf</p>','6a033533527d0.zip','2026-05-12 08:12:03','2026-05-12 08:12:03');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cookie_alerts`
--

DROP TABLE IF EXISTS `cookie_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cookie_alerts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `cookie_alert_status` tinyint(3) unsigned NOT NULL,
  `cookie_alert_btn_text` varchar(255) NOT NULL,
  `cookie_alert_text` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cookie_alerts_language_id_foreign` (`language_id`),
  CONSTRAINT `cookie_alerts_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cookie_alerts`
--

LOCK TABLES `cookie_alerts` WRITE;
/*!40000 ALTER TABLE `cookie_alerts` DISABLE KEYS */;
INSERT INTO `cookie_alerts` VALUES
(3,20,1,'I Agree','We use cookies to give you the best online experience.\r\nBy continuing to browse the site you are agreeing to our use of cookies.','2023-08-29 02:35:44','2025-11-03 23:36:12'),
(4,21,0,'أنا موافق','نحن نستخدم ملفات تعريف الارتباط لنمنحك أفضل تجربة عبر الإنترنت. من خلال الاستمرار في تصفح الموقع فإنك توافق على استخدامنا لملفات تعريف الارتباط.','2023-08-29 02:36:53','2024-02-07 01:00:30');
/*!40000 ALTER TABLE `cookie_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter_informations`
--

DROP TABLE IF EXISTS `counter_informations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `counter_informations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `icon` varchar(255) NOT NULL,
  `amount` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counter_informations`
--

LOCK TABLES `counter_informations` WRITE;
/*!40000 ALTER TABLE `counter_informations` DISABLE KEYS */;
INSERT INTO `counter_informations` VALUES
(10,20,'fas fa-trophy',500,'Awards Winning','2023-08-19 00:41:52','2024-05-06 03:11:10'),
(15,20,'fas fa-users',299,'Happy Users','2023-11-13 02:40:35','2024-05-06 03:12:06'),
(16,20,'fas fa-landmark',199,'Active Members','2023-11-17 20:49:46','2024-05-06 03:13:12'),
(17,20,'far fa-list-alt',499,'Total Listing','2024-05-06 03:10:15','2024-05-06 03:10:15'),
(18,21,'fas fa-trophy',500,'الفوز بالجوائز','2023-08-19 00:41:52','2024-05-06 03:15:10'),
(19,21,'fas fa-users',299,'المستخدمين السعداء','2023-11-13 02:40:35','2024-05-06 03:14:54'),
(20,21,'fas fa-landmark',199,'الأعضاء النشطين','2023-11-17 20:49:46','2024-05-06 03:14:40'),
(21,21,'far fa-list-alt',499,'القائمة الإجمالية','2024-05-06 03:10:15','2024-05-06 03:14:24');
/*!40000 ALTER TABLE `counter_informations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter_sections`
--

DROP TABLE IF EXISTS `counter_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `counter_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counter_sections`
--

LOCK TABLES `counter_sections` WRITE;
/*!40000 ALTER TABLE `counter_sections` DISABLE KEYS */;
INSERT INTO `counter_sections` VALUES
(3,20,'See Our Achievements',NULL,'2023-08-19 00:38:24','2024-05-06 03:08:01'),
(4,21,'لماذا اخترت خدمات قائمة السيارات لدينا؟','إذا كنت في السوق لشراء سيارة جديدة ، فمن المحتمل أنك أجريت نصيبك العادل من البحث في خدمات السيارات. أنت تعرف نوع السيارة التي تريدها ، وما الميزات التي تحتاجها؟ نحن هنا لمساعدتك في أي وقت.','2023-08-19 03:44:15','2023-08-19 03:44:15');
/*!40000 ALTER TABLE `counter_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES
(2,20,'Australia','2024-05-01 21:01:14','2024-05-01 21:01:14'),
(3,21,'أستراليا','2024-05-01 21:01:40','2024-05-07 23:28:36'),
(4,20,'India','2024-05-01 22:32:15','2024-05-01 22:32:15'),
(5,21,'الهند','2024-05-01 22:33:22','2024-05-07 23:28:32'),
(6,20,'Bangladesh','2024-05-02 02:25:08','2024-05-02 02:25:08'),
(7,21,'بنغلاديش','2024-05-02 02:25:34','2024-05-07 23:28:27'),
(8,20,'Pakistan','2024-05-05 20:46:21','2024-05-05 20:46:21'),
(9,21,'باكستان','2024-05-05 20:46:54','2024-05-07 23:28:22'),
(10,20,'United States','2024-05-05 21:35:22','2024-05-05 21:35:22'),
(11,21,'الولايات المتحدة','2024-05-05 21:35:51','2024-05-07 23:28:15');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `serial_number` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `faqs_language_id_foreign` (`language_id`),
  CONSTRAINT `faqs_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES
(16,20,'What is Bulistio app?','To list your car, simply create an account on our website, provide accurate vehicle information, upload high-quality photos, and set an appropriate price.',1,'2023-08-19 02:29:36','2023-10-21 03:10:34'),
(17,20,'How to Purchase this App ?','Yes, you can list multiple cars using a single account. Just follow the same listing process for each vehicle.',2,'2023-08-19 02:29:51','2023-10-21 03:11:50'),
(18,20,'How do I Make a Premium User?','We offer both free and premium listing options. Basic listings are free, while premium options may include enhanced visibility and additional features for a fee.',3,'2023-08-19 02:30:06','2023-10-21 03:12:08'),
(19,20,'How to Debug this App?','It\'s important to provide detailed information such as the make, model, year, mileage, condition, features, and any history of accidents or repairs. The more details you provide, the better your chances of attracting potential buyers.',4,'2023-08-19 02:30:22','2023-10-21 03:12:25'),
(20,20,'Can I make an Appointment?','The duration of your car listing depends on the type of listing you choose. Free listings usually have a standard duration, while premium listings may have extended visibility periods.',5,'2023-08-19 02:30:37','2023-10-21 03:12:38'),
(21,20,'What\'s the Business Policies?','Yes, you can edit your listing at any time. Log in to your account, access your listing, and make the necessary changes to the details, price, or images.',6,'2023-08-19 02:30:55','2023-10-21 03:12:52'),
(22,20,'What\'s the Business Policies?','Interested buyers can contact you through the contact information you provide in your listing. We recommend using our secure messaging system to maintain privacy and security during negotiations.',7,'2023-08-19 02:31:11','2023-10-21 03:13:07'),
(26,21,'كيف أقوم بإدراج سيارتي في موقع الويب الخاص بك؟','لإدراج سيارتك ، ما عليك سوى إنشاء حساب على موقعنا الإلكتروني ، وتقديم معلومات دقيقة عن السيارة ، وتحميل صور عالية الجودة ، وتحديد السعر المناسب.',1,'2023-08-19 02:32:32','2023-08-19 02:32:32'),
(27,21,'هل يمكنني إدراج عدة سيارات في حساب واحد؟','نعم ، يمكنك إدراج عدة سيارات باستخدام حساب واحد. ما عليك سوى اتباع نفس عملية الإدراج لكل مركبة.',2,'2023-08-19 02:32:57','2023-08-19 02:32:57'),
(28,21,'هل هناك رسوم لإدراج سيارتي على منصتك؟','نحن نقدم كلاً من خيارات الإدراج المجانية والمتميزة. القوائم الأساسية مجانية ، بينما قد تتضمن الخيارات المتميزة رؤية محسنة وميزات إضافية مقابل رسوم.',3,'2023-08-19 02:33:20','2023-08-19 02:33:20'),
(29,21,'ما نوع المعلومات التي يجب أن أدرجها في قائمة سيارتي؟','من المهم تقديم معلومات مفصلة مثل الطراز والطراز والسنة والمسافة المقطوعة والحالة والميزات وأي سجل للحوادث أو الإصلاحات. كلما زادت التفاصيل التي تقدمها ، زادت فرصك في جذب المشترين المحتملين.',4,'2023-08-19 02:33:43','2023-08-19 02:33:43'),
(30,21,'كم من الوقت ستكون قائمة سيارتي نشطة؟','تعتمد مدة قائمة سيارتك على نوع القائمة التي تختارها. عادةً ما يكون للقوائم المجانية مدة قياسية ، في حين أن القوائم المميزة قد تحتوي على فترات رؤية ممتدة.',5,'2023-08-19 02:34:08','2023-08-19 02:34:08'),
(31,21,'هل يمكنني تعديل القائمة الخاصة بي بعد أن تكون مباشرة؟','نعم ، يمكنك تعديل قائمتك في أي وقت. قم بتسجيل الدخول إلى حسابك ، والوصول إلى قائمتك ، وإجراء التغييرات اللازمة على التفاصيل أو السعر أو الصور.',6,'2023-08-19 02:34:32','2023-08-19 02:34:32'),
(32,21,'كيف أتواصل مع المشترين المحتملين؟','يمكن للمشترين المهتمين الاتصال بك من خلال معلومات الاتصال التي تقدمها في قائمتك. نوصي باستخدام نظام المراسلة الآمن الخاص بنا للحفاظ على الخصوصية والأمان أثناء المفاوضات.',7,'2023-08-19 02:35:10','2023-08-19 02:35:10'),
(33,21,'ماذا يحدث إذا تم بيع سيارتي من خلال منصة أخرى؟','إذا كانت سيارتك تبيع من خلال منصة أخرى ، فمن المهم إزالة أو وضع علامة على قائمتك على الفور على أنها مباعة على موقعنا على الإنترنت لتجنب أي ارتباك للمشترين المحتملين.',8,'2023-08-19 02:35:46','2023-08-19 02:35:46'),
(34,21,'هل هناك أي نصائح لالتقاط صور جذابة للسيارة؟','قطعاً! يمكن للصور الواضحة والمضاءة جيدًا التي تم التقاطها من زوايا مختلفة أن تعزز إدراجك بشكل كبير. قم بتضمين لقطات من الداخل والخارج والمحرك وأي ميزات خاصة.',9,'2023-08-19 02:36:10','2023-08-19 02:36:10'),
(35,21,'ما هي تدابير السلامة المعمول بها لمنع الاحتيال؟','نحن نتعامل مع منع الاحتيال على محمل الجد. نحن نستخدم تدابير أمنية مختلفة ونوصي بالتعامل محليًا ، والتحقق من معلومات المشتري ، والحذر من طلبات الدفع غير العادية.',10,'2023-08-19 02:36:34','2023-08-19 02:36:34');
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fcm_tokens`
--

DROP TABLE IF EXISTS `fcm_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fcm_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `platform` varchar(255) DEFAULT NULL,
  `message_title` varchar(255) DEFAULT NULL,
  `message_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `booking_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fcm_tokens`
--

LOCK TABLES `fcm_tokens` WRITE;
/*!40000 ALTER TABLE `fcm_tokens` DISABLE KEYS */;
INSERT INTO `fcm_tokens` VALUES
(1,NULL,'bk jfghjash','web','Product Purchase Complete','Your current payment status pending','2025-12-06 02:54:57','2025-12-06 02:54:57',77),
(2,NULL,'bk jfghjash','web','Product Purchase Complete','Your current payment status pending','2025-12-06 02:55:10','2025-12-06 02:55:10',78),
(3,NULL,'bk jfghjash','web','Product Purchase Complete','Your current payment status pending','2025-12-06 02:55:27','2025-12-06 02:55:27',79);
/*!40000 ALTER TABLE `fcm_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature_orders`
--

DROP TABLE IF EXISTS `feature_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `vendor_mail` varchar(255) DEFAULT NULL,
  `order_number` varchar(255) DEFAULT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `gateway_type` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `days` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conversation_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature_orders`
--

LOCK TABLES `feature_orders` WRITE;
/*!40000 ALTER TABLE `feature_orders` DISABLE KEYS */;
INSERT INTO `feature_orders` VALUES
(1,1,204,'superBusiness47@example.com','678c9598299fc',1000.00,'Paypal','online','completed','completed',NULL,'1.pdf','900','2025-01-19','2027-07-08','2025-01-19 00:03:04','2025-01-19 00:10:13',NULL),
(2,14,204,'superBusiness47@example.com','678c95bc2181b',1000.00,'Bank of America','offline','completed','completed','678c95bc20eae.jpg','2.pdf','900','2025-11-03','2028-04-21','2025-01-19 00:03:40','2025-11-03 07:04:36',NULL),
(4,11,202,'biznexus22@example.com','678c969130e1d',1000.00,'Paypal','online','completed','completed',NULL,'4.pdf','900','2025-01-19','2027-07-08','2025-01-19 00:04:57','2025-01-19 00:10:30',NULL),
(6,10,203,'tradetrail9@example.com','678c9734b8b5d',1000.00,'Paypal','online','completed','completed',NULL,'6.pdf','900','2025-01-19','2027-07-08','2025-01-19 00:09:56','2025-01-19 00:10:31',NULL),
(11,7,205,'bizroster@example.com','691325cd7677b',1000.00,'paypal','offline','completed','completed',NULL,NULL,'900','2025-11-11','2028-04-29','2025-11-11 06:02:21','2025-11-11 06:02:21',NULL),
(13,9,201,'listingspot56@example.com','691326a79a46f',600.00,'Paypal','online','completed','completed',NULL,'13.pdf','500','2025-11-11','2027-03-26','2025-11-11 06:05:59','2025-11-11 06:06:16',NULL),
(14,15,204,'superBusiness47@example.com','6a04263f31710',150.00,'Bank of America','offline','completed','completed','6a04263f30975.png','14.pdf','100','2026-05-13','2026-08-21','2026-05-13 01:20:31','2026-05-13 01:23:04',NULL);
/*!40000 ALTER TABLE `feature_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature_sections`
--

DROP TABLE IF EXISTS `feature_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `button_text` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature_sections`
--

LOCK TABLES `feature_sections` WRITE;
/*!40000 ALTER TABLE `feature_sections` DISABLE KEYS */;
INSERT INTO `feature_sections` VALUES
(3,20,NULL,'Our top listing','Explore All','2023-08-19 03:00:57','2025-11-03 22:18:23'),
(4,21,NULL,'أفضل مركباتنا المميزة','مركباتنا المميزة','2023-08-19 03:02:05','2023-12-13 20:54:14');
/*!40000 ALTER TABLE `feature_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `featured_listing_charges`
--

DROP TABLE IF EXISTS `featured_listing_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `featured_listing_charges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `days` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured_listing_charges`
--

LOCK TABLES `featured_listing_charges` WRITE;
/*!40000 ALTER TABLE `featured_listing_charges` DISABLE KEYS */;
INSERT INTO `featured_listing_charges` VALUES
(1,900,1000,'2024-05-02 00:47:38','2024-05-02 00:47:38'),
(2,700,775,'2024-05-02 00:47:53','2024-05-02 00:47:53'),
(3,500,600,'2024-05-07 22:30:33','2024-05-07 22:30:42'),
(4,100,150,'2024-05-07 22:30:58','2024-05-07 22:30:58');
/*!40000 ALTER TABLE `featured_listing_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `footer_contents`
--

DROP TABLE IF EXISTS `footer_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `footer_contents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `about_company` text DEFAULT NULL,
  `copyright_text` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `footer_texts_language_id_foreign` (`language_id`),
  CONSTRAINT `footer_texts_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `footer_contents`
--

LOCK TABLES `footer_contents` WRITE;
/*!40000 ALTER TABLE `footer_contents` DISABLE KEYS */;
INSERT INTO `footer_contents` VALUES
(5,20,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.','<p>Copyright ©2026. All Rights Reserved..</p>','2023-08-19 23:40:53','2025-12-07 21:20:32'),
(6,21,'في قائمة سيارة ، نقدم مجموعة واسعة من السيارات المستعملة عالية الجودة لتلبية احتياجات قيادتك وميزانيتك. مع سنوات من الخبرة في صناعة السيارات ، نفخر بتقديم خدمة عملاء استثنائية والتأكد من أن كل سيارة في قطعتنا تلبي معاييرنا الصارمة للجودة والموثوقية.','<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">حقوق النشر © 2026. كل الحقوق محفوظة.</span></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"> </div>','2023-08-19 23:43:21','2025-12-07 21:20:55');
/*!40000 ALTER TABLE `footer_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_inputs`
--

DROP TABLE IF EXISTS `form_inputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_inputs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` bigint(20) unsigned DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 - Text Field\n2 - Number Field\n3 - Select\n4 - Checkbox\n5 - Textarea Field\n6 - Datepicker\n7 - Timepicker\n8 - File',
  `label` varchar(255) NOT NULL,
  `placeholder` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 - not required\n1 - required',
  `options` text DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `order_no` int(11) NOT NULL DEFAULT 0 COMMENT 'Order number for sorting\ndefault value 0 means, this input field has created just now and it has not sorted yet',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_inputs`
--

LOCK TABLES `form_inputs` WRITE;
/*!40000 ALTER TABLE `form_inputs` DISABLE KEYS */;
INSERT INTO `form_inputs` VALUES
(16,4,1,'Phone','Enter phone','phone',1,NULL,NULL,1,'2025-09-24 00:41:26','2025-09-24 00:41:26'),
(17,4,5,'Content','Enter Message','content',0,NULL,NULL,2,'2025-09-24 00:42:02','2025-09-24 00:42:02'),
(18,4,6,'Date','Select date','date',1,NULL,NULL,3,'2025-09-24 00:42:33','2025-09-24 00:42:33'),
(19,4,7,'time','select time','time',1,NULL,NULL,4,'2025-09-24 00:42:50','2025-09-24 00:42:50'),
(20,4,8,'Zip file',NULL,'zip_file',1,NULL,10,5,'2025-09-24 00:44:14','2025-09-24 00:44:14'),
(31,13,1,'Phone Number','phone','phone_number',1,NULL,NULL,1,'2025-10-27 00:00:01','2025-10-27 00:00:01'),
(32,13,1,'Product Name','Product Name','product_name',1,NULL,NULL,2,'2025-10-27 00:00:31','2025-10-27 00:00:31'),
(33,13,1,'Quantity Needed','Quantity','quantity_needed',1,NULL,NULL,3,'2025-10-27 00:00:47','2025-10-27 00:00:47'),
(34,13,5,'Product Details','Product Details','product_details',1,NULL,NULL,4,'2025-10-27 00:01:25','2025-10-27 05:55:24'),
(35,13,1,'Delivery Location','Delivery Location','delivery_location',1,NULL,NULL,5,'2025-10-27 00:01:45','2025-10-27 00:01:45'),
(36,13,6,'Expected Delivery Date','Expected Delivery Date','expected_delivery_date',1,NULL,NULL,6,'2025-10-27 00:02:03','2025-10-27 00:02:03'),
(37,13,2,'Expected Budget (optional)','Expected Budget','expected_budget_(optional)',0,NULL,NULL,7,'2025-10-27 00:02:25','2025-10-27 00:02:25'),
(38,13,1,'Additional Comments/Note','Additional Comments/Note','additional_comments/note',0,NULL,NULL,8,'2025-10-27 00:02:46','2025-10-27 00:02:46'),
(39,13,8,'file',NULL,'file',0,NULL,23,9,'2025-10-27 22:35:52','2025-12-06 23:47:24'),
(40,15,1,'sdsd','asd','sdsd',1,NULL,NULL,1,'2025-12-07 01:23:56','2025-12-07 01:23:56'),
(41,13,6,'Test Date','Date','test_date',1,NULL,NULL,10,'2026-04-21 23:44:22','2026-04-22 00:50:20');
/*!40000 ALTER TABLE `form_inputs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forms`
--

DROP TABLE IF EXISTS `forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `forms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `vendor_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('quote_request','claim_request') DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forms`
--

LOCK TABLES `forms` WRITE;
/*!40000 ALTER TABLE `forms` DISABLE KEYS */;
INSERT INTO `forms` VALUES
(4,20,NULL,'Claim Request','claim_request','active','2025-09-24 00:41:03','2025-09-24 00:41:03'),
(6,21,NULL,'test','quote_request','active','2025-10-17 08:49:35','2025-10-17 09:33:48'),
(10,21,NULL,'vgdfdfdfd','claim_request','active','2025-10-21 04:50:17','2025-10-21 04:50:17'),
(12,21,208,'vcvcvcv','quote_request','active','2025-10-21 04:51:15','2025-10-21 04:51:15'),
(13,20,204,'product query form','quote_request','active','2025-10-26 22:28:09','2025-11-03 06:35:31'),
(14,21,207,'dsdsdsdsd','quote_request','active','2025-10-28 04:51:27','2025-10-28 04:51:27'),
(15,20,NULL,'ok','quote_request','active','2025-12-07 01:23:41','2025-12-07 01:23:41');
/*!40000 ALTER TABLE `forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `endpoint` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guests`
--

LOCK TABLES `guests` WRITE;
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;
INSERT INTO `guests` VALUES
(10,'https://fcm.googleapis.com/fcm/send/dnSze7t5tAs:APA91bHjfo1pSMafpV2cHXURCr1zbheCWNEFUOhdzEtsQkb2o0xWi6knO1ovl4KgSE0AY2r26csSiWKf5pZQzP1f43VzOlFfh-8lSdNZAuRioIgV_dJV2On7uoGGfwuot_FiMwnq_DUA','2024-06-23 00:30:12','2024-06-23 00:30:12'),
(11,'https://fcm.googleapis.com/fcm/send/dqTWShBKda4:APA91bEj6e7yaguVik1fJdOfZxZwWzkjIbtCPuzCtFhmbi3g1TmSvmZUvwcdPurox4XT9hatxpe4W8fD-uqfbCu2eH1pNBZL_ZOiOmuPyp6Kn4a4ln84MIPP4RSsTxVsGiuaLyKhDFZj','2024-09-30 21:33:54','2024-09-30 21:33:54'),
(12,'https://fcm.googleapis.com/fcm/send/cxzkYsgQ2oU:APA91bGNLPJwyzbqRFyTqfe_r_dHjfJYsSHaZ5vGF1S1cRMBkbRTai203yvsoUNv5vsJD_IJJLwPaCeVW0o9C0HRHRMWkAVkGTnlOUMCWeXadSkR-4PbuSEn6aDgDpGucZ_CcUytx3nJ','2024-10-08 23:07:30','2024-10-08 23:07:30'),
(13,'https://fcm.googleapis.com/fcm/send/d4SZbcDK9tI:APA91bHTCBrS6YZekpkTxh-iqTsqD68JWIP4Sx28PIutRWRuGHvwf714CFiq5R1Q87KcN0dVbcIoyb2RT2Jxzq9k8zmZwnnerd4ELoHClVlrpsv1VKY2U2E1NcY6suFrm2ob6xkLExJQ','2025-03-26 22:37:02','2025-03-26 22:37:02'),
(14,'https://fcm.googleapis.com/fcm/send/ersyZdHLon8:APA91bFD8j5n8zzj0QFFlPPuOx-bnRdgd9NzUc4Eft1i06Wnl_Fltt1Trs8hN7hVd4KtxwjYbQAHGvvnP1UsMYvaEHwq61umAUFrGtVRoc9bZV3ojabu9M4mNK32BTR_Vyhs571nRjmJ','2026-06-24 02:16:22','2026-06-24 02:16:22');
/*!40000 ALTER TABLE `guests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hero_sections`
--

DROP TABLE IF EXISTS `hero_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hero_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hero_sections`
--

LOCK TABLES `hero_sections` WRITE;
/*!40000 ALTER TABLE `hero_sections` DISABLE KEYS */;
INSERT INTO `hero_sections` VALUES
(1,21,'هل تبحث عن عمل؟','تّبع الشرقي و. أم المضي أجزاء بال, ولم أم وصغار الشمال عشوائية. لم الأولىد. الربيع، وايرلندا الإنذار، ان نفس, بعد ان وعُرفت الطريق الأوروبيّون. أي مارد معارضة هذه','2024-03-26 20:40:56','2024-11-11 00:42:08'),
(2,20,'Are You Looking For A business?','Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusa ntium doloremque laudantium, totamrem.','2024-03-26 20:41:33','2024-05-07 23:48:16');
/*!40000 ALTER TABLE `hero_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` char(255) NOT NULL,
  `direction` tinyint(4) NOT NULL,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES
(20,'English','en',0,0,'2023-08-17 03:19:12','2026-06-24 02:35:45'),
(21,'عربي','ar',1,0,'2023-08-17 03:19:32','2025-02-06 01:56:24'),
(23,'Русский','ru',0,1,'2026-06-24 02:33:08','2026-06-24 02:47:30'),
(24,'Türkçe','tr',0,0,'2026-06-24 02:47:26','2026-06-24 02:47:30');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_categories`
--

DROP TABLE IF EXISTS `listing_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `serial_number` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mobile_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_categories`
--

LOCK TABLES `listing_categories` WRITE;
/*!40000 ALTER TABLE `listing_categories` DISABLE KEYS */;
INSERT INTO `listing_categories` VALUES
(1,20,'salon','fas fa-spa','salon',1,1,'2024-04-30 23:18:55','2025-12-07 03:46:35','69354cfbca52c.png'),
(2,21,'صالون','fas fa-spa','صالون',1,1,'2024-04-30 23:28:04','2025-12-07 03:48:16','69354d604cac3.png'),
(3,20,'Hospital','fas fa-hospital-alt','hospital',2,1,'2024-05-01 22:22:03','2025-12-07 03:46:30','69354cf60ec37.png'),
(4,21,'مستشفى','fas fa-hospital-alt','مستشفى',2,1,'2024-05-01 22:22:38','2025-12-07 03:48:09','69354d596ede6.png'),
(5,20,'Travel','fas fa-plane','travel',3,1,'2024-05-01 23:19:47','2025-12-07 03:46:21','69354cedc4ff8.png'),
(6,21,'يسافر','fas fa-plane','يسافر',3,1,'2024-05-01 23:20:22','2025-12-07 03:48:02','69354d527a727.png'),
(7,20,'Hotel','fas fa-h-square','hotel',4,1,'2024-05-02 02:20:21','2025-12-07 03:46:12','69354ce4a5998.png'),
(8,21,'الفندق','fas fa-h-square','الفندق',4,1,'2024-05-02 02:21:19','2025-12-07 03:47:53','69354d495e537.png'),
(9,20,'Restaurant','fas fa-utensils','restaurant',5,1,'2024-05-05 20:43:05','2025-12-07 03:46:03','69354cdb52c4a.png'),
(10,21,'مطعم','fas fa-utensils','مطعم',5,1,'2024-05-05 20:43:53','2025-12-07 03:47:38','69354d3acdc74.png'),
(11,20,'Car','fas fa-car-side','car',6,1,'2024-05-05 21:32:25','2025-12-07 03:45:51','69354ccfc9ff3.png'),
(12,21,'أعمال ال','fas fa-car-side','أعمال-ال',6,1,'2024-05-05 21:33:01','2025-12-07 03:47:30','69354d32539c2.png'),
(13,20,'Real Estate','fas fa-vr-cardboard','real-estate',7,1,'2024-05-05 22:45:36','2025-12-07 03:44:54','69354c966fb5d.png'),
(14,21,'العقارات','fas fa-vr-cardboard','العقارات',7,1,'2024-05-05 22:46:09','2025-12-07 03:47:20','69354d286a937.png'),
(15,20,'Gymnasium','fas fa-dumbbell','gymnasium',8,1,'2024-05-06 02:23:44','2025-12-07 03:44:44','69354c8c33a5d.png'),
(16,21,'صالة للألعاب الرياضية','fas fa-dumbbell','صالة-للألعاب-الرياضية',8,1,'2024-05-06 02:24:11','2025-12-07 03:46:48','69354d08100c2.png');
/*!40000 ALTER TABLE `listing_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_contents`
--

DROP TABLE IF EXISTS `listing_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_contents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `listing_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `aminities` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `meta_keyword` longtext DEFAULT NULL,
  `meta_description` longtext DEFAULT NULL,
  `features` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `summary` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_contents`
--

LOCK TABLES `listing_contents` WRITE;
/*!40000 ALTER TABLE `listing_contents` DISABLE KEYS */;
INSERT INTO `listing_contents` VALUES
(1,20,1,1,2,1,1,'Saddle & Sip Saloon','saddle-&-sip-saloon','[\"1\",\"3\",\"5\"]','<p>\"Saddle &amp; Sip Saloon\" is a lively Western-themed establishment nestled in the heart of [imaginary town name]. Stepping through its swinging doors, patrons are transported to an era where cowboys roamed the frontier and camaraderie was as plentiful as the whiskey poured at the bar.</p>\r\n<p>The saloon\'s rustic decor, adorned with weathered wood, flickering lanterns, and vintage cowboy memorabilia, creates an inviting ambiance that welcomes locals and travelers alike. The scent of hearty barbecue and smoky flavors wafts from the kitchen, tempting hungry guests to indulge in the saloon\'s savory fare.</p>\r\n<p>At the center of the saloon stands a polished wooden bar, where skilled bartenders craft signature cocktails alongside pouring pints of local brews and pouring shots of premium spirits. The bar\'s extensive whiskey selection boasts both classic favorites and rare finds, inviting connoisseurs to savor the rich flavors of aged spirits.</p>\r\n<p>Throughout the week, \"Saddle &amp; Sip Saloon\" hosts a variety of events to entertain its patrons. From live country music performances and line dancing nights to spirited karaoke competitions and themed costume parties, there\'s always something happening to keep the saloon buzzing with excitement.</p>\r\n<p>For those seeking a break from the lively atmosphere, the saloon offers cozy nooks and comfortable seating areas where guests can unwind with friends or enjoy a quiet moment alone. Outside, a spacious patio provides the perfect setting to soak up the sunshine and sip on refreshing drinks beneath the open sky.</p>\r\n<p>With its warm hospitality, authentic Western charm, and spirited atmosphere, \"Saddle &amp; Sip Saloon\" stands as a beloved gathering place where memories are made and friendships flourish amidst the spirited revelry of the Wild West.</p>','Second Ave/Kangaroo Rd, Murrumbeena VIC, Australia',NULL,NULL,NULL,'2024-05-01 21:11:40','2025-01-18 21:57:23','Saddle & Sip Saloon is a lively haven blending rustic charm with modern flair. Nestled in the heart of town, this saloon offers handcrafted cocktails, hearty meals, and a warm, welcoming ambiance. Perfect for gatherings or a quiet evening, its vibrant atmosphere and live music make every visit unforgettable. Saddle up and sip your way to great memories!'),
(2,21,1,2,3,2,2,'صالون السرج ورشفة','صالون-السرج-ورشفة','[\"2\",\"4\",\"6\"]','<p>\"صالون السرج ورشفة\" هي مؤسسة حيوية ذات طابع غربي تقع في قلب [اسم المدينة الخيالي]. من خلال أبوابه المتأرجحة، يتم نقل الزبائن إلى عصر كان فيه رعاة البقر يجوبون الحدود وكانت الصداقة الحميمة وفيرة مثل صب الويسكي في البار.</p>\r\n<p>يخلق الديكور الريفي للصالون، المزين بالخشب المتأثر بالعوامل الجوية والفوانيس الوامضة وتذكارات رعاة البقر العتيقة، أجواءً جذابة ترحب بالسكان المحليين والمسافرين على حدٍ سواء. تنبعث رائحة الشواء اللذيذة والنكهات المدخنة من المطبخ، مما يغري الضيوف الجائعين بالانغماس في مأكولات الصالون اللذيذة.</p>\r\n<p>يوجد في وسط الصالون بار خشبي مصقول، حيث يصنع السقاة المهرة الكوكتيلات المميزة جنبًا إلى جنب مع سكب مكاييل من المشروبات المحلية وسكب جرعات من المشروبات الروحية الفاخرة. تتميز تشكيلة الويسكي الواسعة في البار بكل من المفضلات الكلاسيكية والاكتشافات النادرة، مما يدعو الخبراء لتذوق النكهات الغنية للمشروبات الروحية القديمة.</p>\r\n<p>على مدار الأسبوع، يستضيف \"صالون السرج ورشفة\" مجموعة متنوعة من الفعاليات للترفيه عن رواده. من عروض الموسيقى الريفية الحية وليالي الرقص إلى مسابقات الكاريوكي الحماسية وحفلات الأزياء ذات الطابع الخاص، هناك دائمًا شيء ما يحدث لإبقاء الصالون مليئًا بالإثارة.</p>\r\n<p>بالنسبة لأولئك الذين يبحثون عن استراحة من الأجواء المفعمة بالحيوية، يوفر الصالون زوايا مريحة ومناطق جلوس مريحة حيث يمكن للضيوف الاسترخاء مع الأصدقاء أو الاستمتاع بلحظة هادئة بمفردهم. في الخارج، يوفر الفناء الفسيح مكانًا مثاليًا للاستمتاع بأشعة الشمس واحتساء المشروبات المنعشة تحت السماء المفتوحة.</p>\r\n<p>بفضل ضيافته الدافئة وسحره الغربي الأصيل وأجوائه المفعمة بالحيوية، يعد \"Saddle &amp; Sip Saloon\" مكانًا محبوبًا للتجمع حيث يتم صنع الذكريات وتزدهر الصداقات وسط احتفالات الغرب المتوحش المفعمة بالحيوية.</p>','123 شارع المناطق النائية، معبر الكنغر, ملبورن، فيكتوريا 3000، أستراليا',NULL,NULL,NULL,'2024-05-01 21:11:40','2025-01-18 21:57:23','صالون سادل آند سيب هو ملاذ حيوي يجمع بين الطابع الريفي والجاذبية العصرية. يقع في قلب المدينة ويقدم كوكتيلات مُعدة بعناية وأطباق شهية في أجواء دافئة ومرحبة. سواء كنت تخطط لتجمع مع الأصدقاء أو قضاء أمسية هادئة، فإن أجواءه الحيوية والموسيقى الحية تجعل كل زيارة لا تُنسى. استمتع بأوقات رائعة في هذا المكان المميز!'),
(5,20,3,5,2,1,1,'Dreamscapes Travel Agency','dreamscapes-travel-agency','[\"3\",\"14\"]','<p><strong>Dreamscapes Travel Agency: Where Every Journey Begins with a Dream</strong></p>\r\n<p>Welcome to Dreamscapes Travel Agency, your gateway to a world of unforgettable adventures and experiences. At Dreamscapes, we believe that travel is not just about visiting destinations; it\'s about embarking on transformative journeys that enrich your life and leave you with cherished memories that last a lifetime.</p>\r\n<p>Founded with a passion for exploration and a commitment to excellence, Dreamscapes Travel Agency has been fulfilling the travel dreams of discerning adventurers since our inception. Whether you\'re yearning for a relaxing beach getaway, an adrenaline-pumping adventure in the great outdoors, or a cultural immersion in a far-flung destination, we are here to turn your travel dreams into reality.</p>\r\n<p>At the heart of our ethos lies a dedication to personalized service and attention to detail. We understand that no two travelers are alike, and that\'s why we take the time to tailor each itinerary to suit your unique preferences, interests, and budget. From the moment you contact us, our team of experienced travel consultants will work tirelessly to craft a bespoke journey that exceeds your expectations and fulfills your deepest travel desires.</p>\r\n<p>What sets Dreamscapes apart is our unwavering commitment to quality and authenticity. We handpick our partners and suppliers to ensure that every aspect of your trip – from accommodations and transportation to activities and excursions – meets the highest standards of excellence. Whether you\'re staying at a luxury resort, a boutique hotel, or a charming bed and breakfast, rest assured that you\'ll enjoy impeccable service and comfort throughout your stay.</p>\r\n<p>But our dedication to excellence extends beyond logistics; it\'s about creating meaningful connections and unforgettable experiences that resonate with you long after your journey has ended. Whether you\'re savoring a gourmet meal prepared by a local chef, exploring hidden gems off the beaten path, or immersing yourself in the vibrant culture of a new destination, we strive to create moments of magic that will leave you inspired and invigorated.</p>\r\n<p>At Dreamscapes Travel Agency, we believe that travel has the power to transform lives and broaden horizons. That\'s why we\'re committed to sustainable and responsible tourism practices that preserve the beauty and integrity of the destinations we visit. From supporting local communities and initiatives to minimizing our environmental footprint, we\'re dedicated to making a positive impact wherever we go.</p>\r\n<p>So whether you\'re planning your honeymoon, a family vacation, a solo adventure, or a group getaway, let Dreamscapes Travel Agency be your trusted partner in exploration. With our passion for travel, dedication to excellence, and commitment to personalized service, we\'ll make sure that every journey you embark on is nothing short of extraordinary.</p>\r\n<p>Dream big. Travel far. Explore with Dreamscapes Travel Agency.</p>','123 Collins Street, Melbourne VIC 3000, Australia',NULL,NULL,NULL,'2024-05-01 23:18:29','2025-01-19 00:08:46','Dreamscapes Travel Agency specializes in creating unforgettable travel experiences tailored to your needs. Whether it’s a dream vacation, corporate travel, or a weekend getaway, we provide personalized itineraries, affordable packages, and exceptional service. From flights and accommodations to guided tours, Ulka ensures every journey is seamless and memorable. Discover the world with Ulka Travel Agency—your trusted travel companion!'),
(6,21,3,6,3,2,2,'وكالة دريم سكيبس للسفريات','وكالة-دريم-سكيبس-للسفريات','[\"9\",\"11\",\"13\"]','<p>وكالة Dreamscapes للسفر: حيث تبدأ كل رحلة بحلم</p>\r\n<p>مرحبًا بك في وكالة سفريات Dreamscapes، بوابتك إلى عالم من المغامرات والتجارب التي لا تُنسى. في Dreamscapes، نؤمن بأن السفر لا يقتصر فقط على زيارة الوجهات؛ يتعلق الأمر بالشروع في رحلات تحويلية تثري حياتك وتترك لك ذكريات عزيزة تدوم مدى الحياة.</p>\r\n<p>تأسست شركة Dreamscapes Travel Agency بشغف للاستكشاف والالتزام بالتميز، وهي تحقق أحلام السفر للمغامرين المميزين منذ بدايتها. سواء كنت تتوق إلى قضاء عطلة مريحة على الشاطئ، أو مغامرة تضخ الأدرينالين في الهواء الطلق، أو الانغماس الثقافي في وجهة بعيدة، فنحن هنا لتحويل أحلام السفر الخاصة بك إلى حقيقة.</p>\r\n<p>في قلب روحنا يكمن التفاني في الخدمة الشخصية والاهتمام بالتفاصيل. نحن ندرك أنه لا يوجد مسافران متشابهان، ولهذا السبب نأخذ الوقت الكافي لتخصيص كل خط سير ليناسب تفضيلاتك واهتماماتك وميزانيتك الفريدة. منذ لحظة اتصالك بنا، سيعمل فريقنا من مستشاري السفر ذوي الخبرة بلا كلل لصياغة رحلة مخصصة تتجاوز توقعاتك وتلبي رغباتك العميقة في السفر.</p>\r\n<p>ما يميز Dreamscapes عن الآخرين هو التزامنا الثابت بالجودة والأصالة. نحن نختار شركائنا وموردينا بعناية للتأكد من أن كل جانب من جوانب رحلتك - بدءًا من الإقامة والنقل إلى الأنشطة والرحلات - يلبي أعلى معايير التميز. سواء كنت تقيم في منتجع فاخر، أو فندق بوتيكي، أو فندق مبيت وإفطار ساحر، كن مطمئنًا أنك ستستمتع بخدمة وراحة لا تشوبها شائبة طوال فترة إقامتك.</p>\r\n<p>وكالة Dreamscapes للسفر: حيث تبدأ كل رحلة بحلم</p>\r\n<p>مرحبًا بك في وكالة سفريات Dreamscapes، بوابتك إلى عالم من المغامرات والتجارب التي لا تُنسى. في Dreamscapes، نؤمن بأن السفر لا يقتصر فقط على زيارة الوجهات؛ يتعلق الأمر بالشروع في رحلات تحويلية تثري حياتك وتترك لك ذكريات عزيزة تدوم مدى الحياة.</p>\r\n<p>تأسست شركة Dreamscapes Travel Agency بشغف للاستكشاف والالتزام بالتميز، وهي تحقق أحلام السفر للمغامرين المميزين منذ بدايتها. سواء كنت تتوق إلى قضاء عطلة مريحة على الشاطئ، أو مغامرة تضخ الأدرينالين في الهواء الطلق، أو الانغماس الثقافي في وجهة بعيدة، فنحن هنا لتحويل أحلام السفر الخاصة بك إلى حقيقة.</p>\r\n<p>في قلب روحنا يكمن التفاني في الخدمة الشخصية والاهتمام بالتفاصيل. نحن ندرك أنه لا يوجد مسافران متشابهان، ولهذا السبب نأخذ الوقت الكافي لتخصيص كل خط سير ليناسب تفضيلاتك واهتماماتك وميزانيتك الفريدة. منذ لحظة اتصالك بنا، سيعمل فريقنا من مستشاري السفر ذوي الخبرة بلا كلل لصياغة رحلة مخصصة تتجاوز توقعاتك وتلبي رغباتك العميقة في السفر.</p>\r\n<p>ما يميز Dreamscapes عن الآخرين هو التزامنا الثابت بالجودة والأصالة. نحن نختار شركائنا وموردينا بعناية للتأكد من أن كل جانب من جوانب رحلتك - بدءًا من الإقامة والنقل إلى الأنشطة والرحلات - يلبي أعلى معايير التميز. سواء كنت تقيم في منتجع فاخر، أو فندق بوتيكي، أو فندق مبيت وإفطار ساحر، كن مطمئنًا أنك ستستمتع بخدمة وراحة لا تشوبها شائبة طوال فترة إقامتك.</p>','وكالة دريم سكيبس للسفريات جناح 301، برج كولينز 123 شارع كولينز ملبورن، فكتوريا 3000 أستراليا',NULL,NULL,NULL,'2024-05-01 23:18:29','2025-01-18 21:59:55','تتخصص وكالة أولكا للسفر في خلق تجارب سفر لا تُنسى مصممة حسب احتياجاتك. سواء كانت عطلة حلم أو سفر تجاري أو عطلة نهاية أسبوع، نحن نقدم مسارات مخصصة، باقات بأسعار معقولة، وخدمة استثنائية. من الرحلات الجوية والإقامة إلى الجولات السياحية، تضمن أولكا أن تكون كل رحلة سلسة ولا تُنسى. اكتشف العالم مع وكالة أولكا للسفر - رفيقك الموثوق في السفر!'),
(7,20,4,7,6,NULL,5,'Tranquil Haven Hotel','tranquil-haven-hotel','[\"1\",\"3\"]','<p>Nestled along the picturesque shores of Cox\'s Bazar, Bangladesh, Tranquil Haven Hotel stands as an oasis of serenity amidst the vibrant coastal ambiance. Enveloped by the soothing sounds of the ocean waves and surrounded by breathtaking natural beauty, this luxurious haven offers a sanctuary for travelers seeking relaxation and rejuvenation.</p>\r\n<p>As you step into Tranquil Haven Hotel, you are greeted by an atmosphere of understated elegance and warm hospitality. The hotel\'s contemporary design seamlessly blends with traditional Bangladeshi aesthetics, creating a harmonious environment that instantly puts guests at ease.</p>\r\n<p>Accommodations at Tranquil Haven Hotel are designed to provide the utmost comfort and luxury. Each room and suite is thoughtfully appointed with modern amenities and tasteful décor, offering a tranquil retreat after a day of exploration. From stunning ocean views to plush bedding and spacious living areas, every detail has been carefully curated to ensure a memorable stay.</p>\r\n<p>Guests can indulge their senses and nourish their bodies at the hotel\'s spa and wellness center. Offering an array of rejuvenating treatments and therapies, including massages, facials, and yoga sessions, the spa provides a sanctuary for relaxation and renewal.</p>\r\n<p>For those seeking culinary delights, Tranquil Haven Hotel boasts a fine dining restaurant that tantalizes the taste buds with a diverse menu of local and international cuisine. Using only the freshest ingredients, the hotel\'s talented chefs create culinary masterpieces that satisfy even the most discerning palate.</p>\r\n<p>Beyond the comforts of the hotel, guests can explore the wonders of Cox\'s Bazar and its surrounding areas. From pristine beaches and lush hills to vibrant markets and cultural landmarks, there is no shortage of experiences to discover.</p>\r\n<p>Whether you are seeking a peaceful escape, a romantic getaway, or a memorable family vacation, Tranquil Haven Hotel invites you to immerse yourself in luxury and tranquility amidst the beauty of Cox\'s Bazar. Experience the essence of Bangladeshi hospitality at its finest and create unforgettable memories that will last a lifetime.</p>','Hotel Ocean View, Hotel Motel Zone, Cox\'s Bazar, Chittagong Division, Bangladesh',NULL,NULL,NULL,'2024-05-02 02:33:34','2025-01-18 22:00:52','Tranquil Haven Hotel offers a serene retreat with luxurious accommodations and exceptional service. Nestled in a peaceful setting, it provides the perfect escape for relaxation and rejuvenation. Whether you’re here for a romantic getaway, a family vacation, or a business trip, Tranquil Haven promises an unforgettable experience with top-notch amenities and a welcoming atmosphere.'),
(8,21,4,8,7,NULL,6,'فندق ترانكويل هافن','فندق-ترانكويل-هافن','[\"2\",\"6\",\"13\"]','<div class=\"flex-1 overflow-hidden\">\r\n<div class=\"react-scroll-to-bottom--css-vawqt-79elbk h-full\">\r\n<div class=\"react-scroll-to-bottom--css-vawqt-1n7m0yu\">\r\n<div>\r\n<div class=\"flex flex-col text-sm pb-9\">\r\n<div class=\"w-full text-token-text-primary\">\r\n<div class=\"px-4 py-2 justify-center text-base md:gap-6 m-auto\">\r\n<div class=\"flex flex-1 text-base mx-auto gap-3 juice:gap-4 juice:md:gap-6 md:px-5 lg:px-1 xl:px-5 md:max-w-3xl lg:max-w-[40rem] xl:max-w-[48rem]\">\r\n<div class=\"relative flex w-full min-w-0 flex-col agent-turn\">\r\n<div class=\"flex-col gap-1 md:gap-3\">\r\n<div class=\"flex flex-grow flex-col max-w-full\">\r\n<div class=\"min-h-[20px] text-message flex flex-col items-start gap-3 whitespace-pre-wrap break-words [.text-message+&amp;]:mt-5 overflow-x-auto\">\r\n<div class=\"markdown prose w-full break-words dark:prose-invert dark\">\r\n<p>تقع فندق Tranquil Haven على طول شواطئ كوكس بازار الخلابة في بنغلاديش، حيث يقف كواحة للسكينة بين أجواء الساحل النابضة بالحياة. محاطًا بأصوات الأمواج الهادئة للبحر ومحاطًا بجمال الطبيعة الساحرة، يوفر هذا النزل الفاخر ملاذًا للمسافرين الذين يبحثون عن الاسترخاء والتجديد.</p>\r\n<p>عند دخولك إلى فندق Tranquil Haven، يُرحب بك بأجواء من الأناقة المتفائلة والضيافة الدافئة. تمزج التصميم العصري للفندق بسلاسة مع الجماليات التقليدية البنغلاديشية، مما يخلق بيئة متناغمة تضع الضيوف في راحة تامة.</p>\r\n<p>تم تصميم الإقامة في فندق Tranquil Haven لتوفير أقصى درجات الراحة والفخامة. تم تجهيز كل غرفة وجناح بعناية فائقة مع وسائل الراحة الحديثة والديكور الذوق، مما يوفر ملاذًا هادئًا بعد يوم من الاستكشاف. من إطلالات البحر الرائعة إلى الفراش الفاخر والمساحات المعيشية الواسعة، تم ترتيب كل التفاصيل بعناية لضمان إقامة لا تُنسى.</p>\r\n<p>يمكن للضيوف تدليل حواسهم وتغذية أجسادهم في مركز السبا والعافية في الفندق. يقدم المركز مجموعة من العلاجات والجلسات المتجددة بما في ذلك التدليك والتقشير وجلسات اليوغا، مما يوفر ملاذًا للراحة والتجديد.</p>\r\n<p>لمن يبحثون عن النكهات الشهية، يفتخر فندق Tranquil Haven بمطعم يقدم أطباقًا فاخرة من المأكولات المحلية والعالمية. باستخدام فقط أجود المكونات، يقوم الطهاة الموهوبون بإعداد أطباق تلبي حتى أرقى الأذواق.</p>\r\n<p>بعيدًا عن راحة الفندق، يمكن للضيوف استكشاف عجائب كوكس بازار ومناطقها المحيطة. من الشواطئ النقية والتلال الخضراء إلى الأسواق الحيوية والمعالم الثقافية، لا يوجد نقص في التجارب التي يمكن اكتشافها.</p>\r\n<p>سواء كنت تبحث عن الهروب السلمي، أو عطلة رومانسية، أو عطلة عائلية لا تُنسى، يدعوك فندق Tranquil Haven لغوص في الفخامة والهدوء بين جمال كوكس بازار. عش تجربة جوهر الضيافة البنغلاديشية على أفضل وجه وخلق ذكريات لا تُنسى تدوم مدى الحيا</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"pr-2 lg:pr-0\"> </div>\r\n</div>\r\n<div class=\"absolute\">\r\n<div class=\"flex w-full gap-2 items-center justify-center\"> </div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"w-full pt-2 md:pt-0 dark:border-white/20 md:border-transparent md:dark:border-transparent md:w-[calc(100%-.5rem)] juice:w-full\">\r\n<div class=\"relative flex h-full max-w-full flex-1 flex-col\">\r\n<div class=\"absolute bottom-full left-0 right-0\"> </div>\r\n<div class=\"flex w-full items-center\"> </div>\r\n</div>\r\n</div>','فندق ترانكويل هافن، طريق أوشن فيو، كالاتالي، شاطئ كولاتولي، كوكس بازار، قسم شيتاغونغ، بنغلاديش، 4700',NULL,NULL,NULL,'2024-05-02 02:33:34','2025-01-18 22:00:52','فندق ترانكيل هافن يقدم ملاذًا هادئًا مع أماكن إقامة فاخرة وخدمة استثنائية. يقع في بيئة هادئة، ويوفر الهروب المثالي للاسترخاء والتجديد. سواء كنت هنا لقضاء عطلة رومانسية، أو عطلة عائلية، أو رحلة عمل، يعد فندق ترانكيل هافن بتقديم تجربة لا تُنسى مع أفضل وسائل الراحة وأجواء ترحيبية.'),
(9,20,5,9,8,NULL,7,'Feast Haven Restaurant','feast-haven-restaurant','[\"5\",\"8\",\"10\",\"14\",\"17\"]','<p>Nestled amidst the breathtaking landscapes of Skardu, Pakistan, FeastHaven Restaurant stands as a culinary oasis, beckoning travelers and locals alike to indulge in a gastronomic journey like no other. Perched along the scenic Gilgit-Baltistan Road, this culinary gem offers a haven where exquisite flavors, warm hospitality, and stunning vistas converge to create unforgettable dining experiences.</p>\r\n<p>As you step into FeastHaven, you\'re greeted by an ambiance that seamlessly blends rustic charm with modern elegance. The interior decor exudes warmth, with earthy tones, intricate woodwork, and ambient lighting, evoking a sense of comfort and relaxation. Whether you\'re seeking a romantic dinner for two, a lively gathering with friends, or a celebratory feast with family, the restaurant\'s inviting atmosphere sets the stage for memorable moments.</p>\r\n<p>At the heart of FeastHaven lies its culinary philosophy – a dedication to showcasing the rich tapestry of Pakistani cuisine while embracing global influences. The menu, curated by skilled chefs, celebrates the region\'s diverse culinary heritage, offering a tantalizing array of dishes crafted from the finest locally sourced ingredients. From aromatic biryanis and succulent kebabs to fragrant curries and delicate desserts, each dish is a culinary masterpiece, bursting with flavors and spices that dance on the palate.</p>\r\n<p>Beyond its delectable fare, FeastHaven prides itself on its commitment to exceptional service. The attentive staff, guided by a passion for hospitality, ensures that every guest\'s needs are met with warmth and efficiency. Whether you\'re a first-time visitor or a regular patron, you\'ll be treated to personalized attention and a dining experience that exceeds expectations.</p>\r\n<p>For those seeking a truly immersive culinary adventure, FeastHaven offers a range of amenities to enhance the dining experience. Whether it\'s alfresco dining on the terrace, private gatherings in secluded dining rooms, or live music performances to enliven the evenings, there\'s something to delight every palate and preference.</p>\r\n<p>In essence, FeastHaven Restaurant is more than just a dining destination – it\'s a sanctuary for food lovers, a place where flavors come alive, and memories are made against the backdrop of Skardu\'s majestic beauty. So come, embark on a culinary voyage with us, and discover why FeastHaven is not just a restaurant but an experience to savor and cherish.</p>','FeastHaven Restaurant Gilgit-Baltistan Road, Skardu 16100, Gilgit-Baltistan, Pakistan',NULL,NULL,NULL,'2024-05-05 20:59:20','2025-01-18 22:02:00','Feast Haven Restaurant offers a delightful dining experience with a wide variety of delicious dishes, expertly prepared to satisfy every palate. Whether you\'re enjoying a casual meal with friends, a family gathering, or a special celebration, Feast Haven provides a warm, welcoming atmosphere with exceptional service and flavorful cuisine. Indulge in a feast like no other at Feast Haven Restaurant.'),
(10,21,5,10,9,NULL,8,'مطعم فيست هيفن','مطعم-فيست-هيفن','[\"2\",\"4\",\"18\"]','<p>يقع مطعم وسط المناظر الطبيعية الخلابة في سكاردو بباكستان، ويعد بمثابة واحة للطهي، حيث يدعو المسافرين والسكان المحليين على حدٍ سواء للانغماس في رحلة تذوق الطعام لا مثيل لها. تقع جوهرة الطهي هذه على طول طريق جيلجيت-بالتستان الخلاب، وتوفر ملاذًا حيث تتلاقى النكهات الرائعة وكرم الضيافة والمناظر الخلابة لخلق تجارب طعام لا تُنسى.</p>\r\n<p>عند دخولك إلى FeastHaven، ستستقبلك أجواء تمزج بسلاسة بين السحر الريفي والأناقة العصرية. ينضح الديكور الداخلي بالدفء مع الألوان الترابية والأعمال الخشبية المعقدة والإضاءة المحيطة، مما يثير الشعور بالراحة والاسترخاء. سواء كنت تبحث عن عشاء رومانسي لشخصين، أو تجمع حيوي مع الأصدقاء، أو وليمة احتفالية مع العائلة، فإن أجواء المطعم الجذابة تمهد الطريق للحظات لا تنسى.</p>\r\n<p>في قلب FeastHaven تكمن فلسفته الطهوية - التفاني في عرض النسيج الغني للمطبخ الباكستاني مع احتضان التأثيرات العالمية. تحتفل القائمة، التي يرعاها طهاة ماهرون، بتراث الطهي المتنوع في المنطقة، وتقدم مجموعة رائعة من الأطباق المحضرة من أجود المكونات المحلية. من البرياني العطري والكباب اللذيذ إلى الكاري العطري والحلويات اللذيذة، كل طبق عبارة عن تحفة طهي، مليئة بالنكهات والتوابل التي تتراقص على الحنك.</p>\r\n<p>بالإضافة إلى أجرته اللذيذة، يفتخر FeastHaven بالتزامه بتقديم خدمة استثنائية. يضمن الموظفون اليقظون، الذين يسترشدون بشغف الضيافة، تلبية احتياجات كل ضيف بدفء وكفاءة. سواء كنت زائرًا لأول مرة أو زائرًا منتظمًا، فسوف تحظى باهتمام شخصي وتجربة طعام تتجاوز التوقعات.</p>\r\n<p>بالنسبة لأولئك الذين يبحثون عن مغامرة طهي غامرة حقًا، يقدم FeastHaven مجموعة من وسائل الراحة لتعزيز تجربة تناول الطعام. سواء كان تناول الطعام في الهواء الطلق على الشرفة، أو التجمعات الخاصة في غرف الطعام المنعزلة، أو العروض الموسيقية الحية لإضفاء الحيوية على الأمسيات، هناك ما يسعد كل الأذواق والتفضيلات.</p>\r\n<p>في جوهره، يعد مطعم FeastHaven أكثر من مجرد وجهة لتناول الطعام - فهو ملاذ لمحبي الطعام، ومكان تنبض فيه النكهات بالحياة، وتصنع الذكريات على خلفية جمال سكاردو المهيب. لذا تعال، وانطلق معنا في رحلة طهي، واكتشف لماذا لا يعد FeastHaven مجرد مطعم، بل تجربة تستحق التذوق والاعتزاز بها.</p>','مطعم FeastHaven طريق جيلجيت-بالتستان، سكاردو 16100، جيلجيت-بالتستان، باكستان',NULL,NULL,NULL,'2024-05-05 20:59:20','2025-01-18 22:02:00','مطعم فيست هافن يقدم تجربة طعام لذيذة مع مجموعة واسعة من الأطباق الشهية، التي تم تحضيرها بعناية لإرضاء جميع الأذواق. سواء كنت تستمتع بوجبة غير رسمية مع الأصدقاء، أو تجمع عائلي، أو احتفال خاص، يوفر مطعم فيست هافن أجواء دافئة وترحيبية مع خدمة استثنائية ومأكولات لذيذة. استمتع بوجبة لا مثيل لها في مطعم فيست هافن.'),
(11,20,6,11,10,5,9,'Precision Performance Motors','precision-performance-motors','[\"3\",\"5\",\"8\",\"10\",\"15\"]','<p>Precision Performance Motors is more than just a car dealership; it\'s an automotive oasis nestled in the heart of bustling Los Angeles, California. With a legacy of excellence and a commitment to unparalleled customer service, Precision Performance Motors stands as a beacon of automotive refinement and sophistication.</p>\r\n<p>From the moment you step onto our pristine showroom floor at 1234 Luxe Avenue in Beverly Hills, you\'re enveloped in an atmosphere of luxury and elegance. Every detail, from the sleek modern design to the meticulous placement of each vehicle, is crafted to evoke a sense of awe and admiration.</p>\r\n<p>As you explore our extensive inventory of premium automobiles, ranging from high-performance sports cars to luxurious sedans, you\'ll be guided by our team of knowledgeable and passionate automotive experts. With a deep understanding of the latest automotive trends and technologies, our staff is dedicated to helping you find the perfect vehicle that not only meets but exceeds your expectations.</p>\r\n<p>At Precision Performance Motors, we believe that the car-buying experience should be as enjoyable as it is seamless. That\'s why we offer a comprehensive suite of amenities designed to cater to your every need. Whether you\'re sipping on a freshly brewed cup of coffee in our comfortable lounge area, browsing the internet with complimentary Wi-Fi, or enjoying a complimentary car wash with your service appointment, every aspect of your visit is carefully curated to ensure your complete satisfaction.</p>\r\n<p>But our commitment to excellence doesn\'t end when you drive off the lot. With our state-of-the-art service center staffed by factory-trained technicians, we\'re here to provide you with the highest quality maintenance and repair services to keep your vehicle running smoothly for years to come. And with amenities such as loaner cars and shuttle service, we make it easy to keep up with your busy schedule while your vehicle is in our care.</p>\r\n<p>At Precision Performance Motors, we don\'t just sell cars – we cultivate experiences. Whether you\'re a seasoned automotive enthusiast or a first-time buyer, we invite you to discover the unparalleled luxury and service that define the Precision Performance Motors experience. Visit us today and let us help you embark on the journey of a lifetime behind the wheel of your dream car.</p>','Los Angeles Performance Motors, West Manchester Avenue, Los Angeles, CA, USA',NULL,NULL,NULL,'2024-05-05 21:47:53','2025-01-18 22:02:53','Precision Performance Motors specializes in high-performance automotive services, offering top-quality repairs, maintenance, and upgrades. Whether you\'re looking to enhance your vehicle\'s performance, restore its condition, or keep it running smoothly, we provide expert solutions tailored to your needs. Trust Precision Performance Motors for unmatched craftsmanship and superior service to keep your vehicle performing at its best.'),
(12,21,6,12,11,6,10,'محركات الأداء الدقيقة','محركات-الأداء-الدقيقة','[\"2\",\"6\",\"18\"]','<p>إن شركة محركات الأداء بالدقةهي أكثر من مجرد وكالة لبيع السيارات؛ إنها واحة سيارات تقع في قلب مدينة لوس أنجلوس الصاخبة، كاليفورنيا. بفضل تراثها من التميز والالتزام بخدمة العملاء التي لا مثيل لها، تقف شركة محركات الأداء بالدقةكمنارة لصقل السيارات وتطورها.</p>\r\n<p>منذ اللحظة التي تخطو فيها إلى صالة العرض الأصلية في 1234 Luxe Avenue في بيفرلي هيلز، ستجد نفسك محاطًا بجو من الفخامة والأناقة. تم تصميم كل التفاصيل، بدءًا من التصميم العصري الأنيق وحتى الموضع الدقيق لكل مركبة، لإثارة شعور بالرهبة والإعجاب.</p>\r\n<p>بينما تستكشف مخزوننا الكبير من السيارات الفاخرة، بدءًا من السيارات الرياضية عالية الأداء إلى سيارات السيدان الفاخرة، سيتم إرشادك من قبل فريقنا من خبراء السيارات ذوي المعرفة والشغف. بفضل الفهم العميق لأحدث اتجاهات وتقنيات السيارات، فإن موظفينا ملتزمون بمساعدتك في العثور على السيارة المثالية التي لا تلبي توقعاتك فحسب، بل تتجاوزها أيضًا.</p>\r\n<p>في شركة Precision Performance Motors، نؤمن بأن تجربة شراء السيارة يجب أن تكون ممتعة بقدر ما هي سلسة. ولهذا السبب نقدم مجموعة شاملة من وسائل الراحة المصممة لتلبية جميع احتياجاتك. سواء كنت تحتسي فنجانًا من القهوة الطازجة في منطقة الصالة المريحة لدينا، أو تتصفح الإنترنت باستخدام خدمة الواي فاي المجانية، أو تستمتع بغسيل السيارة مجانًا مع موعد الخدمة الخاص بك، فقد تم تنسيق كل جانب من جوانب زيارتك بعناية لضمان حصولك على خدمات متكاملة إشباع.</p>\r\n<p>لكن التزامنا بالتميز لا ينتهي عندما تقود سيارتك خارج المكان. من خلال مركز الخدمة المتطور الخاص بنا والذي يضم فنيين مدربين في المصنع، نحن هنا لنقدم لك خدمات الصيانة والإصلاح بأعلى مستويات الجودة للحفاظ على تشغيل سيارتك بسلاسة لسنوات قادمة. ومع وسائل الراحة مثل السيارات المستعارة وخدمة النقل المكوكية، فإننا نجعل من السهل مواكبة جدول أعمالك المزدحم أثناء وجود سيارتك في رعايتنا.</p>\r\n<p>في شركة Precision Performance Motors، نحن لا نبيع السيارات فحسب، بل ننمي الخبرات. سواء كنت من عشاق السيارات المتمرسين أو مشتريًا لأول مرة، فإننا ندعوك لاكتشاف الفخامة والخدمة التي لا مثيل لها والتي تحدد تجربة Precision Performance Motors. تفضل بزيارتنا اليوم ودعنا نساعدك على الانطلاق في رحلة العمر خلف عجلة قيادة سيارة أحلامك.</p>','شركة بريسيشن بيرفورمانس موتورز 1234 لوكس أفينيو، جناح 200، بيفرلي هيلز، لوس أنجلوس، كاليفورنيا 90001، الولايات المتحدة.',NULL,NULL,NULL,'2024-05-05 21:47:53','2025-01-18 22:02:53','براسينجن بيرفورمانس موتورز متخصص في خدمات السيارات عالية الأداء، حيث يقدم إصلاحات وصيانة وترقيات عالية الجودة. سواء كنت ترغب في تعزيز أداء سيارتك، أو استعادتها إلى حالتها الأصلية، أو الحفاظ على سيرها بسلاسة، نقدم حلولاً خبيره مصممة وفقًا لاحتياجاتك. ثق في براسينجن بيرفورمانس موتورز للحصول على حرفية لا مثيل لها وخدمة ممتازة للحفاظ على أداء سيارتك في أفضل حالاتها.'),
(13,20,7,13,10,7,11,'Blue Sky Realty Group','blue-sky-realty-group','[\"8\",\"10\",\"17\"]','<p><strong>Blue Sky Estates: Where Serenity Meets Luxury in Jacksonville</strong></p>\r\n<p>Welcome to Blue Sky Estates, an exquisite residential oasis nestled in the heart of Jacksonville, Florida. Poised majestically along the tranquil shores of the St. Johns River, this prestigious community redefines luxury living with its breathtaking vistas, unparalleled amenities, and unrivaled attention to detail.</p>\r\n<p><strong>Location and Accessibility</strong></p>\r\n<p>Conveniently located at 789 Serenity Drive, Blue Sky Estates offers residents the perfect balance of seclusion and accessibility. Situated in the prestigious Mandarin neighborhood of Jacksonville, this exclusive enclave provides easy access to major highways, premier shopping destinations, top-rated schools, and a myriad of cultural and recreational attractions. With downtown Jacksonville just a short drive away, residents enjoy the convenience of urban amenities while basking in the serenity of riverside living.</p>\r\n<p><strong>Scenic Views and Natural Beauty</strong></p>\r\n<p>Prepare to be captivated by the natural beauty that surrounds Blue Sky Estates. Set against a backdrop of lush greenery and the shimmering waters of the St. Johns River, every home in this esteemed community boasts panoramic views that showcase the stunning Florida landscape in all its glory. Whether you\'re savoring a morning cup of coffee on your private terrace or unwinding with a glass of wine as the sun sets over the river, the awe-inspiring vistas of Blue Sky Estates will leave you breathless.</p>\r\n<p><strong>Luxurious Residences</strong></p>\r\n<p>Step inside the elegant residences of Blue Sky Estates and experience a world of refined sophistication and timeless charm. Crafted with meticulous attention to detail and adorned with upscale finishes, each home exudes an aura of luxury and exclusivity. From expansive floor-to-ceiling windows that flood the interiors with natural light to gourmet kitchens equipped with state-of-the-art appliances and custom cabinetry, every aspect of these residences reflects the highest standards of quality and craftsmanship. With spacious layouts, designer fixtures, and sumptuous living spaces, Blue Sky Estates offers the epitome of modern luxury living.</p>\r\n<p><strong>World-Class Amenities</strong></p>\r\n<p>At Blue Sky Estates, luxury knows no bounds. Indulge in a wealth of world-class amenities designed to elevate every aspect of your lifestyle. Lounge by the sparkling infinity pool and soak up the Florida sun as you admire the panoramic views of the river. Stay active and energized at the fully-equipped fitness center, where state-of-the-art equipment and personalized training services await. Host unforgettable gatherings in the elegant clubhouse, complete with a catering kitchen and expansive entertainment spaces. From the meticulously landscaped gardens to the serene walking trails that wind through the community, every amenity at Blue Sky Estates is thoughtfully curated to enhance your sense of well-being and tranquility.</p>\r\n<p><strong>Community and Lifestyle</strong></p>\r\n<p>More than just a place to live, Blue Sky Estates is a vibrant community where neighbors become friends and every day is filled with possibility. Whether you\'re participating in a yoga class on the riverfront lawn or joining fellow residents for a sunset cocktail party at the outdoor terrace, you\'ll find endless opportunities to connect, relax, and unwind. With a full calendar of social events, recreational activities, and cultural experiences, life at Blue Sky Estates is anything but ordinary. Discover the true meaning of luxury living and experience the unparalleled lifestyle that awaits at this exclusive riverside retreat.</p>\r\n<p><strong>Conclusion</strong></p>\r\n<p>In conclusion, Blue Sky Estates represents the pinnacle of luxury living in Jacksonville, Florida. From its idyllic riverside location to its world-class amenities and luxurious residences, every aspect of this esteemed community is designed to exceed your expectations and elevate your lifestyle. Whether you\'re seeking a peaceful retreat from the hustle and bustle of city life or a vibrant community where every day feels like a vacation, Blue Sky Estates offers the perfect blend of serenity, sophistication, and style. Come home to Blue Sky Estates and discover the ultimate in riverside luxury living.</p>','Blue Sky Estates 789 Serenity Drive Jacksonville, FL 32256 United States',NULL,NULL,NULL,'2024-05-05 23:06:52','2025-01-18 22:03:44','Blue Sky Realty Group is a trusted name in real estate, offering a wide range of properties for sale and rent. Whether you\'re looking for your dream home, a commercial property, or an investment opportunity, we provide expert guidance and personalized service to help you make informed decisions. Experience seamless transactions and exceptional customer care with Blue Sky Realty Group.'),
(14,21,7,14,11,8,12,'مجموعة بلو سكاي العقارية','مجموعة-بلو-سكاي-العقارية','[\"2\",\"6\",\"18\"]','<p><strong>بلو سكاي إستيتس: حيث يلتقي الصفاء بالفخامة في جاكسونفيل</strong></p>\r\n<p>مرحبًا بكم في Blue Sky Estates، وهي واحة سكنية رائعة تقع في قلب مدينة جاكسونفيل بولاية فلوريدا. يقع هذا المجتمع المرموق بشكل مهيب على طول الشواطئ الهادئة لنهر سانت جونز، ويعيد تعريف الحياة الفاخرة بمناظره الخلابة ووسائل الراحة التي لا مثيل لها والاهتمام الذي لا مثيل له بالتفاصيل.</p>\r\n<p><strong>الموقع وسهولة الوصول</strong></p>\r\n<p>يقع موقع مناسب في 789 Serenity Drive، ويوفر للمقيمين التوازن المثالي بين العزلة وسهولة الوصول. يقع هذا الجيب الحصري في حي ماندارين المرموق في جاكسونفيل، ويوفر سهولة الوصول إلى الطرق السريعة الرئيسية ووجهات التسوق الرئيسية والمدارس ذات التصنيف العالي وعدد لا يحصى من المعالم الثقافية والترفيهية. مع وجود وسط مدينة جاكسونفيل على بعد مسافة قصيرة بالسيارة، يستمتع السكان براحة المرافق الحضرية بينما يستمتعون بهدوء الحياة على ضفاف النهر.</p>\r\n<p><strong>مناظر خلابة وجمال طبيعي</strong></p>\r\n<p>استعد لتنبهر بالجمال الطبيعي الذي يحيط بـ Blue Sky Estates. يقع على خلفية من المساحات الخضراء المورقة والمياه المتلألئة لنهر سانت جونز، ويتميز كل منزل في هذا المجتمع الموقر بإطلالات بانورامية تعرض المناظر الطبيعية المذهلة في فلوريدا بكل مجدها. سواء كنت تتذوق فنجانًا من القهوة في الصباح على شرفتك الخاصة أو تسترخي مع كأس من النبيذ أثناء غروب الشمس فوق النهر، فإن المناظر المذهلة في Blue Sky Estates ستجعلك تحبس الأنفاس.</p>\r\n<p><strong>مساكن فاخرة</strong></p>\r\n<p>ادخل إلى المساكن الأنيقة في Blue Sky Estates واستمتع بتجربة عالم من الرقي الراقي والسحر الخالد. تم تصميم كل منزل بعناية فائقة بالتفاصيل ومزين بتشطيبات راقية، وهو ينضح بهالة من الفخامة والتفرد. بدءًا من النوافذ الواسعة الممتدة من الأرض حتى السقف والتي تغمر المساحات الداخلية بالضوء الطبيعي إلى مطابخ الذواقة المجهزة بأحدث الأجهزة والخزائن المخصصة، يعكس كل جانب من جوانب هذه المساكن أعلى معايير الجودة والحرفية. بفضل التصميمات الفسيحة والتجهيزات المصممة ومساحات المعيشة الفخمة، تقدم Blue Sky Estates مثالًا للمعيشة الفاخرة الحديثة.</p>\r\n<p><strong>وسائل الراحة ذات المستوى العالمي</strong></p>\r\n<p>في بلو سكاي إستيتس، الفخامة لا تعرف حدودًا. انغمس في مجموعة كبيرة من وسائل الراحة ذات المستوى العالمي المصممة للارتقاء بكل جانب من جوانب نمط حياتك. استرخ بجانب المسبح اللامتناهي المتلألئ واستمتع بأشعة شمس فلوريدا بينما تستمتع بالمناظر البانورامية للنهر. حافظ على نشاطك وحيويتك في مركز اللياقة البدنية المجهز بالكامل، حيث تنتظرك أحدث المعدات وخدمات التدريب الشخصية. يمكنك استضافة تجمعات لا تُنسى في النادي الأنيق المجهز بمطبخ لتقديم الطعام ومساحات ترفيهية واسعة. بدءًا من الحدائق ذات المناظر الطبيعية الدقيقة وحتى مسارات المشي الهادئة التي تمر عبر المجتمع، تم تصميم كل وسائل الراحة في Blue Sky Estates بعناية لتعزيز إحساسك بالرفاهية والهدوء.</p>\r\n<p><strong>المجتمع وأسلوب الحياة</strong></p>\r\n<p>أكثر من مجرد مكان للعيش فيه، Blue Sky Estates هو مجتمع نابض بالحياة حيث يصبح الجيران أصدقاء وكل يوم مليء بالاحتمالات. سواء كنت تشارك في دروس اليوغا في الحديقة المطلة على النهر أو تنضم إلى زملائك المقيمين في حفل كوكتيل عند غروب الشمس في التراس الخارجي، ستجد فرصًا لا حصر لها للتواصل والاسترخاء والراحة. مع وجود تقويم كامل للمناسبات الاجتماعية والأنشطة الترفيهية والتجارب الثقافية، فإن الحياة في Blue Sky Estates ليست عادية على الإطلاق. اكتشف المعنى الحقيقي للمعيشة الفاخرة واستمتع بتجربة نمط الحياة الذي لا مثيل له الذي ينتظرك في هذا الملاذ الحصري على ضفاف النهر.</p>\r\n<p><strong>خاتمة</strong></p>\r\n<p>في الختام، تمثل Blue Sky Estates قمة المعيشة الفاخرة في جاكسونفيل، فلوريدا. بدءًا من موقعه المثالي على ضفاف النهر إلى وسائل الراحة ذات المستوى العالمي والمساكن الفاخرة، تم تصميم كل جانب من جوانب هذا المجتمع المحترم ليتجاوز توقعاتك ويرفع مستوى نمط حياتك. سواء كنت تبحث عن ملاذ هادئ من صخب الحياة في المدينة أو عن مجتمع نابض بالحياة حيث يبدو كل يوم وكأنه إجازة، فإن Blue Sky Estates تقدم مزيجًا مثاليًا من الصفاء والرقي والأناقة. عد إلى موطنك في Blue Sky Estates واكتشف أفضل مستويات المعيشة الفاخرة على ضفاف النهر.</p>','بلو سكاي إستيتس 789 سيرينتي درايف جاكسونفيل، فلوريدا 32256 الولايات المتحدة',NULL,NULL,NULL,'2024-05-05 23:06:52','2025-01-18 22:03:44','مجموعة بلو سكاي للعقارات هي اسم موثوق في مجال العقارات، حيث تقدم مجموعة واسعة من العقارات للبيع والإيجار. سواء كنت تبحث عن منزلك المثالي، أو عقار تجاري، أو فرصة استثمارية، نقدم لك التوجيه الخبير والخدمة المخصصة لمساعدتك في اتخاذ قرارات مدروسة. استمتع بمعاملات سلسة ورعاية عملاء استثنائية مع مجموعة بلو سكاي للعقارات.'),
(17,20,9,9,6,NULL,13,'Wholesome Fare Diner','wholesome-fare-diner','[\"5\",\"8\",\"17\"]','<p>Welcome to Wholesome Fare Diner, where every dish tells a story of flavor, tradition, and community. Nestled in the vibrant heart of Keraniganj, Dhaka, our restaurant is a culinary oasis, offering a haven for food enthusiasts seeking authentic flavors and heartfelt hospitality.</p>\r\n<p>As you step through the doors of Wholesome Fare Diner, you\'re greeted by the tantalizing aroma of freshly prepared dishes and the warm ambiance that invites you to unwind and savor every moment. Our cozy yet chic interior reflects the rustic charm of traditional eateries, with modern touches that elevate the dining experience.</p>\r\n<p>At Wholesome Fare Diner, we take pride in curating a menu that celebrates the rich culinary heritage of Bangladesh while embracing global influences. From classic Bengali comfort food to innovative fusion creations, each dish is meticulously crafted using locally sourced ingredients, ensuring freshness and quality with every bite.</p>\r\n<p>Start your culinary journey with our signature appetizers, like the crispy Piyaju made with lentils and spices, or indulge in the savory goodness of our Chicken Tikka skewers, marinated to perfection and grilled to juicy perfection. For seafood lovers, our Prawn Bhuna and Fish Curry showcase the exquisite flavors of the Bay of Bengal, infused with aromatic spices and served with fluffy rice or warm naan bread.</p>\r\n<p>For those craving something hearty and wholesome, our selection of traditional Bengali thalis offers a taste of home-cooked goodness, featuring an assortment of flavorful curries, dal, vegetables, and fragrant rice. Vegetarian options abound, with dishes like Aloo Gobi and Palak Paneer showcasing the vibrant colors and bold flavors of seasonal produce.</p>\r\n<p>At Wholesome Fare Diner, we believe that dining is not just about nourishing the body but also feeding the soul. That\'s why we go beyond food to create an immersive dining experience that celebrates the spirit of community and togetherness. Our attentive staff is dedicated to providing personalized service, ensuring that every visit feels like a special occasion.</p>\r\n<p>Whether you\'re gathering with loved ones for a leisurely meal, celebrating a milestone, or simply seeking solace in good food, Wholesome Fare Diner welcomes you with open arms. Come join us on a culinary adventure that\'s as satisfying as it is unforgettable.</p>\r\n<p>Experience the flavors of Bangladesh and beyond at Wholesome Fare Diner – where every meal is a celebration of tradition, taste, and togetherness.</p>','Wholesome Fare Diner Street Address: 17, Sheikh Mujib Road, Bazar Bus Stand, Keraniganj, Dhaka-1310 Landmark: Opposite to Keraniganj High School and College City: Dhaka Postal Code: 1310 Country: Bangladesh',NULL,NULL,NULL,'2024-05-06 20:37:36','2025-01-18 22:04:54','Wholesome Fare Diner offers a heartwarming dining experience with fresh, healthy, and delicious meals. Our menu features a variety of wholesome options made from quality ingredients to nourish your body and soul. Whether you\'re stopping by for breakfast, lunch, or dinner, enjoy a welcoming atmosphere, friendly service, and food that feels like home at Wholesome Fare Diner.'),
(18,21,9,10,7,NULL,14,'مطعم أجرة صحية','مطعم-أجرة-صحية','[\"6\",\"16\",\"20\",\"22\"]','<p>مرحبًا بكم في مطعم ، حيث يحكي كل طبق قصة عن النكهة والتقاليد والمجتمع. يقع مطعمنا في قلب مدينة كيرانيجانج النابض بالحياة في داكا، ويُعد واحة للطهي، ويوفر ملاذًا لعشاق الطعام الباحثين عن النكهات الأصيلة وكرم الضيافة.</p>\r\n<p>أثناء دخولك أبواب مطعم ، سيتم الترحيب بك بالرائحة المثيرة للأطباق الطازجة والأجواء الدافئة التي تدعوك للاسترخاء وتذوق كل لحظة. يعكس تصميمنا الداخلي المريح والأنيق السحر الريفي للمطاعم التقليدية، مع لمسات عصرية ترتقي بتجربة تناول الطعام.</p>\r\n<p>في Wholesome Fare Diner، نحن نفخر بتنظيم قائمة تحتفل بتراث الطهي الغني لبنغلاديش مع احتضان التأثيرات العالمية. بدءًا من الطعام البنغالي الكلاسيكي المريح وحتى الإبداعات المبتكرة، يتم إعداد كل طبق بدقة باستخدام مكونات من مصادر محلية، مما يضمن النضارة والجودة مع كل قضمة.</p>\r\n<p>ابدأ رحلتك الطهوية مع المقبلات المميزة لدينا، مثل بياجو المقرمشة المصنوعة من العدس والتوابل، أو انغمس في المذاق اللذيذ لأسياخ دجاج تكا، المتبلة إلى حد الكمال والمشوية إلى درجة الكمال. لمحبي المأكولات البحرية، يقدم الروبيان بهونا والسمك بالكاري النكهات الرائعة لخليج البنغال، الممزوجة بالتوابل العطرية وتقدم مع الأرز الرقيق أو خبز النان الدافئ.</p>\r\n<p>بالنسبة لأولئك الذين يتوقون إلى شيء لذيذ وصحي، تقدم مجموعتنا المختارة من أطباق التاليس البنغالية التقليدية مذاقًا لذيذًا مطبوخًا في المنزل، وتضم مجموعة متنوعة من الكاري اللذيذ، ودال، والخضروات، والأرز العطري. وتكثر الخيارات النباتية، مع أطباق مثل Aloo Gobi وPalak Paneer التي تعرض الألوان النابضة بالحياة والنكهات الجريئة للمنتجات الموسمية.</p>\r\n<p>في ، نحن نؤمن بأن تناول الطعام لا يتعلق فقط بتغذية الجسم ولكن أيضًا بتغذية الروح. ولهذا السبب فإننا نذهب إلى ما هو أبعد من الطعام لنبتكر تجربة طعام غامرة تحتفي بروح المجتمع والعمل الجماعي. يكرس موظفونا اليقظون جهودهم لتقديم خدمة شخصية، مما يضمن أن كل زيارة تبدو وكأنها مناسبة خاصة.</p>\r\n<p>سواء كنت تجتمع مع أحبائك لتناول وجبة ممتعة، أو تحتفل بحدث هام، أو تبحث ببساطة عن العزاء في طعام جيد، فإن مطعم  يرحب بك بأذرع مفتوحة. انضم إلينا في مغامرة طهي مرضية بقدر ما هي لا تُنسى.</p>\r\n<p>استمتع بتجربة نكهات بنجلاديش وخارجها في مطعم  - حيث تمثل كل وجبة احتفالًا بالتقاليد والذوق والعمل الجماعي.</p>','عنوان شارع Wholesome Fare Diner: 17، طريق الشيخ مجيب، موقف حافلات بازار، كيرانيجانج، دكا-1310 معلم بارز: مقابل مدرسة كيرانيجانج الثانوية والكلية المدينة: دكا الرمز البريدي: 1310 البلد: بنغلاديش',NULL,NULL,NULL,'2024-05-06 20:37:36','2025-01-18 22:04:54','مطعم وولسوم فير يقدم تجربة طعام دافئة مع وجبات طازجة وصحية ولذيذة. يضم قائمتنا مجموعة متنوعة من الخيارات المغذية المحضرة من مكونات عالية الجودة لتغذية الجسم والروح. سواء كنت تزورنا لتناول الإفطار، الغداء، أو العشاء، استمتع بأجواء ترحيبية وخدمة ودودة وطعام يشعرك وكأنك في المنزل في مطعم وولسوم فير.'),
(19,20,10,9,10,5,15,'Café Noir et Blanc','café-noir-et-blanc','[\"5\",\"8\",\"10\",\"17\",\"19\"]','<p>Nestled in the heart of vibrant San Diego, Café Noir et Blanc exudes an irresistible charm, inviting patrons to experience a fusion of flavors amidst a backdrop of timeless elegance. This quaint café, aptly named for its chic black and white theme, offers a delightful escape from the hustle and bustle of city life.</p>\r\n<p>Step through the inviting entrance adorned with classic bistro-style signage, and you\'ll find yourself enveloped in an ambiance that effortlessly marries sophistication with warmth. Soft jazz melodies float through the air, complementing the cozy chatter of patrons indulging in their culinary delights.</p>\r\n<p>As you settle into one of the plush seats, you\'re greeted by the aroma of freshly brewed coffee and tantalizing scents wafting from the kitchen. Café Noir et Blanc takes pride in its meticulously crafted menu, boasting an array of artisanal coffees, velvety espressos, and aromatic teas sourced from around the globe.</p>\r\n<p>Whether you\'re craving a hearty breakfast to kickstart your day, a light lunch to refuel, or a decadent dessert to satisfy your sweet tooth, Café Noir et Blanc has something to tantalize every palate. From fluffy Belgian waffles drizzled with maple syrup to savory quiches bursting with flavor, each dish is prepared with care using the finest ingredients.</p>\r\n<p>Indulge in a leisurely brunch with friends as you savor mouthwatering avocado toast topped with poached eggs, or treat yourself to a decadent slice of triple-layer chocolate cake paired with a velvety cappuccino. For those seeking healthier options, the menu also features vibrant salads brimming with seasonal produce and wholesome sandwiches made with freshly baked artisanal bread.</p>\r\n<p>In addition to its delectable fare, Café Noir et Blanc prides itself on providing exceptional service, ensuring that every visit is a memorable one. Whether you\'re popping in for a quick caffeine fix or lingering over a leisurely meal, the attentive staff are always on hand to cater to your every need with a warm smile and a personal touch.</p>\r\n<p>With its inviting ambiance, delectable cuisine, and impeccable service, Café Noir et Blanc is more than just a café – it\'s a culinary haven where every moment is savored and every palate delighted. Come and experience the magic for yourself at this charming oasis in the heart of San Diego.</p>','Café Noir et Blanc (Black and White Café) 1234 Pacific Avenue San Diego, CA 92101 United States',NULL,NULL,NULL,'2024-05-06 21:22:20','2025-01-18 22:05:35','Café Noir et Blanc is a charming coffee spot that blends elegance and comfort. Offering expertly brewed coffee, delightful pastries, and a cozy ambiance, it\'s the perfect place to unwind, catch up with friends, or spark creativity. Whether you prefer rich espresso or a creamy latte, Café Noir et Blanc promises a memorable experience with every sip.'),
(20,21,10,10,11,6,16,'كافيه نوير إي بلان','كافيه-نوير-إي-بلان','[\"16\",\"20\",\"22\"]','<p>يقع مقهى  في قلب مدينة سان دييغو النابضة بالحياة، وهو ينضح بسحر لا يقاوم، ويدعو العملاء لتجربة مزيج من النكهات وسط خلفية من الأناقة الخالدة. يوفر هذا المقهى الجذاب، الذي سُمي على نحو مناسب لطابعه الأنيق باللونين الأبيض والأسود، ملاذًا مبهجًا من صخب الحياة في المدينة.</p>\r\n<p>قم بالدخول عبر المدخل الجذاب المزين بلافتات كلاسيكية على طراز البيسترو، وستجد نفسك محاطًا بأجواء تجمع بين الرقي والدفء بسهولة. تطفو ألحان موسيقى الجاز الناعمة في الهواء، لتكمل الأحاديث المريحة للعملاء الذين ينغمسون في المأكولات الشهية.</p>\r\n<p>عندما تستقر في أحد المقاعد الفخمة، تستقبلك رائحة القهوة الطازجة والروائح المثيرة التي تفوح من المطبخ. يفخر  بقائمة طعامه المعدة بدقة، والتي تضم مجموعة من أنواع القهوة الحرفية والإسبريسو المخملي وأنواع الشاي العطرية التي يتم الحصول عليها من جميع أنحاء العالم.</p>\r\n<p>سواء كنت ترغب في تناول وجبة إفطار شهية لبدء يومك، أو وجبة غداء خفيفة للتزود بالوقود، أو حلوى لذيذة لإرضاء شهيتك للحلويات، فإن  لديه ما يثير إعجاب جميع الأذواق. بدءًا من الفطائر البلجيكية الرقيقة المغطاة بشراب القيقب وحتى الفطائر اللذيذة المليئة بالنكهة، يتم إعداد كل طبق بعناية باستخدام أجود المكونات.</p>\r\n<p>انغمس في وجبة فطور وغداء ممتعة مع الأصدقاء بينما تتذوق خبز الأفوكادو اللذيذ المغطى بالبيض المسلوق، أو دلّل نفسك بشريحة لذيذة من كعكة الشوكولاتة ثلاثية الطبقات مع الكابتشينو المخملي. بالنسبة لأولئك الذين يبحثون عن خيارات صحية، تتميز القائمة أيضًا بالسلطات النابضة بالحياة المليئة بالمنتجات الموسمية والسندويشات الصحية المصنوعة من الخبز الطازج.</p>\r\n<p>بالإضافة إلى أطباقه اللذيذة، يفخر Café  بتقديم خدمة استثنائية، مما يضمن أن كل زيارة ستكون زيارة لا تُنسى. سواء كنت ترغب في تناول وجبة سريعة من الكافيين أو تناول وجبة ممتعة، فإن الموظفين اليقظين موجودون دائمًا لتلبية جميع احتياجاتك بابتسامة دافئة ولمسة شخصية.</p>\r\n<p>بفضل أجواءه الجذابة ومأكولاته اللذيذة وخدمة لا تشوبها شائبة، يعد Café  أكثر من مجرد مقهى - إنه ملاذ للطهي حيث يتم الاستمتاع بكل لحظة وإسعاد كل الأذواق. تعال واستمتع بتجربة السحر بنفسك في هذه الواحة الساحرة في قلب مدينة سان دييغو.</p>','كافيه نوير إي بلان (مقهى بلاك آند وايت) 1234 شارع باسيفيك سان دييغو، كاليفورنيا 92101 الولايات المتحدة',NULL,NULL,NULL,'2024-05-06 21:22:20','2025-01-18 22:05:35','كافيه نوار إيه بلان هو مكان ساحر يجمع بين الأناقة والراحة. يقدم قهوة محضرة بإتقان، ومجموعة من المعجنات اللذيذة، وأجواء دافئة، مما يجعله المكان المثالي للاسترخاء، أو لقاء الأصدقاء، أو إلهام الإبداع. سواء كنت تفضل الإسبرسو الغني أو اللاتيه الكريمي، يعدك كافيه نوار إيه بلان بتجربة لا تُنسى مع كل رشفة.'),
(21,20,11,15,2,1,1,'GymCraft Solutions','gymcraft-solutions','[\"5\",\"8\",\"10\",\"17\"]','<p>GymCraft Solutions stands as a beacon of innovation and excellence in the realm of fitness equipment retail. Nestled within the bustling streets of [City], it beckons fitness enthusiasts and gym aficionados alike with its promise of top-notch products and unparalleled service. As you step through its doors, you are greeted by a symphony of sleek machinery and cutting-edge gear, each item meticulously curated to elevate your fitness journey to new heights.</p>\r\n<p>At GymCraft Solutions, we pride ourselves on offering a comprehensive array of products designed to cater to every aspect of your workout regimen. From cardio machines to strength training equipment, we have it all under one roof. Picture rows of state-of-the-art treadmills, ellipticals, and exercise bikes, beckoning you to embark on a journey of endurance and stamina. Our selection of cardio equipment encompasses the latest advancements in technology, ensuring that you can push your limits while minimizing impact on your joints.</p>\r\n<p>For those seeking to sculpt their physique and build strength, GymCraft Solutions presents an impressive lineup of weightlifting equipment. From dumbbells and barbells to power racks and cable machines, we provide the tools you need to carve out the body of your dreams. Whether you\'re a seasoned lifter or just starting out on your fitness journey, our knowledgeable staff is on hand to guide you towards the perfect equipment tailored to your goals and abilities.</p>\r\n<p>But our commitment to excellence doesn\'t stop at the gym floor. GymCraft Solutions understands the importance of recovery and self-care in achieving optimal fitness results. That\'s why we offer a curated selection of recovery tools and accessories, including foam rollers, massage guns, and compression gear, to help you soothe sore muscles and enhance your overall well-being.</p>\r\n<p>Beyond our stellar product offerings, GymCraft Solutions prides itself on providing a shopping experience like no other. Our team of fitness enthusiasts is dedicated to delivering personalized assistance and expert advice, ensuring that you leave our store feeling confident and inspired to conquer your fitness goals. Whether you\'re a professional athlete, a weekend warrior, or simply someone striving to lead a healthier lifestyle, GymCraft Solutions is your ultimate destination for all things fitness.</p>\r\n<p>In every aspect of our business, from the products we sell to the service we provide, GymCraft Solutions is driven by a passion for empowering individuals to unlock their full potential and live their healthiest, happiest lives. Step into our store today and let us be your partner on the journey to greatness.</p>','GymCraft Solutions Melbourne: 1201 Fitness Avenue, Suite 301 Victoria Central Plaza, Level 3 Melbourne CBD, Victoria 3000 Australia',NULL,NULL,NULL,'2024-05-06 22:34:31','2025-01-18 22:06:12','GymCraft Solutions specializes in designing and equipping cutting-edge fitness spaces. From home gyms to large commercial facilities, we provide tailored solutions, high-quality equipment, and expert consultation to meet your fitness needs. Whether you’re building from scratch or upgrading, GymCraft Solutions ensures your fitness space is functional, stylish, and optimized for peak performance.'),
(22,21,11,16,3,2,2,'جيم كرافت سوليوشنز','جيم-كرافت-سوليوشنز','[\"2\",\"6\",\"18\",\"20\"]','<p>تعد شركة بمثابة منارة للابتكار والتميز في مجال بيع معدات اللياقة البدنية بالتجزئة. يقع في شوارع [] الصاخبة، وهو يغري عشاق اللياقة البدنية وعشاق الصالة الرياضية على حد سواء بوعدهم بتقديم منتجات من الدرجة الأولى وخدمة لا مثيل لها. عندما تدخل من أبوابه، يتم الترحيب بك من خلال سيمفونية من الآلات الأنيقة والمعدات المتطورة، حيث تم تصميم كل عنصر بدقة شديدة للارتقاء برحلة اللياقة البدنية الخاصة بك إلى آفاق جديدة.</p>\r\n<p>في ، نحن نفخر بتقديم مجموعة شاملة من المنتجات المصممة لتلبية كل جانب من جوانب نظام التمرين الخاص بك. من أجهزة القلب إلى معدات تدريب القوة، لدينا كل ذلك تحت سقف واحد. تصور صفوفًا من أجهزة المشي الحديثة، وأجهزة التمارين الرياضية البيضاوية، ودراجات التمرين، والتي تدعوك إلى الشروع في رحلة التحمل والقدرة على التحمل. تشتمل مجموعتنا المختارة من أجهزة تقوية القلب على أحدث التطورات في مجال التكنولوجيا، مما يضمن قدرتك على تجاوز حدودك مع تقليل التأثير على مفاصلك.</p>\r\n<p>بالنسبة لأولئك الذين يسعون إلى نحت اللياقة البدنية وبناء القوة، تقدم تشكيلة رائعة من معدات رفع الأثقال. من الدمبل والأثقال إلى رفوف الطاقة وآلات الكابلات، نحن نقدم الأدوات التي تحتاجها لنحت الجسم الذي تحلم به. سواء كنت من لاعبي رفع الأثقال المتمرسين أو بدأت للتو في رحلة اللياقة البدنية، فإن موظفينا ذوي الخبرة متواجدون لإرشادك نحو المعدات المثالية المصممة خصيصًا لأهدافك وقدراتك.</p>\r\n<p>لكن التزامنا بالتميز لا يتوقف عند صالة الألعاب الرياضية. تدرك شركة أهمية التعافي والرعاية الذاتية في تحقيق نتائج اللياقة البدنية المثالية. لهذا السبب نقدم مجموعة مختارة من أدوات وملحقات التعافي، بما في ذلك بكرات الرغوة وبنادق التدليك ومعدات الضغط، لمساعدتك على تهدئة العضلات الملتهبة وتعزيز صحتك بشكل عام.</p>\r\n<p>بالإضافة إلى عروض منتجاتنا الممتازة، تفتخر شركة بتقديم تجربة تسوق لا مثيل لها. فريقنا من عشاق اللياقة البدنية مكرس لتقديم المساعدة الشخصية ونصائح الخبراء، مما يضمن مغادرة متجرنا وأنت تشعر بالثقة والإلهام لتحقيق أهداف اللياقة البدنية الخاصة بك. سواء كنت رياضيًا محترفًا، أو محاربًا في عطلة نهاية الأسبوع، أو مجرد شخص يسعى لقيادة نمط حياة أكثر صحة، فإن هي وجهتك النهائية لكل ما يتعلق باللياقة البدنية.</p>\r\n<p>في كل جانب من جوانب أعمالنا، بدءًا من المنتجات التي نبيعها إلى الخدمة التي نقدمها، فإن مدفوعة بشغف لتمكين الأفراد من إطلاق العنان لإمكاناتهم الكاملة والعيش حياة أكثر صحة وسعادة. تفضل بزيارة متجرنا اليوم ودعنا نكون شريكك في رحلتك نحو العظمة.</p>','محل جيم كرافت سوليوشنز: ١٢٠١ شارع اللياقة البدنية، جناح ٣٠١ مركز فيكتوريا المركزي، الطابق الثالث مدينة ملبورن، فيكتوريا ٣٠٠٠ أستراليا',NULL,NULL,NULL,'2024-05-06 22:34:31','2025-01-18 22:06:12','تتخصص جيم كرافت سوليوشنز في تصميم وتجهيز مساحات اللياقة البدنية الحديثة. من الصالات المنزلية إلى المنشآت التجارية الكبيرة، نقدم حلولاً مخصصة، ومعدات عالية الجودة، واستشارات خبراء لتلبية احتياجاتك الرياضية. سواء كنت تبني من البداية أو تقوم بالتطوير، تضمن جيم كرافت سوليوشنز أن تكون مساحتك الرياضية عملية، أنيقة، ومثالية لتحقيق الأداء الأمثل.'),
(23,20,12,3,10,7,11,'EliteCare Bed Boutique','elitecare-bed-boutique','[\"5\",\"8\",\"10\",\"17\"]','<p>EliteCare Hospital Bed Boutique is a premier destination in Jacksonville, Florida, dedicated to providing top-quality hospital beds and related medical equipment to meet the diverse needs of healthcare facilities and individuals alike. Situated on the bustling Riverside Avenue, EliteCare stands as a beacon of excellence in the realm of medical bed solutions.</p>\r\n<p>At EliteCare, our mission is to prioritize comfort, functionality, and reliability in every product we offer. We understand the critical role that hospital beds play in patient care and recovery, which is why we meticulously curate our selection to ensure that each bed meets the highest standards of quality and performance. Whether it\'s for a hospital, nursing home, rehabilitation center, or home care setting, customers can trust EliteCare to deliver superior products that enhance the overall patient experience.</p>\r\n<p>What sets EliteCare apart is our commitment to personalized service and attention to detail. Our knowledgeable and friendly staff are dedicated to guiding customers through the selection process, taking into account specific needs, preferences, and budget considerations. From basic adjustable beds to advanced ICU models, we offer a comprehensive range of options to suit every requirement.</p>\r\n<p>In addition to hospital beds, EliteCare also offers a variety of accessories and supplementary equipment to complement our bed offerings. From bedside tables and overbed trays to specialized mattresses and pressure relief systems, we strive to be a one-stop destination for all medical bed needs. Our goal is to simplify the procurement process for our customers, providing them with everything they need to create a comfortable and efficient care environment.</p>\r\n<p>Beyond our product offerings, EliteCare is deeply committed to customer satisfaction and ongoing support. We understand that purchasing hospital beds is a significant investment, and we stand behind the quality and durability of our products. Our team provides comprehensive post-sales assistance, including installation services, maintenance support, and technical troubleshooting, to ensure that our customers receive the utmost value from their investment.</p>\r\n<p>Moreover, EliteCare is actively involved in the local healthcare community, partnering with hospitals, clinics, and care facilities to support their efforts in providing quality patient care. We collaborate with healthcare professionals to understand evolving industry trends and technological advancements, enabling us to continually refine our product offerings and services to better serve our customers.</p>\r\n<p>In conclusion, EliteCare Hospital Bed Boutique is more than just a showroom—it\'s a trusted partner in the provision of premium medical bed solutions. With a steadfast commitment to quality, service, and innovation, EliteCare strives to enhance the lives of patients and caregivers alike, one bed at a time.</p>','EliteCare Hospital Bed Boutique 1256 Riverside Avenue, Suite 210 Jacksonville, FL 32204 United States',NULL,NULL,NULL,'2024-05-07 00:07:13','2025-01-18 22:06:47','EliteCare Bed Boutique offers premium-quality beds and sleep solutions designed for ultimate comfort and style. With a wide range of luxurious mattresses, bed frames, and accessories, we aim to enhance your sleep experience and transform your bedroom into a sanctuary. At EliteCare, quality meets elegance to ensure you wake up refreshed every day.'),
(24,21,12,4,11,8,12,'بوتيك سرير من إليت كير','بوتيك-سرير-من-إليت-كير','[\"11\",\"13\",\"18\"]','<p>تعتبر إليت كير  وجهة رئيسية في جاكسونفيل، فلوريدا، وهي مخصصة لتوفير أسرة المستشفيات عالية الجودة والمعدات الطبية ذات الصلة لتلبية الاحتياجات المتنوعة لمرافق الرعاية الصحية والأفراد على حد سواء. تقع EliteCare في شارع ريفرسايد الصاخب، وتعد بمثابة منارة للتميز في عالم حلول الأسرة الطبية.</p>\r\n<p>في EliteCare، مهمتنا هي إعطاء الأولوية للراحة والأداء الوظيفي والموثوقية في كل منتج نقدمه. نحن نتفهم الدور الحاسم الذي تلعبه أسرة المستشفيات في رعاية المرضى وتعافيهم، ولهذا السبب نقوم بتنسيق اختياراتنا بدقة للتأكد من أن كل سرير يلبي أعلى معايير الجودة والأداء. سواء كان الأمر يتعلق بمستشفى أو دار رعاية أو مركز إعادة تأهيل أو مركز رعاية منزلية، يمكن للعملاء الوثوق في لتقديم منتجات فائقة الجودة تعزز تجربة المريض بشكل عام.</p>\r\n<p>ما يميز EliteCare هو التزامنا بالخدمة الشخصية والاهتمام بالتفاصيل. إن موظفينا ذوي المعرفة والود ملتزمون بتوجيه العملاء خلال عملية الاختيار، مع مراعاة الاحتياجات والتفضيلات المحددة واعتبارات الميزانية. بدءًا من الأسرّة الأساسية القابلة للتعديل وحتى نماذج وحدة العناية المركزة المتقدمة، نقدم مجموعة شاملة من الخيارات التي تناسب كل المتطلبات.</p>\r\n<p>بالإضافة إلى أسرة المستشفيات، تقدم أيضًا مجموعة متنوعة من الملحقات والمعدات التكميلية لتكمل عروض الأسرة لدينا. بدءًا من الطاولات الجانبية للسرير والصواني الموجودة فوق السرير وحتى المراتب المتخصصة وأنظمة تخفيف الضغط، فإننا نسعى جاهدين لنكون وجهة شاملة لجميع احتياجات الأسرة الطبية. هدفنا هو تبسيط عملية الشراء لعملائنا، وتزويدهم بكل ما يحتاجونه لخلق بيئة رعاية مريحة وفعالة.</p>\r\n<p>بالإضافة إلى عروض منتجاتنا، تلتزم بشدة برضا العملاء والدعم المستمر. نحن ندرك أن شراء أسرة المستشفيات يعد استثمارًا كبيرًا، ونحن ندعم جودة منتجاتنا ومتانتها. يقدم فريقنا مساعدة شاملة لما بعد البيع، بما في ذلك خدمات التركيب ودعم الصيانة واستكشاف الأخطاء الفنية وإصلاحها، لضمان حصول عملائنا على أقصى قيمة من استثماراتهم.</p>\r\n<p>علاوة على ذلك، تشارك بنشاط في مجتمع الرعاية الصحية المحلي، حيث تتعاون مع المستشفيات والعيادات ومرافق الرعاية لدعم جهودها في توفير رعاية عالية الجودة للمرضى. نحن نتعاون مع المتخصصين في الرعاية الصحية لفهم اتجاهات الصناعة المتطورة والتقدم التكنولوجي، مما يمكننا من تحسين عروض منتجاتنا وخدماتنا باستمرار لتقديم خدمة أفضل لعملائنا.</p>\r\n<p>في الختام، يعتبر أكثر من مجرد صالة عرض - فهو شريك موثوق به في توفير حلول الأسرة الطبية المتميزة. مع الالتزام الثابت بالجودة والخدمة والابتكار، تسعى جاهدة لتحسين حياة المرضى ومقدمي الرعاية على حد سواء، سرير واحد في كل مرة.</p>','متجر أسرّة المستشفى النخبة بوتيك شارع ريفرسايد 1256، مكتب 210، جاكسونفيل، فلوريدا 32204، الولايات المتحدة',NULL,NULL,NULL,'2024-05-07 00:07:13','2025-01-18 22:06:47','بوتيك إيليت كير للمفروشات يقدم أسرّة وحلول نوم فاخرة مصممة لتحقيق الراحة المطلقة والأناقة. مع مجموعة واسعة من المراتب الفاخرة، وإطارات الأسرة، والإكسسوارات، نسعى لتعزيز تجربة نومك وتحويل غرفة نومك إلى ملاذ مريح. في إيليت كير، يجتمع الجودة مع الأناقة لضمان استيقاظك منتعشًا كل يوم.'),
(25,20,13,1,8,NULL,7,'Frontier Whiskers Saloon','frontier-whiskers-saloon','[\"3\",\"5\",\"8\"]','<p>Nestled within the rugged terrain of Peshawar Province, Pakistan, lies the enchanting Frontier Whiskers Saloon, a beacon of camaraderie and warmth amid the vast desert expanse. With its rustic charm and old-world allure, this saloon stands as a testament to the timeless spirit of the Wild West, transplanted into the heart of the Middle East.</p>\r\n<p>As you approach Frontier Whiskers Saloon along the winding Rugged Road, the whispers of adventure seem to dance in the desert breeze. The exterior, weathered by sun and sand, exudes an aura of authenticity, with swinging saloon doors beckoning travelers and locals alike to step inside and escape the harshness of the desert.</p>\r\n<p>Once through those doors, guests are transported to a bygone era, where the clinking of glasses and the twang of country tunes fill the air. The interior is a symphony of reclaimed wood, flickering lanterns, and worn leather furnishings, evoking the rugged charm of frontier life. Mounted animal heads gaze down from the walls, adding a touch of wilderness to the cozy ambiance.</p>\r\n<p>At the heart of Frontier Whiskers Saloon is the bar, a sprawling oak structure that serves as the focal point of social interaction. Behind it, shelves are lined with an impressive array of spirits, from local favorites to imported rarities, promising a libation to suit every palate. Bartenders, clad in traditional western attire, mix and pour with practiced expertise, regaling patrons with tales of the untamed frontier.</p>\r\n<p>But Frontier Whiskers Saloon is more than just a place to wet one\'s whistle; it\'s a hub of community and entertainment. Regulars gather around rough-hewn tables to swap stories of desert exploits, while newcomers are welcomed with open arms into the fold. Live music fills the air most nights, with talented local musicians taking the stage to serenade the crowd with soulful ballads and foot-stomping anthems.</p>\r\n<p>As the evening wears on and the desert sky transforms into a canvas of stars, Frontier Whiskers Saloon continues to buzz with life. Whether savoring a hearty meal crafted from locally sourced ingredients, testing their luck at a game of cards, or simply soaking in the vibrant atmosphere, guests find themselves drawn back time and again to this oasis of hospitality in the sands of Pakistan. Frontier Whiskers Saloon isn\'t just a place; it\'s an experience—a testament to the enduring allure of the Wild West, thriving halfway across the globe.</p>','Frontier Whiskers Saloon Rugged Road, Dusty Gulch District, Desert Oasis, Peshawar Province, Pakistan',NULL,NULL,NULL,'2024-05-07 02:40:46','2025-01-18 22:07:21','Frontier Whiskers Saloon is a vibrant destination that captures the spirit of the Wild West. Offering a wide selection of craft drinks, hearty meals, and live entertainment, it’s the perfect spot to relax and enjoy rustic charm with a modern twist. Step into Frontier Whiskers Saloon for a unique and unforgettable experience.'),
(26,21,13,2,9,NULL,8,'صالون شعيرات الحدود','صالون-شعيرات-الحدود','[\"2\",\"11\",\"20\"]','<p>يقع صالون الساحر داخل التضاريس الوعرة لمقاطعة بيشاور في باكستان، وهو منارة للصداقة الحميمة والدفء وسط مساحة صحراوية شاسعة. بفضل سحرها الريفي وجاذبية العالم القديم، تقف هذه الصالون بمثابة شهادة على روح الغرب المتوحش الخالدة، المزروعة في قلب الشرق الأوسط.</p>\r\n<p>عندما تقترب من Frontier على طول الطريق الوعرة المتعرج، تبدو همسات المغامرة وكأنها تتراقص مع نسيم الصحراء. ينضح الجزء الخارجي، الذي تغمره الشمس والرمال، بهالة من الأصالة، مع أبواب الصالون المتأرجحة التي تدعو المسافرين والسكان المحليين على حد سواء إلى الدخول والهروب من قسوة الصحراء.</p>\r\n<p>بمجرد عبور هذه الأبواب، يتم نقل الضيوف إلى عصر ماضي، حيث يملأ الهواء قعقعة الكؤوس ونغمات الألحان الريفية. التصميم الداخلي عبارة عن سيمفونية من الخشب المستصلح، والفوانيس الوامضة، والمفروشات الجلدية البالية، مما يستحضر سحر الحياة الحدودية الوعرة. تطل رؤوس الحيوانات من على الجدران، مما يضيف لمسة من الحياة البرية إلى الأجواء المريحة.</p>\r\n<p>يقع البار في قلب Frontier ، وهو عبارة عن هيكل مترامي الأطراف من خشب البلوط يعمل كنقطة محورية للتفاعل الاجتماعي. وخلفه، تصطف الرفوف بمجموعة رائعة من المشروبات الروحية، بدءًا من المشروبات الروحية المفضلة المحلية وحتى المشروبات النادرة المستوردة، مما يَعِد باحتساء مشروب يناسب كل الأذواق. يمتزج السقاة، الذين يرتدون الملابس الغربية التقليدية، مع الخبرة العملية، ويمتعون العملاء بحكايات الحدود الجامحة.</p>\r\n<p>لكن صالون فرونتير ويسكرز هو أكثر من مجرد مكان لتبليل صافرة الشخص؛ إنها مركز للمجتمع والترفيه. يجتمع الزوار النظاميون حول طاولات منحوتة بشكل خشن لتبادل قصص مآثر الصحراء، بينما يتم الترحيب بالوافدين الجدد بأذرع مفتوحة في الحظيرة. تملأ الموسيقى الحية الهواء في معظم الليالي، حيث يعتلي الموسيقيون المحليون الموهوبون المسرح ليغنيوا الجمهور بأغاني غنائية مفعمة بالحيوية وأناشيد راقصة.</p>\r\n<p>مع حلول المساء وتحول سماء الصحراء إلى لوحة من النجوم، يستمر صالون في الحيوية. سواء كانوا يستمتعون بوجبة دسمة مصنوعة من مكونات محلية المصدر، أو يختبرون حظهم في لعبة الورق، أو ببساطة يستمتعون بالأجواء النابضة بالحياة، يجد الضيوف أنفسهم منجذبين مرارًا وتكرارًا إلى واحة الضيافة هذه في رمال باكستان. صالون فرونتير ويسكرز ليس مجرد مكان؛ إنها تجربة - شهادة على الجاذبية الدائمة للغرب المتوحش، المزدهر في منتصف الطريق عبر العالم.</p>','صالون فرونتير ويسكرز الطريق الوعرة، منطقة داستي جولتش، واحة الصحراء، مقاطعة بيشاور، باكستان',NULL,NULL,NULL,'2024-05-07 02:40:46','2025-01-18 22:07:21','صالون فرونتير ويسكرز هو وجهة نابضة بالحياة تجسد روح الغرب الأمريكي. يقدم مجموعة واسعة من المشروبات الحرفية، والوجبات الشهية، والعروض الحية، مما يجعله المكان المثالي للاسترخاء والاستمتاع بسحر الريف مع لمسة عصرية. ادخل إلى صالون فرونتير ويسكرز لتجربة فريدة لا تُنسى.'),
(27,20,14,1,10,7,11,'Outlaw Oasis Saloon','outlaw-oasis-saloon','[\"3\",\"5\"]','<p>Nestled amidst the serene ambiance of Rustic Ravine in Jacknovilla, Florida, Outlaw Oasis Saloon stands as a beacon of rustic charm and laid-back allure. Stepping into this quaint establishment feels like embarking on a journey back in time, where the echoes of the Wild West resonate through every corner. With its weathered wooden facade adorned with swinging saloon doors, Outlaw Oasis Saloon exudes an irresistible old-world charm that beckons travelers and locals alike to venture inside and experience its unique atmosphere.</p>\r\n<p>As you push through the swinging doors, you\'re greeted by the warm glow of lantern light and the lively hum of conversation. The interior transports you to a bygone era, with its rugged wooden beams, vintage memorabilia, and rustic decor that pay homage to the saloons of yesteryears. The scent of aged oak and hearty comfort food wafts through the air, tantalizing your senses and setting the stage for an unforgettable experience.</p>\r\n<p>At the heart of Outlaw Oasis Saloon lies its bustling bar, where skilled bartenders craft an impressive array of cocktails, from classic Old Fashioneds to inventive concoctions inspired by local flavors. Whether you\'re in the mood for a refreshing craft beer, a smooth bourbon, or a signature cocktail, the bar offers something to satisfy every palate. Pull up a stool and strike up a conversation with fellow patrons, or cozy up in one of the dimly lit booths and soak in the ambiance with friends and loved ones.</p>\r\n<p>But Outlaw Oasis Saloon is more than just a place to grab a drink; it\'s a destination for entertainment and camaraderie. Live music fills the air on select nights, with talented musicians taking the stage to serenade guests with toe-tapping tunes that span genres from country and blues to folk and rock. From lively hoedowns to intimate acoustic sets, there\'s always something happening at Outlaw Oasis Saloon to keep you entertained late into the night.</p>\r\n<p>And let\'s not forget about the food. The saloon boasts a mouthwatering menu of hearty comfort fare, with dishes ranging from savory barbecue ribs and juicy burgers to crispy fried chicken and cheesy loaded nachos. Whether you\'re craving a hearty meal to fuel your night or just a satisfying snack to accompany your drinks, the kitchen at Outlaw Oasis Saloon has you covered.</p>\r\n<p>In a world that\'s constantly changing, Outlaw Oasis Saloon remains a timeless haven where friends gather, stories are shared, and memories are made. So saddle up and mosey on down to this hidden gem in the heart of Jacknovilla – because at Outlaw Oasis Saloon, every visit is an adventure worth savoring.</p>','Outlaw Oasis Saloon 556 Rustic Road Rustic Ravine, Jacknovilla, Florida Zip Code: 33221',NULL,NULL,NULL,'2024-05-07 20:48:37','2025-01-18 22:07:59','Outlaw Oasis Saloon is a haven of bold flavors and lively vibes, blending the rugged spirit of the Old West with modern flair. Savor craft cocktails, delicious comfort food, and live entertainment in a welcoming atmosphere. Whether you\'re seeking adventure or relaxation, Outlaw Oasis Saloon offers an unforgettable escape into a world of charm and excitement.'),
(28,21,14,2,11,8,12,'صالون واحة الخارجة عن القانون','صالون-واحة-الخارجة-عن-القانون','[\"16\"]','<p>تقع صالون واوتلو أوازيس في قلب روستيك رافين في جاكنوفيلا، فلوريدا، وتعتبر معلماً يشع بسحره الريفي وسحره الجذاب. فور دخولك لهذا المكان الفريد تشعر وكأنك تعيش رحلة عبر الزمن، حيث يعكس صدى الغرب البري كل زاوية من زواياه. تمتلك صالون واوتلو أوازيس واجهة خشبية متهالكة تتميز بأبوابها المتأرجحة، ما يضفي عليها جاذبية فريدة تجذب المسافرين والسكان المحليين على حد سواء لاستكشاف ما بداخلها وتجربة جوها الفريد.</p>\r\n<p>عندما تدفع بأبوابها المتأرجحة، تستقبلك أجواء دافئة مضاءة بضوء الفانوس وصوت الحديث المليء بالحيوية. تأخذك الديكورات الداخلية في رحلة عبر العصور، مع أعمدة الخشب القديمة والتحف العتيقة والديكورات الريفية التي تُكرم صالونات الماضي. يملأ رائحة البلوط العتيق والطعام الشهي الهواء، محفزًا حواسك وخلق المشهد المثالي لتجربة لا تُنسى.</p>\r\n<p>في قلب صالون واوتلو أوازيس يوجد البار النابض بالحياة، حيث يقوم المشروبين الخبراء بتحضير مجموعة مذهلة من الكوكتيلات، بدءًا من الكلاسيكية مثل الأولد فاشند وحتى المزيجات الاختراعية المستوحاة من النكهات المحلية. سواء كنت تبحث عن بيرة مُنعشة، أو بوربون ناعم، أو كوكتيل مميز، يقدم البار شيئًا لتلبية كل ذوق. جلس وتحدث مع زملائك، أو استرخ في إحدى الكشكات المظلمة واستمتع بالأجواء مع الأصدقاء والأحباء.</p>\r\n<p>لكن صالون واوتلو أوازيس ليس مجرد مكان لتناول المشروبات؛ بل هو وجهة للترفيه والتآلف. تملأ الموسيقى الحية الهواء في الليالي المختارة، حيث يستولي الموسيقيون الموهوبون على المسرح ليحيوا الضيوف بألحان تجعل قلوبهم ترقص، تتراوح من الموسيقى الكانتري والبلوز إلى الموسيقى الفولكلورية والروك. من الحفلات الصاخبة إلى العروض الصوتية الحميمة، دائماً ما يحدث شيء مثير في صالون واوتلو أوازيس ليُسليك حتى وقت متأخر من الليل.</p>\r\n<p>ولا ننسى الطعام. يتميز الصالون بقائمة طعام شهية من الأطباق الريفية اللذيذة، بدءًا من ضلوع اللحم المشوية والبرجر اللذيذ إلى الدجاج المقلي المقرمش والناتشوز المحملة بالجبن. سواء كنت تتوق إلى وجبة دسمة لتمد طاقتك خلال الليل أو مجرد وجبة خفيفة لترافق مشروبك، يضمن المطبخ في صالون واوتلو أوازيس تلبية كل رغباتك.</p>\r\n<p>في عالم متغير باستمرار، يبقى صالون واوتلو أوازيس ملاذًا زمنيًا حيث يجتمع الأصدقاء، ويتبادلون القصص، ويخلقون الذكريات. فانطلق وانضم إلى هذا الجوهرة الخفية في قلب جاكنوفيلا، لأن في صالون واوتلو أوازيس، كل زيارة هي مغامرة تستحق الاستمتاع بها.</p>','صالون واحة الخارجة عن القانون 556 طريق ريفي، وادي ريفي، جاكنوفيلا، فلوريدا الرمز البريدي: 33221',NULL,NULL,NULL,'2024-05-07 20:48:37','2025-01-18 22:07:59','صالون أوتلو أواسيز هو واحة من النكهات الجريئة والأجواء الحيوية، حيث يلتقي طابع الغرب القديم مع اللمسات العصرية. استمتع بالمشروبات الحرفية، والطعام المريح اللذيذ، والعروض الحية في أجواء ترحيبية. سواء كنت تبحث عن المغامرة أو الاسترخاء، يقدم صالون أوتلو أواسيز تجربة لا تُنسى مليئة بالسحر والإثارة.'),
(29,20,15,3,6,NULL,13,'Evergreen Hospital','evergreen-hospital','[\"8\",\"10\",\"12\",\"14\",\"15\",\"17\"]','<p>Evergreen Memorial Hospital stands as a beacon of compassionate care and medical excellence in the heart of Rajshahi, Bangladesh. Nestled on the picturesque Green Avenue in the bustling Lalbagh district, our hospital is dedicated to serving the diverse healthcare needs of our community with unwavering commitment and professionalism.</p>\r\n<p>At Evergreen Memorial Hospital, we pride ourselves on delivering a comprehensive range of medical services tailored to meet the needs of patients across all age groups. From routine check-ups to advanced surgical procedures, our team of highly skilled healthcare professionals is equipped with the latest medical technologies and expertise to provide top-notch care.</p>\r\n<p>Our services encompass a wide spectrum of specialties, including internal medicine, pediatrics, obstetrics and gynecology, orthopedics, cardiology, neurology, and more. Whether you require emergency medical attention or long-term management of chronic conditions, our hospital is equipped to handle it all with precision and compassion.</p>\r\n<p>Patients at Evergreen Memorial Hospital benefit from personalized treatment plans designed to address their unique health concerns and goals. Our multidisciplinary approach ensures that every aspect of their well-being is taken into consideration, fostering optimal outcomes and patient satisfaction.</p>\r\n<p>In addition to our clinical services, Evergreen Memorial Hospital is committed to promoting community health and wellness through various outreach programs and educational initiatives. We believe in empowering individuals with the knowledge and resources they need to lead healthier lives, thus contributing to the overall well-being of our society.</p>\r\n<p>At Evergreen Memorial Hospital, we understand that healthcare goes beyond just treating illnesses; it\'s about restoring hope, dignity, and quality of life. With a steadfast commitment to excellence and a compassionate approach to care, we strive to be the trusted healthcare partner for generations to come.</p>','Evergreen Memorial Hospital 45 Green Avenue, Lalbagh, Rajshahi-6000, Bangladesh.',NULL,NULL,NULL,'2024-05-08 02:46:04','2025-01-18 22:08:34','Evergreen Hospital is dedicated to providing exceptional healthcare with compassion and expertise. Equipped with advanced medical technology and staffed by skilled professionals, we offer a wide range of services to meet your health needs. From routine check-ups to specialized treatments, Evergreen Hospital ensures quality care in a supportive and healing environment.'),
(30,21,15,4,9,NULL,8,'مستشفىين التذكاري','مستشفىين-التذكاري','[\"6\",\"9\",\"11\",\"18\",\"20\"]','<p>يعد مستشفى إيفرجرين التذكاري منارة للرعاية الرحيمة والتميز الطبي في قلب راجشاهي، بنغلاديش. يقع مستشفانا في الجادة الخضراء الخلابة في منطقة لالباغ الصاخبة، وهو مكرس لخدمة احتياجات الرعاية الصحية المتنوعة لمجتمعنا بالتزام واحترافية لا يتزعزعان.</p>\r\n<p>في مستشفى إيفرجرين التذكاري، نحن نفخر بتقديم مجموعة شاملة من الخدمات الطبية المصممة لتلبية احتياجات المرضى في جميع الفئات العمرية. بدءًا من الفحوصات الروتينية وحتى العمليات الجراحية المتقدمة، تم تجهيز فريقنا من المتخصصين في الرعاية الصحية ذوي المهارات العالية بأحدث التقنيات والخبرات الطبية لتقديم رعاية من الدرجة الأولى.</p>\r\n<p>تشمل خدماتنا مجموعة واسعة من التخصصات، بما في ذلك الطب الباطني، وطب الأطفال، وأمراض النساء والتوليد، وجراحة العظام، وأمراض القلب، وأمراض الأعصاب، والمزيد. سواء كنت بحاجة إلى رعاية طبية طارئة أو إدارة طويلة الأمد لحالات مزمنة، فإن مستشفانا مجهز للتعامل مع كل ذلك بدقة وتعاطف.</p>\r\n<p>يستفيد المرضى في مستشفى Evergreen Memorial من خطط العلاج الشخصية المصممة لمعالجة اهتماماتهم وأهدافهم الصحية الفريدة. يضمن نهجنا متعدد التخصصات أن يتم أخذ كل جانب من جوانب رفاهيتهم في الاعتبار، مما يعزز النتائج المثلى ورضا المرضى.</p>\r\n<p>بالإضافة إلى خدماتنا السريرية، يلتزم مستشفى Evergreen Memorial بتعزيز صحة المجتمع وعافيته من خلال برامج التوعية والمبادرات التعليمية المختلفة. نحن نؤمن بتمكين الأفراد بالمعرفة والموارد التي يحتاجونها ليعيشوا حياة أكثر صحة، وبالتالي المساهمة في الرفاهية العامة لمجتمعنا.</p>\r\n<p>في مستشفى إيفرجرين ميموريال، ندرك أن الرعاية الصحية تتجاوز مجرد علاج الأمراض؛ يتعلق الأمر باستعادة الأمل والكرامة ونوعية الحياة. من خلال الالتزام الثابت بالتميز ونهج الرعاية الرحيم، فإننا نسعى جاهدين لنكون شريك الرعاية الصحية الموثوق به للأجيال القادمة.</p>','مستشفى إيفرجرين التذكاري 45 جرين أفينيو، لالباغ، راجشاهي-6000، بنغلاديش.',NULL,NULL,NULL,'2024-05-08 02:46:04','2025-01-18 22:08:34','مستشفى إيفرجرين ملتزم بتقديم رعاية صحية استثنائية بمزيج من التعاطف والخبرة. مجهز بأحدث التقنيات الطبية ويضم فريقًا من المحترفين المهرة، نوفر مجموعة واسعة من الخدمات لتلبية احتياجاتك الصحية. من الفحوصات الروتينية إلى العلاجات المتخصصة، يضمن مستشفى إيفرجرين رعاية عالية الجودة في بيئة داعمة وشفائية.'),
(33,20,17,3,2,1,1,'Popular Special Hospital','popular-special-hospital','[\"1\",\"3\"]','<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>','sddsds,dsds,,dsds, dsdsd',NULL,NULL,NULL,'2025-10-29 04:38:48','2025-11-03 06:03:44','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
(34,21,17,4,3,2,2,'مستشفى شعبي خاص','مستشفى-شعبي-خاص','[\"2\",\"4\"]','<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>','sddsds,dsds,,dsds, dsdsd',NULL,NULL,NULL,'2025-10-29 04:38:48','2025-11-03 06:02:50','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
(35,20,18,13,10,5,15,'The Aetherium Gallery','the-aetherium-gallery','[\"1\",\"3\",\"5\",\"8\",\"10\",\"12\"]','<ul>\r\n<li>\r\n<p class=\"ds-markdown-paragraph\">A prestigious contemporary art gallery in the heart of Manhattan, showcasing groundbreaking works from established and emerging international artists.</p>\r\n</li>\r\n<li>\r\n<p class=\"ds-markdown-paragraph\"><strong>Description:</strong> The Aetherium Gallery is a cornerstone of New York\'s modern art scene. Housed in a sleek, architecturally significant building on Manhattan\'s Upper East Side, we provide a serene and inspiring environment to experience art. Our curated exhibitions rotate quarterly, featuring a diverse range of media including painting, sculpture, digital installations, and mixed media. The Aetherium is dedicated to fostering dialogue and connecting art lovers with the pulse of contemporary culture. We also offer private viewings, artist talks, and consultancy services for collectors.</p>\r\n</li>\r\n</ul>','945 Madison Ave, san diego, California, USA','Obcaecati aliqua Do','Ullamco aliqua Qui',NULL,'2025-11-03 06:24:56','2025-11-03 06:24:56','A prestigious contemporary art gallery in the heart of Manhattan, showcasing groundbreaking works from established and emerging international artists'),
(36,21,18,4,9,NULL,8,'معرض الأثيريوم','معرض-الأثيريوم','[\"4\",\"6\",\"9\"]','<p>معرض فني معاصر مرموق في قلب مانهاتن، يعرض أعمالًا فنية رائدة لفنانين عالميين مخضرمين وناشئين.</p>\r\n<p>الوصف: يُعد معرض إيثيريوم ركنًا أساسيًا في المشهد الفني الحديث في نيويورك. يقع في مبنى أنيق ذي طابع معماري مميز في الجانب الشرقي العلوي من مانهاتن، ويوفر بيئة هادئة وملهمة لتجربة فنية. تُقام معارضنا المُنسقة فصليًا، وتضم مجموعة متنوعة من الوسائط الفنية، بما في ذلك الرسم والنحت والتركيبات الرقمية والوسائط المتعددة. يكرس إيثيريوم جهوده لتعزيز الحوار وربط محبي الفن بنبض الثقافة المعاصرة. كما نقدم عروضًا خاصة، ومحاضرات فنية، وخدمات استشارية لهواة جمع الأعمال الفنية.</p>','945 شارع ماديسون، نيويورك، نيويورك 10021، الولايات المتحدة الأمريكية','Obcaecati aliqua Do',NULL,NULL,'2025-11-03 06:24:56','2025-11-03 06:24:56','معرض فني معاصر مرموق في قلب مانهاتن، يعرض أعمالًا رائدة لفنانين عالميين راسخين وناشئين');
/*!40000 ALTER TABLE `listing_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_faqs`
--

DROP TABLE IF EXISTS `listing_faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_faqs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `question` varchar(255) DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `serial_number` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_faqs`
--

LOCK TABLES `listing_faqs` WRITE;
/*!40000 ALTER TABLE `listing_faqs` DISABLE KEYS */;
INSERT INTO `listing_faqs` VALUES
(1,1,20,'What are your salon\'s safety protocols in light of COVID-19?','This question addresses concerns about hygiene and safety measures implemented by the salon to protect customers and staff.',1,'2024-05-01 21:51:22','2026-04-07 05:06:34'),
(2,1,20,'How do I book an appointment?','This addresses the process for scheduling appointments, whether it\'s done online, over the phone, or in person.',2,'2024-05-01 21:51:50','2024-05-01 21:51:50'),
(3,1,20,'What should I expect during my first visit to your salon?','This helps new customers understand what to anticipate, such as consultations, services offered, and the overall experience.',3,'2024-05-01 21:52:12','2024-05-01 21:52:12'),
(4,1,20,'Do you offer consultations before appointments?','Some clients may want to discuss their desired hairstyle or treatment beforehand, so they\'ll inquire about consultation services.',4,'2024-05-01 21:52:37','2024-05-01 21:52:37'),
(5,1,20,'What haircare products do you recommend for my hair type?','This question is common among clients seeking advice on maintaining their hairstyle or color between salon visits.',5,'2024-05-01 21:53:05','2024-05-01 21:53:05'),
(6,1,20,'How long will my appointment take?','Clients often want to plan their day around salon appointments, so they\'ll ask about the expected duration of their visit.',6,'2024-05-01 21:53:26','2024-05-01 21:53:26'),
(7,1,20,'What is your cancellation policy?','It\'s important for clients to understand the salon\'s policy regarding cancellations, including any fees or notice requirements.',7,'2024-05-01 21:53:47','2024-05-01 21:53:47'),
(8,1,20,'Do you offer any special promotions or loyalty programs?','Clients may inquire about discounts, promotions, or loyalty rewards to make their salon visits more cost-effective.',8,'2024-05-01 21:54:10','2024-05-01 21:54:10'),
(9,1,21,'ما هي إجراءات السلامة الخاصة بصالونكم في ظل جائحة كوفيد-١٩؟','هذا السؤال يتعلق بالاهتمام بالنظافة والإجراءات الأمنية التي يتم تنفيذها في الصالون لحماية العملاء والموظفين.',1,'2024-05-01 22:07:02','2024-05-01 22:07:02'),
(10,1,21,'كيف يمكنني حجز موعد؟','يتعلق هذا بعملية تحديد المواعيد، سواء كانت عبر الإنترنت، أو عبر الهاتف، أو شخصياً.',2,'2024-05-01 22:07:30','2024-05-01 22:07:30'),
(11,1,21,'ما الذي يجب أن أتوقعه خلال زيارتي الأولى إلى صالونكم؟','يساعد هذا السؤال العملاء الجدد على فهم ما يمكن توقعه، مثل الاستشارات، والخدمات المقدمة، والتجربة العامة.',3,'2024-05-01 22:08:00','2024-05-01 22:08:00'),
(12,1,21,'هل تقدمون استشارات قبل المواعيد؟','قد يرغب بعض العملاء في مناقشة القصة أو العلاج المرغوب قبل الحجز، لذلك سيسألون عن خدمات الاستشارة.',4,'2024-05-01 22:08:25','2024-05-01 22:08:25'),
(13,1,21,'ما هي المنتجات المناسبة لنوع شعري؟','هذا السؤال شائع بين العملاء الذين يبحثون عن نصائح للحفاظ على قصة شعرهم أو لونهم بين الزيارات للصالون.',5,'2024-05-01 22:08:56','2024-05-01 22:08:56'),
(14,1,21,'كم سيستغرق موعدي؟','يرغب العملاء غالبًا في تنظيم يومهم حول المواعيد في الصالون، لذا سيسألون عن المدة المتوقعة لزيارتهم.',6,'2024-05-01 22:09:19','2024-05-01 22:09:19'),
(15,1,21,'ما هي سياسة الإلغاء لديكم؟','من المهم أن يفهم العملاء سياسة الصالون المتعلقة بالإلغاء، بما في ذلك أية رسوم أو متطلبات للإشعار.',7,'2024-05-01 22:09:42','2024-05-01 22:09:42'),
(16,1,21,'هل تقدمون عروضًا خاصة أو برامج وفاء؟','قد يسأل العملاء عن الخصومات، والعروض، أو برامج الولاء لجعل زياراتهم للصالون أكثر كفاءة مالية.',8,'2024-05-01 22:11:36','2024-05-01 22:11:36'),
(31,3,20,'How do I book a trip with Dreamscapes Travel Agency?','To book a trip with Dreamscapes, simply contact us through our website, email, or phone. Our experienced travel advisors will guide you through the process and assist you in creating a personalized itinerary tailored to your preferences.',1,'2024-05-01 23:36:21','2024-05-01 23:36:21'),
(32,3,20,'What types of destinations does Dreamscapes offer?','Dreamscapes offers a wide range of destinations, including exotic beach getaways, adventurous wilderness expeditions, cultural explorations, urban escapes, and luxury retreats. Whether you\'re craving relaxation, adventure, or cultural immersion, we have the perfect destination for you.',2,'2024-05-01 23:36:45','2024-05-01 23:36:45'),
(33,3,20,'Are the itineraries customizable?','Yes, absolutely! At Dreamscapes, we believe in the power of personalized travel. Our experienced travel advisors will work closely with you to understand your interests, preferences, and budget, and tailor your itinerary accordingly to ensure it meets your specific needs and desires.',3,'2024-05-01 23:37:06','2024-05-01 23:37:06'),
(34,3,20,'Does Dreamscapes provide travel insurance?','While Dreamscapes does not directly provide travel insurance, our experienced travel advisors can assist you in selecting and purchasing a suitable travel insurance policy from reputable providers. We strongly recommend purchasing travel insurance to protect yourself against unforeseen events or emergencies during your trip.',4,'2024-05-01 23:37:30','2024-05-01 23:37:30'),
(35,3,20,'What safety measures does Dreamscapes have in place for travelers?','The safety and well-being of our clients are our top priorities. Dreamscapes closely monitors travel advisories and updates from relevant authorities to ensure the safety of our travelers. We provide up-to-date information on health and safety protocols, travel restrictions, and entry requirements for each destination.',5,'2024-05-01 23:37:53','2024-05-01 23:37:53'),
(36,3,20,'Can Dreamscapes assist with special requests or accommodations?','Absolutely! Whether you require special dietary accommodations, accessibility assistance, or specific room preferences, our dedicated travel advisors are here to accommodate your needs and ensure that your trip is comfortable and hassle-free.',6,'2024-05-01 23:38:19','2024-05-01 23:38:19'),
(37,3,20,'What happens if I need to cancel or modify my trip?','In the event that you need to cancel or modify your trip, please contact us as soon as possible. Our flexible cancellation and modification policies vary depending on the terms and conditions of your booking, but we will do our best to accommodate your needs and minimize any associated fees or penalties.',7,'2024-05-01 23:38:41','2024-05-01 23:38:41'),
(38,3,20,'Does Dreamscapes offer group travel options?','Yes, Dreamscapes offers group travel options for families, friends, corporate groups, and special interest groups. Whether you\'re planning a family reunion, a destination wedding, a corporate retreat, or a group tour, our experienced team can customize an itinerary to suit your group\'s needs and interests.',8,'2024-05-01 23:39:02','2024-05-01 23:39:02'),
(39,3,21,'كيف يمكنني حجز رحلة مع وكالة ديمسكيبس للسفر؟','لحجز رحلة مع ديمسكيبس، ما عليك سوى الاتصال بنا عبر موقعنا الإلكتروني، البريد الإلكتروني، أو الهاتف. سيقوم مستشارو السفر ذوي الخبرة لدينا بإرشادك خلال العملية ومساعدتك في إنشاء جدول سفر مخصص يتماشى مع تفضيلاتك.',1,'2024-05-01 23:40:15','2024-05-01 23:40:15'),
(40,3,21,'ما هي أنواع الوجهات التي تقدمها ديمسكيبس؟','تقدم ديمسكيبس مجموعة متنوعة من الوجهات، بما في ذلك رحلات الاسترخاء على الشواطئ الاستوائية، ورحلات المغامرة في البراري الوعرة، والرحلات الثقافية، والهروب الحضري، والمنتجعات الفاخرة. سواء كنت تتوق إلى الاسترخاء، أو المغامرة، أو التمتع بالثقافة، فلدينا الوجهة المثالية لك.',2,'2024-05-01 23:41:01','2024-05-01 23:41:01'),
(41,3,21,'هل يمكن تخصيص جداول السفر؟','نعم، بالتأكيد! في ديمسكيبس، نؤمن بقوة السفر المخصص. سيعمل مستشارو السفر ذوو الخبرة لدينا بشكل وثيق معك لفهم اهتماماتك وتفضيلاتك وميزانيتك، وضبط جدول السفر الخاص بك وفقًا لذلك لضمان تلبية احتياجاتك ورغباتك الخاصة.',3,'2024-05-01 23:41:31','2024-05-01 23:41:31'),
(42,3,21,'هل تقدم ديمسكيبس تأمين السفر؟','بالرغم من أن ديمسكيبس لا تقدم مباشرة تأمين السفر، إلا أن مستشاري السفر ذوي الخبرة لدينا يمكنهم مساعدتك في اختيار وشراء وثيقة تأمين سفر من مزودي خدمات موثوق بهم. نوصي بشدة بشراء تأمين السفر لحماية نفسك من الأحداث غير المتوقعة أو الطوارئ خلال رحلتك.',4,'2024-05-01 23:41:57','2024-05-01 23:41:57'),
(43,3,21,'ما الإجراءات الأمنية التي تتخذها ديمسكيبس للمسافرين؟','السلامة وراحة عملائنا هما أولويتنا القصوى. يراقب ديمسكيبس بعناية الإرشادات السفرية والتحديثات من السلطات المختصة لضمان سلامة مسافرينا. نوفر معلومات محدثة عن البروتوكولات الصحية والسلامة،',5,'2024-05-01 23:47:54','2024-05-01 23:47:54'),
(44,3,21,'هل يمكن لديمسكيبس مساعدتي في طلبات أو احتياجات خاصة؟','بالتأكيد! سواء كنت بحاجة إلى تلبية احتياجات غذائية خاصة، أو مساعدة في الوصول، أو تفضيلات غرف محددة، فإن مستشاري السفر المخصصين لدينا هنا لتلبية احتياجاتك وضمان أن رحلتك مريحة وخالية من المتاعب.',6,'2024-05-01 23:48:25','2024-05-01 23:48:25'),
(45,3,21,'ماذا يحدث إذا كان لي الحاجة لإلغاء أو تعديل رحلتي؟','في حالة الحاجة إلى إلغاء أو تعديل رحلتك، يرجى الاتصال بنا في أقرب وقت ممكن. تختلف سياسات الإلغاء والتعديل لدينا اعتمادًا على الشروط والأحكام المتعلقة بحجزك، ولكننا سنبذل قصارى جهدنا لتلبية احتياجاتك وتقليل أي رسوم أو عقوبات مرتبطة بها.',7,'2024-05-01 23:49:03','2024-05-01 23:49:03'),
(46,3,21,'هل تقدم ديمسكيبس خيارات السفر الجماعي؟','نعم، تقدم ديمسكيبس خيارات السفر الجماعي للعائلات والأصدقاء والم',8,'2024-05-01 23:49:30','2024-05-01 23:49:30'),
(47,4,20,'Is parking available at Tranquil Haven Hotel?','Yes, the hotel offers complimentary parking facilities for guests, including both self-parking and valet services.',1,'2024-05-02 02:45:46','2024-05-02 02:45:46'),
(49,4,20,'Does Tranquil Haven Hotel offer airport shuttle service?','Yes, the hotel provides airport shuttle services for guests\' convenience. Please contact the concierge desk to arrange transportation.',2,'2024-05-02 02:46:47','2024-05-02 02:46:47'),
(50,4,20,'Are pets allowed at Tranquil Haven Hotel?','Yes, Tranquil Haven Hotel is pet-friendly. Guests are welcome to bring their furry companions along for the stay. Additional charges or restrictions may apply.',3,'2024-05-02 02:50:11','2024-05-02 02:50:11'),
(51,4,20,'What dining options are available at Tranquil Haven Hotel?','The hotel features a fine dining restaurant serving a diverse menu of local and international cuisine, as well as a casual cafe or lounge for light bites and beverages.',4,'2024-05-02 02:50:36','2024-05-02 02:50:36'),
(52,4,20,'Does Tranquil Haven Hotel have a spa and wellness center?','Yes, the hotel offers a tranquil spa and wellness center where guests can indulge in massage therapies, body treatments, yoga sessions, and more.',5,'2024-05-02 02:51:03','2024-05-02 02:51:03'),
(53,4,20,'Are there any recreational activities available at Tranquil Haven Hotel?','Yes, guests can enjoy a variety of recreational amenities including an outdoor swimming pool, fitness center, and opportunities for water sports such as swimming, surfing, and beach volleyball.',6,'2024-05-02 02:52:00','2024-05-02 02:52:00'),
(54,4,20,'What types of events can be hosted at Tranquil Haven Hotel?','The hotel offers event spaces suitable for weddings, conferences, meetings, and other special occasions. Catering services and audiovisual equipment are available upon request.',7,'2024-05-02 02:52:29','2024-05-02 02:52:29'),
(55,4,20,'Does Tranquil Haven Hotel offer special packages or deals for guests?','Yes, the hotel often has special packages and promotions available for guests, including honeymoon packages, spa retreats, and seasonal offers. Be sure to check the hotel\'s website or contact reservations for more information.',8,'2024-05-02 02:52:52','2024-05-02 02:52:52'),
(56,4,21,'هل يتوفر موقف للسيارات لدى ترانكويل هافن هوتل؟','نعم، يوفّر الفندق مرافق صف السيارات مجانًا للنزلاء، بما في ذلك صف السيارات ذاتيًا وخدمات صف السيارات.',1,'2024-05-02 02:54:48','2024-05-02 02:54:48'),
(57,4,21,'هل يوفّر فندق ترانكويل هافن خدمة النقل من وإلى المطار؟','نعم، يوفّر الفندق خدمات النقل من وإلى المطار لراحة النزلاء. يرجى الاتصال بمكتب الكونسيرج لترتيب النقل.',2,'2024-05-02 02:55:41','2024-05-02 02:55:41'),
(58,4,21,'هل يُسمح بإقامة الحيوانات الأليفة في ترانكويل هافن هوتل؟','نعم، فندق ترانكويل هافن يسمح بالحيوانات الأليفة. الضيوف مدعوون لإحضار رفاقهم ذوي الفراء طوال فترة الإقامة. قد يتم تطبيق رسوم أو قيود إضافية.',3,'2024-05-02 02:56:21','2024-05-02 02:56:21'),
(59,4,21,'ما خيارات الطعام المتوفرة لدى ترانكويل هافن هوتل؟','يضم الفندق مطعمًا فاخرًا يقدم قائمة متنوعة من المأكولات المحلية والعالمية، بالإضافة إلى مقهى غير رسمي أو صالة لتناول الوجبات الخفيفة والمشروبات.',4,'2024-05-02 02:58:07','2024-05-02 02:58:07'),
(60,4,21,'هل لدى فندق ترانكويل هافن سبا ومركز صحي؟','نعم، يوفر الفندق سبا هادئ ومركزًا صحيًا حيث يمكن للضيوف الاستمتاع بعلاجات التدليك وعلاجات الجسم وجلسات اليوغا والمزيد.',5,'2024-05-02 02:58:43','2024-05-02 02:58:43'),
(61,4,21,'هل توجد أي أنشطة ترفيهية متوفرة لدى ترانكويل هافن هوتل؟','نعم، يمكن للنزلاء الاستمتاع بمجموعة متنوعة من المرافق الترفيهية بما في ذلك حمام سباحة خارجي ومركز للياقة البدنية وفرص لممارسة الرياضات المائية مثل السباحة وركوب الأمواج وكرة الطائرة الشاطئية.',6,'2024-05-02 02:59:31','2024-05-02 02:59:31'),
(62,4,21,'ما هي أنواع الفعاليات التي يمكن استضافتها في فندق ترانكويل هافن؟','يوفر الفندق مساحات مناسبة لحفلات الزفاف والمؤتمرات والاجتماعات والمناسبات الخاصة الأخرى. تتوفر خدمات تقديم الطعام والمعدات السمعية والبصرية عند الطلب.',7,'2024-05-02 03:00:07','2024-05-02 03:00:07'),
(63,5,20,'What are your opening hours?','FeastHaven Restaurant is open from [insert opening hours here] every day of the week.',1,'2024-05-05 21:16:51','2024-05-05 21:16:51'),
(64,5,20,'Do you offer vegetarian/vegan options?','Yes, we offer a variety of vegetarian and vegan dishes on our menu. Our chefs are happy to accommodate dietary preferences and restrictions.',2,'2024-05-05 21:17:17','2024-05-05 21:17:17'),
(65,5,20,'Is reservations required?','While reservations are not required, they are recommended, especially during peak hours or for larger groups, to ensure we can accommodate you promptly.',3,'2024-05-05 21:17:42','2024-05-05 21:17:42'),
(66,5,20,'Do you cater to special events or private parties?','Absolutely! FeastHaven Restaurant offers catering services for special events, parties, and gatherings. Please contact us in advance to discuss your requirements.',4,'2024-05-05 21:18:05','2024-05-05 21:18:05'),
(67,5,20,'Is parking available?','Yes, we provide parking facilities for our guests. Additionally, valet parking service is available during select hours.',5,'2024-05-05 21:18:29','2024-05-05 21:18:29'),
(68,5,20,'Do you have a dress code?','While there is no strict dress code, we recommend smart casual attire for a comfortable dining experience.',6,'2024-05-05 21:18:57','2024-05-05 21:18:57'),
(69,5,20,'Are gift cards available for purchase?','Yes, we offer gift cards that can be purchased in various denominations. They make perfect gifts for friends, family, or colleagues who appreciate great food and dining experiences.',7,'2024-05-05 21:19:22','2024-05-05 21:19:22'),
(70,5,20,'Do you accommodate food allergies or intolerances?','Absolutely! Please inform your server about any allergies or intolerances, and our chefs will do their best to accommodate your needs and prepare your meal safely.',8,'2024-05-05 21:19:51','2024-05-05 21:19:51'),
(71,5,21,'ماهو ساعات العمل لديك؟','يفتح مطعم FeastHaven أبوابه اعتبارًا من [أدخل ساعات العمل هنا] طوال أيام الأسبوع.',1,'2024-05-05 21:16:51','2024-05-05 21:21:36'),
(72,5,21,'هل تقدمون خيارات نباتية/نباتية؟','نعم، نحن نقدم مجموعة متنوعة من الأطباق النباتية والنباتية في قائمتنا. يسعد الطهاة لدينا بتلبية التفضيلات والقيود الغذائية.',2,'2024-05-05 21:17:17','2024-05-05 21:24:35'),
(73,5,21,'هل الحجز مطلوب؟','على الرغم من أن الحجز ليس مطلوبًا، إلا أنه يوصى به، خاصة خلال ساعات الذروة أو للمجموعات الكبيرة، لضمان قدرتنا على استيعابك على الفور.',3,'2024-05-05 21:17:42','2024-05-05 21:24:14'),
(74,5,21,'هل تلبي احتياجات المناسبات الخاصة أو الحفلات الخاصة؟','قطعاً! يقدم مطعم  خدمات تقديم الطعام للمناسبات الخاصة والحفلات والتجمعات. يرجى الاتصال بنا مقدما لمناقشة الاحتياجات الخاصة بك.',4,'2024-05-05 21:18:05','2024-05-05 21:23:50'),
(75,5,21,'هل تتوفر مواقف للسيارات؟','نعم، نحن نوفر مرافق وقوف السيارات لضيوفنا. بالإضافة إلى ذلك، تتوفر خدمة صف السيارات خلال ساعات محددة.',5,'2024-05-05 21:18:29','2024-05-05 21:23:21'),
(76,5,21,'هل لديك قواعد اللباس؟','على الرغم من عدم وجود قواعد صارمة للملابس، إلا أننا نوصي بارتداء ملابس غير رسمية أنيقة لتجربة تناول طعام مريحة.',6,'2024-05-05 21:18:57','2024-05-05 21:22:56'),
(77,5,21,'هل بطاقات الهدايا متاحة للشراء؟','نعم، نحن نقدم بطاقات الهدايا التي يمكن شراؤها بفئات مختلفة. إنها تمثل هدايا مثالية للأصدقاء أو العائلة أو الزملاء الذين يقدرون تجارب الطعام وتناول الطعام الرائعة.',7,'2024-05-05 21:19:22','2024-05-05 21:22:30'),
(78,5,21,'هل تستوعب الحساسية الغذائية أو عدم تحملها؟','قطعاً! يرجى إبلاغ الخادم الخاص بك عن أي حساسية أو عدم تحمل، وسيبذل الطهاة لدينا قصارى جهدهم لتلبية احتياجاتك وإعداد وجبتك بأمان.',8,'2024-05-05 21:19:51','2024-05-05 21:22:06'),
(79,6,20,'Do you offer financing options for purchasing vehicles?','Yes, we provide various financing options tailored to meet your needs. Our finance specialists can assist you in finding the best solution that fits your budget and preferences.',1,'2024-05-05 22:09:28','2024-05-05 22:09:28'),
(80,6,20,'Do you accept trade-ins?','Absolutely, we accept trade-ins. Our team will assess your vehicle\'s value and provide a competitive offer, which can be applied towards your new purchase or used as cash.',2,'2024-05-05 22:09:53','2024-05-05 22:09:53'),
(81,6,20,'What kind of warranty do your vehicles come with?','Our vehicles typically come with manufacturer warranties, and we also offer extended warranty options for additional coverage and peace of mind. Our sales team will provide detailed information about warranty coverage for specific vehicles.',3,'2024-05-05 22:10:17','2024-05-05 22:10:17'),
(82,6,20,'Do you offer maintenance services for the vehicles you sell?','Yes, we have a state-of-the-art service center staffed with factory-trained technicians who specialize in servicing the types of vehicles we sell. From routine maintenance to complex repairs, we ensure your vehicle receives the highest quality care.',4,'2024-05-05 22:10:38','2024-05-05 22:10:38'),
(83,6,20,'Can I schedule a test drive before making a purchase?','Of course! We encourage customers to schedule test drives to experience our vehicles firsthand. Simply contact our sales team to arrange a convenient time for your test drive.',5,'2024-05-05 22:11:04','2024-05-05 22:11:04'),
(84,6,20,'Do you sell pre-owned vehicles as well?','Yes, we offer a selection of pre-owned vehicles that undergo thorough inspections to ensure they meet our quality standards. Each pre-owned vehicle comes with a detailed history report for transparency.',6,'2024-05-05 22:11:26','2024-05-05 22:11:26'),
(85,6,20,'Can I customize or order a specific vehicle with certain features?','Depending on availability and manufacturer options, we may be able to customize or special order a vehicle to your specifications. Our sales team can provide more information about customization options and lead times.',7,'2024-05-05 22:11:47','2024-05-05 22:11:47'),
(86,6,20,'What sets Precision Performance Motors apart from other dealerships?','At Precision Performance Motors, we prioritize customer satisfaction and offer a comprehensive range of services, including a premium vehicle selection, exceptional customer service, state-of-the-art service center, and more. Our commitment to excellence and passion for automobiles set us apart as a premier destination for automotive enthusiasts.',8,'2024-05-05 22:12:10','2024-05-05 22:12:10'),
(87,6,21,'هل تقدمون خيارات تمويل لشراء المركبات؟','نعم، نحن نقدم خيارات تمويل متنوعة مصممة خصيصًا لتلبية احتياجاتك. يمكن للمتخصصين الماليين لدينا مساعدتك في العثور على أفضل الحلول التي تناسب ميزانيتك وتفضيلاتك.',1,'2024-05-05 22:09:28','2024-05-05 22:17:02'),
(88,6,21,'هل تقبلون المقايضة؟','بالتأكيد، نحن نقبل المقايضة. سيقوم فريقنا بتقييم قيمة سيارتك وتقديم عرض تنافسي، والذي يمكن تطبيقه على عملية الشراء الجديدة أو استخدامه نقدًا.',2,'2024-05-05 22:09:53','2024-05-05 22:16:40'),
(89,6,21,'ما هو نوع الضمان الذي تأتي به مركباتك؟','تأتي سياراتنا عادةً مع ضمانات الشركة المصنعة، كما نقدم أيضًا خيارات ضمان ممتدة لتغطية إضافية وراحة البال. سيقدم فريق المبيعات لدينا معلومات مفصلة حول تغطية الضمان لمركبات محددة.',3,'2024-05-05 22:10:17','2024-05-05 22:16:06'),
(90,6,21,'هل تقدمون خدمات صيانة للمركبات التي تبيعونها؟','نعم، لدينا مركز خدمة متطور مزود بفنيين مدربين في المصنع ومتخصصين في خدمة أنواع المركبات التي نبيعها. بدءًا من الصيانة الروتينية وحتى الإصلاحات المعقدة، نضمن حصول سيارتك على أعلى مستوى من الرعاية.',4,'2024-05-05 22:10:38','2024-05-05 22:15:42'),
(91,6,21,'هل يمكنني تحديد موعد لتجربة القيادة قبل إجراء عملية الشراء؟','بالطبع! نحن نشجع العملاء على تحديد موعد لاختبار القيادة لتجربة سياراتنا بشكل مباشر. ما عليك سوى الاتصال بفريق المبيعات لدينا لترتيب وقت مناسب لاختبار القيادة الخاص بك.',5,'2024-05-05 22:11:04','2024-05-05 22:15:19'),
(92,6,21,'هل تبيعون المركبات المستعملة أيضًا؟','نعم، نحن نقدم مجموعة مختارة من السيارات المستعملة التي تخضع لفحوصات شاملة للتأكد من أنها تلبي معايير الجودة لدينا. تأتي كل مركبة مملوكة مسبقًا مع تقرير تاريخي مفصل من أجل الشفافية.',6,'2024-05-05 22:11:26','2024-05-05 22:14:33'),
(93,6,21,'هل يمكنني تخصيص أو طلب سيارة معينة بميزات معينة؟','اعتمادًا على التوفر وخيارات الشركة المصنعة، قد نتمكن من تخصيص السيارة أو طلبها بشكل خاص وفقًا لمواصفاتك. يمكن لفريق المبيعات لدينا تقديم المزيد من المعلومات حول خيارات التخصيص والمهل الزمنية.',7,'2024-05-05 22:11:47','2024-05-05 22:14:56'),
(94,6,21,'ما الذي يميز شركة محركات الأداء الدقيقةعن الوكلاء الآخرين؟','في شركة ، نعطي الأولوية لرضا العملاء ونقدم مجموعة شاملة من الخدمات، بما في ذلك اختيار السيارات المتميزة وخدمة العملاء الاستثنائية ومركز الخدمة المتطور والمزيد. إن التزامنا بالتميز والشغف بالسيارات يميزنا كوجهة رائدة لعشاق السيارات.',8,'2024-05-05 22:12:10','2024-05-05 22:14:08'),
(95,7,20,'What types of residences are available at Blue Sky Estates?','Blue Sky Estates offers a variety of luxurious residences including spacious apartments, elegant condominiums, and waterfront villas, each designed to exceed the expectations of discerning residents.',1,'2024-05-05 23:25:16','2024-05-05 23:25:16'),
(96,7,20,'Are pets allowed at Blue Sky Estates?','Yes, Blue Sky Estates is a pet-friendly community. We welcome residents to bring their furry companions and provide amenities such as a designated dog park and pet washing station for their convenience.',2,'2024-05-05 23:25:39','2024-05-05 23:25:39'),
(97,7,20,'What amenities are included for residents?','Residents of Blue Sky Estates enjoy access to a wide range of world-class amenities including a riverside infinity pool, fully-equipped fitness center, elegant clubhouse, landscaped gardens, and more.',3,'2024-05-05 23:26:00','2024-05-05 23:26:00'),
(98,7,20,'Is there on-site parking available for residents and guests?','Yes, Blue Sky Estates offers convenient on-site parking options including reserved parking spaces for residents and valet parking services for guests.',4,'2024-05-05 23:26:20','2024-05-05 23:26:20'),
(99,7,20,'How does Blue Sky Estates prioritize safety and security?','The safety and security of our residents are paramount. Blue Sky Estates features gated access, 24/7 security surveillance, and on-site management to ensure a secure living environment for all.',5,'2024-05-05 23:26:39','2024-05-05 23:26:39'),
(100,7,20,'What recreational activities are available for residents?','Residents of Blue Sky Estates have access to a variety of recreational activities including water sports on the St. Johns River, walking trails, community events, and social gatherings organized by our dedicated team.',6,'2024-05-05 23:27:02','2024-05-05 23:27:02'),
(101,7,20,'Is Blue Sky Estates conveniently located near shopping and dining destinations?','Yes, Blue Sky Estates is situated in close proximity to premier shopping centers, fine dining restaurants, entertainment venues, and cultural attractions, providing residents with easy access to everything Jacksonville has to offer.',7,'2024-05-05 23:27:25','2024-05-05 23:27:25'),
(102,7,20,'Does Blue Sky Estates offer concierge services for residents?','Yes, Blue Sky Estates provides personalized concierge services to assist residents with various tasks including package delivery, dry cleaning, restaurant reservations, and more.',8,'2024-05-05 23:27:56','2024-05-05 23:27:56'),
(103,7,21,'ما هي أنواع المساكن المتوفرة في بلو سكاي إستيتس؟','تقدم بلو سكاي إستيتس مجموعة متنوعة من المساكن الفاخرة بما في ذلك الشقق الفسيحة والوحدات السكنية الأنيقة والفلل ذات الواجهة البحرية، وكل منها مصممة لتتجاوز توقعات السكان المميزين.',1,'2024-05-05 23:25:16','2024-05-05 23:33:00'),
(104,7,21,'هل يُسمح بإقامة الحيوانات الأليفة في بلو سكاي إستيتس؟','نعم، بلو سكاي إستيتس مجتمع صديق للحيوانات الأليفة. نرحب بالمقيمين لإحضار رفاقهم ذوي الفراء وتوفير وسائل الراحة مثل حديقة مخصصة للكلاب ومحطة لغسيل الحيوانات الأليفة من أجل راحتهم.',2,'2024-05-05 23:25:39','2024-05-05 23:32:36'),
(105,7,21,'ما هي وسائل الراحة المتوفرة للمقيمين؟','يتمتع المقيمون بإمكانية الوصول إلى مجموعة واسعة من وسائل الراحة ذات المستوى العالمي بما في ذلك مسبح لا متناهي على ضفاف النهر ومركز للياقة البدنية مجهز بالكامل ونادي أنيق وحدائق ذات مناظر طبيعية والمزيد.',3,'2024-05-05 23:26:00','2024-05-05 23:32:11'),
(106,7,21,'هل تتوفر مواقف للسيارات في الموقع للمقيمين والضيوف؟','نعم، توفر بلو سكاي إستيتس خيارات مريحة لوقوف السيارات داخل الموقع بما في ذلك أماكن ركن السيارات المحجوزة للمقيمين وخدمات صف السيارات للضيوف.',4,'2024-05-05 23:26:20','2024-05-05 23:31:43'),
(107,7,21,'كيف يتم تحديد أولويات السلامة والأمن؟','سلامة وأمن سكاننا لها أهمية قصوى. يتميز ببوابة دخول ومراقبة أمنية على مدار الساعة طوال أيام الأسبوع وإدارة في الموقع لضمان بيئة معيشية آمنة للجميع.',5,'2024-05-05 23:26:39','2024-05-05 23:31:20'),
(108,7,21,'ما هي الأنشطة الترفيهية المتاحة للمقيمين؟','يتمتع سك بإمكانية الوصول إلى مجموعة متنوعة من الأنشطة الترفيهية بما في ذلك الرياضات المائية على نهر سانت جونز ومسارات المشي والفعاليات المجتمعية والتجمعات الاجتماعية التي ينظمها فريقنا المتخصص.',6,'2024-05-05 23:27:02','2024-05-05 23:30:38'),
(109,7,21,'هل يقع بالقرب من وجهات التسوق وتناول الطعام؟','نعم، تقع على مقربة من مراكز التسوق الرائدة والمطاعم الفاخرة وأماكن الترفيه والمعالم الثقافية، مما يوفر للمقيمين سهولة الوصول إلى كل ما تقدمه جاكسونفيل.',7,'2024-05-05 23:27:25','2024-05-05 23:30:05'),
(110,7,21,'هل تقدم شركة بلو سكاي إستيتس خدمات الكونسيرج للمقيمين؟','نعم، توفر شركة خدمات الكونسيرج الشخصية لمساعدة المقيمين في مختلف المهام بما في ذلك توصيل الطرود والتنظيف الجاف وحجوزات المطاعم والمزيد.',8,'2024-05-05 23:27:56','2024-05-05 23:29:27'),
(127,9,20,'What type of cuisine does Wholesome Fare Diner serve?','We specialize in authentic Bengali cuisine with a focus on traditional flavors and locally sourced ingredients.',1,'2024-05-06 20:59:36','2024-05-06 20:59:36'),
(128,9,20,'Do you offer vegetarian and vegan options?','Yes, we have a variety of vegetarian dishes available, and many of our menu items can be modified to accommodate vegan diets upon request.',2,'2024-05-06 20:59:56','2024-05-06 20:59:56'),
(129,9,20,'Is there parking available at the restaurant?','Yes, we provide convenient parking facilities for our guests, making it easy to dine with us.',3,'2024-05-06 21:00:18','2024-05-06 21:00:18'),
(130,9,20,'Do you offer catering services for events and parties?','Yes, we offer catering services for a wide range of events, including weddings, corporate gatherings, and private parties. Please contact us for more information and to discuss your specific needs.',4,'2024-05-06 21:00:41','2024-05-06 21:00:41'),
(131,9,20,'Are reservations required, or can we walk in?','While reservations are not required, especially for smaller groups, we recommend making a reservation for larger parties to ensure we can accommodate you comfortably.',5,'2024-05-06 21:01:01','2024-05-06 21:01:01'),
(132,9,20,'Do you have any special offers or promotions?','Yes, we regularly run special promotions and discounts. Be sure to follow us on social media or sign up for our newsletter to stay updated on our latest offers.',6,'2024-05-06 21:01:23','2024-05-06 21:01:23'),
(133,9,20,'Can I order food for takeaway or delivery?','Absolutely! We offer both takeaway and delivery services for your convenience. You can place your order over the phone or through our online ordering platform.',7,'2024-05-06 21:01:44','2024-05-06 21:01:44'),
(134,9,20,'Are you open for lunch and dinner?','Yes, we are open for both lunch and dinner service. Our operating hours are [insert operating hours here], so feel free to drop by anytime for a delicious meal!',8,'2024-05-06 21:02:06','2024-05-06 21:02:06'),
(135,9,21,'ما نوع المطبخ الذي يقدمه مطعم؟','نحن متخصصون في المأكولات البنغالية الأصيلة مع التركيز على النكهات التقليدية والمكونات من مصادر محلية.',1,'2024-05-06 20:59:36','2024-05-06 21:04:54'),
(136,9,21,'هل تقدمون خيارات نباتية ونباتية؟','نعم، لدينا مجموعة متنوعة من الأطباق النباتية المتاحة، ويمكن تعديل العديد من عناصر القائمة لدينا لاستيعاب الأنظمة الغذائية النباتية عند الطلب.',2,'2024-05-06 20:59:56','2024-05-06 21:05:19'),
(137,9,21,'هل تتوفر مواقف للسيارات في المطعم؟','نعم، نحن نوفر مرافق مريحة لوقوف السيارات لضيوفنا، مما يجعل تناول الطعام معنا أمرًا سهلاً.',3,'2024-05-06 21:00:18','2024-05-06 21:05:44'),
(138,9,21,'هل تقدمون خدمات تقديم الطعام للمناسبات والحفلات؟','نعم، نحن نقدم خدمات تقديم الطعام لمجموعة واسعة من المناسبات، بما في ذلك حفلات الزفاف وتجمعات الشركات والحفلات الخاصة. يرجى الاتصال بنا للحصول على مزيد من المعلومات ومناقشة احتياجاتك الخاصة.',4,'2024-05-06 21:00:41','2024-05-06 21:06:08'),
(139,9,21,'هل الحجز ضروري أم يمكننا الدخول؟','على الرغم من أن الحجز غير مطلوب، خاصة للمجموعات الصغيرة، إلا أننا نوصي بإجراء حجز للحفلات الكبيرة للتأكد من أننا نستطيع استيعابك بشكل مريح.',5,'2024-05-06 21:01:01','2024-05-06 21:06:33'),
(140,9,21,'هل لديكم أي عروض أو عروض ترويجية خاصة؟','نعم، نحن نجري بانتظام عروضًا ترويجية وخصومات خاصة. تأكد من متابعتنا على وسائل التواصل الاجتماعي أو الاشتراك في النشرة الإخبارية لدينا لتبقى على اطلاع بأحدث عروضنا.',6,'2024-05-06 21:01:23','2024-05-06 21:04:25'),
(141,9,21,'هل يمكنني طلب الطعام للوجبات الجاهزة أو التوصيل؟','قطعاً! نحن نقدم خدمات الوجبات الجاهزة والتوصيل لراحتك. يمكنك تقديم طلبك عبر الهاتف أو من خلال منصة الطلب عبر الإنترنت.',7,'2024-05-06 21:01:44','2024-05-06 21:04:02'),
(142,9,21,'هل أنت مفتوح لتناول طعام الغداء والعشاء؟','نعم، نحن منفتحون على خدمة الغداء والعشاء. ساعات العمل لدينا هي [أدخل ساعات العمل هنا]، لذا لا تتردد في الحضور في أي وقت لتناول وجبة لذيذة!',8,'2024-05-06 21:02:06','2024-05-06 21:03:36'),
(143,10,20,'Do you take reservations?','Reservations are not required as we operate on a first-come, first-served basis.',1,'2024-05-06 21:34:25','2024-05-06 21:34:25'),
(144,10,20,'Is your café pet-friendly?','Yes, we welcome well-behaved pets in our outdoor seating area.',2,'2024-05-06 21:34:47','2024-05-06 21:34:47'),
(145,10,20,'Do you offer vegan or gluten-free options?','Yes, we have a selection of vegan and gluten-free items available on our menu.',3,'2024-05-06 21:35:10','2024-05-06 21:35:10'),
(146,10,20,'Can I host private events or parties at your café?','Absolutely! Please contact us for more information on hosting your event at Café Noir et Blanc.',4,'2024-05-06 21:35:29','2024-05-06 21:35:29'),
(147,10,20,'Do you offer Wi-Fi for customers?','Yes, complimentary Wi-Fi is available for our patrons.',5,'2024-05-06 21:35:53','2024-05-06 21:35:53'),
(148,10,20,'Do you have gift cards available for purchase?','Yes, gift cards are available for purchase in-store.',6,'2024-05-06 21:36:14','2024-05-06 21:36:14'),
(149,10,20,'Can I place a takeout or delivery order?','Yes, we offer takeout options, and delivery is available through select third-party platforms.',7,'2024-05-06 21:36:35','2024-05-06 21:36:35'),
(150,10,21,'هل تأخذ تحفظات؟','الحجز غير مطلوب لأننا نعمل على أساس أسبقية الحضور.',1,'2024-05-06 21:34:25','2024-05-06 21:40:27'),
(151,10,21,'هل المقهى الخاص بك صديق للحيوانات الأليفة؟','نعم، نحن نرحب بالحيوانات الأليفة حسنة السلوك في منطقة الجلوس الخارجية.',2,'2024-05-06 21:34:47','2024-05-06 21:40:04'),
(152,10,21,'هل تقدمون خيارات نباتية أو خالية من الغلوتين؟','نعم، لدينا مجموعة مختارة من العناصر النباتية والخالية من الغلوتين المتوفرة في قائمتنا.',3,'2024-05-06 21:35:10','2024-05-06 21:39:42'),
(153,10,21,'هل يمكنني استضافة مناسبات أو حفلات خاصة في المقهى الخاص بك؟','قطعاً! يرجى الاتصال بنا للحصول على مزيد من المعلومات حول استضافة الحدث الخاص بك في .',4,'2024-05-06 21:35:29','2024-05-06 21:39:17'),
(154,10,21,'هل تقدمون خدمة الواي فاي للعملاء؟','نعم، تتوفر خدمة الواي فاي المجانية لعملائنا.',5,'2024-05-06 21:35:53','2024-05-06 21:38:43'),
(155,10,21,'هل لديك بطاقات هدايا متاحة للشراء؟','نعم، بطاقات الهدايا متاحة للشراء في المتجر.',6,'2024-05-06 21:36:14','2024-05-06 21:38:20'),
(156,10,21,'هل يمكنني تقديم طلب خارجي أو توصيل؟','نعم، نحن نقدم خيارات تناول الطعام خارج المنزل، والتسليم متاح من خلال منصات مختارة تابعة لجهات خارجية.',7,'2024-05-06 21:36:35','2024-05-06 21:37:56'),
(157,11,20,'Do you offer installation services for large equipment purchases?','Yes, we provide professional installation services for all large equipment purchases to ensure proper setup and functionality.',1,'2024-05-06 22:44:30','2024-05-06 22:44:30'),
(158,11,20,'What payment methods do you accept?','We accept various payment methods including credit/debit cards, cash, and electronic transfers for your convenience.',2,'2024-05-06 22:44:51','2024-05-06 22:44:51'),
(159,11,20,'Do you provide warranties for your products?','Yes, we offer warranties on all our products to guarantee their quality and performance. Warranty durations may vary depending on the item.',3,'2024-05-06 22:45:15','2024-05-06 22:45:15'),
(160,11,20,'Can I return or exchange an item if it doesn\'t meet my needs?','Yes, we have a hassle-free return and exchange policy within a specified timeframe. Please refer to our return policy for more details.',4,'2024-05-06 22:45:38','2024-05-06 22:45:38'),
(161,11,20,'Do you offer financing options for larger purchases?','Yes, we provide financing options to help you make larger purchases more manageable. Our staff can assist you in exploring available financing plans.',5,'2024-05-06 22:46:02','2024-05-06 22:46:02'),
(162,11,20,'Are there any special discounts or promotions available?','We frequently run special promotions and discounts on select products. Check our website or visit our store to stay updated on current offers.',6,'2024-05-06 22:46:24','2024-05-06 22:46:24'),
(163,11,20,'Can I schedule a consultation to discuss my fitness goals and equipment needs?','Absolutely! We encourage customers to schedule consultations with our fitness experts who can provide personalized recommendations based on your goals and requirements.',7,'2024-05-06 22:46:45','2024-05-06 22:46:45'),
(164,11,20,'Do you offer maintenance services for fitness equipment?','Yes, we offer maintenance services to keep your fitness equipment in top condition. Our technicians can perform regular maintenance checks and repairs as needed.',8,'2024-05-06 22:47:06','2024-05-06 22:47:06'),
(165,11,21,'هل تقدمون خدمات التركيب لشراء المعدات الكبيرة؟','نعم، نحن نقدم خدمات تركيب احترافية لجميع مشتريات المعدات الكبيرة لضمان الإعداد والأداء المناسبين.',1,'2024-05-06 22:44:30','2024-05-06 22:49:30'),
(166,11,21,'ما هي طرق الدفع التي تقبلونها؟','نحن نقبل طرق الدفع المختلفة بما في ذلك بطاقات الائتمان/الخصم والنقد والتحويلات الإلكترونية من أجل راحتك.',2,'2024-05-06 22:44:51','2024-05-06 22:51:02'),
(167,11,21,'هل تقدمون ضمانات لمنتجاتكم؟','نعم، نقدم ضمانات على جميع منتجاتنا لضمان جودتها وأدائها. قد تختلف فترات الضمان حسب السلعة.',3,'2024-05-06 22:45:15','2024-05-06 22:49:53'),
(168,11,21,'هل يمكنني إرجاع أو استبدال منتج إذا كان لا يلبي احتياجاتي؟','نعم، لدينا سياسة إرجاع واستبدال خالية من المتاعب خلال إطار زمني محدد. يرجى الرجوع إلى سياسة الإرجاع لدينا لمزيد من التفاصيل.',4,'2024-05-06 22:45:38','2024-05-06 22:51:23'),
(169,11,21,'هل تقدمون خيارات تمويل للمشتريات الكبيرة؟','نعم، نحن نقدم خيارات التمويل لمساعدتك على إدارة عمليات الشراء الكبيرة بشكل أكثر سهولة. يمكن لموظفينا مساعدتك في استكشاف خطط التمويل المتاحة.',5,'2024-05-06 22:46:02','2024-05-06 22:50:39'),
(170,11,21,'هل هناك أي خصومات أو عروض ترويجية خاصة متاحة؟','نقوم بشكل متكرر بتشغيل عروض ترويجية وخصومات خاصة على منتجات مختارة. قم بزيارة موقعنا الإلكتروني أو قم بزيارة متجرنا لتبقى على اطلاع على العروض الحالية.',6,'2024-05-06 22:46:24','2024-05-06 22:50:16'),
(171,11,21,'هل يمكنني تحديد موعد لاستشارة لمناقشة أهداف اللياقة البدنية واحتياجاتي من المعدات؟','قطعاً! نحن نشجع العملاء على تحديد موعد لإجراء مشاورات مع خبراء اللياقة البدنية لدينا الذين يمكنهم تقديم توصيات مخصصة بناءً على أهدافك ومتطلباتك.',7,'2024-05-06 22:46:45','2024-05-06 22:49:08'),
(172,11,21,'هل تقدمون خدمات صيانة أجهزة اللياقة البدنية؟','نعم، نحن نقدم خدمات الصيانة للحفاظ على معدات اللياقة البدنية الخاصة بك في أفضل حالة. يمكن للفنيين لدينا إجراء فحوصات الصيانة والإصلاحات الدورية حسب الحاجة.',8,'2024-05-06 22:47:06','2024-05-06 22:48:45'),
(173,12,20,'What types of hospital beds do you offer?','We offer a wide range of hospital beds including basic, adjustable, specialty (such as bariatric and pediatric), and ICU models to cater to various healthcare settings and patient needs.',1,'2024-05-07 00:23:04','2024-05-07 00:23:04'),
(174,12,20,'Do you provide installation services for the hospital beds?','Yes, we offer professional installation services by skilled technicians to ensure proper setup and functionality of the hospital beds.',2,'2024-05-07 00:23:29','2024-05-07 00:23:29'),
(175,12,20,'What kind of accessories and equipment do you offer for hospital beds?','We provide a variety of accessories and supplementary equipment including bedside tables, overbed trays, bed rails, specialized mattresses, patient lift systems, and more to enhance patient comfort and care.',3,'2024-05-07 00:23:53','2024-05-07 00:23:53'),
(176,12,20,'Do you offer maintenance services for the hospital beds?','Yes, we offer regular maintenance and inspection services to prolong the lifespan of the hospital beds and ensure their optimal performance.',4,'2024-05-07 00:24:14','2024-05-07 00:24:14'),
(177,12,20,'What warranty coverage do you provide for your products?','We provide warranty coverage for all our products, with prompt resolution of any defects or malfunctions covered under the warranty terms.',5,'2024-05-07 00:24:38','2024-05-07 00:24:38'),
(178,12,20,'Can you assist with technical support and troubleshooting if issues arise with the hospital beds?','Absolutely, our dedicated customer support team is available to provide prompt technical support and troubleshooting assistance to address any issues or concerns.',6,'2024-05-07 00:25:04','2024-05-07 00:25:04'),
(179,12,20,'Do you offer personalized consultation to help customers select the right hospital bed for their needs?','Yes, our knowledgeable and friendly staff are here to offer personalized consultation and guidance throughout the selection process, taking into account specific needs, preferences, and budget considerations.',7,'2024-05-07 00:25:23','2024-05-07 00:25:23'),
(180,12,20,'Are you actively involved in the local healthcare community?','Yes, we are actively engaged in the local healthcare community through partnerships with hospitals, clinics, and care facilities. We also participate in health fairs, seminars, and educational events to promote awareness and best practices in patient care.',8,'2024-05-07 00:25:46','2024-05-07 00:25:46'),
(181,12,21,'ما هي أنواع أسرة المستشفيات التي تقدمها؟','نحن نقدم مجموعة واسعة من أسرة المستشفيات بما في ذلك نماذج أساسية وقابلة للتعديل والتخصص (مثل السمنة وطب الأطفال) ونماذج وحدة العناية المركزة لتلبية مختلف إعدادات الرعاية الصحية واحتياجات المرضى.',1,'2024-05-07 00:23:04','2024-05-07 00:32:12'),
(182,12,21,'هل تقدمون خدمات تركيب أسرة المستشفيات؟','نعم، نحن نقدم خدمات التركيب الاحترافية على يد فنيين ماهرين لضمان الإعداد السليم والأداء الوظيفي لأسرة المستشفيات.',2,'2024-05-07 00:23:29','2024-05-07 00:31:51'),
(183,12,21,'ما نوع الملحقات والمعدات التي تقدمها لأسرة المستشفيات؟','نحن نقدم مجموعة متنوعة من الملحقات والمعدات التكميلية بما في ذلك الطاولات الجانبية للسرير، والصواني الموجودة فوق السرير، وقضبان السرير، والمراتب المتخصصة، وأنظمة رفع المرضى، والمزيد لتعزيز راحة المرضى ورعايتهم.',3,'2024-05-07 00:23:53','2024-05-07 00:31:25'),
(184,12,21,'هل تقدمون خدمات الصيانة لأسرة المستشفيات؟','نعم، نقدم خدمات الصيانة والفحص الدورية لإطالة عمر أسرة المستشفى وضمان أدائها الأمثل.',4,'2024-05-07 00:24:14','2024-05-07 00:31:03'),
(185,12,21,'ما هي تغطية الضمان التي تقدمها لمنتجاتك؟','نحن نقدم تغطية الضمان لجميع منتجاتنا، مع حل سريع لأية عيوب أو أعطال تغطيها شروط الضمان.',5,'2024-05-07 00:24:38','2024-05-07 00:30:40'),
(186,12,21,'هل يمكنك المساعدة في الدعم الفني واستكشاف الأخطاء وإصلاحها في حالة ظهور مشكلات مع أسرة المستشفى؟','بالتأكيد، فريق دعم العملاء المخصص لدينا متاح لتقديم الدعم الفني الفوري والمساعدة في استكشاف الأخطاء وإصلاحها لمعالجة أي مشكلات أو مخاوف.',6,'2024-05-07 00:25:04','2024-05-07 00:30:18'),
(187,12,21,'هل تقدمون استشارات شخصية لمساعدة العملاء على اختيار سرير المستشفى المناسب لاحتياجاتهم؟','نعم، موظفونا الودودون وذوو المعرفة متواجدون هنا لتقديم الاستشارة والتوجيه الشخصي طوال عملية الاختيار، مع مراعاة الاحتياجات والتفضيلات المحددة واعتبارات الميزانية.',7,'2024-05-07 00:25:23','2024-05-07 00:29:53'),
(188,12,21,'هل تشارك بنشاط في مجتمع الرعاية الصحية المحلي؟','نعم، نحن نشارك بنشاط في مجتمع الارك أيضًا في المعارض الصحية والندوات والفعاليات التعليمية لتعزيز الوعي وأفضل الممارسات في رعاية المرضى.',8,'2024-05-07 00:25:46','2024-05-07 00:29:29'),
(189,13,20,'What are your salon\'s safety protocols in light of COVID-19?','This question addresses concerns about hygiene and safety measures implemented by the salon to protect customers and staff.',1,'2024-05-01 21:51:22','2024-05-01 21:51:22'),
(190,13,20,'How do I book an appointment?','This addresses the process for scheduling appointments, whether it\'s done online, over the phone, or in person.',2,'2024-05-01 21:51:50','2024-05-01 21:51:50'),
(191,13,20,'What should I expect during my first visit to your salon?','This helps new customers understand what to anticipate, such as consultations, services offered, and the overall experience.',3,'2024-05-01 21:52:12','2024-05-01 21:52:12'),
(192,13,20,'Do you offer consultations before appointments?','Some clients may want to discuss their desired hairstyle or treatment beforehand, so they\'ll inquire about consultation services.',4,'2024-05-01 21:52:37','2024-05-01 21:52:37'),
(193,13,20,'What haircare products do you recommend for my hair type?','This question is common among clients seeking advice on maintaining their hairstyle or color between salon visits.',5,'2024-05-01 21:53:05','2024-05-01 21:53:05'),
(194,13,20,'How long will my appointment take?','Clients often want to plan their day around salon appointments, so they\'ll ask about the expected duration of their visit.',6,'2024-05-01 21:53:26','2024-05-01 21:53:26'),
(195,13,20,'What is your cancellation policy?','It\'s important for clients to understand the salon\'s policy regarding cancellations, including any fees or notice requirements.',7,'2024-05-01 21:53:47','2024-05-01 21:53:47'),
(196,13,20,'Do you offer any special promotions or loyalty programs?','Clients may inquire about discounts, promotions, or loyalty rewards to make their salon visits more cost-effective.',8,'2024-05-01 21:54:10','2024-05-01 21:54:10'),
(197,13,21,'ما هي إجراءات السلامة الخاصة بصالونكم في ظل جائحة كوفيد-١٩؟','هذا السؤال يتعلق بالاهتمام بالنظافة والإجراءات الأمنية التي يتم تنفيذها في الصالون لحماية العملاء والموظفين.',1,'2024-05-01 22:07:02','2024-05-01 22:07:02'),
(198,13,21,'كيف يمكنني حجز موعد؟','يتعلق هذا بعملية تحديد المواعيد، سواء كانت عبر الإنترنت، أو عبر الهاتف، أو شخصياً.',2,'2024-05-01 22:07:30','2024-05-01 22:07:30'),
(199,13,21,'ما الذي يجب أن أتوقعه خلال زيارتي الأولى إلى صالونكم؟','يساعد هذا السؤال العملاء الجدد على فهم ما يمكن توقعه، مثل الاستشارات، والخدمات المقدمة، والتجربة العامة.',3,'2024-05-01 22:08:00','2024-05-01 22:08:00'),
(200,13,21,'هل تقدمون استشارات قبل المواعيد؟','قد يرغب بعض العملاء في مناقشة القصة أو العلاج المرغوب قبل الحجز، لذلك سيسألون عن خدمات الاستشارة.',4,'2024-05-01 22:08:25','2024-05-01 22:08:25'),
(201,13,21,'ما هي المنتجات المناسبة لنوع شعري؟','هذا السؤال شائع بين العملاء الذين يبحثون عن نصائح للحفاظ على قصة شعرهم أو لونهم بين الزيارات للصالون.',5,'2024-05-01 22:08:56','2024-05-01 22:08:56'),
(202,13,21,'كم سيستغرق موعدي؟','يرغب العملاء غالبًا في تنظيم يومهم حول المواعيد في الصالون، لذا سيسألون عن المدة المتوقعة لزيارتهم.',6,'2024-05-01 22:09:19','2024-05-01 22:09:19'),
(203,13,21,'ما هي سياسة الإلغاء لديكم؟','من المهم أن يفهم العملاء سياسة الصالون المتعلقة بالإلغاء، بما في ذلك أية رسوم أو متطلبات للإشعار.',7,'2024-05-01 22:09:42','2024-05-01 22:09:42'),
(204,13,21,'هل تقدمون عروضًا خاصة أو برامج وفاء؟','قد يسأل العملاء عن الخصومات، والعروض، أو برامج الولاء لجعل زياراتهم للصالون أكثر كفاءة مالية.',8,'2024-05-01 22:11:36','2024-05-01 22:11:36'),
(205,14,20,'What are your salon\'s safety protocols in light of COVID-19?','This question addresses concerns about hygiene and safety measures implemented by the salon to protect customers and staff.',1,'2024-05-01 21:51:22','2024-05-01 21:51:22'),
(206,14,20,'How do I book an appointment?','This addresses the process for scheduling appointments, whether it\'s done online, over the phone, or in person.',2,'2024-05-01 21:51:50','2024-05-01 21:51:50'),
(207,14,20,'What should I expect during my first visit to your salon?','This helps new customers understand what to anticipate, such as consultations, services offered, and the overall experience.',3,'2024-05-01 21:52:12','2024-05-01 21:52:12'),
(208,14,20,'Do you offer consultations before appointments?','Some clients may want to discuss their desired hairstyle or treatment beforehand, so they\'ll inquire about consultation services.',4,'2024-05-01 21:52:37','2024-05-01 21:52:37'),
(209,14,20,'What haircare products do you recommend for my hair type?','This question is common among clients seeking advice on maintaining their hairstyle or color between salon visits.',5,'2024-05-01 21:53:05','2024-05-01 21:53:05'),
(210,14,20,'How long will my appointment take?','Clients often want to plan their day around salon appointments, so they\'ll ask about the expected duration of their visit.',6,'2024-05-01 21:53:26','2024-05-01 21:53:26'),
(211,14,20,'What is your cancellation policy?','It\'s important for clients to understand the salon\'s policy regarding cancellations, including any fees or notice requirements.',7,'2024-05-01 21:53:47','2024-05-01 21:53:47'),
(212,14,20,'Do you offer any special promotions or loyalty programs?','Clients may inquire about discounts, promotions, or loyalty rewards to make their salon visits more cost-effective.',8,'2024-05-01 21:54:10','2024-05-01 21:54:10'),
(213,14,21,'ما هي إجراءات السلامة الخاصة بصالونكم في ظل جائحة كوفيد-١٩؟','هذا السؤال يتعلق بالاهتمام بالنظافة والإجراءات الأمنية التي يتم تنفيذها في الصالون لحماية العملاء والموظفين.',1,'2024-05-01 22:07:02','2024-05-01 22:07:02'),
(214,14,21,'كيف يمكنني حجز موعد؟','يتعلق هذا بعملية تحديد المواعيد، سواء كانت عبر الإنترنت، أو عبر الهاتف، أو شخصياً.',2,'2024-05-01 22:07:30','2024-05-01 22:07:30'),
(215,14,21,'ما الذي يجب أن أتوقعه خلال زيارتي الأولى إلى صالونكم؟','يساعد هذا السؤال العملاء الجدد على فهم ما يمكن توقعه، مثل الاستشارات، والخدمات المقدمة، والتجربة العامة.',3,'2024-05-01 22:08:00','2024-05-01 22:08:00'),
(216,14,21,'هل تقدمون استشارات قبل المواعيد؟','قد يرغب بعض العملاء في مناقشة القصة أو العلاج المرغوب قبل الحجز، لذلك سيسألون عن خدمات الاستشارة.',4,'2024-05-01 22:08:25','2024-05-01 22:08:25'),
(217,14,21,'ما هي المنتجات المناسبة لنوع شعري؟','هذا السؤال شائع بين العملاء الذين يبحثون عن نصائح للحفاظ على قصة شعرهم أو لونهم بين الزيارات للصالون.',5,'2024-05-01 22:08:56','2024-05-01 22:08:56'),
(218,14,21,'كم سيستغرق موعدي؟','يرغب العملاء غالبًا في تنظيم يومهم حول المواعيد في الصالون، لذا سيسألون عن المدة المتوقعة لزيارتهم.',6,'2024-05-01 22:09:19','2024-05-01 22:09:19'),
(219,14,21,'ما هي سياسة الإلغاء لديكم؟','من المهم أن يفهم العملاء سياسة الصالون المتعلقة بالإلغاء، بما في ذلك أية رسوم أو متطلبات للإشعار.',7,'2024-05-01 22:09:42','2024-05-01 22:09:42'),
(220,14,21,'هل تقدمون عروضًا خاصة أو برامج وفاء؟','قد يسأل العملاء عن الخصومات، والعروض، أو برامج الولاء لجعل زياراتهم للصالون أكثر كفاءة مالية.',8,'2024-05-01 22:11:36','2024-05-01 22:11:36'),
(221,15,20,'What are the visiting hours at Hopeview General Hospital?','Visiting hours at Hopeview General Hospital are from 10:00 AM to 8:00 PM. However, exceptions may be made for special circumstances or critical care units. Please check with the hospital reception for specific visiting policies.',1,'2024-05-01 22:53:06','2024-05-01 22:53:06'),
(222,15,20,'Does Hopeview General Hospital accept health insurance?','Yes, Hopeview General Hospital accepts a wide range of health insurance plans. We recommend contacting your insurance provider or the hospital billing department to confirm coverage and any out-of-pocket expenses.',2,'2024-05-01 22:53:32','2024-05-01 22:53:32'),
(223,15,20,'How can I schedule an appointment with a specialist at Hopeview General Hospital?','To schedule an appointment with a specialist at Hopeview General Hospital, you can call our appointment hotline at [insert phone number] or visit our website to book an appointment online. We strive to accommodate appointment requests promptly and efficiently.',3,'2024-05-01 22:54:10','2024-05-01 22:54:10'),
(224,15,20,'What amenities are available for patients and visitors at Hopeview General Hospital?','Hopeview General Hospital offers a range of amenities for the comfort and convenience of patients and visitors, including cafeteria services, parking facilities, Wi-Fi access, and patient counseling services. Additionally, we provide information desks and concierge services to assist with any inquiries or special requests.',4,'2024-05-01 22:54:37','2024-05-01 22:54:37'),
(225,15,20,'Does Hopeview General Hospital provide emergency medical services?','Yes, Hopeview General Hospital has a dedicated emergency department equipped to handle a wide range of medical emergencies 24 hours a day, 7 days a week. Our experienced emergency medical team is committed to providing timely and comprehensive care to patients in need.',5,'2024-05-01 22:55:01','2024-05-01 22:55:01'),
(226,15,20,'What measures does Hopeview General Hospital take to ensure patient safety and infection control?','Hopeview General Hospital prioritizes patient safety and infection control through rigorous protocols and hygiene practices. We adhere to international standards and guidelines, regularly conducting audits and implementing measures to prevent healthcare-associated infections and ensure a safe environment for patients, visitors, and staff.',6,'2024-05-01 22:55:22','2024-05-01 22:55:22'),
(227,15,20,'Are there financial assistance programs available for patients who cannot afford medical treatment at Hopeview General Hospital?','Yes, Hopeview General Hospital offers financial assistance programs and discounts for eligible patients who demonstrate financial need. Our patient financial counselors can provide information and assistance with applying for financial aid programs and exploring available options for managing healthcare costs.',7,'2024-05-01 22:55:44','2024-05-01 22:55:44'),
(228,15,20,'Does Hopeview General Hospital offer telemedicine services for remote consultations?','Yes, Hopeview General Hospital offers telemedicine services, allowing patients to consult with healthcare providers remotely for non-emergency medical concerns. Virtual appointments can be scheduled through our telemedicine platform, providing convenient access to medical expertise from the comfort of your home or office.',8,'2024-05-01 22:56:06','2024-05-01 22:56:06'),
(229,15,21,'ما هي ساعات الزيارة في مستشفى هوبفيو العام؟','ساعات الزيارة في مستشفى هوبفيو العام هي من الساعة ١٠:٠٠ صباحًا حتى الساعة ٨:٠٠ مساءً. ومع ذلك، قد يتم السماح بإجراء استثناءات للحالات الخاصة أو وحدات العناية المركزة. يُرجى التحقق من إدارة المستشفى لمعرفة السياسات الخاصة بالزيارات.',1,'2024-05-01 22:56:47','2024-05-01 22:56:47'),
(230,15,21,'هل يقبل مستشفى هوبفيو العام التأمين الصحي؟','نعم، يقبل مستشفى هوبفيو العام مجموعة واسعة من خطط التأمين الصحي. نوصي بالاتصال بمزود التأمين الخاص بك أو قسم الفوترة في المستشفى للتأكد من التغطية وأي مصاريف شخصية.',2,'2024-05-01 22:57:14','2024-05-01 22:57:14'),
(231,15,21,'كيف يمكنني تحديد موعد مع أخصائي في مستشفى هوبفيو العام؟','لتحديد موعد مع أخصائي في مستشفى هوبفيو العام، يمكنك الاتصال بخطنا الساخن لتحديد المواعيد على الرقم [أدخل رقم الهاتف] أو زيارة موقعنا على الويب لحجز موعد عبر الإنترنت. نحن نسعى لتلبية طلبات المواعيد بسرعة وفعالية.',3,'2024-05-01 22:57:40','2024-05-01 22:57:40'),
(232,15,21,'ما هي الخدمات المتاحة للمرضى والزوار في مستشفى هوبفيو العام؟','يقدم مستشفى هوبفيو العام مجموعة متنوعة من الخدمات لراحة وراحة المرضى والزوار، بما في ذلك خدمات الكافتيريا ومرافق وقوف السيارات والوصول إلى الإنترنت وخدمات المشورة للمرضى. بالإضافة إلى ذلك، نقدم مكاتب معلومات وخدمات الاستقبال لمساعدتك في أي استفسارات أو طلبات خاصة.',4,'2024-05-01 22:58:07','2024-05-01 22:58:07'),
(233,15,21,'هل يقدم مستشفى هوبفيو العام خدمات طبية طارئة؟','نعم، يحتوي مستشفى هوبفيو العام على قسم طوارئ مخصص مجهز للتعامل مع مجموعة واسعة من الحالات الطبية الطارئة على مدار ٢٤ ساعة في اليوم، ٧ أيام في الأسبوع. فريقنا الطبي الطارئ ذو الخبرة ملتزم بتقديم الرعاية الشاملة والفورية للمرضى الذين في حاجة.',5,'2024-05-01 22:58:32','2024-05-01 22:58:32'),
(234,15,21,'ما الإجراءات التي يتخذها مستشفى هوبفيو العام لضمان سلامة المرضى ومراقبة العدوى؟','يولي مستشفى هوبفيو العام اهتمامًا خاصًا بسلامة المرضى ومراقبة العدوى من خلال بروتوكولات صارمة وممارسات النظافة. نلتزم بالمعايير والإرشادات الدولية، ونقوم بشكل منتظم بإجراء الفحوصات الدورية وتنفيذ تدابير لمنع العدوى المرتبطة بالرعاية الصحية وضمان بيئة آمنة للمرضى والزوار والموظفين.',6,'2024-05-01 22:59:01','2024-05-01 22:59:01');
/*!40000 ALTER TABLE `listing_faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_feature_contents`
--

DROP TABLE IF EXISTS `listing_feature_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_feature_contents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_feature_id` bigint(20) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `feature_heading` text DEFAULT NULL,
  `feature_value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_feature_contents`
--

LOCK TABLES `listing_feature_contents` WRITE;
/*!40000 ALTER TABLE `listing_feature_contents` DISABLE KEYS */;
INSERT INTO `listing_feature_contents` VALUES
(7,4,20,'Quality of Services','[\"Skill level of stylists: 9\\/10\",\"Range of services offered (haircuts, coloring, styling, etc.): 8\\/10\",\"Use of high-quality products: 9\\/10\",\"Attention to detail: 9\\/10\"]','2024-05-01 21:55:30','2024-05-01 21:55:30'),
(8,5,20,'Customer Experience','[\"Comfort and ambiance of the salon: 8\\/10\",\"Friendliness and professionalism of staff: 9\\/10\",\"Appointment scheduling and wait times: 8\\/10\",\"Cleanliness and hygiene: 9\\/10\"]','2024-05-01 21:55:30','2024-05-01 21:55:30'),
(9,6,20,'Value for Money','[\"Pricing of services compared to competitors: 8\\/10\",\"Overall satisfaction with the service received for the price paid: 8\\/10\",\"Additional amenities offered (beverage service, complimentary consultations, etc.): 7\\/10\"]','2024-05-01 21:55:30','2024-05-01 21:55:30'),
(10,4,21,'جودة الخدمات','[\"\\u0645\\u0633\\u062a\\u0648\\u0649 \\u0645\\u0647\\u0627\\u0631\\u0629 \\u0627\\u0644\\u0645\\u0635\\u0645\\u0645\\u064a\\u0646: 9\\/10\",\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0645\\u0642\\u062f\\u0645\\u0629 (\\u0642\\u0635 \\u0627\\u0644\\u0634\\u0639\\u0631\\u060c \\u0627\\u0644\\u062a\\u0644\\u0648\\u064a\\u0646\\u060c \\u0627\\u0644\\u062a\\u0635\\u0645\\u064a\\u0645\\u060c \\u0627\\u0644\\u062e): 8\\/10\",\"\\u0627\\u0633\\u062a\\u062e\\u062f\\u0627\\u0645 \\u0645\\u0646\\u062a\\u062c\\u0627\\u062a \\u0639\\u0627\\u0644\\u064a\\u0629 \\u0627\\u0644\\u062c\\u0648\\u062f\\u0629: 9\\/10\",\"\\u0627\\u0644\\u0627\\u0647\\u062a\\u0645\\u0627\\u0645 \\u0628\\u0627\\u0644\\u062a\\u0641\\u0627\\u0635\\u064a\\u0644: 9\\/10\"]','2024-05-01 21:55:30','2024-05-01 21:55:30'),
(11,5,21,'تجربة الزبون','[\"\\u0627\\u0644\\u0631\\u0627\\u062d\\u0629 \\u0648\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0635\\u0627\\u0644\\u0648\\u0646: 8\\/10\",\"\\u0627\\u0644\\u0648\\u062f \\u0648\\u0627\\u0644\\u0643\\u0641\\u0627\\u0621\\u0629 \\u0627\\u0644\\u0645\\u0647\\u0646\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646: 9\\/10\",\"\\u062c\\u062f\\u0648\\u0644\\u0629 \\u0627\\u0644\\u0645\\u0648\\u0627\\u0639\\u064a\\u062f \\u0648\\u0623\\u0648\\u0642\\u0627\\u062a \\u0627\\u0644\\u0627\\u0646\\u062a\\u0638\\u0627\\u0631: 8\\/10\",\"\\u0627\\u0644\\u0646\\u0638\\u0627\\u0641\\u0629 \\u0648\\u0627\\u0644\\u0646\\u0638\\u0627\\u0641\\u0629: 9\\/10\"]','2024-05-01 21:55:30','2024-05-01 21:55:30'),
(12,6,21,'قيمة المال','[\"\\u0623\\u0633\\u0639\\u0627\\u0631 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0627\\u062a \\u0645\\u0642\\u0627\\u0631\\u0646\\u0629 \\u0628\\u0627\\u0644\\u0645\\u0646\\u0627\\u0641\\u0633\\u064a\\u0646: 8\\/10\",\"\\u0623\\u0633\\u0639\\u0627\\u0631 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0627\\u062a \\u0645\\u0642\\u0627\\u0631\\u0646\\u0629 \\u0628\\u0627\\u0644\\u0645\\u0646\\u0627\\u0641\\u0633\\u064a\\u0646: 8\\/10\",\"\\u0648\\u0633\\u0627\\u0626\\u0644 \\u0627\\u0644\\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0642\\u062f\\u0645\\u0629 (\\u062e\\u062f\\u0645\\u0629 \\u0627\\u0644\\u0645\\u0634\\u0631\\u0648\\u0628\\u0627\\u062a\\u060c \\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a \\u0645\\u062c\\u0627\\u0646\\u064a\\u0629\\u060c \\u0648\\u0645\\u0627 \\u0625\\u0644\\u0649 \\u0630\\u0644\\u0643): 7\\/10\"]','2024-05-01 21:55:30','2024-05-01 21:55:30'),
(23,12,20,'Tailored Itinerary Planning','[\"Personalized Consultations\",\"Customized Itineraries\",\"Flexibility and Adjustments\",\"Expert Recommendations\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(24,13,20,'Exceptional Customer Service','[\"Responsive Communication\",\"Dedicated Support\",\"24\\/7 Assistance\",\"Personalized Touches\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(25,14,20,'Expert Destination Knowledge','[\"Destination Specialists\",\"Insider Access\",\"Cultural Immersion\",\"Sustainable Tourism Practices\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(26,15,20,'Comprehensive Travel Resources','[\"Destination Guides and Resources\",\"Travel Technology Integration\",\"Travel Insurance and Risk Management\",\"Multilingual Support\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(27,16,20,'Community Engagement and Social Responsibility','[\"Community Partnerships\",\"Philanthropic Initiatives\",\"Ethical Supply Chain Practices\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(28,12,21,'تخطيط رحلة مصممة خصيصا','[\"\\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a \\u0634\\u062e\\u0635\\u064a\\u0629\",\"\\u0645\\u0633\\u0627\\u0631\\u0627\\u062a \\u0645\\u062e\\u0635\\u0635\\u0629\",\"\\u0627\\u0644\\u0645\\u0631\\u0648\\u0646\\u0629 \\u0648\\u0627\\u0644\\u062a\\u0639\\u062f\\u064a\\u0644\\u0627\\u062a\",\"\\u062a\\u0648\\u0635\\u064a\\u0627\\u062a \\u0627\\u0644\\u062e\\u0628\\u0631\\u0627\\u0621\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(29,13,21,'خدمة عملاء استثنائية','[\"\\u0627\\u0644\\u062a\\u0648\\u0627\\u0635\\u0644 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062c\\u064a\\u0628\",\"\\u062f\\u0639\\u0645 \\u0645\\u062e\\u0635\\u0635\",\"\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0639\\u0644\\u0649 \\u0645\\u062f\\u0627\\u0631 24 \\u0633\\u0627\\u0639\\u0629 \\u0637\\u0648\\u0627\\u0644 \\u0623\\u064a\\u0627\\u0645 \\u0627\\u0644\\u0623\\u0633\\u0628\\u0648\\u0639\",\"\\u0627\\u0644\\u0644\\u0645\\u0633\\u0627\\u062a \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(30,14,21,'معرفة وجهة الخبراء','[\"\\u0645\\u062a\\u062e\\u0635\\u0635\\u0648\\u0646 \\u0627\\u0644\\u0648\\u062c\\u0647\\u0629\",\"\\u0645\\u062a\\u062e\\u0635\\u0635\\u0648\\u0646 \\u0627\\u0644\\u0648\\u062c\\u0647\\u0629\",\"\\u0627\\u0644\\u0627\\u0646\\u063a\\u0645\\u0627\\u0633 \\u0627\\u0644\\u062b\\u0642\\u0627\\u0641\\u064a\",\"\\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0627\\u0644\\u0633\\u064a\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062f\\u0627\\u0645\\u0629\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(31,15,21,'موارد السفر الشاملة','[\"\\u0623\\u062f\\u0644\\u0629 \\u0627\\u0644\\u0648\\u062c\\u0647\\u0629 \\u0648\\u0627\\u0644\\u0645\\u0648\\u0627\\u0631\\u062f\",\"\\u062a\\u0643\\u0627\\u0645\\u0644 \\u062a\\u0643\\u0646\\u0648\\u0644\\u0648\\u062c\\u064a\\u0627 \\u0627\\u0644\\u0633\\u0641\\u0631\",\"\\u062a\\u0623\\u0645\\u064a\\u0646 \\u0627\\u0644\\u0633\\u0641\\u0631 \\u0648\\u0625\\u062f\\u0627\\u0631\\u0629 \\u0627\\u0644\\u0645\\u062e\\u0627\\u0637\\u0631\",\"\\u062f\\u0639\\u0645 \\u0645\\u062a\\u0639\\u062f\\u062f \\u0627\\u0644\\u0644\\u063a\\u0627\\u062a\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(32,16,21,'المشاركة المجتمعية والمسؤولية الاجتماعية','[\"\\u0627\\u0644\\u0634\\u0631\\u0627\\u0643\\u0627\\u062a \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\\u064a\\u0629\",\"\\u0627\\u0644\\u0645\\u0628\\u0627\\u062f\\u0631\\u0627\\u062a \\u0627\\u0644\\u062e\\u064a\\u0631\\u064a\\u0629\",\"\\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0633\\u0644\\u0633\\u0644\\u0629 \\u0627\\u0644\\u062a\\u0648\\u0631\\u064a\\u062f \\u0627\\u0644\\u0623\\u062e\\u0644\\u0627\\u0642\\u064a\\u0629\"]','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(33,17,20,'Oceanfront Location','[\"Spectacular views of the Bay of Bengal\",\"Direct access to Kolatoli Beach\",\"Opportunities for water sports\",\"Sunset viewing spots for guests\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(34,18,20,'Luxurious Accommodations','[\"Spacious rooms and suites with modern amenities and elegant decor.\",\"Private balconies or terraces overlooking the ocean or lush gardens.\",\"Plush bedding and comfortable furnishings for a restful night\'s sleep.\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(35,19,20,'World-Class Dining','[\"Fine dining restaurant offering a diverse menu of local and international cuisine.\",\"Fresh seafood specialties sourced from local fishermen for an authentic taste of the region.\",\"Casual cafe or lounge serving light bites, refreshing beverages, and signature cocktails.\",\"Outdoor dining options with panoramic views of the ocean or landscaped gardens.\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(36,20,20,'Relaxation and Wellness Facilities','[\"Tranquil spa and wellness center offering a range of massage therapies and body treatments.\",\"Yoga and meditation sessions held in serene outdoor spaces or dedicated studios.\",\"Outdoor swimming pool and Jacuzzi for refreshing dips and relaxation under the sun.\",\"Fitness center equipped with state-of-the-art equipment for guests to maintain their workout routines.\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(37,21,20,'Exceptional Hospitality and Services','[\"Warm and attentive staff dedicated to providing personalized service and ensuring guest satisfaction.\",\"Concierge desk to assist with arranging excursions, transportation, and restaurant reservations.\",\"24-hour room service for guests\' convenience, offering a selection of delicious meals and snacks.\",\"Special amenities for families, couples, and business travelers to enhance their stay experience.\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(38,17,21,'موقع واجهة المحيط','[\"\\u0645\\u0646\\u0627\\u0638\\u0631 \\u062e\\u0644\\u0627\\u0628\\u0629 \\u0644\\u062e\\u0644\\u064a\\u062c \\u0627\\u0644\\u0628\\u0646\\u063a\\u0627\\u0644\",\"\\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0627\\u0644\\u0645\\u0628\\u0627\\u0634\\u0631 \\u0625\\u0644\\u0649 \\u0634\\u0627\\u0637\\u0626 \\u0643\\u0648\\u0644\\u0627\\u062a\\u0648\\u0644\\u064a\",\"\\u0641\\u0631\\u0635 \\u0644\\u0645\\u0645\\u0627\\u0631\\u0633\\u0629 \\u0627\\u0644\\u0631\\u064a\\u0627\\u0636\\u0627\\u062a \\u0627\\u0644\\u0645\\u0627\\u0626\\u064a\\u0629\",\"\\u0623\\u0645\\u0627\\u0643\\u0646 \\u0644\\u0645\\u0634\\u0627\\u0647\\u062f\\u0629 \\u063a\\u0631\\u0648\\u0628 \\u0627\\u0644\\u0634\\u0645\\u0633 \\u0644\\u0644\\u0636\\u064a\\u0648\\u0641\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(39,18,21,'أماكن إقامة فاخرة','[\"\\u063a\\u0631\\u0641 \\u0648\\u0623\\u062c\\u0646\\u062d\\u0629 \\u0641\\u0633\\u064a\\u062d\\u0629 \\u0645\\u0639 \\u0648\\u0633\\u0627\\u0626\\u0644 \\u0627\\u0644\\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u062d\\u062f\\u064a\\u062b\\u0629 \\u0648\\u0627\\u0644\\u062f\\u064a\\u0643\\u0648\\u0631 \\u0627\\u0644\\u0623\\u0646\\u064a\\u0642.\",\"\\u0634\\u0631\\u0641\\u0627\\u062a \\u0623\\u0648 \\u062a\\u0631\\u0627\\u0633\\u0627\\u062a \\u062e\\u0627\\u0635\\u0629 \\u0645\\u0637\\u0644\\u0629 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u062d\\u064a\\u0637 \\u0623\\u0648 \\u0627\\u0644\\u062d\\u062f\\u0627\\u0626\\u0642 \\u0627\\u0644\\u0645\\u0648\\u0631\\u0642\\u0629.\",\"\\u0623\\u0633\\u0631\\u0629 \\u0641\\u062e\\u0645\\u0629 \\u0648\\u0645\\u0641\\u0631\\u0648\\u0634\\u0627\\u062a \\u0645\\u0631\\u064a\\u062d\\u0629 \\u0644\\u0642\\u0636\\u0627\\u0621 \\u0644\\u064a\\u0644\\u0629 \\u0646\\u0648\\u0645 \\u0645\\u0631\\u064a\\u062d\\u0629.\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(40,19,21,'تناول الطعام على مستوى عالمي','[\"\\u0645\\u0637\\u0639\\u0645 \\u0641\\u0627\\u062e\\u0631 \\u064a\\u0642\\u062f\\u0645 \\u0642\\u0627\\u0626\\u0645\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u0623\\u0643\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0639\\u0627\\u0644\\u0645\\u064a\\u0629.\",\"\\u062a\\u062e\\u0635\\u0635\\u0627\\u062a \\u0627\\u0644\\u0645\\u0623\\u0643\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u0628\\u062d\\u0631\\u064a\\u0629 \\u0627\\u0644\\u0637\\u0627\\u0632\\u062c\\u0629 \\u0627\\u0644\\u062a\\u064a \\u064a\\u062a\\u0645 \\u0627\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u064a\\u0647\\u0627 \\u0645\\u0646 \\u0627\\u0644\\u0635\\u064a\\u0627\\u062f\\u064a\\u0646 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u064a\\u0646 \\u0644\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u0630\\u0627\\u0642 \\u0627\\u0644\\u0623\\u0635\\u064a\\u0644 \\u0644\\u0644\\u0645\\u0646\\u0637\\u0642\\u0629.\",\"\\u0645\\u0642\\u0647\\u0649 \\u0623\\u0648 \\u0635\\u0627\\u0644\\u0629 \\u063a\\u064a\\u0631 \\u0631\\u0633\\u0645\\u064a\\u0629 \\u062a\\u0642\\u062f\\u0645 \\u0627\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0627\\u0644\\u062e\\u0641\\u064a\\u0641\\u0629 \\u0648\\u0627\\u0644\\u0645\\u0634\\u0631\\u0648\\u0628\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0639\\u0634\\u0629 \\u0648\\u0627\\u0644\\u0643\\u0648\\u0643\\u062a\\u064a\\u0644\\u0627\\u062a \\u0627\\u0644\\u0645\\u0645\\u064a\\u0632\\u0629.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0641\\u064a \\u0627\\u0644\\u0647\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0637\\u0644\\u0642 \\u0645\\u0639 \\u0625\\u0637\\u0644\\u0627\\u0644\\u0627\\u062a \\u0628\\u0627\\u0646\\u0648\\u0631\\u0627\\u0645\\u064a\\u0629 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u062d\\u064a\\u0637 \\u0623\\u0648 \\u0627\\u0644\\u062d\\u062f\\u0627\\u0626\\u0642 \\u0630\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0627\\u0638\\u0631 \\u0627\\u0644\\u0637\\u0628\\u064a\\u0639\\u064a\\u0629.\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(41,20,21,'مرافق الاسترخاء والعافية','[\"\\u064a\\u0642\\u062f\\u0645 \\u0627\\u0644\\u0633\\u0628\\u0627 \\u0648\\u0627\\u0644\\u0645\\u0631\\u0643\\u0632 \\u0627\\u0644\\u0635\\u062d\\u064a \\u0627\\u0644\\u0647\\u0627\\u062f\\u0626 \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0639\\u0644\\u0627\\u062c\\u0627\\u062a \\u0627\\u0644\\u062a\\u062f\\u0644\\u064a\\u0643 \\u0648\\u0639\\u0644\\u0627\\u062c\\u0627\\u062a \\u0627\\u0644\\u062c\\u0633\\u0645.\",\"\\u062a\\u064f\\u0639\\u0642\\u062f \\u062c\\u0644\\u0633\\u0627\\u062a \\u0627\\u0644\\u064a\\u0648\\u063a\\u0627 \\u0648\\u0627\\u0644\\u062a\\u0623\\u0645\\u0644 \\u0641\\u064a \\u0645\\u0633\\u0627\\u062d\\u0627\\u062a \\u062e\\u0627\\u0631\\u062c\\u064a\\u0629 \\u0647\\u0627\\u062f\\u0626\\u0629 \\u0623\\u0648 \\u0641\\u064a \\u0627\\u0633\\u062a\\u0648\\u062f\\u064a\\u0648\\u0647\\u0627\\u062a \\u0645\\u062e\\u0635\\u0635\\u0629.\",\"\\u062d\\u0645\\u0627\\u0645 \\u0633\\u0628\\u0627\\u062d\\u0629 \\u062e\\u0627\\u0631\\u062c\\u064a \\u0648\\u062c\\u0627\\u0643\\u0648\\u0632\\u064a \\u0644\\u0644\\u0633\\u0628\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0645\\u0646\\u0639\\u0634\\u0629 \\u0648\\u0627\\u0644\\u0627\\u0633\\u062a\\u0631\\u062e\\u0627\\u0621 \\u062a\\u062d\\u062a \\u0623\\u0634\\u0639\\u0629 \\u0627\\u0644\\u0634\\u0645\\u0633.\",\"\\u0645\\u0631\\u0643\\u0632 \\u0644\\u0644\\u064a\\u0627\\u0642\\u0629 \\u0627\\u0644\\u0628\\u062f\\u0646\\u064a\\u0629 \\u0645\\u062c\\u0647\\u0632 \\u0628\\u0623\\u062d\\u062f\\u062b \\u0627\\u0644\\u0645\\u0639\\u062f\\u0627\\u062a \\u0644\\u0644\\u0636\\u064a\\u0648\\u0641 \\u0644\\u0644\\u062d\\u0641\\u0627\\u0638 \\u0639\\u0644\\u0649 \\u0631\\u0648\\u062a\\u064a\\u0646 \\u062a\\u0645\\u0627\\u0631\\u064a\\u0646\\u0647\\u0645.\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(42,21,21,'الضيافة والخدمات الاستثنائية','[\"\\u0641\\u0631\\u064a\\u0642 \\u0639\\u0645\\u0644 \\u0648\\u062f\\u0648\\u062f \\u0648\\u064a\\u0642\\u0638 \\u0645\\u0643\\u0631\\u0633 \\u0644\\u062a\\u0642\\u062f\\u064a\\u0645 \\u062e\\u062f\\u0645\\u0629 \\u0634\\u062e\\u0635\\u064a\\u0629 \\u0648\\u0636\\u0645\\u0627\\u0646 \\u0631\\u0636\\u0627 \\u0627\\u0644\\u0636\\u064a\\u0648\\u0641.\",\"\\u0645\\u0643\\u062a\\u0628 \\u0643\\u0648\\u0646\\u0633\\u064a\\u0631\\u062c \\u0644\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u062a\\u0631\\u062a\\u064a\\u0628 \\u0627\\u0644\\u0631\\u062d\\u0644\\u0627\\u062a \\u0627\\u0644\\u0627\\u0633\\u062a\\u0643\\u0634\\u0627\\u0641\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0646\\u0642\\u0644 \\u0648\\u062d\\u062c\\u0648\\u0632\\u0627\\u062a \\u0627\\u0644\\u0645\\u0637\\u0627\\u0639\\u0645.\",\"\\u062e\\u062f\\u0645\\u0629 \\u0627\\u0644\\u063a\\u0631\\u0641 \\u0639\\u0644\\u0649 \\u0645\\u062f\\u0627\\u0631 24 \\u0633\\u0627\\u0639\\u0629 \\u0644\\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0636\\u064a\\u0648\\u0641\\u060c \\u062d\\u064a\\u062b \\u062a\\u0642\\u062f\\u0645 \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062e\\u062a\\u0627\\u0631\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0627\\u0644\\u0644\\u0630\\u064a\\u0630\\u0629 \\u0648\\u0627\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0627\\u0644\\u062e\\u0641\\u064a\\u0641\\u0629.\",\"\\u0648\\u0633\\u0627\\u0626\\u0644 \\u0631\\u0627\\u062d\\u0629 \\u062e\\u0627\\u0635\\u0629 \\u0644\\u0644\\u0639\\u0627\\u0626\\u0644\\u0627\\u062a \\u0648\\u0627\\u0644\\u0623\\u0632\\u0648\\u0627\\u062c \\u0648\\u0627\\u0644\\u0645\\u0633\\u0627\\u0641\\u0631\\u064a\\u0646 \\u0645\\u0646 \\u0631\\u062c\\u0627\\u0644 \\u0627\\u0644\\u0623\\u0639\\u0645\\u0627\\u0644 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u062a\\u062c\\u0631\\u0628\\u0629 \\u0625\\u0642\\u0627\\u0645\\u062a\\u0647\\u0645.\"]','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(43,22,20,'Scenic Location','[\"Breathtaking Views\",\"Outdoor Seating\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(44,23,20,'Culinary Excellence','[\"Authentic Pakistani Cuisine\",\"Global Influences\",\"Seasonal Menus\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(45,24,20,'Warm Hospitality','[\"Attentive Service\",\"Welcoming Ambiance\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(46,25,20,'Amenities for Enhanced Experience','[\"Private Dining Rooms\",\"Live Entertainment\",\"Free Wi-Fi\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(47,26,20,'Commitment to Sustainability','[\"Locally Sourced Ingredients\",\"Waste Reduction Initiatives\",\"Community Engagement\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(48,22,21,'الموقع ذو المناظر الخلابة','[\"\\u0645\\u0646\\u0627\\u0638\\u0631 \\u062e\\u0644\\u0627\\u0628\\u0629\",\"\\u062c\\u0644\\u0648\\u0633 \\u0641\\u064a \\u0627\\u0644\\u0647\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0637\\u0644\\u0642\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(49,23,21,'التميز الطهي','[\"\\u0627\\u0644\\u0645\\u0637\\u0628\\u062e \\u0627\\u0644\\u0628\\u0627\\u0643\\u0633\\u062a\\u0627\\u0646\\u064a \\u0627\\u0644\\u0623\\u0635\\u064a\\u0644\",\"\\u0627\\u0644\\u062a\\u0623\\u062b\\u064a\\u0631\\u0627\\u062a \\u0627\\u0644\\u0639\\u0627\\u0644\\u0645\\u064a\\u0629\",\"\\u0627\\u0644\\u0642\\u0648\\u0627\\u0626\\u0645 \\u0627\\u0644\\u0645\\u0648\\u0633\\u0645\\u064a\\u0629\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(50,24,21,'كرم الضيافة','[\"\\u062e\\u062f\\u0645\\u0629 \\u0627\\u0644\\u064a\\u0642\\u0638\\u0629\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0627\\u0644\\u062a\\u0631\\u062d\\u064a\\u0628\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(51,25,21,'وسائل الراحة لتجربة محسنة','[\"\\u063a\\u0631\\u0641 \\u0637\\u0639\\u0627\\u0645 \\u062e\\u0627\\u0635\\u0629\",\"\\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u062a\\u0631\\u0641\\u0647\\u064a\\u0647 \\u062d\\u064a\\u0629\",\"\\u0648\\u0627\\u0649 \\u0641\\u0627\\u0649 \\u0645\\u062c\\u0627\\u0646\\u0649\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(52,26,21,'الالتزام بالاستدامة','[\"\\u0627\\u0644\\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629\",\"\\u0645\\u0628\\u0627\\u062f\\u0631\\u0627\\u062a \\u0627\\u0644\\u062d\\u062f \\u0645\\u0646 \\u0627\\u0644\\u0646\\u0641\\u0627\\u064a\\u0627\\u062a\",\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\\u064a\\u0629\"]','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(53,27,20,'Premium Vehicle Selection','[\"Wide range of luxury and performance vehicles from renowned brands.\",\"Constantly updated inventory to offer the latest models and variants.\",\"Rigorous inspection and quality assurance processes to ensure the highest standards.\",\"Exclusive access to limited edition and special edition models.\",\"Varied options including sports cars, sedans, SUVs, and exotic vehicles.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(54,28,20,'Exceptional Customer Service','[\"Knowledgeable and attentive sales staff to assist customers throughout the purchasing process.\",\"Personalized consultations to understand each customer\'s needs and preferences.\",\"Transparent pricing and financing options with clear explanations.\",\"Post-sale support and assistance with vehicle maintenance and upgrades.\",\"Prompt responses to inquiries and inquiries via multiple communication channels.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(55,29,20,'State-of-the-Art Service Center','[\"Factory-trained technicians with expertise in servicing luxury and high-performance vehicles.\",\"Advanced diagnostic equipment and tools to accurately identify and resolve issues.\",\"Comprehensive maintenance packages tailored to different vehicle models and mileage intervals.\",\"Genuine OEM parts and accessories to maintain original performance and reliability.\",\"Efficient turnaround times to minimize inconvenience for customers.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(56,30,20,'Luxurious Showroom and Facilities','[\"Elegant showroom ambiance with modern design and comfortable seating areas.\",\"Impeccably maintained facilities showcasing vehicles in a visually appealing manner.\",\"Interactive displays and multimedia presentations to highlight key features and technologies.\",\"Private VIP lounge for exclusive consultations and demonstrations.\",\"Accessible location with ample parking and convenient amenities nearby.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(57,31,20,'Comprehensive Warranty and Coverage','[\"Extensive warranty options covering various components and systems of the vehicle.\",\"Additional protection plans available for extended peace of mind.\",\"Clear terms and conditions with no hidden fees or surprises.\",\"Assistance with warranty claims and service coordination for hassle-free repairs.\",\"Regular updates and reminders about warranty expiration and renewal options.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(58,32,20,'Community Engagement and Events','[\"Participation in local automotive events and car shows to engage with enthusiasts.\",\"Sponsorship of charity drives, fundraisers, and community outreach programs.\",\"Exclusive owner\'s clubs and enthusiast gatherings to foster a sense of community.\",\"Educational workshops and seminars on vehicle maintenance, performance tuning, and driving techniques.\",\"Social media presence with behind-the-scenes insights, customer spotlights, and event coverage.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(59,33,20,'Technology Integration and Innovation','[\"Integration of cutting-edge technology features in showroom displays and customer interactions.\",\"Virtual showroom tours and online configurators for remote browsing and customization.\",\"Mobile apps for scheduling service appointments, tracking vehicle maintenance, and accessing exclusive offers.\",\"Implementation of digital marketing strategies to reach a broader audience and enhance customer engagement.\",\"Investment in research and development to anticipate future trends and customer preferences.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(60,34,20,'Environmental Sustainability Initiatives','[\"Commitment to eco-friendly practices such as energy-efficient lighting and recycling programs.\",\"Promotion of hybrid and electric vehicle options to reduce carbon footprint.\",\"Collaboration with environmentally conscious suppliers and partners.\",\"Education and advocacy for sustainable driving habits and vehicle maintenance.\",\"Continuous improvement efforts to minimize environmental impact across all aspects of operations.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(61,27,21,'اختيار السيارة المتميزة','[\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0641\\u0627\\u062e\\u0631\\u0629 \\u0648\\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0645\\u0646 \\u0627\\u0644\\u0639\\u0644\\u0627\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u062c\\u0627\\u0631\\u064a\\u0629 \\u0627\\u0644\\u0634\\u0647\\u064a\\u0631\\u0629.\",\"\\u064a\\u062a\\u0645 \\u062a\\u062d\\u062f\\u064a\\u062b \\u0627\\u0644\\u0645\\u062e\\u0632\\u0648\\u0646 \\u0628\\u0627\\u0633\\u062a\\u0645\\u0631\\u0627\\u0631 \\u0644\\u062a\\u0642\\u062f\\u064a\\u0645 \\u0623\\u062d\\u062f\\u062b \\u0627\\u0644\\u0645\\u0648\\u062f\\u064a\\u0644\\u0627\\u062a \\u0648\\u0627\\u0644\\u0645\\u062a\\u063a\\u064a\\u0631\\u0627\\u062a.\",\"\\u0639\\u0645\\u0644\\u064a\\u0627\\u062a \\u062a\\u0641\\u062a\\u064a\\u0634 \\u0635\\u0627\\u0631\\u0645\\u0629 \\u0648\\u0636\\u0645\\u0627\\u0646 \\u0627\\u0644\\u062c\\u0648\\u062f\\u0629 \\u0644\\u0636\\u0645\\u0627\\u0646 \\u0623\\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u0639\\u0627\\u064a\\u064a\\u0631.\",\"\\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0627\\u0644\\u062d\\u0635\\u0631\\u064a \\u0625\\u0644\\u0649 \\u0637\\u0628\\u0639\\u0629 \\u0645\\u062d\\u062f\\u0648\\u062f\\u0629 \\u0648\\u0646\\u0645\\u0627\\u0630\\u062c \\u0637\\u0628\\u0639\\u0629 \\u062e\\u0627\\u0635\\u0629.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u062a\\u0634\\u0645\\u0644 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0631\\u064a\\u0627\\u0636\\u064a\\u0629 \\u0648\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0633\\u064a\\u062f\\u0627\\u0646 \\u0648\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u062f\\u0641\\u0639 \\u0627\\u0644\\u0631\\u0628\\u0627\\u0639\\u064a \\u0648\\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0627\\u0644\\u063a\\u0631\\u064a\\u0628\\u0629.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(62,28,21,'خدمة عملاء استثنائية','[\"\\u0645\\u0648\\u0638\\u0641\\u0648 \\u0627\\u0644\\u0645\\u0628\\u064a\\u0639\\u0627\\u062a \\u0630\\u0648\\u064a \\u0627\\u0644\\u0645\\u0639\\u0631\\u0641\\u0629 \\u0648\\u0627\\u0644\\u064a\\u0642\\u0638\\u0629 \\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0637\\u0648\\u0627\\u0644 \\u0639\\u0645\\u0644\\u064a\\u0629 \\u0627\\u0644\\u0634\\u0631\\u0627\\u0621.\",\"\\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a \\u0634\\u062e\\u0635\\u064a\\u0629 \\u0644\\u0641\\u0647\\u0645 \\u0627\\u062d\\u062a\\u064a\\u0627\\u062c\\u0627\\u062a \\u0648\\u062a\\u0641\\u0636\\u064a\\u0644\\u0627\\u062a \\u0643\\u0644 \\u0639\\u0645\\u064a\\u0644.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u062a\\u0633\\u0639\\u064a\\u0631 \\u0648\\u062a\\u0645\\u0648\\u064a\\u0644 \\u0634\\u0641\\u0627\\u0641\\u0629 \\u0645\\u0639 \\u062a\\u0641\\u0633\\u064a\\u0631\\u0627\\u062a \\u0648\\u0627\\u0636\\u062d\\u0629.\",\"\\u062f\\u0639\\u0645 \\u0645\\u0627 \\u0628\\u0639\\u062f \\u0627\\u0644\\u0628\\u064a\\u0639 \\u0648\\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u0635\\u064a\\u0627\\u0646\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0648\\u062a\\u0631\\u0642\\u064a\\u0627\\u062a\\u0647\\u0627.\",\"\\u0631\\u062f\\u0648\\u062f \\u0633\\u0631\\u064a\\u0639\\u0629 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0627\\u0633\\u062a\\u0641\\u0633\\u0627\\u0631\\u0627\\u062a \\u0648\\u0627\\u0644\\u0627\\u0633\\u062a\\u0641\\u0633\\u0627\\u0631\\u0627\\u062a \\u0639\\u0628\\u0631 \\u0642\\u0646\\u0648\\u0627\\u062a \\u0627\\u0644\\u0627\\u062a\\u0635\\u0627\\u0644 \\u0627\\u0644\\u0645\\u062a\\u0639\\u062f\\u062f\\u0629.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(63,29,21,'مركز خدمة على أحدث طراز','[\"\\u0641\\u0646\\u064a\\u0648\\u0646 \\u0645\\u062f\\u0631\\u0628\\u0648\\u0646 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0635\\u0646\\u0639 \\u0648\\u0630\\u0648\\u0648 \\u062e\\u0628\\u0631\\u0629 \\u0641\\u064a \\u062e\\u062f\\u0645\\u0629 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0641\\u0627\\u062e\\u0631\\u0629 \\u0648\\u0639\\u0627\\u0644\\u064a\\u0629 \\u0627\\u0644\\u0623\\u062f\\u0627\\u0621.\",\"\\u0645\\u0639\\u062f\\u0627\\u062a \\u0648\\u0623\\u062f\\u0648\\u0627\\u062a \\u062a\\u0634\\u062e\\u064a\\u0635\\u064a\\u0629 \\u0645\\u062a\\u0642\\u062f\\u0645\\u0629 \\u0644\\u062a\\u062d\\u062f\\u064a\\u062f \\u0627\\u0644\\u0645\\u0634\\u0643\\u0644\\u0627\\u062a \\u0648\\u062d\\u0644\\u0647\\u0627 \\u0628\\u062f\\u0642\\u0629.\",\"\\u062d\\u0632\\u0645 \\u0635\\u064a\\u0627\\u0646\\u0629 \\u0634\\u0627\\u0645\\u0644\\u0629 \\u0645\\u0635\\u0645\\u0645\\u0629 \\u062e\\u0635\\u064a\\u0635\\u064b\\u0627 \\u0644\\u0645\\u062e\\u062a\\u0644\\u0641 \\u0637\\u0631\\u0627\\u0632\\u0627\\u062a \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0648\\u0627\\u0644\\u0641\\u062a\\u0631\\u0627\\u062a \\u0627\\u0644\\u0645\\u0642\\u0637\\u0648\\u0639\\u0629.\",\"\\u0642\\u0637\\u0639 \\u063a\\u064a\\u0627\\u0631 \\u0648\\u0645\\u0644\\u062d\\u0642\\u0627\\u062a \\u0623\\u0635\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0635\\u0627\\u0646\\u0639\\u064a \\u0627\\u0644\\u0642\\u0637\\u0639 \\u0627\\u0644\\u0623\\u0635\\u0644\\u064a\\u0629 \\u0644\\u0644\\u062d\\u0641\\u0627\\u0638 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0627\\u0644\\u0623\\u0635\\u0644\\u064a \\u0648\\u0627\\u0644\\u0645\\u0648\\u062b\\u0648\\u0642\\u064a\\u0629.\",\"\\u0623\\u0648\\u0642\\u0627\\u062a \\u062a\\u0633\\u0644\\u064a\\u0645 \\u0641\\u0639\\u0627\\u0644\\u0629 \\u0644\\u062a\\u0642\\u0644\\u064a\\u0644 \\u0627\\u0644\\u0625\\u0632\\u0639\\u0627\\u062c \\u0644\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(64,30,21,'صالة عرض ومرافق فاخرة','[\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0635\\u0627\\u0644\\u0629 \\u0639\\u0631\\u0636 \\u0623\\u0646\\u064a\\u0642\\u0629 \\u0630\\u0627\\u062a \\u062a\\u0635\\u0645\\u064a\\u0645 \\u0639\\u0635\\u0631\\u064a \\u0648\\u0645\\u0646\\u0627\\u0637\\u0642 \\u062c\\u0644\\u0648\\u0633 \\u0645\\u0631\\u064a\\u062d\\u0629.\",\"\\u0645\\u0631\\u0627\\u0641\\u0642 \\u062a\\u0645\\u062a \\u0635\\u064a\\u0627\\u0646\\u062a\\u0647\\u0627 \\u0628\\u062f\\u0642\\u0629 \\u0648\\u062a\\u0639\\u0631\\u0636 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0628\\u0637\\u0631\\u064a\\u0642\\u0629 \\u062c\\u0630\\u0627\\u0628\\u0629 \\u0628\\u0635\\u0631\\u064a\\u064b\\u0627.\",\"\\u0634\\u0627\\u0634\\u0627\\u062a \\u062a\\u0641\\u0627\\u0639\\u0644\\u064a\\u0629 \\u0648\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0648\\u0633\\u0627\\u0626\\u0637 \\u0627\\u0644\\u0645\\u062a\\u0639\\u062f\\u062f\\u0629 \\u0644\\u062a\\u0633\\u0644\\u064a\\u0637 \\u0627\\u0644\\u0636\\u0648\\u0621 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u0648\\u0627\\u0644\\u062a\\u0642\\u0646\\u064a\\u0627\\u062a \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629.\",\"\\u0635\\u0627\\u0644\\u0629 \\u062e\\u0627\\u0635\\u0629 \\u0644\\u0643\\u0628\\u0627\\u0631 \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0627\\u062a \\u0644\\u0644\\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a \\u0648\\u0627\\u0644\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u062d\\u0635\\u0631\\u064a\\u0629.\",\"\\u0645\\u0648\\u0642\\u0639 \\u064a\\u0633\\u0647\\u0644 \\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u064a\\u0647 \\u0645\\u0639 \\u0645\\u0648\\u0642\\u0641 \\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0648\\u0627\\u0633\\u0639 \\u0648\\u0648\\u0633\\u0627\\u0626\\u0644 \\u0631\\u0627\\u062d\\u0629 \\u0645\\u0631\\u064a\\u062d\\u0629 \\u0628\\u0627\\u0644\\u062c\\u0648\\u0627\\u0631.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(65,31,21,'ضمان وتغطية شاملة','[\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0636\\u0645\\u0627\\u0646 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0627\\u0644\\u0646\\u0637\\u0627\\u0642 \\u062a\\u063a\\u0637\\u064a \\u0645\\u062e\\u062a\\u0644\\u0641 \\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0648\\u0623\\u0646\\u0638\\u0645\\u0629 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0629.\",\"\\u062a\\u062a\\u0648\\u0641\\u0631 \\u062e\\u0637\\u0637 \\u062d\\u0645\\u0627\\u064a\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 \\u0644\\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0628\\u0627\\u0644 \\u0627\\u0644\\u0645\\u0645\\u062a\\u062f\\u0629.\",\"\\u0634\\u0631\\u0648\\u0637 \\u0648\\u0623\\u062d\\u0643\\u0627\\u0645 \\u0648\\u0627\\u0636\\u062d\\u0629 \\u0628\\u062f\\u0648\\u0646 \\u0623\\u064a \\u0631\\u0633\\u0648\\u0645 \\u0623\\u0648 \\u0645\\u0641\\u0627\\u062c\\u0622\\u062a \\u0645\\u062e\\u0641\\u064a\\u0629.\",\"\\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u0645\\u0637\\u0627\\u0644\\u0628\\u0627\\u062a \\u0627\\u0644\\u0636\\u0645\\u0627\\u0646 \\u0648\\u062a\\u0646\\u0633\\u064a\\u0642 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0629 \\u0644\\u0625\\u062c\\u0631\\u0627\\u0621 \\u0625\\u0635\\u0644\\u0627\\u062d\\u0627\\u062a \\u062e\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u062a\\u0627\\u0639\\u0628.\",\"\\u062a\\u062d\\u062f\\u064a\\u062b\\u0627\\u062a \\u0648\\u062a\\u0630\\u0643\\u064a\\u0631\\u0627\\u062a \\u0645\\u0646\\u062a\\u0638\\u0645\\u0629 \\u062d\\u0648\\u0644 \\u0627\\u0646\\u062a\\u0647\\u0627\\u0621 \\u0627\\u0644\\u0636\\u0645\\u0627\\u0646 \\u0648\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u062a\\u062c\\u062f\\u064a\\u062f.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(66,32,21,'المشاركة المجتمعية والأحداث','[\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0641\\u064a \\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u0629 \\u0648\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0644\\u0644\\u062a\\u0648\\u0627\\u0635\\u0644 \\u0645\\u0639 \\u0627\\u0644\\u0645\\u062a\\u062d\\u0645\\u0633\\u064a\\u0646.\",\"\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u062d\\u0645\\u0644\\u0627\\u062a \\u0627\\u0644\\u062e\\u064a\\u0631\\u064a\\u0629 \\u0648\\u062c\\u0645\\u0639 \\u0627\\u0644\\u062a\\u0628\\u0631\\u0639\\u0627\\u062a \\u0648\\u0628\\u0631\\u0627\\u0645\\u062c \\u0627\\u0644\\u062a\\u0648\\u0639\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\\u064a\\u0629.\",\"\\u0646\\u0648\\u0627\\u062f\\u064a \\u0627\\u0644\\u0645\\u0627\\u0644\\u0643 \\u0627\\u0644\\u062d\\u0635\\u0631\\u064a\\u0629 \\u0648\\u062a\\u062c\\u0645\\u0639\\u0627\\u062a \\u0627\\u0644\\u0645\\u062a\\u062d\\u0645\\u0633\\u064a\\u0646 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0627\\u0644\\u0634\\u0639\\u0648\\u0631 \\u0628\\u0627\\u0644\\u0627\\u0646\\u062a\\u0645\\u0627\\u0621 \\u0644\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639.\",\"\\u0648\\u0631\\u0634 \\u0639\\u0645\\u0644 \\u0648\\u0646\\u062f\\u0648\\u0627\\u062a \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u062d\\u0648\\u0644 \\u0635\\u064a\\u0627\\u0646\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0648\\u0636\\u0628\\u0637 \\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0648\\u062a\\u0642\\u0646\\u064a\\u0627\\u062a \\u0627\\u0644\\u0642\\u064a\\u0627\\u062f\\u0629.\",\"\\u0627\\u0644\\u062a\\u0648\\u0627\\u062c\\u062f \\u0639\\u0644\\u0649 \\u0648\\u0633\\u0627\\u0626\\u0644 \\u0627\\u0644\\u062a\\u0648\\u0627\\u0635\\u0644 \\u0627\\u0644\\u0627\\u062c\\u062a\\u0645\\u0627\\u0639\\u064a \\u0645\\u0639 \\u0631\\u0624\\u0649 \\u0645\\u0646 \\u0648\\u0631\\u0627\\u0621 \\u0627\\u0644\\u0643\\u0648\\u0627\\u0644\\u064a\\u0633 \\u0648\\u0623\\u0636\\u0648\\u0627\\u0621 \\u0643\\u0627\\u0634\\u0641\\u0629 \\u0644\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0648\\u062a\\u063a\\u0637\\u064a\\u0629 \\u0627\\u0644\\u0623\\u062d\\u062f\\u0627\\u062b.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(67,33,21,'التكامل التكنولوجي والابتكار','[\"\\u062f\\u0645\\u062c \\u0645\\u064a\\u0632\\u0627\\u062a \\u0627\\u0644\\u062a\\u0643\\u0646\\u0648\\u0644\\u0648\\u062c\\u064a\\u0627 \\u0627\\u0644\\u0645\\u062a\\u0637\\u0648\\u0631\\u0629 \\u0641\\u064a \\u0634\\u0627\\u0634\\u0627\\u062a \\u0627\\u0644\\u0639\\u0631\\u0636 \\u0648\\u062a\\u0641\\u0627\\u0639\\u0644\\u0627\\u062a \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621.\",\"\\u062c\\u0648\\u0644\\u0627\\u062a \\u0635\\u0627\\u0644\\u0629 \\u0627\\u0644\\u0639\\u0631\\u0636 \\u0627\\u0644\\u0627\\u0641\\u062a\\u0631\\u0627\\u0636\\u064a\\u0629 \\u0648\\u0623\\u062f\\u0648\\u0627\\u062a \\u0627\\u0644\\u062a\\u0643\\u0648\\u064a\\u0646 \\u0639\\u0628\\u0631 \\u0627\\u0644\\u0625\\u0646\\u062a\\u0631\\u0646\\u062a \\u0644\\u0644\\u062a\\u0635\\u0641\\u062d \\u0648\\u0627\\u0644\\u062a\\u062e\\u0635\\u064a\\u0635 \\u0639\\u0646 \\u0628\\u0639\\u062f.\",\"\\u062a\\u0637\\u0628\\u064a\\u0642\\u0627\\u062a \\u0627\\u0644\\u0647\\u0627\\u062a\\u0641 \\u0627\\u0644\\u0645\\u062d\\u0645\\u0648\\u0644 \\u0644\\u062c\\u062f\\u0648\\u0644\\u0629 \\u0645\\u0648\\u0627\\u0639\\u064a\\u062f \\u0627\\u0644\\u062e\\u062f\\u0645\\u0629 \\u0648\\u062a\\u062a\\u0628\\u0639 \\u0635\\u064a\\u0627\\u0646\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a \\u0648\\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0627\\u0644\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u062d\\u0635\\u0631\\u064a\\u0629.\",\"\\u062a\\u0646\\u0641\\u064a\\u0630 \\u0627\\u0633\\u062a\\u0631\\u0627\\u062a\\u064a\\u062c\\u064a\\u0627\\u062a \\u0627\\u0644\\u062a\\u0633\\u0648\\u064a\\u0642 \\u0627\\u0644\\u0631\\u0642\\u0645\\u064a \\u0644\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u062c\\u0645\\u0647\\u0648\\u0631 \\u0623\\u0648\\u0633\\u0639 \\u0648\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621.\",\"\\u0627\\u0644\\u0627\\u0633\\u062a\\u062b\\u0645\\u0627\\u0631 \\u0641\\u064a \\u0627\\u0644\\u0628\\u062d\\u062b \\u0648\\u0627\\u0644\\u062a\\u0637\\u0648\\u064a\\u0631 \\u0644\\u062a\\u0648\\u0642\\u0639 \\u0627\\u0644\\u0627\\u062a\\u062c\\u0627\\u0647\\u0627\\u062a \\u0627\\u0644\\u0645\\u0633\\u062a\\u0642\\u0628\\u0644\\u064a\\u0629 \\u0648\\u062a\\u0641\\u0636\\u064a\\u0644\\u0627\\u062a \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(68,34,21,'مبادرات الاستدامة البيئية','[\"\\u0627\\u0644\\u0627\\u0644\\u062a\\u0632\\u0627\\u0645 \\u0628\\u0627\\u0644\\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0627\\u0644\\u0635\\u062f\\u064a\\u0642\\u0629 \\u0644\\u0644\\u0628\\u064a\\u0626\\u0629 \\u0645\\u062b\\u0644 \\u0627\\u0644\\u0625\\u0636\\u0627\\u0621\\u0629 \\u0627\\u0644\\u0645\\u0648\\u0641\\u0631\\u0629 \\u0644\\u0644\\u0637\\u0627\\u0642\\u0629 \\u0648\\u0628\\u0631\\u0627\\u0645\\u062c \\u0625\\u0639\\u0627\\u062f\\u0629 \\u0627\\u0644\\u062a\\u062f\\u0648\\u064a\\u0631.\",\"\\u0627\\u0644\\u062a\\u0631\\u0648\\u064a\\u062c \\u0644\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0647\\u062c\\u064a\\u0646\\u0629 \\u0648\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0626\\u064a\\u0629 \\u0644\\u062a\\u0642\\u0644\\u064a\\u0644 \\u0627\\u0644\\u0628\\u0635\\u0645\\u0629 \\u0627\\u0644\\u0643\\u0631\\u0628\\u0648\\u0646\\u064a\\u0629.\",\"\\u0627\\u0644\\u062a\\u0639\\u0627\\u0648\\u0646 \\u0645\\u0639 \\u0627\\u0644\\u0645\\u0648\\u0631\\u062f\\u064a\\u0646 \\u0648\\u0627\\u0644\\u0634\\u0631\\u0643\\u0627\\u0621 \\u0627\\u0644\\u0645\\u0647\\u062a\\u0645\\u064a\\u0646 \\u0628\\u0627\\u0644\\u0628\\u064a\\u0626\\u0629.\",\"\\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645 \\u0648\\u0627\\u0644\\u062f\\u0639\\u0648\\u0629 \\u0644\\u0639\\u0627\\u062f\\u0627\\u062a \\u0627\\u0644\\u0642\\u064a\\u0627\\u062f\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062f\\u0627\\u0645\\u0629 \\u0648\\u0635\\u064a\\u0627\\u0646\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0628\\u0627\\u062a.\",\"\\u062c\\u0647\\u0648\\u062f \\u0627\\u0644\\u062a\\u062d\\u0633\\u064a\\u0646 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0645\\u0631 \\u0644\\u062a\\u0642\\u0644\\u064a\\u0644 \\u0627\\u0644\\u062a\\u0623\\u062b\\u064a\\u0631 \\u0627\\u0644\\u0628\\u064a\\u0626\\u064a \\u0641\\u064a \\u062c\\u0645\\u064a\\u0639 \\u062c\\u0648\\u0627\\u0646\\u0628 \\u0627\\u0644\\u0639\\u0645\\u0644\\u064a\\u0627\\u062a.\"]','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(69,35,20,'Riverside Luxury Living','[\"Prime location along the scenic shores of the St. Johns River.\",\"Unobstructed panoramic views of the river and surrounding natural beauty.\",\"Serene and tranquil atmosphere away from the hustle and bustle of city life.\",\"Access to recreational water activities such as boating, kayaking, and fishing.\",\"Opportunities for waterfront dining and entertainment within close proximity.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(70,36,20,'Exquisite Residences','[\"Spacious floor plans with open layouts and abundant natural light.\",\"High-end finishes including hardwood floors, granite countertops, and designer fixtures.\",\"Expansive windows and private balconies offering breathtaking views of the river.\",\"Gourmet kitchens equipped with top-of-the-line appliances and custom cabinetry.\",\"Luxurious master suites with walk-in closets and spa-inspired bathrooms.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(71,37,20,'World-Class Amenities','[\"Infinity-edge pool overlooking the river with expansive sundeck and cabanas.\",\"Fully-equipped fitness center with cardio machines, weights, and yoga studio.\",\"Elegant clubhouse with catering kitchen, lounge area, and billiards room.\",\"Professionally landscaped gardens, walking trails, and outdoor recreation areas.\",\"On-site concierge services offering assistance with reservations, event planning, and more.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(72,38,20,'Community Engagement','[\"Regularly scheduled social events and gatherings for residents to connect and mingle.\",\"Community-focused initiatives such as volunteer opportunities and charity drives.\",\"Resident-led clubs and interest groups catering to a variety of hobbies and interests.\",\"On-site management team dedicated to fostering a sense of community and belonging.\",\"Pet-friendly policies and amenities including a designated dog park and pet washing station.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(73,39,20,'Convenient Location','[\"Easy access to major highways, shopping centers, dining options, and entertainment venues.\",\"Proximity to top-rated schools, medical facilities, and recreational amenities.\",\"Close-knit neighborhood with a strong sense of community and camaraderie.\",\"Public transportation options nearby for convenient travel throughout the city.\",\"Peaceful and secure environment with gated access and 24\\/7 security surveillance.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(74,40,20,'Luxury Lifestyle Services','[\"Personalized concierge services including package delivery, dry cleaning, and grocery shopping.\",\"In-home spa treatments, personal training sessions, and private chef services available upon request.\",\"Complimentary valet parking for residents and guests.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(75,41,20,'Sustainable Living Initiatives','[\"Energy-efficient building design and eco-friendly construction materials.\",\"On-site electric vehicle charging stations and bike storage facilities to promote alternative transportation.\",\"Educational workshops and resources focused on sustainable living practices for residents.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(76,35,21,'ريفرسايد للمعيشة الفاخرة','[\"\\u0645\\u0648\\u0642\\u0639 \\u0645\\u062a\\u0645\\u064a\\u0632 \\u0639\\u0644\\u0649 \\u0637\\u0648\\u0644 \\u0627\\u0644\\u0634\\u0648\\u0627\\u0637\\u0626 \\u0630\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0627\\u0638\\u0631 \\u0627\\u0644\\u062e\\u0644\\u0627\\u0628\\u0629 \\u0644\\u0646\\u0647\\u0631 \\u0633\\u0627\\u0646\\u062a \\u062c\\u0648\\u0646\\u0632.\",\"\\u0625\\u0637\\u0644\\u0627\\u0644\\u0627\\u062a \\u0628\\u0627\\u0646\\u0648\\u0631\\u0627\\u0645\\u064a\\u0629 \\u062f\\u0648\\u0646 \\u0639\\u0627\\u0626\\u0642 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0646\\u0647\\u0631 \\u0648\\u0627\\u0644\\u062c\\u0645\\u0627\\u0644 \\u0627\\u0644\\u0637\\u0628\\u064a\\u0639\\u064a \\u0627\\u0644\\u0645\\u062d\\u064a\\u0637.\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0647\\u0627\\u062f\\u0626\\u0629 \\u0648\\u0647\\u0627\\u062f\\u0626\\u0629 \\u0628\\u0639\\u064a\\u062f\\u064b\\u0627 \\u0639\\u0646 \\u0635\\u062e\\u0628 \\u0627\\u0644\\u062d\\u064a\\u0627\\u0629 \\u0641\\u064a \\u0627\\u0644\\u0645\\u062f\\u064a\\u0646\\u0629.\",\"\\u0625\\u0645\\u0643\\u0627\\u0646\\u064a\\u0629 \\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0627\\u0644\\u0623\\u0646\\u0634\\u0637\\u0629 \\u0627\\u0644\\u0645\\u0627\\u0626\\u064a\\u0629 \\u0627\\u0644\\u062a\\u0631\\u0641\\u064a\\u0647\\u064a\\u0629 \\u0645\\u062b\\u0644 \\u0631\\u0643\\u0648\\u0628 \\u0627\\u0644\\u0642\\u0648\\u0627\\u0631\\u0628 \\u0648\\u0627\\u0644\\u062a\\u062c\\u062f\\u064a\\u0641 \\u0628\\u0627\\u0644\\u0643\\u0627\\u064a\\u0627\\u0643 \\u0648\\u0635\\u064a\\u062f \\u0627\\u0644\\u0623\\u0633\\u0645\\u0627\\u0643.\",\"\\u0641\\u0631\\u0635 \\u0644\\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0648\\u0627\\u0644\\u062a\\u0631\\u0641\\u064a\\u0647 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0648\\u0627\\u062c\\u0647\\u0629 \\u0627\\u0644\\u0628\\u062d\\u0631\\u064a\\u0629 \\u0639\\u0644\\u0649 \\u0645\\u0642\\u0631\\u0628\\u0629.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(77,36,21,'مساكن رائعة','[\"\\u0645\\u062e\\u0637\\u0637\\u0627\\u062a \\u0623\\u0631\\u0636\\u064a\\u0629 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0628\\u0645\\u062e\\u0637\\u0637\\u0627\\u062a \\u0645\\u0641\\u062a\\u0648\\u062d\\u0629 \\u0648\\u0625\\u0636\\u0627\\u0621\\u0629 \\u0637\\u0628\\u064a\\u0639\\u064a\\u0629 \\u0648\\u0641\\u064a\\u0631\\u0629.\",\"\\u062a\\u0634\\u0637\\u064a\\u0628\\u0627\\u062a \\u0631\\u0627\\u0642\\u064a\\u0629 \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u0627\\u0644\\u0623\\u0631\\u0636\\u064a\\u0627\\u062a \\u0627\\u0644\\u0635\\u0644\\u0628\\u0629 \\u0648\\u0623\\u0633\\u0637\\u062d \\u0627\\u0644\\u062c\\u0631\\u0627\\u0646\\u064a\\u062a \\u0648\\u0627\\u0644\\u062a\\u0631\\u0643\\u064a\\u0628\\u0627\\u062a \\u0627\\u0644\\u0645\\u0635\\u0645\\u0645\\u0629.\",\"\\u0646\\u0648\\u0627\\u0641\\u0630 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0648\\u0634\\u0631\\u0641\\u0627\\u062a \\u062e\\u0627\\u0635\\u0629 \\u062a\\u0648\\u0641\\u0631 \\u0625\\u0637\\u0644\\u0627\\u0644\\u0627\\u062a \\u062e\\u0644\\u0627\\u0628\\u0629 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0646\\u0647\\u0631.\",\"\\u0645\\u0637\\u0627\\u0628\\u062e \\u0630\\u0648\\u0627\\u0642\\u0629 \\u0645\\u062c\\u0647\\u0632\\u0629 \\u0628\\u0623\\u062d\\u062f\\u062b \\u0627\\u0644\\u0623\\u062c\\u0647\\u0632\\u0629 \\u0648\\u0627\\u0644\\u062e\\u0632\\u0627\\u0626\\u0646 \\u0627\\u0644\\u0645\\u062e\\u0635\\u0635\\u0629.\",\"\\u0623\\u062c\\u0646\\u062d\\u0629 \\u0631\\u0626\\u064a\\u0633\\u064a\\u0629 \\u0641\\u0627\\u062e\\u0631\\u0629 \\u0645\\u0639 \\u062d\\u062c\\u0631\\u0629 \\u0645\\u0644\\u0627\\u0628\\u0633 \\u0648\\u062d\\u0645\\u0627\\u0645\\u0627\\u062a \\u0645\\u0633\\u062a\\u0648\\u062d\\u0627\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0633\\u0628\\u0627.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(78,37,21,'وسائل الراحة ذات المستوى العالمي','[\"\\u062d\\u0645\\u0627\\u0645 \\u0633\\u0628\\u0627\\u062d\\u0629 \\u0644\\u0627 \\u0645\\u062a\\u0646\\u0627\\u0647\\u064a \\u064a\\u0637\\u0644 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0646\\u0647\\u0631 \\u0645\\u0639 \\u062a\\u0631\\u0627\\u0633 \\u0634\\u0645\\u0633\\u064a \\u0648\\u0627\\u0633\\u0639 \\u0648\\u0643\\u0628\\u0627\\u0626\\u0646.\",\"\\u0645\\u0631\\u0643\\u0632 \\u0644\\u064a\\u0627\\u0642\\u0629 \\u0628\\u062f\\u0646\\u064a\\u0629 \\u0645\\u062c\\u0647\\u0632 \\u0628\\u0627\\u0644\\u0643\\u0627\\u0645\\u0644 \\u0628\\u0623\\u062c\\u0647\\u0632\\u0629 \\u062a\\u0645\\u0627\\u0631\\u064a\\u0646 \\u0627\\u0644\\u0642\\u0644\\u0628 \\u0648\\u0627\\u0644\\u0623\\u0648\\u0632\\u0627\\u0646 \\u0648\\u0627\\u0633\\u062a\\u0648\\u062f\\u064a\\u0648 \\u0627\\u0644\\u064a\\u0648\\u063a\\u0627.\",\"\\u0646\\u0627\\u062f\\u064a \\u0623\\u0646\\u064a\\u0642 \\u064a\\u0636\\u0645 \\u0645\\u0637\\u0628\\u062e\\u064b\\u0627 \\u0644\\u062a\\u0642\\u062f\\u064a\\u0645 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0648\\u0645\\u0646\\u0637\\u0642\\u0629 \\u0635\\u0627\\u0644\\u0629 \\u0648\\u063a\\u0631\\u0641\\u0629 \\u0628\\u0644\\u064a\\u0627\\u0631\\u062f\\u0648.\",\"\\u062d\\u062f\\u0627\\u0626\\u0642 \\u0630\\u0627\\u062a \\u0645\\u0646\\u0627\\u0638\\u0631 \\u0637\\u0628\\u064a\\u0639\\u064a\\u0629 \\u0627\\u062d\\u062a\\u0631\\u0627\\u0641\\u064a\\u0629 \\u0648\\u0645\\u0633\\u0627\\u0631\\u0627\\u062a \\u0644\\u0644\\u0645\\u0634\\u064a \\u0648\\u0645\\u0646\\u0627\\u0637\\u0642 \\u062a\\u0631\\u0641\\u064a\\u0647\\u064a\\u0629 \\u062e\\u0627\\u0631\\u062c\\u064a\\u0629.\",\"\\u062a\\u0642\\u062f\\u0645 \\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0643\\u0648\\u0646\\u0633\\u064a\\u0631\\u062c \\u0641\\u064a \\u0627\\u0644\\u0645\\u0648\\u0642\\u0639 \\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u0627\\u0644\\u062d\\u062c\\u0648\\u0632\\u0627\\u062a \\u0648\\u062a\\u062e\\u0637\\u064a\\u0637 \\u0627\\u0644\\u0623\\u062d\\u062f\\u0627\\u062b \\u0648\\u0627\\u0644\\u0645\\u0632\\u064a\\u062f.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(79,38,21,'المشاركة المجتمعية','[\"\\u0627\\u0644\\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u0648\\u0627\\u0644\\u062a\\u062c\\u0645\\u0639\\u0627\\u062a \\u0627\\u0644\\u0627\\u062c\\u062a\\u0645\\u0627\\u0639\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062c\\u062f\\u0648\\u0644\\u0629 \\u0628\\u0627\\u0646\\u062a\\u0638\\u0627\\u0645 \\u0644\\u0644\\u0645\\u0642\\u064a\\u0645\\u064a\\u0646 \\u0644\\u0644\\u062a\\u0648\\u0627\\u0635\\u0644 \\u0648\\u0627\\u0644\\u0627\\u062e\\u062a\\u0644\\u0627\\u0637.\",\"\\u0627\\u0644\\u0645\\u0628\\u0627\\u062f\\u0631\\u0627\\u062a \\u0627\\u0644\\u062a\\u064a \\u062a\\u0631\\u0643\\u0632 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639 \\u0645\\u062b\\u0644 \\u0641\\u0631\\u0635 \\u0627\\u0644\\u062a\\u0637\\u0648\\u0639 \\u0648\\u0627\\u0644\\u062d\\u0645\\u0644\\u0627\\u062a \\u0627\\u0644\\u062e\\u064a\\u0631\\u064a\\u0629.\",\"\\u0627\\u0644\\u0646\\u0648\\u0627\\u062f\\u064a \\u0627\\u0644\\u062a\\u064a \\u064a\\u0642\\u0648\\u062f\\u0647\\u0627 \\u0627\\u0644\\u0645\\u0642\\u064a\\u0645\\u0648\\u0646 \\u0648\\u0645\\u062c\\u0645\\u0648\\u0639\\u0627\\u062a \\u0627\\u0644\\u0627\\u0647\\u062a\\u0645\\u0627\\u0645 \\u0627\\u0644\\u062a\\u064a \\u062a\\u0644\\u0628\\u064a \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0647\\u0648\\u0627\\u064a\\u0627\\u062a \\u0648\\u0627\\u0644\\u0627\\u0647\\u062a\\u0645\\u0627\\u0645\\u0627\\u062a.\",\"\\u0641\\u0631\\u064a\\u0642 \\u0625\\u062f\\u0627\\u0631\\u0629 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0648\\u0642\\u0639 \\u0645\\u062e\\u0635\\u0635 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0627\\u0644\\u0634\\u0639\\u0648\\u0631 \\u0628\\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639 \\u0648\\u0627\\u0644\\u0627\\u0646\\u062a\\u0645\\u0627\\u0621.\",\"\\u0627\\u0644\\u0633\\u064a\\u0627\\u0633\\u0627\\u062a \\u0648\\u0627\\u0644\\u0645\\u0631\\u0627\\u0641\\u0642 \\u0627\\u0644\\u0635\\u062f\\u064a\\u0642\\u0629 \\u0644\\u0644\\u062d\\u064a\\u0648\\u0627\\u0646\\u0627\\u062a \\u0627\\u0644\\u0623\\u0644\\u064a\\u0641\\u0629 \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u062d\\u062f\\u064a\\u0642\\u0629 \\u0645\\u062e\\u0635\\u0635\\u0629 \\u0644\\u0644\\u0643\\u0644\\u0627\\u0628 \\u0648\\u0645\\u062d\\u0637\\u0629 \\u0644\\u063a\\u0633\\u064a\\u0644 \\u0627\\u0644\\u062d\\u064a\\u0648\\u0627\\u0646\\u0627\\u062a \\u0627\\u0644\\u0623\\u0644\\u064a\\u0641\\u0629.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(80,39,21,'موقع ملائم','[\"\\u0633\\u0647\\u0648\\u0644\\u0629 \\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0627\\u0644\\u0637\\u0631\\u0642 \\u0627\\u0644\\u0633\\u0631\\u064a\\u0639\\u0629 \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629 \\u0648\\u0645\\u0631\\u0627\\u0643\\u0632 \\u0627\\u0644\\u062a\\u0633\\u0648\\u0642 \\u0648\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0648\\u0623\\u0645\\u0627\\u0643\\u0646 \\u0627\\u0644\\u062a\\u0631\\u0641\\u064a\\u0647.\",\"\\u0627\\u0644\\u0642\\u0631\\u0628 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u062f\\u0627\\u0631\\u0633 \\u0630\\u0627\\u062a \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641 \\u0627\\u0644\\u0639\\u0627\\u0644\\u064a \\u0648\\u0627\\u0644\\u0645\\u0631\\u0627\\u0641\\u0642 \\u0627\\u0644\\u0637\\u0628\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0645\\u0631\\u0627\\u0641\\u0642 \\u0627\\u0644\\u062a\\u0631\\u0641\\u064a\\u0647\\u064a\\u0629.\",\"\\u062d\\u064a \\u0645\\u062a\\u0645\\u0627\\u0633\\u0643 \\u064a\\u062a\\u0645\\u062a\\u0639 \\u0628\\u0625\\u062d\\u0633\\u0627\\u0633 \\u0642\\u0648\\u064a \\u0628\\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639 \\u0648\\u0627\\u0644\\u0635\\u062f\\u0627\\u0642\\u0629 \\u0627\\u0644\\u062d\\u0645\\u064a\\u0645\\u0629.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0646\\u0642\\u0644 \\u0627\\u0644\\u0639\\u0627\\u0645 \\u0627\\u0644\\u0642\\u0631\\u064a\\u0628\\u0629 \\u0644\\u0644\\u0633\\u0641\\u0631 \\u0627\\u0644\\u0645\\u0631\\u064a\\u062d \\u0641\\u064a \\u062c\\u0645\\u064a\\u0639 \\u0623\\u0646\\u062d\\u0627\\u0621 \\u0627\\u0644\\u0645\\u062f\\u064a\\u0646\\u0629.\",\"\\u0628\\u064a\\u0626\\u0629 \\u0633\\u0644\\u0645\\u064a\\u0629 \\u0648\\u0622\\u0645\\u0646\\u0629 \\u0645\\u0639 \\u0628\\u0648\\u0627\\u0628\\u0629 \\u062f\\u062e\\u0648\\u0644 \\u0648\\u0645\\u0631\\u0627\\u0642\\u0628\\u0629 \\u0623\\u0645\\u0646\\u064a\\u0629 \\u0639\\u0644\\u0649 \\u0645\\u062f\\u0627\\u0631 \\u0627\\u0644\\u0633\\u0627\\u0639\\u0629 \\u0637\\u0648\\u0627\\u0644 \\u0623\\u064a\\u0627\\u0645 \\u0627\\u0644\\u0623\\u0633\\u0628\\u0648\\u0639.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(81,40,21,'خدمات نمط الحياة الفاخرة','[\"\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0643\\u0648\\u0646\\u0633\\u064a\\u0631\\u062c \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629 \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u062a\\u0648\\u0635\\u064a\\u0644 \\u0627\\u0644\\u0637\\u0631\\u0648\\u062f \\u0648\\u0627\\u0644\\u062a\\u0646\\u0638\\u064a\\u0641 \\u0627\\u0644\\u062c\\u0627\\u0641 \\u0648\\u062a\\u0633\\u0648\\u0642 \\u0627\\u0644\\u0628\\u0642\\u0627\\u0644\\u0629.\",\"\\u062a\\u062a\\u0648\\u0641\\u0631 \\u0639\\u0644\\u0627\\u062c\\u0627\\u062a \\u0627\\u0644\\u0633\\u0628\\u0627 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0646\\u0632\\u0644 \\u0648\\u062c\\u0644\\u0633\\u0627\\u062a \\u0627\\u0644\\u062a\\u062f\\u0631\\u064a\\u0628 \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629 \\u0648\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0637\\u0647\\u0627\\u0629 \\u0627\\u0644\\u062e\\u0627\\u0635\\u0629 \\u0639\\u0646\\u062f \\u0627\\u0644\\u0637\\u0644\\u0628.\",\"\\u062e\\u062f\\u0645\\u0629 \\u0635\\u0641 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0645\\u062c\\u0627\\u0646\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0642\\u064a\\u0645\\u064a\\u0646 \\u0648\\u0627\\u0644\\u0636\\u064a\\u0648\\u0641.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(82,41,21,'مبادرات المعيشة المستدامة','[\"\\u062a\\u0635\\u0645\\u064a\\u0645 \\u0627\\u0644\\u0645\\u0628\\u0627\\u0646\\u064a \\u0627\\u0644\\u0645\\u0648\\u0641\\u0631\\u0629 \\u0644\\u0644\\u0637\\u0627\\u0642\\u0629 \\u0648\\u0645\\u0648\\u0627\\u062f \\u0627\\u0644\\u0628\\u0646\\u0627\\u0621 \\u0627\\u0644\\u0635\\u062f\\u064a\\u0642\\u0629 \\u0644\\u0644\\u0628\\u064a\\u0626\\u0629.\",\"\\u0645\\u062d\\u0637\\u0627\\u062a \\u0634\\u062d\\u0646 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0626\\u064a\\u0629 \\u0648\\u0645\\u0631\\u0627\\u0641\\u0642 \\u062a\\u062e\\u0632\\u064a\\u0646 \\u0627\\u0644\\u062f\\u0631\\u0627\\u062c\\u0627\\u062a \\u0641\\u064a \\u0627\\u0644\\u0645\\u0648\\u0642\\u0639 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0648\\u0633\\u0627\\u0626\\u0644 \\u0627\\u0644\\u0646\\u0642\\u0644 \\u0627\\u0644\\u0628\\u062f\\u064a\\u0644\\u0629.\",\"\\u062a\\u0631\\u0643\\u0632 \\u0648\\u0631\\u0634 \\u0627\\u0644\\u0639\\u0645\\u0644 \\u0648\\u0627\\u0644\\u0645\\u0648\\u0627\\u0631\\u062f \\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0639\\u0644\\u0649 \\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0627\\u0644\\u0645\\u0639\\u064a\\u0634\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062f\\u0627\\u0645\\u0629 \\u0644\\u0644\\u0645\\u0642\\u064a\\u0645\\u064a\\u0646.\"]','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(97,49,20,'Authentic Bengali Cuisine','[\"Traditional recipes passed down through generations.\",\"Freshly ground spices for authentic flavors.\",\"Locally sourced ingredients for freshness.\",\"Menu showcases the diverse culinary heritage of Bangladesh.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(98,50,20,'Warm Hospitality','[\"Friendly and attentive staff.\",\"Welcoming ambiance with a cozy atmosphere.\",\"Personalized service for a memorable dining experience.\",\"Staff knowledgeable about the menu and able to make recommendations.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(99,51,20,'Global Fusion Creations','[\"Innovative dishes that blend Bengali flavors with global influences.\",\"Fusion cuisine inspired by international culinary trends.\",\"Creative reinterpretation of traditional favorites.\",\"Diverse menu caters to varied tastes and preferences.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(100,52,20,'Fresh Seafood Selection','[\"Daily deliveries of the freshest seafood from local markets.\",\"Expertly prepared dishes highlight the natural flavors of the sea.\",\"Extensive seafood menu featuring prawns, fish, and more.\",\"Options for grilled, fried, or curry preparations.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(101,53,20,'Vegetarian Specialties','[\"Abundant selection of vegetarian dishes.\",\"Fresh and flavorful vegetable curries and stir-fries.\",\"Paneer dishes showcasing homemade cheese and bold spices.\",\"Veggie thalis with a variety of sides for a complete meal.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(102,54,20,'Cozy Ambiance','[\"Rustic decor with modern touches.\",\"Comfortable seating arrangements for individuals and groups.\",\"Soft lighting creates a warm and inviting atmosphere.\",\"Relaxed setting perfect for casual dining or special occasions.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(103,55,20,'Thali Meals','[\"Generous portions of assorted dishes served on a platter.\",\"Ideal for those wanting to sample a variety of flavors.\",\"Vegetarian and non-vegetarian options available.\",\"Perfect for sharing with family and friends.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(104,56,20,'Takeaway and Delivery Services','[\"Convenient takeaway options for on-the-go meals.\",\"Delivery services available for those dining at home.\",\"Packaging designed to maintain food quality and freshness.\",\"Easy ordering process via phone or online platforms.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(105,49,21,'المطبخ البنغالي الأصيل','[\"\\u0648\\u0635\\u0641\\u0627\\u062a \\u062a\\u0642\\u0644\\u064a\\u062f\\u064a\\u0629 \\u062a\\u0646\\u062a\\u0642\\u0644 \\u0639\\u0628\\u0631 \\u0627\\u0644\\u0623\\u062c\\u064a\\u0627\\u0644.\",\"\\u0628\\u0647\\u0627\\u0631\\u0627\\u062a \\u0645\\u0637\\u062d\\u0648\\u0646\\u0629 \\u0637\\u0627\\u0632\\u062c\\u0629 \\u0644\\u0646\\u0643\\u0647\\u0627\\u062a \\u0623\\u0635\\u064a\\u0644\\u0629.\",\"\\u0627\\u0644\\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629 \\u0644\\u0644\\u0646\\u0636\\u0627\\u0631\\u0629.\",\"\\u062a\\u0639\\u0631\\u0636 \\u0627\\u0644\\u0642\\u0627\\u0626\\u0645\\u0629 \\u062a\\u0631\\u0627\\u062b \\u0627\\u0644\\u0637\\u0647\\u064a \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639 \\u0641\\u064a \\u0628\\u0646\\u063a\\u0644\\u0627\\u062f\\u064a\\u0634.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(106,50,21,'كرم الضيافة','[\"\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646 \\u0648\\u062f\\u064a\\u0629 \\u0648\\u0627\\u0644\\u064a\\u0642\\u0638\\u0629.\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u062a\\u0631\\u062d\\u064a\\u0628\\u064a\\u0629 \\u0645\\u0639 \\u062c\\u0648 \\u0645\\u0631\\u064a\\u062d.\",\"\\u062e\\u062f\\u0645\\u0629 \\u0634\\u062e\\u0635\\u064a\\u0629 \\u0644\\u062a\\u062c\\u0631\\u0628\\u0629 \\u0637\\u0639\\u0627\\u0645 \\u0644\\u0627 \\u062a\\u0646\\u0633\\u0649.\",\"\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u0648\\u0646 \\u0639\\u0644\\u0649 \\u062f\\u0631\\u0627\\u064a\\u0629 \\u0628\\u0627\\u0644\\u0642\\u0627\\u0626\\u0645\\u0629 \\u0648\\u0642\\u0627\\u062f\\u0631\\u0648\\u0646 \\u0639\\u0644\\u0649 \\u062a\\u0642\\u062f\\u064a\\u0645 \\u0627\\u0644\\u062a\\u0648\\u0635\\u064a\\u0627\\u062a.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(107,51,21,'إبداعات الانصهار العالمية','[\"\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0645\\u0628\\u062a\\u0643\\u0631\\u0629 \\u062a\\u0645\\u0632\\u062c \\u0627\\u0644\\u0646\\u0643\\u0647\\u0627\\u062a \\u0627\\u0644\\u0628\\u0646\\u063a\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0639 \\u0627\\u0644\\u062a\\u0623\\u062b\\u064a\\u0631\\u0627\\u062a \\u0627\\u0644\\u0639\\u0627\\u0644\\u0645\\u064a\\u0629.\",\"\\u0627\\u0644\\u0645\\u0637\\u0628\\u062e \\u0627\\u0644\\u0645\\u0646\\u062f\\u0645\\u062c \\u0645\\u0633\\u062a\\u0648\\u062d\\u0649 \\u0645\\u0646 \\u0627\\u062a\\u062c\\u0627\\u0647\\u0627\\u062a \\u0627\\u0644\\u0637\\u0647\\u064a \\u0627\\u0644\\u0639\\u0627\\u0644\\u0645\\u064a\\u0629.\",\"\\u0625\\u0639\\u0627\\u062f\\u0629 \\u062a\\u0641\\u0633\\u064a\\u0631 \\u0625\\u0628\\u062f\\u0627\\u0639\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0641\\u0636\\u0644\\u0627\\u062a \\u0627\\u0644\\u062a\\u0642\\u0644\\u064a\\u062f\\u064a\\u0629.\",\"\\u0642\\u0627\\u0626\\u0645\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u062a\\u0644\\u0628\\u064a \\u0627\\u0644\\u0623\\u0630\\u0648\\u0627\\u0642 \\u0648\\u0627\\u0644\\u062a\\u0641\\u0636\\u064a\\u0644\\u0627\\u062a \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(108,52,21,'اختيار المأكولات البحرية الطازجة','[\"\\u062a\\u0648\\u0635\\u064a\\u0644\\u0627\\u062a \\u064a\\u0648\\u0645\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0623\\u0643\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u0628\\u062d\\u0631\\u064a\\u0629 \\u0627\\u0644\\u0637\\u0627\\u0632\\u062c\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0623\\u0633\\u0648\\u0627\\u0642 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u0629.\",\"\\u0648\\u062a\\u0633\\u0644\\u0637 \\u0627\\u0644\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0627\\u0644\\u0645\\u0639\\u062f\\u0629 \\u0628\\u062e\\u0628\\u0631\\u0629 \\u0627\\u0644\\u0636\\u0648\\u0621 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0646\\u0643\\u0647\\u0627\\u062a \\u0627\\u0644\\u0637\\u0628\\u064a\\u0639\\u064a\\u0629 \\u0644\\u0644\\u0628\\u062d\\u0631.\",\"\\u0642\\u0627\\u0626\\u0645\\u0629 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u0623\\u0643\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u0628\\u062d\\u0631\\u064a\\u0629 \\u062a\\u0636\\u0645 \\u0627\\u0644\\u0642\\u0631\\u064a\\u062f\\u0633 \\u0648\\u0627\\u0644\\u0623\\u0633\\u0645\\u0627\\u0643 \\u0648\\u0623\\u0643\\u062b\\u0631 \\u0645\\u0646 \\u0630\\u0644\\u0643.\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0644\\u062a\\u062d\\u0636\\u064a\\u0631\\u0627\\u062a \\u0627\\u0644\\u0645\\u0634\\u0648\\u064a\\u0629 \\u0623\\u0648 \\u0627\\u0644\\u0645\\u0642\\u0644\\u064a\\u0629 \\u0623\\u0648 \\u0627\\u0644\\u0643\\u0627\\u0631\\u064a.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(109,53,21,'التخصصات النباتية','[\"\\u062a\\u0634\\u0643\\u064a\\u0644\\u0629 \\u0648\\u0641\\u064a\\u0631\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0627\\u0644\\u0646\\u0628\\u0627\\u062a\\u064a\\u0629.\",\"\\u0643\\u0627\\u0631\\u064a \\u0646\\u0628\\u0627\\u062a\\u064a \\u0637\\u0627\\u0632\\u062c \\u0648\\u0644\\u0630\\u064a\\u0630 \\u0648\\u0645\\u0642\\u0644\\u064a.\",\"\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0628\\u0627\\u0646\\u064a\\u0631 \\u062a\\u0639\\u0631\\u0636 \\u0627\\u0644\\u062c\\u0628\\u0646 \\u0645\\u062d\\u0644\\u064a \\u0627\\u0644\\u0635\\u0646\\u0639 \\u0648\\u0627\\u0644\\u062a\\u0648\\u0627\\u0628\\u0644 \\u0627\\u0644\\u062c\\u0631\\u064a\\u0626\\u0629.\",\"\\u062b\\u0627\\u0644\\u064a\\u0633 \\u0646\\u0628\\u0627\\u062a\\u064a \\u0645\\u0639 \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u062c\\u0648\\u0627\\u0646\\u0628 \\u0644\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u0649 \\u0648\\u062c\\u0628\\u0629 \\u0643\\u0627\\u0645\\u0644\\u0629.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(110,54,21,'أجواء مريحة','[\"\\u062f\\u064a\\u0643\\u0648\\u0631 \\u0631\\u064a\\u0641\\u064a \\u0645\\u0639 \\u0644\\u0645\\u0633\\u0627\\u062a \\u062d\\u062f\\u064a\\u062b\\u0629.\",\"\\u062a\\u0631\\u062a\\u064a\\u0628\\u0627\\u062a \\u062c\\u0644\\u0648\\u0633 \\u0645\\u0631\\u064a\\u062d\\u0629 \\u0644\\u0644\\u0623\\u0641\\u0631\\u0627\\u062f \\u0648\\u0627\\u0644\\u0645\\u062c\\u0645\\u0648\\u0639\\u0627\\u062a.\",\"\\u0627\\u0644\\u0625\\u0636\\u0627\\u0621\\u0629 \\u0627\\u0644\\u0646\\u0627\\u0639\\u0645\\u0629 \\u062a\\u062e\\u0644\\u0642 \\u062c\\u0648\\u064b\\u0627 \\u062f\\u0627\\u0641\\u0626\\u064b\\u0627 \\u0648\\u062c\\u0630\\u0627\\u0628\\u064b\\u0627.\",\"\\u0645\\u0643\\u0627\\u0646 \\u0645\\u0631\\u064a\\u062d \\u0645\\u062b\\u0627\\u0644\\u064a \\u0644\\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u063a\\u064a\\u0631 \\u0627\\u0644\\u0631\\u0633\\u0645\\u064a \\u0623\\u0648 \\u0627\\u0644\\u0645\\u0646\\u0627\\u0633\\u0628\\u0627\\u062a \\u0627\\u0644\\u062e\\u0627\\u0635\\u0629.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(111,55,21,'وجبات ثالي','[\"\\u064a\\u062a\\u0645 \\u062a\\u0642\\u062f\\u064a\\u0645 \\u0623\\u062c\\u0632\\u0627\\u0621 \\u0633\\u062e\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0639\\u0644\\u0649 \\u0637\\u0628\\u0642.\",\"\\u0645\\u062b\\u0627\\u0644\\u064a\\u0629 \\u0644\\u0623\\u0648\\u0644\\u0626\\u0643 \\u0627\\u0644\\u0630\\u064a\\u0646 \\u064a\\u0631\\u064a\\u062f\\u0648\\u0646 \\u062a\\u0630\\u0648\\u0642 \\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0646\\u0643\\u0647\\u0627\\u062a.\",\"\\u062a\\u062a\\u0648\\u0641\\u0631 \\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0646\\u0628\\u0627\\u062a\\u064a\\u0629 \\u0648\\u063a\\u064a\\u0631 \\u0646\\u0628\\u0627\\u062a\\u064a\\u0629.\",\"\\u0645\\u062b\\u0627\\u0644\\u064a\\u0629 \\u0644\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0645\\u0639 \\u0627\\u0644\\u0639\\u0627\\u0626\\u0644\\u0629 \\u0648\\u0627\\u0644\\u0623\\u0635\\u062f\\u0642\\u0627\\u0621.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(112,56,21,'خدمات الوجبات الجاهزة والتوصيل','[\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0627\\u0644\\u062c\\u0627\\u0647\\u0632\\u0629 \\u0645\\u0631\\u064a\\u062d\\u0629 \\u0644\\u0644\\u0648\\u062c\\u0628\\u0627\\u062a \\u0623\\u062b\\u0646\\u0627\\u0621 \\u0627\\u0644\\u062a\\u0646\\u0642\\u0644.\",\"\\u062a\\u062a\\u0648\\u0641\\u0631 \\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u0648\\u0635\\u064a\\u0644 \\u0644\\u0623\\u0648\\u0644\\u0626\\u0643 \\u0627\\u0644\\u0630\\u064a\\u0646 \\u064a\\u062a\\u0646\\u0627\\u0648\\u0644\\u0648\\u0646 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0646\\u0632\\u0644.\",\"\\u0627\\u0644\\u062a\\u0639\\u0628\\u0626\\u0629 \\u0648\\u0627\\u0644\\u062a\\u063a\\u0644\\u064a\\u0641 \\u0645\\u0635\\u0645\\u0645\\u0629 \\u0644\\u0644\\u062d\\u0641\\u0627\\u0638 \\u0639\\u0644\\u0649 \\u062c\\u0648\\u062f\\u0629 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0648\\u0646\\u0636\\u0627\\u0631\\u062a\\u0647.\",\"\\u0639\\u0645\\u0644\\u064a\\u0629 \\u0627\\u0644\\u0637\\u0644\\u0628 \\u0633\\u0647\\u0644\\u0629 \\u0639\\u0628\\u0631 \\u0627\\u0644\\u0647\\u0627\\u062a\\u0641 \\u0623\\u0648 \\u0627\\u0644\\u0645\\u0646\\u0635\\u0627\\u062a \\u0639\\u0628\\u0631 \\u0627\\u0644\\u0625\\u0646\\u062a\\u0631\\u0646\\u062a.\"]','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(113,57,20,'Chic Black and White Décor','[\"Elegant monochromatic theme\",\"Stylish bistro-style furnishings\",\"Artistic wall accents\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(114,58,20,'Artisanal Coffee Selection','[\"Locally sourced beans\",\"Diverse brewing methods\",\"Signature house blends\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(115,59,20,'Seasonal Menu Offerings','[\"Fresh, locally sourced ingredients\",\"Rotating specials\",\"Emphasis on seasonal produce\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(116,60,20,'Cozy Ambiance','[\"Soft jazz music\",\"Warm lighting\",\"Comfortable seating\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(117,61,20,'Exceptional Service','[\"Friendly and attentive staff\",\"Personalized recommendations\",\"Prompt and efficient service\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(118,62,20,'Varied Menu Options','[\"Breakfast, lunch, and dessert offerings\",\"Vegetarian and gluten-free options\",\"International influences\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(119,63,20,'Community Engagement','[\"Support of local artists\",\"Participation in neighborhood events\",\"Collaboration with nearby businesses\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(120,64,20,'Outdoor Seating','[\"Al fresco dining option\",\"Charming sidewalk caf\\u00e9 atmosphere\",\"Ideal for people-watching\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(121,57,21,'ديكور أنيق باللونين الأبيض والأسود','[\"\\u0645\\u0648\\u0636\\u0648\\u0639 \\u0623\\u062d\\u0627\\u062f\\u064a \\u0627\\u0644\\u0644\\u0648\\u0646 \\u0623\\u0646\\u064a\\u0642\",\"\\u0645\\u0641\\u0631\\u0648\\u0634\\u0627\\u062a \\u0623\\u0646\\u064a\\u0642\\u0629 \\u0639\\u0644\\u0649 \\u0637\\u0631\\u0627\\u0632 \\u0627\\u0644\\u0628\\u064a\\u0633\\u062a\\u0631\\u0648\",\"\\u0644\\u0647\\u062c\\u0627\\u062a \\u0627\\u0644\\u062c\\u062f\\u0627\\u0631 \\u0627\\u0644\\u0641\\u0646\\u064a\\u0629\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(122,58,21,'اختيار القهوة الحرفية','[\"\\u0627\\u0644\\u0641\\u0648\\u0644 \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629\",\"\\u0637\\u0631\\u0642 \\u0627\\u0644\\u062a\\u062e\\u0645\\u064a\\u0631 \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629\",\"\\u064a\\u0645\\u0632\\u062c \\u0627\\u0644\\u0628\\u064a\\u062a \\u0627\\u0644\\u0645\\u0645\\u064a\\u0632\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(123,59,21,'عروض القائمة الموسمية','[\"\\u0627\\u0644\\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0627\\u0644\\u0637\\u0627\\u0632\\u062c\\u0629 \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629\",\"\\u0639\\u0631\\u0648\\u0636 \\u062e\\u0627\\u0635\\u0629 \\u062f\\u0648\\u0627\\u0631\\u0629\",\"\\u0627\\u0644\\u062a\\u0631\\u0643\\u064a\\u0632 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0645\\u0646\\u062a\\u062c\\u0627\\u062a \\u0627\\u0644\\u0645\\u0648\\u0633\\u0645\\u064a\\u0629\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(124,60,21,'أجواء مريحة','[\"\\u0645\\u0648\\u0633\\u064a\\u0642\\u0649 \\u0627\\u0644\\u062c\\u0627\\u0632 \\u0627\\u0644\\u0646\\u0627\\u0639\\u0645\\u0629\",\"\\u0627\\u0644\\u0625\\u0636\\u0627\\u0621\\u0629 \\u0627\\u0644\\u062f\\u0627\\u0641\\u0626\\u0629\",\"\\u0645\\u0642\\u0627\\u0639\\u062f \\u0645\\u0631\\u064a\\u062d\\u0629\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(125,61,21,'خدمة استثنائية','[\"\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646 \\u0648\\u062f\\u064a\\u0629 \\u0648\\u0627\\u0644\\u064a\\u0642\\u0638\\u0629\",\"\\u062a\\u0648\\u0635\\u064a\\u0627\\u062a \\u0634\\u062e\\u0635\\u064a\\u0629\",\"\\u062e\\u062f\\u0645\\u0629 \\u0633\\u0631\\u064a\\u0639\\u0629 \\u0648\\u0641\\u0639\\u0627\\u0644\\u0629\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(126,62,21,'خيارات القائمة المتنوعة','[\"\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0625\\u0641\\u0637\\u0627\\u0631 \\u0648\\u0627\\u0644\\u063a\\u062f\\u0627\\u0621 \\u0648\\u0627\\u0644\\u062d\\u0644\\u0648\\u064a\\u0627\\u062a\",\"\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0646\\u0628\\u0627\\u062a\\u064a\\u0629 \\u0648\\u062e\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u063a\\u0644\\u0648\\u062a\\u064a\\u0646\",\"\\u0627\\u0644\\u062a\\u0623\\u062b\\u064a\\u0631\\u0627\\u062a \\u0627\\u0644\\u062f\\u0648\\u0644\\u064a\\u0629\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(127,63,21,'المشاركة المجتمعية','[\"\\u062f\\u0639\\u0645 \\u0627\\u0644\\u0641\\u0646\\u0627\\u0646\\u064a\\u0646 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u064a\\u0646\",\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0641\\u064a \\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u0627\\u0644\\u062d\\u064a\",\"\\u0627\\u0644\\u062a\\u0639\\u0627\\u0648\\u0646 \\u0645\\u0639 \\u0627\\u0644\\u0634\\u0631\\u0643\\u0627\\u062a \\u0627\\u0644\\u0642\\u0631\\u064a\\u0628\\u0629\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(128,64,21,'جلوس في الهواء الطلق','[\"\\u062e\\u064a\\u0627\\u0631 \\u062a\\u0646\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0637\\u0639\\u0627\\u0645 \\u0641\\u064a \\u0627\\u0644\\u0647\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0637\\u0644\\u0642\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0645\\u0642\\u0647\\u0649 \\u0627\\u0644\\u0631\\u0635\\u064a\\u0641 \\u0627\\u0644\\u0633\\u0627\\u062d\\u0631\\u0629\",\"\\u0645\\u062b\\u0627\\u0644\\u064a\\u0629 \\u0644\\u0645\\u0634\\u0627\\u0647\\u062f\\u0629 \\u0627\\u0644\\u0646\\u0627\\u0633\"]','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(129,65,20,'Wide Range, Top Brands','[\"Diverse Equipment Selection\",\"Premium Brands Available\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(130,66,20,'Expert Guidance','[\"Personalized Assistance\",\"Knowledgeable Staff\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(131,67,20,'Knowledgeable Staff','[\"CBD Accessibility\",\"Parking Available\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(132,68,20,'Community Engagement','[\"Events & Workshops\",\"Lively Fitness Community\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(133,69,20,'Cutting-Edge Tech','[\"Latest Features\",\"User-Friendly Design\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(134,70,20,'Customer Satisfaction','[\"Hassle-Free Returns\",\"Responsive Support Team\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(135,71,20,'Health & Safety Priority','[\"Clean Environment\",\"Social Distancing Measures\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(136,65,21,'مجموعة واسعة، أعلى العلامات التجارية','[\"\\u0627\\u062e\\u062a\\u064a\\u0627\\u0631 \\u0627\\u0644\\u0645\\u0639\\u062f\\u0627\\u062a \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629\",\"\\u0627\\u0644\\u0639\\u0644\\u0627\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u062c\\u0627\\u0631\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062a\\u0645\\u064a\\u0632\\u0629 \\u0627\\u0644\\u0645\\u062a\\u0627\\u062d\\u0629\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(137,66,21,'إرشادات الخبراء','[\"\\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629\",\"\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646 \\u0630\\u0648\\u064a \\u0627\\u0644\\u0645\\u0639\\u0631\\u0641\\u0629\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(138,67,21,'الموظفين ذوي المعرفة','[\"\\u0625\\u0645\\u0643\\u0627\\u0646\\u064a\\u0629 \\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0627\\u062a\\u0641\\u0627\\u0642\\u064a\\u0629 \\u0627\\u0644\\u062a\\u0646\\u0648\\u0639 \\u0627\\u0644\\u0628\\u064a\\u0648\\u0644\\u0648\\u062c\\u064a\",\"\\u0645\\u0648\\u0627\\u0642\\u0641 \\u0627\\u0644\\u0633\\u064a\\u0627\\u0631\\u0627\\u062a \\u0645\\u062a\\u0627\\u062d\\u0629\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(139,68,21,'المشاركة المجتمعية','[\"\\u0627\\u0644\\u0623\\u062d\\u062f\\u0627\\u062b \\u0648\\u0648\\u0631\\u0634 \\u0627\\u0644\\u0639\\u0645\\u0644\",\"\\u0645\\u062c\\u062a\\u0645\\u0639 \\u0627\\u0644\\u0644\\u064a\\u0627\\u0642\\u0629 \\u0627\\u0644\\u0628\\u062f\\u0646\\u064a\\u0629 \\u0627\\u0644\\u062d\\u064a\\u0648\\u064a\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(140,69,21,'أحدث التقنيات','[\"\\u0623\\u062d\\u062f\\u062b \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a\",\"\\u062a\\u0635\\u0645\\u064a\\u0645 \\u0633\\u0647\\u0644 \\u0627\\u0644\\u0627\\u0633\\u062a\\u062e\\u062f\\u0627\\u0645\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(141,70,21,'رضا العملاء','[\"\\u0639\\u0648\\u0627\\u0626\\u062f \\u062e\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u062a\\u0627\\u0639\\u0628\",\"\\u0641\\u0631\\u064a\\u0642 \\u0627\\u0644\\u062f\\u0639\\u0645 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062c\\u064a\\u0628\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(142,71,21,'أولوية الصحة والسلامة','[\"\\u0628\\u064a\\u0626\\u0629 \\u0646\\u0638\\u064a\\u0641\\u0629\",\"\\u0625\\u062c\\u0631\\u0627\\u0621\\u0627\\u062a \\u0627\\u0644\\u0625\\u0628\\u0639\\u0627\\u062f \\u0627\\u0644\\u0627\\u062c\\u062a\\u0645\\u0627\\u0639\\u064a\"]','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(143,72,20,'Wide Selection of High-Quality Hospital Beds','[\"Comprehensive range of hospital beds including basic, adjustable, specialty, and ICU models.\",\"Beds sourced from reputable manufacturers known for their reliability and durability.\",\"Options available for various healthcare settings including hospitals, nursing homes, rehabilitation centers, and home care.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(144,73,20,'Personalized Consultation and Guidance','[\"Knowledgeable and friendly staff offering personalized assistance throughout the selection process.\",\"Understanding of specific needs, preferences, and budget constraints to recommend suitable products.\",\"Expert advice on features, functionalities, and accessories to optimize patient comfort and care.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(145,74,20,'Complementary Accessories and Equipment','[\"Extensive selection of accessories including bedside tables, overbed trays, bed rails, and patient lift systems.\",\"Specialized mattresses and pressure relief systems to prevent bedsores and enhance patient comfort.\",\"Supplementary equipment such as IV poles, bedside commodes, and patient monitoring devices available to create a complete care environment.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(146,75,20,'Installation Services and Technical Support','[\"Professional installation services provided by skilled technicians to ensure proper setup and functionality.\",\"Comprehensive training and guidance for caregivers on operating and maintaining hospital beds.\",\"Prompt technical support and troubleshooting assistance to address any issues or concerns.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(147,76,20,'Post-Sales Maintenance and Warranty Coverage','[\"Regular maintenance and inspection services offered to prolong the lifespan of hospital beds and ensure optimal performance.\",\"Warranty coverage provided for all products, with prompt resolution of any defects or malfunctions.\",\"Hassle-free repair and replacement process facilitated by dedicated customer support team.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(148,77,20,'Community Engagement and Industry Collaboration','[\"Active involvement in the local healthcare community through partnerships with hospitals, clinics, and care facilities.\",\"Collaboration with healthcare professionals to stay abreast of industry trends and technological advancements.\",\"Participation in health fairs, seminars, and educational events to promote awareness and best practices in patient care.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(149,78,20,'Commitment to Customer Satisfaction and Feedback','[\"Continuous commitment to exceeding customer expectations through exceptional service and support.\",\"Regular solicitation of feedback and testimonials to gauge customer satisfaction and identify areas for improvement.\",\"Implementation of customer suggestions and recommendations to enhance product offerings and service delivery.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(150,72,21,'مجموعة واسعة من أسرة المستشفيات عالية الجودة','[\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0634\\u0627\\u0645\\u0644\\u0629 \\u0645\\u0646 \\u0623\\u0633\\u0631\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u0627\\u0644\\u0646\\u0645\\u0627\\u0630\\u062c \\u0627\\u0644\\u0623\\u0633\\u0627\\u0633\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0642\\u0627\\u0628\\u0644\\u0629 \\u0644\\u0644\\u062a\\u0639\\u062f\\u064a\\u0644 \\u0648\\u0627\\u0644\\u062a\\u062e\\u0635\\u0635 \\u0648\\u0648\\u062d\\u062f\\u0629 \\u0627\\u0644\\u0639\\u0646\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0632\\u0629.\",\"\\u064a\\u062a\\u0645 \\u0627\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0623\\u0633\\u0631\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0634\\u0631\\u0643\\u0627\\u062a \\u0627\\u0644\\u0645\\u0635\\u0646\\u0639\\u0629 \\u0630\\u0627\\u062a \\u0627\\u0644\\u0633\\u0645\\u0639\\u0629 \\u0627\\u0644\\u0637\\u064a\\u0628\\u0629 \\u0648\\u0627\\u0644\\u0645\\u0639\\u0631\\u0648\\u0641\\u0629 \\u0628\\u0645\\u0648\\u062b\\u0648\\u0642\\u064a\\u062a\\u0647\\u0627 \\u0648\\u0645\\u062a\\u0627\\u0646\\u062a\\u0647\\u0627.\",\"\\u0627\\u0644\\u062e\\u064a\\u0627\\u0631\\u0627\\u062a \\u0627\\u0644\\u0645\\u062a\\u0627\\u062d\\u0629 \\u0644\\u0645\\u062e\\u062a\\u0644\\u0641 \\u0625\\u0639\\u062f\\u0627\\u062f\\u0627\\u062a \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0635\\u062d\\u064a\\u0629 \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a \\u0648\\u062f\\u0648\\u0631 \\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0633\\u0646\\u064a\\u0646 \\u0648\\u0645\\u0631\\u0627\\u0643\\u0632 \\u0625\\u0639\\u0627\\u062f\\u0629 \\u0627\\u0644\\u062a\\u0623\\u0647\\u064a\\u0644 \\u0648\\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0646\\u0632\\u0644\\u064a\\u0629.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(151,73,21,'التشاور والتوجيه الشخصي','[\"\\u064a\\u0642\\u062f\\u0645 \\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u0648\\u0646 \\u0630\\u0648\\u0648 \\u0627\\u0644\\u0645\\u0639\\u0631\\u0641\\u0629 \\u0648\\u0627\\u0644\\u0648\\u062f \\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0627\\u0644\\u0634\\u062e\\u0635\\u064a\\u0629 \\u0637\\u0648\\u0627\\u0644 \\u0639\\u0645\\u0644\\u064a\\u0629 \\u0627\\u0644\\u0627\\u062e\\u062a\\u064a\\u0627\\u0631.\",\"\\u0641\\u0647\\u0645 \\u0627\\u0644\\u0627\\u062d\\u062a\\u064a\\u0627\\u062c\\u0627\\u062a \\u0648\\u0627\\u0644\\u062a\\u0641\\u0636\\u064a\\u0644\\u0627\\u062a \\u0627\\u0644\\u0645\\u062d\\u062f\\u062f\\u0629 \\u0648\\u0642\\u064a\\u0648\\u062f \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u0646\\u064a\\u0629 \\u0644\\u0644\\u062a\\u0648\\u0635\\u064a\\u0629 \\u0628\\u0627\\u0644\\u0645\\u0646\\u062a\\u062c\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0627\\u0633\\u0628\\u0629.\",\"\\u0646\\u0635\\u064a\\u062d\\u0629 \\u0627\\u0644\\u062e\\u0628\\u0631\\u0627\\u0621 \\u0628\\u0634\\u0623\\u0646 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u0648\\u0627\\u0644\\u0648\\u0638\\u0627\\u0626\\u0641 \\u0648\\u0627\\u0644\\u0645\\u0644\\u062d\\u0642\\u0627\\u062a \\u0644\\u062a\\u062d\\u0633\\u064a\\u0646 \\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0645\\u0631\\u064a\\u0636 \\u0648\\u0631\\u0639\\u0627\\u064a\\u062a\\u0647.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(152,74,21,'الملحقات والمعدات التكميلية','[\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0648\\u0627\\u0633\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u0644\\u062d\\u0642\\u0627\\u062a \\u0628\\u0645\\u0627 \\u0641\\u064a \\u0630\\u0644\\u0643 \\u0627\\u0644\\u0637\\u0627\\u0648\\u0644\\u0627\\u062a \\u0627\\u0644\\u062c\\u0627\\u0646\\u0628\\u064a\\u0629 \\u0644\\u0644\\u0633\\u0631\\u064a\\u0631\\u060c \\u0648\\u0627\\u0644\\u0635\\u0648\\u0627\\u0646\\u064a \\u0627\\u0644\\u0645\\u0648\\u062c\\u0648\\u062f\\u0629 \\u0641\\u0648\\u0642 \\u0627\\u0644\\u0633\\u0631\\u064a\\u0631\\u060c \\u0648\\u0642\\u0636\\u0628\\u0627\\u0646 \\u0627\\u0644\\u0633\\u0631\\u064a\\u0631\\u060c \\u0648\\u0623\\u0646\\u0638\\u0645\\u0629 \\u0631\\u0641\\u0639 \\u0627\\u0644\\u0645\\u0631\\u0636\\u0649.\",\"\\u0645\\u0631\\u0627\\u062a\\u0628 \\u0645\\u062a\\u062e\\u0635\\u0635\\u0629 \\u0648\\u0623\\u0646\\u0638\\u0645\\u0629 \\u062a\\u062e\\u0641\\u064a\\u0641 \\u0627\\u0644\\u0636\\u063a\\u0637 \\u0644\\u0645\\u0646\\u0639 \\u062a\\u0642\\u0631\\u062d\\u0627\\u062a \\u0627\\u0644\\u0641\\u0631\\u0627\\u0634 \\u0648\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0631\\u0627\\u062d\\u0629 \\u0627\\u0644\\u0645\\u0631\\u064a\\u0636.\",\"\\u0627\\u0644\\u0645\\u0639\\u062f\\u0627\\u062a \\u0627\\u0644\\u062a\\u0643\\u0645\\u064a\\u0644\\u064a\\u0629 \\u0645\\u062b\\u0644 \\u0627\\u0644\\u0623\\u0639\\u0645\\u062f\\u0629 \\u0627\\u0644\\u0648\\u0631\\u064a\\u062f\\u064a\\u0629\\u060c \\u0648\\u0627\\u0644\\u0643\\u0648\\u0645\\u0648\\u062f\\u0627\\u062a \\u0628\\u062c\\u0627\\u0646\\u0628 \\u0627\\u0644\\u0633\\u0631\\u064a\\u0631\\u060c \\u0648\\u0623\\u062c\\u0647\\u0632\\u0629 \\u0645\\u0631\\u0627\\u0642\\u0628\\u0629 \\u0627\\u0644\\u0645\\u0631\\u064a\\u0636 \\u0645\\u062a\\u0627\\u062d\\u0629 \\u0644\\u062e\\u0644\\u0642 \\u0628\\u064a\\u0626\\u0629 \\u0631\\u0639\\u0627\\u064a\\u0629 \\u0643\\u0627\\u0645\\u0644\\u0629.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(153,75,21,'خدمات التثبيت والدعم الفني','[\"\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u0631\\u0643\\u064a\\u0628 \\u0627\\u0644\\u0627\\u062d\\u062a\\u0631\\u0627\\u0641\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0642\\u062f\\u0645\\u0629 \\u0645\\u0646 \\u0642\\u0628\\u0644 \\u0641\\u0646\\u064a\\u064a\\u0646 \\u0645\\u0627\\u0647\\u0631\\u064a\\u0646 \\u0644\\u0636\\u0645\\u0627\\u0646 \\u0627\\u0644\\u0625\\u0639\\u062f\\u0627\\u062f \\u0648\\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0627\\u0644\\u0645\\u0646\\u0627\\u0633\\u0628\\u064a\\u0646.\",\"\\u0627\\u0644\\u062a\\u062f\\u0631\\u064a\\u0628 \\u0627\\u0644\\u0634\\u0627\\u0645\\u0644 \\u0648\\u0627\\u0644\\u062a\\u0648\\u062c\\u064a\\u0647 \\u0644\\u0645\\u0642\\u062f\\u0645\\u064a \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0628\\u0634\\u0623\\u0646 \\u062a\\u0634\\u063a\\u064a\\u0644 \\u0648\\u0635\\u064a\\u0627\\u0646\\u0629 \\u0623\\u0633\\u0631\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a.\",\"\\u0627\\u0644\\u062f\\u0639\\u0645 \\u0627\\u0644\\u0641\\u0646\\u064a \\u0627\\u0644\\u0641\\u0648\\u0631\\u064a \\u0648\\u0627\\u0644\\u0645\\u0633\\u0627\\u0639\\u062f\\u0629 \\u0641\\u064a \\u0627\\u0633\\u062a\\u0643\\u0634\\u0627\\u0641 \\u0627\\u0644\\u0623\\u062e\\u0637\\u0627\\u0621 \\u0648\\u0625\\u0635\\u0644\\u0627\\u062d\\u0647\\u0627 \\u0644\\u0645\\u0639\\u0627\\u0644\\u062c\\u0629 \\u0623\\u064a \\u0645\\u0634\\u0627\\u0643\\u0644 \\u0623\\u0648 \\u0645\\u062e\\u0627\\u0648\\u0641.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(154,76,21,'صيانة ما بعد البيع وتغطية الضمان','[\"\\u064a\\u062a\\u0645 \\u062a\\u0642\\u062f\\u064a\\u0645 \\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u0635\\u064a\\u0627\\u0646\\u0629 \\u0648\\u0627\\u0644\\u0641\\u062d\\u0635 \\u0627\\u0644\\u062f\\u0648\\u0631\\u064a\\u0629 \\u0644\\u0625\\u0637\\u0627\\u0644\\u0629 \\u0639\\u0645\\u0631 \\u0623\\u0633\\u0631\\u0629 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a \\u0648\\u0636\\u0645\\u0627\\u0646 \\u0627\\u0644\\u0623\\u062f\\u0627\\u0621 \\u0627\\u0644\\u0623\\u0645\\u062b\\u0644.\",\"\\u062a\\u063a\\u0637\\u064a\\u0629 \\u0627\\u0644\\u0636\\u0645\\u0627\\u0646 \\u0645\\u062a\\u0648\\u0641\\u0631\\u0629 \\u0644\\u062c\\u0645\\u064a\\u0639 \\u0627\\u0644\\u0645\\u0646\\u062a\\u062c\\u0627\\u062a\\u060c \\u0645\\u0639 \\u062d\\u0644 \\u0633\\u0631\\u064a\\u0639 \\u0644\\u0623\\u064a\\u0629 \\u0639\\u064a\\u0648\\u0628 \\u0623\\u0648 \\u0623\\u0639\\u0637\\u0627\\u0644.\",\"\\u0639\\u0645\\u0644\\u064a\\u0629 \\u0625\\u0635\\u0644\\u0627\\u062d \\u0648\\u0627\\u0633\\u062a\\u0628\\u062f\\u0627\\u0644 \\u062e\\u0627\\u0644\\u064a\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0645\\u062a\\u0627\\u0639\\u0628 \\u064a\\u062a\\u0645 \\u062a\\u0633\\u0647\\u064a\\u0644\\u0647\\u0627 \\u0628\\u0648\\u0627\\u0633\\u0637\\u0629 \\u0641\\u0631\\u064a\\u0642 \\u062f\\u0639\\u0645 \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0627\\u0644\\u0645\\u062e\\u0635\\u0635.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(155,77,21,'المشاركة المجتمعية والتعاون الصناعي','[\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0627\\u0644\\u0641\\u0639\\u0627\\u0644\\u0629 \\u0641\\u064a \\u0645\\u062c\\u062a\\u0645\\u0639 \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0635\\u062d\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a \\u0645\\u0646 \\u062e\\u0644\\u0627\\u0644 \\u0627\\u0644\\u0634\\u0631\\u0627\\u0643\\u0627\\u062a \\u0645\\u0639 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0634\\u0641\\u064a\\u0627\\u062a \\u0648\\u0627\\u0644\\u0639\\u064a\\u0627\\u062f\\u0627\\u062a \\u0648\\u0645\\u0631\\u0627\\u0641\\u0642 \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629.\",\"\\u0627\\u0644\\u062a\\u0639\\u0627\\u0648\\u0646 \\u0645\\u0639 \\u0627\\u0644\\u0645\\u062a\\u062e\\u0635\\u0635\\u064a\\u0646 \\u0641\\u064a \\u0627\\u0644\\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0635\\u062d\\u064a\\u0629 \\u0644\\u0645\\u0648\\u0627\\u0643\\u0628\\u0629 \\u0627\\u062a\\u062c\\u0627\\u0647\\u0627\\u062a \\u0627\\u0644\\u0635\\u0646\\u0627\\u0639\\u0629 \\u0648\\u0627\\u0644\\u062a\\u0642\\u062f\\u0645 \\u0627\\u0644\\u062a\\u0643\\u0646\\u0648\\u0644\\u0648\\u062c\\u064a.\",\"\\u0627\\u0644\\u0645\\u0634\\u0627\\u0631\\u0643\\u0629 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0639\\u0627\\u0631\\u0636 \\u0627\\u0644\\u0635\\u062d\\u064a\\u0629 \\u0648\\u0627\\u0644\\u0646\\u062f\\u0648\\u0627\\u062a \\u0648\\u0627\\u0644\\u0641\\u0639\\u0627\\u0644\\u064a\\u0627\\u062a \\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0627\\u0644\\u0648\\u0639\\u064a \\u0648\\u0623\\u0641\\u0636\\u0644 \\u0627\\u0644\\u0645\\u0645\\u0627\\u0631\\u0633\\u0627\\u062a \\u0641\\u064a \\u0631\\u0639\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0636\\u0649.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(156,78,21,'الالتزام برضا العملاء وردود الفعل','[\"\\u0627\\u0644\\u0627\\u0644\\u062a\\u0632\\u0627\\u0645 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0645\\u0631 \\u0628\\u062a\\u062c\\u0627\\u0648\\u0632 \\u062a\\u0648\\u0642\\u0639\\u0627\\u062a \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0645\\u0646 \\u062e\\u0644\\u0627\\u0644 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0629 \\u0648\\u0627\\u0644\\u062f\\u0639\\u0645 \\u0627\\u0644\\u0627\\u0633\\u062a\\u062b\\u0646\\u0627\\u0626\\u064a\\u064a\\u0646.\",\"\\u0627\\u0644\\u062a\\u0645\\u0627\\u0633 \\u0645\\u0646\\u062a\\u0638\\u0645 \\u0644\\u0644\\u062a\\u0639\\u0644\\u064a\\u0642\\u0627\\u062a \\u0648\\u0627\\u0644\\u0634\\u0647\\u0627\\u062f\\u0627\\u062a \\u0644\\u0642\\u064a\\u0627\\u0633 \\u0631\\u0636\\u0627 \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0648\\u062a\\u062d\\u062f\\u064a\\u062f \\u0645\\u062c\\u0627\\u0644\\u0627\\u062a \\u0627\\u0644\\u062a\\u062d\\u0633\\u064a\\u0646.\",\"\\u062a\\u0646\\u0641\\u064a\\u0630 \\u0627\\u0642\\u062a\\u0631\\u0627\\u062d\\u0627\\u062a \\u0627\\u0644\\u0639\\u0645\\u0644\\u0627\\u0621 \\u0648\\u062a\\u0648\\u0635\\u064a\\u0627\\u062a\\u0647\\u0645 \\u0644\\u062a\\u0639\\u0632\\u064a\\u0632 \\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0645\\u0646\\u062a\\u062c\\u0627\\u062a \\u0648\\u062a\\u0642\\u062f\\u064a\\u0645 \\u0627\\u0644\\u062e\\u062f\\u0645\\u0627\\u062a.\"]','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(157,79,20,'Authentic Western Atmosphere','[\"Weathered d\\u00e9cor\",\"Swinging saloon doors\",\"Mounted animal heads\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(158,80,20,'Extensive Spirits Selection','[\"Local and imported\",\"Varied whiskey collection\",\"Expert bartenders\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(159,81,20,'Live Music Entertainment','[\"Talented local musicians\",\"Soulful ballads\",\"Foot-stomping anthems\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(160,82,20,'Community Hub','[\"Welcoming atmosphere\",\"Regulars\' camaraderie\",\"Newcomer-friendly\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(161,83,20,'Rustic Dining Experience','[\"Hearty meals\",\"Locally sourced ingredients\",\"Western-themed dishes\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(162,84,20,'Games and Activities','[\"Card games\",\"Darts\",\"Billiards\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(163,85,20,'Outdoor Seating','[\"Desert views\",\"Starlit evenings\",\"Cozy campfire area\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(164,79,21,'الجو الغربي الأصيل','[\"\\u062f\\u064a\\u0643\\u0648\\u0631 \\u0645\\u062a\\u0623\\u062b\\u0631 \\u0628\\u0627\\u0644\\u0637\\u0642\\u0633\",\"\\u0623\\u0628\\u0648\\u0627\\u0628 \\u0627\\u0644\\u0635\\u0627\\u0644\\u0648\\u0646 \\u0627\\u0644\\u0645\\u062a\\u0623\\u0631\\u062c\\u062d\\u0629\",\"\\u0631\\u0624\\u0648\\u0633 \\u062d\\u064a\\u0648\\u0627\\u0646\\u0627\\u062a \\u0645\\u062b\\u0628\\u062a\\u0629\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(165,80,21,'اختيار المشروبات الروحية واسعة النطاق','[\"\\u0645\\u062d\\u0644\\u064a \\u0648\\u0645\\u0633\\u062a\\u0648\\u0631\\u062f\",\"\\u0645\\u062c\\u0645\\u0648\\u0639\\u0629 \\u0645\\u062a\\u0646\\u0648\\u0639\\u0629 \\u0645\\u0646 \\u0627\\u0644\\u0648\\u064a\\u0633\\u0643\\u064a\",\"\\u0627\\u0644\\u0633\\u0642\\u0627\\u0629 \\u0627\\u0644\\u062e\\u0628\\u0631\\u0627\\u0621\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(166,81,21,'الترفيه الموسيقي الحي','[\"\\u0627\\u0644\\u0645\\u0648\\u0633\\u064a\\u0642\\u064a\\u064a\\u0646 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u064a\\u0646 \\u0627\\u0644\\u0645\\u0648\\u0647\\u0648\\u0628\\u064a\\u0646\",\"\\u0627\\u0644\\u0623\\u063a\\u0627\\u0646\\u064a \\u0627\\u0644\\u0631\\u0648\\u062d\\u064a\\u0629\",\"\\u0623\\u0646\\u0627\\u0634\\u064a\\u062f \\u0627\\u0644\\u062f\\u0648\\u0633 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0623\\u0642\\u062f\\u0627\\u0645\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(167,82,21,'مركز المجتمع','[\"\\u062c\\u0648 \\u062a\\u0631\\u062d\\u0627\\u0628\",\"\\u0627\\u0644\\u0635\\u062f\\u0627\\u0642\\u0629 \\u0627\\u0644\\u062d\\u0645\\u064a\\u0645\\u0629 \\u0627\\u0644\\u0646\\u0638\\u0627\\u0645\\u064a\\u064a\\u0646\",\"\\u0635\\u062f\\u064a\\u0642\\u0629 \\u0644\\u0644\\u0648\\u0627\\u0641\\u062f\\u064a\\u0646 \\u0627\\u0644\\u062c\\u062f\\u062f\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(168,83,21,'تجربة تناول الطعام الريفية','[\"\\u0648\\u062c\\u0628\\u0627\\u062a \\u062f\\u0633\\u0645\\u0629\",\"\\u0627\\u0644\\u0645\\u0643\\u0648\\u0646\\u0627\\u062a \\u0645\\u0646 \\u0645\\u0635\\u0627\\u062f\\u0631 \\u0645\\u062d\\u0644\\u064a\\u0629\",\"\\u0623\\u0637\\u0628\\u0627\\u0642 \\u0630\\u0627\\u062a \\u0637\\u0627\\u0628\\u0639 \\u063a\\u0631\\u0628\\u064a\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(169,84,21,'الألعاب والأنشطة','[\"\\u0644\\u0639\\u0628 \\u0627\\u0644\\u0648\\u0631\\u0642\",\"\\u0627\\u0644\\u0633\\u0647\\u0627\\u0645\",\"\\u0627\\u0644\\u0628\\u0644\\u064a\\u0627\\u0631\\u062f\\u0648\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(170,85,21,'جلوس في الهواء الطلق','[\"\\u0645\\u0646\\u0627\\u0638\\u0631 \\u0635\\u062d\\u0631\\u0627\\u0648\\u064a\\u0629\",\"\\u0623\\u0645\\u0633\\u064a\\u0627\\u062a \\u0645\\u0636\\u0627\\u0621\\u0629 \\u0628\\u0627\\u0644\\u0646\\u062c\\u0648\\u0645\",\"\\u0645\\u0646\\u0637\\u0642\\u0629 \\u0646\\u0627\\u0631 \\u0627\\u0644\\u0645\\u0639\\u0633\\u0643\\u0631 \\u0627\\u0644\\u0645\\u0631\\u064a\\u062d\\u0629\"]','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(171,86,20,'Live Music Nights','[\"Weekly performances\",\"Diverse musical genres\",\"Talented local artists\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(172,87,20,'Vintage Decor','[\"Old-world charm\",\"Authentic memorabilia.\",\"Rustic ambiance\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(173,88,20,'Craft Cocktail Bar','[\"Skilled bartenders\",\"Unique concoctions\",\"Local flavor inspiration\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(174,89,20,'Hearty Comfort Food','[\"Delicious BBQ ribs.\",\"Juicy burgers\",\"Crispy fried chicken\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(175,90,20,'Friendly Atmosphere','[\"Welcoming staff\",\"Lively conversations\",\"Community vibe\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(176,91,20,'Outdoor Seating','[\"Scenic patio area\",\"Relaxing atmosphere\",\"Ideal for warm evenings\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(178,86,21,'ليالي الموسيقى الحية','[\"\\u0627\\u0644\\u0639\\u0631\\u0648\\u0636 \\u0627\\u0644\\u0623\\u0633\\u0628\\u0648\\u0639\\u064a\\u0629\",\"\\u0627\\u0644\\u0623\\u0646\\u0648\\u0627\\u0639 \\u0627\\u0644\\u0645\\u0648\\u0633\\u064a\\u0642\\u064a\\u0629 \\u0627\\u0644\\u0645\\u062a\\u0646\\u0648\\u0639\\u0629\",\"\\u0627\\u0644\\u0641\\u0646\\u0627\\u0646\\u064a\\u0646 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u064a\\u0646 \\u0627\\u0644\\u0645\\u0648\\u0647\\u0648\\u0628\\u064a\\u0646\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(179,87,21,'ديكور عتيق','[\"\\u0633\\u062d\\u0631 \\u0627\\u0644\\u0639\\u0627\\u0644\\u0645 \\u0627\\u0644\\u0642\\u062f\\u064a\\u0645\",\"\\u062a\\u0630\\u0643\\u0627\\u0631\\u0627\\u062a \\u0623\\u0635\\u064a\\u0644\\u0629.\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0631\\u064a\\u0641\\u064a\\u0629\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(180,88,21,'بار كوكتيل كرافت','[\"\\u0627\\u0644\\u0633\\u0642\\u0627\\u0629 \\u0627\\u0644\\u0645\\u0647\\u0631\\u0629\",\"\\u0627\\u062e\\u062a\\u0631\\u0627\\u0639\\u0627\\u062a \\u0641\\u0631\\u064a\\u062f\\u0629 \\u0645\\u0646 \\u0646\\u0648\\u0639\\u0647\\u0627\",\"\\u0625\\u0644\\u0647\\u0627\\u0645 \\u0627\\u0644\\u0646\\u0643\\u0647\\u0629 \\u0627\\u0644\\u0645\\u062d\\u0644\\u064a\\u0629\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(181,89,21,'طعام مريح شهي','[\"\\u0623\\u0636\\u0644\\u0627\\u0639 \\u0634\\u0648\\u0627\\u0621 \\u0644\\u0630\\u064a\\u0630\\u0629.\",\"\\u0627\\u0644\\u0628\\u0631\\u063a\\u0631 \\u0627\\u0644\\u0639\\u0635\\u064a\\u0631\",\"\\u062f\\u062c\\u0627\\u062c \\u0645\\u0642\\u0644\\u064a \\u0645\\u0642\\u0631\\u0645\\u0634\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(182,90,21,'أجواء ودية','[\"\\u0627\\u0644\\u062a\\u0631\\u062d\\u064a\\u0628 \\u0628\\u0627\\u0644\\u0645\\u0648\\u0638\\u0641\\u064a\\u0646\",\"\\u0645\\u062d\\u0627\\u062f\\u062b\\u0627\\u062a \\u062d\\u064a\\u0629\",\"\\u0623\\u062c\\u0648\\u0627\\u0621 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(183,91,21,'جلوس في الهواء الطلق','[\"\\u0645\\u0646\\u0637\\u0642\\u0629 \\u0627\\u0644\\u0641\\u0646\\u0627\\u0621 \\u0630\\u0627\\u062a \\u0627\\u0644\\u0645\\u0646\\u0627\\u0638\\u0631 \\u0627\\u0644\\u062e\\u0644\\u0627\\u0628\\u0629\",\"\\u062c\\u0648 \\u0645\\u0646 \\u0627\\u0644\\u0627\\u0633\\u062a\\u0631\\u062e\\u0627\\u0621\",\"\\u0645\\u062b\\u0627\\u0644\\u064a\\u0629 \\u0644\\u0644\\u0623\\u0645\\u0633\\u064a\\u0627\\u062a \\u0627\\u0644\\u062f\\u0627\\u0641\\u0626\\u0629\"]','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(205,103,20,'Advanced Medical Facilities','[\"Cutting-edge Diagnostic Equipment\",\"Modern Operating Theatres\",\"Intensive Care Units (ICUs)\",\"Telemedicine Services\"]','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(206,104,20,'Comprehensive Specialties','[\"Multidisciplinary Approach\",\"Subspecialty Clinics\",\"Rehabilitation Services\"]','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(207,105,20,'Patient-Centered Care','[\"Holistic Approach\",\"Patient Advocacy\",\"Language and Cultural Sensitivity\"]','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(208,106,20,'Community Engagement','[\"Health Education Programs\",\"Community Health Screenings\",\"Collaborative Partnerships\"]','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(209,107,20,'Quality and Safety','[\"Accreditation and Certifications\",\"Continuous Quality Improvemen\",\"Infection Control Measures\"]','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(210,103,21,'المرافق الطبية المتقدمة','[\"\\u0645\\u0639\\u062f\\u0627\\u062a \\u0627\\u0644\\u062a\\u0634\\u062e\\u064a\\u0635 \\u0627\\u0644\\u0645\\u062a\\u0637\\u0648\\u0631\\u0629\",\"\\u063a\\u0631\\u0641 \\u0627\\u0644\\u0639\\u0645\\u0644\\u064a\\u0627\\u062a \\u0627\\u0644\\u062d\\u062f\\u064a\\u062b\\u0629\",\"\\u0648\\u062d\\u062f\\u0627\\u062a \\u0627\\u0644\\u0639\\u0646\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0645\\u0631\\u0643\\u0632\\u0629 (ICUs)\",\"\\u062e\\u062f\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u0637\\u0628\\u064a\\u0628 \\u0639\\u0646 \\u0628\\u0639\\u062f\"]','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(211,104,21,'التخصصات الشاملة','[\"\\u0646\\u0647\\u062c \\u0645\\u062a\\u0639\\u062f\\u062f \\u0627\\u0644\\u062a\\u062e\\u0635\\u0635\\u0627\\u062a\",\"\\u0639\\u064a\\u0627\\u062f\\u0627\\u062a \\u0627\\u0644\\u062a\\u062e\\u0635\\u0635 \\u0627\\u0644\\u062f\\u0642\\u064a\\u0642\",\"\\u062e\\u062f\\u0645\\u0627\\u062a \\u0625\\u0639\\u0627\\u062f\\u0629 \\u0627\\u0644\\u062a\\u0623\\u0647\\u064a\\u0644\"]','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(212,105,21,'الرعاية التي تركز على المريض','[\"\\u0646\\u0647\\u062c \\u0634\\u0645\\u0648\\u0644\\u064a\",\"\\u0627\\u0644\\u062f\\u0641\\u0627\\u0639 \\u0639\\u0646 \\u0627\\u0644\\u0645\\u0631\\u0636\\u0649\",\"\\u0627\\u0644\\u0644\\u063a\\u0629 \\u0648\\u0627\\u0644\\u062d\\u0633\\u0627\\u0633\\u064a\\u0629 \\u0627\\u0644\\u062b\\u0642\\u0627\\u0641\\u064a\\u0629\"]','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(213,106,21,'المشاركة المجتمعية','[\"\\u0628\\u0631\\u0627\\u0645\\u062c \\u0627\\u0644\\u062a\\u062b\\u0642\\u064a\\u0641 \\u0627\\u0644\\u0635\\u062d\\u064a\",\"\\u0641\\u062d\\u0648\\u0635\\u0627\\u062a \\u0635\\u062d\\u0629 \\u0627\\u0644\\u0645\\u062c\\u062a\\u0645\\u0639\",\"\\u0627\\u0644\\u0634\\u0631\\u0627\\u0643\\u0627\\u062a \\u0627\\u0644\\u062a\\u0639\\u0627\\u0648\\u0646\\u064a\\u0629\"]','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(214,107,21,'الجودة والسلامة','[\"\\u0627\\u0644\\u0627\\u0639\\u062a\\u0645\\u0627\\u062f \\u0648\\u0627\\u0644\\u0634\\u0647\\u0627\\u062f\\u0627\\u062a\",\"\\u0627\\u0644\\u062a\\u062d\\u0633\\u064a\\u0646 \\u0627\\u0644\\u0645\\u0633\\u062a\\u0645\\u0631 \\u0644\\u0644\\u062c\\u0648\\u062f\\u0629\",\"\\u062a\\u062f\\u0627\\u0628\\u064a\\u0631 \\u0645\\u0643\\u0627\\u0641\\u062d\\u0629 \\u0627\\u0644\\u0639\\u062f\\u0648\\u0649\"]','2024-05-08 02:54:02','2024-05-08 02:54:02');
/*!40000 ALTER TABLE `listing_feature_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_features`
--

DROP TABLE IF EXISTS `listing_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_features` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `indx` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_features`
--

LOCK TABLES `listing_features` WRITE;
/*!40000 ALTER TABLE `listing_features` DISABLE KEYS */;
INSERT INTO `listing_features` VALUES
(4,1,'0','2024-05-01 21:55:30','2024-05-01 21:55:30'),
(5,1,'1','2024-05-01 21:55:30','2024-05-01 21:55:30'),
(6,1,'2','2024-05-01 21:55:30','2024-05-01 21:55:30'),
(12,3,'0','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(13,3,'1','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(14,3,'2','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(15,3,'3','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(16,3,'4','2024-05-01 23:34:31','2024-05-01 23:34:31'),
(17,4,'0','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(18,4,'1','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(19,4,'2','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(20,4,'3','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(21,4,'4','2024-05-02 02:43:26','2024-05-02 02:43:26'),
(22,5,'0','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(23,5,'1','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(24,5,'2','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(25,5,'3','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(26,5,'4','2024-05-05 21:08:51','2024-05-05 21:08:51'),
(27,6,'0','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(28,6,'1','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(29,6,'2','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(30,6,'3','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(31,6,'4','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(32,6,'5','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(33,6,'6','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(34,6,'7','2024-05-05 22:08:08','2024-05-05 22:08:08'),
(35,7,'0','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(36,7,'1','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(37,7,'2','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(38,7,'3','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(39,7,'4','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(40,7,'5','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(41,7,'6','2024-05-05 23:24:11','2024-05-05 23:24:11'),
(49,9,'0','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(50,9,'1','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(51,9,'2','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(52,9,'3','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(53,9,'4','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(54,9,'5','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(55,9,'6','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(56,9,'7','2024-05-06 20:58:16','2024-05-06 20:58:16'),
(57,10,'0','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(58,10,'1','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(59,10,'2','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(60,10,'3','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(61,10,'4','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(62,10,'5','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(63,10,'6','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(64,10,'7','2024-05-06 21:33:13','2024-05-06 21:33:13'),
(65,11,'0','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(66,11,'1','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(67,11,'2','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(68,11,'3','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(69,11,'4','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(70,11,'5','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(71,11,'6','2024-05-06 22:42:58','2024-05-06 22:42:58'),
(72,12,'0','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(73,12,'1','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(74,12,'2','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(75,12,'3','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(76,12,'4','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(77,12,'5','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(78,12,'6','2024-05-07 00:20:16','2024-05-07 00:20:16'),
(79,13,'0','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(80,13,'1','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(81,13,'2','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(82,13,'3','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(83,13,'4','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(84,13,'5','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(85,13,'6','2024-05-07 02:56:02','2024-05-07 02:56:02'),
(86,14,'0','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(87,14,'1','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(88,14,'2','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(89,14,'3','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(90,14,'4','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(91,14,'5','2024-05-07 21:01:02','2024-05-07 21:01:02'),
(103,15,'0','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(104,15,'1','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(105,15,'2','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(106,15,'3','2024-05-08 02:54:02','2024-05-08 02:54:02'),
(107,15,'4','2024-05-08 02:54:02','2024-05-08 02:54:02');
/*!40000 ALTER TABLE `listing_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_images`
--

DROP TABLE IF EXISTS `listing_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_images`
--

LOCK TABLES `listing_images` WRITE;
/*!40000 ALTER TABLE `listing_images` DISABLE KEYS */;
INSERT INTO `listing_images` VALUES
(1,1,'663303c0686b9.jpg','2024-05-01 21:08:48','2024-05-01 21:11:39'),
(2,1,'663303c0686ae.jpg','2024-05-01 21:08:48','2024-05-01 21:11:39'),
(3,1,'663303c0917ac.jpg','2024-05-01 21:08:48','2024-05-01 21:11:39'),
(4,1,'663303c091d22.jpg','2024-05-01 21:08:48','2024-05-01 21:11:39'),
(5,1,'663303c0b55d8.jpg','2024-05-01 21:08:48','2024-05-01 21:11:39'),
(11,3,'663321672525b.jpg','2024-05-01 23:15:19','2024-05-01 23:18:29'),
(12,3,'6633216725271.jpg','2024-05-01 23:15:19','2024-05-01 23:18:29'),
(13,3,'663321674e34b.jpg','2024-05-01 23:15:19','2024-05-01 23:18:29'),
(14,3,'6633216752563.jpg','2024-05-01 23:15:19','2024-05-01 23:18:29'),
(15,3,'663321677a161.jpg','2024-05-01 23:15:19','2024-05-01 23:18:29'),
(16,4,'66334eaa734e5.jpg','2024-05-02 02:28:26','2024-05-02 02:33:34'),
(17,4,'66334eaa742f6.jpg','2024-05-02 02:28:26','2024-05-02 02:33:34'),
(18,4,'66334eaaab007.jpg','2024-05-02 02:28:26','2024-05-02 02:33:34'),
(19,4,'66334eaaac55e.jpg','2024-05-02 02:28:26','2024-05-02 02:33:34'),
(20,4,'66334eaae51cc.jpg','2024-05-02 02:28:26','2024-05-02 02:33:34'),
(21,5,'6638469558198.jpg','2024-05-05 20:55:17','2024-05-05 20:59:19'),
(22,5,'6638469560ab7.jpg','2024-05-05 20:55:17','2024-05-05 20:59:19'),
(23,5,'663846958a097.jpg','2024-05-05 20:55:17','2024-05-05 20:59:19'),
(24,5,'6638469591b96.jpg','2024-05-05 20:55:17','2024-05-05 20:59:19'),
(25,5,'66384695aff7f.jpg','2024-05-05 20:55:17','2024-05-05 20:59:19'),
(26,6,'66385162bfca7.jpg','2024-05-05 21:41:22','2024-05-05 21:47:53'),
(27,6,'66385162c3bd2.jpg','2024-05-05 21:41:22','2024-05-05 21:47:53'),
(28,6,'66385162f33cf.jpg','2024-05-05 21:41:22','2024-05-05 21:47:53'),
(29,6,'663851630692f.jpg','2024-05-05 21:41:23','2024-05-05 21:47:53'),
(30,6,'66385163280df.jpg','2024-05-05 21:41:23','2024-05-05 21:47:53'),
(31,7,'663863db61c60.jpg','2024-05-05 23:00:11','2024-05-05 23:06:52'),
(32,7,'663863db6bcbc.jpg','2024-05-05 23:00:11','2024-05-05 23:06:52'),
(33,7,'663863db88804.jpg','2024-05-05 23:00:11','2024-05-05 23:06:52'),
(34,7,'663863db951e9.jpg','2024-05-05 23:00:11','2024-05-05 23:06:52'),
(35,7,'663863dbb515b.jpg','2024-05-05 23:00:11','2024-05-05 23:06:52'),
(41,9,'66399335a42a0.jpg','2024-05-06 20:34:29','2024-05-06 20:37:35'),
(42,9,'66399335a42a0.jpg','2024-05-06 20:34:29','2024-05-06 20:37:35'),
(43,9,'66399335cef34.jpg','2024-05-06 20:34:29','2024-05-06 20:37:35'),
(44,9,'66399335daa26.jpg','2024-05-06 20:34:29','2024-05-06 20:37:35'),
(45,9,'6639933605387.jpg','2024-05-06 20:34:30','2024-05-06 20:37:35'),
(46,10,'66399d5bbe8cf.jpg','2024-05-06 21:17:47','2024-05-06 21:22:20'),
(47,10,'66399d5bc409d.jpg','2024-05-06 21:17:47','2024-05-06 21:22:20'),
(48,10,'66399d5bed80e.jpg','2024-05-06 21:17:47','2024-05-06 21:22:20'),
(49,10,'66399d5bf07ce.jpg','2024-05-06 21:17:47','2024-05-06 21:22:20'),
(50,10,'66399d5c23332.jpg','2024-05-06 21:17:48','2024-05-06 21:22:20'),
(51,11,'6639adcd305bb.jpg','2024-05-06 22:27:57','2024-05-06 22:34:31'),
(52,11,'6639adcd3bb02.jpg','2024-05-06 22:27:57','2024-05-06 22:34:31'),
(53,11,'6639adcd5a415.jpg','2024-05-06 22:27:57','2024-05-06 22:34:31'),
(54,11,'6639adcd6e6bf.jpg','2024-05-06 22:27:57','2024-05-06 22:34:31'),
(55,11,'6639adcd818f6.jpg','2024-05-06 22:27:57','2024-05-06 22:34:31'),
(56,12,'6639c38d900ac.jpg','2024-05-07 00:00:45','2024-05-07 00:07:13'),
(57,12,'6639c3929e89d.jpg','2024-05-07 00:00:50','2024-05-07 00:07:13'),
(58,12,'6639c392a0f8e.jpg','2024-05-07 00:00:50','2024-05-07 00:07:13'),
(59,12,'6639c392ccbd2.jpg','2024-05-07 00:00:50','2024-05-07 00:07:13'),
(60,12,'6639c392ce66c.jpg','2024-05-07 00:00:50','2024-05-07 00:07:13'),
(65,NULL,'6639e7c4d3d72.jpg','2024-05-07 02:35:16','2024-05-07 02:35:16'),
(66,13,'6639e7db2420a.jpg','2024-05-07 02:35:39','2024-05-07 02:40:46'),
(67,13,'6639e7db29ac4.jpg','2024-05-07 02:35:39','2024-05-07 02:40:46'),
(68,13,'6639e7db51eee.jpg','2024-05-07 02:35:39','2024-05-07 02:40:46'),
(69,13,'6639e7db546b4.jpg','2024-05-07 02:35:39','2024-05-07 02:40:46'),
(70,13,'6639e7db76aa1.jpg','2024-05-07 02:35:39','2024-05-07 02:40:46'),
(76,14,'663af05188f79.jpg','2024-05-07 21:24:01','2024-05-07 21:24:07'),
(77,14,'663af05188fa5.jpg','2024-05-07 21:24:01','2024-05-07 21:24:07'),
(78,14,'663af051b1beb.jpg','2024-05-07 21:24:01','2024-05-07 21:24:07'),
(79,14,'663af051b60b6.jpg','2024-05-07 21:24:01','2024-05-07 21:24:07'),
(80,14,'663af051d6688.jpg','2024-05-07 21:24:01','2024-05-07 21:24:07'),
(86,15,'663b4b6a1da7a.jpg','2024-05-08 03:52:42','2024-05-08 03:52:45'),
(87,NULL,'6784864de9162.jpg','2025-01-12 21:19:41','2025-01-12 21:19:41'),
(88,NULL,'6784866f29a72.jpg','2025-01-12 21:20:15','2025-01-12 21:20:15'),
(89,NULL,'678486710d185.jpg','2025-01-12 21:20:17','2025-01-12 21:20:17'),
(90,NULL,'67848675e24c6.jpg','2025-01-12 21:20:21','2025-01-12 21:20:21'),
(91,NULL,'67848675ed4a0.jpg','2025-01-12 21:20:21','2025-01-12 21:20:21'),
(92,NULL,'6784867618643.jpg','2025-01-12 21:20:22','2025-01-12 21:20:22'),
(93,NULL,'6784867620b56.jpg','2025-01-12 21:20:22','2025-01-12 21:20:22'),
(94,NULL,'678486763d31e.jpg','2025-01-12 21:20:22','2025-01-12 21:20:22'),
(95,NULL,'6784867649464.jpg','2025-01-12 21:20:22','2025-01-12 21:20:22'),
(96,NULL,'6784867a1f57e.jpg','2025-01-12 21:20:26','2025-01-12 21:20:26'),
(97,NULL,'68f0ebfc0f005.jpg','2025-10-16 06:58:36','2025-10-16 06:58:36'),
(98,NULL,'68f0ebfc191e4.jpg','2025-10-16 06:58:36','2025-10-16 06:58:36'),
(101,NULL,'68fc694d38836.jpg','2025-10-25 00:08:13','2025-10-25 00:08:13'),
(102,NULL,'68fc704b085f8.jpg','2025-10-25 00:38:03','2025-10-25 00:38:03'),
(103,NULL,'68fc717677aa4.jpg','2025-10-25 00:43:02','2025-10-25 00:43:02'),
(106,NULL,'69089ac413644.jpg','2025-11-03 06:06:28','2025-11-03 06:06:28'),
(107,NULL,'69089ac41345c.jpg','2025-11-03 06:06:28','2025-11-03 06:06:28'),
(108,17,'69089accd9a65.jpg','2025-11-03 06:06:36','2025-11-03 06:08:23'),
(109,17,'69089acce30dc.jpg','2025-11-03 06:06:36','2025-11-03 06:08:23'),
(110,18,'69089eb21d2dc.jpg','2025-11-03 06:23:14','2025-11-03 06:24:56'),
(111,18,'69089eb21e2ea.jpg','2025-11-03 06:23:14','2025-11-03 06:24:56'),
(112,NULL,'69abe8e20516d.jpg','2026-03-07 02:59:14','2026-03-07 02:59:14');
/*!40000 ALTER TABLE `listing_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_messages`
--

DROP TABLE IF EXISTS `listing_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_messages`
--

LOCK TABLES `listing_messages` WRITE;
/*!40000 ALTER TABLE `listing_messages` DISABLE KEYS */;
INSERT INTO `listing_messages` VALUES
(1,3,204,'Jack','jack234534@gmail.com','35475465345','What inspired you to start Dreamscapes Travel Agency, and what sets it apart from other travel agencies?','2024-05-07 23:33:50','2024-05-07 23:33:50'),
(2,3,204,'Jack jos','jack234534@gmail.com','35463546356','How does Dreamscapes handle unforeseen circumstances or emergencies during travel?','2024-05-07 23:34:48','2024-05-07 23:34:48'),
(3,14,204,'test','daspobin027@gmail.com','34579854354679','Could you share any memorable or unique travel packages or experiences that Dreamscapes has curated for clients?','2024-05-07 23:37:11','2024-05-07 23:37:11'),
(4,1,204,'المثالية مع','fgwergert3450354@gmail.com','23458354635465478','Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?','2024-05-07 23:37:51','2024-05-07 23:37:51'),
(5,14,204,'المثالية مع','a@gmail.com','3546354654','Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?','2024-05-07 23:43:16','2024-05-07 23:43:16'),
(8,11,NULL,'saiful islam sharif','saifislamfci@gmail.co','0187233757','Ki re kemon acos','2025-11-17 23:51:13','2025-11-17 23:51:13'),
(10,14,204,'May Knight','zezexo@mailinator.com','92','Veniam rerum in del','2026-05-13 01:17:28','2026-05-13 01:17:28');
/*!40000 ALTER TABLE `listing_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_product_contents`
--

DROP TABLE IF EXISTS `listing_product_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_product_contents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` int(11) DEFAULT NULL,
  `listing_id` bigint(20) DEFAULT NULL,
  `listing_product_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `meta_keyword` text DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_product_contents`
--

LOCK TABLES `listing_product_contents` WRITE;
/*!40000 ALTER TABLE `listing_product_contents` DISABLE KEYS */;
INSERT INTO `listing_product_contents` VALUES
(1,20,1,1,'Salon Chair','salon-chair','<ul>\r\n<li>Color: Black, Coffee<br />Material: Artificial Leather, Plastic, SS<br />Value Addition: Non-Hydraulic<br />Place of Origin: Bangladesh<br />Height: Adjustable<br />Care Instructions: Wipe with Soft Dry Brush After Use.<br />Features: Durable &amp; Comfortable.</li>\r\n</ul>',NULL,NULL,'2024-05-01 21:16:07','2024-05-01 21:16:07'),
(2,21,1,1,'كرسي صالون','كرسي-صالون','<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">اللون: أسود، قهوة\r\nالمواد: جلد صناعي، بلاستيك، SS\r\nإضافة القيمة: غير هيدروليكي\r\nمكان المنشأ: بنجلاديش\r\nالارتفاع: قابل للتعديل\r\nتعليمات العناية: امسحي بفرشاة جافة ناعمة بعد الاستخدام.\r\nالميزات: متين ومريح.</span></pre>',NULL,NULL,'2024-05-01 21:16:07','2024-05-01 21:16:07'),
(3,20,1,2,'Hair Curler','hair-curler','<p>A hair roller or hair curler is a small tube that is rolled into a person\'s hair in order to curl it, or to straighten curly hair, making a new hairstyle.[1]</p>\r\n<p>The diameter of a roller varies from approximately 0.8 inches (20 mm) to 1.5 inches (38 mm). The hair is heated, and the rollers strain and break the hydrogen bonds[citation needed] of each hair\'s cortex, which causes the hair to curl. The hydrogen bonds reform after the hair is moistened.</p>\r\n<p>A hot roller or hot curler is designed to be heated in an electric chamber before one rolls it into the hair.[2] Alternatively, a hair dryer heats the hair after the rolls are in place. Hair spray can temporarily fix curled hair in place.</p>\r\n<p>In 1930, Solomon Harper created the first electrically heated hair rollers, then creating a better design in 1953.</p>\r\n<p>In 1968 at the feminist Miss America protest, protesters symbolically threw a number of feminine products into a \"Freedom Trash Can\". These included hair rollers,[3] which were among items the protesters called \"instruments of female torture\"[4] and accoutrements of what they perceived to be enforced femininity.</p>',NULL,NULL,'2024-05-01 21:17:29','2024-05-01 21:17:29'),
(4,21,1,2,'مجعد الشعر','مجعد-الشعر','<p>بكرة الشعر أو أداة تجعيد الشعر عبارة عن أنبوب صغير يتم لفه في شعر الشخص من أجل تجعيده، أو تنعيم الشعر المجعد، وعمل تسريحة شعر جديدة.</p>\r\n<p>يتراوح قطر الأسطوانة من حوالي 0.8 بوصة (20 ملم) إلى 1.5 بوصة (38 ملم). يتم تسخين الشعر، وتقوم البكرات بإجهاد وكسر الروابط الهيدروجينية لقشرة كل شعرة، مما يتسبب في تجعد الشعر. يتم إصلاح الروابط الهيدروجينية بعد ترطيب الشعر.</p>\r\n<p>تم تصميم الأسطوانة الساخنة أو أداة تجعيد الشعر الساخنة بحيث يتم تسخينها في غرفة كهربائية قبل لفها في الشعر. بدلًا من ذلك، يقوم مجفف الشعر بتسخين الشعر بعد وضع اللفائف في مكانها. يمكن لرذاذ الشعر تثبيت الشعر المجعد في مكانه بشكل مؤقت.</p>\r\n<p>في عام 1930، ابتكر سولومون هاربر أول بكرات شعر يتم تسخينها كهربائيًا، ثم ابتكر تصميمًا أفضل في عام 1953.</p>\r\n<p>في عام 1968، أثناء احتجاج ملكة جمال أمريكا النسوية، ألقى المتظاهرون بشكل رمزي عددًا من المنتجات النسائية في \"سلة مهملات الحرية\". وشملت هذه بكرات الشعر، والتي كانت من بين العناصر التي أطلق عليها المتظاهرون \"أدوات تعذيب الإناث\" ومستلزمات ما اعتبروه أنوثة قسرية.</p>',NULL,NULL,'2024-05-01 21:17:29','2024-05-01 21:17:29'),
(5,20,1,3,'Shampoo Bowl','shampoo-bowl','<p>Minerva Beauty offers a variety of shampoo bowls and wet stations for salons and barbershops, including standalone shampoo bowls you can pair with your existing shampoo cabinet or wall unit, pedestal shampoo bowls, barber wet stations, and barber sinks paired with a cabinet and mirror. Minerva shampoo bowls come with mounting hardware and all the parts your plumber needs to install them, and we also provide shampoo bowl replacement parts and accessories. Add more storage to your professional shampoo stations with lower and upper cabinets, available in a wide range of colors and finishes including custom options. Don’t forget to pick up a shampoo chair to pair with your hair wash bowl, or browse our shampoo backwash units for ready-made setups. We also have a helpful guide to choosing the best shampoo bowl and chair that covers dimensions, accessibility and more.</p>',NULL,NULL,'2024-05-01 21:19:10','2024-05-01 21:19:10'),
(6,21,1,3,'وعاء الشامبو','وعاء-الشامبو','<p>تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.<br /><br /></p>',NULL,NULL,'2024-05-01 21:19:10','2024-05-01 21:19:10'),
(19,20,11,10,'Pull-Up Bar','pull-up-bar','<p>A pull-up bar is a simple yet versatile piece of exercise equipment designed for upper body workouts. Typically mounted on a doorframe or installed as a standalone unit, it allows users to perform various exercises targeting muscles like the back, arms, and shoulders. By gripping the bar and lifting one\'s body weight, pull-ups and chin-ups engage multiple muscle groups, promoting strength and endurance. Portable options exist for home use, while gym-grade bars offer durability and stability for intensive workouts.</p>',NULL,NULL,'2024-05-06 23:02:32','2024-05-06 23:02:32'),
(20,21,11,10,'اسحب الشريط','اسحب-الشريط','<p>شريط السحب عبارة عن قطعة بسيطة ومتعددة الاستخدامات من معدات التمارين المصممة لتدريبات الجزء العلوي من الجسم. يتم تركيبه عادةً على إطار الباب أو تثبيته كوحدة مستقلة، وهو يسمح للمستخدمين بأداء تمارين مختلفة تستهدف العضلات مثل الظهر والذراعين والكتفين. من خلال الإمساك بالقضيب ورفع وزن الجسم، تعمل عمليات السحب والذقن على إشراك مجموعات عضلية متعددة، مما يعزز القوة والتحمل. توجد خيارات محمولة للاستخدام المنزلي، بينما توفر القضبان المخصصة للصالة الرياضية المتانة والثبات للتمرينات المكثفة.</p>',NULL,NULL,'2024-05-06 23:02:32','2024-05-06 23:02:32'),
(21,20,11,11,'Stationary Bike','stationary-bike','<p>Introducing the Stationary Bike, your ultimate companion in fitness journey and wellness. Designed to bring the exhilaration of cycling into the comfort of your home, this sleek and sturdy exercise bike offers a dynamic workout experience tailored to your needs.</p>\r\n<p>Crafted with premium materials and cutting-edge engineering, our Stationary Bike ensures durability and stability, providing a secure platform for your workouts. Whether you\'re a beginner looking to kickstart your fitness routine or a seasoned athlete aiming to push your limits, this bike is built to accommodate users of all fitness levels.</p>',NULL,NULL,'2024-05-06 23:03:56','2024-05-06 23:03:56'),
(22,21,11,11,'دراجة ثابتة','دراجة-ثابتة','<p>نقدم لكم الدراجة الثابتة، رفيقكم المثالي في رحلة اللياقة البدنية والعافية. صُممت هذه الدراجة الرياضية الأنيقة والمتينة لجلب متعة ركوب الدراجات إلى راحة منزلك، وتوفر تجربة تمرين ديناميكية مصممة خصيصًا لتلبية احتياجاتك.</p>\r\n<p>تضمن دراجتنا الثابتة، المصنوعة من مواد فاخرة وهندسة متطورة، المتانة والثبات، وتوفر منصة آمنة لتدريباتك. سواء كنت مبتدئًا يتطلع إلى بدء روتين اللياقة البدنية الخاص بك أو رياضيًا متمرسًا يهدف إلى تجاوز حدودك، فقد تم تصميم هذه الدراجة لاستيعاب المستخدمين من جميع مستويات اللياقة البدنية.</p>',NULL,NULL,'2024-05-06 23:03:56','2024-05-06 23:03:56'),
(23,20,11,12,'Treadmill','treadmill','<p>Healthfit Foldable Semi Commercial Motorized Treadmill 586DS Price In Bangladesh When it comes to buying a treadmill make sure the treadmill has all the features for your needs. Our Asian Sky Shop offers you a semi-commercial motorized treadmill that has so many features and specifications. It\'s manufactured by Healthfit. This foldable treadmill is easy to carry and user comfortable. We are giving you an affordable price range and lots of facilities.</p>',NULL,NULL,'2024-05-06 23:19:53','2024-05-06 23:19:53'),
(24,21,11,12,'جهاز المشي','جهاز-المشي','<p>جهاز المشي الكهربائي القابل للطي شبه التجاري من السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian Sky Shop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.</p>',NULL,NULL,'2024-05-06 23:19:53','2024-05-06 23:19:53'),
(25,20,11,13,'Kettlebells','kettlebells','<p>A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying supine on the floor to standing, and back again. Get-ups are sometimes modified into get-up presses, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.</p>',NULL,NULL,'2024-05-06 23:21:31','2024-05-06 23:21:31'),
(26,21,11,13,'أجراس كيتل','أجراس-كيتل','<p>تمرين كيتل بيل الذي يجمع بين تمرين الاندفاع والجسر واللوح الجانبي في حركة بطيئة ومنضبطة. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات الاستيقاظ أحيانًا إلى مكابس الاستيقاظ، مع الضغط على كل موضع من موضع الاستيقاظ؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي.</p>',NULL,NULL,'2024-05-06 23:21:31','2024-05-06 23:21:31'),
(27,20,5,14,'product under the listing','product-under-the-listing','<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham</p>',NULL,NULL,'2025-09-20 23:24:42','2025-09-20 23:24:42'),
(28,21,5,14,'product under the listing','product-under-the-listing','<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham</p>',NULL,NULL,'2025-09-20 23:24:42','2025-09-20 23:24:42');
/*!40000 ALTER TABLE `listing_product_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_product_images`
--

DROP TABLE IF EXISTS `listing_product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_product_images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `listing_product_id` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_product_images`
--

LOCK TABLES `listing_product_images` WRITE;
/*!40000 ALTER TABLE `listing_product_images` DISABLE KEYS */;
INSERT INTO `listing_product_images` VALUES
(1,1,1,'66330541d4350.jpg','2024-05-01 21:15:13','2024-05-01 21:16:07'),
(2,1,1,'66330541dd559.jpg','2024-05-01 21:15:13','2024-05-01 21:16:07'),
(3,1,1,'663305420e68a.jpg','2024-05-01 21:15:14','2024-05-01 21:16:07'),
(4,1,2,'663305987e915.jpg','2024-05-01 21:16:40','2024-05-01 21:17:29'),
(5,1,2,'6633059882453.jpg','2024-05-01 21:16:40','2024-05-01 21:17:29'),
(6,1,2,'66330598ae19e.jpg','2024-05-01 21:16:40','2024-05-01 21:17:29'),
(7,1,3,'6633060932edb.jpg','2024-05-01 21:18:33','2024-05-01 21:19:10'),
(8,1,3,'6633060dd0733.jpg','2024-05-01 21:18:37','2024-05-01 21:19:10'),
(9,1,3,'6633060dd5ae9.jpg','2024-05-01 21:18:37','2024-05-01 21:19:10'),
(22,NULL,NULL,'663899b0c01f2.jpg','2024-05-06 02:49:52','2024-05-06 02:49:52'),
(23,NULL,NULL,'663899b0c0228.jpg','2024-05-06 02:49:52','2024-05-06 02:49:52'),
(24,NULL,NULL,'663899b0eb65c.jpg','2024-05-06 02:49:52','2024-05-06 02:49:52'),
(32,11,10,'6639b5b4c018e.jpg','2024-05-06 23:01:40','2024-05-06 23:02:31'),
(33,11,10,'6639b5b6aad44.jpg','2024-05-06 23:01:42','2024-05-06 23:02:31'),
(34,11,10,'6639b5b8a2fba.jpg','2024-05-06 23:01:44','2024-05-06 23:02:31'),
(35,11,11,'6639b60dbbe09.jpg','2024-05-06 23:03:09','2024-05-06 23:03:56'),
(36,11,11,'6639b6115f8b2.jpg','2024-05-06 23:03:13','2024-05-06 23:03:56'),
(37,11,11,'6639b6116d089.jpg','2024-05-06 23:03:13','2024-05-06 23:03:56'),
(38,11,12,'6639b6cd51b10.jpg','2024-05-06 23:06:21','2024-05-06 23:19:53'),
(39,11,12,'6639b6cd51b1d.jpg','2024-05-06 23:06:21','2024-05-06 23:19:53'),
(40,11,12,'6639b6cd791f8.jpg','2024-05-06 23:06:21','2024-05-06 23:19:53'),
(41,11,13,'6639ba3fdb5f0.jpg','2024-05-06 23:21:03','2024-05-06 23:21:31'),
(42,11,13,'6639ba3fe5509.jpg','2024-05-06 23:21:03','2024-05-06 23:21:31'),
(43,11,13,'6639ba400fea7.jpg','2024-05-06 23:21:04','2024-05-06 23:21:31'),
(44,NULL,NULL,'68cf8bcac2b42.jpg','2025-09-20 23:23:22','2025-09-20 23:23:22'),
(45,NULL,NULL,'68cf8bcb272b2.jpg','2025-09-20 23:23:23','2025-09-20 23:23:23'),
(46,NULL,NULL,'68cf8bcb59196.jpg','2025-09-20 23:23:23','2025-09-20 23:23:23'),
(47,NULL,NULL,'68cf8bcb5cd0e.jpg','2025-09-20 23:23:23','2025-09-20 23:23:23'),
(48,NULL,NULL,'68cf8bcb9561e.jpg','2025-09-20 23:23:23','2025-09-20 23:23:23'),
(49,NULL,NULL,'68cf8bcb979f2.jpg','2025-09-20 23:23:23','2025-09-20 23:23:23'),
(50,NULL,NULL,'68cf8bcbe2843.jpg','2025-09-20 23:23:23','2025-09-20 23:23:23'),
(51,NULL,NULL,'68cf8bcbe3761.jpg','2025-09-20 23:23:23','2025-09-20 23:23:23'),
(52,NULL,NULL,'68cf8bcc1bc77.jpg','2025-09-20 23:23:24','2025-09-20 23:23:24'),
(53,5,14,'68cf8bdcd395e.jpg','2025-09-20 23:23:40','2025-09-20 23:24:41'),
(54,5,14,'68cff667a714f.jpg','2025-09-21 06:58:15','2025-09-21 06:58:18'),
(55,5,14,'68cff667a92f0.jpg','2025-09-21 06:58:15','2025-09-21 06:58:18'),
(56,5,14,'68cff667db3fe.jpg','2025-09-21 06:58:15','2025-09-21 06:58:18');
/*!40000 ALTER TABLE `listing_product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_products`
--

DROP TABLE IF EXISTS `listing_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `feature_image` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `current_price` varchar(255) DEFAULT NULL,
  `previous_price` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_products`
--

LOCK TABLES `listing_products` WRITE;
/*!40000 ALTER TABLE `listing_products` DISABLE KEYS */;
INSERT INTO `listing_products` VALUES
(1,1,204,'1714619767.png','1','67','78','2024-05-01 21:16:07','2024-05-01 21:16:07'),
(2,1,204,'1714619849.png','1','899','993','2024-05-01 21:17:29','2024-05-01 21:17:29'),
(3,1,204,'1714619950.png','1','98','189','2024-05-01 21:19:10','2024-05-01 21:19:10'),
(10,11,202,'1715058151.png','1','900','1167','2024-05-06 23:02:31','2024-05-06 23:02:31'),
(11,11,202,'1715058236.png','1','789','990','2024-05-06 23:03:56','2024-05-06 23:03:56'),
(12,11,202,'1715059193.png','1','999','1200','2024-05-06 23:19:53','2024-05-06 23:19:53'),
(13,11,202,'1715059291.png','1','699','987','2024-05-06 23:21:31','2024-05-06 23:21:31'),
(14,5,207,'1758432281.png','1','2','5','2025-09-20 23:24:41','2025-09-20 23:24:41');
/*!40000 ALTER TABLE `listing_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_reviews`
--

DROP TABLE IF EXISTS `listing_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `listing_id` bigint(20) DEFAULT NULL,
  `rating` bigint(20) DEFAULT NULL,
  `review` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_reviews`
--

LOCK TABLES `listing_reviews` WRITE;
/*!40000 ALTER TABLE `listing_reviews` DISABLE KEYS */;
INSERT INTO `listing_reviews` VALUES
(1,2,1,5,'Visiting Saddle & Sip Saloon was an absolute delight from start to finish. Stepping into the salon, I was immediately impressed by the sleek and modern ambiance. The cleanliness and attention to detail were evident, which was particularly reassuring given the ongoing concerns about safety during the pandemic.','2024-05-01 22:16:02','2024-05-01 22:16:02'),
(2,1,1,4,'My recent visit to Saddle & Sip Saloon was an indulgent experience from start to finish. As I entered the salon, I was greeted by an atmosphere of sophistication and tranquility. The chic décor and soothing ambiance instantly set the tone for what promised to be a pampering session unlike any other.','2024-05-01 22:18:55','2024-05-01 22:18:55'),
(5,2,4,3,'My stay at Tranquil Haven Hotel was absolutely delightful. The oceanfront location provided stunning views, and the sound of the waves was incredibly soothing. The room was spacious, elegantly decorated, and equipped with all the modern amenities I needed for a comfortable stay. The staff were attentive and friendly, always ready to assist with any requests. I particularly enjoyed the dining experience at the hotel\'s restaurant; the food was exquisite and the ambiance was perfect for a relaxing meal. Overall, I highly recommend Tranquil Haven Hotel to anyone looking for a peaceful retreat by the sea.','2024-05-02 03:02:23','2024-05-02 03:02:23'),
(6,1,4,4,'Tranquil Haven Hotel exceeded all my expectations. From the moment I arrived, I was greeted with warmth and hospitality. The hotel\'s facilities, including the spa and fitness center, were top-notch and provided the perfect opportunity for relaxation and rejuvenation. The room was tastefully decorated, with a comfortable bed and a balcony overlooking the ocean. I also appreciated the attention to detail in the amenities provided. Whether it was enjoying a leisurely swim in the pool or savoring a delicious meal at the restaurant, every moment spent at Tranquil Haven was truly enjoyable. I can\'t wait to return for another stay.','2024-05-02 03:03:28','2024-05-02 03:03:28'),
(8,2,14,4,'Excellent service and very professional communication. The work was completed on time with great attention to detail. Everything was handled smoothly and exactly as expected. Highly recommended for anyone looking for reliable and quality service.','2026-05-12 08:20:08','2026-05-12 08:20:08');
/*!40000 ALTER TABLE `listing_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_sections`
--

DROP TABLE IF EXISTS `listing_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` text DEFAULT NULL,
  `button_text` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_sections`
--

LOCK TABLES `listing_sections` WRITE;
/*!40000 ALTER TABLE `listing_sections` DISABLE KEYS */;
INSERT INTO `listing_sections` VALUES
(3,20,'Trending Latest Listing',NULL,'All Listings','2023-10-18 21:37:18','2024-05-06 03:07:01'),
(4,21,'فئات السيارات الشعبية','فئات السيارات الشعبيةفئات السيارات الشعبيةفئات السيارات الشعبيةفئات السيارات الشعبيةفئات السيارات الشعبية','فئات السيارات الشعبية','2023-10-18 21:38:06','2023-12-12 22:23:21');
/*!40000 ALTER TABLE `listing_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_socail_medias`
--

DROP TABLE IF EXISTS `listing_socail_medias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing_socail_medias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_socail_medias`
--

LOCK TABLES `listing_socail_medias` WRITE;
/*!40000 ALTER TABLE `listing_socail_medias` DISABLE KEYS */;
INSERT INTO `listing_socail_medias` VALUES
(3,1,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-01 21:38:35','2024-05-01 21:38:35'),
(4,1,'fab fa-youtube','https://www.example.com','2024-05-01 21:38:35','2024-05-01 21:38:35'),
(5,1,'fab fa-linkedin-in','https://www.example.com','2024-05-01 21:38:35','2024-05-01 21:38:35'),
(45,3,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-05 23:10:30','2024-05-05 23:10:30'),
(46,3,'fab fa-youtube-square iconpicker-component','https://www.example.com','2024-05-05 23:10:30','2024-05-05 23:10:30'),
(47,3,'fab fa-twitter iconpicker-component','https://www.example.com','2024-05-05 23:10:30','2024-05-05 23:10:30'),
(48,3,'fab fa-linkedin-in iconpicker-component','https://www.example.com','2024-05-05 23:10:30','2024-05-05 23:10:30'),
(49,4,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-05 23:10:38','2024-05-05 23:10:38'),
(50,4,'fab fa-twitter iconpicker-component','https://www.example.com','2024-05-05 23:10:38','2024-05-05 23:10:38'),
(51,4,'fab fa-youtube iconpicker-component','https://www.example.com','2024-05-05 23:10:38','2024-05-05 23:10:38'),
(52,4,'fab fa-instagram iconpicker-component','https://www.example.com','2024-05-05 23:10:38','2024-05-05 23:10:38'),
(53,5,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-05 23:10:46','2024-05-05 23:10:46'),
(54,5,'fab fa-youtube iconpicker-component','https://www.example.com','2024-05-05 23:10:46','2024-05-05 23:10:46'),
(55,5,'fas fa-times iconpicker-component','https://www.example.com','2024-05-05 23:10:46','2024-05-05 23:10:46'),
(56,5,'fab fa-linkedin-in iconpicker-component','https://www.example.com','2024-05-05 23:10:46','2024-05-05 23:10:46'),
(57,6,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-05 23:10:53','2024-05-05 23:10:53'),
(58,6,'fab fa-youtube iconpicker-component','https://www.example.com','2024-05-05 23:10:53','2024-05-05 23:10:53'),
(59,6,'fab fa-linkedin-in iconpicker-component','https://www.example.com','2024-05-05 23:10:53','2024-05-05 23:10:53'),
(60,7,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-05 23:11:02','2024-05-05 23:11:02'),
(61,7,'fab fa-twitter iconpicker-component','https://www.example.com','2024-05-05 23:11:02','2024-05-05 23:11:02'),
(62,7,'fab fa-linkedin-in iconpicker-component','https://www.example.com','2024-05-05 23:11:02','2024-05-05 23:11:02'),
(63,7,'fab fa-youtube iconpicker-component','https://www.example.com','2024-05-05 23:11:02','2024-05-05 23:11:02'),
(68,9,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-06 20:46:06','2024-05-06 20:46:06'),
(69,9,'fab fa-youtube-square','https://www.example.com','2024-05-06 20:46:06','2024-05-06 20:46:06'),
(70,9,'fab fa-twitter','https://www.example.com','2024-05-06 20:46:06','2024-05-06 20:46:06'),
(71,9,'fab fa-linkedin-in','https://www.example.com','2024-05-06 20:46:06','2024-05-06 20:46:06'),
(72,10,'fab fa-facebook-messenger','https://www.facebook.com/azim.ahmed.9237245','2024-05-06 21:23:10','2024-05-06 21:23:10'),
(73,10,'fab fa-twitter-square','https://www.example.com','2024-05-06 21:23:10','2024-05-06 21:23:10'),
(74,10,'fab fa-linkedin','https://www.example.com','2024-05-06 21:23:10','2024-05-06 21:23:10'),
(75,10,'fab fa-youtube','https://www.example.com','2024-05-06 21:23:10','2024-05-06 21:23:10'),
(76,11,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-06 22:36:32','2024-05-06 22:36:32'),
(77,11,'fab fa-facebook-square iconpicker-component','https://www.example.com','2024-05-06 22:36:32','2024-05-06 22:36:32'),
(78,11,'fab fa-facebook-square iconpicker-component','https://www.example.com','2024-05-06 22:36:32','2024-05-06 22:36:32'),
(79,11,'fab fa-facebook-square iconpicker-component','https://www.example.com','2024-05-06 22:36:32','2024-05-06 22:36:32'),
(80,12,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-07 00:10:23','2024-05-07 00:10:23'),
(81,12,'fab fa-twitter','https://www.example.com','2024-05-07 00:10:23','2024-05-07 00:10:23'),
(82,12,'fab fa-youtube','https://www.example.com','2024-05-07 00:10:23','2024-05-07 00:10:23'),
(83,12,'fas fa-anchor','https://www.example.com','2024-05-07 00:10:23','2024-05-07 00:10:23'),
(84,13,'fab fa-facebook-messenger','https://www.facebook.com/azim.ahmed.9237245','2024-05-07 02:42:31','2024-05-07 02:42:31'),
(85,13,'fab fa-twitter','https://www.example.com','2024-05-07 02:42:31','2024-05-07 02:42:31'),
(86,13,'fab fa-linkedin-in','https://www.example.com','2024-05-07 02:42:31','2024-05-07 02:42:31'),
(87,13,'fab fa-youtube','https://www.example.com','2024-05-07 02:42:31','2024-05-07 02:42:31'),
(88,14,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-07 20:51:48','2024-05-07 20:51:48'),
(89,14,'fab fa-youtube','https://www.example.com','2024-05-07 20:51:48','2024-05-07 20:51:48'),
(90,14,'fab fa-twitter-square','https://www.example.com','2024-05-07 20:51:48','2024-05-07 20:51:48'),
(91,14,'fab fa-instagram','https://www.example.com','2024-05-07 20:51:48','2024-05-07 20:51:48'),
(92,15,'fab fa-facebook-square iconpicker-component','https://www.facebook.com/azim.ahmed.9237245','2024-05-08 02:46:52','2024-05-08 02:46:52'),
(93,15,'fab fa-youtube','https://www.example.com','2024-05-08 02:46:52','2024-05-08 02:46:52'),
(94,15,'fab fa-twitter','https://www.example.com','2024-05-08 02:46:52','2024-05-08 02:46:52'),
(95,15,'fab fa-linkedin','https://www.example.com','2024-05-08 02:46:52','2024-05-08 02:46:52');
/*!40000 ALTER TABLE `listing_socail_medias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listings`
--

DROP TABLE IF EXISTS `listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `listings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `feature_image` varchar(255) DEFAULT NULL,
  `video_background_image` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT 0,
  `mail` varchar(255) DEFAULT NULL,
  `average_rating` varchar(255) DEFAULT '0',
  `phone` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `min_price` double DEFAULT NULL,
  `max_price` double DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `visibility` int(11) NOT NULL DEFAULT 0,
  `is_featured` int(11) NOT NULL DEFAULT 0,
  `tawkto_status` tinyint(4) DEFAULT 0,
  `tawkto_direct_chat_link` varchar(255) DEFAULT NULL,
  `telegram_status` int(11) NOT NULL DEFAULT 0,
  `telegram_username` varchar(255) DEFAULT NULL,
  `messenger_status` int(11) NOT NULL DEFAULT 0,
  `messenger_direct_chat_link` varchar(255) DEFAULT NULL,
  `whatsapp_status` int(11) DEFAULT 0,
  `whatsapp_number` varchar(255) DEFAULT NULL,
  `whatsapp_header_title` varchar(255) DEFAULT NULL,
  `whatsapp_popup_status` int(11) DEFAULT NULL,
  `whatsapp_popup_message` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `average_rating` (`average_rating`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listings`
--

LOCK TABLES `listings` WRITE;
/*!40000 ALTER TABLE `listings` DISABLE KEYS */;
INSERT INTO `listings` VALUES
(1,'1714619499.png','1715160698.png','https://www.youtube.com/watch?v=-FnrCZJw6TE',204,'sddlesaloon@gmail.commm','4.5','+3545469034096','-37.89743','145.06727',397,2858,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-01 21:11:39','2025-01-18 21:56:07'),
(3,'1714627109.png','1715161205.png','https://www.youtube.com/watch?v=Xj4E0Zry6K4',204,'ulka@gmail.com','0','66','-37.8152145','144.9700836',892,1430,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8801775891798','Hey,...',1,'What need you?','2024-05-01 23:18:29','2025-01-18 21:59:55'),
(4,'1714638814.png','1715161266.png','https://www.youtube.com/watch?v=hNN9Q3GuWEM',204,'resorthotel34@gmail.com','3.5','+78685678678','21.4265856','91.9796587',NULL,NULL,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-02 02:33:34','2025-01-18 22:00:52'),
(5,'1714964359.png','1715161438.png','https://www.youtube.com/watch?v=--MdohXec7M',207,'feastHaven@gmail.com','0','+5469560654690','35.32473427220887','75.55125792520062',631,3612,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-05 20:59:19','2025-01-18 22:02:00'),
(6,'1714967273.png','1715161572.png','https://www.youtube.com/watch?v=9l6RywtDlKA',206,'motors@gmail.com','0','+3545478654','33.9596331','-118.3907052',2729,3948,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-05 21:47:53','2025-01-18 22:02:53'),
(7,'1714972012.png','1715161646.png','https://www.youtube.com/watch?v=ugK8HYpoDzE',205,'real@gmail.com','0','+54679354795','30.3322','81.6557',1005,3081,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8801775891798','Hey,...',1,'What need you?','2024-05-05 23:06:52','2024-05-08 03:47:26'),
(9,'1715059991.png','1715161408.png','https://www.youtube.com/watch?v=rI8FOLA-9XM',201,'Wholesome@gmail.com','0','+0354583546','23.6933','90.3818',1155,2362,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8801775891798','Hey,...',1,'What need you?','2024-05-06 20:37:35','2024-05-08 03:43:28'),
(10,'1715052140.png','1715161357.png','https://www.youtube.com/watch?v=_dui6BUmMBg',203,'cafe@gmail.com','0','+346753547835467','32.7157','117.1611',751,2314,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-06 21:22:20','2024-05-08 03:42:37'),
(11,'1715056471.png','1715161751.png','https://www.youtube.com/watch?v=UrZlTz8NMr0',202,'gymcraft@gmail.com','3','+234783457984','37.8136','142.9631',2700,5142,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-06 22:34:31','2025-12-06 22:55:05'),
(12,'1715062033.png','1715161036.png','https://www.youtube.com/watch?v=KqCUuvl1myg',205,'Eliartaltique@gmail.com','0','+3485478234234','30.3322','81.6557',1349,1564,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-07 00:07:13','2024-05-08 03:37:16'),
(13,'1715071246.png','1715160819.png','https://www.youtube.com/watch?v=_GSc3uAm8rQ',207,'bosky@gmail.com','0','+65463546954','33.9983','71.4859',NULL,NULL,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-07 02:40:46','2024-05-08 03:35:08'),
(14,'1715138647.png','1715160845.png','https://www.youtube.com/watch?v=-FnrCZJw6TE',204,'outlaw@gmail.com','4','+609354689546','27.1234','-81.5678',2289,4903,1,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-07 20:48:36','2026-05-12 08:20:08'),
(15,'1715161965.png','1728975507.png','https://www.youtube.com/watch?v=KqCUuvl1myg',204,'evergreen@gmail.com','0','+3549354765343','24.3746','88.6004',NULL,NULL,0,1,0,1,'https://embed.tawk.to/65617f23da19b36217909aae/1hg2dh96j',1,'example',1,'https://www.example.com',1,'+8800000000000','Hey,...',1,'What need you?','2024-05-08 02:46:04','2026-05-12 08:17:20'),
(17,'1762171703.jpg',NULL,NULL,0,'sovoha9006@hh7f.com','0','2121212','49.43453','149.91553',2072,2288,1,1,0,0,'gdfgfgf',0,NULL,0,NULL,0,NULL,NULL,NULL,NULL,'2025-10-29 04:38:46','2025-11-03 06:08:23'),
(18,'1762172696.jpg',NULL,NULL,0,'fobaj71978@burangir.com','0','+1 (422) 432-2987','40.7614','-73.9776',828,855,1,1,0,0,NULL,0,NULL,0,NULL,0,NULL,NULL,NULL,NULL,'2025-11-03 06:24:56','2025-11-03 06:24:56');
/*!40000 ALTER TABLE `listings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_sections`
--

DROP TABLE IF EXISTS `location_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_sections`
--

LOCK TABLES `location_sections` WRITE;
/*!40000 ALTER TABLE `location_sections` DISABLE KEYS */;
INSERT INTO `location_sections` VALUES
(1,20,'Explore Most Popo','2023-12-13 04:04:00','2024-03-19 23:34:45'),
(2,21,'اقرأ أحدث مدوناتنا','2023-12-13 04:04:18','2023-12-13 04:04:18');
/*!40000 ALTER TABLE `location_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_templates`
--

DROP TABLE IF EXISTS `mail_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mail_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_type` varchar(255) NOT NULL,
  `mail_subject` varchar(255) NOT NULL,
  `mail_body` blob DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_templates`
--

LOCK TABLES `mail_templates` WRITE;
/*!40000 ALTER TABLE `mail_templates` DISABLE KEYS */;
INSERT INTO `mail_templates` VALUES
(1,'verify_email','Verify Your Email Address','<p>Dear <strong>{username}</strong>,</p>\r\n<p>We just need to verify your email address before you can access to your dashboard.</p>\r\n<p>Verify your email address, {verification_link}.</p>\r\n<p>Thank you.<br>{website_title}</p>'),
(2,'reset_password','Recover Password of Your Account','<p>Hi {customer_name},</p><p>We have received a request to reset your password. If you did not make the request, ignore this email. Otherwise, you can reset your password using the below link.</p><p>{password_reset_link}</p><p>Thanks,<br />{website_title}</p>'),
(3,'product_order','Product Order Has Been Placed','<p>Hi {customer_name},</p><p>Your order has been placed successfully. We have attached an invoice in this mail.<br />Order No: #{order_number}</p><p>{order_link}<br /></p><p>Best regards.<br />{website_title}</p>'),
(4,'package_purchase','Your Package Purchase is successful.','<p>Hi {username},<br /><br />This is a confirmation mail from us.<br />You have Purchased your membership.<br /><strong>Package Title:</strong> {package_title}<br /><strong>Package Price:</strong> {package_price}<br /><strong>Activation Date:</strong> {activation_date}<br /><strong>Expire Date:</strong> {expire_date}</p>\r\n<p> </p>\r\n<p>We have attached an invoice with this mail.<br />Thank you for your purchase.</p>\r\n<p><br />Best Regards,<br />{website_title}.</p>'),
(8,'membership_expiry_reminder','Your membership will be expired soon','Hi {username},<br /><br />\r\n\r\nYour membership will be expired soon.<br />\r\nYour membership is valid till <strong>{last_day_of_membership}</strong><br />\r\nPlease click here - {login_link} to log into the dashboard to purchase a new package / extend the current package to extend your membership.<br /><br />\r\n\r\nBest Regards,<br />\r\n{website_title}.'),
(9,'membership_expired','Your membership is expired','Hi {username},<br><br>\r\n\r\nYour membership is expired.<br>\r\nPlease click here - {login_link} to log into the dashboard to purchase a new package / extend the current package to continue the membership.<br><br>\r\n\r\nBest Regards,<br>\r\n{website_title}.'),
(10,'payment_accepted_for_membership_offline_gateway','Your payment for registration is approved','<p>Hi {username},<br /><br />This is a confirmation mail from us.<br />Your payment has been accepted &amp; now you can login to your user dashboard to build your portfolio website.<br /><strong>Package Title:</strong> {package_title}<br /><strong>Package Price:</strong> {package_price}<br /><strong>Activation Date:</strong> {activation_date}<br /><strong>Expire Date:</strong> {expire_date}</p>\r\n<p> </p>\r\n<p>We have attached an invoice with this mail.<br />Thank you for your purchase.</p>\r\n<p><br />Best Regards,<br />{website_title}.</p>'),
(12,'payment_rejected_for_membership_offline_gateway','Your payment for membership extension is rejected','<p>Hi {username},<br /><br />\r\n\r\nWe are sorry to inform you that your payment has been rejected<br />\r\n\r\n<strong>Package Title:</strong> {package_title}<br />\r\n<strong>Package Price:</strong> {package_price}<br />\r\n\r\nBest Regards,<br />\r\n{website_title}.<br /></p>'),
(14,'admin_changed_current_package','Admin has changed your current package','<p>Hi {username},<br /><br />\r\n\r\nAdmin has changed your current package <b>({replaced_package})</b></p>\r\n<p><b>New Package Information:</b></p>\r\n<p>\r\n<strong>Package:</strong> {package_title}<br />\r\n<strong>Package Price:</strong> {package_price}<br />\r\n<strong>Activation Date:</strong> {activation_date}<br />\r\n<strong>Expire Date:</strong> {expire_date}</p><p><br /></p><p>We have attached an invoice with this mail.<br />\r\nThank you for your purchase.</p><p><br />\r\n\r\nBest Regards,<br />\r\n{website_title}.<br /></p>'),
(15,'admin_added_current_package','Admin has added current package for you','<p>Hi {username},<br /><br />\r\n\r\nAdmin has added current package for you</p><p><b><span style=\"font-size:18px;\">Current Membership Information:</span></b><br />\r\n<strong>Package Title:</strong> {package_title}<br />\r\n<strong>Package Price:</strong> {package_price}<br />\r\n<strong>Activation Date:</strong> {activation_date}<br />\r\n<strong>Expire Date:</strong> {expire_date}</p><p><br /></p><p>We have attached an invoice with this mail.<br />\r\nThank you for your purchase.</p><p><br />\r\n\r\nBest Regards,<br />\r\n{website_title}.<br /></p>'),
(16,'admin_changed_next_package','Admin has changed your next package','<p>Hi {username},<br /><br />\r\n\r\nAdmin has changed your next package <b>({replaced_package})</b></p><p><b><span style=\"font-size:18px;\">Next Membership Information:</span></b><br />\r\n<strong>Package Title:</strong> {package_title}<br />\r\n<strong>Package Price:</strong> {package_price}<br />\r\n<strong>Activation Date:</strong> {activation_date}<br />\r\n<strong>Expire Date:</strong> {expire_date}</p><p><br /></p><p>We have attached an invoice with this mail.<br />\r\nThank you for your purchase.</p><p><br />\r\n\r\nBest Regards,<br />\r\n{website_title}.<br /></p>'),
(17,'admin_added_next_package','Admin has added next package for you','<p>Hi {username},<br /><br />\r\n\r\nAdmin has added next package for you</p><p><b><span style=\"font-size:18px;\">Next Membership Information:</span></b><br />\r\n<strong>Package Title:</strong> {package_title}<br />\r\n<strong>Package Price:</strong> {package_price}<br />\r\n<strong>Activation Date:</strong> {activation_date}<br />\r\n<strong>Expire Date:</strong> {expire_date}</p><p><br /></p><p>We have attached an invoice with this mail.<br />\r\nThank you for your purchase.</p><p><br />\r\n\r\nBest Regards,<br />\r\n{website_title}.<br /></p>'),
(18,'admin_removed_current_package','Admin has removed current package for you','<p>Hi {username},<br /><br />\r\n\r\nAdmin has removed current package - <strong>{removed_package_title}</strong><br>\r\n\r\nBest Regards,<br />\r\n{website_title}.<br />'),
(19,'admin_removed_next_package','Admin has removed next package for you','<p>Hi {username},<br /><br />\r\n\r\nAdmin has removed next package - <strong>{removed_package_title}</strong><br>\r\n\r\nBest Regards,<br />\r\n{website_title}.<br />'),
(26,'inquiry_about_listing','Inquiry About Listing','<div class=\"\">\r\n<div class=\"ii gt\">\r\n<div class=\"a3s aiL\">\r\n<p> </p>\r\n<div style=\"margin: 0; box-sizing: border-box; color: #0a0a0a; font-family: Tahoma,\'Lucida Grande\',\'Lucida Sans\',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; line-height: 19px; min-width: 100%; padding: 0; text-align: left; width: 100%!important;\">\r\n<table style=\"margin: 0; background: #f3f5f8; border-collapse: collapse; border-spacing: 0; color: #0a0a0a; font-family: Tahoma,\'Lucida Grande\',\'Lucida Sans\',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; height: 100%; line-height: 19px; padding: 0; text-align: left; vertical-align: top; width: 100%;\">\r\n<tbody>\r\n<tr style=\"padding:0;text-align:left;\">\r\n<td style=\"margin: 0; border-collapse: collapse!important; color: #0a0a0a; font-family: Tahoma,\'Lucida Grande\',\'Lucida Sans\',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; line-height: 19px; padding: 0; text-align: left; vertical-align: top; word-wrap: break-word;\">\r\n<div style=\"padding-left: 16px!important; padding-right: 16px!important;\"><br />              <br />             \r\n<table style=\"margin: 0 auto; background: #f5f5ff; border: 1px solid #d4dce2; border-collapse: collapse; border-spacing: 0; min-width: 500px; padding: 0; text-align: inherit; vertical-align: top; width: 580px;\">\r\n<tbody>\r\n<tr style=\"padding:0;text-align:left;\">\r\n<td style=\"margin: 0; border-collapse: collapse!important; color: #0a0a0a; font-family: Tahoma,\'Lucida Grande\',\'Lucida Sans\',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; line-height: 19px; padding: 0; text-align: left; vertical-align: top; word-wrap: break-word;\"><br />\r\n<p style=\"padding-left:40px;\">Dear {username},</p>\r\n<p style=\"padding-left:40px;\">This email informs you that an enquirer is trying to contact you. Here is the information about the enquirer.</p>\r\n<p style=\"padding-left:40px;\"><strong>Listing</strong>: {listing_name}.</p>\r\n<p style=\"padding-left:40px;\">Enquirer Name: {enquirer_name}.</p>\r\n<p style=\"padding-left:40px;\">Enquirer Email: {enquirer_email}.</p>\r\n<p style=\"padding-left:40px;\">Enquirer Phone: {enquirer_phone}.</p>\r\n<p style=\"padding-left:40px;\">Message:</p>\r\n<p style=\"padding-left:40px;\">{enquirer_message}.</p>\r\n<p style=\"padding-left:40px;\"> </p>\r\n<p style=\"padding-left:40px;\">Best Regards.<br />{website_title}</p>\r\n <br />               <br />             </td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n </div>\r\n       </td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<p> </p>'),
(27,'payment_accepted_for_featured_offline_gateway','Your payment for Feature is approved','<p>Hi {username},<br /><br />This is a confirmation mail from us.<br />Your payment has been accepted &amp; now wait for status approve.</p>\r\n<p><strong>Listing :</strong> {listing_name}<br /><strong>Payment Via:</strong> {payment_via}<br /><strong>Payment Amount:</strong> {package_price}</p>\r\n<p>Thank you for your purchase.</p>\r\n<p><br />Best Regards,<br />{website_title}.</p>\r\n<p style=\"padding-left:40px;\"> </p>'),
(28,'payment_rejected_for_buy_feature_offline_gateway','Your payment for Active Listing Feature  is rejected','<p>Hi {username},<br /><br />We are sorry to inform you that your payment has been rejected.</p>\r\n<p><strong>Listing :</strong> {listing_name}<br /><strong>Payment Via:</strong> {payment_via}<br /><strong>Payment Amount:</strong> {package_price}<br />Best Regards,<br />{website_title}.</p>'),
(29,'listing_feature_active','Your request to feature listing is approved.','<p>Hi {username},<br /><br />We have approved your request.</p>\r\n<p>Your listing is featured for {days} days.  </p>\r\n<p><strong>Listing Title</strong>: {listing_name}.</p>\r\n<p><strong>Start Date :</strong> {activation_date}<br /><strong>End Date:</strong> {end_date}</p>\r\n<p> </p>\r\n<p>Best Regards,<br />{website_title}.</p>'),
(30,'listing_feature_reject','Your Request to Feature Listing is Rejected.','<p>Hi {username},<br /><br /></p>\r\n<p>We are sorry .</p>\r\n<p>Your request has been rejected</p>\r\n<p>Please create a support ticket.</p>\r\n<p><strong>Listing Title</strong>: {listing_name}.</p>\r\n<p><br />Best Regards,<br />{website_title}.</p>'),
(31,'payment_accepted_for_featured_online_gateway','Your payment to Feature your business is successful.','<p>Hi {username},<br /><br />This is a confirmation mail from us.<br />Your payment has been accepted &amp; now wait for status approve.<br /><strong>Payment Via:</strong> {payment_via}<br /><strong>Payment Amount:</strong> {package_price}</p>\r\n<p>Thank you for your purchase.</p>\r\n<p><br />Best Regards,<br />{website_title}.</p>\r\n<p style=\"padding-left:40px;\"> </p>'),
(32,'inquiry_about_product','Inquiry About Product','<p> </p>\r\n<div style=\"margin: 0; box-sizing: border-box; color: #0a0a0a; font-family: Tahoma,\'Lucida Grande\',\'Lucida Sans\',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; line-height: 19px; min-width: 100%; padding: 0; text-align: left; width: 100%!important;\">\r\n<table style=\"margin: 0; background: #f3f5f8; border-collapse: collapse; border-spacing: 0; color: #0a0a0a; font-family: Tahoma,\'Lucida Grande\',\'Lucida Sans\',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; height: 100%; line-height: 19px; padding: 0; text-align: left; vertical-align: top; width: 100%;\">\r\n<tbody>\r\n<tr style=\"padding:0;text-align:left;\">\r\n<td style=\"margin: 0; border-collapse: collapse!important; color: #0a0a0a; font-family: Tahoma,\'Lucida Grande\',\'Lucida Sans\',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; line-height: 19px; padding: 0; text-align: left; vertical-align: top; word-wrap: break-word;\">\r\n<div style=\"padding-left: 16px!important; padding-right: 16px!important;\"><br />              <br />             \r\n<table style=\"margin: 0 auto; background: #f5f5ff; border: 1px solid #d4dce2; border-collapse: collapse; border-spacing: 0; min-width: 500px; padding: 0; text-align: inherit; vertical-align: top; width: 580px;\">\r\n<tbody>\r\n<tr style=\"padding:0;text-align:left;\">\r\n<td style=\"margin: 0; border-collapse: collapse!important; color: #0a0a0a; font-family: Tahoma,\'Lucida Grande\',\'Lucida Sans\',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; line-height: 19px; padding: 0; text-align: left; vertical-align: top; word-wrap: break-word;\"><br />\r\n<p style=\"padding-left:40px;\">Dear {username},</p>\r\n<p style=\"padding-left:40px;\">This email informs you that an enquirer is trying to contact you. Here is the information about the enquirer.</p>\r\n<p style=\"padding-left:40px;\"><strong>Listing</strong>: {listing_name}.</p>\r\n<p style=\"padding-left:40px;\"><strong>Product</strong>: {product_name}.</p>\r\n<p style=\"padding-left:40px;\">Enquirer Name: {enquirer_name}.</p>\r\n<p style=\"padding-left:40px;\">Enquirer Email: {enquirer_email}.</p>\r\n<p style=\"padding-left:40px;\">Message:</p>\r\n<p style=\"padding-left:40px;\">{enquirer_message}.</p>\r\n<p style=\"padding-left:40px;\"> </p>\r\n<p style=\"padding-left:40px;\">Best Regards.<br />{website_title}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>'),
(33,'withdraw_approve','Confirmation of Withdraw Approve','<p>Hi {vendor_username},</p>\n<p>This email is confirm that your withdraw request {withdraw_id} is approved. </p>\n<p>Your current balance is {current_balance}, withdraw amount {withdraw_amount}, charge : {charge},payable amount {payable_amount}</p>\n<p>withdraw method : {withdraw_method},</p>\n<p> </p>\n<p>Best Regards.<br />{website_title}</p>'),
(34,'withdraw_rejected','Withdraw Request Rejected','<p>Hi {vendor_username},</p>\n<p>This email is to confirm that your withdrawal request {withdraw_id} is rejected and the balance added to your account. </p>\n<p>Your current balance is {current_balance}</p>\n<p> </p>\n<p>Best Regards.<br />{website_title}</p>'),
(39,'verify_email_app','Verify Your Email Address','<p>Dear <strong>{username}</strong>,</p>\r\n<p>We just need to verify your email address before you can access to your dashboard.</p>\r\n<p>Verification Code:{verification_code}.</p>\r\n<p>Thank you.<br />{website_title}</p>'),
(40,'reset_password_app','Recover Password of Your Account','<p>Hi {username},</p>\r\n<p>We have received a request to reset your password. If you did not make the request, ignore this email. Otherwise, you can reset your password using the below link.</p>\r\n<p>Verification Code: {verification_code}.</p>\r\n<p>Thanks,<br />{website_title}</p>');
/*!40000 ALTER TABLE `mail_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `memberships`
--

DROP TABLE IF EXISTS `memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `memberships` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_id` bigint(20) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `currency_symbol` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `is_trial` tinyint(4) NOT NULL DEFAULT 0,
  `trial_days` int(11) NOT NULL DEFAULT 0,
  `receipt` longtext DEFAULT NULL,
  `transaction_details` longtext DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `package_id` bigint(20) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `modified` tinyint(4) DEFAULT NULL COMMENT '1 - modified by Admin, 0 - not modified by Admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conversation_id` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `claim_id` smallint(5) unsigned DEFAULT NULL,
  `ai_engine` varchar(50) DEFAULT NULL,
  `ai_token_limit` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ai_image_limit` int(10) unsigned NOT NULL DEFAULT 0,
  `ai_used_tokens` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ai_used_images` int(10) unsigned NOT NULL DEFAULT 0,
  `ai_token_purchased` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ai_image_purchased` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberships`
--

LOCK TABLES `memberships` WRITE;
/*!40000 ALTER TABLE `memberships` DISABLE KEYS */;
INSERT INTO `memberships` VALUES
(1,204,999,'TRY','$','Stripe','18803cf5',1,0,0,NULL,'{\"id\":\"ch_3QipRsJlIV5dN9n71yEMY10K\",\"object\":\"charge\",\"amount\":99900,\"amount_captured\":99900,\"amount_refunded\":0,\"application\":null,\"application_fee\":null,\"application_fee_amount\":null,\"balance_transaction\":\"txn_3QipRsJlIV5dN9n71U7q2aZA\",\"billing_details\":{\"address\":{\"city\":null,\"country\":null,\"line1\":null,\"line2\":null,\"postal_code\":\"12345\",\"state\":null},\"email\":null,\"name\":null,\"phone\":null},\"calculated_statement_descriptor\":\"Stripe\",\"captured\":true,\"created\":1737258320,\"currency\":\"usd\",\"customer\":null,\"description\":\"You are extending your membership\",\"destination\":null,\"dispute\":null,\"disputed\":false,\"failure_balance_transaction\":null,\"failure_code\":null,\"failure_message\":null,\"fraud_details\":[],\"invoice\":null,\"livemode\":false,\"metadata\":{\"customer_name\":\"Jackson Lee\"},\"on_behalf_of\":null,\"order\":null,\"outcome\":{\"advice_code\":null,\"network_advice_code\":null,\"network_decline_code\":null,\"network_status\":\"approved_by_network\",\"reason\":null,\"risk_level\":\"normal\",\"risk_score\":57,\"seller_message\":\"Payment complete.\",\"type\":\"authorized\"},\"paid\":true,\"payment_intent\":null,\"payment_method\":\"card_1QipRrJlIV5dN9n7HFRhBWrM\",\"payment_method_details\":{\"card\":{\"amount_authorized\":99900,\"authorization_code\":null,\"brand\":\"visa\",\"checks\":{\"address_line1_check\":null,\"address_postal_code_check\":\"pass\",\"cvc_check\":\"pass\"},\"country\":\"US\",\"exp_month\":12,\"exp_year\":2026,\"extended_authorization\":{\"status\":\"disabled\"},\"fingerprint\":\"WXDgVUSzrY61Nnm6\",\"funding\":\"credit\",\"incremental_authorization\":{\"status\":\"unavailable\"},\"installments\":null,\"last4\":\"4242\",\"mandate\":null,\"multicapture\":{\"status\":\"unavailable\"},\"network\":\"visa\",\"network_token\":{\"used\":false},\"network_transaction_id\":\"878868103868583\",\"overcapture\":{\"maximum_amount_capturable\":99900,\"status\":\"unavailable\"},\"regulated_status\":\"unregulated\",\"three_d_secure\":null,\"wallet\":null},\"type\":\"card\"},\"receipt_email\":\"superBusiness47@example.com\",\"receipt_number\":null,\"receipt_url\":\"https:\\/\\/pay.stripe.com\\/receipts\\/payment\\/CAcaFwoVYWNjdF8xQXplbzNKbElWNWROOW43KNHqsbwGMgYeKuNnKnM6LBYHdnjekioLzgcMxS0glISCRW3acVQMQJBLbVTRUXZ4RKy1Y1YKdCELqsZ_\",\"refunded\":false,\"refunds\":{\"object\":\"list\",\"data\":[],\"has_more\":false,\"total_count\":0,\"url\":\"\\/v1\\/charges\\/ch_3QipRsJlIV5dN9n71yEMY10K\\/refunds\"},\"review\":null,\"shipping\":null,\"source\":{\"id\":\"card_1QipRrJlIV5dN9n7HFRhBWrM\",\"object\":\"card\",\"address_city\":null,\"address_country\":null,\"address_line1\":null,\"address_line1_check\":null,\"address_line2\":null,\"address_state\":null,\"address_zip\":\"12345\",\"address_zip_check\":\"pass\",\"allow_redisplay\":\"unspecified\",\"brand\":\"Visa\",\"country\":\"US\",\"customer\":null,\"cvc_check\":\"pass\",\"dynamic_last4\":null,\"exp_month\":12,\"exp_year\":2026,\"fingerprint\":\"WXDgVUSzrY61Nnm6\",\"funding\":\"credit\",\"last4\":\"4242\",\"metadata\":[],\"name\":null,\"regulated_status\":\"unregulated\",\"tokenization_method\":null,\"wallet\":null},\"source_transfer\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"TRY\",\"base_currency_text_position\":\"left\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}',93,'2025-01-19','2026-03-08',1,'2025-01-18 21:45:21','2026-03-09 01:51:55',NULL,'extend678c755184855.pdf',NULL,NULL,0,0,0,0,0,0),
(2,207,999,'TRY','$','PayPal','3f3f366c',1,0,0,NULL,'{\n    \"id\": \"PAYID-M6GHLPQ5FC20223YN353592V\",\n    \"intent\": \"sale\",\n    \"state\": \"approved\",\n    \"cart\": \"9S965919VD0346436\",\n    \"payer\": {\n        \"payment_method\": \"paypal\",\n        \"status\": \"VERIFIED\",\n        \"payer_info\": {\n            \"email\": \"megasoft.envato@gmail.com\",\n            \"first_name\": \"Samiul Alim\",\n            \"last_name\": \"Pratik\",\n            \"payer_id\": \"8C5NYJ7EZ7QSS\",\n            \"shipping_address\": {\n                \"recipient_name\": \"Samiul Alim Pratik\",\n                \"id\": \"7157040345310252769\",\n                \"line1\": \"1 Main St\",\n                \"city\": \"San Jose\",\n                \"state\": \"CA\",\n                \"postal_code\": \"95131\",\n                \"country_code\": \"US\",\n                \"type\": \"HOME_OR_WORK\",\n                \"default_address\": false,\n                \"preferred_address\": true,\n                \"primary_address\": true,\n                \"disable_for_transaction\": false\n            },\n            \"country_code\": \"US\"\n        }\n    },\n    \"transactions\": [\n        {\n            \"amount\": {\n                \"total\": \"999.00\",\n                \"currency\": \"USD\",\n                \"details\": {\n                    \"subtotal\": \"999.00\",\n                    \"shipping\": \"0.00\",\n                    \"insurance\": \"0.00\",\n                    \"handling_fee\": \"0.00\",\n                    \"shipping_discount\": \"0.00\",\n                    \"discount\": \"0.00\"\n                }\n            },\n            \"payee\": {\n                \"merchant_id\": \"BKNWZYE3MAUNU\",\n                \"email\": \"megasoft.envato-facilitator@gmail.com\"\n            },\n            \"description\": \"You are extending your membership Via Paypal\",\n            \"item_list\": {\n                \"items\": [\n                    {\n                        \"name\": \"You are extending your membership\",\n                        \"price\": \"999.00\",\n                        \"currency\": \"USD\",\n                        \"tax\": \"0.00\",\n                        \"quantity\": 1\n                    }\n                ],\n                \"shipping_address\": {\n                    \"recipient_name\": \"Samiul Alim Pratik\",\n                    \"id\": \"7157040345310252769\",\n                    \"line1\": \"1 Main St\",\n                    \"city\": \"San Jose\",\n                    \"state\": \"CA\",\n                    \"postal_code\": \"95131\",\n                    \"country_code\": \"US\",\n                    \"type\": \"HOME_OR_WORK\",\n                    \"default_address\": false,\n                    \"preferred_address\": true,\n                    \"primary_address\": true,\n                    \"disable_for_transaction\": false\n                }\n            },\n            \"related_resources\": [\n                {\n                    \"sale\": {\n                        \"id\": \"8KL55362P3264215Y\",\n                        \"state\": \"completed\",\n                        \"amount\": {\n                            \"total\": \"999.00\",\n                            \"currency\": \"USD\",\n                            \"details\": {\n                                \"subtotal\": \"999.00\",\n                                \"shipping\": \"0.00\",\n                                \"insurance\": \"0.00\",\n                                \"handling_fee\": \"0.00\",\n                                \"shipping_discount\": \"0.00\",\n                                \"discount\": \"0.00\"\n                            }\n                        },\n                        \"payment_mode\": \"INSTANT_TRANSFER\",\n                        \"protection_eligibility\": \"ELIGIBLE\",\n                        \"protection_eligibility_type\": \"ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE\",\n                        \"transaction_fee\": {\n                            \"value\": \"35.36\",\n                            \"currency\": \"USD\"\n                        },\n                        \"parent_payment\": \"PAYID-M6GHLPQ5FC20223YN353592V\",\n                        \"create_time\": \"2025-01-19T03:47:43Z\",\n                        \"update_time\": \"2025-01-19T03:47:43Z\",\n                        \"links\": [\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/8KL55362P3264215Y\",\n                                \"rel\": \"self\",\n                                \"method\": \"GET\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/8KL55362P3264215Y/refund\",\n                                \"rel\": \"refund\",\n                                \"method\": \"POST\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHLPQ5FC20223YN353592V\",\n                                \"rel\": \"parent_payment\",\n                                \"method\": \"GET\"\n                            }\n                        ]\n                    }\n                }\n            ]\n        }\n    ],\n    \"create_time\": \"2025-01-19T03:47:09Z\",\n    \"update_time\": \"2025-01-19T03:47:43Z\",\n    \"links\": [\n        {\n            \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHLPQ5FC20223YN353592V\",\n            \"rel\": \"self\",\n            \"method\": \"GET\"\n        }\n    ],\n    \"failed_transactions\": []\n}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"TRY\",\"base_currency_text_position\":\"left\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}',93,'2025-01-19','2026-03-08',1,'2025-01-18 21:48:46','2026-03-09 01:49:10',NULL,'extend678c761ed7f79.pdf',NULL,NULL,0,0,0,0,0,0),
(3,206,999,'USD','$','Authorize.net','382dacae',1,0,0,NULL,'{}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}',93,'2025-01-19','2026-03-08',1,'2025-01-18 21:50:54','2026-03-09 01:51:21',NULL,'extend678c769ebbfb4.pdf',NULL,NULL,0,0,0,0,0,0),
(4,205,999,'USD','$','Bank of America','1473d634',1,0,0,'1737258725.jpg','\"offline\"','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}',93,'2025-01-19','2026-03-08',1,'2025-01-18 21:52:05','2026-03-09 01:53:22',NULL,'membership678c76f03c454.pdf',NULL,NULL,0,0,0,0,0,0),
(5,201,999,'USD','$','PayPal','191ae1e3',1,0,0,NULL,'{\n    \"id\": \"PAYID-M6GHOKI9X122956293229900\",\n    \"intent\": \"sale\",\n    \"state\": \"approved\",\n    \"cart\": \"6D735369TT745435S\",\n    \"payer\": {\n        \"payment_method\": \"paypal\",\n        \"status\": \"VERIFIED\",\n        \"payer_info\": {\n            \"email\": \"megasoft.envato@gmail.com\",\n            \"first_name\": \"Samiul Alim\",\n            \"last_name\": \"Pratik\",\n            \"payer_id\": \"8C5NYJ7EZ7QSS\",\n            \"shipping_address\": {\n                \"recipient_name\": \"Samiul Alim Pratik\",\n                \"id\": \"7157040345310252769\",\n                \"line1\": \"1 Main St\",\n                \"city\": \"San Jose\",\n                \"state\": \"CA\",\n                \"postal_code\": \"95131\",\n                \"country_code\": \"US\",\n                \"type\": \"HOME_OR_WORK\",\n                \"default_address\": false,\n                \"preferred_address\": true,\n                \"primary_address\": true,\n                \"disable_for_transaction\": false\n            },\n            \"country_code\": \"US\"\n        }\n    },\n    \"transactions\": [\n        {\n            \"amount\": {\n                \"total\": \"999.00\",\n                \"currency\": \"USD\",\n                \"details\": {\n                    \"subtotal\": \"999.00\",\n                    \"shipping\": \"0.00\",\n                    \"insurance\": \"0.00\",\n                    \"handling_fee\": \"0.00\",\n                    \"shipping_discount\": \"0.00\",\n                    \"discount\": \"0.00\"\n                }\n            },\n            \"payee\": {\n                \"merchant_id\": \"BKNWZYE3MAUNU\",\n                \"email\": \"megasoft.envato-facilitator@gmail.com\"\n            },\n            \"description\": \"You are extending your membership Via Paypal\",\n            \"item_list\": {\n                \"items\": [\n                    {\n                        \"name\": \"You are extending your membership\",\n                        \"price\": \"999.00\",\n                        \"currency\": \"USD\",\n                        \"tax\": \"0.00\",\n                        \"quantity\": 1\n                    }\n                ],\n                \"shipping_address\": {\n                    \"recipient_name\": \"Samiul Alim Pratik\",\n                    \"id\": \"7157040345310252769\",\n                    \"line1\": \"1 Main St\",\n                    \"city\": \"San Jose\",\n                    \"state\": \"CA\",\n                    \"postal_code\": \"95131\",\n                    \"country_code\": \"US\",\n                    \"type\": \"HOME_OR_WORK\",\n                    \"default_address\": false,\n                    \"preferred_address\": true,\n                    \"primary_address\": true,\n                    \"disable_for_transaction\": false\n                }\n            },\n            \"related_resources\": [\n                {\n                    \"sale\": {\n                        \"id\": \"5HT849373G2733944\",\n                        \"state\": \"completed\",\n                        \"amount\": {\n                            \"total\": \"999.00\",\n                            \"currency\": \"USD\",\n                            \"details\": {\n                                \"subtotal\": \"999.00\",\n                                \"shipping\": \"0.00\",\n                                \"insurance\": \"0.00\",\n                                \"handling_fee\": \"0.00\",\n                                \"shipping_discount\": \"0.00\",\n                                \"discount\": \"0.00\"\n                            }\n                        },\n                        \"payment_mode\": \"INSTANT_TRANSFER\",\n                        \"protection_eligibility\": \"ELIGIBLE\",\n                        \"protection_eligibility_type\": \"ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE\",\n                        \"transaction_fee\": {\n                            \"value\": \"35.36\",\n                            \"currency\": \"USD\"\n                        },\n                        \"parent_payment\": \"PAYID-M6GHOKI9X122956293229900\",\n                        \"create_time\": \"2025-01-19T03:53:23Z\",\n                        \"update_time\": \"2025-01-19T03:53:23Z\",\n                        \"links\": [\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/5HT849373G2733944\",\n                                \"rel\": \"self\",\n                                \"method\": \"GET\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/5HT849373G2733944/refund\",\n                                \"rel\": \"refund\",\n                                \"method\": \"POST\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHOKI9X122956293229900\",\n                                \"rel\": \"parent_payment\",\n                                \"method\": \"GET\"\n                            }\n                        ]\n                    }\n                }\n            ]\n        }\n    ],\n    \"redirect_urls\": {\n        \"return_url\": \"https://bulistio.test/vendor/membership/paypal/success?paymentId=PAYID-M6GHOKI9X122956293229900\",\n        \"cancel_url\": \"https://bulistio.test/vendor/membership/paypal/cancel\"\n    },\n    \"create_time\": \"2025-01-19T03:53:12Z\",\n    \"update_time\": \"2025-01-19T03:53:23Z\",\n    \"links\": [\n        {\n            \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHOKI9X122956293229900\",\n            \"rel\": \"self\",\n            \"method\": \"GET\"\n        }\n    ],\n    \"failed_transactions\": []\n}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}',93,'2025-01-19','9999-12-31',NULL,'2025-01-18 21:53:23','2025-01-18 21:53:23',NULL,'extend678c7733bdee5.pdf',NULL,NULL,0,0,0,0,0,0),
(6,203,999,'USD','$','Citibank','e8fa55c6',1,0,0,NULL,'\"offline\"','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}',93,'2025-01-19','2026-04-01',1,'2025-01-18 21:53:56','2026-04-02 00:58:59',NULL,'membership678c77595f0e0.pdf',NULL,NULL,0,0,0,0,0,0),
(7,202,999,'USD','$','PayPal','e17ae7cc',1,0,0,NULL,'{\n    \"id\": \"PAYID-M6GHO7A5JB73275VY033110H\",\n    \"intent\": \"sale\",\n    \"state\": \"approved\",\n    \"cart\": \"44U651594K3749149\",\n    \"payer\": {\n        \"payment_method\": \"paypal\",\n        \"status\": \"VERIFIED\",\n        \"payer_info\": {\n            \"email\": \"megasoft.envato@gmail.com\",\n            \"first_name\": \"Samiul Alim\",\n            \"last_name\": \"Pratik\",\n            \"payer_id\": \"8C5NYJ7EZ7QSS\",\n            \"shipping_address\": {\n                \"recipient_name\": \"Samiul Alim Pratik\",\n                \"id\": \"7157040345310252769\",\n                \"line1\": \"1 Main St\",\n                \"city\": \"San Jose\",\n                \"state\": \"CA\",\n                \"postal_code\": \"95131\",\n                \"country_code\": \"US\",\n                \"type\": \"HOME_OR_WORK\",\n                \"default_address\": false,\n                \"preferred_address\": true,\n                \"primary_address\": true,\n                \"disable_for_transaction\": false\n            },\n            \"country_code\": \"US\"\n        }\n    },\n    \"transactions\": [\n        {\n            \"amount\": {\n                \"total\": \"999.00\",\n                \"currency\": \"USD\",\n                \"details\": {\n                    \"subtotal\": \"999.00\",\n                    \"shipping\": \"0.00\",\n                    \"insurance\": \"0.00\",\n                    \"handling_fee\": \"0.00\",\n                    \"shipping_discount\": \"0.00\",\n                    \"discount\": \"0.00\"\n                }\n            },\n            \"payee\": {\n                \"merchant_id\": \"BKNWZYE3MAUNU\",\n                \"email\": \"megasoft.envato-facilitator@gmail.com\"\n            },\n            \"description\": \"You are extending your membership Via Paypal\",\n            \"item_list\": {\n                \"items\": [\n                    {\n                        \"name\": \"You are extending your membership\",\n                        \"price\": \"999.00\",\n                        \"currency\": \"USD\",\n                        \"tax\": \"0.00\",\n                        \"quantity\": 1\n                    }\n                ],\n                \"shipping_address\": {\n                    \"recipient_name\": \"Samiul Alim Pratik\",\n                    \"id\": \"7157040345310252769\",\n                    \"line1\": \"1 Main St\",\n                    \"city\": \"San Jose\",\n                    \"state\": \"CA\",\n                    \"postal_code\": \"95131\",\n                    \"country_code\": \"US\",\n                    \"type\": \"HOME_OR_WORK\",\n                    \"default_address\": false,\n                    \"preferred_address\": true,\n                    \"primary_address\": true,\n                    \"disable_for_transaction\": false\n                }\n            },\n            \"related_resources\": [\n                {\n                    \"sale\": {\n                        \"id\": \"27B842984G4918334\",\n                        \"state\": \"completed\",\n                        \"amount\": {\n                            \"total\": \"999.00\",\n                            \"currency\": \"USD\",\n                            \"details\": {\n                                \"subtotal\": \"999.00\",\n                                \"shipping\": \"0.00\",\n                                \"insurance\": \"0.00\",\n                                \"handling_fee\": \"0.00\",\n                                \"shipping_discount\": \"0.00\",\n                                \"discount\": \"0.00\"\n                            }\n                        },\n                        \"payment_mode\": \"INSTANT_TRANSFER\",\n                        \"protection_eligibility\": \"ELIGIBLE\",\n                        \"protection_eligibility_type\": \"ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE\",\n                        \"transaction_fee\": {\n                            \"value\": \"35.36\",\n                            \"currency\": \"USD\"\n                        },\n                        \"parent_payment\": \"PAYID-M6GHO7A5JB73275VY033110H\",\n                        \"create_time\": \"2025-01-19T03:54:46Z\",\n                        \"update_time\": \"2025-01-19T03:54:46Z\",\n                        \"links\": [\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/27B842984G4918334\",\n                                \"rel\": \"self\",\n                                \"method\": \"GET\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/sale/27B842984G4918334/refund\",\n                                \"rel\": \"refund\",\n                                \"method\": \"POST\"\n                            },\n                            {\n                                \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHO7A5JB73275VY033110H\",\n                                \"rel\": \"parent_payment\",\n                                \"method\": \"GET\"\n                            }\n                        ]\n                    }\n                }\n            ]\n        }\n    ],\n    \"redirect_urls\": {\n        \"return_url\": \"https://bulistio.test/vendor/membership/paypal/success?paymentId=PAYID-M6GHO7A5JB73275VY033110H\",\n        \"cancel_url\": \"https://bulistio.test/vendor/membership/paypal/cancel\"\n    },\n    \"create_time\": \"2025-01-19T03:54:35Z\",\n    \"update_time\": \"2025-01-19T03:54:46Z\",\n    \"links\": [\n        {\n            \"href\": \"https://api.sandbox.paypal.com/v1/payments/payment/PAYID-M6GHO7A5JB73275VY033110H\",\n            \"rel\": \"self\",\n            \"method\": \"GET\"\n        }\n    ],\n    \"failed_transactions\": []\n}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"ranaahmed269205@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"ranaahmed269205@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"azimahmed11040@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":1,\"google_recaptcha_site_key\":\"recaptcha-site-key\",\"google_recaptcha_secret_key\":\"recaptcha-secret-key\",\"whatsapp_status\":1,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":1,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":2,\"facebook_login_status\":0,\"facebook_app_id\":\"882678273570258\",\"facebook_app_secret\":\"facebook-app-secret\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":0,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500}',93,'2025-01-19','9999-12-31',NULL,'2025-01-18 21:54:46','2025-01-18 21:54:46',NULL,'extend678c778694962.pdf',NULL,NULL,0,0,0,0,0,0),
(34,207,999,'USD','$','PayPal','69ae7b9b338a3',1,0,0,NULL,NULL,NULL,93,'2026-03-09','9999-12-31',NULL,'2026-03-09 01:49:47','2026-03-09 01:49:47',NULL,NULL,NULL,'gemini',60000,60,20723,10,0,0),
(35,206,999,'USD','$','Xendit','69ae7c05b6ffe',1,0,0,NULL,NULL,NULL,93,'2026-03-09','9999-12-31',NULL,'2026-03-09 01:51:33','2026-03-09 01:51:33',NULL,NULL,NULL,'gemini',60000,60,0,15,0,0),
(36,204,999,'USD','$','Xendit','69ae7c28aefe7',1,0,0,NULL,NULL,NULL,93,'2026-03-09','2026-04-05',1,'2026-03-09 01:52:08','2026-04-06 02:45:16',NULL,NULL,NULL,'gemini',60000,60,10544,5,0,0),
(37,205,699,'USD','$','Perfect Money','69ae7c7e009f0',1,0,0,NULL,NULL,NULL,92,'2026-03-09','9999-12-31',NULL,'2026-03-09 01:53:34','2026-03-09 01:53:34',NULL,NULL,NULL,'openai',40000,40,7055,25,0,0),
(39,203,999,'USD','$','Xendit','69ce14b6e7e88',1,0,0,NULL,NULL,NULL,93,'2026-04-02','9999-12-31',NULL,'2026-04-02 01:03:18','2026-04-02 01:07:01',NULL,NULL,NULL,'gemini',60000,60,453,22,0,0),
(40,204,29.99,'USD','$','Xendit','69d372ac25943',1,0,0,NULL,NULL,NULL,87,'2026-04-06','2026-04-05',1,'2026-04-06 02:45:32','2026-04-06 03:02:21',NULL,NULL,NULL,'gemini',35000,30,0,0,0,0),
(41,204,999,'USD','$','Xendit','69d376ac13f24',1,0,0,NULL,NULL,NULL,93,'2026-04-06','2026-04-06',1,'2026-04-06 03:02:36','2026-04-07 00:06:50',NULL,NULL,NULL,'gemini',60000,60,0,0,0,0),
(42,204,999,'USD','$','Perfect Money','69d4a3c607366',1,0,0,NULL,NULL,NULL,93,'2026-04-07','2026-04-11',1,'2026-04-07 00:27:18','2026-04-12 04:16:13',NULL,NULL,NULL,'gemini',60000,60,2249,0,0,0),
(43,204,699,'USD','$','Citibank','5e80625e',0,0,0,NULL,'\"offline\"','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"google-api-key\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}',92,'9999-12-31','9999-12-31',1,'2026-04-12 04:15:52','2026-04-12 04:16:06',NULL,NULL,NULL,'openai',40000,40,0,0,0,0),
(44,204,999,'USD','$','Citibank','36145108',1,0,0,NULL,'\"offline\"','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"google-api-key\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}',93,'2026-04-12','2026-04-19',1,'2026-04-12 04:17:22','2026-04-19 22:43:10',NULL,'membership69db713893b6c.pdf',NULL,'gemini',60000,60,4830,4,0,0),
(46,204,999,'USD','$','PayPal','6UW88667CJ765174G',1,0,0,NULL,'{\"paypal_order_id\":\"6UW88667CJ765174G\",\"paypal_capture_status\":\"COMPLETED\",\"paypal_capture_response\":{\"status\":\"COMPLETED\",\"raw\":{\"id\":\"6UW88667CJ765174G\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"megasoft.envato@gmail.com\",\"account_id\":\"8C5NYJ7EZ7QSS\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"address\":{\"country_code\":\"US\"}}},\"purchase_units\":[{\"reference_id\":\"default\",\"shipping\":{\"name\":{\"full_name\":\"Samiul Alim Pratik\"},\"address\":{\"address_line_1\":\"1 Main St\",\"admin_area_2\":\"San Jose\",\"admin_area_1\":\"CA\",\"postal_code\":\"95131\",\"country_code\":\"US\"}},\"payments\":{\"captures\":[{\"id\":\"4RW91909MX576104V\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"35.36\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"963.64\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4RW91909MX576104V\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4RW91909MX576104V\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/6UW88667CJ765174G\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-20T04:43:38Z\",\"update_time\":\"2026-04-20T04:43:38Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"email_address\":\"megasoft.envato@gmail.com\",\"payer_id\":\"8C5NYJ7EZ7QSS\",\"address\":{\"country_code\":\"US\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/6UW88667CJ765174G\",\"rel\":\"self\",\"method\":\"GET\"}]}},\"gateway\":\"paypal\",\"payment_state\":\"completed\"}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}',93,'2026-04-20','2026-04-19',1,'2026-04-19 22:43:45','2026-04-19 22:46:24',NULL,NULL,NULL,'gemini',60000,60,0,0,0,0),
(47,204,999,'USD','$','PayPal','4HY982028C6056123',1,0,0,NULL,'{\"paypal_order_id\":\"4HY982028C6056123\",\"paypal_capture_status\":\"COMPLETED\",\"paypal_capture_response\":{\"status\":\"COMPLETED\",\"raw\":{\"id\":\"4HY982028C6056123\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"megasoft.envato@gmail.com\",\"account_id\":\"8C5NYJ7EZ7QSS\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"address\":{\"country_code\":\"US\"}}},\"purchase_units\":[{\"reference_id\":\"default\",\"shipping\":{\"name\":{\"full_name\":\"Samiul Alim Pratik\"},\"address\":{\"address_line_1\":\"1 Main St\",\"admin_area_2\":\"San Jose\",\"admin_area_1\":\"CA\",\"postal_code\":\"95131\",\"country_code\":\"US\"}},\"payments\":{\"captures\":[{\"id\":\"4UY74085H80422231\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"35.36\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"963.64\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4UY74085H80422231\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4UY74085H80422231\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/4HY982028C6056123\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-20T04:46:34Z\",\"update_time\":\"2026-04-20T04:46:34Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"email_address\":\"megasoft.envato@gmail.com\",\"payer_id\":\"8C5NYJ7EZ7QSS\",\"address\":{\"country_code\":\"US\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/4HY982028C6056123\",\"rel\":\"self\",\"method\":\"GET\"}]}},\"gateway\":\"paypal\",\"payment_state\":\"completed\"}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"USD\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}',93,'2026-04-20','2026-04-19',1,'2026-04-19 22:46:40','2026-04-19 23:07:01',NULL,NULL,NULL,'gemini',60000,60,0,0,0,0),
(49,204,999,'INR','₹','PhonePe','txn_20260420050750_4081d152',1,0,0,NULL,'{\"phonepe_merchant_txn_id\":\"txn_20260420050750_4081d152\",\"phonepe_status\":\"COMPLETED\",\"phonepe_verify_response\":{\"status\":\"COMPLETED\",\"raw\":{\"code\":\"PAYMENT_SUCCESS\"}},\"gateway\":\"phonepe\",\"payment_state\":\"completed\"}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"\\u20b9\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"INR\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}',93,'2026-04-20','2026-04-19',1,'2026-04-19 23:08:12','2026-04-19 23:36:09',NULL,NULL,NULL,'gemini',60000,60,0,0,0,0),
(50,204,999,'INR','₹','PayPal','51L57987CH954384F',1,0,0,NULL,'{\"paypal_order_id\":\"51L57987CH954384F\",\"paypal_capture_status\":\"COMPLETED\",\"paypal_capture_response\":{\"status\":\"COMPLETED\",\"raw\":{\"id\":\"51L57987CH954384F\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"megasoft.envato@gmail.com\",\"account_id\":\"8C5NYJ7EZ7QSS\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"address\":{\"country_code\":\"US\"}}},\"purchase_units\":[{\"reference_id\":\"default\",\"shipping\":{\"name\":{\"full_name\":\"Samiul Alim Pratik\"},\"address\":{\"address_line_1\":\"1 Main St\",\"admin_area_2\":\"San Jose\",\"admin_area_1\":\"CA\",\"postal_code\":\"95131\",\"country_code\":\"US\"}},\"payments\":{\"captures\":[{\"id\":\"26B360064L288035U\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"999.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"35.36\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"963.64\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/26B360064L288035U\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/26B360064L288035U\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/51L57987CH954384F\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-20T05:36:34Z\",\"update_time\":\"2026-04-20T05:36:34Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"email_address\":\"megasoft.envato@gmail.com\",\"payer_id\":\"8C5NYJ7EZ7QSS\",\"address\":{\"country_code\":\"US\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/51L57987CH954384F\",\"rel\":\"self\",\"method\":\"GET\"}]}},\"gateway\":\"paypal\",\"payment_state\":\"completed\"}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"\\u20b9\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"INR\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}',93,'2026-04-20','2026-04-19',1,'2026-04-19 23:36:41','2026-04-19 23:36:58',NULL,NULL,NULL,'gemini',60000,60,0,0,0,0),
(51,204,999,'INR','₹','PhonePe','txn_20260420053707_9862baaa',1,0,0,NULL,'{\"phonepe_merchant_txn_id\":\"txn_20260420053707_9862baaa\",\"phonepe_status\":\"COMPLETED\",\"phonepe_verify_response\":{\"status\":\"COMPLETED\",\"raw\":{\"code\":\"PAYMENT_SUCCESS\"}},\"gateway\":\"phonepe\",\"payment_state\":\"completed\"}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"\\u20b9\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"INR\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"1.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}',93,'2026-04-20','2026-04-19',1,'2026-04-19 23:37:20','2026-04-19 23:37:29',NULL,NULL,NULL,'gemini',60000,60,0,0,0,0),
(52,204,999,'NGN','₦','PayPal','8EM27060E97485437',1,0,0,NULL,'{\"paypal_order_id\":\"8EM27060E97485437\",\"paypal_capture_status\":\"COMPLETED\",\"paypal_capture_response\":{\"status\":\"COMPLETED\",\"raw\":{\"id\":\"8EM27060E97485437\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"megasoft.envato@gmail.com\",\"account_id\":\"8C5NYJ7EZ7QSS\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"address\":{\"country_code\":\"US\"}}},\"purchase_units\":[{\"reference_id\":\"default\",\"shipping\":{\"name\":{\"full_name\":\"Samiul Alim Pratik\"},\"address\":{\"address_line_1\":\"1 Main St\",\"admin_area_2\":\"San Jose\",\"admin_area_1\":\"CA\",\"postal_code\":\"95131\",\"country_code\":\"US\"}},\"payments\":{\"captures\":[{\"id\":\"8YX7870979381842G\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"12.49\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"12.49\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"0.93\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"11.56\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/8YX7870979381842G\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/8YX7870979381842G\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/8EM27060E97485437\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-20T06:14:26Z\",\"update_time\":\"2026-04-20T06:14:26Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Samiul Alim\",\"surname\":\"Pratik\"},\"email_address\":\"megasoft.envato@gmail.com\",\"payer_id\":\"8C5NYJ7EZ7QSS\",\"address\":{\"country_code\":\"US\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/8EM27060E97485437\",\"rel\":\"self\",\"method\":\"GET\"}]}},\"payment_verifier\":{\"source_amount\":999,\"source_currency\":\"NGN\",\"verified_amount\":12.49,\"verified_currency\":\"USD\",\"verified_amount_minor\":1249},\"gateway\":\"paypal\",\"payment_state\":\"completed\"}','{\"id\":2,\"uniqid\":12345,\"favicon\":\"66321327155b0.png\",\"logo\":\"65b9bb8f98dd7.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Bulistio\",\"redeem_token_expire_days\":364,\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"\\u20a6\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"NGN\",\"base_currency_text_position\":\"right\",\"base_currency_rate\":\"80.00\",\"primary_color\":\"F9725F\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":587,\"encryption\":\"TLS\",\"smtp_username\":\"goutam052597@gmail.com\",\"smtp_password\":\"smtp-password\",\"from_mail\":\"goutam052597@gmail.com\",\"from_name\":\"Bulistio\",\"to_mail\":\"saifislamfci@gmail.com\",\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":\"test\",\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":\"1\",\"google_recaptcha_secret_key\":\"1\",\"whatsapp_status\":0,\"whatsapp_number\":\"+880111111111\",\"whatsapp_header_title\":\"Hi,there!\",\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":\"If you have any issues, let us know.\",\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"azim\",\"footer_logo\":\"690978719ca9e.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"dark\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663c8354ee10d.jpg\",\"call_to_action_section_highlight_image\":\"663c8354ef694.jpg\",\"video_section_image\":\"663efd5b5134b.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":1,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":\"1\",\"facebook_app_secret\":\"1\",\"google_login_status\":1,\"google_client_id\":\"google-client-id.apps.googleusercontent.com\",\"google_client_secret\":\"google-client-secret\",\"tawkto_status\":1,\"hero_section_background_img\":\"664af3245b2b4.png\",\"tawkto_direct_chat_link\":\"https:\\/\\/embed.tawk.to\\/65617f23da19b36217909aae\\/1hg2dh96j\",\"vendor_admin_approval\":1,\"vendor_email_verification\":1,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T06:02:42.000000Z\",\"time_format\":12,\"google_map_api_key_status\":1,\"google_map_api_key\":\"google-map-api-key\",\"radius\":500,\"commission_amount\":\"10.00\",\"app_logo\":\"693504171db56.png\",\"app_fav\":\"69350407b717e.png\",\"app_url\":null,\"app_primary_color\":\"FF8000\",\"app_breadcrumb_color\":\"AC68FF\",\"app_breadcrumb_overlay_opacity\":\"0.00\",\"app_google_map_status\":0,\"app_firebase_json_file\":\"69185257de210.json\",\"openai_api_key\":\"openai-api-key\",\"openai_text_model\":\"gpt-4o\",\"openai_image_model\":\"dall-e-3\",\"gemini_api_key\":\"hh\",\"gemini_text_model\":\"gemini-2.5-flash\",\"gemini_image_model\":\"imagen-4.0-generat-001\",\"pollinations_secret_key\":\"pollinations-secret-key\",\"pollinations_text_model\":\"gemini-fast\",\"pollinations_image_model\":\"flux\"}',93,'2026-04-20','2026-05-11',NULL,'2026-04-20 00:14:33','2026-05-12 07:58:56',NULL,NULL,NULL,'gemini',60000,60,0,0,0,0),
(55,204,19.99,'USD','$','Flutterwave','6a03332158b0a',1,0,0,NULL,NULL,NULL,86,'2026-05-12','2026-05-11',1,'2026-05-12 08:03:13','2026-05-12 08:03:52',NULL,NULL,NULL,'openai',20000,25,0,0,0,0),
(56,204,999,'USD','$','PayPal','6a03334854f51',1,0,0,NULL,NULL,NULL,93,'2026-05-12','2026-05-11',1,'2026-05-12 08:03:52','2026-05-12 08:04:23',NULL,NULL,NULL,'gemini',60000,60,0,0,0,0),
(57,204,19.99,'USD','$',NULL,'6a0333674ae36',1,0,0,NULL,NULL,NULL,86,'2026-05-12','2026-05-12',1,'2026-05-12 08:04:23','2026-05-12 23:32:17',NULL,NULL,NULL,'openai',20000,25,0,0,0,0),
(58,204,29.99,'USD','$',NULL,'6a033376ad26b',1,0,0,NULL,NULL,NULL,87,'9999-12-31','2026-07-13',1,'2026-05-12 08:04:38','2026-05-12 23:32:03',NULL,NULL,NULL,'gemini',35000,30,0,0,0,0),
(59,204,999,'USD','$',NULL,'6a040ce1a744c',1,0,0,NULL,NULL,NULL,93,'2026-05-13','9999-12-31',NULL,'2026-05-12 23:32:17','2026-05-12 23:32:17',NULL,NULL,NULL,'gemini',60000,60,0,0,0,0);
/*!40000 ALTER TABLE `memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_builders`
--

DROP TABLE IF EXISTS `menu_builders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_builders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `menus` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_builders`
--

LOCK TABLES `menu_builders` WRITE;
/*!40000 ALTER TABLE `menu_builders` DISABLE KEYS */;
INSERT INTO `menu_builders` VALUES
(7,20,'[{\"text\":\"Home\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"type\":\"listings\",\"text\":\"Listings\",\"target\":\"_self\"},{\"text\":\"Pricing\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"Vendors\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"vendors\"},{\"text\":\"Shop\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"shop\",\"children\":[{\"text\":\"Cart\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"cart\"},{\"text\":\"Checkout\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"checkout\"}]},{\"text\":\"Pages\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"custom\",\"children\":[{\"text\":\"Blog\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"blog\"},{\"text\":\"FAQ\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"About Us\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"about-us\"},{\"text\":\"Terms & Condition\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"terms-&-condition\"},{\"text\":\"Privacy Policy\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"privacy-policy\"}]},{\"text\":\"Contact\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"}]','2023-08-17 03:19:12','2025-05-14 06:25:29'),
(8,21,'[{\"text\":\"بيت\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"text\":\"القوائم\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"listings\"},{\"text\":\"التسعير\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"الباعة\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"vendors\"},{\"text\":\"محل\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"shop\",\"children\":[{\"text\":\"عربة التسوق\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"cart\"},{\"text\":\"الدفع\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"checkout\"}]},{\"text\":\"الصفحات\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_blank\",\"title\":\"\",\"type\":\"custom\",\"children\":[{\"text\":\"مدونة\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"blog\"},{\"text\":\"التعليمات\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"معلومات عنا\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"about-us\"},{\"text\":\"سياسة الخصوصية\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"سياسة-الخصوصية\"},{\"text\":\"الأحكام والشروط\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"الأحكام-والشروط\"}]},{\"text\":\"اتصال\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"}]','2023-08-17 03:19:32','2025-01-19 23:05:03'),
(10,23,'[{\"text\":\"Home\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"text\":\"Listings\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"listings\"},{\"text\":\"Pricing\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"Vendors\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"vendors\"},{\"text\":\"Shop\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"shop\"},{\"text\":\"Blog\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"blog\"},{\"text\":\"FAQ\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"About Us\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"about-us\"},{\"text\":\"Contact\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"}]','2026-06-24 02:33:08','2026-06-24 02:33:08'),
(11,24,'[{\"text\":\"Home\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"text\":\"Listings\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"listings\"},{\"text\":\"Pricing\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"Vendors\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"vendors\"},{\"text\":\"Shop\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"shop\"},{\"text\":\"Blog\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"blog\"},{\"text\":\"FAQ\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"About Us\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"about-us\"},{\"text\":\"Contact\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"}]','2026-06-24 02:47:26','2026-06-24 02:47:26');
/*!40000 ALTER TABLE `menu_builders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2023_10_19_031727_create_listing_sections_table',1),
(2,'2023_10_19_035156_pacakge_section',2),
(3,'2023_11_13_042845_v',3),
(4,'2023_11_13_042942_listing_category',3),
(5,'2023_11_13_044154_create_settings_table',3),
(6,'2023_11_13_071453_aminites',4),
(7,'2023_11_14_025059_listing_images',5),
(8,'2023_11_15_025019_listings',6),
(9,'2023_11_15_025156_listing_contents',6),
(10,'2023_11_16_033741_listing_features',7),
(11,'2023_11_20_062648_listing_reviews',8),
(12,'2023_11_21_090259_messages',9),
(13,'2023_11_21_091821_listing_messages',10),
(14,'2023_11_22_040920_listing_social_media',11),
(15,'2023_11_23_034340_listing_products',12),
(16,'2023_11_23_034430_listing_products_content',12),
(17,'2023_11_23_034512_listingproductimages',12),
(18,'2023_11_26_031913_business_hours',13),
(19,'2023_12_02_045705_listing_faq',14),
(20,'2023_12_05_033837_listing_feature_charges',15),
(21,'2023_12_05_081415_feature_orders',16),
(22,'2023_12_13_050545_video_sections',17),
(23,'2023_12_13_095353_location_section',18),
(24,'2023_12_17_033638_countries',19),
(25,'2023_12_17_044738_states',20),
(26,'2023_12_17_064230_cities',21),
(27,'2023_12_24_031950_product_messages',22),
(28,'2024_01_10_033406_listingspecificationcontents',23),
(29,'2024_03_27_022811_herosections',24),
(33,'2024_09_21_023134_add_new_9_payment_gateways_into_payment_gateways_table',25),
(34,'2021_02_01_030511_create_payment_invoices_table',26),
(35,'2024_10_02_054621_colum_change_type_in_listing_contents_table',27),
(36,'2024_10_02_055839_chang_colum_type_in_seos_table',28),
(37,'2024_10_14_062259_add_a_colum_to_the_memberships_table',29),
(38,'2024_10_14_083647_add_conversation_id_to_product_orders_table',30),
(39,'2024_10_15_035325_add_a_colum_cities',31),
(40,'2024_10_15_064417_add_a_colum_listing_contents',32),
(42,'2024_10_15_083427_add_a_colum_to_basic_settings',33),
(43,'2024_10_28_043254_three_colum_added_basic_settings',34),
(44,'2024_11_07_081919_add_invoice_colum_in_memberships_table',35),
(45,'2024_11_07_084745_add_colum_vendors_table_and_admins_table',36),
(46,'2025_01_14_041000_add_conversation_id_to_feature_orders_table',37),
(47,'2025_09_23_090816_create_forms_table',38),
(48,'2025_09_23_091028_create_form_inputs_table',39),
(49,'2025_09_23_112845_create_forms_table',40),
(50,'2025_09_23_082541_create_claim_listings_table',41),
(51,'2025_10_10_055102_modify_product_id_foreign_on_product_contents_table',42),
(52,'2025_10_10_063904_alter_product_contents_make_product_category_id_nullable',43),
(53,'2025_10_14_072622_create_withdraws_table',44),
(54,'2025_10_14_073517_create_withdraw_method_inputs_table',45),
(55,'2025_10_14_074202_create_withdraw_method_options_table',46),
(56,'2025_10_14_080023_create_withdraw_payment_methods_table',47),
(57,'2025_10_23_064107_add_redemption_fields_to_claim_listings_table',48),
(58,'2019_12_14_000001_create_personal_access_tokens_table',49),
(59,'2025_11_03_080928_add_columns_to_existing_tables',49),
(60,'2025_11_03_112159_transfer_listing_products_to_products',50),
(62,'2025_11_11_130153_add_column_to_basic_settings',51),
(63,'2025_11_11_123006_create_mobile_interface_settings_table',52),
(64,'2025_11_15_102259_add_column_online_gateways',53),
(67,'2025_11_18_090332_add_column_to_mobile_interface',54),
(68,'2025_10_18_124132_create_fcm_tokens_table',55),
(69,'2025_12_04_081914_add_three_colum_to_fcm_tokens',55),
(70,'2025_12_04_090431_add_a_colum_to_product_orders_table',55),
(71,'2025_12_07_091718_add_a_colum_to_listing_categories_table',56),
(72,'2026_03_04_064304_create_token_wallets_table',57),
(73,'2026_03_04_074027_add_ai_columns_to_packages_table',58),
(74,'2026_03_04_074729_add_ai_provider_columns_to_basic_settings_table',59),
(75,'2026_03_07_054612_add_columns_to_memberships_table',60),
(76,'2026_05_11_113337_create_vendor_devices_table',61),
(77,'2026_05_11_114519_create_vendor_notifications_table',61);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_interface_settings`
--

DROP TABLE IF EXISTS `mobile_interface_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobile_interface_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `category_listing_section_title` varchar(255) DEFAULT NULL,
  `featured_listing_section_title` varchar(255) DEFAULT NULL,
  `banner_background_image` varchar(255) DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `banner_title` varchar(255) DEFAULT NULL,
  `banner_button_text` varchar(255) DEFAULT NULL,
  `banner_button_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_interface_settings`
--

LOCK TABLES `mobile_interface_settings` WRITE;
/*!40000 ALTER TABLE `mobile_interface_settings` DISABLE KEYS */;
INSERT INTO `mobile_interface_settings` VALUES
(1,20,'Categories','Featured Listings','6918478ed97df.png','691847a0c9b2e.png','Explore Most Popular Listing Items','Listings','/listing',NULL,NULL),
(2,21,'فئات','القوائم المميزة','693644a142a3e.png','693644a142f81.png','استكشف العناصر الأكثر شعبية في القائمة','القوائم','/listing',NULL,NULL);
/*!40000 ALTER TABLE `mobile_interface_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offline_gateways`
--

DROP TABLE IF EXISTS `offline_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `offline_gateways` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `short_description` text DEFAULT NULL,
  `instructions` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 -> gateway is deactive, 1 -> gateway is active.',
  `has_attachment` tinyint(1) NOT NULL COMMENT '0 -> do not need attachment, 1 -> need attachment.',
  `serial_number` mediumint(8) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offline_gateways`
--

LOCK TABLES `offline_gateways` WRITE;
/*!40000 ALTER TABLE `offline_gateways` DISABLE KEYS */;
INSERT INTO `offline_gateways` VALUES
(14,'Citibank','A pioneer of both the credit card industry and automated teller machines, Citibank – formerly the City Bank of New York.','',1,0,1,'2024-05-07 22:05:24','2024-05-07 22:05:24'),
(15,'Bank of America','Bank of America has 4,265 branches in the country, only about 700 fewer than Chase. It started as a small institution serving immigrants in San Francisco.','',1,1,2,'2024-05-07 22:06:01','2024-05-07 22:06:01');
/*!40000 ALTER TABLE `offline_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `online_gateways`
--

DROP TABLE IF EXISTS `online_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `online_gateways` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `information` mediumtext NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `mobile_status` tinyint(4) NOT NULL DEFAULT 0,
  `mobile_information` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `online_gateways`
--

LOCK TABLES `online_gateways` WRITE;
/*!40000 ALTER TABLE `online_gateways` DISABLE KEYS */;
INSERT INTO `online_gateways` VALUES
(1,'PayPal','paypal','{\"sandbox_status\":\"1\",\"client_id\":\"xxxxx\",\"client_secret\":\"xxxxx\"}',1,1,'{\"sandbox_status\":\"1\",\"client_id\":\"fdffd\",\"client_secret\":\"fdfdfdfdf\"}'),
(2,'Instamojo','instamojo','{\"sandbox_status\":\"0\",\"key\":\"t\",\"token\":\"t\"}',0,1,'{\"sandbox_status\":\"1\",\"key\":\"fdfdfd\",\"token\":\"fdfdf\"}'),
(3,'Paystack','paystack','{\"key\":\"t\"}',0,1,'{\"key\":\"rr\"}'),
(4,'Flutterwave','flutterwave','{\"public_key\":\"t\",\"secret_key\":\"t\"}',1,1,'{\"public_key\":\"fdfdfdf\",\"secret_key\":\"fdfdfdf\"}'),
(5,'Razorpay','razorpay','{\"key\":\"t\",\"secret\":\"t\"}',0,1,'{\"key\":\"Quia commodi perfere\",\"secret\":\"Consequatur ut poss\"}'),
(6,'MercadoPago','mercadopago','{\"sandbox_status\":\"0\",\"token\":\"t\"}',0,1,'{\"sandbox_status\":\"1\",\"token\":\"Sed quos fugiat in s\"}'),
(7,'Mollie','mollie','{\"key\":\"xxxxx\"}',1,1,'{\"key\":\"fdfdfdff\"}'),
(10,'Stripe','stripe','{\"key\":\"t\",\"secret\":\"t\"}',0,1,'{\"key\":\"11\",\"secret\":\"11\"}'),
(11,'Paytm','paytm','{\"environment\":\"production\",\"merchant_key\":\"t\",\"merchant_mid\":\"t\",\"merchant_website\":\"t\",\"industry_type\":\"t\"}',0,1,'{\"environment\":\"test\",\"merchant_key\":\"fggfgfg\",\"merchant_mid\":\"gfgfggf\",\"merchant_website\":\"gfgfgf\",\"industry_type\":\"gfgfgfg\"}'),
(21,'Authorize.net','authorize.net','{\"login_id\":\"t\",\"transaction_key\":\"t\",\"public_key\":\"t\",\"sandbox_check\":\"0\",\"text\":\"Pay via your Authorize.net account.\"}',0,1,'{\"login_id\":\"11\",\"transaction_key\":\"11\",\"public_key\":\"11\",\"sandbox_check\":\"1\",\"text\":\"Pay via your Authorize.net account.\"}'),
(49,'PhonePe','phonepe','{\"merchant_id\":\"xxxx\",\"sandbox_status\":\"1\",\"salt_key\":\"xxx\",\"salt_index\":\"1\"}',1,1,'{\"merchant_id\":\"dfdfdf\",\"sandbox_status\":\"1\",\"salt_key\":\"dfdfdf\",\"salt_index\":\"1\"}'),
(50,'Perfect Money','perfect_money','{\"perfect_money_wallet_id\":\"t\"}',1,1,'{\"perfect_money_wallet_id\":\"rrr\",\"perfect_money_password\":\"trtrt\",\"perfect_money_name\":\"trtrt\"}'),
(51,'Xendit','xendit','{\"secret_key\":\"1\"}',1,1,'{\"secret_key\":\"Consequatur alias ex\"}'),
(52,'Myfatoorah','myfatoorah','{\"token\":\"t\",\"sandbox_status\":\"0\"}',0,1,'{\"token\":\"11\",\"sandbox_status\":\"1\"}'),
(53,'Yoco','yoco','{\"secret_key\":\"t\"}',0,1,'{\"secret_key\":\"fdfdffd\"}'),
(54,'Toyyibpay','toyyibpay','{\"sandbox_status\":\"0\",\"secret_key\":\"t\",\"category_code\":\"t\"}',0,1,'{\"sandbox_status\":\"1\",\"secret_key\":\"11\",\"category_code\":\"11\"}'),
(55,'Paytabs','paytabs','{\"server_key\":\"t\",\"profile_id\":\"t\",\"country\":\"global\",\"api_endpoint\":\"t\"}',0,1,'{\"server_key\":\"fggffg\",\"profile_id\":\"gfgfggf\",\"country\":\"global\",\"api_endpoint\":\"gfgfg\"}'),
(56,'Iyzico','iyzico','{\"api_key\":\"t\",\"secrect_key\":\"t\",\"iyzico_mode\":\"0\"}',0,1,'{\"api_key\":\"fdfdf\",\"secrect_key\":\"fdfdfdf\",\"iyzico_mode\":\"1\"}'),
(57,'Midtrans','midtrans','{\"is_production\":\"1\",\"server_key\":\"t\"}',0,1,'{\"is_production\":\"1\",\"server_key\":\"11\"}'),
(58,'Authorize.net','authorize.net','',0,0,''),
(59,'Monnify','monnify','',0,1,'{\"sandbox_status\":\"1\",\"api_key\":\"11\",\"secret_key\":\"11\",\"wallet_account_number\":\"11\"}'),
(60,'NowPayments','now_payments','',0,1,'{\"api_key\":\"fdffdffd\"}');
/*!40000 ALTER TABLE `online_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_sections`
--

DROP TABLE IF EXISTS `package_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` text DEFAULT NULL,
  `button_text` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_sections`
--

LOCK TABLES `package_sections` WRITE;
/*!40000 ALTER TABLE `package_sections` DISABLE KEYS */;
INSERT INTO `package_sections` VALUES
(1,20,'Most Affordable Package',NULL,NULL,'2023-10-18 22:02:00','2024-05-06 03:16:31'),
(2,21,'الحزمة الأكثر بأسعار معقولة',NULL,NULL,'2023-10-18 22:02:18','2024-05-06 03:16:42');
/*!40000 ALTER TABLE `package_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `packages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `price` double NOT NULL DEFAULT 0,
  `icon` varchar(255) DEFAULT NULL,
  `term` varchar(255) DEFAULT NULL,
  `number_of_listing` int(11) DEFAULT 0,
  `recommended` int(11) DEFAULT NULL,
  `number_of_images_per_listing` int(11) DEFAULT 0,
  `number_of_products` int(11) DEFAULT 0,
  `number_of_images_per_products` int(11) DEFAULT 0,
  `number_of_amenities_per_listing` int(11) DEFAULT 0,
  `number_of_additional_specification` int(11) DEFAULT 0,
  `number_of_social_links` int(11) DEFAULT 0,
  `number_of_faq` int(11) DEFAULT 0,
  `custom_features` longtext DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `features` text DEFAULT NULL,
  `ai_engine` varchar(50) DEFAULT NULL,
  `ai_token_limit` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ai_image_limit` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` VALUES
(85,'Silver','silver',9,'fas fa-gift iconpicker-component','monthly',3,0,3,3,3,3,3,3,3,'',1,'[\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"AI Content & Image Generator\"]','gemini',10000,10,'2024-04-30 23:00:29','2026-03-09 01:45:47'),
(86,'Gold','gold',19.99,'fas fa-gift iconpicker-component','monthly',5,1,5,5,5,5,5,5,5,'',1,'[\"Listing Enquiry Form\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"WhatsApp\",\"AI Content & Image Generator\"]','openai',20000,25,'2024-04-30 23:01:21','2026-03-09 01:22:01'),
(87,'Platinum','platinum',29.99,'fas fa-gift iconpicker-component','monthly',10,0,10,10,10,10,10,10,10,'',1,'[\"Listing Enquiry Form\",\"Video\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"Messenger\",\"WhatsApp\",\"Telegram\",\"Tawk.To\",\"AI Content & Image Generator\"]','gemini',35000,30,'2024-04-30 23:02:16','2026-03-09 01:22:43'),
(88,'Silver','silver',99,'fas fa-gift iconpicker-component','yearly',3,0,3,3,10,3,3,3,3,'',1,'[\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Product Enquiry Form\",\"AI Content & Image Generator\"]','gemini',25000,25,'2024-04-30 23:03:30','2026-03-09 01:24:13'),
(89,'Gold','gold',199,'fas fa-gift iconpicker-component','yearly',5,1,5,5,5,5,5,5,5,'',1,'[\"Listing Enquiry Form\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"WhatsApp\",\"AI Content & Image Generator\"]','openai',35000,33,'2024-04-30 23:04:31','2026-03-09 01:25:13'),
(90,'Platinum','platinum',299,'fas fa-gift iconpicker-component','yearly',10,0,10,10,10,10,10,10,10,'',1,'[\"Listing Enquiry Form\",\"Video\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"Messenger\",\"WhatsApp\",\"Telegram\",\"Tawk.To\",\"AI Content & Image Generator\"]','gemini',50000,48,'2024-04-30 23:05:31','2026-03-09 01:26:08'),
(91,'Silver','silver',399,'fas fa-gift iconpicker-component','lifetime',3,0,3,3,3,3,3,3,3,'',1,'[\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"AI Content & Image Generator\"]','openai',30000,30,'2024-04-30 23:08:56','2026-03-09 01:29:30'),
(92,'Gold','gold',699,'fas fa-gift iconpicker-component','lifetime',5,1,5,5,5,5,5,5,5,'',1,'[\"Listing Enquiry Form\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"WhatsApp\",\"AI Content & Image Generator\"]','openai',40000,40,'2024-04-30 23:10:57','2026-03-09 01:27:47'),
(93,'Platinum','platinum',999,'fas fa-gift iconpicker-component','lifetime',10,0,10,10,10,10,10,10,10,'',1,'[\"Listing Enquiry Form\",\"Video\",\"Amenities\",\"Feature\",\"Social Links\",\"FAQ\",\"Business Hours\",\"Products\",\"Product Enquiry Form\",\"Messenger\",\"WhatsApp\",\"Telegram\",\"Tawk.To\",\"AI Content & Image Generator\"]','gemini',60000,60,'2024-04-30 23:11:40','2026-03-09 01:28:15');
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_contents`
--

DROP TABLE IF EXISTS `page_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_contents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `page_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` blob NOT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_contents_language_id_foreign` (`language_id`),
  KEY `page_contents_page_id_foreign` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_contents`
--

LOCK TABLES `page_contents` WRITE;
/*!40000 ALTER TABLE `page_contents` DISABLE KEYS */;
INSERT INTO `page_contents` VALUES
(45,20,21,'Terms & Condition','terms-&-condition','<p>Welcome to <strong>Bulistio</strong>!</p>\r\n<p>These terms and conditions outline the rules and regulations for the use of Bulistio\'s Website.</p>\r\n<p>By accessing this website we assume you accept these terms and conditions. Do not continue to use Bulistio if you do not agree to take all of the terms and conditions stated on this page.</p>\r\n<p>The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: \"Client\", \"You\" and \"Your\" refers to you, the person log on this website and compliant to the Company\'s terms and conditions. \"The Company\", \"Ourselves\", \"We\", \"Our\" and \"Us\", refers to our Company. \"Party\", \"Parties\", or \"Us\", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client\'s needs in respect of provision of the Company\'s stated services, in accordance with and subject to, prevailing law of us. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.</p>\r\n<h4><strong>Cookies</strong></h4>\r\n<p>We employ the use of cookies. By accessing Bulistio, you agreed to use cookies in agreement with the Bulistio\'s Privacy Policy.</p>\r\n<p>Most interactive websites use cookies to let us retrieve the user\'s details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.</p>\r\n<h4><strong>License</strong></h4>\r\n<p>Unless otherwise stated, Bulistio and/or its licensors own the intellectual property rights for all material on Bulistio. All intellectual property rights are reserved. You may access this from Bulistio for your own personal use subjected to restrictions set in these terms and conditions.</p>\r\n<p>You must not:</p>\r\n<ul>\r\n<li>Republish material from Bulistio</li>\r\n<li>Sell, rent or sub-license material from Bulistio</li>\r\n<li>Reproduce, duplicate or copy material from Bulistio</li>\r\n<li>Redistribute content from Bulistio</li>\r\n</ul>\r\n<p>This Agreement shall begin on the date hereof. Our Terms and Conditions were created with the help of the <a href=\"https://www.termsandconditionsgenerator.com/\">Free Terms and Conditions Generator</a>.</p>\r\n<p>Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Bulistio does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of Bulistio,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Bulistio shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.</p>\r\n<p>Bulistio reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.</p>\r\n<p>You warrant and represent that:</p>\r\n<ul>\r\n<li>You are entitled to post the Comments on our website and have all necessary licenses and consents to do so;</li>\r\n<li>The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;</li>\r\n<li>The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy</li>\r\n<li>The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.</li>\r\n</ul>\r\n<p>You hereby grant Bulistio a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.</p>\r\n<h4><strong>Hyperlinking to our Content</strong></h4>\r\n<p>The following organizations may link to our Website without prior written approval:</p>\r\n<ul>\r\n<li>Government agencies;</li>\r\n<li>Search engines;</li>\r\n<li>News organizations;</li>\r\n<li>Online directory distributors may link to our Website in the same manner as they hyperlink to the Websites of other listed businesses; and</li>\r\n<li>System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.</li>\r\n</ul>\r\n<p>These organizations may link to our home page, to publications or to other Website information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party\'s site.</p>\r\n<p>We may consider and approve other link requests from the following types of organizations:</p>\r\n<ul>\r\n<li>commonly-known consumer and/or business information sources;</li>\r\n<li>dot.com community sites;</li>\r\n<li>associations or other groups representing charities;</li>\r\n<li>online directory distributors;</li>\r\n<li>internet portals;</li>\r\n<li>accounting, law and consulting firms; and</li>\r\n<li>educational institutions and trade associations.</li>\r\n</ul>\r\n<p>We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of Bulistio; and (d) the link is in the context of general resource information.</p>\r\n<p>These organizations may link to our home page so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party\'s site.</p>\r\n<p>If you are one of the organizations listed in paragraph 2 above and are interested in linking to our website, you must inform us by sending an e-mail to Bulistio. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.</p>\r\n<p>Approved organizations may hyperlink to our Website as follows:</p>\r\n<ul>\r\n<li>By use of our corporate name; or</li>\r\n<li>By use of the uniform resource locator being linked to; or</li>\r\n<li>By use of any other description of our Website being linked to that makes sense within the context and format of content on the linking party\'s site.</li>\r\n</ul>\r\n<p>No use of Bulistio\'s logo or other artwork will be allowed for linking absent a trademark license agreement.</p>\r\n<h4><strong>iFrames</strong></h4>\r\n<p>Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our Website.</p>\r\n<h4><strong>Content Liability</strong></h4>\r\n<p>We shall not be hold responsible for any content that appears on your Website. You agree to protect and defend us against all claims that is rising on your Website. No link(s) should appear on any Website that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.</p>\r\n<h4><strong>Reservation of Rights</strong></h4>\r\n<p>We reserve the right to request that you remove all links or any particular link to our Website. You approve to immediately remove all links to our Website upon request. We also reserve the right to amen these terms and conditions and it\'s linking policy at any time. By continuously linking to our Website, you agree to be bound to and follow these linking terms and conditions.</p>\r\n<h4><strong>Removal of links from our website</strong></h4>\r\n<p>If you find any link on our Website that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.</p>\r\n<p>We do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.</p>\r\n<h4><strong>Disclaimer</strong></h4>\r\n<p>To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our website and the use of this website. Nothing in this disclaimer will:</p>\r\n<ul>\r\n<li>limit or exclude our or your liability for death or personal injury;</li>\r\n<li>limit or exclude our or your liability for fraud or fraudulent misrepresentation;</li>\r\n<li>limit any of our or your liabilities in any way that is not permitted under applicable law; or</li>\r\n<li>exclude any of our or your liabilities that may not be excluded under applicable law.</li>\r\n</ul>\r\n<p>The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.</p>\r\n<p>As long as the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature.</p>',NULL,NULL,'2023-08-19 23:52:10','2024-05-23 04:53:47'),
(46,21,21,'الأحكام والشروط','الأحكام-والشروط','<p>مرحبًا بك في قائمة السيارات!</p>\r\n<p>تحدد هذه الشروط والأحكام القواعد واللوائح الخاصة باستخدام موقع الويب الخاص بقائمة السيارات.</p>\r\n<p>من خلال الوصول إلى هذا الموقع ، نفترض أنك تقبل هذه الشروط والأحكام. لا تستمر في استخدام قائمة السيارات إذا كنت لا توافق على أخذ جميع الشروط والأحكام المذكورة في هذه الصفحة.</p>\r\n<p>تنطبق المصطلحات التالية على هذه الشروط والأحكام وبيان الخصوصية وإشعار إخلاء المسؤولية وجميع الاتفاقيات: يشير مصطلح \"العميل\" و \"أنت\" و \"الخاص بك\" إليك ، والشخص الذي يقوم بتسجيل الدخول إلى هذا الموقع الإلكتروني ومتوافق مع شروط وأحكام الشركة. تشير \"الشركة\" و \"أنفسنا\" و \"نحن\" و \"لنا\" و \"نحن\" إلى شركتنا. يشير \"الطرف\" أو \"الأطراف\" أو \"نحن\" إلى كل من العميل وأنفسنا. تشير جميع الشروط إلى العرض والقبول والنظر في الدفع اللازم للاضطلاع بعملية مساعدتنا للعميل بالطريقة الأنسب للغرض الصريح المتمثل في تلبية احتياجات العميل فيما يتعلق بتوفير خدمات الشركة المعلنة ، وفقًا لـ وتخضع للقانون السائد منا. أي استخدام للمصطلحات المذكورة أعلاه أو غيرها من الكلمات في صيغة المفرد والجمع و / أو هو / هي أو هم ، يتم اعتباره قابلاً للتبادل وبالتالي يشير إلى نفسه.</p>\r\n<p>بسكويت</p>\r\n<p>نحن نوظف استخدام ملفات تعريف الارتباط. من خلال الوصول إلى قائمة السيارات ، فإنك توافق على استخدام ملفات تعريف الارتباط بالاتفاق مع سياسة الخصوصية الخاصة بقائمة السيارات.</p>\r\n<p>تستخدم معظم مواقع الويب التفاعلية ملفات تعريف الارتباط للسماح لنا باسترداد تفاصيل المستخدم لكل زيارة. يستخدم موقعنا ملفات تعريف الارتباط لتمكين وظائف مناطق معينة لتسهيل زيارة الأشخاص لموقعنا. قد يستخدم بعض الشركاء التابعين / المعلنين أيضًا ملفات تعريف الارتباط.</p>',NULL,NULL,'2023-08-19 23:52:10','2023-08-19 23:52:10'),
(47,20,22,'Privacy Policy','privacy-policy','<p>At Bulistio, accessible from <a href=\"https://codecanyon.kreativdev.com/carlisting\">https://codecanyon.kreativdev.com/bulistio</a>, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Bulistio and how we use it.</p>\r\n<p>If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.</p>\r\n<p>This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in Bulistio. This policy is not applicable to any information collected offline or via channels other than this website.</p>\r\n<p><strong>Consent</strong></p>\r\n<p>By using our website, you hereby consent to our Privacy Policy and agree to its terms.</p>\r\n<p><strong>Information We Collect</strong></p>\r\n<p>The personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information.</p>\r\n<p>If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.</p>\r\n<p>When you register for an account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.</p>\r\n<p><strong>How We Use Your Information</strong></p>\r\n<p>We use the information we collect in various ways, including to:</p>\r\n<ul>\r\n<li>Provide, operate, and maintain our website</li>\r\n<li>Improve, personalize, and expand our website</li>\r\n<li>Understand and analyze how you use our website</li>\r\n<li>Develop new products, services, features, and functionality</li>\r\n<li>Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the website, and for marketing and promotional purposes</li>\r\n<li>Send you emails</li>\r\n<li>Find and prevent fraud</li>\r\n</ul>\r\n<p><strong>Log Files</strong></p>\r\n<p>Bulistio follows a standard procedure of using log files. These files log visitors when they visit websites. All hosting companies do this and a part of hosting services\' analytics. The information collected by log files includes internet protocol (IP) addresses, browser type, Internet Service Provider (ISP), date and time stamp, referring/exit pages, and possibly the number of clicks. These are not linked to any information that is personally identifiable. The purpose of the information is for analyzing trends, administering the site, tracking users\' movement on the website, and gathering demographic information.</p>\r\n<p><strong>Cookies and Web Beacons</strong></p>\r\n<p>Like any other website, Bulistio uses \"cookies\". These cookies are used to store information including visitors\' preferences, and the pages on the website that the visitor accessed or visited. The information is used to optimize the users\' experience by customizing our web page content based on visitors\' browser type and/or other information.</p>\r\n<p><strong>Google DoubleClick DART Cookie</strong></p>\r\n<p>Google is one of a third-party vendor on our site. It also uses cookies, known as DART cookies, to serve ads to our site visitors based upon their visit to and other sites on the internet. However, visitors may choose to decline the use</p>','privacy policy','privacy policy','2023-08-19 23:56:10','2024-05-23 04:48:39'),
(48,21,22,'سياسة الخصوصية','سياسة-الخصوصية','<p>في Bulistio، الذي يمكن الوصول إليه من https://codecanyon.kreativdev.com/bulistio، إحدى أولوياتنا الرئيسية هي خصوصية زوارنا. تحتوي وثيقة سياسة الخصوصية هذه على أنواع المعلومات التي يتم جمعها وتسجيلها بواسطة <strong>Bulistio </strong>وكيفية استخدامها.</p>\r\n<p>إذا كانت لديك أسئلة إضافية أو كنت بحاجة إلى مزيد من المعلومات حول سياسة الخصوصية الخاصة بنا، فلا تتردد في الاتصال بنا.</p>\r\n<p>تنطبق سياسة الخصوصية هذه فقط على أنشطتنا عبر الإنترنت وهي صالحة لزوار موقعنا فيما يتعلق بالمعلومات التي شاركوها و/أو جمعوها في <strong>Bulistio</strong>. لا تنطبق هذه السياسة على أي معلومات يتم جمعها دون اتصال بالإنترنت أو عبر قنوات أخرى غير هذا الموقع.</p>\r\n<p>إذا كانت لديك أسئلة إضافية أو كنت بحاجة إلى مزيد من المعلومات حول سياسة الخصوصية الخاصة بنا، فلا تتردد في الاتصال بنا.</p>\r\n<p>تنطبق سياسة الخصوصية هذه فقط على أنشطتنا عبر الإنترنت وهي صالحة لزوار موقعنا فيما يتعلق بالمعلومات التي شاركوها و/أو جمعوها في Bulistio. لا تنطبق هذه السياسة على أي معلومات يتم جمعها دون اتصال بالإنترنت أو عبر قنوات أخرى غير هذا الموقع.</p>\r\n<p><strong>موافقة</strong></p>\r\n<p>باستخدام موقعنا، فإنك توافق بموجبه على سياسة الخصوصية الخاصة بنا وتوافق على شروطها.</p>\r\n<p><strong>المعلومات التي نجمعها</strong></p>\r\n<p>سيتم توضيح المعلومات الشخصية التي يُطلب منك تقديمها، وأسباب مطالبتك بتقديمها، لك عندما نطلب منك تقديم معلوماتك الشخصية.</p>\r\n<p>إذا اتصلت بنا مباشرة، فقد نتلقى معلومات إضافية عنك مثل اسمك وعنوان بريدك الإلكتروني ورقم هاتفك ومحتويات الرسالة و/أو المرفقات التي قد ترسلها إلينا، وأي معلومات أخرى قد تختار تقديمها.</p>\r\n<p>عندما تقوم بالتسجيل للحصول على حساب، قد نطلب معلومات الاتصال الخاصة بك، بما في ذلك عناصر مثل الاسم واسم الشركة والعنوان وعنوان البريد الإلكتروني ورقم الهاتف.</p>\r\n<p><strong>كيف نستخدم معلوماتك</strong></p>\r\n<p>نحن نستخدم المعلومات التي نجمعها بطرق مختلفة، بما في ذلك:</p>\r\n<ul>\r\n<li>توفير وتشغيل وصيانة موقعنا</li>\r\n<li>توفير وتشغيل وصيانة موقعنا</li>\r\n<li>توفير وتشغيل وصيانة موقعنا</li>\r\n<li>توفير وتشغيل وصيانة موقعنا</li>\r\n<li>توفير وتشغيل وصيانة موقعناتوفير وتشغيل وصيانة موقعنا</li>\r\n<li>توفير وتشغيل وصيانة موقعنا</li>\r\n<li>توفير وتشغيل وصيانة موقعنا</li>\r\n</ul>\r\n<p><strong>ملفات السجل</strong></p>\r\n<p>يتبع Bulistio الإجراء القياسي لاستخدام ملفات السجل. تقوم هذه الملفات بتسجيل الزوار عند زيارتهم لمواقع الويب. جميع شركات الاستضافة تفعل ذلك وجزء من تحليلات خدمات الاستضافة. تتضمن المعلومات التي تم جمعها بواسطة ملفات السجل عناوين بروتوكول الإنترنت (IP)، ونوع المتصفح، وموفر خدمة الإنترنت (ISP)، وختم التاريخ والوقت، وصفحات الإحالة/الخروج، وربما عدد النقرات. ولا ترتبط هذه بأي معلومات تحدد هويتك الشخصية. الغرض من المعلومات هو تحليل الاتجاهات وإدارة الموقع وتتبع حركة المستخدمين على الموقع وجمع المعلومات الديموغرافية.</p>\r\n<p> </p>',NULL,NULL,'2023-08-19 23:56:10','2024-05-23 04:53:13');
/*!40000 ALTER TABLE `page_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_headings`
--

DROP TABLE IF EXISTS `page_headings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_headings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `listing_page_title` varchar(255) DEFAULT NULL,
  `blog_page_title` varchar(255) NOT NULL,
  `contact_page_title` varchar(255) NOT NULL,
  `products_page_title` varchar(255) NOT NULL,
  `error_page_title` varchar(255) NOT NULL,
  `pricing_page_title` varchar(255) DEFAULT NULL,
  `faq_page_title` varchar(255) NOT NULL,
  `forget_password_page_title` varchar(255) NOT NULL,
  `vendor_forget_password_page_title` varchar(255) DEFAULT NULL,
  `login_page_title` varchar(255) NOT NULL,
  `signup_page_title` varchar(255) NOT NULL,
  `vendor_login_page_title` varchar(255) DEFAULT NULL,
  `vendor_signup_page_title` varchar(255) DEFAULT NULL,
  `cart_page_title` varchar(255) NOT NULL,
  `checkout_page_title` varchar(255) NOT NULL,
  `vendor_page_title` varchar(255) DEFAULT NULL,
  `about_us_title` varchar(255) DEFAULT NULL,
  `wishlist_page_title` varchar(255) DEFAULT NULL,
  `dashboard_page_title` varchar(255) DEFAULT NULL,
  `orders_page_title` varchar(255) DEFAULT NULL,
  `support_ticket_page_title` varchar(255) DEFAULT NULL,
  `support_ticket_create_page_title` varchar(255) DEFAULT NULL,
  `change_password_page_title` varchar(255) DEFAULT NULL,
  `edit_profile_page_title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_headings_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_headings`
--

LOCK TABLES `page_headings` WRITE;
/*!40000 ALTER TABLE `page_headings` DISABLE KEYS */;
INSERT INTO `page_headings` VALUES
(9,20,'Listings','Blog','Contact','Products','404','Pricing','FAQ','Forget Password','Forget Password','Login','Signup','Vendor Login','Vendor Signup','Cart','Checkout','Vendors','About Us','Wishlists','Dashboard','Orders','Support Tickets','Create a Support Ticket','Change Password','Edit Profile','2023-08-27 01:23:22','2024-01-01 04:49:59'),
(10,21,'القوائم','مدونة','اتصال','منتجات','404','التسعير','التعليمات','نسيت كلمة المرور','نسيت كلمة المرور','تسجيل الدخول','اشتراك','تسجيل دخول البائع','تسجيل البائع','عربة التسوق','الدفع','الباعة','معلومات عنا','قوائم الامنيات','لوحة القيادة','طلبات','تذاكر الدعم الفني','إنشاء تذكرة دعم','تغيير كلمة المرور','تعديل الملف الشخصي','2024-02-06 02:49:35','2024-02-06 02:49:35');
/*!40000 ALTER TABLE `page_headings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES
(21,1,'2023-08-19 23:52:10','2023-08-19 23:52:10'),
(22,1,'2023-08-19 23:56:10','2023-08-19 23:56:10');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
INSERT INTO `password_resets` VALUES
(8,'fahadahmadshemul@gmail.com','ktTRmy3rfZBfonez2MM80l9jZvEwYbaS',NULL),
(9,'fahadahmadshemul@gmail.com','LqksSbBPKGXCNF3hJ9a5Ghri3aX5973G',NULL),
(11,'divaf87260@canvect.com','$2y$10$SRL7m.QMdyayL5SFe8awLeL.CBBj0F.uOKmXUMycAxYI6eOut5UKW','2025-11-25 01:06:09'),
(12,'xisex41713@bablace.com','$2y$10$.hZ2zgB0UimYcM5v.Qs3V.PNnebEUkFl01uDQaU6Dg4nUY5qIfO3i','2025-11-25 03:52:47');
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_invoices`
--

DROP TABLE IF EXISTS `payment_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `InvoiceId` bigint(20) unsigned NOT NULL,
  `InvoiceStatus` varchar(255) NOT NULL,
  `InvoiceValue` varchar(255) NOT NULL,
  `Currency` varchar(255) NOT NULL,
  `InvoiceDisplayValue` varchar(255) NOT NULL,
  `TransactionId` bigint(20) unsigned NOT NULL,
  `TransactionStatus` varchar(255) NOT NULL,
  `PaymentGateway` varchar(255) NOT NULL,
  `PaymentId` bigint(20) unsigned NOT NULL,
  `CardNumber` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_invoices`
--

LOCK TABLES `payment_invoices` WRITE;
/*!40000 ALTER TABLE `payment_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES
(1,'App\\Models\\User',12,'unknown-device','c8006acf0bb4d6a329ad9a59532a63f568418e25866a64fcb5e8ff85cadae412','[\"*\"]',NULL,NULL,'2025-11-18 04:31:47','2025-11-18 04:31:47'),
(2,'App\\Models\\User',12,'unknown-device','4c9fc374d335fa93bd3a5727dea14cf0243bbbb2a51e65d9b97d5e68a8ceabd5','[\"*\"]',NULL,NULL,'2025-11-18 04:43:34','2025-11-18 04:43:34'),
(3,'App\\Models\\User',12,'unknown-device','eb5425f744d5864f276d379a60c3cea1416f05736f2bc90d26005f03471a8e4b','[\"*\"]',NULL,NULL,'2025-11-18 04:45:48','2025-11-18 04:45:48'),
(4,'App\\Models\\User',12,'unknown-device','d9248005bf545bba0b63be991488fc054980d6435ed18308f1dc1d34e017cbea','[\"*\"]',NULL,NULL,'2025-11-18 23:06:39','2025-11-18 23:06:39'),
(5,'App\\Models\\User',12,'unknown-device','ecd6e5802e44310da2847f0ffc343e67a2c2e94aafe141074d048ee619c5a5fe','[\"*\"]',NULL,NULL,'2025-11-19 00:22:19','2025-11-19 00:22:19'),
(7,'App\\Models\\User',12,'unknown-device','16de36e885d5b0db9f7769475cc17cb67513721a9525d6f4697b00c7f99c87e3','[\"*\"]','2025-11-24 02:19:51',NULL,'2025-11-19 05:24:26','2025-11-24 02:19:51'),
(8,'App\\Models\\User',12,'unknown-device','dfbdac84def64c35e7e0e33f4d79ebfe2a77eaffe41d4a640e504fb5c39aac79','[\"*\"]','2025-11-24 02:09:58',NULL,'2025-11-19 22:21:12','2025-11-24 02:09:58'),
(9,'App\\Models\\User',12,'unknown-device','22fa453ca7035f298cb0074be66fd616057836a46636503e0e02b7de1a82d9d0','[\"*\"]',NULL,NULL,'2025-11-23 22:54:42','2025-11-23 22:54:42'),
(10,'App\\Models\\User',12,'unknown-device','6b9268577ace09830b67ee9b86a39e562f3b6ae6b597d118215005187320c591','[\"*\"]','2025-11-23 23:33:27',NULL,'2025-11-23 23:13:05','2025-11-23 23:33:27'),
(11,'App\\Models\\User',12,'unknown-device','6fdfa599d1f3cebcdcbbcb9581faeccaa666d649162cc6b06427103ac46d06ff','[\"*\"]','2025-11-24 03:41:23',NULL,'2025-11-24 01:44:57','2025-11-24 03:41:23'),
(12,'App\\Models\\User',12,'unknown-device','81b45c2b07bb4f0f96c1c52bc78ed1123f63e671a75ee6863e2dbca00eb2494d','[\"*\"]',NULL,NULL,'2025-11-24 02:08:17','2025-11-24 02:08:17'),
(13,'App\\Models\\User',12,'unknown-device','a6caf8ce5ff380fe5bb2e346ff0ee0c1e8c545ed0edb7771d0080abf92f63c23','[\"*\"]',NULL,NULL,'2025-11-24 02:10:03','2025-11-24 02:10:03'),
(14,'App\\Models\\User',12,'unknown-device','de627959d542d602018de7f5381ca8a5c33dfa14fae1d407fdd3975e64eb690b','[\"*\"]',NULL,NULL,'2025-11-24 02:19:42','2025-11-24 02:19:42'),
(15,'App\\Models\\User',12,'unknown-device','401499b2e42b81477a9e02d2b9d11a50122a0a5c120acc1a64405a3287156abe','[\"*\"]','2025-11-24 03:38:18',NULL,'2025-11-24 03:27:09','2025-11-24 03:38:18'),
(16,'App\\Models\\User',12,'unknown-device','bc9679c9031f82b4285edd6e18f18ee8455cc6b7aea1ff13fac22e6764f396bc','[\"*\"]','2025-11-25 00:21:32',NULL,'2025-11-24 22:58:16','2025-11-25 00:21:32'),
(17,'App\\Models\\User',12,'unknown-device','3ec74aa08015eddfd5508de6105d2bca210b604157fe0fe66048bea9b1aeb2b3','[\"*\"]','2025-11-26 02:05:59',NULL,'2025-11-24 23:59:11','2025-11-26 02:05:59'),
(18,'App\\Models\\User',12,'unknown-device','0bc68b19595bd57773e871f398e40e90cbb836201e16079e1254c2aa94f5f6c6','[\"*\"]',NULL,NULL,'2025-11-26 01:57:38','2025-11-26 01:57:38'),
(19,'App\\Models\\User',12,'unknown-device','65ea6ce29a033da476bacbc0a56e547bfc0fdf0d886249c9f4167e2aeec9fb06','[\"*\"]','2025-12-06 22:55:05',NULL,'2025-12-06 22:53:17','2025-12-06 22:55:05'),
(20,'App\\Models\\User',12,'unknown-device','45102cf62127d5a58c4e010847beb289a9e26eaa738217f5d7bf9d072009a7a9','[\"*\"]','2025-12-07 22:01:17',NULL,'2025-12-07 22:00:59','2025-12-07 22:01:17'),
(21,'App\\Models\\User',12,'unknown-device','fadbfe50d37cdb98319b1679096d077e691edd152fc845c732024698958e4574','[\"*\"]','2025-12-12 21:47:01',NULL,'2025-12-12 21:44:16','2025-12-12 21:47:01'),
(22,'App\\Models\\Vendor',204,'vendor-token','185e2f7a3fd8da3ad869dbd5c9f3bf392f08c214f0f7b1ab5062048db25d4e06','[\"*\"]',NULL,NULL,'2026-04-05 01:01:00','2026-04-05 01:01:00'),
(23,'App\\Models\\Vendor',204,'vendor-token','3d47034dc4c9dc7b7d1c168d3401331e70e4317ab66159329d9d6726e63c3bc1','[\"*\"]',NULL,NULL,'2026-04-05 01:02:12','2026-04-05 01:02:12'),
(24,'App\\Models\\Vendor',204,'vendor-token','a6080342a4733eeab84b86deff1f5d437b8ac11bf3ebd79149a3e1b438ae6404','[\"*\"]',NULL,NULL,'2026-04-05 01:02:42','2026-04-05 01:02:42'),
(25,'App\\Models\\Vendor',204,'vendor-token','e21cd83554ed1e9b0b2c3188736bed62068378a903b8a6cadeafad4c4e6f848d','[\"*\"]',NULL,NULL,'2026-04-05 01:02:52','2026-04-05 01:02:52'),
(26,'App\\Models\\Vendor',204,'vendor-token','6af46222b7de737fbc470ab91cd21e5d802a247e044cdccc32ca99d659e1f23d','[\"*\"]','2026-04-05 03:49:48',NULL,'2026-04-05 01:03:46','2026-04-05 03:49:48'),
(27,'App\\Models\\Vendor',204,'vendor-token','7d78e15c4572c85f74f626006559e62dc223bd6e1736bf02f2fa7d60d2fce637','[\"*\"]',NULL,NULL,'2026-04-05 01:04:49','2026-04-05 01:04:49'),
(28,'App\\Models\\Vendor',204,'vendor-token','bd5c0e22ff1bd1fefe31d48399db741f75e5d4c0e8f780cc188225fa1e0ba6e0','[\"*\"]',NULL,NULL,'2026-04-05 01:05:04','2026-04-05 01:05:04'),
(29,'App\\Models\\Vendor',204,'vendor-token','1763e6f18dc389f9c9589fa866b20933e653d2e4b0fbab449af98ecce2f0201a','[\"*\"]',NULL,NULL,'2026-04-05 01:08:10','2026-04-05 01:08:10'),
(30,'App\\Models\\Vendor',204,'vendor-token','ad5ee75888e02a3c5c6339cded0513bbc6eb3529cf1e1679269a291d4de1b495','[\"*\"]',NULL,NULL,'2026-04-05 01:09:22','2026-04-05 01:09:22'),
(31,'App\\Models\\Vendor',204,'vendor-token','80cdbf199febc65979f057e77edda170a0813874cb99af943a4a80786c260a88','[\"*\"]','2026-04-05 01:37:27',NULL,'2026-04-05 01:12:05','2026-04-05 01:37:27'),
(32,'App\\Models\\Vendor',204,'vendor-token','5616a3666bc7a148303517443b103224c6a67a91d8d4eb0dd3902acf69240e06','[\"*\"]',NULL,NULL,'2026-04-05 02:42:19','2026-04-05 02:42:19'),
(33,'App\\Models\\Vendor',204,'vendor-token','ed8944f9aed3c86a2d58a896672d4adc66964c82f1158701c34299c989c9c491','[\"*\"]','2026-04-05 02:44:13',NULL,'2026-04-05 02:44:11','2026-04-05 02:44:13'),
(34,'App\\Models\\Vendor',204,'vendor-token','ef7ffa52b94cc05fb3fbee2acc6500096506d4f6f790bcc89f2cccac215086de','[\"*\"]','2026-04-05 03:50:37',NULL,'2026-04-05 02:45:03','2026-04-05 03:50:37'),
(35,'App\\Models\\Vendor',204,'vendor-token','f8bf537cfbe80346751a5c28b9e88ddbdd83b7ca12843325889f9385fb67a5a4','[\"*\"]','2026-04-05 23:30:41',NULL,'2026-04-05 23:10:45','2026-04-05 23:30:41'),
(36,'App\\Models\\Vendor',204,'vendor-token','e5f69d9be7d0d792301eaa3b65e5e3c230b5f0951b0cd2206816fe155a04037b','[\"*\"]',NULL,NULL,'2026-04-06 01:52:32','2026-04-06 01:52:32'),
(37,'App\\Models\\Vendor',204,'vendor-token','50338d181a66afe1b429f21f2f53dbcf0b80562e6d84157fd2935ba5721007ef','[\"*\"]','2026-04-06 05:09:49',NULL,'2026-04-06 01:54:23','2026-04-06 05:09:49'),
(38,'App\\Models\\Vendor',204,'vendor-token','0993a4bbf8421971bf58aa5af91519164f21402aa2b4c4248b6d5c027cd78a42','[\"*\"]','2026-04-07 05:06:34',NULL,'2026-04-06 02:10:08','2026-04-07 05:06:34'),
(39,'App\\Models\\Vendor',204,'vendor-token','4556f95238f6383e1df52e731eec6e8abafc3816fcd0833ac4ca9f8dffc38808','[\"*\"]','2026-04-07 00:32:58',NULL,'2026-04-06 22:53:34','2026-04-07 00:32:58'),
(40,'App\\Models\\Vendor',204,'vendor-token','81b5be7432e4bbf840b478c4e61651018983f81ec1ba3d20cb12b7178e4f6908','[\"*\"]','2026-04-07 00:05:44',NULL,'2026-04-06 22:55:05','2026-04-07 00:05:44'),
(41,'App\\Models\\Vendor',204,'vendor-token','a1e59eae1f9031c276878e2e92a9d3500d0a775e94957dbaf5cee4ee0ad56272','[\"*\"]','2026-04-07 01:06:11',NULL,'2026-04-07 00:31:03','2026-04-07 01:06:11'),
(42,'App\\Models\\Vendor',204,'vendor-token','745da79996146fa457c857535fe2e1724ee68b6366711d8efff9bcb296947d93','[\"*\"]','2026-04-13 00:28:11',NULL,'2026-04-07 01:06:34','2026-04-13 00:28:11'),
(43,'App\\Models\\Vendor',204,'vendor-token','0a218977a71179f2a537e3e3ec4f48b63849ed1645f927999dba75591969e88c','[\"*\"]','2026-04-07 03:40:34',NULL,'2026-04-07 01:07:17','2026-04-07 03:40:34'),
(44,'App\\Models\\Vendor',204,'vendor-token','8c2c5c97b94b6a332ca52286dce9619cdd0b24d64118f86def85bf8d80e7785a','[\"*\"]','2026-04-07 04:32:26',NULL,'2026-04-07 04:32:24','2026-04-07 04:32:26'),
(45,'App\\Models\\Vendor',204,'vendor-token','d3cd5957b08c2c0fc57895b0ee9932c2685326f9a49e038864b236f31e1f47d6','[\"*\"]','2026-04-12 04:59:51',NULL,'2026-04-12 00:20:30','2026-04-12 04:59:51'),
(46,'App\\Models\\Vendor',204,'vendor-token','aca0d8836205a6af82b4d1f9aaec65e42041423d7a5dcc2d17125a460ea184fc','[\"*\"]','2026-04-13 04:21:59',NULL,'2026-04-12 23:01:06','2026-04-13 04:21:59'),
(48,'App\\Models\\Vendor',204,'vendor-token','c1f3e8289b7ca59695122d8122d7dba57ba7872e8d60fb2d472abb016a9a7a3f','[\"*\"]',NULL,NULL,'2026-04-14 22:55:21','2026-04-14 22:55:21'),
(49,'App\\Models\\Vendor',204,'vendor-token','618bc03a9cfc66c25aef57e3c7836f5111c0d80b4f0235eb002e69cc22ceea09','[\"*\"]','2026-04-14 22:58:42',NULL,'2026-04-14 22:57:15','2026-04-14 22:58:42'),
(50,'App\\Models\\Vendor',204,'vendor-token','0db67c4cca7815ed9b9478c0a7947b1b73a0d3e0196b62d3a2cc8df6a0913999','[\"*\"]','2026-04-14 22:58:54',NULL,'2026-04-14 22:57:33','2026-04-14 22:58:54'),
(51,'App\\Models\\Vendor',204,'vendor-token','2007624d57bd3ae8dc1e03e45acaf909f66de93505cb05893cbb0ed23b5295a7','[\"*\"]','2026-04-15 00:47:26',NULL,'2026-04-14 23:54:39','2026-04-15 00:47:26'),
(52,'App\\Models\\Vendor',204,'vendor-token','caeac5bd0b4ed7f8157f5d4c23a701562d8dc12fbf4ac9aa1e283f923b43fe75','[\"*\"]','2026-04-15 05:20:42',NULL,'2026-04-15 04:03:52','2026-04-15 05:20:42'),
(53,'App\\Models\\Vendor',204,'vendor-token','6ea1f7fa1c89f9fa89d85329ef8ae41a8f6a8c222605f0207f8558e296c180c9','[\"*\"]','2026-04-19 22:27:02',NULL,'2026-04-15 21:59:39','2026-04-19 22:27:02'),
(54,'App\\Models\\Vendor',204,'vendor-token','b921c526def29557c2f33f6841283f5afe123570dc9ff385456a66db97c0f187','[\"*\"]','2026-04-19 22:34:34',NULL,'2026-04-19 22:31:24','2026-04-19 22:34:34'),
(55,'App\\Models\\Vendor',204,'vendor-token','963f75372b005aafaa19713229edc1ff156f75f94bc9032966874dacf2fa4d1c','[\"*\"]','2026-04-20 00:12:01',NULL,'2026-04-19 22:40:22','2026-04-20 00:12:01'),
(56,'App\\Models\\Vendor',204,'vendor-token','4c3ec7e2082b76bdac3ab8594907d1f5f3f55846d1729d49106c31510a4ab055','[\"*\"]','2026-04-22 01:09:18',NULL,'2026-04-20 00:14:07','2026-04-22 01:09:18'),
(57,'App\\Models\\Vendor',204,'vendor-token','79e43b81910021ce366dd8fbaf13625291fdad1f7ab9126fbab75ab55c97c347','[\"*\"]','2026-05-13 03:24:07',NULL,'2026-05-13 01:53:22','2026-05-13 03:24:07'),
(58,'App\\Models\\Vendor',204,'vendor-token','9c016576c09c2f4c46b877da7069086920d1f5c9dae0aa3510c4a6d39bc0ce10','[\"*\"]','2026-05-14 02:09:10',NULL,'2026-05-13 23:19:37','2026-05-14 02:09:10'),
(59,'App\\Models\\Vendor',204,'vendor-token','614614d4d222a464e4cfb1750840649cf947eb33320cdb3bb348c2b5e2aad4a5','[\"*\"]','2026-05-16 02:45:23',NULL,'2026-05-16 02:43:10','2026-05-16 02:45:23');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `popups`
--

DROP TABLE IF EXISTS `popups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `popups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `type` smallint(5) unsigned NOT NULL,
  `image` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `background_color` varchar(255) DEFAULT NULL,
  `background_color_opacity` decimal(3,2) unsigned DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `button_text` varchar(255) DEFAULT NULL,
  `button_color` varchar(255) DEFAULT NULL,
  `button_url` varchar(255) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `delay` int(10) unsigned NOT NULL COMMENT 'value will be in milliseconds',
  `serial_number` mediumint(8) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '0 => deactive, 1 => active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `popups_language_id_foreign` (`language_id`),
  CONSTRAINT `popups_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `popups`
--

LOCK TABLES `popups` WRITE;
/*!40000 ALTER TABLE `popups` DISABLE KEYS */;
INSERT INTO `popups` VALUES
(20,20,1,'64e1aff148d67.png','Black Friday',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1500,1,0,'2023-08-20 00:17:21','2024-03-28 02:12:16'),
(21,20,2,'64e1b8074e80b.png','Month End Sale','EE1243',0.80,'ENJOY 10% OFF','Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.','Get Offer','EE1243','https://codecanyon8.kreativdev.com/carlisting',NULL,NULL,2000,2,0,'2023-08-20 00:51:51','2024-03-28 02:12:13'),
(22,20,3,'64e1b8ba1a7a7.jpg','Summer Offer','EE1243',0.70,'Newsletter','Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.','Subscribe','EE1243',NULL,NULL,NULL,2000,3,0,'2023-08-20 00:54:50','2024-03-28 02:12:09'),
(23,20,4,'64e1b95adbe02.jpg','Winter Offer',NULL,NULL,'Get 10% off your sign up','Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt','Sign up','EE1243','https://codecanyon8.kreativdev.com/carlisting',NULL,NULL,2000,4,0,'2023-08-20 00:57:30','2024-03-28 02:12:06'),
(24,20,5,'64e1b9ca02dbb.png','Email Popup',NULL,NULL,'Get 10% off your first package purchase','Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt','Subscribe','EE1243',NULL,NULL,NULL,2000,2,0,'2023-08-20 00:59:22','2024-03-28 02:06:24'),
(25,20,6,'64e1ba4d0151d.png','Countdown Popup',NULL,NULL,'Hurry, Sale Ends This Friday','This is your last chance to save 30%','Yes,I Want to Save 30%','EE1243','https://codecanyon8.kreativdev.com/carlisting','2029-12-27','12:30:00',2000,6,0,'2023-08-20 01:00:55','2024-03-28 02:06:15'),
(26,20,7,'690991a33d7fb.png','Flash Deal','EE1243',NULL,'Hurry, Sale Ends This Friday','This is your last chance to save 30%','Yes, I Want to Save 30%','A50C2E','https://codecanyon8.kreativdev.com/carlisting','2029-11-29','01:00:00',2000,7,1,'2023-08-20 01:03:34','2026-05-13 01:25:59');
/*!40000 ALTER TABLE `popups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `serial_number` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_categories_language_id_foreign` (`language_id`),
  CONSTRAINT `product_categories_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_categories`
--

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` VALUES
(61,20,'Hospital Equipment','hospital-equipment',1,1,'2024-05-01 03:14:30','2024-05-01 03:14:30'),
(62,21,'معدات المستشفيات','معدات-المستشفيات',1,1,'2024-05-01 03:15:10','2024-11-09 22:02:18'),
(63,20,'Gym Equipment','gym-equipment',1,2,'2024-05-01 03:22:17','2024-05-01 03:22:17'),
(64,21,'معدات النادي الرياضي','معدات-النادي-الرياضي',1,2,'2024-05-01 03:22:39','2024-11-09 22:02:12'),
(65,20,'Saloon Equipment','saloon-equipment',1,3,'2024-05-01 03:33:30','2024-05-01 03:33:30'),
(66,21,'معدات الصالون','معدات-الصالون',1,3,'2024-05-01 03:33:51','2024-11-09 22:02:06');
/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_contents`
--

DROP TABLE IF EXISTS `product_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_contents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `product_category_id` bigint(20) unsigned DEFAULT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `list_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `summary` text NOT NULL,
  `content` longtext NOT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_contents_language_id_foreign` (`language_id`),
  KEY `product_contents_product_id_foreign` (`product_id`),
  CONSTRAINT `product_contents_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_contents_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_contents`
--

LOCK TABLES `product_contents` WRITE;
/*!40000 ALTER TABLE `product_contents` DISABLE KEYS */;
INSERT INTO `product_contents` VALUES
(143,20,61,71,NULL,'Surgical Lights','surgical-lights','Surgical lights, also known as surgical lighting or operating lights, are mainly used in hospital operating rooms and ambulatory surgery centers, but can also be used in various locations throughout the facility to provide high quality lighting for procedures. Examples include emergency rooms, labor and delivery, examination rooms, and anywhere where procedures are completed. They are used by clinicians, surgeons and proceduralists','<p>Surgical lights, also known as  or operating lights, are mainly used in hospital operating rooms and ambulatory surgery centers, but can also be used in various locations throughout the facility to provide high quality lighting for procedures. Examples include emergency rooms, labor and delivery, examination rooms, and anywhere where procedures are completed. They are used by clinicians, surgeons and proceduralistsSurgical lights, also known as or operating lights, are mainly used in hospital operating rooms and ambulatory surgery centers, but can also be used in various locations throughout the facility to provide high quality lighting for procedures. Examples include emergency rooms, labor and delivery, examination rooms, and anywhere where procedures are completed. They are used by clinicians, surgeons and proceduralists</p>',NULL,NULL,'2024-05-01 03:17:35','2024-05-01 03:17:35'),
(144,21,62,71,NULL,'أضواء جراحية','أضواء-جراحية','تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين','<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">تُستخدم الأضواء الجراحية، والمعروفة أيضًا باسم الإضاءة الجراحية أو أضواء العمليات، بشكل أساسي في غرف العمليات بالمستشفيات ومراكز الجراحة المتنقلة، ولكن يمكن استخدامها أيضًا في مواقع مختلفة في جميع أنحاء المنشأة لتوفير إضاءة عالية الجودة للإجراءات. تشمل الأمثلة غرف الطوارئ، وغرف المخاض والولادة، وغرف الفحص، وفي أي مكان يتم فيه استكمال الإجراءات. يتم استخدامها من قبل الأطباء والجراحين والإجرائيين</span></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"></div>',NULL,NULL,'2024-05-01 03:17:35','2024-05-01 03:45:52'),
(145,20,61,72,NULL,'MRI','mri','Magnetic resonance imaging, or MRI, is a noninvasive medical imaging test that produces detailed images of almost every internal structure in the human body, including the organs, bones, muscles and blood vessels. MRI scanners create images of the body using a large magnet and radio waves.','<p><span class=\"c5aZPb\"><span class=\"JPfdse\">Magnetic resonance</span></span> imaging, or MRI, is <strong>a noninvasive medical imaging test that produces detailed images of almost every internal structure in the human body, including the organs, bones, muscles and blood vessels</strong>. MRI scanners create images of the body using a large magnet and radio waves.<span class=\"c5aZPb\"><span class=\"JPfdse\">Magnetic resonance</span></span> imaging, or MRI, is <strong>a noninvasive medical imaging test that produces detailed images of almost every internal structure in the human body, including the organs, bones, muscles and blood vessels</strong>. MRI scanners create images of the body using a large magnet and radio waves.</p>',NULL,NULL,'2024-05-01 03:19:04','2024-05-01 03:49:01'),
(146,21,62,72,NULL,'التصوير بالرنين المغناطيسي','التصوير-بالرنين-المغناطيسي','التصوير بالرنين المغناطيسي، أو التصوير بالرنين المغناطيسي، هو اختبار تصوير طبي غير جراحي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا في جسم الإنسان، بما في ذلك الأعضاء والعظام والعضلات والأوعية الدموية. تقوم ماسحات التصوير بالرنين المغناطيسي بإنشاء صور للجسم باستخدام مغناطيس كبير وموجات الراديو.','<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">التصوير بالرنين المغناطيسي، أو MRI، هو اختبار تصوير طبي غير جرا<br />حي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا في جسم الإنسان، بما في <br />ذلك الأعضاء والعظام والعضلات والأوعية الدموية. تنشئ ماسحات التصوير بالرنين المغناطيسي صورًا لل<br />جسم باستخدام مغناطيس كبير وموجات راديو. التصوير بالرنين المغناطيسي، أو التصوير بالرنين المغناطيسي، هو اختبار تصوي<br />ر طبي غير جراحي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا في جسم الإنسان، بما في <br />ذلك الأعضاء والعظام والعضلات والأعصاب. الأوعية الدموية. تنشئ ماسحات التصوير بالرنين المغناطيسي صورًا للجسم باستخدام م<br />غناطيس كبير وموجات راديو. التصوير بالرنين المغناطيسي، أو التصوير<br /> بالرنين المغناطيسي، هو اختبار تصوير طبي غير جراحي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا ف<br />ي جسم الإنسان، بما في ذلك الأعضاء والعظام والعضلات والأعصاب. الأوعية الدموية. تنشئ ماسحات التصوير بالرنين ال<br />مغناطيسي صورًا للجسم باستخدام مغناطي<br />س كبير وموجات راديو. التصوير بالرنين المغناطيسي، أو التصوير بالرنين المغناطيسي، هو اخ<br />تبار تصوير طبي غير جراحي ينتج صورًا تفصيلية لكل بنية داخلية تقريبًا في جسم الإنسان، بما في ذلك الأعضاء والعظا<br />م والعضلات والأعصاب. الأوعية الدموية. تقوم ماسحات التصوير بالرنين ال<br />مغناطيسي بإنشاء صور للجسم باستخدام مغناطيس كبير وموجات الراديو.</span></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"> </div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"> </div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"> </div>',NULL,NULL,'2024-05-01 03:19:04','2024-05-01 03:50:07'),
(147,20,61,73,NULL,'Infusion Pump','infusion-pump','Infusion pumps allow for high viscous medications to be administered through small catheters into the veins. Medication is usually administered this way through the dorsal veins of the hand, the forearm, the arm, the dorsal veins of the foot, the inguinal region and the antecubital fossa.','<p>Infusion pumps <strong>allow for high viscous medications to be administered through small catheters into the veins</strong>. Medication is usually administered this way through the dorsal veins of the hand, the forearm, the arm, the dorsal veins of the foot, the inguinal region and the antecubital fossa.Infusion pumps <strong>allow for high viscous medications to be administered through small catheters into the veins</strong>. Medication is usually administered this way through the dorsal veins of the hand, the forearm, the arm, the dorsal veins of the foot, the inguinal region and the antecubital fossa.</p>',NULL,NULL,'2024-05-01 03:20:40','2024-05-01 03:20:40'),
(148,21,62,73,NULL,'مضخة التصريف','مضخة-التصريف','تسمح مضخات التسريب بإدخال الأدوية عالية اللزوجة من خلال القسطرة الصغيرة إلى الأوردة. يتم إعطاء الدواء عادة بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود.','<p>تتيح مضخات التسريب إمكانية إعطاء الأدوية عالية اللزوجة من خلال القسطرة الصغيرة في الأوردة. يتم عادةً إعطاء الدواء بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود. وتسمح مضخات التسريب بإدخال الأدوية عالية اللزوجة من خلال قسطرات صغيرة إلى داخل الأوردة. الأوردة. يتم عادةً إعطاء الدواء بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود. وتسمح مضخات التسريب بإدخال الأدوية عالية اللزوجة من خلال قسطرات صغيرة إلى داخل الأوردة. الأوردة. يتم عادةً إعطاء الدواء بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود. وتسمح مضخات التسريب بإدخال الأدوية عالية اللزوجة من خلال قسطرات صغيرة إلى داخل الأوردة. الأوردة. يتم إعطاء الدواء عادة بهذه الطريقة من خلال الأوردة الظهرية لليد والساعد والذراع والأوردة الظهرية للقدم والمنطقة الأربية والحفرة المضادة للعنقود.</p>',NULL,NULL,'2024-05-01 03:20:40','2024-05-01 03:55:30'),
(149,20,63,74,NULL,'Treadmill','treadmill','Healthfit Foldable Semi Commercial Motorized Treadmill 586DS Price In Bangladesh When it comes to buying a treadmill make sure the treadmill has all the features for your needs. Our Asian Sky Shop offers you a semi-commercial motorized treadmill that has so many features and specifications. It\'s manufactured by Healthfit. This foldable treadmill is easy to carry and user comfortable. We are giving you an affordable price range and lots of facilities.','<p>Healthfit Foldable Semi Commercial Motorized Treadmill 586DS Price In Bangladesh When it comes to buying a treadmill make sure the treadmill has all the features for your needs. Our Asian Sky Shop offers you a semi-commercial motorized treadmill that has so many features and specifications. It\'s manufactured by Healthfit. This foldable treadmill is easy to carry and user comfortable. We are giving you an affordable price range and lots of facilities.</p>\r\n<p>Healthfit Foldable Semi Commercial Motorized Treadmill 586DS Price In Bangladesh When it comes to buying a treadmill make sure the treadmill has all the features for your needs. Our Asian Sky Shop offers you a semi-commercial motorized treadmill that has so many features and specifications. It\'s manufactured by Healthfit. This foldable treadmill is easy to carry and user comfortable. We are giving you an affordable price range and lots of facilities.</p>',NULL,NULL,'2024-05-01 03:24:57','2024-05-01 03:24:57'),
(150,21,64,74,NULL,'جهاز المشي','جهاز-المشي','جهاز المشي الكهربائي القابل للطي شبه التجاري من السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian Sky Shop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.','<p>جهاز المشي الكهربائي القابل للطي شبه التجاري من السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian SkyShop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.جهاز المشي الكهربائي القابل للطي شبه التجاري من Healthfit 586DS السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian Sky Shop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.جهاز المشي الكهربائي القابل للطي شبه التجاري من Healthfit 586DS السعر في بنغلاديش عندما يتعلق الأمر بشراء جهاز المشي، تأكد من أن جهاز المشي يحتوي على جميع الميزات التي تلبي احتياجاتك. يقدم لك متجر Asian Sky Shop جهاز مشي كهربائي شبه تجاري يحتوي على العديد من الميزات والمواصفات. تم تصنيعه بواسطة شركة هيلث فيت. جهاز المشي القابل للطي هذا سهل الحمل ومريح للمستخدم. نحن نقدم لك نطاقًا بأسعار معقولة والكثير من المرافق.</p>',NULL,NULL,'2024-05-01 03:24:57','2024-05-01 03:54:40'),
(151,20,63,75,NULL,'Kettlebells','kettlebells','A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying supine on the floor to standing, and back again. Get-ups are sometimes modified into get-up presses, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.','<p>A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying on the floor to standing, and back again. Get-ups are sometimes modified into <em>get-up presses</em>, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.<sup class=\"reference\"><a href=\"https://en.wikipedia.org/wiki/Kettlebell#cite_note-14\">]</a></sup>A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying on the floor to standing, and back again. Get-ups are sometimes modified into <em>get-up presses</em>, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.A kettlebell exercise that combines the lunge, bridge and side plank in a slow, controlled movement. Keeping the arm holding the bell extended vertically, the athlete transitions from lying on the floor to standing, and back again. Get-ups are sometimes modified into <em>get-up presses</em>, with a press at each position of the get-up; that is, the athlete performs a floor press, a leaning seated press, a high bridge press, a single-leg kneeling press, and a standing press in the course of a single get-up.</p>',NULL,NULL,'2024-05-01 03:27:14','2024-05-01 03:53:50'),
(152,21,64,75,NULL,'أجراس كيتل','أجراس-كيتل','تمرين كيتل بيل الذي يجمع بين تمرين الاندفاع والجسر واللوح الجانبي في حركة بطيئة ومنضبطة. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات الاستيقاظ أحيانًا إلى مكابس الاستيقاظ، مع الضغط على كل موضع من موضع الاستيقاظ؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي.','<p>تمرين كيتل بيل الذي يجمع بين تمرين الاندفاع والجسر واللوح الجانبي في حركة بطيئة ومنضبطة. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات النهوض أحيانًا إلى ضغطات النهوض، مع الضغط على كل موضع من موضع النهوض؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي.] تمرين كيتل بيل الذي يجمع بين الاندفاع، الجسر واللوح الجانبي في حركة بطيئة ومسيطر عليها. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات النهوض أحيانًا إلى ضغطات النهوض، مع الضغط على كل موضع من موضع النهوض؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي. واللوح الجانبي بحركة بطيئة ومسيطر عليها. مع إبقاء الذراع التي تحمل الجرس ممتدة عموديًا، ينتقل الرياضي من الاستلقاء على الأرض إلى الوقوف والعودة مرة أخرى. يتم تعديل عمليات النهوض أحيانًا إلى ضغطات النهوض، مع الضغط على كل موضع من موضع النهوض؛ أي أن الرياضي يؤدي تمرين الضغط على الأرض، والضغط أثناء الجلوس، والضغط على الجسر العالي، والضغط على الركوع بساق واحدة، والضغط أثناء الوقوف أثناء النهوض الفردي.</p>',NULL,NULL,'2024-05-01 03:27:14','2024-05-01 03:53:50'),
(153,20,63,76,NULL,'Dumbbells','dumbbells','There are many variations possible while using the same basic concept of reducing the weight used. One way is to do a specified number of repetitions at each weight (without necessarily reaching the point of muscle failure) with an increase in the number of repetitions each time the weight is reduced. The amount or percentage of weight reduced at each step is also one aspect of the method with much variety. A wide drop set method is one in which a large percentage (usually 30% or more) of the starting weight is shed with each weight reduction. A tight drop set would remove anywhere from 10% to 25%.\r\n\r\nDrop sets may be performed either with or without rest periods between sets. Some make a distinction between the two: if the lifter does not rest then these sets are referred to as drop sets, whereas if the lifter does rest between sets then these sets are usually referred to as down sets.\r\n\r\nThese definitions are somewhat arbitrary, of course, and not everyone will agree on the exact definitions.','<p>There are many variations possible while using the same basic concept of reducing the weight used. One way is to do a specified number of repetitions at each weight (without necessarily reaching the point of )with an increase in the number of repetitions each time the weight is reduced. The amount or percentage of weight reduced at each step is also one aspect of the method with much variety. A <strong>wide drop set</strong> method is one in which a large percentage (usually 30% or more) of the starting weight is shed with each weight reduction. A <strong>tight drop set</strong> would remove anywhere from 10% to 25%.</p>\r\n<p>Drop sets may be performed either with or without rest periods between sets. Some make a distinction between the two: if the lifter does not rest then these sets are referred to as drop sets, whereas if the lifter does rest between sets then these sets are usually referred to as <strong>down sets</strong>.</p>\r\n<p>These definitions are somewhat arbitrary, of course, and not everyone will agree on the exact definitions.</p>\r\n<p>There are many variations possible while using the same basic concept of reducing the weight used. One way is to do a specified number of repetitions at each weight (without necessarily reaching the point ofwith an increase in the number of repetitions each time the weight is reduced. The amount or percentage of weight reduced at each step is also one aspect of the method with much variety. A <strong>wide drop set</strong> method is one in which a large percentage (usually 30% or more) of the starting weight is shed with each weight reduction. A <strong>tight drop set</strong> would remove anywhere from 10% to 25%.</p>\r\n<p>Drop sets may be performed either with or without rest periods between sets. Some make a distinction between the two: if the lifter does not rest then these sets are referred to as drop sets, whereas if the lifter does rest between sets then these sets are usually referred to as <strong>down sets</strong>.</p>\r\n<p>These definitions are somewhat arbitrary, of course, and not everyone will agree on the exact definitions.</p>',NULL,NULL,'2024-05-01 03:29:51','2024-05-01 03:29:51'),
(154,21,64,76,NULL,'اجراس صماء','اجراس-صماء','هناك العديد من الاختلافات الممكنة أثناء استخدام نفس المفهوم الأساسي لتقليل الوزن المستخدم. إحدى الطرق هي القيام بعدد محدد من التكرارات عند كل وزن (دون الوصول بالضرورة إلى نقطة الفشل العضلي) مع زيادة عدد التكرارات في كل مرة ينقص فيها الوزن. يعد مقدار أو نسبة الوزن المنخفض في كل خطوة أيضًا أحد جوانب الطريقة مع تنوع كبير. طريقة مجموعة الإسقاط الواسعة هي الطريقة التي يتم فيها التخلص من نسبة كبيرة (عادة 30٪ أو أكثر) من الوزن الأولي مع كل تخفيض للوزن. ستؤدي مجموعة الإسقاط الضيقة إلى إزالة أي مكان من 10٪ إلى 25٪.\r\n\r\nيمكن إجراء مجموعات الإسقاط إما مع أو بدون فترات راحة بين المجموعات. يميز البعض بين الاثنين: إذا لم يستريح الرافع فيشار إلى هذه المجموعات بمجموعات الهبوط، بينما إذا استراح الرافع بين المجموعات فيشار إلى هذه المجموعات عادةً باسم المجموعات السفلية.\r\n\r\nهذه التعريفات تعسفية إلى حد ما، بطبيعة الحال، ولن يتفق الجميع على التعريفات الدقيقة.','<p>هناك العديد من الاختلافات الممكنة أثناء استخدام نفس المفهوم الأساسي لتقليل الوزن المستخدم. إحدى الطرق هي القيام بعدد محدد من التكرارات عند كل وزن (دون الوصول بالضرورة إلى النقطة ) مع زيادة عدد التكرارات في كل مرة ينقص فيها الوزن. يعد مقدار أو نسبة الوزن المنخفض في كل خطوة أيضًا أحد جوانب الطريقة مع تنوع كبير. طريقة مجموعة الإسقاط الواسعة هي الطريقة التي يتم فيها التخلص من نسبة كبيرة (عادةً 30% أو أكثر) من الوزن الأولي مع كل عملية تخفيض للوزن. ستؤدي مجموعة الإسقاط الضيقة إلى إزالة أي مكان من 10% إلى 25%.</p>\r\n<p>يمكن إجراء مجموعات الإسقاط إما مع أو بدون فترات راحة بين المجموعات. يميز البعض بين الاثنين: إذا لم يستريح الرافع، تتم الإشارة إلى هذه المجموعات باسم مجموعات الإسقاط، بينما إذا كان الرافع يستريح بين المجموعات، فيُشار إلى هذه المجموعات عادةً باسم المجموعات السفلية.</p>\r\n<p>هذه التعريفات تعسفية إلى حد ما، بطبيعة الحال، ولن يتفق الجميع على التعريفات الدقيقة.</p>\r\n<p>هناك العديد من الاختلافات الممكنة أثناء استخدام نفس المفهوم الأساسي لتقليل الوزن المستخدم. إحدى الطرق هي القيام بعدد محدد من التكرارات عند كل وزن (دون الوصول بالضرورة إلى نقطة زيادة عدد التكرارات في كل مرة يتم فيها تقليل الوزن. كما أن مقدار أو نسبة الوزن المخفض في كل خطوة هو أيضًا أحد جوانب الهدف). طريقة ذات تنوع كبير. طريقة مجموعة الإسقاط الواسعة هي الطريقة التي يتم فيها التخلص من نسبة كبيرة (عادةً 30% أو أكثر) من الوزن الأولي مع كل تخفيض في الوزن.</p>\r\n<p>يمكن إجراء مجموعات الإسقاط إما مع أو بدون فترات راحة بين المجموعات. يميز البعض بين الاثنين: إذا لم يستريح الرافع، تتم الإشارة إلى هذه المجموعات باسم مجموعات الإسقاط، بينما إذا كان الرافع يستريح بين المجموعات، فيُشار إلى هذه المجموعات عادةً باسم المجموعات السفلية.</p>\r\n<p>هذه التعريفات تعسفية إلى حد ما، بطبيعة الحال، ولن يتفق الجميع على التعريفات الدقيقة.</p>',NULL,NULL,'2024-05-01 03:29:51','2024-05-01 03:52:51'),
(155,20,65,77,NULL,'Hair Curler','hair-curler','A hair roller or hair curler is a small tube that is rolled into a person\'s hair in order to curl it, or to straighten curly hair, making a new hairstyle.[1]\r\n\r\nThe diameter of a roller varies from approximately 0.8 inches (20 mm) to 1.5 inches (38 mm). The hair is heated, and the rollers strain and break the hydrogen bonds[citation needed] of each hair\'s cortex, which causes the hair to curl. The hydrogen bonds reform after the hair is moistened.\r\n\r\nA hot roller or hot curler is designed to be heated in an electric chamber before one rolls it into the hair.[2] Alternatively, a hair dryer heats the hair after the rolls are in place. Hair spray can temporarily fix curled hair in place.\r\n\r\nIn 1930, Solomon Harper created the first electrically heated hair rollers, then creating a better design in 1953.\r\n\r\nIn 1968 at the feminist Miss America protest, protesters symbolically threw a number of feminine products into a \"Freedom Trash Can\". These included hair rollers,[3] which were among items the protesters called \"instruments of female torture\"[4] and accoutrements of what they perceived to be enforced femininity.','<p>A <strong>hair roller</strong> or <strong>hair curler</strong> is a small tube that is rolled into a person\'s in order to it, or to curly hair, making a new .</p>\r\n<p>The diameter of a roller varies from approximately 0.8 inches (20 mm) to 1.5 inches (38 mm). The hair is heated, and the rollers strain and break the of each hair\'s cortex, which causes the hair to curl. The hydrogen bonds reform after the hair is moistened.</p>\r\n<p>A <strong>hot roller</strong> or <strong>hot curler</strong> is designed to be heated in an electric chamber before one rolls it into the hair.Alternatively, a heats the hair after the rolls are in place.can temporarily fix curled hair in place.</p>\r\n<p>In 1930, created the first electrically heated hair rollers, then creating a better design in 1953.</p>\r\n<p>In 1968 at the feminist, protesters symbolically threw a number of feminine products into a \"Freedom Trash Can\". These included hair rollers, which were among items the protesters called \"instruments of female torture\" and accoutrements of what they perceived to be enforced .</p>\r\n<p>A <strong>hair roller</strong> or <strong>hair curler</strong> is a small tube that is rolled into a person\'s in order to it, or to curly hair, making a new .</p>\r\n<p>The diameter of a roller varies from approximately 0.8 inches (20 mm) to 1.5 inches (38 mm). The hair is heated, and the rollers strain and break the  of each hair\'s cortex, which causes the hair to curl. The hydrogen bonds reform after the hair is moistened.</p>\r\n<p>A <strong>hot roller</strong> or <strong>hot curler</strong> is designed to be heated in an electric chamber before one rolls it into the hair. Alternatively, a heats the hair after the rolls are in place. can temporarily fix curled hair in place.</p>\r\n<p>In 1930, created the first electrically heated hair rollers, then creating a better design in 1953.</p>\r\n<p>In 1968 at the feminist, protesters symbolically threw a number of feminine products into a \"Freedom Trash Can\". These included hair rollers, which were among items the protesters called \"instruments of female torture\" and accoutrements of what they perceived to be enforced .</p>',NULL,NULL,'2024-05-01 03:37:27','2024-05-01 03:51:49'),
(156,21,66,77,NULL,'مجعد الشعر','مجعد-الشعر','بكرة الشعر أو أداة تجعيد الشعر عبارة عن أنبوب صغير يتم لفه في شعر الشخص من أجل تجعيده، أو تنعيم الشعر المجعد، وعمل تسريحة شعر جديدة.\r\n\r\nيتراوح قطر الأسطوانة من حوالي 0.8 بوصة (20 ملم) إلى 1.5 بوصة (38 ملم). يتم تسخين الشعر، وتقوم البكرات بإجهاد وكسر الروابط الهيدروجينية لقشرة كل شعرة، مما يتسبب في تجعد الشعر. يتم إصلاح الروابط الهيدروجينية بعد ترطيب الشعر.\r\n\r\nتم تصميم الأسطوانة الساخنة أو أداة تجعيد الشعر الساخنة بحيث يتم تسخينها في غرفة كهربائية قبل لفها في الشعر. بدلًا من ذلك، يقوم مجفف الشعر بتسخين الشعر بعد وضع اللفائف في مكانها. يمكن لرذاذ الشعر تثبيت الشعر المجعد في مكانه بشكل مؤقت.\r\n\r\nفي عام 1930، ابتكر سولومون هاربر أول بكرات شعر يتم تسخينها كهربائيًا، ثم ابتكر تصميمًا أفضل في عام 1953.\r\n\r\nفي عام 1968، أثناء احتجاج ملكة جمال أمريكا النسوية، ألقى المتظاهرون بشكل رمزي عددًا من المنتجات النسائية في \"سلة مهملات الحرية\". وشملت هذه بكرات الشعر، والتي كانت من بين العناصر التي أطلق عليها المتظاهرون \"أدوات تعذيب الإناث\" ومستلزمات ما اعتبروه أنوثة قسرية.','<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">بكرة الشعر أو أداة تجعيد الشعر عبارة عن أنبوب صغير يتم لفه داخل شعر الشخص أو تجعيده، مما يؤدي إلى تكوين شعر جديد.\r\n\r\nيتراوح قطر الأسطوانة من حوالي 0.8 بوصة (20 ملم) إلى 1.5 بوصة (38 ملم). يتم تسخين الشعر، وتجهد البكرات وتكسر قشرة كل شعرة، مما يتسبب في تجعد الشعر. يتم إصلاح الروابط الهيدروجينية بعد ترطيب الشعر.\r\n\r\nتم تصميم الأسطوانة الساخنة أو أداة تجعيد الشعر الساخنة بحيث يتم تسخينها في غرفة كهربائية قبل لفها في الشعر. وبدلاً من ذلك، يتم تسخين الشعر بعد وضع اللفائف في مكانها. ويمكن تثبيت الشعر المجعد في مكانه بشكل مؤقت.\r\n\r\nفي عام 1930، ابتكر أول بكرات شعر يتم تسخينها كهربائيًا، ثم ابتكر تصميمًا أفضل في عام 1953.\r\n\r\nفي عام 1968، قامت الناشطة النسوية بإلقاء المتظاهرات بشكل رمزي عددًا من المنتجات النسائية في \"سلة مهملات الحرية\". وشملت هذه بكرات الشعر، والتي كانت من بين العناصر التي وصفها المتظاهرون بأنها \"أدوات تعذيب للإناث\" ومعدات ما اعتقدوا أنه يتم فرضها.\r\n\r\nبكرة الشعر أو أداة تجعيد الشعر عبارة عن أنبوب صغير يتم لفه داخل شعر الشخص أو تجعيده، مما يؤدي إلى تكوين شعر جديد.\r\n\r\nيتراوح قطر الأسطوانة من حوالي 0.8 بوصة (20 ملم) إلى 1.5 بوصة (38 ملم). يتم تسخين الشعر، وتجهد البكرات وتكسر قشرة كل شعرة، مما يتسبب في تجعد الشعر. يتم إصلاح الروابط الهيدروجينية بعد ترطيب الشعر.\r\n\r\nتم تصميم الأسطوانة الساخنة أو أداة تجعيد الشعر الساخنة بحيث يتم تسخينها في غرفة كهربائية قبل لفها في الشعر. وبدلاً من ذلك، يتم تسخين الشعر بعد وضع اللفائف في مكانها. يمكن تثبيت الشعر المجعد مؤقتًا في مكانه.\r\n\r\nفي عام 1930، ابتكر أول بكرات شعر يتم تسخينها كهربائيًا، ثم ابتكر تصميمًا أفضل في عام 1953.\r\n\r\nفي عام 1968، قامت الناشطة النسوية بإلقاء المتظاهرات بشكل رمزي عددًا من المنتجات النسائية في \"سلة مهملات الحرية\". وشملت هذه بكرات الشعر، والتي كانت من بين العناصر التي وصفها المتظاهرون بأنها \"أدوات تعذيب للإناث\" ومعدات ما اعتقدوا أنه يتم فرضها.</span></pre>',NULL,NULL,'2024-05-01 03:37:27','2024-05-01 03:51:49'),
(157,20,65,78,NULL,'Salon Chair','salon-chair','Color: Black, Coffee\r\nMaterial: Artificial Leather, Plastic, SS\r\nValue Addition: Non-Hydraulic\r\nPlace of Origin: Bangladesh\r\nHeight: Adjustable\r\nCare Instructions: Wipe with Soft Dry Brush After Use.\r\nFeatures: Durable & Comfortable.','<ul>\r\n<li>Color: Black, Coffee<br />Material: Artificial Leather, Plastic, SS<br />Value Addition: Non-Hydraulic<br />Place of Origin: Bangladesh<br />Height: Adjustable<br />Care Instructions: Wipe with Soft Dry Brush After Use.<br />Features: Durable &amp; Comfortable.</li>\r\n</ul>',NULL,NULL,'2024-05-01 03:38:55','2024-05-01 03:38:55'),
(158,21,66,78,NULL,'كرسي صالون','كرسي-صالون','اللون: أسود، قهوة\r\nالمواد: جلد صناعي، بلاستيك، SS\r\nإضافة القيمة: غير هيدروليكي\r\nمكان المنشأ: بنجلاديش\r\nالارتفاع: قابل للتعديل\r\nتعليمات العناية: امسحي بفرشاة جافة ناعمة بعد الاستخدام.\r\nالميزات: متين ومريح.','<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">اللون: أسود، قهوة\r\nالمواد: جلد صناعي، بلاستيك، SS\r\nإضافة القيمة: غير هيدروليكي\r\nمكان المنشأ: بنجلاديش\r\nالارتفاع: قابل للتعديل\r\nتعليمات العناية: امسحي بفرشاة جافة ناعمة بعد الاستخدام.\r\nالميزات: متين ومريح.</span></pre>',NULL,NULL,'2024-05-01 03:38:55','2024-05-01 03:46:46'),
(159,20,65,79,NULL,'Shampoo Bowl','shampoo-bowl','Minerva Beauty offers a variety of shampoo bowls and wet stations for salons and barbershops, including standalone shampoo bowls you can pair with your existing shampoo cabinet or wall unit, pedestal shampoo bowls, barber wet stations, and barber sinks paired with a cabinet and mirror. Minerva shampoo bowls come with mounting hardware and all the parts your plumber needs to install them, and we also provide shampoo bowl replacement parts and accessories. Add more storage to your professional shampoo stations with lower and upper cabinets, available in a wide range of colors and finishes including custom options. Don’t forget to pick up a shampoo chair to pair with your hair wash bowl, or browse our shampoo backwash units for ready-made setups. We also have a helpful guide to choosing the best shampoo bowl and chair that covers dimensions, accessibility and more.','<p>Minerva Beauty offers a variety of shampoo bowls and wet stations for salons and barbershops, including standalone shampoo bowls you can pair with your existing shampoo cabinet or wall unit, pedestal shampoo bowls, barber wet stations, and barber sinks paired with a cabinet and mirror. Minerva shampoo bowls come with mounting hardware and all the parts your plumber needs to install them, and we also provide . Add more storage to your professional with lower and upper cabinets, available in a wide range of colors and finishes including custom options. Don’t forget to pick up a to pair with your hair wash bowl, or browse our for ready-made setups. We also have a helpful guide to <a href=\"https://www.minervabeauty.com/blog/post/shampoo-system-buying-guide\"> </a>that covers dimensions, accessibility and more.</p>\r\n<p>Minerva Beauty offers a variety of shampoo bowls and wet stations for salons and barbershops, including standalone shampoo bowls you can pair with your existing shampoo cabinet or wall unit, pedestal shampoo bowls, barber wet stations, and barber sinks paired with a cabinet and mirror. Minerva shampoo bowls come with mounting hardware and all the parts your plumber needs to install them, and we also provide . Add more storage to your professional with lower and upper cabinets, available in a wide range of colors and finishes including custom options. Don’t forget to pick up a to pair with your hair wash bowl, or browse our for ready-made setups. We also have a helpful guide to <a href=\"https://www.minervabeauty.com/blog/post/shampoo-system-buying-guide\"> </a>that covers dimensions, accessibility and more.</p>',NULL,NULL,'2024-05-01 03:41:06','2024-05-01 03:41:06'),
(160,21,66,79,NULL,'وعاء الشامبو','وعاء-الشامبو','تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.','<p>تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.تقدم مجموعة متنوعة من أوعية الشامبو والمحطات الرطبة للصالونات ومحلات الحلاقة، بما في ذلك أوعية الشامبو المستقلة التي يمكنك إقرانها بخزانة الشامبو أو وحدة الحائط الموجودة لديك، وأوعية الشامبو ذات القاعدة، ومحطات الحلاقة المبللة، وأحواض الحلاقة المقترنة بخزانة ومرآة. تأتي أوعية الشامبو من مينيرفا مزودة بمعدات التركيب وجميع الأجزاء التي يحتاجها السباك لتركيبها، ونوفر أيضًا قطع غيار وملحقات لوعاء الشامبو. أضف المزيد من التخزين إلى محطات الشامبو الاحترافية الخاصة بك من خلال الخزانات السفلية والعلوية، المتوفرة في مجموعة واسعة من الألوان والتشطيبات بما في ذلك الخيارات المخصصة. لا تنسَ اختيار كرسي الشامبو ليتوافق مع وعاء غسيل شعرك، أو تصفح وحدات الغسيل العكسي بالشامبو الخاصة بنا للتعرف على الإعدادات الجاهزة. لدينا أيضًا دليل مفيد لاختيار أفضل وعاء شامبو وكرسي يغطي الأبعاد وإمكانية الوصول والمزيد.<br /><br /></p>',NULL,NULL,'2024-05-01 03:41:06','2024-05-01 03:44:59'),
(161,20,61,80,NULL,'Do not Distrub','do-not-distrub','\"Do Not Disturb\" is a mystery thriller novel written by British author Claire Douglas. The story revolves around a group of friends who decide to spend a weekend away at a remote lodge in the Scottish Highlands. However, their peaceful retreat turns into a nightmare when they discover a woman\'s body in the hot tub.\r\n\r\nAs the friends grapple with shock and fear, tensions rise, and they realize that each of them harbors secrets that could unravel their lives. With suspicion and paranoia mounting, they must confront their pasts and untangle the web of lies surrounding them to uncover the truth about what happened that fateful night.\r\n\r\nFilled with twists, suspense, and psychological depth, \"Do Not Disturb\" explores themes of trust, betrayal, and the consequences of buried secrets. It keeps readers on the edge of their seats as they race to unravel the mystery alongside the characters.','<p>\"Do Not Disturb\" is a mystery thriller novel written by British author Claire Douglas. The story revolves around a group of friends who decide to spend a weekend away at a remote lodge in the Scottish Highlands. However, their peaceful retreat turns into a nightmare when they discover a woman\'s body in the hot tub.</p>\r\n<p>As the friends grapple with shock and fear, tensions rise, and they realize that each of them harbors secrets that could unravel their lives. With suspicion and paranoia mounting, they must confront their pasts and untangle the web of lies surrounding them to uncover the truth about what happened that fateful night.</p>\r\n<p>Filled with twists, suspense, and psychological depth, \"Do Not Disturb\" explores themes of trust, betrayal, and the consequences of buried secrets. It keeps readers on the edge of their seats as they race to unravel the mystery alongside the characters.</p>',NULL,NULL,'2024-05-06 03:52:19','2024-05-06 03:52:19'),
(162,21,62,80,NULL,'لا تخل','لا-تخل','\"لا تزعج\" هي رواية غامضة ومثيرة من تأليف الكاتبة البريطانية كلير دوجلاس. تدور القصة حول مجموعة من الأصدقاء الذين قرروا قضاء عطلة نهاية الأسبوع بعيدًا في نزل بعيد في المرتفعات الاسكتلندية. ومع ذلك، يتحول ملاذهم الهادئ إلى كابوس عندما يكتشفون جثة امرأة في حوض الاستحمام الساخن.\r\n\r\nبينما يتصارع الأصدقاء مع الصدمة والخوف، ترتفع التوترات، ويدركون أن كل واحد منهم يحمل أسرارًا يمكن أن تكشف حياتهم. ومع تزايد الشك والبارانويا، يجب عليهم مواجهة ماضيهم وفك شبكة الأكاذيب المحيطة بهم لكشف حقيقة ما حدث في تلك الليلة المشؤومة.\r\n\r\nيستكشف فيلم \"عدم الإزعاج\" المليء بالتقلبات والتشويق والعمق النفسي موضوعات الثقة والخيانة وعواقب الأسرار المدفونة. إنه يبقي القراء على حافة مقاعدهم وهم يتسابقون لكشف الغموض إلى جانب الشخصيات.','<p>\"لا تزعج\" هي رواية غامضة ومثيرة من تأليف الكاتبة البريطانية كلير دوجلاس. تدور القصة حول مجموعة من الأصدقاء الذين قرروا قضاء عطلة نهاية الأسبوع بعيدًا في نزل بعيد في المرتفعات الاسكتلندية. ومع ذلك، يتحول ملاذهم الهادئ إلى كابوس عندما يكتشفون جثة امرأة في حوض الاستحمام الساخن.</p>\r\n<p>بينما يتصارع الأصدقاء مع الصدمة والخوف، ترتفع التوترات، ويدركون أن كل واحد منهم يحمل أسرارًا يمكن أن تكشف حياتهم. ومع تزايد الشك والبارانويا، يجب عليهم مواجهة ماضيهم وفك شبكة الأكاذيب المحيطة بهم لكشف حقيقة ما حدث في تلك الليلة المشؤومة.</p>\r\n<p>يستكشف فيلم \"عدم الإزعاج\" المليء بالتقلبات والتشويق والعمق النفسي موضوعات الثقة والخيانة وعواقب الأسرار المدفونة. إنه يبقي القراء على حافة مقاعدهم وهم يتسابقون لكشف الغموض إلى جانب الشخصيات.</p>\r\n<p>\"لا تزعج\" هي رواية غامضة ومثيرة من تأليف الكاتبة البريطانية كلير دوجلاس. تدور القصة حول مجموعة من الأصدقاء الذين قرروا قضاء عطلة نهاية الأسبوع بعيدًا في نزل بعيد في المرتفعات الاسكتلندية. ومع ذلك، يتحول ملاذهم الهادئ إلى كابوس عندما يكتشفون جثة امرأة في حوض الاستحمام الساخن.</p>\r\n<p>بينما يتصارع الأصدقاء مع الصدمة والخوف، ترتفع التوترات، ويدركون أن كل واحد منهم يحمل أسرارًا يمكن أن تكشف حياتهم. ومع تزايد الشك والبارانويا، يجب عليهم مواجهة ماضيهم وفك شبكة الأكاذيب المحيطة بهم لكشف حقيقة ما حدث في تلك الليلة المشؤومة.</p>\r\n<p>يستكشف فيلم \"عدم الإزعاج\" المليء بالتقلبات والتشويق والعمق النفسي موضوعات الثقة والخيانة وعواقب الأسرار المدفونة. إنه يبقي القراء على حافة مقاعدهم وهم يتسابقون لكشف الغموض إلى جانب الشخصيات.</p>',NULL,NULL,'2024-05-06 03:52:19','2024-05-06 03:52:19'),
(163,20,63,81,NULL,'Stationary Bike','stationary-bike','Introducing the Stationary Bike, your ultimate companion in fitness journey and wellness. Designed to bring the exhilaration of cycling into the comfort of your home, this sleek and sturdy exercise bike offers a dynamic workout experience tailored to your needs.\r\n\r\nCrafted with premium materials and cutting-edge engineering, our Stationary Bike ensures durability and stability, providing a secure platform for your workouts. Whether you\'re a beginner looking to kickstart your fitness routine or a seasoned athlete aiming to push your limits, this bike is built to accommodate users of all fitness levels.','<p>Introducing the Stationary Bike, your ultimate companion in fitness journey and wellness. Designed to bring the exhilaration of cycling into the comfort of your home, this sleek and sturdy exercise bike offers a dynamic workout experience tailored to your needs.</p>\r\n<p>Crafted with premium materials and cutting-edge engineering, our Stationary Bike ensures durability and stability, providing a secure platform for your workouts. Whether you\'re a beginner looking to kickstart your fitness routine or a seasoned athlete aiming to push your limits, this bike is built to accommodate users of all fitness levels.</p>\r\n<p>Equipped with customizable resistance levels, the Stationary Bike allows you to tailor each session to your desired intensity, helping you achieve your fitness goals effectively. Its smooth and silent operation ensures a seamless ride, allowing you to focus on your workout without any distractions.</p>\r\n<p>Featuring an adjustable seat and handlebars, this bike offers optimal comfort and ergonomics, ensuring proper posture and minimizing strain during extended workouts. The intuitive LCD display keeps you informed of essential metrics such as speed, distance, time, and calories burned, empowering you to track your progress and stay motivated.</p>\r\n<p>Compact and space-saving, the Stationary Bike seamlessly integrates into any home environment, allowing you to enjoy convenient workouts without sacrificing precious space. Its lightweight yet robust construction makes it easy to move around, so you can find the perfect spot for your fitness endeavors.</p>\r\n<p>Experience the joy of cycling year-round, rain or shine, with the Stationary Bike. Whether you\'re aiming to improve your cardiovascular health, build strength, or simply stay active, this versatile exercise bike is your gateway to a healthier, happier lifestyle.</p>',NULL,NULL,'2024-05-06 03:56:09','2024-05-06 03:56:09'),
(164,21,64,81,NULL,'دراجة ثابتة','دراجة-ثابتة','نقدم لكم الدراجة الثابتة، رفيقكم المثالي في رحلة اللياقة البدنية والعافية. صُممت هذه الدراجة الرياضية الأنيقة والمتينة لجلب متعة ركوب الدراجات إلى راحة منزلك، وتوفر تجربة تمرين ديناميكية مصممة خصيصًا لتلبية احتياجاتك.\r\n\r\nتضمن دراجتنا الثابتة، المصنوعة من مواد فاخرة وهندسة متطورة، المتانة والثبات، وتوفر منصة آمنة لتدريباتك. سواء كنت مبتدئًا يتطلع إلى بدء روتين اللياقة البدنية الخاص بك أو رياضيًا متمرسًا يهدف إلى تجاوز حدودك، فقد تم تصميم هذه الدراجة لاستيعاب المستخدمين من جميع مستويات اللياقة البدنية.','<p>نقدم لكم الدراجة الثابتة، رفيقكم المثالي في رحلة اللياقة البدنية والعافية. صُممت هذه الدراجة الرياضية الأنيقة والمتينة لجلب متعة ركوب الدراجات إلى راحة منزلك، وتوفر تجربة تمرين ديناميكية مصممة خصيصًا لتلبية احتياجاتك.</p>\r\n<p>تضمن دراجتنا الثابتة، المصنوعة من مواد فاخرة وهندسة متطورة، المتانة والثبات، وتوفر منصة آمنة لتدريباتك. سواء كنت مبتدئًا يتطلع إلى بدء روتين اللياقة البدنية الخاص بك أو رياضيًا متمرسًا يهدف إلى تجاوز حدودك، فقد تم تصميم هذه الدراجة لاستيعاب المستخدمين من جميع مستويات اللياقة البدنية.</p>\r\n<p>تتيح لك الدراجة الثابتة، المجهزة بمستويات مقاومة قابلة للتخصيص، تصميم كل جلسة وفقًا للكثافة المرغوبة، مما يساعدك على تحقيق أهداف اللياقة البدنية الخاصة بك بفعالية. يضمن تشغيلها السلس والصامت قيادة سلسة، مما يسمح لك بالتركيز على تمرينك دون أي تشتيت.</p>\r\n<p>تتميز هذه الدراجة بمقعد ومقود قابلين للتعديل، وتوفر الراحة المثالية وبيئة العمل، مما يضمن الوضع المناسب وتقليل الضغط أثناء التدريبات الطويلة. تبقيك شاشة LCD البديهية على علم بالمقاييس الأساسية مثل السرعة والمسافة والوقت والسعرات الحرارية المحروقة، مما يتيح لك تتبع تقدمك والبقاء متحفزًا.</p>\r\n<p>مدمجة وموفرة للمساحة، تندمج الدراجة الثابتة بسلاسة في أي بيئة منزلية، مما يسمح لك بالاستمتاع بتمارين مريحة دون التضحية بالمساحة الثمينة. إن بنيتها خفيفة الوزن ولكنها قوية تجعل من السهل تحريكها، لذلك يمكنك العثور على المكان المثالي لمساعيك في اللياقة البدنية.</p>\r\n<p>استمتع بمتعة ركوب الدراجات على مدار العام، سواء كان الطقس ممطرًا أو مشمسًا، مع الدراجة الثابتة. سواء كنت تهدف إلى تحسين صحة القلب والأوعية الدموية، أو بناء القوة، أو ببساطة البقاء نشيطًا، فإن دراجة التمرين متعددة الاستخدامات هذه هي بوابتك إلى نمط حياة أكثر صحة وسعادة.</p>',NULL,NULL,'2024-05-06 03:56:09','2024-05-06 03:56:09'),
(165,20,61,82,NULL,'Ultrasound Machine','ultrasound-machine','An ultrasound machine is a crucial medical imaging tool that employs high-frequency sound waves to generate images of internal body structures. It comprises a transducer, which emits and receives the sound waves, a console for control and processing, and a display screen for image visualization. Operators manipulate the device by adjusting settings via a keyboard and controls on the console. Before scanning, a gel is applied to the skin to aid in sound wave transmission. These machines are widely used across medical settings for diagnostics, such as examining organs, monitoring pregnancies, and guiding procedures, offering real-time insights into the body\'s internal workings in a non-invasive and safe manner.','<p>Welcome to the cutting-edge world of medical imaging with our state-of-the-art Ultrasound Machine. Revolutionizing healthcare diagnostics, our Ultrasound Machine offers unparalleled clarity, precision, and versatility, empowering healthcare professionals to deliver exceptional patient care.</p>\r\n<p>Designed with the latest technological advancements, our Ultrasound Machine delivers high-definition imaging, providing detailed insights into anatomical structures with remarkable clarity. From superficial to deep tissue imaging, this advanced system offers exceptional resolution and contrast, enabling accurate diagnosis and treatment planning across a wide range of medical specialties.</p>\r\n<p>With an intuitive user interface and customizable imaging settings, our Ultrasound Machine offers a seamless and efficient workflow, enhancing productivity and reducing scan times. Its ergonomic design and user-friendly controls ensure ease of use for healthcare providers of all skill levels, facilitating confident and precise examinations.</p>\r\n<p>Equipped with a comprehensive suite of imaging modes and advanced features, including Doppler imaging and elastography, our Ultrasound Machine enables comprehensive diagnostic capabilities for a diverse range of clinical applications. Whether it\'s obstetrics, cardiology, musculoskeletal, or vascular imaging, this versatile system delivers exceptional performance and reliability.</p>\r\n<p>Compact yet powerful, our Ultrasound Machine is designed to adapt to diverse clinical environments, from busy hospital settings to remote clinics. Its lightweight and portable design facilitate easy maneuverability, allowing healthcare professionals to bring advanced imaging capabilities directly to the point of care.</p>\r\n<p>Experience the future of medical imaging with our Ultrasound Machine. Engineered for excellence, reliability, and innovation, it represents the pinnacle of diagnostic imaging technology, empowering healthcare providers to make confident diagnoses and improve patient outcomes with precision and efficiency.</p>',NULL,NULL,'2024-05-06 04:02:07','2024-05-06 04:02:07'),
(166,21,62,82,NULL,'آلة الموجات فوق الصوتية','آلة-الموجات-فوق-الصوتية','يعد جهاز الموجات فوق الصوتية أداة تصوير طبية مهمة تستخدم موجات صوتية عالية التردد لإنشاء صور لهياكل الجسم الداخلية. وهو يشتمل على محول طاقة، الذي يرسل ويستقبل الموجات الصوتية، ووحدة تحكم للتحكم والمعالجة، وشاشة عرض لتصور الصورة. يتلاعب المشغلون بالجهاز عن طريق ضبط الإعدادات عبر لوحة المفاتيح وعناصر التحكم الموجودة على وحدة التحكم. قبل المسح، يتم وضع مادة هلامية على الجلد للمساعدة في نقل الموجات الصوتية. تُستخدم هذه الآلات على نطاق واسع عبر الإعدادات الطبية للتشخيص، مثل فحص الأعضاء، ومراقبة حالات الحمل، وتوجيه الإجراءات، مما يوفر رؤى في الوقت الفعلي حول الأعمال الداخلية للجسم بطريقة غير جراحية وآمنة.','<p>مرحبًا بكم في عالم التصوير الطبي المتطور من خلال جهاز الموجات فوق الصوتية الحديث لدينا. أحدث ثورة في تشخيص الرعاية الصحية، حيث توفر آلة الموجات فوق الصوتية لدينا وضوحًا ودقة وتنوعًا لا مثيل له، مما يمكّن المتخصصين في الرعاية الصحية من تقديم رعاية استثنائية للمرضى.</p>\r\n<p>تم تصميم جهاز الموجات فوق الصوتية الخاص بنا بأحدث التطورات التكنولوجية، ويوفر تصويرًا عالي الدقة، مما يوفر رؤى تفصيلية للهياكل التشريحية بوضوح ملحوظ. من تصوير الأنسجة السطحية إلى العميقة، يوفر هذا النظام المتقدم دقة وتباينًا استثنائيين، مما يتيح التشخيص الدقيق والتخطيط للعلاج عبر مجموعة واسعة من التخصصات الطبية.</p>\r\n<p>بفضل واجهة المستخدم البديهية وإعدادات التصوير القابلة للتخصيص، يوفر جهاز الموجات فوق الصوتية الخاص بنا سير عمل سلسًا وفعالاً، مما يعزز الإنتاجية ويقلل أوقات المسح. يضمن تصميمه المريح وعناصر التحكم سهلة الاستخدام سهولة الاستخدام لمقدمي الرعاية الصحية من جميع مستويات المهارة، مما يسهل إجراء فحوصات موثوقة ودقيقة.</p>\r\n<p>مجهزة بمجموعة شاملة من أوضاع التصوير والميزات المتقدمة، بما في ذلك تصوير دوبلر وتصوير المرونة، تتيح آلة الموجات فوق الصوتية الخاصة بنا إمكانات تشخيصية شاملة لمجموعة متنوعة من التطبيقات السريرية. سواء كان الأمر يتعلق بالتوليد أو أمراض القلب أو تصوير العضلات والعظام أو تصوير الأوعية الدموية، فإن هذا النظام متعدد الاستخدامات يوفر أداءً وموثوقية استثنائيين.</p>\r\n<p>تم تصميم جهاز الموجات فوق الصوتية الخاص بنا، صغير الحجم ولكنه قوي، للتكيف مع البيئات السريرية المتنوعة، بدءًا من إعدادات المستشفيات المزدحمة وحتى العيادات البعيدة. ويسهل تصميمه خفيف الوزن والمحمول سهولة المناورة، مما يسمح لمتخصصي الرعاية الصحية بتوفير إمكانات التصوير المتقدمة مباشرة إلى نقطة الرعاية.</p>\r\n<p>اكتشف مستقبل التصوير الطبي مع جهاز الموجات فوق الصوتية الخاص بنا. تم تصميمه لتحقيق التميز والموثوقية والابتكار، وهو يمثل قمة تكنولوجيا التصوير التشخيصي، مما يمكّن مقدمي الرعاية الصحية من إجراء تشخيصات موثوقة وتحسين نتائج المرضى بدقة وكفاءة.</p>',NULL,NULL,'2024-05-06 04:02:07','2024-05-06 04:02:07'),
(167,20,61,83,NULL,'Defibrillator','defibrillator','A defibrillator is a medical device that delivers an electric shock to the heart to restore its normal rhythm during sudden cardiac arrest. It works by sending a high-energy pulse through the chest, momentarily stopping the heart\'s electrical activity, allowing it to reset and resume its normal beating pattern.','<p>A defibrillator is a crucial medical device designed to address life-threatening cardiac arrhythmias, particularly ventricular fibrillation (VF) and pulseless ventricular tachycardia (VT), which can lead to sudden cardiac arrest (SCA). SCA occurs when the heart\'s electrical system malfunctions, causing it to beat irregularly or stop altogether. Without prompt intervention, SCA can result in death within minutes.</p>\r\n<p>Defibrillators operate on the principle of delivering an electric shock to the heart to restore its normal rhythm. There are two main types of defibrillators: automated external defibrillators (AEDs) and implantable cardioverter-defibrillators (ICDs).</p>\r\n<p>AEDs are portable devices commonly found in public spaces, workplaces, and healthcare facilities. They are user-friendly and designed to be operated by laypeople with minimal training. A typical AED consists of adhesive electrode pads, which are placed on the patient\'s chest, and a control unit that analyzes the heart rhythm and delivers a shock if necessary. A voice prompt guides the user through the process, providing instructions on when to administer CPR and when to stand clear during shock delivery.</p>\r\n<p>ICDs, on the other hand, are implantable devices surgically placed under the skin, usually in the chest area. They continuously monitor the heart\'s rhythm and automatically deliver shocks if dangerous arrhythmias are detected. ICDs are recommended for individuals at high risk of recurrent arrhythmias, such as those with a history of cardiac arrest or certain cardiac conditions.</p>\r\n<p>The mechanism of action of defibrillation involves delivering a high-energy electrical pulse to the heart, momentarily depolarizing the cardiac cells and allowing the heart\'s natural pacemaker to reestablish a normal rhythm. This process, known as cardioversion, interrupts the chaotic electrical activity in the heart and enables it to resume coordinated contractions, restoring blood flow to vital organs.</p>\r\n<p>Prompt defibrillation is crucial for improving the chances of survival in SCA cases. For every minute that passes without defibrillation, the likelihood of successful resuscitation decreases by approximately 7-10%. Therefore, widespread access to defibrillators in public spaces, along with public awareness and training in cardiopulmonary resuscitation (CPR), plays a vital role in saving lives during cardiac</p>',NULL,NULL,'2024-05-06 04:06:50','2024-05-06 04:06:50'),
(168,21,62,83,NULL,'جهاز الصدمات الكهربائية','جهاز-الصدمات-الكهربائية','مزيل الرجفان هو جهاز طبي يقوم بتوصيل صدمة كهربائية للقلب لاستعادة إيقاعه الطبيعي أثناء السكتة القلبية المفاجئة. وهو يعمل عن طريق إرسال نبض عالي الطاقة عبر الصدر، مما يؤدي إلى إيقاف النشاط الكهربائي للقلب مؤقتًا، مما يسمح له بإعادة ضبط واستئناف نمط الضرب الطبيعي.','<p>مزيل الرجفان هو جهاز طبي مهم مصمم لمعالجة عدم انتظام ضربات القلب الذي يهدد الحياة، وخاصة الرجفان البطيني (VF) وعدم انتظام دقات القلب البطيني غير النبضي (VT)، والذي يمكن أن يؤدي إلى توقف القلب المفاجئ (SCA). يحدث SCA عندما يتعطل النظام الكهربائي للقلب، مما يؤدي إلى نبضه بشكل غير منتظم أو توقفه تمامًا. وبدون التدخل الفوري، يمكن أن يؤدي مرض SCA إلى الوفاة في غضون دقائق.</p>\r\n<p>تعمل أجهزة تنظيم ضربات القلب على مبدأ توصيل صدمة كهربائية إلى القلب لاستعادة إيقاعه الطبيعي. هناك نوعان رئيسيان من أجهزة تنظيم ضربات القلب: أجهزة تنظيم ضربات القلب الخارجية الآلية (AEDs) وأجهزة تنظيم ضربات القلب القابلة للزرع (ICDs).</p>\r\n<p>أجهزة AED هي أجهزة محمولة توجد عادة في الأماكن العامة وأماكن العمل ومرافق الرعاية الصحية. فهي سهلة الاستخدام ومصممة ليتم تشغيلها بواسطة أشخاص عاديين بأقل قدر من التدريب. يتكون جهاز AED النموذجي من وسادات قطبية لاصقة، يتم وضعها على صدر المريض، ووحدة تحكم تقوم بتحليل إيقاع القلب وتوجيه الصدمة إذا لزم الأمر. يقوم موجه صوتي بتوجيه المستخدم خلال العملية، ويوفر إرشادات حول متى يجب إدارة الإنعاش القلبي الرئوي ومتى يجب الوقوف بوضوح أثناء توصيل الصدمة.</p>\r\n<p>من ناحية أخرى، أجهزة ICD هي أجهزة قابلة للزرع يتم وضعها جراحياً تحت الجلد، عادة في منطقة الصدر. إنهم يراقبون إيقاع القلب بشكل مستمر ويوجهون الصدمات تلقائيًا في حالة اكتشاف حالات عدم انتظام ضربات القلب الخطيرة. يوصى باستخدام أجهزة ICD للأفراد المعرضين لخطر كبير من عدم انتظام ضربات القلب المتكررة، مثل أولئك الذين لديهم تاريخ من السكتة القلبية أو بعض حالات القلب.</p>\r\n<p>تتضمن آلية عمل إزالة الرجفان توصيل نبض كهربائي عالي الطاقة إلى القلب، وإزالة استقطاب خلايا القلب مؤقتًا والسماح لجهاز تنظيم ضربات القلب الطبيعي بالقلب باستعادة الإيقاع الطبيعي. هذه العملية، المعروفة باسم تقويم نظم القلب، تقطع النشاط الكهربائي الفوضوي في القلب وتمكنه من استئناف الانقباضات المنسقة، واستعادة تدفق الدم إلى الأعضاء الحيوية.</p>\r\n<p>يعد إزالة الرجفان الفوري أمرًا بالغ الأهمية لتحسين فرص البقاء على قيد الحياة في حالات SCA. لكل دقيقة تمر دون إزالة الرجفان، تقل احتمالية نجاح الإنعاش بنسبة 7-10٪ تقريبًا. ولذلك، فإن الوصول على نطاق واسع إلى أجهزة تنظيم ضربات القلب في الأماكن العامة، إلى جانب الوعي العام والتدريب على الإنعاش القلبي الرئوي (CPR)، يلعب دورًا حيويًا في إنقاذ الأرواح أثناء أمراض القلب.</p>',NULL,NULL,'2024-05-06 04:06:50','2024-05-06 04:06:50'),
(169,20,63,84,NULL,'Pull-Up Bar','pull-up-bar','A pull-up bar is a simple yet versatile piece of exercise equipment designed for upper body workouts. Typically mounted on a doorframe or installed as a standalone unit, it allows users to perform various exercises targeting muscles like the back, arms, and shoulders. By gripping the bar and lifting one\'s body weight, pull-ups and chin-ups engage multiple muscle groups, promoting strength and endurance. Portable options exist for home use, while gym-grade bars offer durability and stability for intensive workouts.','<p>Welcome to Pull-Up Pro, your premier destination for high-quality pull-up bars and home fitness equipment! At Pull-Up Pro, we are passionate about helping you achieve your fitness goals and build a stronger, healthier you from the comfort of your own home.</p>\r\n<p>Our extensive selection of pull-up bars caters to fitness enthusiasts of all levels, whether you\'re a beginner looking to kickstart your fitness journey or a seasoned athlete aiming to take your workouts to the next level. From doorway-mounted bars to freestanding power towers, we offer a variety of options to suit your space and training needs.</p>\r\n<p>Each pull-up bar in our collection is meticulously crafted from durable materials to ensure long-lasting performance and safety during your workouts. Our products undergo rigorous quality control measures to guarantee reliability and stability, giving you peace of mind as you focus on your fitness routine.</p>\r\n<p>But we\'re not just about pull-up bars – we\'re dedicated to providing a comprehensive home fitness experience. Explore our range of accessories, including resistance bands, ab straps, and suspension trainers, to enhance your workouts and target different muscle groups effectively.</p>\r\n<p>At Pull-Up Pro, customer satisfaction is our top priority. Our knowledgeable team is here to assist you every step of the way, from selecting the perfect equipment for your needs to offering expert advice on exercise techniques and training programs. We strive to create a seamless shopping experience, with fast shipping and hassle-free returns, so you can start working out sooner rather than later.</p>\r\n<p>Join the Pull-Up Pro community today and unlock your full fitness potential. Whether you\'re striving for strength, endurance, or overall wellness, we\'ve got the tools you need to succeed. Transform your home into a personal gym and make every workout count with Pull-Up Pro – because when it comes to fitness, excellence is non-negotiable.</p>',NULL,NULL,'2024-05-06 04:10:31','2024-05-06 04:10:31'),
(170,21,64,84,NULL,'اسحب الشريط','اسحب-الشريط','شريط السحب عبارة عن قطعة بسيطة ومتعددة الاستخدامات من معدات التمارين المصممة لتدريبات الجزء العلوي من الجسم. يتم تركيبه عادةً على إطار الباب أو تثبيته كوحدة مستقلة، وهو يسمح للمستخدمين بأداء تمارين مختلفة تستهدف العضلات مثل الظهر والذراعين والكتفين. من خلال الإمساك بالقضيب ورفع وزن الجسم، تعمل عمليات السحب والذقن على إشراك مجموعات عضلية متعددة، مما يعزز القوة والتحمل. توجد خيارات محمولة للاستخدام المنزلي، بينما توفر القضبان المخصصة للصالة الرياضية المتانة والثبات للتمرينات المكثفة.','<p>مرحبًا بك في  وجهتك الأولى لقضبان السحب ومعدات اللياقة البدنية المنزلية عالية الجودة! في  نحن متحمسون لمساعدتك على تحقيق أهداف اللياقة البدنية الخاصة بك وبناء جسم أقوى وأكثر صحة وأنت مرتاح في منزلك.</p>\r\n<p>تلبي مجموعتنا الواسعة من قضبان السحب احتياجات عشاق اللياقة البدنية من جميع المستويات، سواء كنت مبتدئًا يتطلع إلى بدء رحلة اللياقة البدنية الخاصة بك أو رياضيًا متمرسًا يهدف إلى الارتقاء بتدريباتك إلى المستوى التالي. بدءًا من القضبان المثبتة على المداخل وحتى أبراج الطاقة القائمة بذاتها، نقدم مجموعة متنوعة من الخيارات التي تناسب المساحة الخاصة بك واحتياجاتك التدريبية.</p>\r\n<p>تم تصميم كل شريط سحب في مجموعتنا بدقة من مواد متينة لضمان الأداء والسلامة طويل الأمد أثناء التدريبات. تخضع منتجاتنا لإجراءات صارمة لمراقبة الجودة لضمان الموثوقية والثبات، مما يمنحك راحة البال أثناء التركيز على روتين اللياقة البدنية الخاص بك.</p>\r\n<p>ولكننا لا نهتم فقط بقضبان السحب - فنحن ملتزمون بتقديم تجربة شاملة للياقة البدنية في المنزل. استكشف مجموعتنا من الملحقات، بما في ذلك أشرطة المقاومة، وأشرطة البطن، وأجهزة التدريب المعلقة، لتعزيز تدريباتك واستهداف مجموعات العضلات المختلفة بفعالية.</p>\r\n<p>في Pull-Up Pro، رضا العملاء هو أولويتنا القصوى. فريقنا واسع المعرفة موجود هنا لمساعدتك في كل خطوة على الطريق، بدءًا من اختيار المعدات المثالية التي تلبي احتياجاتك ووصولاً إلى تقديم مشورة الخبراء بشأن تقنيات التمارين وبرامج التدريب. نحن نسعى جاهدين لخلق تجربة تسوق سلسة، مع الشحن السريع والإرجاع بدون متاعب، حتى تتمكن من البدء في ممارسة التمارين الرياضية عاجلاً وليس آجلاً.</p>\r\n<p>انضم إلى مجتمع Pull-Up Pro اليوم واطلق العنان لإمكاناتك الكاملة في اللياقة البدنية. سواء كنت تسعى جاهدة للحصول على القوة أو القدرة على التحمل أو الصحة العامة، فلدينا الأدوات التي تحتاجها لتحقيق النجاح. قم بتحويل منزلك إلى صالة ألعاب رياضية شخصية واجعل كل تمرين مهمًا مع Pull-Up Pro - لأنه عندما يتعلق الأمر باللياقة البدنية، فإن التميز غير قابل للتفاوض.</p>',NULL,NULL,'2024-05-06 04:10:31','2024-05-06 04:10:31'),
(171,20,63,85,NULL,'Gym book Guidence','gym-book-guidence','\"Gym Book Guidance\" offers comprehensive advice on maximizing your fitness journey. From tailored workout plans to nutritional tips, it serves as a roadmap to achieving your fitness goals. Detailed exercise demonstrations ensure proper form and safety. Additionally, it provides insights into mental well-being, emphasizing the importance of motivation and consistency. With expert guidance on setting realistic targets and tracking progress, this book equips you with the knowledge and tools needed for a successful fitness transformation.','<p>\"Gym Book Guidance\" is a comprehensive manual designed to be your trusted companion on your fitness journey. Within its pages, you\'ll find a wealth of knowledge curated to empower you with the tools and strategies necessary to achieve your fitness aspirations.</p>\r\n<p>The book begins by delving into the fundamental principles of fitness, laying a solid foundation for understanding the intricate relationship between exercise, nutrition, and mental well-being. It then seamlessly transitions into practical guidance, offering customized workout plans tailored to different fitness levels and goals. Whether you\'re a beginner looking to establish a consistent exercise routine or a seasoned athlete aiming to break through plateaus, you\'ll find targeted exercises and routines to suit your needs.</p>\r\n<p>What sets \"Gym Book Guidance\" apart is its emphasis on proper form and technique. Detailed instructions and illustrations accompany each exercise, ensuring that you perform movements safely and effectively, minimizing the risk of injury while maximizing results. Additionally, the book provides invaluable insights into nutrition, offering practical advice on fueling your body for optimal performance and recovery.</p>\r\n<p>But \"Gym Book Guidance\" is more than just a compilation of exercises and meal plans; it\'s a holistic approach to fitness that recognizes the importance of mental well-being. Throughout the book, you\'ll find motivational tips and strategies to overcome obstacles and stay committed to your goals.</p>\r\n<p>Whether you\'re striving to build muscle, lose weight, or improve overall health and vitality, \"Gym Book Guidance\" equips you with the knowledge and support you need to succeed on your fitness journey.</p>',NULL,NULL,'2024-05-07 21:41:09','2024-05-07 21:41:09'),
(172,21,64,85,NULL,'إرشادات كتاب الصالة الرياضية-','إرشادات-كتاب-الصالة-الرياضية-','يقدم \"إرشادات كتاب الصالة الرياضية-\" نصيحة شاملة حول تحقيق أقصى قدر من رحلة اللياقة البدنية الخاصة بك. بدءًا من خطط التمارين المصممة خصيصًا وحتى النصائح الغذائية، فهو بمثابة خريطة طريق لتحقيق أهداف اللياقة البدنية الخاصة بك. تضمن العروض التوضيحية التفصيلية للتمرين الشكل والسلامة المناسبين. بالإضافة إلى ذلك، فإنه يوفر نظرة ثاقبة للصحة العقلية، مع التركيز على أهمية الدافع والاتساق. بفضل إرشادات الخبراء حول تحديد أهداف واقعية وتتبع التقدم، يزودك هذا الكتاب بالمعرفة والأدوات اللازمة لتحقيق تحول ناجح في اللياقة البدنية.','<p>\"إرشادات كتاب الصالة الرياضية\" هو دليل شامل مصمم ليكون رفيقك الموثوق به في رحلة اللياقة البدنية الخاصة بك. ستجد ضمن صفحاته ثروة من المعرفة تم إعدادها لتمكينك من خلال الأدوات والاستراتيجيات اللازمة لتحقيق تطلعاتك في اللياقة البدنية.</p>\r\n<p>يبدأ الكتاب بالتعمق في المبادئ الأساسية للياقة البدنية، ووضع أساس متين لفهم العلاقة المعقدة بين التمارين الرياضية والتغذية والصحة العقلية. ثم ينتقل بسلاسة إلى التوجيه العملي، حيث يقدم خطط تمرين مخصصة مصممة خصيصًا لمستويات وأهداف اللياقة البدنية المختلفة. سواء كنت مبتدئًا يتطلع إلى إنشاء روتين تمرين ثابت أو رياضيًا متمرسًا يهدف إلى اختراق حالة الاستقرار، ستجد تمارين وروتينية مستهدفة تناسب احتياجاتك.</p>\r\n<p>ما يميز \"\"إرشادات كتاب الصالة الرياضية\" هو تركيزه على الشكل والتقنية المناسبين. تعليمات مفصلة ورسوم توضيحية تصاحب كل تمرين، مما يضمن أداء الحركات بأمان وفعالية، ويقلل من خطر الإصابة مع تحقيق أقصى قدر من النتائج. بالإضافة إلى ذلك، يقدم الكتاب رؤى لا تقدر بثمن في مجال التغذية، ويقدم نصائح عملية حول تزويد جسمك بالطاقة لتحقيق الأداء الأمثل والتعافي.</p>\r\n<p>لكن \"إرشادات كتاب الصالة الرياضية\" هو أكثر من مجرد مجموعة من التمارين وخطط الوجبات؛ إنه نهج شامل للياقة البدنية يدرك أهمية الصحة العقلية. ستجد في جميع أنحاء الكتاب نصائح واستراتيجيات تحفيزية للتغلب على العقبات والبقاء ملتزمًا بأهدافك.</p>\r\n<p>سواء كنت تسعى جاهدة لبناء العضلات، أو إنقاص الوزن، أو تحسين الصحة والحيوية بشكل عام، فإن \"Gym Book Guidance\" يزودك بالمعرفة والدعم الذي تحتاجه للنجاح في رحلة اللياقة البدنية الخاصة بك.</p>',NULL,NULL,'2024-05-07 21:41:09','2024-05-07 21:41:09'),
(200,20,65,118,NULL,'Trade mill','trade-mill','','<p>A treadmill is one of the most popular and useful fitness machines used for walking, jogging, and running indoors. It is designed with a moving belt that allows a person to exercise in one place without going outside. A treadmill is suitable for people of almost all fitness levels, from beginners to professional athletes. It is commonly used at homes, gyms, fitness centers, hospitals, and rehabilitation centers.</p>\r\n<p>The main purpose of a treadmill is to improve physical fitness, burn calories, strengthen muscles, and support a healthy lifestyle. It helps increase heart rate, improve blood circulation, and build stamina. Regular treadmill exercise can also help reduce body fat, control weight, improve lung capacity, and maintain overall health. For people who cannot go outside because of bad weather, lack of time, or unsafe roads, a treadmill is a very convenient option.</p>\r\n<p>Most modern treadmills come with different speed levels, incline settings, heart rate sensors, calorie counters, distance trackers, and workout programs. The speed can be adjusted according to the user’s comfort. Beginners can start with slow walking, while experienced users can increase the speed for jogging or running. The incline feature makes the workout more challenging by creating the feeling of walking or running uphill. This helps burn more calories and strengthen the legs.</p>\r\n<p>A treadmill is also useful because it allows users to track their progress. The display screen usually shows time, speed, distance, calories burned, and heart rate. This information helps users understand their performance and set fitness goals. Some advanced treadmills also include Bluetooth, speakers, touchscreens, app connectivity, and pre-set training programs.</p>\r\n<p>Using a treadmill regularly can have many health benefits. It helps improve cardiovascular health, increases energy levels, reduces stress, and supports better sleep. It is also helpful for people who want to maintain a daily exercise routine. Since treadmill workouts can be done indoors, users can exercise at any time of the day.</p>\r\n<p>However, safety is very important while using a treadmill. Users should start slowly, wear proper shoes, keep their body balanced, and avoid sudden speed changes. Many treadmills have emergency stop buttons or safety clips to prevent accidents. Proper maintenance is also necessary to keep the treadmill working smoothly. The belt should be cleaned, checked, and lubricated when needed.</p>\r\n<p>In conclusion, a treadmill is an excellent fitness machine for indoor exercise. It is easy to use, effective, and suitable for different fitness goals. Whether someone wants to lose weight, improve stamina, stay active, or maintain good health, a treadmill can be a very helpful exercise equipment.</p>',NULL,NULL,'2025-11-03 06:53:53','2026-05-12 23:34:50'),
(201,21,64,118,NULL,'مطحنة التجارة','مطحنة-التجارة','','<p>جهاز المشي الكهربائي، أو ما يُعرف بالتريدميل، هو واحد من أشهر أجهزة اللياقة البدنية وأكثرها استخدامًا لممارسة المشي والركض والجري داخل المنزل أو في صالات الرياضة. يتميز هذا الجهاز بوجود حزام متحرك يساعد المستخدم على ممارسة التمارين في مكان ثابت دون الحاجة إلى الخروج إلى الشارع أو الحديقة.</p>\r\n<p>يُستخدم جهاز المشي لتحسين اللياقة البدنية، حرق السعرات الحرارية، تقوية عضلات الجسم، والمحافظة على نمط حياة صحي. كما يساعد على تحسين صحة القلب، تنشيط الدورة الدموية، زيادة القدرة على التحمل، وتقليل الدهون في الجسم. ويُعد خيارًا مناسبًا للأشخاص الذين لا يستطيعون ممارسة الرياضة في الخارج بسبب سوء الطقس أو ضيق الوقت أو عدم توفر مكان مناسب للمشي.</p>\r\n<p>تتوفر في معظم أجهزة المشي الحديثة عدة مميزات مثل التحكم في السرعة، ضبط مستوى الميل، قياس نبضات القلب، حساب السعرات الحرارية، عرض المسافة المقطوعة، وتحديد مدة التمرين. يستطيع المبتدئ أن يبدأ بالمشي البطيء، بينما يمكن للشخص المتقدم زيادة السرعة للركض أو الجري. كما أن خاصية الميل تجعل التمرين أكثر صعوبة وتشبه المشي على طريق مرتفع، مما يساعد على حرق سعرات حرارية أكثر وتقوية عضلات الساقين.</p>\r\n<p>يساعد جهاز المشي المستخدم على متابعة تقدمه بشكل واضح، حيث تعرض الشاشة معلومات مهمة مثل الوقت، السرعة، المسافة، السعرات المحروقة، ومعدل ضربات القلب. وبعض الأجهزة المتطورة تحتوي أيضًا على تقنيات حديثة مثل البلوتوث، السماعات، الشاشة اللمسية، والاتصال بتطبيقات اللياقة البدنية.</p>\r\n<p>إن استخدام جهاز المشي بانتظام له فوائد صحية عديدة، فهو يساعد على تقوية القلب، زيادة النشاط والطاقة، تقليل التوتر، تحسين النوم، والمحافظة على الوزن المثالي. كما أنه مناسب للأشخاص من مختلف الأعمار ومستويات اللياقة، بشرط استخدامه بطريقة صحيحة وآمنة.</p>\r\n<p>ومن المهم عند استخدام جهاز المشي ارتداء حذاء رياضي مناسب، البدء بسرعة منخفضة، الحفاظ على توازن الجسم، وعدم تغيير السرعة بشكل مفاجئ. كما تحتوي العديد من الأجهزة على زر إيقاف طارئ أو مفتاح أمان لحماية المستخدم من الحوادث. ويجب أيضًا الاهتمام بتنظيف الجهاز وصيانته بانتظام حتى يعمل بشكل جيد لفترة طويلة.</p>\r\n<p>في الختام، يُعتبر جهاز المشي الكهربائي من أفضل أجهزة التمارين المنزلية والرياضية، لأنه سهل الاستخدام وفعّال ومناسب لتحقيق أهداف صحية مختلفة مثل إنقاص الوزن، تحسين اللياقة، زيادة القدرة على التحمل، والمحافظة على</p>',NULL,NULL,'2025-11-03 06:53:53','2026-05-12 23:34:50');
/*!40000 ALTER TABLE `product_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_coupons`
--

DROP TABLE IF EXISTS `product_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_coupons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` decimal(8,2) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `minimum_spend` decimal(8,2) unsigned DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_coupons`
--

LOCK TABLES `product_coupons` WRITE;
/*!40000 ALTER TABLE `product_coupons` DISABLE KEYS */;
INSERT INTO `product_coupons` VALUES
(12,'Hot Sell','hotsell','fixed',70.00,'2024-03-09','2028-07-26',100.00,NULL,'2023-07-12 00:29:49','2024-05-01 03:57:30'),
(19,'Flash Discount','F0080','percentage',10.00,'2024-04-30','2025-09-28',0.00,NULL,'2024-05-01 03:56:55','2025-11-22 03:23:07'),
(21,'low price','low','fixed',34.00,'2025-09-01','2025-10-09',33.00,207,'2025-09-17 03:57:38','2025-09-17 04:01:04');
/*!40000 ALTER TABLE `product_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_messages`
--

DROP TABLE IF EXISTS `product_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_messages`
--

LOCK TABLES `product_messages` WRITE;
/*!40000 ALTER TABLE `product_messages` DISABLE KEYS */;
INSERT INTO `product_messages` VALUES
(1,2,204,'Azim Ahmed','daspobin027@gmail.com','Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?','2024-05-07 23:39:58','2024-05-07 23:39:58'),
(2,3,204,'المثالية مع','azimahmed11040@gmail.com','Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?','2024-05-07 23:40:17','2024-05-07 23:40:17'),
(3,2,204,'Flash Discount','daspobin027@gmail.com','Can you provide insights into any upcoming developments or expansions for Dreamscapes Travel Agency?','2024-05-07 23:40:42','2024-05-07 23:40:42'),
(5,113,222,'Ashton Burns','xobeca@mailinator.com','Dolores ut earum dol','2025-10-25 06:30:30','2025-10-25 06:30:30'),
(6,117,207,'Bevis Bishop','cejope8172@hh7f.com','{\"phone_number\":{\"value\":\"+1 (903) 568-5323\",\"type\":1},\"product_name\":{\"value\":\"Todd Guerrero\",\"type\":1},\"quantity_needed\":{\"value\":\"326\",\"type\":1},\"product_details\":{\"value\":\"Sit repellendus Ut\",\"type\":5},\"delivery_location\":{\"value\":\"Rerum suscipit at qu\",\"type\":1},\"expected_delivery_date\":{\"value\":\"1977-04-29\",\"type\":6},\"expected_budget_(optional)\":{\"value\":\"79\",\"type\":2},\"additional_comments\\/note\":{\"value\":\"Beatae dolorum conse\",\"type\":1}}','2025-10-27 06:01:49','2025-10-27 06:01:49'),
(7,117,207,'Quinlan Burnett','cejope8172@hh7f.com','{\"phone_number\":{\"value\":\"+1 (358) 386-2379\",\"type\":1},\"product_name\":{\"value\":\"Mary Nash\",\"type\":1},\"quantity_needed\":{\"value\":\"930\",\"type\":1},\"product_details\":{\"value\":\"Nulla culpa sed sed\",\"type\":5},\"delivery_location\":{\"value\":\"Vel velit eveniet\",\"type\":1},\"expected_delivery_date\":{\"value\":\"1990-10-16\",\"type\":6},\"expected_budget_(optional)\":{\"value\":\"24\",\"type\":2},\"additional_comments\\/note\":{\"value\":\"Velit tempore sapie\",\"type\":1}}','2025-10-27 06:07:19','2025-10-27 06:07:19');
/*!40000 ALTER TABLE `product_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_orders`
--

DROP TABLE IF EXISTS `product_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `order_number` varchar(255) NOT NULL,
  `billing_name` varchar(255) NOT NULL,
  `billing_email` varchar(255) NOT NULL,
  `billing_phone` varchar(255) NOT NULL,
  `billing_address` varchar(255) NOT NULL,
  `billing_city` varchar(255) NOT NULL,
  `billing_state` varchar(255) DEFAULT NULL,
  `billing_country` varchar(255) NOT NULL,
  `shipping_name` varchar(255) NOT NULL,
  `shipping_email` varchar(255) NOT NULL,
  `shipping_phone` varchar(255) NOT NULL,
  `shipping_address` varchar(255) NOT NULL,
  `shipping_city` varchar(255) NOT NULL,
  `shipping_state` varchar(255) DEFAULT NULL,
  `shipping_country` varchar(255) NOT NULL,
  `total` decimal(8,2) unsigned NOT NULL,
  `discount` decimal(8,2) unsigned DEFAULT NULL,
  `product_shipping_charge_id` bigint(20) unsigned DEFAULT NULL,
  `shipping_cost` decimal(8,2) unsigned DEFAULT NULL,
  `tax` decimal(8,2) unsigned NOT NULL,
  `grand_total` decimal(8,2) unsigned NOT NULL,
  `currency_text` varchar(255) NOT NULL,
  `currency_text_position` varchar(255) NOT NULL,
  `currency_symbol` varchar(255) NOT NULL,
  `currency_symbol_position` varchar(255) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `gateway_type` varchar(255) NOT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conversation_id` varchar(255) DEFAULT NULL,
  `vendor_id` bigint(20) unsigned DEFAULT NULL,
  `total_commission` decimal(12,2) DEFAULT NULL,
  `admin_amount_with_commission` decimal(16,2) DEFAULT NULL,
  `vendor_net_amount` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`vendor_net_amount`)),
  `per_vendor_discount_and_commission` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`per_vendor_discount_and_commission`)),
  `fcm_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_orders_user_id_foreign` (`user_id`),
  CONSTRAINT `product_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_orders`
--

LOCK TABLES `product_orders` WRITE;
/*!40000 ALTER TABLE `product_orders` DISABLE KEYS */;
INSERT INTO `product_orders` VALUES
(42,1,'663af98139f93','Azim Ahmed','azimahmed11040@gmail.com','01775891798','uttara','Dhaka',NULL,'Bangladesh','Azim Ahmed','azimahmed11040@gmail.com','01775891798','uttara','Dhaka',NULL,'Bangladesh',3046.00,0.00,13,0.00,152.30,3198.30,'USD','left','$','left','Stripe','online','completed','completed',NULL,'663af98139f93.pdf','2024-05-07 22:03:13','2024-05-07 22:04:19',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(43,1,'663afaa4b22fd','Azim Ahmed','azimahmed11040@gmail.com','01775891798','uttara','Dhaka',NULL,'Bangladesh','Azim Ahmed','azimahmed11040@gmail.com','01775891798','uttara','Dhaka',NULL,'Bangladesh',4178.00,0.00,14,5.00,208.90,4391.90,'USD','left','$','left','PayPal','online','completed','processing',NULL,'663afaa4b22fd.pdf','2024-05-07 22:08:04','2024-05-07 22:08:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(44,1,'663afba4ed827','Azim Ahmed','azimahmed11040@gmail.com','01775891798','uttara','Dhaka',NULL,'Bangladesh','Azim Ahmed','azimahmed11040@gmail.com','01775891798','uttara','Dhaka',NULL,'Bangladesh',1597.00,0.00,14,5.00,79.85,1681.85,'USD','left','$','left','Citibank','offline','rejected','rejected',NULL,NULL,'2024-05-07 22:12:20','2024-05-07 22:12:36',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(45,1,'663affaad00a4','Azim Ahmed','azimahmed11040@gmail.com','01775891798','uttara','Dhaka',NULL,'Bangladesh','Azim Ahmed','azimahmed11040@gmail.com','01775891798','uttara','Dhaka',NULL,'Bangladesh',977.00,0.00,14,5.00,48.85,1030.85,'USD','left','$','left','Bank of America','offline','pending','pending','663affaace58d.jpg',NULL,'2024-05-07 22:29:30','2024-05-07 22:29:30',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(63,2,'6908a702bb478','Bill Gates','daspobin027@gmail.com','9932323232','945 Madison Ave, New York, NY 10021, USA','New York','New York','United States','Bill Gates','daspobin027@gmail.com','9932323232','945 Madison Ave, New York, NY 10021, USA','New York','New York','United States',222.00,0.00,15,10.00,12.00,244.00,'PHP','right','$','left','Xendit','online','completed','pending',NULL,'6908a702bb478.pdf','2025-11-03 06:58:42','2025-11-03 06:58:43',NULL,NULL,12.30,111.30,'{\"204\": 110.7}','{\"204\": {\"tax_share\": 6.65, \"cart_total\": 123, \"commission\": 12.3, \"discount_share\": 0, \"net_total_after_subtract\": 110.7}}',NULL),
(65,NULL,'6921a28de4689','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka','','bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka',NULL,'bangladesh',9.00,0.00,NULL,0.00,0.00,9.00,'USD','right','$','left','PayPal','online','completed','pending',NULL,'6921a28de4689.pdf','2025-11-22 05:46:21','2025-11-22 05:46:22',NULL,NULL,0.00,9.00,'[]','[]',NULL),
(66,NULL,'6921a2b859de5','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka','','bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka',NULL,'bangladesh',9.00,2.00,NULL,0.00,0.00,7.00,'USD','right','$','left','PayPal','online','completed','pending',NULL,'6921a2b859de5.pdf','2025-11-22 05:47:04','2025-11-22 05:47:04',NULL,NULL,0.00,7.00,'[]','[]',NULL),
(67,NULL,'6921a3801d3fc','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka','','bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka',NULL,'bangladesh',9.00,2.00,NULL,0.00,0.00,7.00,'USD','right','$','left','PayPal','online','completed','pending',NULL,'6921a3801d3fc.pdf','2025-11-22 05:50:24','2025-11-22 05:50:24',NULL,NULL,0.00,7.00,'[]','[]',NULL),
(68,NULL,'6921a58048e87','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka','','bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka',NULL,'bangladesh',9.00,2.00,NULL,0.00,0.00,7.00,'USD','right','$','left','bkash','offline','completed','pending',NULL,'6921a58048e87.pdf','2025-11-22 05:58:56','2025-11-22 05:59:07',NULL,NULL,0.00,7.00,'[]','[]',NULL),
(69,NULL,'6921a633196dc','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka','','bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','uttarra','dhaka',NULL,'bangladesh',9.00,2.00,NULL,0.00,0.00,7.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6921a633196dc.pdf','2025-11-22 06:01:55','2025-11-22 06:01:55',NULL,NULL,0.00,7.00,'[]','[]',NULL),
(70,NULL,'6921a7cca0a85','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,NULL,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6921a7cca0a85.pdf','2025-11-22 06:08:44','2025-11-22 06:08:45',NULL,NULL,0.00,9.00,'[]','[]',NULL),
(71,NULL,'6921aff574842','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,NULL,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6921aff574842.pdf','2025-11-22 06:43:33','2025-11-22 06:43:33',NULL,NULL,0.00,9.00,'[]','[]',NULL),
(72,NULL,'6926b28c3fe83','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,NULL,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6926b28c3fe83.pdf','2025-11-26 01:55:56','2025-11-26 01:55:58',NULL,NULL,0.00,9.00,'[]','[]',NULL),
(73,NULL,'6933d8eb3266c','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,13,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6933d8eb3266c.pdf','2025-12-06 01:19:07','2025-12-06 01:19:08',NULL,NULL,0.00,9.00,'[]','[]',NULL),
(74,NULL,'6933ed740c25d','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,13,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6933ed740c25d.pdf','2025-12-06 02:46:44','2025-12-06 02:46:44',NULL,NULL,0.00,9.00,'[]','[]','bkash'),
(75,NULL,'6933ef23370ac','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,13,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6933ef23370ac.pdf','2025-12-06 02:53:55','2025-12-06 02:53:55',NULL,NULL,0.00,9.00,'[]','[]','bkash'),
(76,NULL,'6933ef41e2e7f','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,13,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6933ef41e2e7f.pdf','2025-12-06 02:54:25','2025-12-06 02:54:26',NULL,NULL,0.00,9.00,'[]','[]','bk jfghjash'),
(77,NULL,'6933ef5c70001','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,13,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6933ef5c70001.pdf','2025-12-06 02:54:52','2025-12-06 02:54:52',NULL,NULL,0.00,9.00,'[]','[]','bk jfghjash'),
(78,NULL,'6933ef6a09965','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,13,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6933ef6a09965.pdf','2025-12-06 02:55:06','2025-12-06 02:55:06',NULL,NULL,0.00,9.00,'[]','[]','bk jfghjash'),
(79,NULL,'6933ef79ece53','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka','','Bangladesh','saiful islam sharif','saifislamfci@gmail.com','01872330757','Bangladesh','Dhaka',NULL,'Bangladesh',9.00,0.00,13,0.00,0.00,9.00,'USD','right','$','left','bkash','offline','pending','pending',NULL,'6933ef79ece53.pdf','2025-12-06 02:55:21','2025-12-06 02:55:22',NULL,NULL,0.00,9.00,'[]','[]','bk jfghjash'),
(84,2,'6a01d36991d7e','Bill Gates','daspobin027@gmail.com','11112','sasasasassasasasa','asasasas','sasasa','sasassa','Bill Gates','daspobin027@gmail.com','11112','sasasasassasasasa','asasasas','sasasa','sasassa',399.00,0.00,13,0.00,20.00,419.00,'USD','right','$','left','Bank of America','offline','completed','completed','6a01d3698fa3a.png','6a01d36991d7e.pdf','2026-05-11 07:02:33','2026-05-11 07:05:20',NULL,NULL,39.90,39.90,'{\"201\": 359.1}','{\"201\": {\"tax_share\": 20, \"cart_total\": 399, \"commission\": 39.900000000000006, \"discount_share\": 0, \"net_total_after_subtract\": 359.1}}',NULL),
(90,2,'6a01e73d9ab9a','xagovynuk@mailinator.com','kefeqeni@mailinator.com','wyqesom@mailinator.com','Iusto architecto dis','jeqylofyx@mailinator.com','jaxunugodo@mailinator.com','jaqegovaqa@mailinator.com','xagovynuk@mailinator.com','kefeqeni@mailinator.com','wyqesom@mailinator.com','Iusto architecto dis','jeqylofyx@mailinator.com','jaxunugodo@mailinator.com','jaqegovaqa@mailinator.com',399.00,0.00,13,0.00,20.00,419.00,'USD','right','$','left','Bank of America','offline','pending','pending','6a01e73d99247.png',NULL,'2026-05-11 08:27:09','2026-05-11 08:27:09',NULL,NULL,39.90,39.90,'{\"201\": 359.1}','{\"201\": {\"tax_share\": 20, \"cart_total\": 399, \"commission\": 39.900000000000006, \"discount_share\": 0, \"net_total_after_subtract\": 359.1}}',NULL),
(91,2,'6a01e7cb04262','vepah@mailinator.com','nesywurojy@mailinator.com','rypa@mailinator.com','Magni sunt voluptate','mazudov@mailinator.com','miqawe@mailinator.com','vonipe@mailinator.com','vepah@mailinator.com','nesywurojy@mailinator.com','rypa@mailinator.com','Magni sunt voluptate','mazudov@mailinator.com','miqawe@mailinator.com','vonipe@mailinator.com',399.00,0.00,13,0.00,20.00,419.00,'USD','right','$','left','Bank of America','offline','pending','pending','6a01e7cb02442.png',NULL,'2026-05-11 08:29:31','2026-05-11 08:29:31',NULL,NULL,39.90,39.90,'{\"201\": 359.1}','{\"201\": {\"tax_share\": 20, \"cart_total\": 399, \"commission\": 39.900000000000006, \"discount_share\": 0, \"net_total_after_subtract\": 359.1}}',NULL);
/*!40000 ALTER TABLE `product_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_purchase_items`
--

DROP TABLE IF EXISTS `product_purchase_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_purchase_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `vendor_id` bigint(20) unsigned DEFAULT NULL,
  `vendor_net_amount` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_purchase_items_product_order_id_foreign` (`product_order_id`),
  KEY `product_purchase_items_product_id_foreign` (`product_id`),
  CONSTRAINT `product_purchase_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_purchase_items_product_order_id_foreign` FOREIGN KEY (`product_order_id`) REFERENCES `product_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_purchase_items`
--

LOCK TABLES `product_purchase_items` WRITE;
/*!40000 ALTER TABLE `product_purchase_items` DISABLE KEYS */;
INSERT INTO `product_purchase_items` VALUES
(61,42,85,'Gym book Guidence',1,'2024-05-07 22:03:13','2024-05-07 22:03:13',NULL,NULL),
(62,42,83,'Defibrillator',1,'2024-05-07 22:03:13','2024-05-07 22:03:13',NULL,NULL),
(63,42,84,'Pull-Up Bar',1,'2024-05-07 22:03:13','2024-05-07 22:03:13',NULL,NULL),
(64,42,78,'Salon Chair',1,'2024-05-07 22:03:13','2024-05-07 22:03:13',NULL,NULL),
(65,42,71,'Surgical Lights',1,'2024-05-07 22:03:13','2024-05-07 22:03:13',NULL,NULL),
(66,42,73,'Infusion Pump',1,'2024-05-07 22:03:13','2024-05-07 22:03:13',NULL,NULL),
(67,43,85,'Gym book Guidence',1,'2024-05-07 22:08:04','2024-05-07 22:08:04',NULL,NULL),
(68,43,80,'Do not Distrub',1,'2024-05-07 22:08:04','2024-05-07 22:08:04',NULL,NULL),
(69,43,83,'Defibrillator',4,'2024-05-07 22:08:04','2024-05-07 22:08:04',NULL,NULL),
(70,43,78,'Salon Chair',2,'2024-05-07 22:08:04','2024-05-07 22:08:04',NULL,NULL),
(71,43,73,'Infusion Pump',3,'2024-05-07 22:08:04','2024-05-07 22:08:04',NULL,NULL),
(72,44,83,'Defibrillator',1,'2024-05-07 22:12:20','2024-05-07 22:12:20',NULL,NULL),
(73,44,79,'Shampoo Bowl',1,'2024-05-07 22:12:21','2024-05-07 22:12:21',NULL,NULL),
(74,44,74,'Treadmill',1,'2024-05-07 22:12:21','2024-05-07 22:12:21',NULL,NULL),
(75,45,77,'Hair Curler',1,'2024-05-07 22:29:30','2024-05-07 22:29:30',NULL,NULL),
(76,45,79,'Shampoo Bowl',1,'2024-05-07 22:29:30','2024-05-07 22:29:30',NULL,NULL),
(77,45,81,'Stationary Bike',1,'2024-05-07 22:29:30','2024-05-07 22:29:30',NULL,NULL),
(112,63,118,'Exercise Bike',1,'2025-11-03 06:58:42','2025-11-03 06:58:42',204,NULL),
(113,63,79,'Shampoo Bowl',1,'2025-11-03 06:58:42','2025-11-03 06:58:42',NULL,NULL),
(116,65,80,'Do not Distrub',2,'2025-11-22 05:46:21','2025-11-22 05:46:21',NULL,NULL),
(117,66,80,'Do not Distrub',2,'2025-11-22 05:47:04','2025-11-22 05:47:04',NULL,NULL),
(118,67,80,'Do not Distrub',2,'2025-11-22 05:50:24','2025-11-22 05:50:24',NULL,NULL),
(119,68,80,'Do not Distrub',2,'2025-11-22 05:58:56','2025-11-22 05:58:56',NULL,NULL),
(120,69,80,'Do not Distrub',2,'2025-11-22 06:01:55','2025-11-22 06:01:55',NULL,NULL),
(121,70,80,'Do not Distrub',2,'2025-11-22 06:08:44','2025-11-22 06:08:44',NULL,NULL),
(122,71,80,'Do not Distrub',2,'2025-11-22 06:43:33','2025-11-22 06:43:33',NULL,NULL),
(123,72,80,'Do not Distrub',2,'2025-11-26 01:55:56','2025-11-26 01:55:56',NULL,NULL),
(124,73,80,'Do not Distrub',2,'2025-12-06 01:19:07','2025-12-06 01:19:07',NULL,NULL),
(125,74,80,'Do not Distrub',2,'2025-12-06 02:46:44','2025-12-06 02:46:44',NULL,NULL),
(126,75,80,'Do not Distrub',2,'2025-12-06 02:53:55','2025-12-06 02:53:55',NULL,NULL),
(127,76,80,'Do not Distrub',2,'2025-12-06 02:54:25','2025-12-06 02:54:25',NULL,NULL),
(128,77,80,'Do not Distrub',2,'2025-12-06 02:54:52','2025-12-06 02:54:52',NULL,NULL),
(129,78,80,'Do not Distrub',2,'2025-12-06 02:55:06','2025-12-06 02:55:06',NULL,NULL),
(130,79,80,'Do not Distrub',2,'2025-12-06 02:55:21','2025-12-06 02:55:21',NULL,NULL),
(135,84,78,'Salon Chair',1,'2026-05-11 07:02:33','2026-05-11 07:02:33',201,NULL),
(141,90,78,'Salon Chair',1,'2026-05-11 08:27:09','2026-05-11 08:27:09',201,NULL),
(142,91,78,'Salon Chair',1,'2026-05-11 08:29:31','2026-05-11 08:29:31',201,NULL);
/*!40000 ALTER TABLE `product_purchase_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `comment` text DEFAULT NULL,
  `rating` smallint(5) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_reviews_user_id_foreign` (`user_id`),
  KEY `product_reviews_product_id_foreign` (`product_id`),
  CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_reviews`
--

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;
INSERT INTO `product_reviews` VALUES
(2,1,85,'\"Guidance\" is not just a book; it\'s a personal trainer, a nutritionist, and a motivator, all bound within its pages. From the moment I cracked it open, I knew I had found the ultimate companion for my fitness journey.\r\n\r\nWhat sets \"Guidance\" apart is its holistic approach to health and fitness. It doesn\'t just focus on workouts; it delves deep into the science behind exercise, nutrition, and mindset. The explanations are clear and concise, making complex concepts easy to understand for beginners and seasoned gym-goers alike.',5,'2024-05-07 22:13:49','2024-05-07 22:14:31'),
(3,1,71,'df',4,'2024-05-07 22:14:55','2024-05-07 22:14:55'),
(4,1,78,NULL,3,'2024-05-07 22:15:29','2024-05-07 22:15:29'),
(5,1,83,NULL,4,'2024-05-07 22:15:47','2024-05-07 22:15:47'),
(6,1,80,NULL,2,'2024-05-07 22:16:04','2024-05-07 22:16:04'),
(7,2,78,'Excellent service and very professional communication. The work was completed on time with great attention to detail. Everything was handled smoothly and exactly as expected. Highly recommended for anyone looking for reliable and quality service.',5,'2026-05-12 08:21:33','2026-05-12 08:21:33');
/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_shipping_charges`
--

DROP TABLE IF EXISTS `product_shipping_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_shipping_charges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `short_text` text NOT NULL,
  `shipping_charge` decimal(8,2) unsigned NOT NULL,
  `serial_number` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_charges_language_id_foreign` (`language_id`),
  CONSTRAINT `shipping_charges_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_shipping_charges`
--

LOCK TABLES `product_shipping_charges` WRITE;
/*!40000 ALTER TABLE `product_shipping_charges` DISABLE KEYS */;
INSERT INTO `product_shipping_charges` VALUES
(13,20,'Free Shipping','Shipment will be within 10-15 Days.',0.00,1,'2023-08-19 23:13:03','2023-08-19 23:13:03'),
(14,20,'Standard Shipping','Shipment will be within 5-10 Day.',5.00,2,'2023-08-19 23:13:30','2023-08-19 23:13:30'),
(15,20,'2-Day Shipping','Shipment will be within 2 Days.',10.00,3,'2023-08-19 23:13:56','2023-08-19 23:13:56'),
(16,20,'Same Day Shipping','Shipment will be within 1 Day.',20.00,4,'2023-08-19 23:14:17','2023-08-19 23:14:17'),
(17,21,'الشحن مجانا','ستكون الشحنة في غضون 10-15 يومًا.',0.00,1,'2023-08-19 23:14:44','2023-08-19 23:14:44'),
(18,21,'شحن قياسي','سيتم الشحن في غضون 5-10 يوم.',5.00,2,'2023-08-19 23:15:04','2023-08-19 23:15:04'),
(19,21,'شحن لمدة يومين','ستكون الشحنة في غضون يومين.',10.00,3,'2023-08-19 23:15:23','2023-08-19 23:15:23'),
(20,21,'نفس الشحن يوم','ستكون الشحنة في غضون يوم واحد.',20.00,4,'2023-08-19 23:15:40','2023-08-19 23:15:40');
/*!40000 ALTER TABLE `product_shipping_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_id` bigint(20) DEFAULT NULL,
  `product_type` varchar(255) NOT NULL,
  `featured_image` varchar(255) NOT NULL,
  `slider_images` text NOT NULL,
  `status` varchar(10) NOT NULL,
  `input_type` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `stock` int(10) unsigned DEFAULT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `current_price` decimal(8,2) unsigned NOT NULL,
  `previous_price` decimal(8,2) unsigned DEFAULT NULL,
  `average_rating` decimal(4,2) unsigned DEFAULT 0.00,
  `is_featured` varchar(5) NOT NULL DEFAULT 'no',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `listing_id` bigint(20) unsigned DEFAULT NULL,
  `placement_type` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES
(71,NULL,'physical','663208aeee8ae.png','[\"663208523e32f.png\",\"663208523ffda.png\",\"663208526872b.png\"]','show',NULL,NULL,NULL,39,NULL,43.00,47.00,4.00,'no','2024-05-01 03:17:34','2024-05-07 22:14:55',NULL,2),
(72,NULL,'physical','6632090876c5f.png','[\"663208dabbbd5.png\",\"663208dabd2a2.png\",\"663208dae7c85.png\"]','show',NULL,NULL,NULL,8,NULL,600.00,644.00,0.00,'no','2024-05-01 03:19:04','2024-05-01 03:19:04',NULL,3),
(73,NULL,'physical','663209687d71d.png','[\"663209245592a.png\",\"6632092459264.png\",\"66320924783ba.png\"]','show',NULL,NULL,NULL,95,NULL,35.00,47.00,0.00,'no','2024-05-01 03:20:40','2024-05-07 22:08:04',NULL,2),
(74,NULL,'physical','66320a695d7ea.png','[\"66320a0adff84.png\",\"66320a0ae0056.png\",\"66320a0b0e4f8.png\"]','show',NULL,NULL,NULL,25,NULL,699.00,799.00,0.00,'no','2024-05-01 03:24:57','2024-05-07 22:12:29',NULL,1),
(75,NULL,'physical','66320af23b9b6.png','[\"66320a9a1ec48.png\",\"66320a9a26422.png\",\"66320a9a41485.png\"]','show',NULL,NULL,NULL,66,NULL,89.00,110.00,0.00,'no','2024-05-01 03:27:14','2024-05-01 03:27:14',NULL,3),
(76,NULL,'physical','66320b8f7a357.png','[\"66320b02cd39e.png\",\"66320b02d3fd2.png\",\"66320b02f340e.png\"]','show',NULL,NULL,NULL,89,NULL,79.00,90.00,0.00,'no','2024-05-01 03:29:51','2024-05-01 03:29:51',NULL,1),
(77,NULL,'physical','66320d5766a3b.png','[\"66320c9a01b68.png\",\"66320c9a1c8a3.png\",\"66320c9a24c5e.png\"]','show',NULL,NULL,NULL,6,NULL,89.00,99.00,0.00,'no','2024-05-01 03:37:27','2024-05-07 22:29:30',NULL,2),
(78,201,'physical','66320dafa3260.png','[\"66320d73d2c0b.png\",\"66320d73df90d.png\",\"66320d74052c2.png\"]','show',NULL,NULL,NULL,83,NULL,399.00,459.00,4.00,'no','2024-05-01 03:38:55','2026-05-12 08:21:33',9,3),
(79,NULL,'physical','66320e321610c.png','[\"66320dbc806dd.png\",\"66320dc0279aa.png\",\"66320dc027729.png\"]','show',NULL,NULL,NULL,97,NULL,99.00,132.00,0.00,'no','2024-05-01 03:41:06','2025-11-03 06:58:42',NULL,1),
(80,NULL,'digital','6638a8537ee17.png','[\"6638a79b5d573.png\",\"6638a79b5d573.png\",\"6638a79b8616f.png\"]','show','link',NULL,'https://www.example.com',NULL,NULL,9.00,12.00,2.00,'no','2024-05-06 03:52:19','2024-05-07 22:16:04',NULL,1),
(81,NULL,'physical','6638a939927da.png','[\"6638a8aa141eb.png\",\"6638a8adb5806.png\",\"6638a8adb580d.png\"]','show',NULL,NULL,NULL,98,NULL,789.00,889.00,0.00,'no','2024-05-06 03:56:09','2024-05-07 22:29:30',NULL,2),
(82,NULL,'physical','6638aa9f37c81.png','[\"6638a9cc3683a.png\",\"6638a9cc3693c.png\",\"6638a9cc5d916.png\"]','show',NULL,NULL,NULL,798,NULL,1200.00,1347.00,0.00,'no','2024-05-06 04:02:07','2024-10-14 02:46:59',NULL,2),
(83,NULL,'physical','6638abba21391.png','[\"6638ab131b6c1.png\",\"6638ab132f113.png\",\"6638ab134494c.png\"]','show',NULL,NULL,NULL,56780,NULL,799.00,899.00,4.00,'no','2024-05-06 04:06:50','2025-10-12 09:28:29',NULL,1),
(84,NULL,'physical','6638ac9768c09.png','[\"6638abe99c5c4.png\",\"6638abe99d19e.png\",\"6638abe9c7136.png\"]','show',NULL,NULL,NULL,5461,NULL,1700.00,2490.00,0.00,'no','2024-05-06 04:10:31','2025-11-19 22:27:57',NULL,3),
(85,NULL,'digital','663af45576e1f.png','[\"663af383cd7c8.png\",\"663af38904fd9.png\",\"663af389072fa.png\"]','show','upload','663af45577213.zip',NULL,NULL,NULL,70.00,99.00,5.00,'no','2024-05-07 21:41:09','2024-05-07 22:14:31',NULL,2),
(118,204,'physical','6908a5e13c04e.jpg','[\"6908a5d9bde1f.jpg\",\"6908a5d9bd76d.jpg\"]','show',NULL,NULL,NULL,20,NULL,55.00,55.00,0.00,'no','2025-11-03 06:53:53','2026-05-12 23:34:48',1,2),
(121,228,'digital','69abf52b14774.jpg','[\"69abf4f42018b.jpg\",\"69abf4f448e3b.jpg\"]','show','link',NULL,'https://bulistio-4.0.test/vendor/vendor/shop-management/create-product/digital',NULL,NULL,132.00,456.00,0.00,'no','2026-03-07 03:51:39','2026-03-07 03:51:39',NULL,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_subscriptions`
--

DROP TABLE IF EXISTS `push_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subscribable_type` varchar(255) NOT NULL,
  `subscribable_id` bigint(20) unsigned NOT NULL,
  `endpoint` varchar(500) NOT NULL,
  `public_key` varchar(255) DEFAULT NULL,
  `auth_token` varchar(255) DEFAULT NULL,
  `content_encoding` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `push_subscriptions_endpoint_unique` (`endpoint`),
  KEY `push_subscriptions_subscribable_type_subscribable_id_index` (`subscribable_type`,`subscribable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_subscriptions`
--

LOCK TABLES `push_subscriptions` WRITE;
/*!40000 ALTER TABLE `push_subscriptions` DISABLE KEYS */;
INSERT INTO `push_subscriptions` VALUES
(4,'App\\Models\\Guest',4,'https://fcm.googleapis.com/fcm/send/flEhRYIHDVo:APA91bFQITwjEf1JiVAzyMs2BnJcRFc51Jwq9HaueeV3sVg0x3KTBVnAjeagfVeJyV_Z9HOrye_ySB9nVOb7zilXBej-K-zBTYpWbkb-bWfuGOY6U0fQPA0hamXkg4b4t6pfjm_E7ZiT','BC-1oU5LYywIix1iUwzOhoz56hXX1F0G24WiHUSdUzvSnsWMTV4mMAA-P-jbI1c4CisYkw21e0L5PKM_Mse9zcY','LC_QKytx_tApJyxn_vi_-w',NULL,'2024-05-21 04:06:22','2024-05-21 04:06:22'),
(7,'App\\Models\\Guest',7,'https://fcm.googleapis.com/fcm/send/c8XVe3f_tJc:APA91bHzoWoarafQ9yN0NvWJ40vPWyDeLnaw_Wqbm85Xrc1QlXcxS0Qa3oDiQc7Y6f9Pmyj6b7c2FnNz9b6uHRqwfYGfWO7lRaZxO-8_T2w6JXKV3aTXF0uFrLSs4sDseMn3blEB0iDc','BM88u6U9zASUsaomE0POvoLjG3lrtmZBJvNnKQ0oOiHhIhXI0JZH_8iaB9oOYaoPRfm-4edxdgmcEJAftk0S-4c','jfE6BBQ9J-wrG1-5uu3hlg',NULL,'2024-05-22 02:58:11','2024-05-22 02:58:11'),
(10,'App\\Models\\Guest',10,'https://fcm.googleapis.com/fcm/send/dnSze7t5tAs:APA91bHjfo1pSMafpV2cHXURCr1zbheCWNEFUOhdzEtsQkb2o0xWi6knO1ovl4KgSE0AY2r26csSiWKf5pZQzP1f43VzOlFfh-8lSdNZAuRioIgV_dJV2On7uoGGfwuot_FiMwnq_DUA','BJzxI8TEHnY2hbyEpyzpmuOvhAuINoy9yMROiNUegJbYrubYaGzs7rv379QHMDmkQi6LHe9KB8MwgHtKE8vGy98','edWOhIs2qxcZUJRNoWHyPw',NULL,'2024-06-23 00:30:12','2024-06-23 00:30:12'),
(11,'App\\Models\\Guest',11,'https://fcm.googleapis.com/fcm/send/dqTWShBKda4:APA91bEj6e7yaguVik1fJdOfZxZwWzkjIbtCPuzCtFhmbi3g1TmSvmZUvwcdPurox4XT9hatxpe4W8fD-uqfbCu2eH1pNBZL_ZOiOmuPyp6Kn4a4ln84MIPP4RSsTxVsGiuaLyKhDFZj','BJzxI8TEHnY2hbyEpyzpmuOvhAuINoy9yMROiNUegJbYrubYaGzs7rv379QHMDmkQi6LHe9KB8MwgHtKE8vGy98','edWOhIs2qxcZUJRNoWHyPw',NULL,'2024-09-30 21:33:54','2024-09-30 21:33:54'),
(12,'App\\Models\\Guest',12,'https://fcm.googleapis.com/fcm/send/cxzkYsgQ2oU:APA91bGNLPJwyzbqRFyTqfe_r_dHjfJYsSHaZ5vGF1S1cRMBkbRTai203yvsoUNv5vsJD_IJJLwPaCeVW0o9C0HRHRMWkAVkGTnlOUMCWeXadSkR-4PbuSEn6aDgDpGucZ_CcUytx3nJ','BJzxI8TEHnY2hbyEpyzpmuOvhAuINoy9yMROiNUegJbYrubYaGzs7rv379QHMDmkQi6LHe9KB8MwgHtKE8vGy98','edWOhIs2qxcZUJRNoWHyPw',NULL,'2024-10-08 23:07:30','2024-10-08 23:07:30'),
(13,'App\\Models\\Guest',13,'https://fcm.googleapis.com/fcm/send/d4SZbcDK9tI:APA91bHTCBrS6YZekpkTxh-iqTsqD68JWIP4Sx28PIutRWRuGHvwf714CFiq5R1Q87KcN0dVbcIoyb2RT2Jxzq9k8zmZwnnerd4ELoHClVlrpsv1VKY2U2E1NcY6suFrm2ob6xkLExJQ','BJqKEr4sUJYtWnf8I-_nJu1KZGa2XNNjzxCTDx8NHDOrIg7ph6CuPg2PayMF9J6X2yQ3zRDHWsQKrCYlzCio8js','9i1KhIrhVADR-WcEQPmSpQ',NULL,'2025-03-26 22:37:02','2025-03-26 22:37:02'),
(14,'App\\Models\\Guest',14,'https://fcm.googleapis.com/fcm/send/ersyZdHLon8:APA91bFD8j5n8zzj0QFFlPPuOx-bnRdgd9NzUc4Eft1i06Wnl_Fltt1Trs8hN7hVd4KtxwjYbQAHGvvnP1UsMYvaEHwq61umAUFrGtVRoc9bZV3ojabu9M4mNK32BTR_Vyhs571nRjmJ','BBpx4ZMBr0SQg-85OGF1tdewaPVvmWAleFRALsU4m_5bRtxohHLYiLuH4msgNq9Mnrnpc5veuHSe3PMJhFTfKlU','GzWPKgzytIHmAA35tdFXzw',NULL,'2026-06-24 02:16:22','2026-06-24 02:16:22');
/*!40000 ALTER TABLE `push_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quick_links`
--

DROP TABLE IF EXISTS `quick_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `quick_links` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `serial_number` smallint(5) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quick_links_language_id_foreign` (`language_id`),
  CONSTRAINT `quick_links_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quick_links`
--

LOCK TABLES `quick_links` WRITE;
/*!40000 ALTER TABLE `quick_links` DISABLE KEYS */;
INSERT INTO `quick_links` VALUES
(11,20,'About Us','https://codecanyon8.kreativdev.com/carlist/about-us',1,'2023-08-19 23:46:05','2023-08-28 04:16:52'),
(12,20,'Contact','https://codecanyon8.kreativdev.com/carlist/contact',2,'2023-08-19 23:46:32','2023-08-28 04:16:45'),
(13,20,'FAQ','https://codecanyon8.kreativdev.com/carlist/faq',3,'2023-08-19 23:46:51','2023-08-28 04:16:38'),
(15,21,'معلومات عنا','https://codecanyon8.kreativdev.com/carlist/about-us',1,'2023-08-20 00:12:46','2023-08-28 04:17:13'),
(16,21,'اتصال','https://codecanyon8.kreativdev.com/carlist/contact',2,'2023-08-20 00:13:18','2023-08-28 04:17:08'),
(17,21,'التعليمات','https://codecanyon8.kreativdev.com/carlist/faq',3,'2023-08-20 00:13:43','2023-08-28 04:17:02');
/*!40000 ALTER TABLE `quick_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `permissions` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES
(4,'Admin','[\"Menu Builder\",\"Payment Log\",\"Advertisements\",\"Announcement Popups\",\"Support Tickets\",\"Language Management\"]','2021-08-06 22:42:38','2024-03-19 22:47:59'),
(6,'Moderator','[\"Payment Log\",\"Home Page\",\"Footer\",\"Blog Management\",\"FAQ Management\",\"Basic Settings\"]','2021-08-07 22:14:34','2023-07-22 21:02:33'),
(14,'Supervisor','null','2021-11-24 22:48:53','2025-12-06 22:32:52');
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `work_process_section_status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `category_section_status` tinyint(4) DEFAULT 0,
  `featured_listing_section_status` tinyint(4) NOT NULL DEFAULT 1,
  `feature_section_status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `latest_listing_section_status` tinyint(4) DEFAULT NULL,
  `counter_section_status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `package_section_status` tinyint(4) NOT NULL DEFAULT 1,
  `video_section` tinyint(4) DEFAULT 0,
  `testimonial_section_status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `call_to_action_section_status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `location_section_status` tinyint(4) DEFAULT NULL,
  `blog_section_status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `subscribe_section_status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `footer_section_status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES
(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,NULL,'2024-03-21 00:17:28');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seos`
--

DROP TABLE IF EXISTS `seos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `seos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `meta_keyword_home` longtext DEFAULT NULL,
  `meta_description_home` text DEFAULT NULL,
  `meta_keyword_pricing` text DEFAULT NULL,
  `meta_description_pricing` text DEFAULT NULL,
  `meta_keyword_listings` text DEFAULT NULL,
  `meta_description_listings` text DEFAULT NULL,
  `meta_keyword_products` longtext DEFAULT NULL,
  `meta_description_products` text DEFAULT NULL,
  `meta_keyword_blog` longtext DEFAULT NULL,
  `meta_description_blog` text DEFAULT NULL,
  `meta_keyword_faq` longtext DEFAULT NULL,
  `meta_description_faq` text DEFAULT NULL,
  `meta_keyword_contact` longtext DEFAULT NULL,
  `meta_description_contact` text DEFAULT NULL,
  `meta_keyword_login` longtext DEFAULT NULL,
  `meta_description_login` text DEFAULT NULL,
  `meta_keyword_signup` longtext DEFAULT NULL,
  `meta_description_signup` text DEFAULT NULL,
  `meta_keyword_forget_password` longtext DEFAULT NULL,
  `meta_description_forget_password` text DEFAULT NULL,
  `meta_keywords_vendor_login` longtext DEFAULT NULL,
  `meta_description_vendor_login` longtext DEFAULT NULL,
  `meta_keywords_vendor_signup` longtext DEFAULT NULL,
  `meta_description_vendor_signup` longtext DEFAULT NULL,
  `meta_keywords_vendor_forget_password` longtext DEFAULT NULL,
  `meta_descriptions_vendor_forget_password` longtext DEFAULT NULL,
  `meta_keywords_vendor_page` longtext DEFAULT NULL,
  `meta_description_vendor_page` longtext DEFAULT NULL,
  `meta_keywords_about_page` text DEFAULT NULL,
  `meta_description_about_page` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seos_language_id_foreign` (`language_id`),
  CONSTRAINT `seos_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seos`
--

LOCK TABLES `seos` WRITE;
/*!40000 ALTER TABLE `seos` DISABLE KEYS */;
INSERT INTO `seos` VALUES
(5,20,'Home','Home Descriptions','Pricimg','Pricing descriptions','Listings','Listings Description','products','Product descriptions','Blog','Blog descriptions','Faq','faq descriptions','contact','contact descriptions','Login','Login descriptions','Signup','signup descriptions','Forget Password','Forget Password descriptions','Vendor Login','Vendor Login descriptions','Vendor Signup','Vendor Signup descriptions','Vendor Forget Password','vendor forget password descriptions','vendors','vendors descriptions','About us','about us descriptions','2023-08-27 01:03:33','2024-01-01 21:20:39'),
(6,21,'عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','عرض أقل','2024-01-02 03:34:05','2024-01-02 03:34:05');
/*!40000 ALTER TABLE `seos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_medias`
--

DROP TABLE IF EXISTS `social_medias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_medias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `icon` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `serial_number` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_medias`
--

LOCK TABLES `social_medias` WRITE;
/*!40000 ALTER TABLE `social_medias` DISABLE KEYS */;
INSERT INTO `social_medias` VALUES
(36,'fab fa-facebook-f','http://example.com/',1,'2021-11-20 03:01:42','2021-11-20 03:01:42'),
(37,'fab fa-twitter','http://example.com/',3,'2021-11-20 03:03:22','2021-11-20 03:03:22'),
(38,'fab fa-linkedin-in','http://example.com/',2,'2021-11-20 03:04:29','2021-11-20 03:04:29');
/*!40000 ALTER TABLE `social_medias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `country_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES
(1,20,2,'Victoria','2024-05-01 21:02:06','2024-05-01 21:02:06'),
(2,21,3,'فيكتوريا','2024-05-01 21:02:35','2024-05-07 23:29:02'),
(3,20,4,'Andhra Pradesh','2024-05-01 22:32:59','2024-05-01 22:35:14'),
(4,21,5,'ولاية اندرا براديش','2024-05-01 22:34:05','2024-05-07 23:28:58'),
(5,20,10,'California','2024-05-05 21:38:02','2024-05-05 21:38:02'),
(6,21,11,'كاليفورنيا','2024-05-05 21:38:25','2024-05-07 23:28:50'),
(7,20,10,'Florida','2024-05-05 21:38:55','2024-05-05 21:38:55'),
(8,21,11,'فلوريدا','2024-05-05 21:39:12','2024-05-07 23:28:44');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribers`
--

DROP TABLE IF EXISTS `subscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscribers_email_id_unique` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribers`
--

LOCK TABLES `subscribers` WRITE;
/*!40000 ALTER TABLE `subscribers` DISABLE KEYS */;
INSERT INTO `subscribers` VALUES
(5,'azimahmed11041@gmail.com','2024-11-10 22:10:30','2024-11-10 22:10:30');
/*!40000 ALTER TABLE `subscribers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_ticket_statuses`
--

DROP TABLE IF EXISTS `support_ticket_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_ticket_statuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `support_ticket_status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_ticket_statuses`
--

LOCK TABLES `support_ticket_statuses` WRITE;
/*!40000 ALTER TABLE `support_ticket_statuses` DISABLE KEYS */;
INSERT INTO `support_ticket_statuses` VALUES
(1,'active','2022-06-25 03:52:18','2024-03-21 00:50:57');
/*!40000 ALTER TABLE `support_ticket_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_tickets`
--

DROP TABLE IF EXISTS `support_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(20) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1-pending, 2-open, 3-closed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_message` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_tickets`
--

LOCK TABLES `support_tickets` WRITE;
/*!40000 ALTER TABLE `support_tickets` DISABLE KEYS */;
INSERT INTO `support_tickets` VALUES
(1,201,'vendor',NULL,'listingspot56@example.com','Support Text Ticket','<p>Support Text Ticket</p>',NULL,1,'2026-04-05 01:16:00','2026-04-05 01:16:00',NULL),
(5,204,'vendor',NULL,'superBusiness47@example.com','Support Text Ticket','<p>test giflwe</p>',NULL,1,'2026-04-07 01:15:30','2026-04-07 01:29:07','2026-04-07 01:29:07'),
(6,204,'vendor',NULL,'superBusiness47@example.com','Test ticket','Test ticket','69d4c45158672.zip',1,'2026-04-07 02:46:09','2026-04-07 02:46:09',NULL),
(7,204,'vendor',NULL,'superBusiness47@example.com','Need help with your product listings?','<p>Hi there! Are you finding it challenging to get your product listings just right? We understand that creating compelling and accurate listings can be time-consuming, and sometimes a little tricky. Our team is here to help you optimize your product pages so they shine and attract more customers. Whether it\'s improving descriptions, adding better images, or navigating our listing tools, we\'ve got resources to guide you. Don\'t let listing hurdles slow you down – reach out to our support team today and let us assist you in making your products stand out!</p>',NULL,1,'2026-04-12 03:39:11','2026-04-12 03:39:11',NULL),
(8,204,'vendor',3,'superBusiness47@example.com','test','<p>Hi there! Are you finding it challenging to get your product listings just right? We understand that creating compelling and accurate listings can be time-consuming, and sometimes a little tricky. Our team is here to help you optimize your product pages so they shine and attract more customers. Whether it\'s improving descriptions, adding better images, or navigating our listing tools, we\'ve got resources to guide you. Don\'t let listing hurdles slow you down – reach out to our support team today and let us assist you in making your products stand out!</p>',NULL,3,'2026-05-12 08:10:45','2026-05-12 08:13:03','2026-05-12 08:12:03');
/*!40000 ALTER TABLE `support_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testimonial_sections`
--

DROP TABLE IF EXISTS `testimonial_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonial_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `clients` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testimonial_sections`
--

LOCK TABLES `testimonial_sections` WRITE;
/*!40000 ALTER TABLE `testimonial_sections` DISABLE KEYS */;
INSERT INTO `testimonial_sections` VALUES
(7,20,NULL,'What Clients Say About Bulistio Packages','10k+ Active Client’s','2023-08-19 03:45:43','2023-12-13 21:06:27'),
(8,21,NULL,'ماذا يقول عملاؤنا عنا','k2 كيلوعملاؤن','2023-08-19 03:47:29','2023-12-13 21:07:11');
/*!40000 ALTER TABLE `testimonial_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testimonials`
--

DROP TABLE IF EXISTS `testimonials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `occupation` varchar(255) NOT NULL,
  `comment` text NOT NULL,
  `rating` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testimonials`
--

LOCK TABLES `testimonials` WRITE;
/*!40000 ALTER TABLE `testimonials` DISABLE KEYS */;
INSERT INTO `testimonials` VALUES
(25,20,'663c43857a830.png','Hames Rodrigo','Marketing Executive','Regular updates and accurate contact details ensure the information is current. An essential tool for anyone needing quick access to local services.','5','2023-08-19 03:51:32','2024-05-24 22:23:24'),
(26,20,'663c437f271c3.png','John Martinez','IT Consultant','The review and rating system adds transparency, making it easier to choose reputable businesses. Very helpful for new residents.','4.5','2023-08-19 03:52:23','2024-05-24 22:23:11'),
(27,20,'663c437896de6.png','Emily Parker','Teacher','Efficient search filters and categories specific business types. A valuable resource for both consumers and business owners.','5','2023-08-19 03:53:54','2024-05-24 22:24:11'),
(28,20,'663c43702294e.png','Michael Collins','Marketing Manager','Comprehensive listings with detailed information and reviews help in making informed decisions. A must-use for discovering trusted local businesses.','4.3','2023-08-19 03:55:02','2024-05-24 22:22:38'),
(29,20,'663c43676a110.png','Jennifer Lee','Freelance Photographer','User-friendly interface makes finding local businesses a breeze. Highly recommend for  services or products nearby.','5','2023-08-19 03:55:59','2024-05-24 22:23:49'),
(30,21,'663c43a9b4af0.png','هاميس رودريجو','تنفيذي تسويق','لقد حظيت بتجربة مدهشة باستخدام موقع قائمة السيارات هذا. جعلت الواجهة سهلة الاستخدام من السهل جدًا علي العثور على السيارة المثالية التي تناسب احتياجاتي. كان تنوع الخيارات المتاحة مثيرًا للإعجاب ، وأنا سعيد بعملية الشراء السلسة. ينصح به بشده!','5','2023-08-19 04:48:15','2024-05-08 21:31:53'),
(32,21,'663c43a137eac.png','جون مارتينيز','مستشار تكنولوجيا المعلومات','لقد وجدت أن موقع قائمة السيارات مفيد جدًا بشكل عام. لقد ساعدني في العثور  ، واجهت بعض الأخطاء الفنية أثناء البحث ، مما أثر قليلاً على تجربتي. مع مزيد من الصقل قليلاً ، يمكن أن يصبح هذا بسهولة منصة الذهاب إلى التسوق في السيارات.','4.5','2023-08-19 04:50:14','2024-05-24 22:25:51'),
(33,21,'663c439ad8654.png','إميلي باركر','مدرس','عادةً ما أكون متشككًا جدًا بشأن عمليات الشراء عبر الإنترنت ، لكن موقع قائمة السيارات هذا تجاوز توقعاتي. أعطتني الشفافية في تقديم تاريخ المركبات والأوصاف الدقيقة الثقة في اختياراتي. بفضل هذه المنصة ، وجدت سيارة موثوقة تناسب ميزانيتي تمامًا','5','2023-08-19 04:50:59','2024-05-08 21:31:38'),
(34,21,'663c43949f349.png','مايكل كولينز','مدير تسويق','\"كنت أخشى عملية البحث عن سيارة جديدة ، ل التصميم البديهي التنقل نسيمًا ، وكان دعم الدردشة في الوقت الفعلي مفيدًا بشكل لا يصدق عندما كانت لدي أسئلة. سيارتي الجديدة هي كل شيء كنت أتمنى ، وأنا ممتن لهذه المنصة','4.3','2023-08-19 04:51:37','2024-05-24 22:25:14'),
(35,21,'663c438e42d3f.png','جينيفر لي','مصور فوتوغرافي مستقل','لقد وجدت أن موقع قائمة السيارات مفيد جدًا بشكل عام. لقد ساعدني في العثور  ، واجهت بعض الأخطاء الفنية أثناء البحث ، مما أثر قليلاً على تجربتي. مع مزيد من الصقل قليلاً ، يمكن أن يصبح هذا بسهولة منصة الذهاب إلى التسوق في السيارات.','5','2023-08-19 04:52:25','2024-05-24 22:25:28');
/*!40000 ALTER TABLE `testimonials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timezones`
--

DROP TABLE IF EXISTS `timezones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `timezones` (
  `country_code` char(3) NOT NULL,
  `timezone` varchar(125) NOT NULL DEFAULT '',
  `gmt_offset` float(10,2) DEFAULT NULL,
  `dst_offset` float(10,2) DEFAULT NULL,
  `raw_offset` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`country_code`,`timezone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timezones`
--

LOCK TABLES `timezones` WRITE;
/*!40000 ALTER TABLE `timezones` DISABLE KEYS */;
INSERT INTO `timezones` VALUES
('AD','Europe/Andorra',1.00,2.00,1.00),
('AE','Asia/Dubai',4.00,4.00,4.00),
('AF','Asia/Kabul',4.50,4.50,4.50),
('AG','America/Antigua',-4.00,-4.00,-4.00),
('AI','America/Anguilla',-4.00,-4.00,-4.00),
('AL','Europe/Tirane',1.00,2.00,1.00),
('AM','Asia/Yerevan',4.00,4.00,4.00),
('AO','Africa/Luanda',1.00,1.00,1.00),
('AQ','Antarctica/Casey',8.00,8.00,8.00),
('AQ','Antarctica/Davis',7.00,7.00,7.00),
('AQ','Antarctica/DumontDUrville',10.00,10.00,10.00),
('AQ','Antarctica/Mawson',5.00,5.00,5.00),
('AQ','Antarctica/McMurdo',13.00,12.00,12.00),
('AQ','Antarctica/Palmer',-3.00,-4.00,-4.00),
('AQ','Antarctica/Rothera',-3.00,-3.00,-3.00),
('AQ','Antarctica/South_Pole',13.00,12.00,12.00),
('AQ','Antarctica/Syowa',3.00,3.00,3.00),
('AQ','Antarctica/Vostok',6.00,6.00,6.00),
('AR','America/Argentina/Buenos_Aires',-3.00,-3.00,-3.00),
('AR','America/Argentina/Catamarca',-3.00,-3.00,-3.00),
('AR','America/Argentina/Cordoba',-3.00,-3.00,-3.00),
('AR','America/Argentina/Jujuy',-3.00,-3.00,-3.00),
('AR','America/Argentina/La_Rioja',-3.00,-3.00,-3.00),
('AR','America/Argentina/Mendoza',-3.00,-3.00,-3.00),
('AR','America/Argentina/Rio_Gallegos',-3.00,-3.00,-3.00),
('AR','America/Argentina/Salta',-3.00,-3.00,-3.00),
('AR','America/Argentina/San_Juan',-3.00,-3.00,-3.00),
('AR','America/Argentina/San_Luis',-3.00,-3.00,-3.00),
('AR','America/Argentina/Tucuman',-3.00,-3.00,-3.00),
('AR','America/Argentina/Ushuaia',-3.00,-3.00,-3.00),
('AS','Pacific/Pago_Pago',-11.00,-11.00,-11.00),
('AT','Europe/Vienna',1.00,2.00,1.00),
('AU','Antarctica/Macquarie',11.00,11.00,11.00),
('AU','Australia/Adelaide',10.50,9.50,9.50),
('AU','Australia/Brisbane',10.00,10.00,10.00),
('AU','Australia/Broken_Hill',10.50,9.50,9.50),
('AU','Australia/Currie',11.00,10.00,10.00),
('AU','Australia/Darwin',9.50,9.50,9.50),
('AU','Australia/Eucla',8.75,8.75,8.75),
('AU','Australia/Hobart',11.00,10.00,10.00),
('AU','Australia/Lindeman',10.00,10.00,10.00),
('AU','Australia/Lord_Howe',11.00,10.50,10.50),
('AU','Australia/Melbourne',11.00,10.00,10.00),
('AU','Australia/Perth',8.00,8.00,8.00),
('AU','Australia/Sydney',11.00,10.00,10.00),
('AW','America/Aruba',-4.00,-4.00,-4.00),
('AX','Europe/Mariehamn',2.00,3.00,2.00),
('AZ','Asia/Baku',4.00,5.00,4.00),
('BA','Europe/Sarajevo',1.00,2.00,1.00),
('BB','America/Barbados',-4.00,-4.00,-4.00),
('BD','Asia/Dhaka',6.00,6.00,6.00),
('BE','Europe/Brussels',1.00,2.00,1.00),
('BF','Africa/Ouagadougou',0.00,0.00,0.00),
('BG','Europe/Sofia',2.00,3.00,2.00),
('BH','Asia/Bahrain',3.00,3.00,3.00),
('BI','Africa/Bujumbura',2.00,2.00,2.00),
('BJ','Africa/Porto-Novo',1.00,1.00,1.00),
('BL','America/St_Barthelemy',-4.00,-4.00,-4.00),
('BM','Atlantic/Bermuda',-4.00,-3.00,-4.00),
('BN','Asia/Brunei',8.00,8.00,8.00),
('BO','America/La_Paz',-4.00,-4.00,-4.00),
('BQ','America/Kralendijk',-4.00,-4.00,-4.00),
('BR','America/Araguaina',-3.00,-3.00,-3.00),
('BR','America/Bahia',-3.00,-3.00,-3.00),
('BR','America/Belem',-3.00,-3.00,-3.00),
('BR','America/Boa_Vista',-4.00,-4.00,-4.00),
('BR','America/Campo_Grande',-3.00,-4.00,-4.00),
('BR','America/Cuiaba',-3.00,-4.00,-4.00),
('BR','America/Eirunepe',-5.00,-5.00,-5.00),
('BR','America/Fortaleza',-3.00,-3.00,-3.00),
('BR','America/Maceio',-3.00,-3.00,-3.00),
('BR','America/Manaus',-4.00,-4.00,-4.00),
('BR','America/Noronha',-2.00,-2.00,-2.00),
('BR','America/Porto_Velho',-4.00,-4.00,-4.00),
('BR','America/Recife',-3.00,-3.00,-3.00),
('BR','America/Rio_Branco',-5.00,-5.00,-5.00),
('BR','America/Santarem',-3.00,-3.00,-3.00),
('BR','America/Sao_Paulo',-2.00,-3.00,-3.00),
('BS','America/Nassau',-5.00,-4.00,-5.00),
('BT','Asia/Thimphu',6.00,6.00,6.00),
('BW','Africa/Gaborone',2.00,2.00,2.00),
('BY','Europe/Minsk',3.00,3.00,3.00),
('BZ','America/Belize',-6.00,-6.00,-6.00),
('CA','America/Atikokan',-5.00,-5.00,-5.00),
('CA','America/Blanc-Sablon',-4.00,-4.00,-4.00),
('CA','America/Cambridge_Bay',-7.00,-6.00,-7.00),
('CA','America/Creston',-7.00,-7.00,-7.00),
('CA','America/Dawson',-8.00,-7.00,-8.00),
('CA','America/Dawson_Creek',-7.00,-7.00,-7.00),
('CA','America/Edmonton',-7.00,-6.00,-7.00),
('CA','America/Glace_Bay',-4.00,-3.00,-4.00),
('CA','America/Goose_Bay',-4.00,-3.00,-4.00),
('CA','America/Halifax',-4.00,-3.00,-4.00),
('CA','America/Inuvik',-7.00,-6.00,-7.00),
('CA','America/Iqaluit',-5.00,-4.00,-5.00),
('CA','America/Moncton',-4.00,-3.00,-4.00),
('CA','America/Montreal',-5.00,-4.00,-5.00),
('CA','America/Nipigon',-5.00,-4.00,-5.00),
('CA','America/Pangnirtung',-5.00,-4.00,-5.00),
('CA','America/Rainy_River',-6.00,-5.00,-6.00),
('CA','America/Rankin_Inlet',-6.00,-5.00,-6.00),
('CA','America/Regina',-6.00,-6.00,-6.00),
('CA','America/Resolute',-6.00,-5.00,-6.00),
('CA','America/St_Johns',-3.50,-2.50,-3.50),
('CA','America/Swift_Current',-6.00,-6.00,-6.00),
('CA','America/Thunder_Bay',-5.00,-4.00,-5.00),
('CA','America/Toronto',-5.00,-4.00,-5.00),
('CA','America/Vancouver',-8.00,-7.00,-8.00),
('CA','America/Whitehorse',-8.00,-7.00,-8.00),
('CA','America/Winnipeg',-6.00,-5.00,-6.00),
('CA','America/Yellowknife',-7.00,-6.00,-7.00),
('CC','Indian/Cocos',6.50,6.50,6.50),
('CD','Africa/Kinshasa',1.00,1.00,1.00),
('CD','Africa/Lubumbashi',2.00,2.00,2.00),
('CF','Africa/Bangui',1.00,1.00,1.00),
('CG','Africa/Brazzaville',1.00,1.00,1.00),
('CH','Europe/Zurich',1.00,2.00,1.00),
('CI','Africa/Abidjan',0.00,0.00,0.00),
('CK','Pacific/Rarotonga',-10.00,-10.00,-10.00),
('CL','America/Santiago',-3.00,-4.00,-4.00),
('CL','Pacific/Easter',-5.00,-6.00,-6.00),
('CM','Africa/Douala',1.00,1.00,1.00),
('CN','Asia/Chongqing',8.00,8.00,8.00),
('CN','Asia/Harbin',8.00,8.00,8.00),
('CN','Asia/Kashgar',8.00,8.00,8.00),
('CN','Asia/Shanghai',8.00,8.00,8.00),
('CN','Asia/Urumqi',8.00,8.00,8.00),
('CO','America/Bogota',-5.00,-5.00,-5.00),
('CR','America/Costa_Rica',-6.00,-6.00,-6.00),
('CU','America/Havana',-5.00,-4.00,-5.00),
('CV','Atlantic/Cape_Verde',-1.00,-1.00,-1.00),
('CW','America/Curacao',-4.00,-4.00,-4.00),
('CX','Indian/Christmas',7.00,7.00,7.00),
('CY','Asia/Nicosia',2.00,3.00,2.00),
('CZ','Europe/Prague',1.00,2.00,1.00),
('DE','Europe/Berlin',1.00,2.00,1.00),
('DE','Europe/Busingen',1.00,2.00,1.00),
('DJ','Africa/Djibouti',3.00,3.00,3.00),
('DK','Europe/Copenhagen',1.00,2.00,1.00),
('DM','America/Dominica',-4.00,-4.00,-4.00),
('DO','America/Santo_Domingo',-4.00,-4.00,-4.00),
('DZ','Africa/Algiers',1.00,1.00,1.00),
('EC','America/Guayaquil',-5.00,-5.00,-5.00),
('EC','Pacific/Galapagos',-6.00,-6.00,-6.00),
('EE','Europe/Tallinn',2.00,3.00,2.00),
('EG','Africa/Cairo',2.00,2.00,2.00),
('EH','Africa/El_Aaiun',0.00,0.00,0.00),
('ER','Africa/Asmara',3.00,3.00,3.00),
('ES','Africa/Ceuta',1.00,2.00,1.00),
('ES','Atlantic/Canary',0.00,1.00,0.00),
('ES','Europe/Madrid',1.00,2.00,1.00),
('ET','Africa/Addis_Ababa',3.00,3.00,3.00),
('FI','Europe/Helsinki',2.00,3.00,2.00),
('FJ','Pacific/Fiji',13.00,12.00,12.00),
('FK','Atlantic/Stanley',-3.00,-3.00,-3.00),
('FM','Pacific/Chuuk',10.00,10.00,10.00),
('FM','Pacific/Kosrae',11.00,11.00,11.00),
('FM','Pacific/Pohnpei',11.00,11.00,11.00),
('FO','Atlantic/Faroe',0.00,1.00,0.00),
('FR','Europe/Paris',1.00,2.00,1.00),
('GA','Africa/Libreville',1.00,1.00,1.00),
('GB','Europe/London',0.00,1.00,0.00),
('GD','America/Grenada',-4.00,-4.00,-4.00),
('GE','Asia/Tbilisi',4.00,4.00,4.00),
('GF','America/Cayenne',-3.00,-3.00,-3.00),
('GG','Europe/Guernsey',0.00,1.00,0.00),
('GH','Africa/Accra',0.00,0.00,0.00),
('GI','Europe/Gibraltar',1.00,2.00,1.00),
('GL','America/Danmarkshavn',0.00,0.00,0.00),
('GL','America/Godthab',-3.00,-2.00,-3.00),
('GL','America/Scoresbysund',-1.00,0.00,-1.00),
('GL','America/Thule',-4.00,-3.00,-4.00),
('GM','Africa/Banjul',0.00,0.00,0.00),
('GN','Africa/Conakry',0.00,0.00,0.00),
('GP','America/Guadeloupe',-4.00,-4.00,-4.00),
('GQ','Africa/Malabo',1.00,1.00,1.00),
('GR','Europe/Athens',2.00,3.00,2.00),
('GS','Atlantic/South_Georgia',-2.00,-2.00,-2.00),
('GT','America/Guatemala',-6.00,-6.00,-6.00),
('GU','Pacific/Guam',10.00,10.00,10.00),
('GW','Africa/Bissau',0.00,0.00,0.00),
('GY','America/Guyana',-4.00,-4.00,-4.00),
('HK','Asia/Hong_Kong',8.00,8.00,8.00),
('HN','America/Tegucigalpa',-6.00,-6.00,-6.00),
('HR','Europe/Zagreb',1.00,2.00,1.00),
('HT','America/Port-au-Prince',-5.00,-4.00,-5.00),
('HU','Europe/Budapest',1.00,2.00,1.00),
('ID','Asia/Jakarta',7.00,7.00,7.00),
('ID','Asia/Jayapura',9.00,9.00,9.00),
('ID','Asia/Makassar',8.00,8.00,8.00),
('ID','Asia/Pontianak',7.00,7.00,7.00),
('IE','Europe/Dublin',0.00,1.00,0.00),
('IL','Asia/Jerusalem',2.00,3.00,2.00),
('IM','Europe/Isle_of_Man',0.00,1.00,0.00),
('IN','Asia/Kolkata',5.50,5.50,5.50),
('IO','Indian/Chagos',6.00,6.00,6.00),
('IQ','Asia/Baghdad',3.00,3.00,3.00),
('IR','Asia/Tehran',3.50,4.50,3.50),
('IS','Atlantic/Reykjavik',0.00,0.00,0.00),
('IT','Europe/Rome',1.00,2.00,1.00),
('JE','Europe/Jersey',0.00,1.00,0.00),
('JM','America/Jamaica',-5.00,-5.00,-5.00),
('JO','Asia/Amman',2.00,3.00,2.00),
('JP','Asia/Tokyo',9.00,9.00,9.00),
('KE','Africa/Nairobi',3.00,3.00,3.00),
('KG','Asia/Bishkek',6.00,6.00,6.00),
('KH','Asia/Phnom_Penh',7.00,7.00,7.00),
('KI','Pacific/Enderbury',13.00,13.00,13.00),
('KI','Pacific/Kiritimati',14.00,14.00,14.00),
('KI','Pacific/Tarawa',12.00,12.00,12.00),
('KM','Indian/Comoro',3.00,3.00,3.00),
('KN','America/St_Kitts',-4.00,-4.00,-4.00),
('KP','Asia/Pyongyang',9.00,9.00,9.00),
('KR','Asia/Seoul',9.00,9.00,9.00),
('KW','Asia/Kuwait',3.00,3.00,3.00),
('KY','America/Cayman',-5.00,-5.00,-5.00),
('KZ','Asia/Almaty',6.00,6.00,6.00),
('KZ','Asia/Aqtau',5.00,5.00,5.00),
('KZ','Asia/Aqtobe',5.00,5.00,5.00),
('KZ','Asia/Oral',5.00,5.00,5.00),
('KZ','Asia/Qyzylorda',6.00,6.00,6.00),
('LA','Asia/Vientiane',7.00,7.00,7.00),
('LB','Asia/Beirut',2.00,3.00,2.00),
('LC','America/St_Lucia',-4.00,-4.00,-4.00),
('LI','Europe/Vaduz',1.00,2.00,1.00),
('LK','Asia/Colombo',5.50,5.50,5.50),
('LR','Africa/Monrovia',0.00,0.00,0.00),
('LS','Africa/Maseru',2.00,2.00,2.00),
('LT','Europe/Vilnius',2.00,3.00,2.00),
('LU','Europe/Luxembourg',1.00,2.00,1.00),
('LV','Europe/Riga',2.00,3.00,2.00),
('LY','Africa/Tripoli',2.00,2.00,2.00),
('MA','Africa/Casablanca',0.00,0.00,0.00),
('MC','Europe/Monaco',1.00,2.00,1.00),
('MD','Europe/Chisinau',2.00,3.00,2.00),
('ME','Europe/Podgorica',1.00,2.00,1.00),
('MF','America/Marigot',-4.00,-4.00,-4.00),
('MG','Indian/Antananarivo',3.00,3.00,3.00),
('MH','Pacific/Kwajalein',12.00,12.00,12.00),
('MH','Pacific/Majuro',12.00,12.00,12.00),
('MK','Europe/Skopje',1.00,2.00,1.00),
('ML','Africa/Bamako',0.00,0.00,0.00),
('MM','Asia/Rangoon',6.50,6.50,6.50),
('MN','Asia/Choibalsan',8.00,8.00,8.00),
('MN','Asia/Hovd',7.00,7.00,7.00),
('MN','Asia/Ulaanbaatar',8.00,8.00,8.00),
('MO','Asia/Macau',8.00,8.00,8.00),
('MP','Pacific/Saipan',10.00,10.00,10.00),
('MQ','America/Martinique',-4.00,-4.00,-4.00),
('MR','Africa/Nouakchott',0.00,0.00,0.00),
('MS','America/Montserrat',-4.00,-4.00,-4.00),
('MT','Europe/Malta',1.00,2.00,1.00),
('MU','Indian/Mauritius',4.00,4.00,4.00),
('MV','Indian/Maldives',5.00,5.00,5.00),
('MW','Africa/Blantyre',2.00,2.00,2.00),
('MX','America/Bahia_Banderas',-6.00,-5.00,-6.00),
('MX','America/Cancun',-6.00,-5.00,-6.00),
('MX','America/Chihuahua',-7.00,-6.00,-7.00),
('MX','America/Hermosillo',-7.00,-7.00,-7.00),
('MX','America/Matamoros',-6.00,-5.00,-6.00),
('MX','America/Mazatlan',-7.00,-6.00,-7.00),
('MX','America/Merida',-6.00,-5.00,-6.00),
('MX','America/Mexico_City',-6.00,-5.00,-6.00),
('MX','America/Monterrey',-6.00,-5.00,-6.00),
('MX','America/Ojinaga',-7.00,-6.00,-7.00),
('MX','America/Santa_Isabel',-8.00,-7.00,-8.00),
('MX','America/Tijuana',-8.00,-7.00,-8.00),
('MY','Asia/Kuala_Lumpur',8.00,8.00,8.00),
('MY','Asia/Kuching',8.00,8.00,8.00),
('MZ','Africa/Maputo',2.00,2.00,2.00),
('NA','Africa/Windhoek',2.00,1.00,1.00),
('NC','Pacific/Noumea',11.00,11.00,11.00),
('NE','Africa/Niamey',1.00,1.00,1.00),
('NF','Pacific/Norfolk',11.50,11.50,11.50),
('NG','Africa/Lagos',1.00,1.00,1.00),
('NI','America/Managua',-6.00,-6.00,-6.00),
('NL','Europe/Amsterdam',1.00,2.00,1.00),
('NO','Europe/Oslo',1.00,2.00,1.00),
('NP','Asia/Kathmandu',5.75,5.75,5.75),
('NR','Pacific/Nauru',12.00,12.00,12.00),
('NU','Pacific/Niue',-11.00,-11.00,-11.00),
('NZ','Pacific/Auckland',13.00,12.00,12.00),
('NZ','Pacific/Chatham',13.75,12.75,12.75),
('OM','Asia/Muscat',4.00,4.00,4.00),
('PA','America/Panama',-5.00,-5.00,-5.00),
('PE','America/Lima',-5.00,-5.00,-5.00),
('PF','Pacific/Gambier',-9.00,-9.00,-9.00),
('PF','Pacific/Marquesas',-9.50,-9.50,-9.50),
('PF','Pacific/Tahiti',-10.00,-10.00,-10.00),
('PG','Pacific/Port_Moresby',10.00,10.00,10.00),
('PH','Asia/Manila',8.00,8.00,8.00),
('PK','Asia/Karachi',5.00,5.00,5.00),
('PL','Europe/Warsaw',1.00,2.00,1.00),
('PM','America/Miquelon',-3.00,-2.00,-3.00),
('PN','Pacific/Pitcairn',-8.00,-8.00,-8.00),
('PR','America/Puerto_Rico',-4.00,-4.00,-4.00),
('PS','Asia/Gaza',2.00,3.00,2.00),
('PS','Asia/Hebron',2.00,3.00,2.00),
('PT','Atlantic/Azores',-1.00,0.00,-1.00),
('PT','Atlantic/Madeira',0.00,1.00,0.00),
('PT','Europe/Lisbon',0.00,1.00,0.00),
('PW','Pacific/Palau',9.00,9.00,9.00),
('PY','America/Asuncion',-3.00,-4.00,-4.00),
('QA','Asia/Qatar',3.00,3.00,3.00),
('RE','Indian/Reunion',4.00,4.00,4.00),
('RO','Europe/Bucharest',2.00,3.00,2.00),
('RS','Europe/Belgrade',1.00,2.00,1.00),
('RU','Asia/Anadyr',12.00,12.00,12.00),
('RU','Asia/Irkutsk',9.00,9.00,9.00),
('RU','Asia/Kamchatka',12.00,12.00,12.00),
('RU','Asia/Khandyga',10.00,10.00,10.00),
('RU','Asia/Krasnoyarsk',8.00,8.00,8.00),
('RU','Asia/Magadan',12.00,12.00,12.00),
('RU','Asia/Novokuznetsk',7.00,7.00,7.00),
('RU','Asia/Novosibirsk',7.00,7.00,7.00),
('RU','Asia/Omsk',7.00,7.00,7.00),
('RU','Asia/Sakhalin',11.00,11.00,11.00),
('RU','Asia/Ust-Nera',11.00,11.00,11.00),
('RU','Asia/Vladivostok',11.00,11.00,11.00),
('RU','Asia/Yakutsk',10.00,10.00,10.00),
('RU','Asia/Yekaterinburg',6.00,6.00,6.00),
('RU','Europe/Kaliningrad',3.00,3.00,3.00),
('RU','Europe/Moscow',4.00,4.00,4.00),
('RU','Europe/Samara',4.00,4.00,4.00),
('RU','Europe/Volgograd',4.00,4.00,4.00),
('RW','Africa/Kigali',2.00,2.00,2.00),
('SA','Asia/Riyadh',3.00,3.00,3.00),
('SB','Pacific/Guadalcanal',11.00,11.00,11.00),
('SC','Indian/Mahe',4.00,4.00,4.00),
('SD','Africa/Khartoum',3.00,3.00,3.00),
('SE','Europe/Stockholm',1.00,2.00,1.00),
('SG','Asia/Singapore',8.00,8.00,8.00),
('SH','Atlantic/St_Helena',0.00,0.00,0.00),
('SI','Europe/Ljubljana',1.00,2.00,1.00),
('SJ','Arctic/Longyearbyen',1.00,2.00,1.00),
('SK','Europe/Bratislava',1.00,2.00,1.00),
('SL','Africa/Freetown',0.00,0.00,0.00),
('SM','Europe/San_Marino',1.00,2.00,1.00),
('SN','Africa/Dakar',0.00,0.00,0.00),
('SO','Africa/Mogadishu',3.00,3.00,3.00),
('SR','America/Paramaribo',-3.00,-3.00,-3.00),
('SS','Africa/Juba',3.00,3.00,3.00),
('ST','Africa/Sao_Tome',0.00,0.00,0.00),
('SV','America/El_Salvador',-6.00,-6.00,-6.00),
('SX','America/Lower_Princes',-4.00,-4.00,-4.00),
('SY','Asia/Damascus',2.00,3.00,2.00),
('SZ','Africa/Mbabane',2.00,2.00,2.00),
('TC','America/Grand_Turk',-5.00,-4.00,-5.00),
('TD','Africa/Ndjamena',1.00,1.00,1.00),
('TF','Indian/Kerguelen',5.00,5.00,5.00),
('TG','Africa/Lome',0.00,0.00,0.00),
('TH','Asia/Bangkok',7.00,7.00,7.00),
('TJ','Asia/Dushanbe',5.00,5.00,5.00),
('TK','Pacific/Fakaofo',13.00,13.00,13.00),
('TL','Asia/Dili',9.00,9.00,9.00),
('TM','Asia/Ashgabat',5.00,5.00,5.00),
('TN','Africa/Tunis',1.00,1.00,1.00),
('TO','Pacific/Tongatapu',13.00,13.00,13.00),
('TR','Europe/Istanbul',2.00,3.00,2.00),
('TT','America/Port_of_Spain',-4.00,-4.00,-4.00),
('TV','Pacific/Funafuti',12.00,12.00,12.00),
('TW','Asia/Taipei',8.00,8.00,8.00),
('TZ','Africa/Dar_es_Salaam',3.00,3.00,3.00),
('UA','Europe/Kiev',2.00,3.00,2.00),
('UA','Europe/Simferopol',2.00,4.00,4.00),
('UA','Europe/Uzhgorod',2.00,3.00,2.00),
('UA','Europe/Zaporozhye',2.00,3.00,2.00),
('UG','Africa/Kampala',3.00,3.00,3.00),
('UM','Pacific/Johnston',-10.00,-10.00,-10.00),
('UM','Pacific/Midway',-11.00,-11.00,-11.00),
('UM','Pacific/Wake',12.00,12.00,12.00),
('US','America/Adak',-10.00,-9.00,-10.00),
('US','America/Anchorage',-9.00,-8.00,-9.00),
('US','America/Boise',-7.00,-6.00,-7.00),
('US','America/Chicago',-6.00,-5.00,-6.00),
('US','America/Denver',-7.00,-6.00,-7.00),
('US','America/Detroit',-5.00,-4.00,-5.00),
('US','America/Indiana/Indianapolis',-5.00,-4.00,-5.00),
('US','America/Indiana/Knox',-6.00,-5.00,-6.00),
('US','America/Indiana/Marengo',-5.00,-4.00,-5.00),
('US','America/Indiana/Petersburg',-5.00,-4.00,-5.00),
('US','America/Indiana/Tell_City',-6.00,-5.00,-6.00),
('US','America/Indiana/Vevay',-5.00,-4.00,-5.00),
('US','America/Indiana/Vincennes',-5.00,-4.00,-5.00),
('US','America/Indiana/Winamac',-5.00,-4.00,-5.00),
('US','America/Juneau',-9.00,-8.00,-9.00),
('US','America/Kentucky/Louisville',-5.00,-4.00,-5.00),
('US','America/Kentucky/Monticello',-5.00,-4.00,-5.00),
('US','America/Los_Angeles',-8.00,-7.00,-8.00),
('US','America/Menominee',-6.00,-5.00,-6.00),
('US','America/Metlakatla',-8.00,-8.00,-8.00),
('US','America/New_York',-5.00,-4.00,-5.00),
('US','America/Nome',-9.00,-8.00,-9.00),
('US','America/North_Dakota/Beulah',-6.00,-5.00,-6.00),
('US','America/North_Dakota/Center',-6.00,-5.00,-6.00),
('US','America/North_Dakota/New_Salem',-6.00,-5.00,-6.00),
('US','America/Phoenix',-7.00,-7.00,-7.00),
('US','America/Shiprock',-7.00,-6.00,-7.00),
('US','America/Sitka',-9.00,-8.00,-9.00),
('US','America/Yakutat',-9.00,-8.00,-9.00),
('US','Pacific/Honolulu',-10.00,-10.00,-10.00),
('UY','America/Montevideo',-2.00,-3.00,-3.00),
('UZ','Asia/Samarkand',5.00,5.00,5.00),
('UZ','Asia/Tashkent',5.00,5.00,5.00),
('VA','Europe/Vatican',1.00,2.00,1.00),
('VC','America/St_Vincent',-4.00,-4.00,-4.00),
('VE','America/Caracas',-4.50,-4.50,-4.50),
('VG','America/Tortola',-4.00,-4.00,-4.00),
('VI','America/St_Thomas',-4.00,-4.00,-4.00),
('VN','Asia/Ho_Chi_Minh',7.00,7.00,7.00),
('VU','Pacific/Efate',11.00,11.00,11.00),
('WF','Pacific/Wallis',12.00,12.00,12.00),
('WS','Pacific/Apia',14.00,13.00,13.00),
('YE','Asia/Aden',3.00,3.00,3.00),
('YT','Indian/Mayotte',3.00,3.00,3.00),
('ZA','Africa/Johannesburg',2.00,2.00,2.00),
('ZM','Africa/Lusaka',2.00,2.00,2.00),
('ZW','Africa/Harare',2.00,2.00,2.00);
/*!40000 ALTER TABLE `timezones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '0 -> banned or deactive, 1 -> active',
  `verification_token` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `provider` varchar(20) DEFAULT NULL,
  `provider_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'Azim Ahmed','user','azimahmed11040@gmail.com','6631e2b762822.png','2024-05-01 00:35:35','$2y$10$vswyd.6bx/iuuCpgu4Z7eu9FvEHbIDt7Fj3xjPdP8gaRpA4sRx7WW',1,NULL,NULL,NULL,NULL,'2024-05-01 00:35:35','2024-10-01 02:04:59','01775991798','Bangladesh','uttara-1230',NULL,'12','house-32,road-3,sector-11,uttara,dhaka'),
(2,'Bill Gates','userbill','daspobin027@gmail.com','6631e2f22dd2e.png','2024-05-01 00:36:34','$2y$10$MzX2odn0k616LMnMWLTXBORAkRRrJrVekZGp.u/INC69Ct/LdqgPu',1,NULL,NULL,NULL,NULL,'2024-05-01 00:36:34','2024-05-01 00:36:34',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_devices`
--

DROP TABLE IF EXISTS `vendor_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_id` bigint(20) unsigned NOT NULL,
  `fcm_token` varchar(500) NOT NULL,
  `device_type` varchar(255) DEFAULT NULL,
  `last_seen_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vendor_devices_fcm_token_unique` (`fcm_token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_devices`
--

LOCK TABLES `vendor_devices` WRITE;
/*!40000 ALTER TABLE `vendor_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_infos`
--

DROP TABLE IF EXISTS `vendor_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_infos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_id` bigint(20) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `details` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_infos`
--

LOCK TABLES `vendor_infos` WRITE;
/*!40000 ALTER TABLE `vendor_infos` DISABLE KEYS */;
INSERT INTO `vendor_infos` VALUES
(1,201,20,'Samantha Johnson','United States','San Francisco',NULL,'94107','321 Willow Way, House 8, Chicago, Illinois, USA, 60601','Design Skills: Samantha possesses a deep understanding of design principles and aesthetics. She excels in creating visually appealing and intuitive user interfaces (UI) that enhance user experience.\r\n\r\nUser-Centric Approach: Samantha prioritizes user needs and behavior while crafting interfaces. Her designs focus on simplicity, functionality, and ease of navigation, ensuring a positive user experience.\r\n\r\nWeb Development Proficiency: Alongside her design skills, Samantha is proficient in web development. She has expertise in various programming languages, frameworks, and technologies essential for creating responsive and dynamic websites.','2024-04-30 23:51:15','2024-05-23 04:33:58'),
(2,201,21,'سامانثا جونسون','United States','سان فرانسيسكو',NULL,'94107','321 ، 8، شيكاغو، إلينوي، الولايات المتحدة الأمريكية، 60601','سامانثا هي مصممة ماهرة متخصصة في إنشاء واجهات سهلة الاستخدام وحلول فعالة لتطوير الويب.','2024-04-30 23:51:15','2024-05-23 04:33:58'),
(3,202,20,'Oliver Patel','United Kingdom','London',NULL,'EC1A 1BB','654 Cedar Road, Building 6, Austin, Texas, USA, 73301','Oliver is a seasoned content writer known for his exceptional skills in crafting engaging and polished written content. With years of experience in the industry, Oliver has honed his abilities to create compelling narratives across various platforms and industries. His expertise extends beyond merely stringing words together; he possesses a deep understanding of how to tailor content to resonate with specific audiences while meeting clients\' objectives.','2024-04-30 23:58:04','2024-05-23 04:33:27'),
(4,202,21,'أوليفر باتيل','المملكة المتحدة','لندن',NULL,'EC1A 1BB','654 طريق سيدار، مبنى 6، أوستن، تكساس، الولايات المتحدة الأمريكية، 73301','أوليفر هو كاتب محتوى ذو خبرة ويهتم بالتفاصيل والقواعد.','2024-04-30 23:58:04','2024-05-23 04:33:27'),
(5,203,20,'Priya Sharma',NULL,NULL,NULL,NULL,'987 Birch Boulevard, Room 402, Miami, Florida, USA, 33101',NULL,'2024-05-01 00:01:01','2024-05-23 04:33:01'),
(6,203,21,'بنغالوربنغالور',NULL,NULL,NULL,NULL,'987 شارع بيرش، غرفة 402، ميامي، فلوريدا، الولايات المتحدة الأمريكية، 33101',NULL,'2024-05-01 00:01:01','2024-05-23 04:33:01'),
(7,204,20,'Jackson Lee','India','kolkata',NULL,NULL,'1010 Pine Lane, Floor 3, Seattle, Washington, USA, 98101','details','2024-05-01 00:03:03','2026-04-06 05:01:49'),
(8,204,21,'جاكسون لي','الهند','كولكاتا',NULL,NULL,'1010 باين لين، الطابق 3، سياتل، واشنطن، الولايات المتحدة الأمريكية، 98101','تفاصيل','2024-05-01 00:03:03','2026-04-06 05:09:46'),
(9,205,20,'Rachel Carter',NULL,NULL,NULL,NULL,'456 Oak Drive, Unit 12, San Francisco, CA, 94102',NULL,'2024-05-01 00:04:18','2024-05-23 04:31:55'),
(10,205,21,'نعمنعم',NULL,NULL,NULL,NULL,'456 أوك درايف، الوحدة 12، سان فرانسيسكو، كاليفورنيا، 94102',NULL,'2024-05-01 00:04:18','2024-05-23 04:31:55'),
(11,206,20,'Sofia Rousseau','France',NULL,NULL,'75001','789 Maple Avenue, Suite 101, New York, NY, 10001',NULL,'2024-05-01 00:05:59','2024-05-23 04:31:26'),
(12,206,21,'صوفيا روسو','فرنسا',NULL,NULL,'75001','789 شارع مابل، جناح 101، نيويورك، نيويورك، 10001',NULL,'2024-05-01 00:05:59','2024-05-23 04:31:26'),
(13,207,20,'Lily Chen','Australia','city','state','3000','1234 Elm Street, Apartment 5B, Springfield, Illinois, USA, 62704','Lily provides top-notch administrative and customer support as a virtual assistant.','2024-05-01 00:09:40','2025-10-30 07:40:03'),
(14,207,21,'ليلي تشين','أستراليا','ملبورن','state','3000','1234 , 5B, سبرينجفيلد, إلينوي, الولايات المتحدة الأمريكية, 62704','توفر Lily دعمًا إداريًا ودعمًا للعملاء من الدرجة الأولى كمساعد افتراضي.','2024-05-01 00:09:40','2025-10-30 07:40:30');
/*!40000 ALTER TABLE `vendor_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_notifications`
--

DROP TABLE IF EXISTS `vendor_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_notifications`
--

LOCK TABLES `vendor_notifications` WRITE;
/*!40000 ALTER TABLE `vendor_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendors`
--

DROP TABLE IF EXISTS `vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `photo` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `to_mail` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `amount` decimal(16,2) DEFAULT 0.00,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `avg_rating` float(8,2) NOT NULL DEFAULT 0.00,
  `show_email_addresss` tinyint(4) NOT NULL DEFAULT 1,
  `show_phone_number` tinyint(4) NOT NULL DEFAULT 1,
  `show_contact_form` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `lang_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendors`
--

LOCK TABLES `vendors` WRITE;
/*!40000 ALTER TABLE `vendors` DISABLE KEYS */;
INSERT INTO `vendors` VALUES
(201,'6631d85340e8e.png','listingspot56@example.com','listingspot56@example.com','+1 (555) 123-4567','listingspot','$2y$10$hEv/VEkvf6XYApROrv/aeupjgwToTwpmLNVXXDaT1hgkdEOfXsmiC',1,3231.90,'2024-04-30 23:51:15',0.00,1,1,1,'2024-04-30 23:51:15','2026-05-11 08:33:41','en','admin_en'),
(202,'6631d9ec106be.png','biznexus22@example.com','biznexus22@example.com','+44 20 1234 5678','biznexus','$2y$10$sGrrareqewDdQa0QrJ9EeOIk5h.WrpNy2B.ZOty6y4iXif4Wn3ub.',1,0.00,'2024-04-30 23:58:04',0.00,1,1,1,'2024-04-30 23:58:04','2025-01-18 21:54:21','en','admin_en'),
(203,'6631da9d0c952.png','tradetrail9@example.com','tradetrail9@example.com','+91 98765 43210','tradetrail','$2y$10$hcBv0idegTuqzD67pwzEoelHJWERLWfLccmrF.Z1rae1FgEhLUtfe',1,0.00,'2024-05-01 00:01:01',0.00,1,1,1,'2024-05-01 00:01:01','2024-05-24 22:55:06',NULL,NULL),
(204,'6631db1720b0b.png','superBusiness47@example.com','superBusiness47@example.com','+61 2 8765 4321','superbusiness47','$2y$10$8C2WPdPe2E4Vfq.gHnp4nuKrUzvpcv/zCk/aJgmNggAgoj/HG8CKC',1,987949.00,'2024-05-01 00:03:03',0.00,1,1,1,'2024-05-01 00:03:03','2026-05-21 06:05:17','en','admin_en'),
(205,'6631db62bf160.png','bizroster@example.com','bizroster@example.com','+1 (555) 987-6543','bizroster','$2y$10$EHWzz3h66.zfYNtkJeMyu.p1RAdxyjrPYgIpaY8bF1x6P8VGHv0lS',1,0.00,'2024-05-01 00:04:18',0.00,1,1,1,'2024-05-01 00:04:18','2024-05-24 22:53:22',NULL,NULL),
(206,'6631dbc785e95.png','marketlinks@example.com','marketlinks@example.com','+33 1 2345 6789','marketlink','$2y$10$UOCqKpMHdIoxqazFNFRzc.jHVab0nkROby6ituAOps1t9uh6Kk1Ju',1,196.72,'2024-05-01 00:05:59',0.00,1,1,1,'2024-05-01 00:05:59','2025-10-31 05:57:07','en','admin_en'),
(207,'6631dca4e15a7.png','marketmapper99@example.com','marketmapper99@example.com','+61 3 9876 5432','marketmapper','$2y$10$H.YwWKx8s4KAkTFWWL.3..aLKEfQJBJy61dzGzIUut4q8lPhv5GVq',1,44.47,'2024-05-01 00:09:40',0.00,1,1,1,'2024-05-01 00:09:40','2025-10-31 07:58:09','en','admin_en');
/*!40000 ALTER TABLE `vendors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_sections`
--

DROP TABLE IF EXISTS `video_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `button_name` varchar(255) DEFAULT NULL,
  `button_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_sections`
--

LOCK TABLES `video_sections` WRITE;
/*!40000 ALTER TABLE `video_sections` DISABLE KEYS */;
INSERT INTO `video_sections` VALUES
(1,20,'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusa ntium doloremque.  Start From: $200.00','Explore Your Favorite Restaurant Listsss','https://www.youtube.com/watch?v=QSwvg9Rv2EI','Browse moreee','https://www.youtube.com/','2023-12-12 23:15:10','2023-12-12 23:29:03'),
(2,21,'هل تريد أن تكون بائعًا لقائمة السيارات؟','افتح متجرك في سوق البلد','https://www.youtube.com/watch?v=QSwvg9Rv2EI','سجل الان','https://codecanyon8.kreativdev.com/carlist/vendor/signup','2023-12-12 23:16:35','2023-12-12 23:31:13');
/*!40000 ALTER TABLE `video_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitors`
--

DROP TABLE IF EXISTS `visitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitors`
--

LOCK TABLES `visitors` WRITE;
/*!40000 ALTER TABLE `visitors` DISABLE KEYS */;
INSERT INTO `visitors` VALUES
(1,1,204,'127.0.0.1','2024-05-02','2024-05-01 21:12:05','2024-05-01 21:12:05'),
(3,3,204,'127.0.0.1','2024-05-02','2024-05-01 23:49:53','2024-05-01 23:49:53'),
(4,4,204,'127.0.0.1','2024-05-02','2024-05-02 02:43:32','2024-05-02 02:43:32'),
(5,1,204,'127.0.0.1','2024-05-06','2024-05-05 20:40:04','2024-05-05 20:40:04'),
(7,4,204,'127.0.0.1','2024-05-06','2024-05-05 20:40:26','2024-05-05 20:40:26'),
(8,5,207,'127.0.0.1','2024-05-06','2024-05-05 21:00:12','2024-05-05 21:00:12'),
(9,6,206,'127.0.0.1','2024-05-06','2024-05-05 22:08:15','2024-05-05 22:08:15'),
(10,7,205,'127.0.0.1','2024-05-06','2024-05-05 23:24:17','2024-05-05 23:24:17'),
(12,5,207,'127.0.0.1','2024-05-07','2024-05-06 20:38:05','2024-05-06 20:38:05'),
(13,9,201,'127.0.0.1','2024-05-07','2024-05-06 20:58:24','2024-05-06 20:58:24'),
(14,10,203,'127.0.0.1','2024-05-07','2024-05-06 21:33:19','2024-05-06 21:33:19'),
(15,11,202,'127.0.0.1','2024-05-07','2024-05-06 22:34:41','2024-05-06 22:34:41'),
(16,12,205,'127.0.0.1','2024-05-07','2024-05-07 00:20:21','2024-05-07 00:20:21'),
(17,13,207,'127.0.0.1','2024-05-07','2024-05-07 02:56:24','2024-05-07 02:56:24'),
(18,1,204,'127.0.0.1','2024-05-07','2024-05-07 02:57:57','2024-05-07 02:57:57'),
(19,4,204,'127.0.0.1','2024-05-08','2024-05-07 21:30:27','2024-05-07 21:30:27'),
(20,1,204,'127.0.0.1','2024-05-08','2024-05-07 22:31:14','2024-05-07 22:31:14'),
(22,11,202,'127.0.0.1','2024-05-08','2024-05-07 22:36:24','2024-05-07 22:36:24'),
(23,10,203,'127.0.0.1','2024-05-08','2024-05-07 22:45:38','2024-05-07 22:45:38'),
(24,3,204,'127.0.0.1','2024-05-08','2024-05-07 23:33:14','2024-05-07 23:33:14'),
(25,14,204,'127.0.0.1','2024-05-08','2024-05-07 23:36:42','2024-05-07 23:36:42'),
(26,15,204,'127.0.0.1','2024-05-08','2024-05-08 03:00:30','2024-05-08 03:00:30'),
(27,13,207,'127.0.0.1','2024-05-08','2024-05-08 03:33:43','2024-05-08 03:33:43'),
(28,12,205,'127.0.0.1','2024-05-08','2024-05-08 03:37:20','2024-05-08 03:37:20'),
(30,9,201,'127.0.0.1','2024-05-08','2024-05-08 03:43:31','2024-05-08 03:43:31'),
(31,5,207,'127.0.0.1','2024-05-08','2024-05-08 03:44:02','2024-05-08 03:44:02'),
(32,6,206,'127.0.0.1','2024-05-08','2024-05-08 03:46:15','2024-05-08 03:46:15'),
(33,7,205,'127.0.0.1','2024-05-08','2024-05-08 03:47:30','2024-05-08 03:47:30'),
(34,5,207,'127.0.0.1','2024-05-11','2024-05-10 23:26:54','2024-05-10 23:26:54'),
(36,1,204,'127.0.0.1','2024-05-15','2024-05-15 04:01:53','2024-05-15 04:01:53'),
(37,4,204,'127.0.0.1','2024-05-16','2024-05-16 03:46:08','2024-05-16 03:46:08'),
(40,15,204,'127.0.0.1','2024-06-02','2024-06-02 03:01:03','2024-06-02 03:01:03'),
(41,15,204,'127.0.0.1','2024-07-08','2024-07-08 04:04:12','2024-07-08 04:04:12'),
(42,1,204,'127.0.0.1','2024-08-10','2024-08-10 02:13:34','2024-08-10 02:13:34'),
(43,10,203,'127.0.0.1','2024-10-01','2024-09-30 22:00:59','2024-09-30 22:00:59'),
(44,15,204,'127.0.0.1','2024-10-15','2024-10-15 01:07:41','2024-10-15 01:07:41'),
(45,10,203,'127.0.0.1','2024-10-15','2024-10-15 01:11:11','2024-10-15 01:11:11'),
(46,15,204,'127.0.0.1','2024-10-29','2024-10-28 23:53:36','2024-10-28 23:53:36'),
(47,15,204,'127.0.0.1','2024-11-09','2024-11-08 23:06:53','2024-11-08 23:06:53'),
(48,15,204,'127.0.0.1','2024-11-20','2024-11-20 00:37:18','2024-11-20 00:37:18'),
(49,4,204,'127.0.0.1','2024-11-30','2024-11-30 00:33:57','2024-11-30 00:33:57'),
(52,1,204,'127.0.0.1','2025-01-19','2025-01-18 21:57:56','2025-01-18 21:57:56'),
(53,1,204,'127.0.0.1','2025-09-17','2025-09-17 02:00:22','2025-09-17 02:00:22'),
(54,13,207,'127.0.0.1','2025-09-17','2025-09-17 04:16:11','2025-09-17 04:16:11'),
(56,10,203,'127.0.0.1','2025-09-20','2025-09-20 01:42:48','2025-09-20 01:42:48'),
(57,3,204,'127.0.0.1','2025-09-20','2025-09-20 01:43:05','2025-09-20 01:43:05'),
(58,1,204,'127.0.0.1','2025-09-20','2025-09-20 01:43:21','2025-09-20 01:43:21'),
(59,5,207,'127.0.0.1','2025-09-21','2025-09-21 02:29:37','2025-09-21 02:29:37'),
(60,13,207,'127.0.0.1','2025-09-21','2025-09-21 06:58:57','2025-09-21 06:58:57'),
(61,10,203,'127.0.0.1','2025-09-21','2025-09-21 07:11:16','2025-09-21 07:11:16'),
(62,12,205,'127.0.0.1','2025-09-21','2025-09-21 07:11:27','2025-09-21 07:11:27'),
(63,14,204,'127.0.0.1','2025-09-21','2025-09-21 07:11:40','2025-09-21 07:11:40'),
(64,15,204,'127.0.0.1','2025-09-21','2025-09-21 07:11:57','2025-09-21 07:11:57'),
(66,1,204,'127.0.0.1','2025-09-22','2025-09-22 07:00:19','2025-09-22 07:00:19'),
(68,1,204,'127.0.0.1','2025-09-30','2025-09-30 01:41:33','2025-09-30 01:41:33'),
(69,13,207,'127.0.0.1','2025-10-04','2025-10-04 05:01:46','2025-10-04 05:01:46'),
(70,13,207,'127.0.0.1','2025-10-10','2025-10-10 07:18:10','2025-10-10 07:18:10'),
(71,5,207,'127.0.0.1','2025-10-10','2025-10-10 07:18:42','2025-10-10 07:18:42'),
(73,13,207,'127.0.0.1','2025-10-15','2025-10-14 23:16:23','2025-10-14 23:16:23'),
(74,15,204,'127.0.0.1','2025-10-21','2025-10-20 22:23:27','2025-10-20 22:23:27'),
(75,1,204,'127.0.0.1','2025-10-21','2025-10-21 04:07:24','2025-10-21 04:07:24'),
(76,10,203,'127.0.0.1','2025-10-23','2025-10-22 23:02:08','2025-10-22 23:02:08'),
(78,1,204,'127.0.0.1','2025-10-24','2025-10-24 06:15:17','2025-10-24 06:15:17'),
(79,13,207,'127.0.0.1','2025-10-25','2025-10-25 05:20:42','2025-10-25 05:20:42'),
(80,15,204,'127.0.0.1','2025-10-25','2025-10-25 06:13:12','2025-10-25 06:13:12'),
(82,5,207,'127.0.0.1','2025-10-27','2025-10-27 00:09:31','2025-10-27 00:09:31'),
(84,5,207,'127.0.0.1','2025-10-28','2025-10-27 22:36:03','2025-10-27 22:36:03'),
(85,13,207,'127.0.0.1','2025-10-29','2025-10-29 06:58:44','2025-10-29 06:58:44'),
(86,17,0,'127.0.0.1','2025-10-29','2025-10-29 06:59:08','2025-10-29 06:59:08'),
(87,12,205,'127.0.0.1','2025-10-30','2025-10-30 00:18:18','2025-10-30 00:18:18'),
(88,1,204,'127.0.0.1','2025-10-30','2025-10-30 02:10:14','2025-10-30 02:10:14'),
(89,4,204,'127.0.0.1','2025-10-30','2025-10-30 02:10:23','2025-10-30 02:10:23'),
(90,11,202,'127.0.0.1','2025-10-30','2025-10-30 08:16:00','2025-10-30 08:16:00'),
(91,13,207,'127.0.0.1','2025-10-31','2025-10-31 05:53:02','2025-10-31 05:53:02'),
(92,17,0,'127.0.0.1','2025-11-03','2025-11-03 00:00:06','2025-11-03 00:00:06'),
(93,11,202,'127.0.0.1','2025-11-03','2025-11-03 00:00:52','2025-11-03 00:00:52'),
(94,15,204,'127.0.0.1','2025-11-03','2025-11-03 00:03:16','2025-11-03 00:03:16'),
(95,14,204,'127.0.0.1','2025-11-03','2025-11-03 07:28:08','2025-11-03 07:28:08'),
(96,12,205,'127.0.0.1','2025-11-03','2025-11-03 07:30:30','2025-11-03 07:30:30'),
(97,14,204,'127.0.0.1','2025-11-04','2025-11-03 22:52:56','2025-11-03 22:52:56'),
(98,15,204,'127.0.0.1','2025-11-04','2025-11-03 22:55:03','2025-11-03 22:55:03'),
(99,1,204,'127.0.0.1','2025-11-04','2025-11-03 23:01:50','2025-11-03 23:01:50'),
(100,10,203,'127.0.0.1','2025-11-17','2025-11-17 04:21:53','2025-11-17 04:21:53'),
(101,7,205,'127.0.0.1','2025-11-17','2025-11-17 06:16:34','2025-11-17 06:16:34'),
(102,11,202,'127.0.0.1','2025-11-18','2025-11-17 23:13:51','2025-11-17 23:13:51'),
(103,10,203,'127.0.0.1','2025-11-20','2025-11-20 00:28:23','2025-11-20 00:28:23'),
(104,15,204,'127.0.0.1','2025-11-22','2025-11-22 06:21:43','2025-11-22 06:21:43'),
(105,10,203,'127.0.0.1','2025-11-22','2025-11-22 06:21:52','2025-11-22 06:21:52'),
(106,14,204,'127.0.0.1','2025-11-24','2025-11-23 22:56:48','2025-11-23 22:56:48'),
(107,14,204,'127.0.0.1','2025-11-25','2025-11-25 02:57:28','2025-11-25 02:57:28'),
(108,15,204,'127.0.0.1','2025-11-25','2025-11-25 03:28:02','2025-11-25 03:28:02'),
(109,9,201,'127.0.0.1','2025-11-25','2025-11-25 04:00:12','2025-11-25 04:00:12'),
(110,15,204,'127.0.0.1','2025-11-26','2025-11-26 01:16:25','2025-11-26 01:16:25'),
(111,14,204,'127.0.0.1','2025-12-06','2025-12-06 04:28:14','2025-12-06 04:28:14'),
(112,14,204,'127.0.0.1','2025-12-07','2025-12-06 20:51:31','2025-12-06 20:51:31'),
(113,17,0,'127.0.0.1','2025-12-07','2025-12-06 22:02:21','2025-12-06 22:02:21'),
(114,11,202,'127.0.0.1','2025-12-07','2025-12-06 22:03:29','2025-12-06 22:03:29'),
(115,10,203,'127.0.0.1','2025-12-07','2025-12-06 22:58:19','2025-12-06 22:58:19'),
(116,1,204,'127.0.0.1','2025-12-07','2025-12-06 23:02:19','2025-12-06 23:02:19'),
(118,4,204,'127.0.0.1','2026-04-05','2026-04-05 03:51:48','2026-04-05 03:51:48'),
(119,14,204,'127.0.0.1','2026-04-07','2026-04-07 04:39:55','2026-04-07 04:39:55'),
(120,15,204,'127.0.0.1','2026-04-07','2026-04-07 04:39:55','2026-04-07 04:39:55'),
(121,4,204,'127.0.0.1','2026-04-07','2026-04-07 04:39:55','2026-04-07 04:39:55'),
(122,3,204,'127.0.0.1','2026-04-07','2026-04-07 04:39:56','2026-04-07 04:39:56'),
(123,1,204,'127.0.0.1','2026-04-07','2026-04-07 04:39:57','2026-04-07 04:39:57'),
(124,15,204,'127.0.0.1','2026-04-22','2026-04-21 22:16:04','2026-04-21 22:16:04'),
(125,1,204,'127.0.0.1','2026-04-22','2026-04-21 23:50:00','2026-04-21 23:50:00'),
(126,14,204,'127.0.0.1','2026-04-22','2026-04-21 23:51:57','2026-04-21 23:51:57'),
(127,4,204,'127.0.0.1','2026-04-22','2026-04-21 23:51:58','2026-04-21 23:51:58'),
(128,14,204,'127.0.0.1','2026-05-12','2026-05-12 08:19:09','2026-05-12 08:19:09'),
(129,13,207,'127.0.0.1','2026-05-12','2026-05-12 08:20:50','2026-05-12 08:20:50'),
(130,18,0,'127.0.0.1','2026-05-12','2026-05-12 08:20:59','2026-05-12 08:20:59'),
(131,12,205,'127.0.0.1','2026-05-12','2026-05-12 08:21:06','2026-05-12 08:21:06'),
(132,1,204,'127.0.0.1','2026-05-12','2026-05-12 08:23:23','2026-05-12 08:23:23'),
(133,1,204,'127.0.0.1','2026-05-13','2026-05-12 23:42:03','2026-05-12 23:42:03'),
(134,14,204,'127.0.0.1','2026-05-13','2026-05-13 01:17:19','2026-05-13 01:17:19'),
(135,18,0,'127.0.0.1','2026-05-21','2026-05-21 05:40:43','2026-05-21 05:40:43'),
(136,17,0,'127.0.0.1','2026-05-21','2026-05-21 05:48:43','2026-05-21 05:48:43'),
(137,1,204,'127.0.0.1','2026-05-21','2026-05-21 06:07:52','2026-05-21 06:07:52');
/*!40000 ALTER TABLE `visitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlists`
--

LOCK TABLES `wishlists` WRITE;
/*!40000 ALTER TABLE `wishlists` DISABLE KEYS */;
INSERT INTO `wishlists` VALUES
(1,1,14,'2024-05-07 21:29:55','2024-05-07 21:29:55'),
(3,1,6,'2024-05-07 21:30:04','2024-05-07 21:30:04'),
(4,1,2,'2024-05-07 21:30:15','2024-05-07 21:30:15'),
(7,12,9,'2025-11-19 05:31:27','2025-11-19 05:31:27'),
(12,12,10,'2025-11-25 00:20:42','2025-11-25 00:20:42');
/*!40000 ALTER TABLE `wishlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdraw_method_inputs`
--

DROP TABLE IF EXISTS `withdraw_method_inputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraw_method_inputs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `withdraw_payment_method_id` bigint(20) unsigned DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1-text, 2-select, 3-checkbox, 4-textarea, 5-datepicker, 6-timepicker, 7-number',
  `label` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `placeholder` varchar(255) DEFAULT NULL,
  `required` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1-required, 0-optional',
  `order_number` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw_method_inputs`
--

LOCK TABLES `withdraw_method_inputs` WRITE;
/*!40000 ALTER TABLE `withdraw_method_inputs` DISABLE KEYS */;
INSERT INTO `withdraw_method_inputs` VALUES
(1,1,1,'fdfd','fdfd','fdfd',1,1,'2025-10-14 02:55:54','2025-10-14 02:55:54'),
(2,1,2,'test12','test12','test2',0,2,'2025-10-14 04:14:54','2025-10-14 04:15:08'),
(3,1,6,'time','time','time',1,3,'2025-10-14 04:15:47','2025-10-14 04:15:47'),
(4,1,5,'date','date','date',1,4,'2025-10-14 04:16:01','2025-10-14 04:16:01'),
(5,1,3,'fdfdf','fdfdf',NULL,1,5,'2025-10-14 04:24:37','2025-10-14 04:24:37'),
(6,1,4,'fdfdfdfdfdd','fdfdfdfdfdd','fdf',1,6,'2025-10-14 04:24:50','2025-10-14 04:24:50'),
(7,2,2,'bKash Account Type','bKash_Account_Type','Select a  Type',1,1,'2025-10-14 05:04:12','2025-10-14 05:04:12'),
(8,2,1,'bKash Mobile Number','bKash_Mobile_Number','Enter number',1,2,'2025-10-14 05:04:41','2025-10-14 05:04:41'),
(9,2,1,'bKash Account Holder Name','bKash_Account_Holder_Name','Enter name',1,3,'2025-10-14 05:05:01','2025-10-14 05:05:01');
/*!40000 ALTER TABLE `withdraw_method_inputs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdraw_method_options`
--

DROP TABLE IF EXISTS `withdraw_method_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraw_method_options` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `withdraw_method_input_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw_method_options`
--

LOCK TABLES `withdraw_method_options` WRITE;
/*!40000 ALTER TABLE `withdraw_method_options` DISABLE KEYS */;
INSERT INTO `withdraw_method_options` VALUES
(2,2,'test2','2025-10-14 04:15:08','2025-10-14 04:15:08'),
(3,5,'fdffd','2025-10-14 04:24:37','2025-10-14 04:24:37'),
(4,5,'fdfdfddf','2025-10-14 04:24:37','2025-10-14 04:24:37'),
(5,7,'Personal','2025-10-14 05:04:12','2025-10-14 05:04:12'),
(6,7,'Agent','2025-10-14 05:04:12','2025-10-14 05:04:12'),
(7,7,'Merchant','2025-10-14 05:04:12','2025-10-14 05:04:12');
/*!40000 ALTER TABLE `withdraw_method_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdraw_payment_methods`
--

DROP TABLE IF EXISTS `withdraw_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraw_payment_methods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `min_limit` double(12,2) DEFAULT NULL,
  `max_limit` double(12,2) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `fixed_charge` double(12,2) NOT NULL DEFAULT 0.00,
  `percentage_charge` double(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw_payment_methods`
--

LOCK TABLES `withdraw_payment_methods` WRITE;
/*!40000 ALTER TABLE `withdraw_payment_methods` DISABLE KEYS */;
INSERT INTO `withdraw_payment_methods` VALUES
(2,10.00,1000.00,'bkash',1,2.00,5.00,'2025-10-14 04:58:14','2026-04-05 03:12:48');
/*!40000 ALTER TABLE `withdraw_payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdraws`
--

DROP TABLE IF EXISTS `withdraws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraws` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_id` bigint(20) unsigned DEFAULT NULL,
  `withdraw_id` varchar(255) DEFAULT NULL,
  `method_id` int(11) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `payable_amount` double(8,2) NOT NULL DEFAULT 0.00,
  `total_charge` double(8,2) NOT NULL DEFAULT 0.00,
  `additional_reference` text DEFAULT NULL,
  `feilds` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraws`
--

LOCK TABLES `withdraws` WRITE;
/*!40000 ALTER TABLE `withdraws` DISABLE KEYS */;
INSERT INTO `withdraws` VALUES
(2,207,'68ee487aba6b1',2,'10',7.60,2.40,'test','{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"3434344343\",\"bKash_Account_Holder_Name\":\"jonh doe\"}',2,'2025-10-14 06:56:26','2025-10-14 06:58:36'),
(8,204,'69d228497bccc',2,'1000',948.10,51.90,NULL,'{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"01403818435\",\"bKash_Account_Holder_Name\":\"Goutam\"}',1,'2026-04-05 03:15:53','2026-04-12 04:46:17'),
(9,204,'69d2284a8d00b',2,'1000',948.10,51.90,NULL,'{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"01403818435\",\"bKash_Account_Holder_Name\":\"Goutam\"}',2,'2026-04-05 03:15:54','2026-04-12 04:46:22'),
(16,204,'69db77d718e8e',2,'1000',948.10,51.90,NULL,'{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"0151828826\",\"bKash_Account_Holder_Name\":\"Goutam Sharma\"}',1,'2026-04-12 04:45:43','2026-04-12 04:45:59'),
(17,204,'69db78a39ebde',2,'1000',948.10,51.90,NULL,'{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"15728281991\",\"bKash_Account_Holder_Name\":\"Super Business\"}',0,'2026-04-12 04:49:07','2026-04-12 04:49:07'),
(18,204,'6a03361d47187',2,'50',45.60,4.40,'nkjkk','{\"bKash_Account_Type\":\"Personal\",\"bKash_Mobile_Number\":\"1313\",\"bKash_Account_Holder_Name\":\"jhjhjh\"}',1,'2026-05-12 08:15:57','2026-05-12 08:16:32');
/*!40000 ALTER TABLE `withdraws` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_process_sections`
--

DROP TABLE IF EXISTS `work_process_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_process_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `button_text` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_process_sections`
--

LOCK TABLES `work_process_sections` WRITE;
/*!40000 ALTER TABLE `work_process_sections` DISABLE KEYS */;
INSERT INTO `work_process_sections` VALUES
(3,20,'Explore Listings','How Bulistio Works','2023-08-19 04:05:15','2024-05-06 03:07:43'),
(4,21,'استكشاف القوائم','كيف يعمل بوليستيو','2023-08-28 02:59:46','2024-05-06 03:15:53');
/*!40000 ALTER TABLE `work_process_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_processes`
--

DROP TABLE IF EXISTS `work_processes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_processes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `icon` varchar(255) NOT NULL,
  `serial_number` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_processes`
--

LOCK TABLES `work_processes` WRITE;
/*!40000 ALTER TABLE `work_processes` DISABLE KEYS */;
INSERT INTO `work_processes` VALUES
(14,20,'fas fa-suitcase',3,'Explore Selected Place','They are definitely recommend them if you are looking for a good car service. always on time, and they\'re very professional.','2023-08-19 04:06:12','2024-05-09 02:45:00'),
(15,20,'fas fa-map-marker-alt',2,'Select Favorite Place','They definitely recommend them if you are looking for a good car service. always on time, and they\'re very professional.','2023-08-19 04:06:46','2024-05-09 02:45:23'),
(16,20,'fas fa-th',1,'Choose A Category','They definitely recommend them if you are looking for a good car service. always on time, and they\'re very professional.','2023-08-19 04:07:22','2024-05-09 02:46:06'),
(17,21,'fas fa-search',1,'ابحث عن سيارة أحلامك','إنهم بالتأكيد يوصون بهم إذا كنت تبحث عن خدمة سيارات جيدة. دائمًا في الوقت المحدد، وهم محترفون جدًا.','2023-08-28 03:00:33','2023-08-28 03:00:33'),
(18,21,'fas fa-file-invoice-dollar',2,'التحقق من السعر مع الميزات','إنهم يوصون بهم بالتأكيد إذا كنت تبحث عن خدمة سيارات جيدة. دائمًا في الوقت المحدد، وهم محترفون جدًا.','2023-08-28 03:01:12','2023-08-28 03:01:12'),
(19,21,'fas fa-headphones-alt',3,'تواصل مع التاجر','إنهم يوصون بهم بالتأكيد إذا كنت تبحث عن خدمة سيارات جيدة. دائمًا في الوقت المحدد، وهم محترفون جدًا.','2023-08-28 03:02:15','2023-08-28 03:02:15');
/*!40000 ALTER TABLE `work_processes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-24  8:57:19
