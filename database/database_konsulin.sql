-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for konsulin
CREATE DATABASE IF NOT EXISTS `konsulin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `konsulin`;

-- Dumping structure for table konsulin.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `id_user` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id_user`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table konsulin.aktivitas_sistem
CREATE TABLE IF NOT EXISTS `aktivitas_sistem` (
  `id_aktivitas` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned DEFAULT NULL,
  `aktivitas` varchar(200) NOT NULL,
  `detail` text DEFAULT NULL,
  `waktu_aktivitas` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_aktivitas`),
  KEY `idx_aktivitas_waktu` (`waktu_aktivitas`),
  KEY `idx_aktivitas_user` (`id_user`),
  CONSTRAINT `fk_aktivitas_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table konsulin.dosen
CREATE TABLE IF NOT EXISTS `dosen` (
  `id_user` bigint(20) unsigned NOT NULL,
  `nip` varchar(30) NOT NULL,
  `bidang_keahlian` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `nip` (`nip`),
  CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table konsulin.jadwal
CREATE TABLE IF NOT EXISTS `jadwal` (
  `id_jadwal` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_dosen` bigint(20) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `lokasi` varchar(150) NOT NULL,
  `status_jadwal` enum('tersedia','terisi','nonaktif') NOT NULL DEFAULT 'tersedia',
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_jadwal`),
  KEY `idx_jadwal_dosen_tanggal` (`id_dosen`,`tanggal`),
  CONSTRAINT `fk_jadwal_dosen` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_user`) ON UPDATE CASCADE,
  CONSTRAINT `chk_jam_jadwal` CHECK (`jam_selesai` > `jam_mulai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table konsulin.mahasiswa
CREATE TABLE IF NOT EXISTS `mahasiswa` (
  `id_user` bigint(20) unsigned NOT NULL,
  `nim` varchar(30) NOT NULL,
  `angkatan` year(4) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `nim` (`nim`),
  CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table konsulin.notifikasi
CREATE TABLE IF NOT EXISTS `notifikasi` (
  `id_notifikasi` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user_penerima` bigint(20) unsigned NOT NULL,
  `id_pengajuan` bigint(20) unsigned DEFAULT NULL,
  `pesan` text NOT NULL,
  `waktu_kirim` datetime NOT NULL DEFAULT current_timestamp(),
  `status_dibaca` enum('belum_dibaca','sudah_dibaca') NOT NULL DEFAULT 'belum_dibaca',
  PRIMARY KEY (`id_notifikasi`),
  KEY `fk_notifikasi_pengajuan` (`id_pengajuan`),
  KEY `idx_notifikasi_penerima` (`id_user_penerima`,`status_dibaca`),
  CONSTRAINT `fk_notifikasi_pengajuan` FOREIGN KEY (`id_pengajuan`) REFERENCES `pengajuan_konsultasi` (`id_pengajuan`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_notifikasi_user` FOREIGN KEY (`id_user_penerima`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table konsulin.pengajuan_konsultasi
CREATE TABLE IF NOT EXISTS `pengajuan_konsultasi` (
  `id_pengajuan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_mahasiswa` bigint(20) unsigned NOT NULL,
  `id_jadwal` bigint(20) unsigned NOT NULL,
  `topik` varchar(200) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `tanggal_pengajuan` datetime NOT NULL DEFAULT current_timestamp(),
  `status_pengajuan` enum('menunggu','diterima','ditolak','menunggu_konfirmasi_alternatif','selesai','dibatalkan') NOT NULL DEFAULT 'menunggu',
  `jadwal_alternatif` datetime DEFAULT NULL,
  `catatan_dosen` text DEFAULT NULL,
  `diperbarui_pada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_pengajuan`),
  KEY `fk_pengajuan_jadwal` (`id_jadwal`),
  KEY `idx_pengajuan_mahasiswa` (`id_mahasiswa`),
  KEY `idx_pengajuan_status` (`status_pengajuan`),
  CONSTRAINT `fk_pengajuan_jadwal` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal` (`id_jadwal`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pengajuan_mahasiswa` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_user`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table konsulin.riwayat_konsultasi
CREATE TABLE IF NOT EXISTS `riwayat_konsultasi` (
  `id_riwayat` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_pengajuan` bigint(20) unsigned NOT NULL,
  `tanggal_konsultasi` datetime NOT NULL,
  `topik` varchar(200) NOT NULL,
  `catatan` text DEFAULT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_riwayat`),
  UNIQUE KEY `id_pengajuan` (`id_pengajuan`),
  CONSTRAINT `fk_riwayat_pengajuan` FOREIGN KEY (`id_pengajuan`) REFERENCES `pengajuan_konsultasi` (`id_pengajuan`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table konsulin.users
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('mahasiswa','dosen','admin') NOT NULL,
  `status_akun` enum('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp(),
  `diperbarui_pada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
