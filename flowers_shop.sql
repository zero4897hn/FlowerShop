-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 17, 2019 at 10:27 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flowers_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `chi_tiet_khuyen_mai`
--

CREATE TABLE `chi_tiet_khuyen_mai` (
  `id_khuyen_mai` int(11) NOT NULL,
  `id_kieu_san_pham` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `chi_tiet_khuyen_mai`
--

INSERT INTO `chi_tiet_khuyen_mai` (`id_khuyen_mai`, `id_kieu_san_pham`) VALUES
(7, 2),
(7, 3),
(7, 4),
(7, 5),
(7, 7),
(7, 8),
(7, 9),
(7, 14),
(7, 16),
(7, 17),
(7, 19),
(7, 20),
(7, 21),
(7, 23),
(7, 24),
(7, 25),
(7, 26),
(7, 27),
(7, 40),
(7, 41),
(7, 42),
(8, 5),
(8, 14),
(8, 20),
(8, 21),
(8, 23),
(8, 24),
(8, 25),
(8, 26),
(8, 38),
(8, 39),
(8, 40),
(8, 41),
(8, 43),
(8, 44),
(8, 45),
(8, 46);

-- --------------------------------------------------------

--
-- Table structure for table `chuc_vu`
--

CREATE TABLE `chuc_vu` (
  `id` int(11) NOT NULL,
  `ten_chuc_vu` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `chuc_vu`
--

INSERT INTO `chuc_vu` (`id`, `ten_chuc_vu`) VALUES
(1, 'Khách hàng'),
(2, 'Nhân viên'),
(3, 'Quản trị');

-- --------------------------------------------------------

--
-- Table structure for table `dang_nhap`
--

CREATE TABLE `dang_nhap` (
  `id` int(11) NOT NULL,
  `id_nhan_vien` int(11) NOT NULL,
  `ten_dang_nhap` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `mat_khau` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `dang_nhap`
--

INSERT INTO `dang_nhap` (`id`, `id_nhan_vien`, `ten_dang_nhap`, `mat_khau`) VALUES
(1, 1, 'zero4897hn', 'nobita12'),
(3, 3, 'kanna123', '123456'),
(4, 4, 'suzuko123', '123456'),
(5, 5, 'maki123', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `danh_gia`
--

CREATE TABLE `danh_gia` (
  `id` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `id_nhan_vien` int(11) NOT NULL,
  `so_sao` int(11) NOT NULL,
  `tieu_de` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `noi_dung` text COLLATE utf8_unicode_ci NOT NULL,
  `thoi_gian_danh_gia` datetime NOT NULL,
  `da_xem` bit(1) NOT NULL,
  `da_xoa` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `danh_gia`
--

INSERT INTO `danh_gia` (`id`, `id_san_pham`, `id_nhan_vien`, `so_sao`, `tieu_de`, `noi_dung`, `thoi_gian_danh_gia`, `da_xem`, `da_xoa`) VALUES
(3, 2, 1, 5, 'Tuyệt vời', 'Chất lượng sản phẩm tuyệt vời', '2019-06-30 13:43:01', b'1', b'0');

--
-- Triggers `danh_gia`
--
DELIMITER $$
CREATE TRIGGER `AutoGenerating` BEFORE INSERT ON `danh_gia` FOR EACH ROW BEGIN
	SET new.da_xem = 0;
	SET new.thoi_gian_danh_gia = now();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `danh_muc`
--

CREATE TABLE `danh_muc` (
  `id` int(11) NOT NULL,
  `ten_danh_muc` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `danh_muc`
--

INSERT INTO `danh_muc` (`id`, `ten_danh_muc`) VALUES
(1, 'Hoa sinh nhật'),
(2, 'Hoa tình yêu'),
(3, 'Hoa chúc mừng'),
(4, 'Hoa Giáng Sinh'),
(5, 'Hoa chia buồn');

-- --------------------------------------------------------

--
-- Table structure for table `don_hang`
--

CREATE TABLE `don_hang` (
  `id` int(11) NOT NULL,
  `id_kieu_san_pham` int(11) NOT NULL,
  `id_hoa_don` int(11) NOT NULL,
  `so_luong` int(11) NOT NULL,
  `thanh_tien` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `don_hang`
--

INSERT INTO `don_hang` (`id`, `id_kieu_san_pham`, `id_hoa_don`, `so_luong`, `thanh_tien`) VALUES
(1, 7, 1, 1, 1500000),
(2, 3, 1, 1, 1800000),
(3, 2, 1, 1, 350000),
(4, 3, 2, 1, 1800000),
(6, 16, 2, 1, 500000),
(7, 7, 3, 1, 1500000),
(8, 2, 3, 1, 350000),
(9, 28, 3, 1, 1700000),
(10, 3, 4, 5, 9000000),
(11, 28, 4, 1, 1700000),
(12, 16, 4, 1, 500000),
(13, 25, 4, 6, 2100000),
(14, 3, 5, 5, 9000000),
(15, 29, 5, 1, 1200000),
(16, 25, 6, 1, 350000),
(17, 14, 6, 1, 350000),
(18, 3, 6, 1, 1800000);

-- --------------------------------------------------------

--
-- Table structure for table `hoa_don`
--

CREATE TABLE `hoa_don` (
  `id` int(11) NOT NULL,
  `ma_hoa_don` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `id_nhan_vien` int(11) DEFAULT NULL,
  `ho_ten_nguoi_nhan` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `dia_chi_giao_hang` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `so_dien_thoai` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tinh_trang` int(11) NOT NULL DEFAULT '0',
  `nguyen_nhan` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `da_xem` bit(1) NOT NULL,
  `ngay_lap` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `hoa_don`
--

INSERT INTO `hoa_don` (`id`, `ma_hoa_don`, `id_nhan_vien`, `ho_ten_nguoi_nhan`, `dia_chi_giao_hang`, `so_dien_thoai`, `ghi_chu`, `tinh_trang`, `nguyen_nhan`, `da_xem`, `ngay_lap`) VALUES
(1, '8FC1A156-9956-11E9-9', 1, 'Bùi Tuấn Đạt', '99 tổ 28 ngõ 250 Kim Giang, Hoàng Mai, Hà Nội', '0972753644', NULL, 2, NULL, b'0', '2019-06-28 10:40:52'),
(2, '99DE2F78-9956-11E9-9', 1, 'Bùi Tuấn Đạt', '99 tổ 28 ngõ 250 Kim Giang, Hoàng Mai, Hà Nội', '0972753644', NULL, 0, NULL, b'0', '2019-06-28 10:41:09'),
(3, 'DAAE0E53-9A7E-11E9-9', 1, 'Bùi Tuấn Đạt', '99 tổ 28 ngõ 250 Kim Giang, Hoàng Mai, Hà Nội', '0972753644', NULL, -1, NULL, b'0', '2019-06-29 22:01:44'),
(4, '75AE6CFE-9F0C-11E9-9', 1, 'Bùi Tuấn Đạt', '99 tổ 28 ngõ 250 Kim Giang, Hoàng Mai, Hà Nội', '0972753644', NULL, 0, NULL, b'0', '2019-07-05 17:05:46'),
(5, '3D7E94B0-A375-11E9-9', 1, 'Bùi Tuấn Đạt', '99 tổ 28 ngõ 250 Kim Giang, Hoàng Mai, Hà Nội', '0972753644', NULL, -1, NULL, b'1', '2019-07-11 07:45:49'),
(6, '93EAF3D4-A6CB-11E9-9', 1, 'Bùi Tuấn Đạt', '99 tổ 28 ngõ 250 Kim Giang, Hoàng Mai, Hà Nội', '0972753644', NULL, 1, NULL, b'1', '2019-07-15 13:41:25');

--
-- Triggers `hoa_don`
--
DELIMITER $$
CREATE TRIGGER `AutoGeneratingHoaDon` BEFORE INSERT ON `hoa_don` FOR EACH ROW BEGIN
	SET new.ngay_lap = now();
    SET new.ma_hoa_don = UPPER(UUID());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `khuyen_mai`
--

CREATE TABLE `khuyen_mai` (
  `id` int(11) NOT NULL,
  `ten_khuyen_mai` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `thoi_gian_bat_dau` datetime NOT NULL,
  `thoi_gian_ket_thuc` datetime NOT NULL,
  `phan_tram_giam` int(11) NOT NULL DEFAULT '0',
  `gia_giam_toi_da` bigint(20) NOT NULL DEFAULT '0',
  `mo_ta` text COLLATE utf8_unicode_ci,
  `hinh_khuyen_mai` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `da_xoa` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `khuyen_mai`
--

INSERT INTO `khuyen_mai` (`id`, `ten_khuyen_mai`, `thoi_gian_bat_dau`, `thoi_gian_ket_thuc`, `phan_tram_giam`, `gia_giam_toi_da`, `mo_ta`, `hinh_khuyen_mai`, `da_xoa`) VALUES
(7, 'gsdhsdh', '1907-07-07 07:07:00', '9999-09-09 21:09:00', 10, 100000, 'sdhsdhsdh', NULL, b'0'),
(8, 'ấg', '6666-06-05 06:06:00', '8888-05-04 18:06:00', 10, 1000000, 'gágá', NULL, b'1');

-- --------------------------------------------------------

--
-- Table structure for table `kieu_san_pham`
--

CREATE TABLE `kieu_san_pham` (
  `id` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `ten_kieu` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gia_tien` bigint(20) NOT NULL DEFAULT '0',
  `so_luong` int(11) NOT NULL DEFAULT '0',
  `luong_mua` int(11) NOT NULL,
  `ngay_nhap` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `kieu_san_pham`
--

INSERT INTO `kieu_san_pham` (`id`, `id_san_pham`, `ten_kieu`, `gia_tien`, `so_luong`, `luong_mua`, `ngay_nhap`) VALUES
(2, 2, 'Phút Yêu Đầu 2', 350000, 24, 3, '2019-05-06 11:33:42'),
(3, 3, 'Nắng yêu thương', 1800000, 39, 5, '2019-05-06 11:36:18'),
(4, 3, 'Cắm tròn hai mặt', 2500000, 60, 0, '2019-05-06 11:36:18'),
(5, 4, 'Memory Of Love', 450000, 59, 0, '2019-05-06 11:38:39'),
(7, 6, 'Phồn Vinh', 1500000, 41, 3, '2019-05-08 16:40:36'),
(8, 7, 'Bó hoa tươi Dịu Dàng', 600000, 30, 0, '2019-05-07 13:28:27'),
(9, 8, 'Red Rose', 2000000, 39, 0, '2019-05-07 13:30:31'),
(14, 13, 'Hồn Nhiên', 350000, 27, 1, '2019-05-08 15:25:34'),
(16, 15, 'Khởi đầu mới', 500000, 41, 2, '2019-05-08 15:30:05'),
(17, 15, 'Cắm tròn hai mặt', 600000, 50, 0, '2019-05-08 15:30:05'),
(19, 17, 'Success Flowers', 900000, 50, 0, '2019-05-08 15:35:50'),
(20, 18, 'Người Tôi Thương', 400000, 100, 0, '2019-05-08 15:38:51'),
(21, 18, 'Cắm tròn hai mặt', 500000, 100, 0, '2019-05-08 15:38:51'),
(23, 21, 'Lời tỏ tình', 600000, 100, 0, '2019-05-08 15:58:41'),
(24, 22, 'First Kiss', 500000, 500, 0, '2019-05-08 16:00:49'),
(25, 23, NULL, 350000, 492, 2, '2019-05-08 16:02:41'),
(26, 24, 'Gold Love', 300000, 300, 0, '2019-05-08 16:04:19'),
(27, 25, NULL, 1400000, 140, 0, '2019-05-08 16:05:41'),
(28, 26, NULL, 1700000, 77, 3, '2019-05-08 16:06:52'),
(29, 27, 'null', 1200000, 39, 1, '2019-05-08 16:09:03'),
(37, 29, 'In Your Eyes', 1400000, 50, 0, '2019-06-15 14:56:55'),
(38, 30, 'Yêu Thương Hạnh Phúc', 350000, 48, 0, '2019-06-15 14:59:58'),
(39, 31, 'Purple Love', 2400000, 1000, 0, '2019-06-15 15:02:48'),
(40, 32, 'Những Nụ Hôn', 400000, 50, 0, '2019-06-15 15:03:37'),
(41, 33, 'Believe Me', 600000, 50, 0, '2019-06-15 15:04:46'),
(42, 34, 'Kiếp nhân sinh', 1200000, 50, 0, '2019-06-15 15:06:18'),
(43, 35, 'Nụ Cười', 450000, 50, 0, '2019-06-15 16:57:37'),
(44, 35, 'Cắm tròn hai mặt', 600000, 50, 0, '2019-06-15 16:57:37'),
(45, 36, 'Hè Rực Rỡ', 800000, 100, 0, '2019-06-15 17:01:54'),
(46, 37, 'Hạnh Phúc', 550000, 50, 0, '2019-06-15 17:03:21');

--
-- Triggers `kieu_san_pham`
--
DELIMITER $$
CREATE TRIGGER `AutoGeneratingNgayNhap` BEFORE INSERT ON `kieu_san_pham` FOR EACH ROW BEGIN
	SET new.ngay_nhap = now();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `nhan_vien`
--

CREATE TABLE `nhan_vien` (
  `id` int(11) NOT NULL,
  `ten_nhan_vien` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `gioi_tinh` bit(1) NOT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `dia_chi` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chung_minh_nhan_dan` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `so_dien_thoai` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_chuc_vu` int(11) NOT NULL DEFAULT '1',
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ngay_them` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `nhan_vien`
--

INSERT INTO `nhan_vien` (`id`, `ten_nhan_vien`, `gioi_tinh`, `ngay_sinh`, `dia_chi`, `chung_minh_nhan_dan`, `so_dien_thoai`, `email`, `id_chuc_vu`, `avatar`, `ngay_them`) VALUES
(1, 'Bùi Tuấn Đạt', b'1', '1997-08-04', '99 tổ 28 ngõ 250 Kim Giang, Hoàng Mai, Hà Nội', '1234567890', '0972753644', 'zero4897hn@gmail.com', 3, 'hashimoto_kanna_digital_painting_by_garuby_dce86xi-pre.jpg', '2019-05-13 16:48:36'),
(3, 'Hashimoto Kanna', b'0', '1999-02-02', 'Fukuoka, Nhật Bản', '214125125125', '1512512515', 'kanna@gmail.com', 2, 'hashimoto_kanna_digital_painting_by_garuby_dce86xi-pre.jpg', '2019-07-02 13:15:13'),
(4, 'Mimori Suzuko', b'0', '1986-06-27', 'Tôkyô, Nhật Bản', '1251251251', '512512512512', 'suzuko@gmail.com', 2, '51DWkZJo-PL.jpg', '2019-07-02 13:18:38'),
(5, 'Horikita Maki', b'0', '1988-10-05', 'Kiyose, Tokyo, Tôkyô, Nhật Bản', '21515125', '125125125', 'maki@gmail.com', 2, 'iME5NKAqDlpWzSZWI9auq0q8ZEq.jpg', '2019-07-02 13:21:23');

--
-- Triggers `nhan_vien`
--
DELIMITER $$
CREATE TRIGGER `AutoGeneratingNgayThem` BEFORE INSERT ON `nhan_vien` FOR EACH ROW BEGIN
	SET new.ngay_them = now();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `phan_hoi`
--

CREATE TABLE `phan_hoi` (
  `id` int(11) NOT NULL,
  `so_dien_thoai` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tieu_de` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `noi_dung` text COLLATE utf8_unicode_ci NOT NULL,
  `thoi_gian_phan_hoi` datetime NOT NULL,
  `da_xem` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `phan_hoi`
--
DELIMITER $$
CREATE TRIGGER `AutoGeneratedThoiGianPhanHoi` BEFORE INSERT ON `phan_hoi` FOR EACH ROW BEGIN
	SET new.thoi_gian_phan_hoi = now();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `san_pham`
--

CREATE TABLE `san_pham` (
  `id` int(11) NOT NULL,
  `ten_san_pham` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hinh_anh` text COLLATE utf8_unicode_ci,
  `mo_ta` text COLLATE utf8_unicode_ci,
  `id_danh_muc` int(11) NOT NULL,
  `ban_ra` bit(1) NOT NULL,
  `da_xoa` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `san_pham`
--

INSERT INTO `san_pham` (`id`, `ten_san_pham`, `hinh_anh`, `mo_ta`, `id_danh_muc`, `ban_ra`, `da_xoa`) VALUES
(2, 'Bó hoa tươi Phút Yêu Đầu 2', 'phut_yeu_dau.jpg', 'Với tone màu hồng nhẹ nhàng, nữ tính. Bó hoa là món quà tuyệt vời dành tặng cho những bạn nữ yêu thích sự lãng mạn và tràn đầy yêu thương. Thích hợp tặng dịp sinh nhật, làm quen, kỷ niệm...', 1, b'1', b'1'),
(3, 'Bình hoa tươi Nắng Yêu Thương', 'nang_yeu_thuong.jpg', 'Được thiết kế hài hòa giữa tông màu nhẹ của hoa cúc PingPong và hoa hồng vàng tạo ra những đường nét hài hòa, nhẹ nhàng. Là những cánh địa lan đầy nét tinh khiết hay hơi thở của các loài ngưng tự lại tạo nên sắc vàng của sự thành công, của màu nắng yêu thương hằng ngày sưởi ấm con tim mỗi người chúng ta. Thích hợp tặng cho người thân,bạn bè đồng nghiệp trong ngày khai trương, chúc mừng và những ngày hội họp...', 1, b'1', b'0'),
(4, 'Bó hoa tươi Memory Of Love', 'memory_of_love.png', 'Bó hoa của những dịu dàng, những ngây thơ và cả những hoài niệm về những phút giây đầu gặp gỡ. Ký ức về tình yêu đôi ta thật tự nhiên, đằm thắm mà vẫn để lại biết bao xúc cảm trong lòng của ta. Đó là những kỉ niệm đẹp, chỉ nghĩ cần đến thôi thì nụ cười hạnh phúc bất chợt nở trên mội.\r\nBó hoa tươi Memory Of Love gồm các loại hoa:\r\n- 15 hoa hồng tím\r\n- Cẩm chướng vàng \r\n- Hoa lá phụ khác\r\n- Giấy gói - nơ xuất xứ Hàn Quốc', 2, b'1', b'0'),
(6, 'Kệ chúc mừng Phồn Vinh', 'phon_vinh.jpg', 'Kệ hoa chúc mừng \"Phồn vinh\" như chính ý nghĩa của nó giàu có, thịnh vượng,là lời chúc cho sự phát triển tốt đẹp. Tone màu hồng của hoa ly và hoa đồng tiền chắc chắn sẽ là món quà tặng đặc biệt dành cho khai trương, kỷ niệm thành lập công ty, chúc mừng đối tác...', 3, b'1', b'0'),
(7, 'Bó hoa tươi Dịu Dàng', 'diu_dang.jpg', 'Với tone màu hồng pastel nhẹ nhàng và tràn đầy nữ tính như sự dịu dàng, đằm thắm của những cô thiếu nữ xinh xắn tuổi trăng tròn. Hoa hồng da kết hợp cùng cát tường hồng và baby trắng chắc chắn sẽ là điều bất ngờ và sang trọng dành tặng cho những cô gái đáng yêu.\r\nBó hoa tươi Dịu Dàng gồm các loại hoa:\r\n- 12 hoa hồng da\r\n- Cát tường hồng\r\n- Cát tường tím\r\n- Baby trắng\r\n- Hoa lá phụ khác\r\n- Giấy gói, nơ xuất xứ HQ', 1, b'1', b'0'),
(8, 'Bình hoa tươi Red Rose', 'red_rose.jpg', 'Bình hoa với hoa hồng đỏ là chủ đạo được bạn florist thiết kế đặc biệt dùng để tặng cho những fan cuồng hoa hồng đỏ. Loài hoa được yêu thích nhất trong các màu của hoa hồng. Bình hoa sẽ là món quà tuyệt vời dành tặng cho người thân yêu của bạn.\r\nBình hoa tươi Red Roses gồm các loại hoa:\r\n- 10 hoa hồng đỏ Rednaomi\r\n- Hoa hồng đỏ sasa\r\n- Baby trắng nhập\r\n- Chuỗi ngọc đỏ\r\n- Hoa lá phụ khác', 1, b'1', b'0'),
(13, 'Bó hoa tươi Hồn Nhiên', 'hon_nhien.jpg', 'Sự hồn nhiên của người con gái luôn luôn có sức thu hút đặc biệt đối với người đàn ông. Họ hồn nhiên vui vẻ bất chấp những khó khăn hay muộn phiền trong cuộc sống. Màu trắng tinh khôi của hoa hồng và baby sẽ là sự bất ngờ dành tặng cho cô gái hồn nhiên và vui vẻ của mình bạn nhé.', 2, b'1', b'0'),
(15, 'Giỏ hoa tươi Khởi Đầu Mới', 'khoi_dau_moi.jpg', 'Cuộc sống không ai lường trước được điều gì. Có khi thành công vang dội, có khi thất bại trong công việc. Nhưng bạn ơi, dù xảy ra chuyện gì thì ngày mới luôn đến. Ngày mới đến đó là thời điểm cho chúng ta bắt đầu lại sau những thất bại hay còn gọi là \"Khởi Đầu Mới\". Cùng chúc cho những dự định mới với giỏ hoa tone đỏ rực rỡ này bạn nhé.', 3, b'1', b'0'),
(17, 'Kệ chúc mừng Success Flowers', 'success_flower.jpg', 'Kệ hoa với tone màu vàng - màu của sự cao quý - như lời chúc thành công rực rỡ cho mọi sự khởi đầu mới. Hãy gửi lời chúc đến người yêu quý như tiếp sức cho những bước chân đầu tiên trong việc xây dựng sự nghiệp của riêng mình bạn nhé. Thích hợp tặng dịp khai trương, kỉ niệm thành lập công ty...', 3, b'1', b'0'),
(18, 'Giỏ hoa tươi Người Tôi Thương', 'nguoi_toi_thuong.jpg', 'Trong cuộc sống anh trải qua rất nhiều áp lực nhưng em có biết không, niềm vui anh có được chính là có em. Có nhiều niềm vui giản đơn là mỗi sớm mai có em trong vòng tay, được ngắm nhìn nụ cười của em cũng đủ xóa tan mệt mỏi trong anh và đó là \" Người Tôi Thương.', 2, b'1', b'0'),
(21, 'Bó hoa tươi Lời Tỏ Tình', 'loi_to_tinh.jpg', 'Sắc hồng ngọt ngào của hoa hồng da và sắc trắng tinh khôi của cẩm chướng trắng được kết hợp lại dễ dàng làm xao xuyến và thu hút ánh nhìn với bất kì ai. Bó hoa chính là lời nhắn \"Em đến dịu dàng như cơn mưa mùa hạ làm mát lạnh tâm hồn anh bằng một tình yêu bình dị và thủy chung. Cám ơn em - thiên thần của anh\".', 2, b'1', b'1'),
(22, 'Bó hoa tươi First Kiss', 'first_kiss.png', 'Bó hoa hồng sen đơn giản nhưng không kém phần sang trọng. Tựa như nụ hôn đầu thật ngại ngùng, e ấp nhưng ngập tràn tình yêu.', 2, b'1', b'0'),
(23, 'Bó hoa tươi Hồng Xinh 2', 'hong_xinh.jpg', 'Bó hồng xinh được thiết kế với tông hồng nhẹ, thích hợp tặng cho việc tặng các tình cảm nhẹ nhàng. Người nhận là nữ ở tuổi từ 18-24.', 2, b'1', b'0'),
(24, 'Bó hoa tươi Gold Love', 'gold_love.jpg', 'Sắc vàng rực rỡ của hoa hồng như một tình yêu dài lâu. Dù mai ra sau thì 2 ta vẫn sẽ luôn bên nhau. Một thứ tình yêu mộc mạc, bình dị không cần quá cầu kỳ nhưng vẫn luôn sắc son bền vững. Đừng vì những phút giận hờn, vì những cái tôi của bản thân mình mà đánh mất đi thứ hạnh phúc mà mình đang có bạn nhé.', 2, b'1', b'0'),
(25, 'Kệ chia buồn Người Xa Khuất', 'nguoi_xa_khuat.jpg', 'Cuộc sống nào ai biết trước được điều gì. Hôm qua còn đang nói chuyện vui cười, hôm nay đã mỗi người mỗi thế giới khác. Người đã xa khuất rồi bạn cũng đừng quá đau buồn hãy mạnh mẽ lên để họ được yên giấc ngàn thu.', 5, b'1', b'0'),
(26, 'Kệ chia buồn Dòng Thời Gian', 'dong_thoi_gian.jpg', 'Thời gian trôi qua. Ai rồi cũng phải rời xa cuộc đời này dù muốn hay không. Dòng thời gian cuốn trôi mọi thứ vì thế hãy đừng quá đau buồn khi người thân ra đi. Kệ hoa tone trắng sẽ là lời chia buồn sâu sắc gửi đến gia chủ. Mọi thứ rồi sẽ qua xin hãy vượt qua phút giây này', 5, b'1', b'0'),
(27, 'Kệ chia buồn Thiên Đàng', 'thien_dang.jpg', 'Đâu ai đang yên trông mong xa nhân gian nay mai. Nhưng khi đã qua hết những ngày để sống. Tiếc nuối cũng thế gửi người về với đất, Thôi xin cúi đầu tạm biệt người vừa đi\" lời bài hát cũng chính là cảm hứng cho các florist tạo ra kệ hoa chia buồn này. Với mong muốn người ra đi được thanh thản khi rời bỏ thế giới này', 5, b'1', b'0'),
(29, 'Bình hoa tươi In Your Eyes', '6050_shop-hoa-tuoi.jpg.png', 'Hoa hướng dương là loài hoa của sự hy vọng, của những khát khao và ước mơ vươn tới tương lai. Bình hoa với tone màu vàng như ánh bình minh rực rỡ soi sáng và dẫn bước cho con đường thành công của những người thân yêu của bạn. Tựa như ánh mắt của em như lần đầu anh bắt gặp\nBình hoa tươi In Your Eyes gồm các loại hoa:\n- 11 Hoa hướng dương\n- 20 Hoa hồng vàng\n- Cát tường xanh\n- Hoa phi yến (hoa theo mùa ) / hoa mõm sói\n- Hoa lá phụ khác\n* Chiều cao bình khoảng 130cm - 150cm', 1, b'0', b'1'),
(30, 'Bó hoa tươi Yêu Thương Hạnh Phúc', '3381_shop-hoa-tuoi.jpg', '\"Yêu Thương Hạnh Phúc\" kể một câu chuyện tình yêu ngọt ngào và lãng mạn. Bó hoa là sự kết hợp của hoa hồng tím và hoa hồng da đan xen và hòa quyện cùng với cúc calimero tựa như giai điệu của những đôi đang hạnh phúc khi bên nhau. Lúc sôi động khi thì trầm lắng nhẹ nhàng.', 2, b'1', b'1'),
(31, 'Bó hoa tươi Purple Love', NULL, 'Hoa hồng tím là một trong loài hoa khá đặc biệt và hiếm thấy do đó ý nghĩa của nó cũng rất đặc biệt. Là bó hoa tình yêu tuyệt vời để bạn thể hiện tình cảm của mình trong những dịp đặc biệt, sẽ là món quà độc đáo và sang trọng trong tình yêu khi bạn muốn thể hiện tình cảm đặc biệt của mình dành cho người mà bạn yêu mến. Màu tím là màu của sự quyến rũ của tình yêu say mê', 2, b'0', b'1'),
(32, 'Bó hoa tươi Những Nụ Hôn', NULL, 'Trong tình yêu, nụ hôn chưa bao giờ chỉ đơn thuần là một hành động, nó ý nghĩa và thiêng liêng hơn thế. Có nụ hôn của sự khởi đầu, cũng có những nụ hôn của sự kết thúc. Có nụ hôn của gặp gỡ, cũng có những nụ hôn của biệt ly. Những nụ hôn ta từng cảm nhận qua trong cuộc đời đều đáng trở thành những kỷ niệm khó quên.', 2, b'0', b'0'),
(33, 'Bó hoa tươi Believe Me', '6914_shop-hoa-tuoi.jpg.png', 'Trong tình cảm thì việc tin tưởng nhau chính là thước đo cho sự bền lâu của mối quan hệ đó. Trong cuộc sống, có những thứ mất đi có thể tìm lại được. Nhưng có một vài thứ mất đi là mất mãi mãi, đó là thời gian, là thanh xuân, là tuổi trẻ… nhưng có một thứ vô cùng quý giá giữa con người với con người đó là niềm tin. Niềm tin trong con người cũng chia thành hai, niềm tin trong tình yêu và niềm tin trong cuộc sống', 2, b'0', b'0'),
(34, 'Kiếp nhân sinh', '4693_kiep-nhan-sinh.jpg.png', 'Trong cuộc sống chúng ta mất bất cứ thứ gì chúng ta cũng có thể có lại được, nhưng khi chúng ta mất vĩnh viễn một người thân hay một người bạn chúng ta không bao giờ tìm lại được.', 5, b'0', b'0'),
(35, 'Giỏ hoa tươi Nụ Cười', '5276_dien-hoa.jpg', 'Giỏ hoa với hoa hồng da và hồng trứng gà cùng với cúc calimero trắng giỏ hoa như một cô nàng tươi trẻ, vui vẻ chào đón cuộc sống với niêm vui và nụ cười. Thích hợp tặng dịp sinh nhật, làm quen, tỏ tình, hay là điều bất ngờ cho người yêu. Giỏ hoa cắm 1 mặt', 2, b'0', b'1'),
(36, 'Giỏ hoa tươi Hè Rực Rỡ', '6928_shop-hoa-tuoi.jpg.png', 'Có lẽ bao mùa hè trôi qua đều đầy ắp những kỉ niệm mà con người cứ thích lưu giữ mãi đến độ hôm nay nắng về lại được dịp ra hong phơi. Một chút hương hoa thoang thoảng hay làn gió nhẹ khẽ đung đưa qua tay cũng đủ khiến cho trái tim này xuyến xao. Đôi chân cứ lơ đãng bước qua những góc phố, con đường quen thuộc mà ngỡ như là mới. Góc phố nơi anh và em gặp nhau lần đầu.', 2, b'0', b'1'),
(37, 'Giỏ hoa tươi Hạnh Phúc', '5205_shop-hoa-tuoi.jpg', 'Hạnh phúc là cái gì? Đó là cảm giác đến từ trái tim, chứ không phải nhận định của người khác. Hạnh phúc và bi ai thực sự, chỉ có bản thân mới hiểu, định nghĩa của hạnh phúc của mỗi người đâu có giống nhau. Hạnh phúc là hai người yên lặng bảo vệ, gom góp tất cả tình yêu gửi sâu vào đáy lòng, ngày qua ngày mang ra thưởng thức. Giỏ hoa này sẽ lan tỏa và nhân rộng hạnh phúc đến từng người, từng nhà, trong từng mối quan hệ tình cảm giữa con người với nhau.', 2, b'0', b'1');

--
-- Triggers `san_pham`
--
DELIMITER $$
CREATE TRIGGER `ChoPhepBanTrigger` BEFORE INSERT ON `san_pham` FOR EACH ROW BEGIN
	SET new.ban_ra = false;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trang_chu`
--

CREATE TABLE `trang_chu` (
  `id` int(11) NOT NULL,
  `ten_truong` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `noi_dung` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trang_chu`
--

INSERT INTO `trang_chu` (`id`, `ten_truong`, `noi_dung`) VALUES
(1, 'banner', '[{\"hinhAnh\":\"banner_1.png\"},{\"hinhAnh\":\"banner_2.jpg\"},{\"hinhAnh\":\"banner_3.png\"}]'),
(2, 'noiDung', '[{\"kiHieu\":\"truck\",\"tieuDe\":\"Miễn phí vận chuyển\"},{\"kiHieu\":\"tags\",\"tieuDe\":\"Giá đảm bảo\",\"noiDung\":\"Đảm bảo giá tốt nhất cho tất cả sản phẩm\"},{\"kiHieu\":\"phone-square\",\"tieuDe\":\"Hỗ trợ miễn phí\",\"noiDung\":\"Ngày thường: 8h ~ 18h <br/> Cuối tuần: 8h ~ 16h\"}]'),
(3, 'sanPham', '{\"sanPhamHot\":true,\"soLuongSanPham\":\"8\",\"danhSachIdSanPham\":[2,6,3,26,15,27,25,24]}'),
(4, 'nhungBanDo', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29784.636441564642!2d105.71619531938794!3d21.069484552469355!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313455aa15919acf%3A0xd83f79a5852943f6!2zVMOieSBU4buxdSwgQuG6r2MgVOG7qyBMacOqbSwgSMOgIE7hu5lpLCBWaeG7h3QgTmFt!5e0!3m2!1svi!2s!4v1555392453829!5m2!1svi!2s\" width=\"100%\" height=\"600px\" frameborder=\"0\" style=\"border:0\" allowfullscreen></iframe>'),
(5, 'chanTrang', '{\"benTrai\":{\"noiDung\":[\"Ngày thường: 9h ~ 21h\",\"Cuối tuần: 9h ~ 18h\"],\"tieuDe\":\"Giờ mở cửa\"},\"xaHoi\":[{\"kiHieu\":\"facebook\",\"duongDan\":\"#\"},{\"kiHieu\":\"twitter\",\"duongDan\":\"#\"},{\"kiHieu\":\"instagram\",\"duongDan\":\"#\"},{\"kiHieu\":\"google-plus\",\"duongDan\":\"#\"}],\"benPhai\":{\"noiDung\":[\"số XX ngõ XXX Tây Tựu, quận Bắc Từ Liêm\",\"zero4897hncool@gmail.com\",\"Số điện thoại: 0987124XXX\"],\"tieuDe\":\"Liên hệ\"}}');

-- --------------------------------------------------------

--
-- Table structure for table `tra_loi_danh_gia`
--

CREATE TABLE `tra_loi_danh_gia` (
  `id` int(11) NOT NULL,
  `id_danh_gia` int(11) NOT NULL,
  `id_nhan_vien` int(11) NOT NULL,
  `noi_dung` text COLLATE utf8_unicode_ci NOT NULL,
  `thoi_gian_tra_loi` datetime NOT NULL,
  `da_xoa` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tra_loi_danh_gia`
--

INSERT INTO `tra_loi_danh_gia` (`id`, `id_danh_gia`, `id_nhan_vien`, `noi_dung`, `thoi_gian_tra_loi`, `da_xoa`) VALUES
(2, 3, 1, 'Cảm ơn bạn', '2019-06-30 13:53:27', b'1'),
(3, 3, 1, 'Ahihi', '2019-06-30 13:53:36', b'1');

--
-- Triggers `tra_loi_danh_gia`
--
DELIMITER $$
CREATE TRIGGER `AutoGeneratedTraLoiDanhGia` BEFORE INSERT ON `tra_loi_danh_gia` FOR EACH ROW BEGIN
	SET new.thoi_gian_tra_loi = now();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tuong_tac`
--

CREATE TABLE `tuong_tac` (
  `id` int(11) NOT NULL,
  `truong_tuong_tac` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_tuong_tac` int(11) DEFAULT NULL,
  `ten_tuong_tac` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `noi_dung` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_nhan_vien` int(11) NOT NULL,
  `thoi_gian_tuong_tac` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tuong_tac`
--

INSERT INTO `tuong_tac` (`id`, `truong_tuong_tac`, `id_tuong_tac`, `ten_tuong_tac`, `noi_dung`, `id_nhan_vien`, `thoi_gian_tuong_tac`) VALUES
(1, 'nhan_vien', 2, 'Hashimoto Kanna', 'đã thêm người dùng', 1, '2019-07-01 16:44:38'),
(2, 'nhan_vien', 2, 'Hashimoto Kanna', 'đã xóa người dùng', 1, '2019-07-01 17:11:46'),
(3, 'nhan_vien', 1, 'Bùi Tuấn Đạt', 'đã cập nhật người dùng', 1, '2019-07-01 17:31:55'),
(4, NULL, NULL, NULL, 'đã đổi tên danh mục sản phẩm Hoa sinh nhật thành Hoa sinh nhật 1', 1, '2019-07-01 17:39:03'),
(5, NULL, NULL, NULL, 'đã đổi tên danh mục sản phẩm Hoa sinh nhật 1 thành Hoa sinh nhật', 1, '2019-07-01 17:40:42'),
(6, NULL, NULL, NULL, 'đã xóa danh mục a', 1, '2019-07-01 17:48:13'),
(7, 'san_pham', 2, 'Bó hoa tươi Phút Yêu Đầu 2', 'đã khôi phục sản phẩm ', 1, '2019-07-01 20:43:57'),
(8, 'san_pham', 2, 'Bó hoa tươi Phút Yêu Đầu 2', 'đã khôi phục sản phẩm ', 1, '2019-07-01 20:44:08'),
(9, 'san_pham', 2, 'Bó hoa tươi Phút Yêu Đầu 2', 'đã khôi phục sản phẩm ', 1, '2019-07-01 20:44:54'),
(10, 'san_pham', 3, 'Bình hoa tươi Nắng Yêu Thương', 'đã sửa sản phẩm ', 1, '2019-07-01 20:46:51'),
(11, 'san_pham', 2, 'Bó hoa tươi Phút Yêu Đầu 2', 'đã sửa sản phẩm ', 1, '2019-07-02 10:48:27'),
(12, 'san_pham', 6, 'Kệ chúc mừng Phồn Vinh', 'đã xóa sản phẩm ', 1, '2019-07-02 10:48:44'),
(13, 'san_pham', 6, 'Kệ chúc mừng Phồn Vinh', 'đã khôi phục sản phẩm ', 1, '2019-07-02 10:48:52'),
(14, 'san_pham', 6, 'Kệ chúc mừng Phồn Vinh', 'đã hủy bán sản phẩm ', 1, '2019-07-02 10:48:59'),
(15, 'san_pham', 6, 'Kệ chúc mừng Phồn Vinh', 'đã bán ra sản phẩm ', 1, '2019-07-02 10:49:06'),
(16, 'khuyen_mai', 7, 'gsdhsdh', 'đã cập nhật khuyến mãi ', 1, '2019-07-02 10:49:28'),
(17, 'khuyen_mai', 7, 'gsdhsdh', 'đã khôi phục khuyến mãi ', 1, '2019-07-02 10:49:38'),
(18, 'khuyen_mai', 7, 'gsdhsdh', 'đã khôi phục khuyến mãi ', 1, '2019-07-02 10:50:36'),
(19, 'khuyen_mai', 7, 'gsdhsdh', 'đã xóa khuyến mãi ', 1, '2019-07-02 10:50:42'),
(20, NULL, NULL, NULL, 'đã xác nhận và tiến hành giao hóa đơn DAAE0E53-9A7E-11E9-9', 1, '2019-07-02 10:51:07'),
(21, NULL, NULL, NULL, 'đã hủy hóa đơn DAAE0E53-9A7E-11E9-9', 1, '2019-07-02 10:51:21'),
(22, 'khuyen_mai', 7, 'gsdhsdh', 'đã khôi phục khuyến mãi ', 1, '2019-07-02 10:55:07'),
(23, NULL, NULL, NULL, 'đã cập nhật trang chủ ', 1, '2019-07-02 11:00:42'),
(24, NULL, NULL, NULL, 'đã cập nhật trang chủ ', 1, '2019-07-02 11:02:19'),
(25, NULL, NULL, NULL, 'đã cập nhật trang chủ ', 1, '2019-07-02 11:10:05'),
(26, NULL, NULL, NULL, 'đã cập nhật trang chủ ', 1, '2019-07-02 11:20:00'),
(27, NULL, NULL, NULL, 'đã cập nhật trang chủ ', 1, '2019-07-02 11:45:04'),
(28, NULL, NULL, NULL, 'đã cập nhật trang chủ ', 1, '2019-07-02 12:05:18'),
(29, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã thêm người dùng', 1, '2019-07-02 13:15:13'),
(30, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã đổi chức vụ người dùng', 1, '2019-07-02 13:16:30'),
(31, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã đổi chức vụ người dùng', 1, '2019-07-02 13:16:34'),
(32, 'nhan_vien', 4, 'Mimori Suzuko', 'đã thêm người dùng', 1, '2019-07-02 13:18:39'),
(33, 'nhan_vien', 5, 'Horikita Maki', 'đã thêm người dùng', 1, '2019-07-02 13:21:23'),
(34, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 1, '2019-07-02 13:41:05'),
(35, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 1, '2019-07-02 13:41:20'),
(36, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 1, '2019-07-02 13:42:35'),
(37, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 1, '2019-07-02 13:43:02'),
(38, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 1, '2019-07-02 13:44:24'),
(39, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 1, '2019-07-02 13:44:52'),
(40, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 3, '2019-07-02 13:47:17'),
(41, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã đổi chức vụ người dùng', 3, '2019-07-02 13:47:31'),
(42, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã đổi chức vụ người dùng', 3, '2019-07-02 13:47:36'),
(43, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 3, '2019-07-02 13:48:41'),
(44, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 3, '2019-07-02 13:48:49'),
(45, 'san_pham', 2, 'Bó hoa tươi Phút Yêu Đầu 2', 'đã xóa sản phẩm ', 3, '2019-07-02 13:49:30'),
(46, 'nhan_vien', 3, 'Hashimoto Kanna', 'đã cập nhật người dùng', 3, '2019-07-02 14:37:52'),
(47, NULL, NULL, NULL, 'đã xác nhận và tiến hành giao hóa đơn 8FC1A156-9956-11E9-9', 1, '2019-07-02 18:52:03'),
(48, NULL, NULL, NULL, 'đã xác nhận đã giao cho khách hóa đơn 8FC1A156-9956-11E9-9', 1, '2019-07-02 18:52:07'),
(49, 'nhan_vien', 1, 'Bùi Tuấn Đạt', 'đã cập nhật người dùng', 1, '2019-07-15 13:42:39'),
(50, NULL, NULL, NULL, 'đã xác nhận và tiến hành giao hóa đơn 93EAF3D4-A6CB-11E9-9', 1, '2019-07-15 13:43:32'),
(51, NULL, NULL, NULL, 'đã hủy hóa đơn 3D7E94B0-A375-11E9-9', 1, '2019-07-15 13:43:54');

--
-- Triggers `tuong_tac`
--
DELIMITER $$
CREATE TRIGGER `AutoGeneratedTuongTac` BEFORE INSERT ON `tuong_tac` FOR EACH ROW BEGIN
	SET new.thoi_gian_tuong_tac = now();
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chi_tiet_khuyen_mai`
--
ALTER TABLE `chi_tiet_khuyen_mai`
  ADD PRIMARY KEY (`id_khuyen_mai`,`id_kieu_san_pham`),
  ADD KEY `FK_KieuSanPham_ChiTietKhuyenMai` (`id_kieu_san_pham`);

--
-- Indexes for table `chuc_vu`
--
ALTER TABLE `chuc_vu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dang_nhap`
--
ALTER TABLE `dang_nhap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_NhanVien_DangNhap` (`id_nhan_vien`);

--
-- Indexes for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_NhanVien_DanhGia` (`id_nhan_vien`),
  ADD KEY `FK_SanPham_DanhGia` (`id_san_pham`);

--
-- Indexes for table `danh_muc`
--
ALTER TABLE `danh_muc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_KieuSanPham_DonHang` (`id_kieu_san_pham`),
  ADD KEY `FK_HoaDon_DonHang` (`id_hoa_don`);

--
-- Indexes for table `hoa_don`
--
ALTER TABLE `hoa_don`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_hoa_don` (`ma_hoa_don`),
  ADD KEY `FK_NhanVien_HoaDon` (`id_nhan_vien`);

--
-- Indexes for table `khuyen_mai`
--
ALTER TABLE `khuyen_mai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kieu_san_pham`
--
ALTER TABLE `kieu_san_pham`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_SanPham_KieuSanPham` (`id_san_pham`);

--
-- Indexes for table `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ChucVu_NhanVien` (`id_chuc_vu`);

--
-- Indexes for table `phan_hoi`
--
ALTER TABLE `phan_hoi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_DanhMuc_SanPham` (`id_danh_muc`);

--
-- Indexes for table `trang_chu`
--
ALTER TABLE `trang_chu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tra_loi_danh_gia`
--
ALTER TABLE `tra_loi_danh_gia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_DanhGia_TraLoiDanhGia` (`id_danh_gia`),
  ADD KEY `FK_NhanVien_TraLoiDanhGia` (`id_nhan_vien`);

--
-- Indexes for table `tuong_tac`
--
ALTER TABLE `tuong_tac`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_NhanVien_TuongTac` (`id_nhan_vien`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chuc_vu`
--
ALTER TABLE `chuc_vu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dang_nhap`
--
ALTER TABLE `dang_nhap`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `danh_muc`
--
ALTER TABLE `danh_muc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `hoa_don`
--
ALTER TABLE `hoa_don`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `khuyen_mai`
--
ALTER TABLE `khuyen_mai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `kieu_san_pham`
--
ALTER TABLE `kieu_san_pham`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `nhan_vien`
--
ALTER TABLE `nhan_vien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `phan_hoi`
--
ALTER TABLE `phan_hoi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `trang_chu`
--
ALTER TABLE `trang_chu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tra_loi_danh_gia`
--
ALTER TABLE `tra_loi_danh_gia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tuong_tac`
--
ALTER TABLE `tuong_tac`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chi_tiet_khuyen_mai`
--
ALTER TABLE `chi_tiet_khuyen_mai`
  ADD CONSTRAINT `FK_KhuyenMai_ChiTietKhuyenMai` FOREIGN KEY (`id_khuyen_mai`) REFERENCES `khuyen_mai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_KieuSanPham_ChiTietKhuyenMai` FOREIGN KEY (`id_kieu_san_pham`) REFERENCES `kieu_san_pham` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dang_nhap`
--
ALTER TABLE `dang_nhap`
  ADD CONSTRAINT `FK_NhanVien_DangNhap` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhan_vien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD CONSTRAINT `FK_NhanVien_DanhGia` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhan_vien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SanPham_DanhGia` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `FK_HoaDon_DonHang` FOREIGN KEY (`id_hoa_don`) REFERENCES `hoa_don` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_KieuSanPham_DonHang` FOREIGN KEY (`id_kieu_san_pham`) REFERENCES `kieu_san_pham` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hoa_don`
--
ALTER TABLE `hoa_don`
  ADD CONSTRAINT `FK_NhanVien_HoaDon` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhan_vien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kieu_san_pham`
--
ALTER TABLE `kieu_san_pham`
  ADD CONSTRAINT `FK_SanPham_KieuSanPham` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD CONSTRAINT `FK_ChucVu_NhanVien` FOREIGN KEY (`id_chuc_vu`) REFERENCES `chuc_vu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD CONSTRAINT `FK_DanhMuc_SanPham` FOREIGN KEY (`id_danh_muc`) REFERENCES `danh_muc` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tra_loi_danh_gia`
--
ALTER TABLE `tra_loi_danh_gia`
  ADD CONSTRAINT `FK_DanhGia_TraLoiDanhGia` FOREIGN KEY (`id_danh_gia`) REFERENCES `danh_gia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_NhanVien_TraLoiDanhGia` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhan_vien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tuong_tac`
--
ALTER TABLE `tuong_tac`
  ADD CONSTRAINT `FK_NhanVien_TuongTac` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhan_vien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
