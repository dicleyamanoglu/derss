-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 13 Mar 2019, 07:44:35
-- Sunucu sürümü: 5.7.14
-- PHP Sürümü: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `13mart2019`
--

DELIMITER $$
--
-- Yordamlar
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `h4-s1` (IN `yer` INT(11), IN `sehir_adi` VARCHAR(255))  NO SQL
INSERT INTO `dogum_sehir`(`dogum_yer_id`, `sehir`) VALUES (yer,sehir_adi)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `h4-s10` (IN `rakam` INT)  NO SQL
DELETE FROM `kitaplar` WHERE kitaplar.kitap_yas>rakam$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `h4-s2` (IN `deneme` VARCHAR(255))  NO SQL
SELECT yazarlar.adi,yazarlar.soyadi,dogum_sehir.sehir,kitaplar.tarih,kitaplar.ad
FROM yazarlar,dogum_sehir,kitaplar,kitap_yazar
WHERE yazarlar.yazar_id=kitap_yazar.yazar_id and kitaplar.kitap_id=kitap_yazar.kitap_id and yazarlar.dogum_yer_id=dogum_sehir.dogum_yer_id AND dogum_sehir.sehir=deneme
ORDER BY kitaplar.tarih DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `h4-s3` (IN `turr` VARCHAR(255))  NO SQL
SELECT kitaplar.ad as kitap_ad,yayinevleri.adi as yayinevi_adi
FROM kitaplar,yayinevleri,turler,kitap_tur
WHERE kitaplar.yayinevi_id=yayinevleri.yayinevi_id
AND kitap_tur.kitap_id=kitaplar.kitap_id
AND kitap_tur.tur_id=turler.tur_id
AND turler.ad like concat("%",turr,"%")$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `h4-s4` (IN `turr` VARCHAR(255))  NO SQL
select yazarlar.adi as yazar_ad, yazarlar.soyadi as yazarlar_soyad , dogum_sehir.sehir , kitaplar.ad as kitap_ad
from yazarlar,dogum_sehir,kitaplar,kitap_yazar,turler ,kitap_tur
where yazarlar.dogum_yer_id=dogum_sehir.dogum_yer_id AND
yazarlar.yazar_id=kitap_yazar.yazar_id AND
kitap_yazar.kitap_id = kitaplar.kitap_id AND
kitaplar.kitap_id=kitap_tur.kitap_id AND
kitap_tur.tur_id=turler.tur_id AND
turler.ad=turr$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `h4-s5` (IN `harf` VARCHAR(255))  NO SQL
SELECT *
FROM yazarlar
WHERE yazarlar.adi like concat("%",harf,"%")$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `h4-s6` (IN `harf1` VARCHAR(255), IN `harf2` VARCHAR(255))  NO SQL
SELECT *
FROM yazarlar
WHERE yazarlar.adi LIKE concat("%",harf1,"%","%",harf2,"%")$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `h4-s7` (IN `rakam` INT(11))  NO SQL
SELECT yazarlar.adi,yazarlar.soyadi, COUNT(kitaplar.kitap_id)as sayi
FROM yazarlar,kitaplar,kitap_yazar
WHERE yazarlar.yazar_id=kitap_yazar.yazar_id AND kitap_yazar.kitap_id=kitaplar.kitap_id
GROUP BY yazarlar.adi,yazarlar.soyadi
HAVING sayi>=rakam$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `h4-s9` ()  NO SQL
UPDATE `kitaplar` 
SET kitap_yas=year(curdate())-`tarih`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru1` ()  NO SQL
SELECT yazarlar.adi,yazarlar.soyadi,dogum_sehir.sehir,kitaplar.tarih,kitaplar.ad
FROM yazarlar,dogum_sehir,kitaplar,kitap_yazar

WHERE yazarlar.yazar_id=kitap_yazar.yazar_id and kitaplar.kitap_id=kitap_yazar.kitap_id and yazarlar.dogum_yer_id=dogum_sehir.dogum_yer_id AND dogum_sehir.sehir="İzmir"
ORDER BY kitaplar.tarih DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru10` ()  NO SQL
SELECT yazarlar.adi, COUNT(kitaplar.kitap_id)
FROM yazarlar, kitaplar, kitap_yazar
WHERE yazarlar.yazar_id=kitap_yazar.yazar_id
AND kitap_yazar.kitap_id=kitaplar.kitap_id
GROUP BY yazarlar.yazar_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru11` ()  NO SQL
SELECT yazarlar.adi,yazarlar.soyadi, COUNT(kitaplar.kitap_id)as sayi
FROM yazarlar,kitaplar,kitap_yazar
WHERE yazarlar.yazar_id=kitap_yazar.yazar_id AND kitap_yazar.kitap_id=kitaplar.kitap_id
GROUP BY yazarlar.adi,yazarlar.soyadi
HAVING sayi>3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru12` ()  NO SQL
SELECT turler.ad,max(kitaplar.satis_miktari)
FROM kitaplar,turler,kitap_tur
WHERE kitaplar.kitap_id=kitap_tur.kitap_id AND
turler.tur_id=kitap_tur.tur_id
GROUP BY turler.tur_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru13` ()  NO SQL
SELECT turler.ad,SUM(kitaplar.satis_miktari)
FROM turler,kitap_tur,kitaplar
WHERE kitaplar.kitap_id=kitap_tur.kitap_id
AND kitap_tur.tur_id=turler.tur_id
GROUP BY turler.ad
ORDER BY SUM(kitaplar.satis_miktari) DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru14` ()  NO SQL
SELECT turler.ad as turler_ad,kitaplar.ad as kitap_ad,kitaplar.satis_miktari
FROM turler,kitaplar,kitap_tur
WHERE kitaplar.satis_miktari=
(SELECT max(kitaplar.satis_miktari)
FROM kitaplar)AND kitaplar.kitap_id=kitap_tur.kitap_id
AND
kitap_tur.tur_id=turler.tur_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru15` ()  NO SQL
SELECT yazarlar.adi,yazarlar.soyadi, COUNT(*)
FROM turler,kitap_tur,kitaplar,kitap_yazar,yazarlar
WHERE turler.ad LIKE "Bilgisayar%"
AND
turler.tur_id=kitap_tur.tur_id 
AND
kitap_tur.kitap_id=kitaplar.kitap_id
AND
kitaplar.kitap_id=kitap_yazar.kitap_id
AND
yazarlar.yazar_id=kitap_yazar.yazar_id
GROUP BY yazarlar.adi,yazarlar.soyadi$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru16` ()  NO SQL
SELECT yayinevleri.adi,sum(kitaplar.satis_miktari)
from yayinevleri,kitaplar
where yayinevleri.yayinevi_id=kitaplar.yayinevi_id
GROUP by yayinevleri.yayinevi_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru17` ()  NO SQL
SELECT dogum_sehir.sehir, COUNT(dogum_sehir.dogum_yer_id)
FROM yazarlar,dogum_sehir
WHERE yazarlar.dogum_yer_id=dogum_sehir.dogum_yer_id
GROUP BY dogum_sehir.dogum_yer_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru2` ()  NO SQL
SELECT kitaplar.ad,yayinevleri.adi FROM turler,kitap_tur,kitaplar,yayinevleri WHERE turler.tur_id=kitap_tur.tur_id AND kitap_tur.kitap_id=kitaplar.kitap_id AND kitaplar.yayinevi_id=yayinevleri.yayinevi_id AND turler.ad LIKE "Bilgisayar%"$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru3` ()  NO SQL
SELECT yazarlar.adi,yazarlar.soyadi,yazarlar.dogum_yer_id,kitaplar.ad,dogum_sehir.sehir FROM yazarlar,kitaplar,kitap_yazar,dogum_sehir,turler,kitap_tur WHERE kitaplar.kitap_id=kitap_yazar.kitap_id AND kitap_yazar.yazar_id=yazarlar.yazar_id AND yazarlar.dogum_yer_id=dogum_sehir.dogum_yer_id AND kitaplar.kitap_id=kitap_tur.kitap_id AND kitap_tur.tur_id=turler.tur_id AND turler.ad='Felsefe'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru4` ()  NO SQL
SELECT*
FROM turler,kitap_tur,kitap_yazar,yazarlar,kitaplar
WHERE turler.tur_id=kitap_tur.kitap_id 
AND
kitap_tur.kitap_id=kitaplar.kitap_id
AND
kitaplar.kitap_id=kitap_yazar.kitap_id
AND
yazarlar.yazar_id=kitap_yazar.kitap_id
AND
turler.ad IN('Müzik','Şiir')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru5` ()  NO SQL
SELECT*
FROM turler,kitap_tur,kitap_yazar,yazarlar,kitaplar
WHERE turler.tur_id=kitap_tur.tur_id 
AND
kitap_tur.kitap_id=kitaplar.kitap_id
AND
kitaplar.kitap_id=kitap_yazar.kitap_id
AND
yazarlar.yazar_id=kitap_yazar.yazar_id
AND
turler.ad not IN ('Felsefe')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru6` ()  NO SQL
SELECT turler.ad,kitaplar.ad,kitaplar.satis_miktari
FROM kitap_tur,kitaplar,turler
WHERE kitap_tur.tur_id=turler.tur_id AND kitaplar.kitap_id=kitap_tur.kitap_id AND turler.ad="Reklamcılık"$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru7` ()  NO SQL
SELECT kitaplar.ad,turler.ad,kitaplar.satis_miktari
FROM kitaplar,turler,kitap_tur
WHERE kitaplar.kitap_id=kitap_tur.kitap_id
AND
kitap_tur.tur_id=turler.tur_id
and
kitaplar.satis_miktari<any(
SELECT kitaplar.satis_miktari
FROM kitaplar,kitap_tur,turler
WHERE turler.ad="Reklamcılık"
AND
kitaplar.kitap_id=kitap_tur.kitap_id
AND
kitap_tur.tur_id=turler.tur_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru8` ()  NO SQL
SELECT kitaplar.ad,turler.ad,kitaplar.satis_miktari
FROM kitaplar,turler,kitap_tur
WHERE kitaplar.kitap_id=kitap_tur.kitap_id
AND
kitap_tur.tur_id=turler.tur_id
and
kitaplar.satis_miktari<all(
SELECT kitaplar.satis_miktari
FROM kitaplar,kitap_tur,turler
WHERE turler.ad="Reklamcılık"
AND
kitaplar.kitap_id=kitap_tur.kitap_id
AND
kitap_tur.tur_id=turler.tur_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soru9` ()  NO SQL
SELECT yazarlar.adi
FROM yazarlar
WHERE yazarlar.adi LIKE "%t%"$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dogum_sehir`
--

CREATE TABLE `dogum_sehir` (
  `dogum_yer_id` int(11) NOT NULL,
  `sehir` varchar(255) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `dogum_sehir`
--

INSERT INTO `dogum_sehir` (`dogum_yer_id`, `sehir`) VALUES
(1, 'Adana'),
(6, 'Ankara'),
(10, 'Balıkesir'),
(14, 'Bolu'),
(17, 'Çanakkale'),
(20, 'Denizli'),
(35, 'İzmir'),
(38, 'Kayseri'),
(42, 'Konya');

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `kitapci`
-- (Asıl görünüm için aşağıya bakın)
--
CREATE TABLE `kitapci` (
`tur_ad` varchar(255)
,`kitap_ad` varchar(255)
,`tarih` year(4)
,`satis_miktari` int(11)
,`fiyati` int(11)
,`adi` varchar(255)
,`yazar_ad` varchar(255)
,`yazar_soyad` varchar(255)
,`sehir` varchar(255)
);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitaplar`
--

CREATE TABLE `kitaplar` (
  `kitap_id` int(11) NOT NULL,
  `ad` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `tarih` year(4) NOT NULL,
  `kitap_yas` int(11) NOT NULL,
  `yayinevi_id` int(11) NOT NULL,
  `satis_miktari` int(11) NOT NULL,
  `fiyati` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitaplar`
--

INSERT INTO `kitaplar` (`kitap_id`, `ad`, `tarih`, `kitap_yas`, `yayinevi_id`, `satis_miktari`, `fiyati`) VALUES
(1, 'Ekonomi', 2010, 9, 1, 100, 50),
(2, 'Veritabanı', 2012, 7, 2, 2000, 45),
(3, 'Borsa', 2017, 2, 3, 1000, 100),
(4, 'Borsa\'da Başarı', 2012, 7, 4, 1500, 20),
(5, 'Şiirler', 2008, 11, 6, 100, 10),
(8, 'Bilim Felsefesi', 2005, 14, 7, 400, 100),
(10, 'Kariyer', 2010, 9, 5, 5000, 50),
(11, 'İş Dünyası', 2015, 4, 8, 300, 30),
(12, 'Reklamcılık', 2008, 11, 8, 500, 60),
(13, 'Sistem Analizi', 2017, 2, 5, 100, 1000),
(14, 'Yapay Zeka', 2013, 6, 5, 600, 50),
(15, 'Tarihe Bakış', 2009, 10, 5, 300, 40);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitap_tur`
--

CREATE TABLE `kitap_tur` (
  `kitap_id` int(11) NOT NULL,
  `tur_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitap_tur`
--

INSERT INTO `kitap_tur` (`kitap_id`, `tur_id`) VALUES
(1, 4),
(2, 9),
(3, 1),
(4, 1),
(5, 5),
(8, 7),
(10, 3),
(10, 1),
(10, 4),
(10, 3),
(11, 1),
(11, 2),
(11, 3),
(11, 4),
(12, 2),
(12, 3),
(13, 3),
(13, 9),
(14, 9),
(14, 3);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitap_yazar`
--

CREATE TABLE `kitap_yazar` (
  `yazar_id` int(11) NOT NULL,
  `kitap_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitap_yazar`
--

INSERT INTO `kitap_yazar` (`yazar_id`, `kitap_id`) VALUES
(1, 1),
(2, 1),
(2, 5),
(4, 12),
(5, 13),
(8, 15),
(9, 8),
(10, 15),
(11, 15),
(12, 2),
(13, 14),
(14, 5),
(16, 4),
(16, 10),
(17, 15),
(7, 5),
(14, 4),
(16, 1),
(3, 1),
(13, 2),
(17, 15),
(3, 11),
(11, 8);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `turler`
--

CREATE TABLE `turler` (
  `tur_id` int(11) NOT NULL,
  `ad` varchar(255) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `turler`
--

INSERT INTO `turler` (`tur_id`, `ad`) VALUES
(1, 'Borsa-Finans-Analiz'),
(2, 'Reklamcılık'),
(3, 'İş Dünyası - Kariyer'),
(4, 'Dünya Ekonomisi'),
(5, 'Şiir'),
(6, 'Tarih'),
(7, 'Felsefe'),
(8, 'Müzik'),
(9, 'Bilgisayar Kitapları ');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yayinevleri`
--

CREATE TABLE `yayinevleri` (
  `yayinevi_id` int(11) NOT NULL,
  `adi` varchar(255) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yayinevleri`
--

INSERT INTO `yayinevleri` (`yayinevi_id`, `adi`) VALUES
(1, 'Abaküs Yayınevi'),
(2, 'Alfa Yayıncılık '),
(3, 'İnkilap Yayınevi'),
(4, 'Alter Yayınevi'),
(5, 'Belge Yayınları'),
(6, 'Beta Yayınları'),
(7, 'Bilgi Yayınevi'),
(8, 'Donanım Yayınevi'),
(9, 'Yazılım Yayınevi');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yazarlar`
--

CREATE TABLE `yazarlar` (
  `yazar_id` int(11) NOT NULL,
  `adi` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `soyadi` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `dogum_yer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yazarlar`
--

INSERT INTO `yazarlar` (`yazar_id`, `adi`, `soyadi`, `dogum_yer_id`) VALUES
(1, 'Mehmet', 'Yılmaz', 1),
(2, 'Kenan', 'Öztürk', 6),
(3, 'Orhan', 'Duru', 10),
(4, 'Ayşe', 'Gül', 20),
(5, 'Buse', 'Nur', 17),
(6, 'Mehmet', 'Erdem', 35),
(7, 'Funda', 'Yıkılmaz', 38),
(8, 'Özlem', 'Çetin', 42),
(9, 'Ece', 'Demir', 20),
(10, 'Aygül', 'Birgül', 35),
(11, 'Canan', 'Can', 6),
(12, 'Öztürk', 'Yıkılmaz', 10),
(13, 'Fatma', 'Yazar', 38),
(14, 'Simge', 'Okur', 14),
(15, 'Derya', 'Deniz', 38),
(16, 'Okan', 'Okur', 35),
(17, 'Ahmet', 'Terim', 6);

-- --------------------------------------------------------

--
-- Görünüm yapısı `kitapci`
--
DROP TABLE IF EXISTS `kitapci`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `kitapci`  AS  select `turler`.`ad` AS `tur_ad`,`kitaplar`.`ad` AS `kitap_ad`,`kitaplar`.`tarih` AS `tarih`,`kitaplar`.`satis_miktari` AS `satis_miktari`,`kitaplar`.`fiyati` AS `fiyati`,`yayinevleri`.`adi` AS `adi`,`yazarlar`.`adi` AS `yazar_ad`,`yazarlar`.`soyadi` AS `yazar_soyad`,`dogum_sehir`.`sehir` AS `sehir` from ((((((`kitaplar` join `turler`) join `yayinevleri`) join `yazarlar`) join `dogum_sehir`) join `kitap_tur`) join `kitap_yazar`) where ((`turler`.`tur_id` = `kitap_tur`.`tur_id`) and (`kitap_tur`.`kitap_id` = `kitaplar`.`kitap_id`) and (`kitaplar`.`yayinevi_id` = `yayinevleri`.`yayinevi_id`) and (`yazarlar`.`yazar_id` = `kitap_yazar`.`yazar_id`) and (`kitap_yazar`.`kitap_id` = `kitaplar`.`kitap_id`) and (`dogum_sehir`.`dogum_yer_id` = `yazarlar`.`dogum_yer_id`)) ;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `dogum_sehir`
--
ALTER TABLE `dogum_sehir`
  ADD PRIMARY KEY (`dogum_yer_id`);

--
-- Tablo için indeksler `kitaplar`
--
ALTER TABLE `kitaplar`
  ADD PRIMARY KEY (`kitap_id`),
  ADD KEY `yayinevi_id` (`yayinevi_id`);

--
-- Tablo için indeksler `kitap_tur`
--
ALTER TABLE `kitap_tur`
  ADD KEY `kitap_id` (`kitap_id`),
  ADD KEY `tur_id` (`tur_id`);

--
-- Tablo için indeksler `kitap_yazar`
--
ALTER TABLE `kitap_yazar`
  ADD KEY `yazar_id` (`yazar_id`),
  ADD KEY `kitap_id` (`kitap_id`);

--
-- Tablo için indeksler `turler`
--
ALTER TABLE `turler`
  ADD PRIMARY KEY (`tur_id`);

--
-- Tablo için indeksler `yayinevleri`
--
ALTER TABLE `yayinevleri`
  ADD PRIMARY KEY (`yayinevi_id`);

--
-- Tablo için indeksler `yazarlar`
--
ALTER TABLE `yazarlar`
  ADD PRIMARY KEY (`yazar_id`),
  ADD KEY `dogum_yer_id` (`dogum_yer_id`);

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `kitaplar`
--
ALTER TABLE `kitaplar`
  ADD CONSTRAINT `yayinevi` FOREIGN KEY (`yayinevi_id`) REFERENCES `yayinevleri` (`yayinevi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitap_tur`
--
ALTER TABLE `kitap_tur`
  ADD CONSTRAINT `kitaplar` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `turler` FOREIGN KEY (`tur_id`) REFERENCES `turler` (`tur_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitap_yazar`
--
ALTER TABLE `kitap_yazar`
  ADD CONSTRAINT `kitap2` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `yazar2` FOREIGN KEY (`yazar_id`) REFERENCES `yazarlar` (`yazar_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `yazarlar`
--
ALTER TABLE `yazarlar`
  ADD CONSTRAINT `dogum_yeri` FOREIGN KEY (`dogum_yer_id`) REFERENCES `dogum_sehir` (`dogum_yer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
