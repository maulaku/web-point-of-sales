-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.8 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2012-12-14 16:37:57
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for putridb
DROP DATABASE IF EXISTS `putridb`;
CREATE DATABASE IF NOT EXISTS `putridb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `putridb`;


-- Dumping structure for table putridb.bayar_transaksi
DROP TABLE IF EXISTS `bayar_transaksi`;
CREATE TABLE IF NOT EXISTS `bayar_transaksi` (
  `no_transaksi` varchar(50) NOT NULL DEFAULT '',
  `total_belanja` double DEFAULT '0',
  `ppn` double DEFAULT '0',
  `total_bayar` double DEFAULT '0',
  `dibayar` double DEFAULT '0',
  `kembalian` double DEFAULT '0',
  `created_by` varchar(125) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `terbilang` text,
  PRIMARY KEY (`no_transaksi`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table data pembayaran pejualan';

-- Dumping data for table putridb.bayar_transaksi: 0 rows
/*!40000 ALTER TABLE `bayar_transaksi` DISABLE KEYS */;
/*!40000 ALTER TABLE `bayar_transaksi` ENABLE KEYS */;


-- Dumping structure for table putridb.buku_besar
DROP TABLE IF EXISTS `buku_besar`;
CREATE TABLE IF NOT EXISTS `buku_besar` (
  `ID` int(11) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `NoJurnal` varchar(10) DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Saldo` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.buku_besar: 0 rows
/*!40000 ALTER TABLE `buku_besar` DISABLE KEYS */;
/*!40000 ALTER TABLE `buku_besar` ENABLE KEYS */;


-- Dumping structure for table putridb.detail_transaksi
DROP TABLE IF EXISTS `detail_transaksi`;
CREATE TABLE IF NOT EXISTS `detail_transaksi` (
  `id_transaksi` int(11) NOT NULL AUTO_INCREMENT,
  `no_transaksi` varchar(50) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `faktur_transaksi` varchar(100) DEFAULT NULL,
  `jenis_transaksi` varchar(50) DEFAULT NULL,
  `akun_transaksi` varchar(100) DEFAULT NULL,
  `cara_bayar` varchar(50) DEFAULT NULL,
  `nm_produsen` varchar(225) DEFAULT NULL,
  `nm_barang` varchar(225) DEFAULT NULL,
  `nm_satuan` varchar(225) DEFAULT NULL,
  `jml_transaksi` double(10,2) DEFAULT '0.00',
  `expired` date DEFAULT NULL,
  `harga_beli` double DEFAULT '0',
  `ket_transaksi` text,
  `created_by` varchar(50) DEFAULT NULL,
  `doc_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_transaksi`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table transaksi keluar masuk obat';

-- Dumping data for table putridb.detail_transaksi: 0 rows
/*!40000 ALTER TABLE `detail_transaksi` DISABLE KEYS */;
/*!40000 ALTER TABLE `detail_transaksi` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_barang
DROP TABLE IF EXISTS `inv_barang`;
CREATE TABLE IF NOT EXISTS `inv_barang` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Kode` varchar(15) DEFAULT NULL,
  `ID_Kategori` int(11) DEFAULT NULL,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `ID_Pemasok` int(11) DEFAULT NULL,
  `Nama_Barang` varchar(30) NOT NULL DEFAULT '',
  `Harga_Beli` float DEFAULT NULL,
  `Harga_Jual` float DEFAULT NULL,
  `ID_Satuan` int(11) DEFAULT NULL,
  `Status` varchar(11) DEFAULT NULL,
  `minstok` double DEFAULT '1',
  PRIMARY KEY (`Nama_Barang`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_barang: 0 rows
/*!40000 ALTER TABLE `inv_barang` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_barang` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_barang_jenis
DROP TABLE IF EXISTS `inv_barang_jenis`;
CREATE TABLE IF NOT EXISTS `inv_barang_jenis` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `JenisBarang` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`JenisBarang`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_barang_jenis: 9 rows
/*!40000 ALTER TABLE `inv_barang_jenis` DISABLE KEYS */;
REPLACE INTO `inv_barang_jenis` (`ID`, `JenisBarang`) VALUES
	(1, 'BUILD UP'),
	(2, 'CPU'),
	(5, 'MOTHERBOARD'),
	(6, 'PROCESSOR'),
	(7, 'VGA CARD'),
	(8, 'MONITOR CRT'),
	(9, 'MONITOR LCD'),
	(10, 'MONITOR LED'),
	(11, 'SOUND CARD');
/*!40000 ALTER TABLE `inv_barang_jenis` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_barang_kategori
DROP TABLE IF EXISTS `inv_barang_kategori`;
CREATE TABLE IF NOT EXISTS `inv_barang_kategori` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Kategori` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`Kategori`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_barang_kategori: 4 rows
/*!40000 ALTER TABLE `inv_barang_kategori` DISABLE KEYS */;
REPLACE INTO `inv_barang_kategori` (`ID`, `Kategori`) VALUES
	(1, 'KOMPUTER'),
	(2, 'PRINTER'),
	(3, 'SPARE PART'),
	(4, 'ASESORIS');
/*!40000 ALTER TABLE `inv_barang_kategori` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_barang_satuan
DROP TABLE IF EXISTS `inv_barang_satuan`;
CREATE TABLE IF NOT EXISTS `inv_barang_satuan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Satuan` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`Satuan`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_barang_satuan: 0 rows
/*!40000 ALTER TABLE `inv_barang_satuan` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_barang_satuan` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_blacklist
DROP TABLE IF EXISTS `inv_blacklist`;
CREATE TABLE IF NOT EXISTS `inv_blacklist` (
  `ID` int(11) DEFAULT NULL,
  `ID_Agt` int(11) NOT NULL DEFAULT '0',
  `Keterangan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_Agt`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_blacklist: 0 rows
/*!40000 ALTER TABLE `inv_blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_blacklist` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_golongan
DROP TABLE IF EXISTS `inv_golongan`;
CREATE TABLE IF NOT EXISTS `inv_golongan` (
  `nm_golongan` varchar(225) NOT NULL DEFAULT '',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nm_golongan`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='tabel golongan obat';

-- Dumping data for table putridb.inv_golongan: 0 rows
/*!40000 ALTER TABLE `inv_golongan` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_golongan` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_konversi
DROP TABLE IF EXISTS `inv_konversi`;
CREATE TABLE IF NOT EXISTS `inv_konversi` (
  `id_barang` varchar(50) NOT NULL DEFAULT '',
  `nm_barang` varchar(225) NOT NULL DEFAULT '',
  `nm_satuan` varchar(50) DEFAULT NULL,
  `sat_beli` varchar(50) NOT NULL DEFAULT '',
  `isi_konversi` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`sat_beli`,`id_barang`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_konversi: 0 rows
/*!40000 ALTER TABLE `inv_konversi` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_konversi` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_material_count
DROP TABLE IF EXISTS `inv_material_count`;
CREATE TABLE IF NOT EXISTS `inv_material_count` (
  `nm_barang` varchar(125) NOT NULL DEFAULT '',
  `nm_satuan` varchar(50) DEFAULT NULL,
  `count1` double DEFAULT '0',
  `count2` double DEFAULT '0',
  `datecount` date DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`nm_barang`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_material_count: 0 rows
/*!40000 ALTER TABLE `inv_material_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_material_count` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_material_stok
DROP TABLE IF EXISTS `inv_material_stok`;
CREATE TABLE IF NOT EXISTS `inv_material_stok` (
  `id_barang` int(50) NOT NULL DEFAULT '0',
  `nm_barang` varchar(125) NOT NULL DEFAULT '',
  `batch` varchar(125) NOT NULL DEFAULT '',
  `expired` date DEFAULT NULL,
  `stock` double DEFAULT '0',
  `blokstok` double DEFAULT '0',
  `nm_satuan` varchar(50) DEFAULT NULL,
  `harga_beli` int(10) unsigned DEFAULT '0',
  `created_by` varchar(50) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`batch`,`id_barang`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='data stock material';

-- Dumping data for table putridb.inv_material_stok: 0 rows
/*!40000 ALTER TABLE `inv_material_stok` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_material_stok` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_pemasok
DROP TABLE IF EXISTS `inv_pemasok`;
CREATE TABLE IF NOT EXISTS `inv_pemasok` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Pemasok` varchar(30) DEFAULT NULL,
  `Alamat` varchar(50) DEFAULT NULL,
  `Kota` varchar(20) DEFAULT NULL,
  `Propinsi` varchar(20) DEFAULT NULL,
  `Telepon` varchar(30) DEFAULT NULL,
  `Faksimili` varchar(15) DEFAULT NULL,
  `Status` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_pemasok: 0 rows
/*!40000 ALTER TABLE `inv_pemasok` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_pemasok` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_pembayaran
DROP TABLE IF EXISTS `inv_pembayaran`;
CREATE TABLE IF NOT EXISTS `inv_pembayaran` (
  `no_transaksi` varchar(50) NOT NULL DEFAULT '0',
  `total_belanja` double DEFAULT '0',
  `ppn` double DEFAULT '0',
  `total_bayar` double DEFAULT '0',
  `jml_dibayar` double DEFAULT '0',
  `kembalian` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no_transaksi`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_pembayaran: 0 rows
/*!40000 ALTER TABLE `inv_pembayaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_pembayaran` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_pembelian
DROP TABLE IF EXISTS `inv_pembelian`;
CREATE TABLE IF NOT EXISTS `inv_pembelian` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Pemasok` int(11) DEFAULT NULL,
  `NoUrut` varchar(50) DEFAULT NULL,
  `Nomor` varchar(15) DEFAULT NULL,
  `Deskripsi` varchar(30) DEFAULT NULL,
  `ID_Bayar` int(11) DEFAULT NULL,
  `ID_Post` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_pembelian: 0 rows
/*!40000 ALTER TABLE `inv_pembelian` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_pembelian` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_pembelian_detail
DROP TABLE IF EXISTS `inv_pembelian_detail`;
CREATE TABLE IF NOT EXISTS `inv_pembelian_detail` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Tanggal` datetime DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Beli` int(11) DEFAULT NULL,
  `ID_Barang` int(11) DEFAULT NULL,
  `Jml_Faktur` smallint(6) DEFAULT NULL,
  `Jumlah` int(11) DEFAULT NULL,
  `Harga_Beli` float DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `ID_Satuan` int(11) DEFAULT NULL,
  `Batch` varchar(50) DEFAULT NULL,
  KEY `ID` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_pembelian_detail: 0 rows
/*!40000 ALTER TABLE `inv_pembelian_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_pembelian_detail` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_pembelian_jenis
DROP TABLE IF EXISTS `inv_pembelian_jenis`;
CREATE TABLE IF NOT EXISTS `inv_pembelian_jenis` (
  `ID` int(11) DEFAULT NULL,
  `Jenis_Beli` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_pembelian_jenis: 0 rows
/*!40000 ALTER TABLE `inv_pembelian_jenis` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_pembelian_jenis` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_pembelian_rekap
DROP TABLE IF EXISTS `inv_pembelian_rekap`;
CREATE TABLE IF NOT EXISTS `inv_pembelian_rekap` (
  `ID` int(11) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Beli` int(11) DEFAULT NULL,
  `ID_Barang` int(11) DEFAULT NULL,
  `Jml_Faktur` smallint(6) DEFAULT NULL,
  `Jumlah` int(11) DEFAULT NULL,
  `Harga_Beli` float DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `ID_Satuan` int(11) DEFAULT NULL,
  `batch` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table putridb.inv_pembelian_rekap: 0 rows
/*!40000 ALTER TABLE `inv_pembelian_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_pembelian_rekap` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_pembelian_status
DROP TABLE IF EXISTS `inv_pembelian_status`;
CREATE TABLE IF NOT EXISTS `inv_pembelian_status` (
  `ID` int(11) DEFAULT NULL,
  `Status` varchar(12) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_pembelian_status: 0 rows
/*!40000 ALTER TABLE `inv_pembelian_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_pembelian_status` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_penjualan
DROP TABLE IF EXISTS `inv_penjualan`;
CREATE TABLE IF NOT EXISTS `inv_penjualan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` varchar(50) NOT NULL DEFAULT '',
  `Nomor` varchar(50) DEFAULT NULL,
  `ID_Anggota` int(11) DEFAULT '0',
  `Deskripsi` varchar(30) DEFAULT NULL,
  `Cicilan` tinyint(4) DEFAULT NULL,
  `Total` double DEFAULT NULL,
  `Tgl_Cicilan` datetime DEFAULT NULL,
  `ID_Post` tinyint(4) DEFAULT NULL,
  `ID_Close` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_penjualan: 0 rows
/*!40000 ALTER TABLE `inv_penjualan` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_penjualan` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_penjualan_bayar
DROP TABLE IF EXISTS `inv_penjualan_bayar`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_bayar` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jual` int(11) DEFAULT NULL,
  `ID_Master` tinyint(4) DEFAULT NULL,
  `Tanggal` varchar(50) DEFAULT NULL,
  `Bayar` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_penjualan_bayar: 0 rows
/*!40000 ALTER TABLE `inv_penjualan_bayar` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_penjualan_bayar` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_penjualan_detail
DROP TABLE IF EXISTS `inv_penjualan_detail`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_detail` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Jual` int(11) DEFAULT NULL,
  `ID_Barang` int(11) DEFAULT NULL,
  `Jumlah` smallint(6) DEFAULT NULL,
  `Harga` float DEFAULT NULL,
  `ID_Post` tinyint(4) DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `ID_Satuan` varchar(50) DEFAULT NULL,
  `Batch` varchar(50) DEFAULT NULL,
  KEY `ID` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_penjualan_detail: 0 rows
/*!40000 ALTER TABLE `inv_penjualan_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_penjualan_detail` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_penjualan_jenis
DROP TABLE IF EXISTS `inv_penjualan_jenis`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_jenis` (
  `ID` int(11) DEFAULT NULL,
  `Jenis_Jual` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_penjualan_jenis: 0 rows
/*!40000 ALTER TABLE `inv_penjualan_jenis` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_penjualan_jenis` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_penjualan_rekap
DROP TABLE IF EXISTS `inv_penjualan_rekap`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_rekap` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Jual` int(11) DEFAULT NULL,
  `ID_Barang` int(11) DEFAULT NULL,
  `Jumlah` smallint(6) DEFAULT NULL,
  `Harga` double DEFAULT NULL,
  `ID_Post` tinyint(4) DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `no_transaksi` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table putridb.inv_penjualan_rekap: 0 rows
/*!40000 ALTER TABLE `inv_penjualan_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_penjualan_rekap` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_penjualan_status
DROP TABLE IF EXISTS `inv_penjualan_status`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_status` (
  `ID` int(11) DEFAULT NULL,
  `Status_Jual` varchar(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_penjualan_status: 0 rows
/*!40000 ALTER TABLE `inv_penjualan_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_penjualan_status` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_posting_date
DROP TABLE IF EXISTS `inv_posting_date`;
CREATE TABLE IF NOT EXISTS `inv_posting_date` (
  `ID` int(11) DEFAULT NULL,
  `PostingDate` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_posting_date: 0 rows
/*!40000 ALTER TABLE `inv_posting_date` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_posting_date` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_posting_status
DROP TABLE IF EXISTS `inv_posting_status`;
CREATE TABLE IF NOT EXISTS `inv_posting_status` (
  `ID` int(11) DEFAULT NULL,
  `PostStatus` varchar(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_posting_status: 0 rows
/*!40000 ALTER TABLE `inv_posting_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_posting_status` ENABLE KEYS */;


-- Dumping structure for table putridb.inv_tagihan
DROP TABLE IF EXISTS `inv_tagihan`;
CREATE TABLE IF NOT EXISTS `inv_tagihan` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jual` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.inv_tagihan: 0 rows
/*!40000 ALTER TABLE `inv_tagihan` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_tagihan` ENABLE KEYS */;


-- Dumping structure for table putridb.jenis_simpanan
DROP TABLE IF EXISTS `jenis_simpanan`;
CREATE TABLE IF NOT EXISTS `jenis_simpanan` (
  `ID` int(11) DEFAULT NULL,
  `Jenis` varchar(12) DEFAULT NULL,
  `ID_Klasifikasi` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.jenis_simpanan: 0 rows
/*!40000 ALTER TABLE `jenis_simpanan` DISABLE KEYS */;
/*!40000 ALTER TABLE `jenis_simpanan` ENABLE KEYS */;


-- Dumping structure for table putridb.jurnal
DROP TABLE IF EXISTS `jurnal`;
CREATE TABLE IF NOT EXISTS `jurnal` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.jurnal: 0 rows
/*!40000 ALTER TABLE `jurnal` DISABLE KEYS */;
/*!40000 ALTER TABLE `jurnal` ENABLE KEYS */;


-- Dumping structure for table putridb.kas
DROP TABLE IF EXISTS `kas`;
CREATE TABLE IF NOT EXISTS `kas` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Kode` varchar(50) DEFAULT NULL,
  `Nama_Kas` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.kas: 0 rows
/*!40000 ALTER TABLE `kas` DISABLE KEYS */;
/*!40000 ALTER TABLE `kas` ENABLE KEYS */;


-- Dumping structure for table putridb.kas_sub
DROP TABLE IF EXISTS `kas_sub`;
CREATE TABLE IF NOT EXISTS `kas_sub` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ID_KAS` int(10) DEFAULT NULL,
  `Nama_SubKas` varchar(150) DEFAULT NULL,
  `ID_Calc` int(10) DEFAULT '0',
  `ID_CC` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.kas_sub: 0 rows
/*!40000 ALTER TABLE `kas_sub` DISABLE KEYS */;
/*!40000 ALTER TABLE `kas_sub` ENABLE KEYS */;


-- Dumping structure for table putridb.keaktifan
DROP TABLE IF EXISTS `keaktifan`;
CREATE TABLE IF NOT EXISTS `keaktifan` (
  `ID` int(11) DEFAULT NULL,
  `Keaktifan` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.keaktifan: 0 rows
/*!40000 ALTER TABLE `keaktifan` DISABLE KEYS */;
/*!40000 ALTER TABLE `keaktifan` ENABLE KEYS */;


-- Dumping structure for table putridb.klasifikasi
DROP TABLE IF EXISTS `klasifikasi`;
CREATE TABLE IF NOT EXISTS `klasifikasi` (
  `ID` int(11) DEFAULT NULL,
  `Kode` varchar(2) DEFAULT NULL,
  `Klasifikasi` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.klasifikasi: 0 rows
/*!40000 ALTER TABLE `klasifikasi` DISABLE KEYS */;
/*!40000 ALTER TABLE `klasifikasi` ENABLE KEYS */;


-- Dumping structure for table putridb.laba_rugi
DROP TABLE IF EXISTS `laba_rugi`;
CREATE TABLE IF NOT EXISTS `laba_rugi` (
  `ID` int(11) DEFAULT NULL,
  `Jenis` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.laba_rugi: 0 rows
/*!40000 ALTER TABLE `laba_rugi` DISABLE KEYS */;
/*!40000 ALTER TABLE `laba_rugi` ENABLE KEYS */;


-- Dumping structure for table putridb.laporan
DROP TABLE IF EXISTS `laporan`;
CREATE TABLE IF NOT EXISTS `laporan` (
  `ID` int(11) DEFAULT NULL,
  `JenisLaporan` varchar(15) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.laporan: 0 rows
/*!40000 ALTER TABLE `laporan` DISABLE KEYS */;
/*!40000 ALTER TABLE `laporan` ENABLE KEYS */;


-- Dumping structure for table putridb.lap_head
DROP TABLE IF EXISTS `lap_head`;
CREATE TABLE IF NOT EXISTS `lap_head` (
  `ID` int(11) DEFAULT NULL,
  `Header1` varchar(11) DEFAULT NULL,
  `Header2` varchar(11) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.lap_head: 0 rows
/*!40000 ALTER TABLE `lap_head` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_head` ENABLE KEYS */;


-- Dumping structure for table putridb.lap_jenis
DROP TABLE IF EXISTS `lap_jenis`;
CREATE TABLE IF NOT EXISTS `lap_jenis` (
  `ID` int(11) DEFAULT NULL,
  `ID_Head` int(11) DEFAULT NULL,
  `ID_KBR` smallint(6) DEFAULT NULL,
  `ID_USP` smallint(6) DEFAULT NULL,
  `ID_Calc` smallint(6) DEFAULT NULL,
  `Jenis` varchar(30) DEFAULT NULL,
  `Jenis1` varchar(30) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.lap_jenis: 0 rows
/*!40000 ALTER TABLE `lap_jenis` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_jenis` ENABLE KEYS */;


-- Dumping structure for table putridb.lap_neraca_detail
DROP TABLE IF EXISTS `lap_neraca_detail`;
CREATE TABLE IF NOT EXISTS `lap_neraca_detail` (
  `ID` int(11) DEFAULT NULL,
  `ID_Head` int(11) DEFAULT NULL,
  `ID_KBR` tinyint(4) DEFAULT NULL,
  `ID_USP` tinyint(4) DEFAULT NULL,
  `Detail` varchar(50) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.lap_neraca_detail: 0 rows
/*!40000 ALTER TABLE `lap_neraca_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_neraca_detail` ENABLE KEYS */;


-- Dumping structure for table putridb.lap_neraca_head
DROP TABLE IF EXISTS `lap_neraca_head`;
CREATE TABLE IF NOT EXISTS `lap_neraca_head` (
  `ID` int(11) DEFAULT NULL,
  `ID_Ledger` int(11) DEFAULT NULL,
  `ID_Head` int(11) DEFAULT NULL,
  `Head` varchar(30) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.lap_neraca_head: 0 rows
/*!40000 ALTER TABLE `lap_neraca_head` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_neraca_head` ENABLE KEYS */;


-- Dumping structure for table putridb.lap_neraca_ledger
DROP TABLE IF EXISTS `lap_neraca_ledger`;
CREATE TABLE IF NOT EXISTS `lap_neraca_ledger` (
  `ID` int(11) DEFAULT NULL,
  `ID_Ledger` int(11) DEFAULT NULL,
  `Ledger1` varchar(20) DEFAULT NULL,
  `Ledger2` varchar(20) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.lap_neraca_ledger: 0 rows
/*!40000 ALTER TABLE `lap_neraca_ledger` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_neraca_ledger` ENABLE KEYS */;


-- Dumping structure for table putridb.lap_shu_detail
DROP TABLE IF EXISTS `lap_shu_detail`;
CREATE TABLE IF NOT EXISTS `lap_shu_detail` (
  `ID` int(11) DEFAULT NULL,
  `ID_Head` int(11) DEFAULT NULL,
  `ID_KBR` tinyint(4) DEFAULT NULL,
  `ID_USP` tinyint(4) DEFAULT NULL,
  `Detail` varchar(50) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.lap_shu_detail: 0 rows
/*!40000 ALTER TABLE `lap_shu_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_shu_detail` ENABLE KEYS */;


-- Dumping structure for table putridb.lap_shu_head
DROP TABLE IF EXISTS `lap_shu_head`;
CREATE TABLE IF NOT EXISTS `lap_shu_head` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Head` int(11) DEFAULT NULL,
  `Head` varchar(50) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.lap_shu_head: 0 rows
/*!40000 ALTER TABLE `lap_shu_head` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_shu_head` ENABLE KEYS */;


-- Dumping structure for table putridb.lap_subjenis
DROP TABLE IF EXISTS `lap_subjenis`;
CREATE TABLE IF NOT EXISTS `lap_subjenis` (
  `ID` int(11) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `ID_Lap` int(11) DEFAULT NULL,
  `ID_Jenis` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_KBR` smallint(6) DEFAULT NULL,
  `ID_USP` smallint(6) DEFAULT NULL,
  `ID_Post` smallint(6) DEFAULT NULL,
  `SubJenis` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.lap_subjenis: 0 rows
/*!40000 ALTER TABLE `lap_subjenis` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_subjenis` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_anggota
DROP TABLE IF EXISTS `mst_anggota`;
CREATE TABLE IF NOT EXISTS `mst_anggota` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT '0',
  `ID_Aktif` int(11) DEFAULT '0',
  `ID_Dept` int(11) DEFAULT '0',
  `No_Perkiraan` varchar(4) DEFAULT NULL,
  `NIP` varchar(10) DEFAULT NULL,
  `No_Agt` varchar(10) DEFAULT NULL,
  `Nama` varchar(50) DEFAULT NULL,
  `ID_Check` smallint(6) DEFAULT '0',
  `ID_Kelamin` int(11) DEFAULT '0',
  `TanggalMasuk` datetime DEFAULT NULL,
  `TanggalKeluar` datetime DEFAULT NULL,
  `PhotoLink` varchar(255) DEFAULT NULL,
  `Catatan` mediumtext,
  `Alamat` varchar(50) DEFAULT NULL,
  `Kota` varchar(50) DEFAULT NULL,
  `Propinsi` varchar(50) DEFAULT NULL,
  `Telepon` varchar(50) DEFAULT NULL,
  `Faksimili` varchar(50) DEFAULT NULL,
  `Status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table anggota koperasi';

-- Dumping data for table putridb.mst_anggota: 0 rows
/*!40000 ALTER TABLE `mst_anggota` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_anggota` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_anggota_copy
DROP TABLE IF EXISTS `mst_anggota_copy`;
CREATE TABLE IF NOT EXISTS `mst_anggota_copy` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `ID_Aktif` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `No_Perkiraan` varchar(4) DEFAULT NULL,
  `NIP` varchar(10) DEFAULT NULL,
  `No_Agt` varchar(10) DEFAULT NULL,
  `Nama` varchar(40) DEFAULT NULL,
  `ID_Check` smallint(6) DEFAULT NULL,
  `ID_Kelamin` int(11) DEFAULT NULL,
  `TanggalMasuk` datetime DEFAULT NULL,
  `TanggalKeluar` datetime DEFAULT NULL,
  `PhotoLink` varchar(255) DEFAULT NULL,
  `Catatan` mediumtext,
  `Alamat` varchar(50) DEFAULT NULL,
  `Kota` varchar(20) DEFAULT NULL,
  `Propinsi` varchar(20) DEFAULT NULL,
  `Telepon` varchar(50) DEFAULT NULL,
  `Faksimili` varchar(50) DEFAULT NULL,
  `Status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='table anggota koperasi';

-- Dumping data for table putridb.mst_anggota_copy: 0 rows
/*!40000 ALTER TABLE `mst_anggota_copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_anggota_copy` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_bulan
DROP TABLE IF EXISTS `mst_bulan`;
CREATE TABLE IF NOT EXISTS `mst_bulan` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `Bulan` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.mst_bulan: 0 rows
/*!40000 ALTER TABLE `mst_bulan` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_bulan` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_departemen
DROP TABLE IF EXISTS `mst_departemen`;
CREATE TABLE IF NOT EXISTS `mst_departemen` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `Kode` varchar(2) DEFAULT NULL,
  `Departemen` varchar(40) DEFAULT NULL,
  `Title` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.mst_departemen: 0 rows
/*!40000 ALTER TABLE `mst_departemen` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_departemen` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_kas
DROP TABLE IF EXISTS `mst_kas`;
CREATE TABLE IF NOT EXISTS `mst_kas` (
  `id_kas` varchar(100) NOT NULL DEFAULT '',
  `nm_kas` varchar(225) DEFAULT '',
  `sa_kas` double DEFAULT '0',
  `sl_kas` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_kas`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.mst_kas: 1 rows
/*!40000 ALTER TABLE `mst_kas` DISABLE KEYS */;
REPLACE INTO `mst_kas` (`id_kas`, `nm_kas`, `sa_kas`, `sl_kas`, `doc_date`, `created_by`) VALUES
	('100002', 'KAS HARIAN TOKO', 0, 0, '2012-12-07 00:09:28', 'superuser');
/*!40000 ALTER TABLE `mst_kas` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_kas_harian
DROP TABLE IF EXISTS `mst_kas_harian`;
CREATE TABLE IF NOT EXISTS `mst_kas_harian` (
  `no_trans` varchar(50) NOT NULL DEFAULT '0000-00-00',
  `tgl_kas` date NOT NULL DEFAULT '0000-00-00',
  `id_kas` varchar(50) NOT NULL DEFAULT '',
  `nm_kas` varchar(150) DEFAULT NULL,
  `sa_kas` double DEFAULT '0',
  `created_by` varchar(225) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tgl_kas`,`id_kas`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.mst_kas_harian: 2 rows
/*!40000 ALTER TABLE `mst_kas_harian` DISABLE KEYS */;
REPLACE INTO `mst_kas_harian` (`no_trans`, `tgl_kas`, `id_kas`, `nm_kas`, `sa_kas`, `created_by`, `doc_date`) VALUES
	('2000000000', '2012-12-06', '100002', 'KAS HARIAN TOKO', 500000, 'superuser', '2012-12-07 00:18:43'),
	('2000000001', '2012-12-14', '100002', 'KAS HARIAN TOKO', 500000, 'superuser', '2012-12-14 16:26:50');
/*!40000 ALTER TABLE `mst_kas_harian` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_kas_trans
DROP TABLE IF EXISTS `mst_kas_trans`;
CREATE TABLE IF NOT EXISTS `mst_kas_trans` (
  `id_trans` int(10) NOT NULL DEFAULT '0',
  `id_kas` varchar(10) DEFAULT NULL,
  `tgl_trans` date DEFAULT NULL,
  `uraian_trans` text,
  `jumlah` double DEFAULT '0',
  `saldo_kas` double DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_trans`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='transaksi kas harian';

-- Dumping data for table putridb.mst_kas_trans: 2 rows
/*!40000 ALTER TABLE `mst_kas_trans` DISABLE KEYS */;
REPLACE INTO `mst_kas_trans` (`id_trans`, `id_kas`, `tgl_trans`, `uraian_trans`, `jumlah`, `saldo_kas`, `created_by`, `doc_date`) VALUES
	(2000000000, '100002', '2012-12-06', 'Saldo Awal hari ini', 0, 500000, NULL, '2012-12-07 00:18:43'),
	(2000000001, '100002', '2012-12-14', 'Saldo Awal hari ini', 0, 500000, NULL, '2012-12-14 16:26:50');
/*!40000 ALTER TABLE `mst_kas_trans` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_kota
DROP TABLE IF EXISTS `mst_kota`;
CREATE TABLE IF NOT EXISTS `mst_kota` (
  `kota_anggota` varchar(150) NOT NULL DEFAULT '',
  `created_by` varchar(150) NOT NULL DEFAULT '',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kota_anggota`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.mst_kota: 0 rows
/*!40000 ALTER TABLE `mst_kota` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_kota` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_pelanggan
DROP TABLE IF EXISTS `mst_pelanggan`;
CREATE TABLE IF NOT EXISTS `mst_pelanggan` (
  `nm_pelanggan` varchar(125) NOT NULL DEFAULT '',
  `alm_pelanggan` text,
  `telp_pelanggan` varchar(50) DEFAULT NULL,
  `hutang_pelanggan` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nm_pelanggan`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.mst_pelanggan: 0 rows
/*!40000 ALTER TABLE `mst_pelanggan` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_pelanggan` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_produsen
DROP TABLE IF EXISTS `mst_produsen`;
CREATE TABLE IF NOT EXISTS `mst_produsen` (
  `nm_produsen` varchar(125) NOT NULL DEFAULT '',
  ` alm_produsen` text,
  ` telp_produsen` varchar(50) DEFAULT NULL,
  ` hutang_produsen` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nm_produsen`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.mst_produsen: 0 rows
/*!40000 ALTER TABLE `mst_produsen` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_produsen` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_propinsi
DROP TABLE IF EXISTS `mst_propinsi`;
CREATE TABLE IF NOT EXISTS `mst_propinsi` (
  `prop_anggota` varchar(100) NOT NULL DEFAULT '',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`prop_anggota`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='data propinsi';

-- Dumping data for table putridb.mst_propinsi: 0 rows
/*!40000 ALTER TABLE `mst_propinsi` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_propinsi` ENABLE KEYS */;


-- Dumping structure for table putridb.mst_status
DROP TABLE IF EXISTS `mst_status`;
CREATE TABLE IF NOT EXISTS `mst_status` (
  `nm_status` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`nm_status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.mst_status: 0 rows
/*!40000 ALTER TABLE `mst_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_status` ENABLE KEYS */;


-- Dumping structure for table putridb.nomor_transaksi
DROP TABLE IF EXISTS `nomor_transaksi`;
CREATE TABLE IF NOT EXISTS `nomor_transaksi` (
  `nomor` varchar(50) NOT NULL DEFAULT '',
  `jenis_transaksi` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`nomor`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.nomor_transaksi: 2 rows
/*!40000 ALTER TABLE `nomor_transaksi` DISABLE KEYS */;
REPLACE INTO `nomor_transaksi` (`nomor`, `jenis_transaksi`, `created_by`, `doc_date`) VALUES
	('2000000000', 'D', NULL, '2012-12-07 00:18:43'),
	('2000000001', 'D', NULL, '2012-12-14 16:26:50');
/*!40000 ALTER TABLE `nomor_transaksi` ENABLE KEYS */;


-- Dumping structure for table putridb.perkiraan
DROP TABLE IF EXISTS `perkiraan`;
CREATE TABLE IF NOT EXISTS `perkiraan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.perkiraan: 0 rows
/*!40000 ALTER TABLE `perkiraan` DISABLE KEYS */;
/*!40000 ALTER TABLE `perkiraan` ENABLE KEYS */;


-- Dumping structure for table putridb.pinjaman
DROP TABLE IF EXISTS `pinjaman`;
CREATE TABLE IF NOT EXISTS `pinjaman` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ID_Unit` int(10) NOT NULL DEFAULT '0',
  `ID_Dept` int(10) NOT NULL DEFAULT '0',
  `ID_Agt` int(10) DEFAULT NULL,
  `ID_Bulan` int(10) DEFAULT NULL,
  `Tahun` int(10) DEFAULT NULL,
  `pinjaman` double DEFAULT '0',
  `cicilan` double DEFAULT '0',
  `cicilan_end` double DEFAULT '0',
  `lama_cicilan` double DEFAULT '1',
  `cara_bayar` varchar(50) DEFAULT NULL,
  `keterangan` text,
  `mulai_bayar` varchar(50) DEFAULT NULL,
  `stat_pinjaman` int(11) DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table daftar pinjaman anggota';

-- Dumping data for table putridb.pinjaman: 0 rows
/*!40000 ALTER TABLE `pinjaman` DISABLE KEYS */;
/*!40000 ALTER TABLE `pinjaman` ENABLE KEYS */;


-- Dumping structure for table putridb.pinjaman_bayar
DROP TABLE IF EXISTS `pinjaman_bayar`;
CREATE TABLE IF NOT EXISTS `pinjaman_bayar` (
  `ID_pinjaman` int(10) NOT NULL DEFAULT '0',
  `ID_Agt` int(10) NOT NULL DEFAULT '0',
  `ID_Bulan` int(10) NOT NULL DEFAULT '0',
  `Tahun` int(10) NOT NULL DEFAULT '0',
  `Debet` double DEFAULT '0',
  `Kredit` double DEFAULT '0',
  `saldo` double DEFAULT '0',
  `keterangan` text,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_Agt`,`ID_Bulan`,`Tahun`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table transaksi pembayaran pinjaman';

-- Dumping data for table putridb.pinjaman_bayar: 0 rows
/*!40000 ALTER TABLE `pinjaman_bayar` DISABLE KEYS */;
/*!40000 ALTER TABLE `pinjaman_bayar` ENABLE KEYS */;


-- Dumping structure for table putridb.pinjaman_limit
DROP TABLE IF EXISTS `pinjaman_limit`;
CREATE TABLE IF NOT EXISTS `pinjaman_limit` (
  `ID_Ang` int(10) NOT NULL DEFAULT '0',
  `Tahun` int(10) NOT NULL DEFAULT '0',
  `max_limit` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_Ang`,`Tahun`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table daftar limit maximal anggota dapat meminjam, 0 adalah no limit';

-- Dumping data for table putridb.pinjaman_limit: 0 rows
/*!40000 ALTER TABLE `pinjaman_limit` DISABLE KEYS */;
/*!40000 ALTER TABLE `pinjaman_limit` ENABLE KEYS */;


-- Dumping structure for table putridb.setup_simpanan
DROP TABLE IF EXISTS `setup_simpanan`;
CREATE TABLE IF NOT EXISTS `setup_simpanan` (
  `id_simpanan` int(10) NOT NULL DEFAULT '0',
  `nm_simpanan` varchar(50) DEFAULT NULL,
  `min_simpanan` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_simpanan`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table pengaturan simpanan anggota';

-- Dumping data for table putridb.setup_simpanan: 0 rows
/*!40000 ALTER TABLE `setup_simpanan` DISABLE KEYS */;
/*!40000 ALTER TABLE `setup_simpanan` ENABLE KEYS */;


-- Dumping structure for table putridb.set_simpanan_log
DROP TABLE IF EXISTS `set_simpanan_log`;
CREATE TABLE IF NOT EXISTS `set_simpanan_log` (
  `id_simpanan` int(10) NOT NULL DEFAULT '0',
  `nm_simpanan` varchar(50) DEFAULT NULL,
  `min_simpanan` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED COMMENT='table pengaturan simpanan anggota';

-- Dumping data for table putridb.set_simpanan_log: 0 rows
/*!40000 ALTER TABLE `set_simpanan_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `set_simpanan_log` ENABLE KEYS */;


-- Dumping structure for table putridb.status
DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `ID` int(11) DEFAULT NULL,
  `Status1` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.status: 0 rows
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
/*!40000 ALTER TABLE `status` ENABLE KEYS */;


-- Dumping structure for table putridb.sub_klasifikasi
DROP TABLE IF EXISTS `sub_klasifikasi`;
CREATE TABLE IF NOT EXISTS `sub_klasifikasi` (
  `ID` int(11) DEFAULT NULL,
  `ID_Klasifikasi` int(11) DEFAULT NULL,
  `ID_Neraca` int(11) DEFAULT NULL,
  `Kode` varchar(2) DEFAULT NULL,
  `SubKlasifikasi` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.sub_klasifikasi: 0 rows
/*!40000 ALTER TABLE `sub_klasifikasi` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_klasifikasi` ENABLE KEYS */;


-- Dumping structure for procedure putridb.s_total_pinjaman
DROP PROCEDURE IF EXISTS `s_total_pinjaman`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_total_pinjaman`(IN `ID_Pi` INT)
BEGIN
	select p.pinjaman as t_pinjaman from pinjaman as p where ID=ID_Pi;
END//
DELIMITER ;


-- Dumping structure for procedure putridb.s_total_pinjaman_bayar
DROP PROCEDURE IF EXISTS `s_total_pinjaman_bayar`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_total_pinjaman_bayar`(IN `ID_Pinjaman` INT)
BEGIN
	select sum(kredit) as t_setoran from pinjaman_bayar where ID_Pinjaman=ID_Pinjaman;
END//
DELIMITER ;


-- Dumping structure for table putridb.tipe_jurnal
DROP TABLE IF EXISTS `tipe_jurnal`;
CREATE TABLE IF NOT EXISTS `tipe_jurnal` (
  `ID` int(11) DEFAULT NULL,
  `Jenis` varchar(30) DEFAULT NULL,
  `Kode` varchar(2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.tipe_jurnal: 0 rows
/*!40000 ALTER TABLE `tipe_jurnal` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipe_jurnal` ENABLE KEYS */;


-- Dumping structure for table putridb.tipe_transaksi
DROP TABLE IF EXISTS `tipe_transaksi`;
CREATE TABLE IF NOT EXISTS `tipe_transaksi` (
  `ID` int(11) DEFAULT NULL,
  `Tipe` varchar(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.tipe_transaksi: 0 rows
/*!40000 ALTER TABLE `tipe_transaksi` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipe_transaksi` ENABLE KEYS */;


-- Dumping structure for table putridb.tmp_kasir_transaksi_rekap
DROP TABLE IF EXISTS `tmp_kasir_transaksi_rekap`;
CREATE TABLE IF NOT EXISTS `tmp_kasir_transaksi_rekap` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept_T` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_P` int(11) DEFAULT NULL,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) DEFAULT NULL,
  `NoUrut_P` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  `ID_J` int(11) DEFAULT NULL,
  `ID_Unit_J` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept_J` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan_J` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.tmp_kasir_transaksi_rekap: 0 rows
/*!40000 ALTER TABLE `tmp_kasir_transaksi_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_kasir_transaksi_rekap` ENABLE KEYS */;


-- Dumping structure for table putridb.tmp_superuser_neraca_balance
DROP TABLE IF EXISTS `tmp_superuser_neraca_balance`;
CREATE TABLE IF NOT EXISTS `tmp_superuser_neraca_balance` (
  `unit` int(10) NOT NULL DEFAULT '0',
  `periode` date NOT NULL DEFAULT '0000-00-00',
  `Aktiva` double DEFAULT '0',
  `Aktiva2` double DEFAULT '0',
  `Pasiva` double DEFAULT '0',
  `Pasiva2` double DEFAULT '0',
  PRIMARY KEY (`periode`,`unit`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.tmp_superuser_neraca_balance: 0 rows
/*!40000 ALTER TABLE `tmp_superuser_neraca_balance` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_superuser_neraca_balance` ENABLE KEYS */;


-- Dumping structure for table putridb.tmp_superuser_total_shu
DROP TABLE IF EXISTS `tmp_superuser_total_shu`;
CREATE TABLE IF NOT EXISTS `tmp_superuser_total_shu` (
  `tglAwal` date DEFAULT NULL,
  `tglAkhir` date DEFAULT NULL,
  `saldo` double DEFAULT '0',
  `saldo2` double DEFAULT '0',
  `unit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`unit`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.tmp_superuser_total_shu: 0 rows
/*!40000 ALTER TABLE `tmp_superuser_total_shu` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_superuser_total_shu` ENABLE KEYS */;


-- Dumping structure for table putridb.tmp_superuser_transaksi_rekap
DROP TABLE IF EXISTS `tmp_superuser_transaksi_rekap`;
CREATE TABLE IF NOT EXISTS `tmp_superuser_transaksi_rekap` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept_T` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_P` int(11) DEFAULT NULL,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) DEFAULT NULL,
  `NoUrut_P` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  `ID_J` int(11) DEFAULT NULL,
  `ID_Unit_J` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept_J` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan_J` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.tmp_superuser_transaksi_rekap: 0 rows
/*!40000 ALTER TABLE `tmp_superuser_transaksi_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_superuser_transaksi_rekap` ENABLE KEYS */;


-- Dumping structure for table putridb.tmp__neraca_balance
DROP TABLE IF EXISTS `tmp__neraca_balance`;
CREATE TABLE IF NOT EXISTS `tmp__neraca_balance` (
  `unit` int(10) NOT NULL DEFAULT '0',
  `periode` date NOT NULL DEFAULT '0000-00-00',
  `Aktiva` double DEFAULT '0',
  `Aktiva2` double DEFAULT '0',
  `Pasiva` double DEFAULT '0',
  `Pasiva2` double DEFAULT '0',
  PRIMARY KEY (`periode`,`unit`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.tmp__neraca_balance: 0 rows
/*!40000 ALTER TABLE `tmp__neraca_balance` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp__neraca_balance` ENABLE KEYS */;


-- Dumping structure for table putridb.tmp__total_shu
DROP TABLE IF EXISTS `tmp__total_shu`;
CREATE TABLE IF NOT EXISTS `tmp__total_shu` (
  `tglAwal` date DEFAULT NULL,
  `tglAkhir` date DEFAULT NULL,
  `saldo` double DEFAULT '0',
  `saldo2` double DEFAULT '0',
  `unit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`unit`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.tmp__total_shu: 0 rows
/*!40000 ALTER TABLE `tmp__total_shu` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp__total_shu` ENABLE KEYS */;


-- Dumping structure for table putridb.tmp__transaksi_rekap
DROP TABLE IF EXISTS `tmp__transaksi_rekap`;
CREATE TABLE IF NOT EXISTS `tmp__transaksi_rekap` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept_T` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_P` int(11) DEFAULT NULL,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) DEFAULT NULL,
  `NoUrut_P` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  `ID_J` int(11) DEFAULT NULL,
  `ID_Unit_J` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept_J` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan_J` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.tmp__transaksi_rekap: 0 rows
/*!40000 ALTER TABLE `tmp__transaksi_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp__transaksi_rekap` ENABLE KEYS */;


-- Dumping structure for table putridb.transaksi
DROP TABLE IF EXISTS `transaksi`;
CREATE TABLE IF NOT EXISTS `transaksi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.transaksi: 0 rows
/*!40000 ALTER TABLE `transaksi` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi` ENABLE KEYS */;


-- Dumping structure for table putridb.transaksi_del
DROP TABLE IF EXISTS `transaksi_del`;
CREATE TABLE IF NOT EXISTS `transaksi_del` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Ket` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table putridb.transaksi_del: 0 rows
/*!40000 ALTER TABLE `transaksi_del` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_del` ENABLE KEYS */;


-- Dumping structure for table putridb.transaksi_log
DROP TABLE IF EXISTS `transaksi_log`;
CREATE TABLE IF NOT EXISTS `transaksi_log` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ID_Trans` varchar(50) DEFAULT NULL,
  `Keterangan` text,
  `old_val` varchar(50) DEFAULT NULL,
  `new_val` varchar(50) DEFAULT NULL,
  `tanggal` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='log transaksi user';

-- Dumping data for table putridb.transaksi_log: 0 rows
/*!40000 ALTER TABLE `transaksi_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_log` ENABLE KEYS */;


-- Dumping structure for table putridb.transaksi_new
DROP TABLE IF EXISTS `transaksi_new`;
CREATE TABLE IF NOT EXISTS `transaksi_new` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Ket` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.transaksi_new: 0 rows
/*!40000 ALTER TABLE `transaksi_new` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_new` ENABLE KEYS */;


-- Dumping structure for table putridb.transaksi_rekap
DROP TABLE IF EXISTS `transaksi_rekap`;
CREATE TABLE IF NOT EXISTS `transaksi_rekap` (
  `ID` int(11) NOT NULL,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept_T` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_P` int(11) DEFAULT NULL,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) DEFAULT NULL,
  `NoUrut_P` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  `ID_J` int(11) DEFAULT NULL,
  `ID_Unit_J` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept_J` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan_J` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.transaksi_rekap: 0 rows
/*!40000 ALTER TABLE `transaksi_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_rekap` ENABLE KEYS */;


-- Dumping structure for table putridb.transaksi_temp
DROP TABLE IF EXISTS `transaksi_temp`;
CREATE TABLE IF NOT EXISTS `transaksi_temp` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ID_Unit` int(10) DEFAULT NULL,
  `ID_Dept` int(10) DEFAULT NULL,
  `ID_Klas` int(10) DEFAULT NULL,
  `ID_SubKlas` int(10) DEFAULT NULL,
  `ID_Perkiraan` int(10) NOT NULL DEFAULT '0',
  `Debet` double NOT NULL DEFAULT '0',
  `Kredit` double NOT NULL DEFAULT '0',
  `Keterangan` text,
  `ID_Bulan` varchar(50) NOT NULL DEFAULT '',
  `Tahun` varchar(50) NOT NULL DEFAULT '',
  `Tanggal` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `ID_Stat` int(10) DEFAULT '0',
  PRIMARY KEY (`ID_Perkiraan`,`Debet`,`Kredit`,`ID_Bulan`,`Tahun`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='pencatatan transaksi sebelum posting ke jurnal';

-- Dumping data for table putridb.transaksi_temp: 0 rows
/*!40000 ALTER TABLE `transaksi_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_temp` ENABLE KEYS */;


-- Dumping structure for table putridb.unit_jurnal
DROP TABLE IF EXISTS `unit_jurnal`;
CREATE TABLE IF NOT EXISTS `unit_jurnal` (
  `ID` int(11) DEFAULT NULL,
  `Kode` varchar(2) DEFAULT NULL,
  `Unit` varchar(15) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.unit_jurnal: 0 rows
/*!40000 ALTER TABLE `unit_jurnal` DISABLE KEYS */;
/*!40000 ALTER TABLE `unit_jurnal` ENABLE KEYS */;


-- Dumping structure for table putridb.useroto
DROP TABLE IF EXISTS `useroto`;
CREATE TABLE IF NOT EXISTS `useroto` (
  `userid` varchar(50) DEFAULT NULL,
  `idmenu` varchar(50) DEFAULT NULL,
  `c` enum('Y','N') DEFAULT 'N',
  `e` enum('Y','N') DEFAULT 'N',
  `v` enum('Y','N') DEFAULT 'N',
  `p` enum('Y','N') DEFAULT 'N',
  `d` enum('Y','N') DEFAULT 'N'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.useroto: 45 rows
/*!40000 ALTER TABLE `useroto` DISABLE KEYS */;
REPLACE INTO `useroto` (`userid`, `idmenu`, `c`, `e`, `v`, `p`, `d`) VALUES
	('3', 'authorisation', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'listuser', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'konversisatuan', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'satuanbarang', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'jenisbarang', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'kategoribarang', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'master__general', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'dataakun', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'preferece__lokasi', 'N', 'N', 'Y', 'N', 'N'),
	('2', 'adduser', 'Y', 'Y', 'N', 'N', 'N'),
	('2', 'listuser', 'N', 'Y', 'Y', 'N', 'N'),
	('2', 'authorisation', 'Y', 'N', 'Y', 'N', 'N'),
	('3', 'lokasogudang', 'N', 'N', 'Y', 'N', 'N'),
	('2', 'lokasogudang', 'Y', 'Y', 'Y', 'N', 'N'),
	('2', 'kategoribarang', 'Y', 'Y', 'Y', 'N', 'N'),
	('2', 'jenisbarang', 'Y', 'Y', 'Y', 'N', 'N'),
	('2', 'satuanbarang', 'Y', 'Y', 'Y', 'N', 'N'),
	('2', 'konversisatuan', 'Y', 'Y', 'Y', 'N', 'N'),
	('2', 'dataakun', 'Y', 'Y', 'Y', 'N', 'N'),
	('2', 'pembelian__index', 'Y', 'Y', 'N', 'N', 'N'),
	('2', 'stockadjustment', 'N', 'Y', 'Y', 'Y', 'N'),
	('2', 'gudang__index', 'Y', 'Y', 'Y', 'N', 'N'),
	('2', 'listbarang', 'N', 'Y', 'Y', 'Y', 'N'),
	('2', 'master__vendor_n', 'Y', 'Y', 'N', 'N', 'N'),
	('2', 'listvendor', 'N', 'Y', 'Y', 'Y', 'N'),
	('2', 'profile', 'Y', 'Y', 'Y', 'N', 'N'),
	('2', 'userarea', 'Y', 'N', 'Y', 'N', 'N'),
	('3', 'userarea', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'profile', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'penjualan__index', 'Y', 'N', 'N', 'N', 'N'),
	('3', 'return_jual', 'Y', 'N', 'N', 'N', 'N'),
	('3', 'kas_harian', 'Y', 'N', 'N', 'N', 'N'),
	('3', 'kas_keluar', 'Y', 'N', 'N', 'N', 'N'),
	('3', 'laporan__faktur', 'N', 'N', 'N', 'Y', 'N'),
	('3', 'liststock', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'listbarangterjual', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'pelangganbaru', 'Y', 'Y', 'N', 'N', 'N'),
	('3', 'member__member_list', 'N', 'Y', 'Y', 'Y', 'N'),
	('3', 'pembayarantagihan', 'Y', 'Y', 'N', 'N', 'N'),
	('3', 'listtagihan', 'N', 'N', 'Y', 'Y', 'N'),
	('3', 'listbarang', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'gudang__index', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'stock__index', 'N', 'N', 'Y', 'N', 'N'),
	('3', 'grafikpenjualan', 'N', 'N', 'N', 'N', 'N'),
	('3', 'operasionalharian', 'N', 'N', 'Y', 'N', 'N');
/*!40000 ALTER TABLE `useroto` ENABLE KEYS */;


-- Dumping structure for table putridb.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userid` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `idlevel` varchar(50) DEFAULT NULL,
  `active` enum('Y','N') DEFAULT 'Y',
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lokasi` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.users: ~2 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` (`userid`, `username`, `password`, `idlevel`, `active`, `createdate`, `lokasi`) VALUES
	('kasir', 'Kasirun', '7f46165474d11ee5836777d85df2cdab', '3', 'Y', '2012-12-07 00:19:45', NULL),
	('superuser', 'superuser', '8b5e22ec5b6020776fc7f5ec4897ac52', '1', 'Y', '2012-12-06 23:01:11', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


-- Dumping structure for table putridb.user_level
DROP TABLE IF EXISTS `user_level`;
CREATE TABLE IF NOT EXISTS `user_level` (
  `idlevel` int(50) NOT NULL AUTO_INCREMENT,
  `nmlevel` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idlevel`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.user_level: ~3 rows (approximately)
/*!40000 ALTER TABLE `user_level` DISABLE KEYS */;
REPLACE INTO `user_level` (`idlevel`, `nmlevel`) VALUES
	(1, 'Super User'),
	(2, 'Administrator'),
	(3, 'Kasir');
/*!40000 ALTER TABLE `user_level` ENABLE KEYS */;


-- Dumping structure for table putridb.user_lokasi
DROP TABLE IF EXISTS `user_lokasi`;
CREATE TABLE IF NOT EXISTS `user_lokasi` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `lokasi` varchar(150) DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.user_lokasi: ~3 rows (approximately)
/*!40000 ALTER TABLE `user_lokasi` DISABLE KEYS */;
REPLACE INTO `user_lokasi` (`ID`, `lokasi`, `alamat`, `status`) VALUES
	(2, 'PUSAT', 'jl. katineung', 'Client'),
	(5, 'CABANG 1', '', 'Client'),
	(6, 'CABANG 2', '', 'Client');
/*!40000 ALTER TABLE `user_lokasi` ENABLE KEYS */;


-- Dumping structure for table putridb.user_oto_area
DROP TABLE IF EXISTS `user_oto_area`;
CREATE TABLE IF NOT EXISTS `user_oto_area` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `userid` varchar(100) NOT NULL DEFAULT '',
  `lokasi` varchar(100) NOT NULL DEFAULT '',
  `c` enum('N','Y') DEFAULT 'N',
  PRIMARY KEY (`lokasi`,`userid`),
  UNIQUE KEY `id` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.user_oto_area: ~2 rows (approximately)
/*!40000 ALTER TABLE `user_oto_area` DISABLE KEYS */;
REPLACE INTO `user_oto_area` (`ID`, `userid`, `lokasi`, `c`) VALUES
	(8, 'kasir', '2', 'Y'),
	(7, 'kasir', '5', 'N');
/*!40000 ALTER TABLE `user_oto_area` ENABLE KEYS */;


-- Dumping structure for table putridb.v_dept_trans
DROP TABLE IF EXISTS `v_dept_trans`;
CREATE TABLE IF NOT EXISTS `v_dept_trans` (
  `ID_Dept` int(10) NOT NULL DEFAULT '0',
  `ID_Klas` int(10) DEFAULT NULL,
  `ID_SubKlas` int(10) DEFAULT NULL,
  `ID_Perkiraan` int(10) NOT NULL DEFAULT '0',
  `ID_Bulan` int(10) NOT NULL DEFAULT '0',
  `ID_Tahun` int(10) NOT NULL DEFAULT '0',
  `SaldoAwal` double DEFAULT '0',
  `Kredit` double DEFAULT '0',
  `Debet` double DEFAULT '0',
  PRIMARY KEY (`ID_Perkiraan`,`ID_Dept`,`ID_Bulan`,`ID_Tahun`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='summary transaksi by simpanan by departemen';

-- Dumping data for table putridb.v_dept_trans: 0 rows
/*!40000 ALTER TABLE `v_dept_trans` DISABLE KEYS */;
/*!40000 ALTER TABLE `v_dept_trans` ENABLE KEYS */;


-- Dumping structure for table putridb.v_neraca
DROP TABLE IF EXISTS `v_neraca`;
CREATE TABLE IF NOT EXISTS `v_neraca` (
  `ID_Head` int(10) DEFAULT NULL,
  `ID_Jenis` int(10) DEFAULT NULL,
  `ID_SubJenis` int(10) NOT NULL DEFAULT '0',
  `SubJenis` varchar(200) DEFAULT NULL,
  `ID_Calc` int(10) DEFAULT NULL,
  `ID_KBR` int(10) DEFAULT NULL,
  `ID_USP` int(10) DEFAULT NULL,
  `Debet` double DEFAULT '0',
  `Kredit` double DEFAULT '0',
  `SaldoAwal` double DEFAULT '0',
  `SaldoAkhir` double DEFAULT '0',
  PRIMARY KEY (`ID_SubJenis`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='membentuk laporan neraca';

-- Dumping data for table putridb.v_neraca: 0 rows
/*!40000 ALTER TABLE `v_neraca` DISABLE KEYS */;
/*!40000 ALTER TABLE `v_neraca` ENABLE KEYS */;


-- Dumping structure for table putridb.v_neraca_lajur
DROP TABLE IF EXISTS `v_neraca_lajur`;
CREATE TABLE IF NOT EXISTS `v_neraca_lajur` (
  `ID_Dept` varchar(250) NOT NULL DEFAULT '',
  `SaldoAwal` double DEFAULT '0',
  `Simp_Pokok` double DEFAULT '0',
  `Simp_Wajib` double DEFAULT '0',
  `Simp_Khusus` double DEFAULT '0',
  `Barang` double DEFAULT '0',
  `Pinjaman` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Dept`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.v_neraca_lajur: 0 rows
/*!40000 ALTER TABLE `v_neraca_lajur` DISABLE KEYS */;
/*!40000 ALTER TABLE `v_neraca_lajur` ENABLE KEYS */;


-- Dumping structure for table putridb.v_superuser_neraca_lajur
DROP TABLE IF EXISTS `v_superuser_neraca_lajur`;
CREATE TABLE IF NOT EXISTS `v_superuser_neraca_lajur` (
  `ID_Dept` varchar(250) NOT NULL DEFAULT '',
  `SaldoAwal` double DEFAULT '0',
  `Simp_Pokok` double DEFAULT '0',
  `Simp_Wajib` double DEFAULT '0',
  `Simp_Khusus` double DEFAULT '0',
  `Barang` double DEFAULT '0',
  `Pinjaman` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Dept`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.v_superuser_neraca_lajur: 0 rows
/*!40000 ALTER TABLE `v_superuser_neraca_lajur` DISABLE KEYS */;
/*!40000 ALTER TABLE `v_superuser_neraca_lajur` ENABLE KEYS */;


-- Dumping structure for table putridb.z_inv_konversi
DROP TABLE IF EXISTS `z_inv_konversi`;
CREATE TABLE IF NOT EXISTS `z_inv_konversi` (
  `ID` int(11) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `ID_Source` int(11) DEFAULT NULL,
  `Jml_Source` smallint(6) DEFAULT NULL,
  `ID_Dest` int(11) DEFAULT NULL,
  `Jml_Dest` smallint(6) DEFAULT NULL,
  `ID_Post` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.z_inv_konversi: 0 rows
/*!40000 ALTER TABLE `z_inv_konversi` DISABLE KEYS */;
/*!40000 ALTER TABLE `z_inv_konversi` ENABLE KEYS */;


-- Dumping structure for table putridb.z_inv_pemakaian
DROP TABLE IF EXISTS `z_inv_pemakaian`;
CREATE TABLE IF NOT EXISTS `z_inv_pemakaian` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Tanggal` datetime DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `ID_Barang` int(11) DEFAULT NULL,
  `Jumlah` smallint(6) DEFAULT NULL,
  `Harga` float DEFAULT NULL,
  `Keterangan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.z_inv_pemakaian: 0 rows
/*!40000 ALTER TABLE `z_inv_pemakaian` DISABLE KEYS */;
/*!40000 ALTER TABLE `z_inv_pemakaian` ENABLE KEYS */;


-- Dumping structure for table putridb.z_inv_pemakaian_jenis
DROP TABLE IF EXISTS `z_inv_pemakaian_jenis`;
CREATE TABLE IF NOT EXISTS `z_inv_pemakaian_jenis` (
  `ID` int(11) DEFAULT NULL,
  `JenisPakai` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.z_inv_pemakaian_jenis: 0 rows
/*!40000 ALTER TABLE `z_inv_pemakaian_jenis` DISABLE KEYS */;
/*!40000 ALTER TABLE `z_inv_pemakaian_jenis` ENABLE KEYS */;


-- Dumping structure for table putridb.z_t_inv_konversi
DROP TABLE IF EXISTS `z_t_inv_konversi`;
CREATE TABLE IF NOT EXISTS `z_t_inv_konversi` (
  `ID` int(11) DEFAULT NULL,
  `ID_Source` int(11) DEFAULT NULL,
  `ID_Dest` int(11) DEFAULT NULL,
  `Jml_Dest` smallint(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table putridb.z_t_inv_konversi: 0 rows
/*!40000 ALTER TABLE `z_t_inv_konversi` DISABLE KEYS */;
/*!40000 ALTER TABLE `z_t_inv_konversi` ENABLE KEYS */;


-- Dumping structure for trigger putridb.mst_kas_t_del
DROP TRIGGER IF EXISTS `mst_kas_t_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `mst_kas_t_del` AFTER DELETE ON `mst_kas_harian` FOR EACH ROW BEGIN
	delete from mst_kas_trans where id_trans=old.no_trans;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.mst_kas_t_new
DROP TRIGGER IF EXISTS `mst_kas_t_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `mst_kas_t_new` AFTER INSERT ON `mst_kas_harian` FOR EACH ROW BEGIN
	insert into mst_kas_trans (id_trans,id_kas,tgl_trans,uraian_trans,saldo_kas)
	values(New.no_trans,new.id_kas,new.tgl_kas,'Saldo Awal hari ini',new.sa_kas);
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.pembelian_del
DROP TRIGGER IF EXISTS `pembelian_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `pembelian_del` AFTER DELETE ON `inv_pembelian_detail` FOR EACH ROW BEGIN
	delete from inv_pembelian_rekap where ID=OLD.ID;
	update inv_pembelian set ID_Bayar=(ID_Bayar-(OLD.Jumlah*OLD.Harga_Beli)) where
	ID=OLD.ID_Beli;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.pembelian_new
DROP TRIGGER IF EXISTS `pembelian_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `pembelian_new` AFTER INSERT ON `inv_pembelian_detail` FOR EACH ROW BEGIN
	insert into inv_pembelian_rekap select * from inv_pembelian_detail where ID=New.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.pembelian_upd
DROP TRIGGER IF EXISTS `pembelian_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `pembelian_upd` AFTER UPDATE ON `inv_pembelian_detail` FOR EACH ROW BEGIN
	update inv_pembelian_rekap set jml_faktur=new.jml_faktur,jumlah=new.jumlah,
	harga_beli=round(new.jumlah/new.jml_faktur,-1)
	where id=Old.ID;
	
	/*otomatis update field ID_Bayar)
	update inv_pembelian set ID_Bayar=(ID_Bayar-OLD.Jumlah) where ID=NEW.ID_Beli;
	*/
	update inv_pembelian set ID_Bayar=(ID_Bayar+NEW.Jumlah) where ID=NEW.ID_Beli;

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.pembelian_upd_bfr
DROP TRIGGER IF EXISTS `pembelian_upd_bfr`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `pembelian_upd_bfr` BEFORE UPDATE ON `inv_pembelian_detail` FOR EACH ROW BEGIN
 UPDATE inv_pembelian set ID_Bayar=(ID_Bayar-OLD.Jumlah)
 WHERE ID=OLD.ID_Beli;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.penjualan_del
DROP TRIGGER IF EXISTS `penjualan_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_del` AFTER DELETE ON `inv_penjualan_detail` FOR EACH ROW BEGIN
	delete from inv_penjualan_rekap where ID=OLD.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.penjualan_del_header
DROP TRIGGER IF EXISTS `penjualan_del_header`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_del_header` AFTER DELETE ON `inv_penjualan` FOR EACH ROW BEGIN
	delete from inv_penjualan_detail where ID_Jual=OLD.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.penjualan_new
DROP TRIGGER IF EXISTS `penjualan_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_new` AFTER INSERT ON `inv_penjualan_detail` FOR EACH ROW BEGIN
	insert into inv_penjualan_rekap
	(ID,ID_Jenis,Tanggal,Bulan,Tahun,ID_Jual,ID_Barang,Jumlah,Harga,Keterangan,no_transaksi)
	values(  
	(select ID from inv_penjualan_detail where ID=NEW.ID),
	(select ID_Jenis from inv_penjualan_detail where ID=NEW.ID),
	(select Tanggal from inv_penjualan where ID=NEW.ID_Jual),
	(select Bulan from inv_penjualan where ID=NEW.ID_Jual),
	(select Tahun from inv_penjualan where ID=NEW.ID_Jual),
	(select ID_Jual from inv_penjualan_detail where ID=NEW.ID),
	(select ID_Barang from inv_penjualan_detail where ID=NEW.ID),
	(select Jumlah from inv_penjualan_detail where ID=NEW.ID),
	(select Harga from inv_penjualan_detail where ID=NEW.ID),
	(select ID_Jenis from inv_penjualan where ID=NEW.ID_Jual)&
	(select Nomor from inv_penjualan where ID=NEW.ID_Jual),
	(select NoUrut from inv_penjualan where ID=NEW.ID_Jual)
	);

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.penjualan_upd
DROP TRIGGER IF EXISTS `penjualan_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_upd` AFTER UPDATE ON `inv_penjualan_detail` FOR EACH ROW BEGIN
update inv_penjualan_rekap set jumlah=new.jumlah,ID_Jenis=NEW.ID_Jenis
where id=NEW.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.penjualan_upd_header
DROP TRIGGER IF EXISTS `penjualan_upd_header`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_upd_header` AFTER UPDATE ON `inv_penjualan` FOR EACH ROW BEGIN
	update inv_penjualan_detail set ID_Jenis=NEW.ID_Jenis
	where ID_Jual=NEW.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.transaksi_tmp_del
DROP TRIGGER IF EXISTS `transaksi_tmp_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `transaksi_tmp_del` AFTER DELETE ON `transaksi_temp` FOR EACH ROW BEGIN
/* data yang di delete akan di simpan secara otomatis ke table transaksi log*/
	INSERT INTO transaksi_log 
	(ID_Trans,Keterangan,old_val,new_val,created_by)
	VALUES
	(OLD.ID_Perkiraan,concat('Delete ', OLD.Keterangan),OLD.Debet,OLD.Kredit,(SELECT UUID_SHORT()));

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.transaksi_tmp_upd
DROP TRIGGER IF EXISTS `transaksi_tmp_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `transaksi_tmp_upd` AFTER UPDATE ON `transaksi_temp` FOR EACH ROW BEGIN
/* data yang di update akan di simpan secara otomatis ke table transaksi log*/
	INSERT INTO transaksi_log 
	(ID_Trans,Keterangan,old_val,new_val,created_by)
	VALUES
	(OLD.ID_Perkiraan,concat('Update ', OLD.Keterangan),OLD.Debet,OLD.Kredit,NEW.Created_by);

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_alamat_new
DROP TRIGGER IF EXISTS `t_alamat_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_alamat_new` AFTER INSERT ON `mst_anggota` FOR EACH ROW BEGIN
	replace into mst_kota(kota_anggota) values(New.Kota);
	replace into mst_propinsi(prop_anggota) values(NEW.Propinsi);
	/*buat akun perkiraan
	 akun Simp.Pokok
	*/
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='1'),
		(select ID_SubKlas from jenis_simpanan where ID='1'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='1'),
		(select ID_Laporan from jenis_simpanan where ID='1'),
		(select ID_LapDetail from jenis_simpanan where ID='1'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='1'),
		'1','0','0') ;
  /*Simp.Wajib  */
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='2'),
		(select ID_SubKlas from jenis_simpanan where ID='2'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='2'),
		(select ID_Laporan from jenis_simpanan where ID='2'),
		(select ID_LapDetail from jenis_simpanan where ID='2'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='2'),
		'2','0','0') ;
  /*Simp.Khusus  */
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='3'),
		(select ID_SubKlas from jenis_simpanan where ID='3'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='3'),
		(select ID_Laporan from jenis_simpanan where ID='3'),
		(select ID_LapDetail from jenis_simpanan where ID='3'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='3'),
		'3','0','0') ;
 
  /*Pinjaman,Barang  */
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='4'),
		(select ID_SubKlas from jenis_simpanan where ID='4'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='4'),
		(select ID_Laporan from jenis_simpanan where ID='4'),
		(select ID_LapDetail from jenis_simpanan where ID='4'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='4'),
		'4','0','0') ;
 
  /*Barang  */
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='5'),
		(select ID_SubKlas from jenis_simpanan where ID='5'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='5'),
		(select ID_Laporan from jenis_simpanan where ID='5'),
		(select ID_LapDetail from jenis_simpanan where ID='5'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='5'),
		'5','0','0') ;


END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_alamat_upd
DROP TRIGGER IF EXISTS `t_alamat_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_alamat_upd` AFTER UPDATE ON `mst_anggota` FOR EACH ROW BEGIN
	update mst_kota set kota_anggota=New.Kota where kota_anggota=OLD.Kota;
	update mst_propinsi set prop_anggota=NEW.Propinsi where porp_anggota=OLD.Propinsi;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_barang_del
DROP TRIGGER IF EXISTS `t_barang_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_barang_del` AFTER DELETE ON `inv_barang` FOR EACH ROW BEGIN
	delete from inv_konversi where id_barang=old.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_barang_new
DROP TRIGGER IF EXISTS `t_barang_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_barang_new` AFTER INSERT ON `inv_barang` FOR EACH ROW BEGIN
 insert into inv_konversi (id_barang,nm_barang,nm_satuan,sat_beli,isi_konversi) 
 values(NEW.ID,NEW.Nama_Barang,NEW.ID_Satuan,NEW.ID_Satuan,'1');
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_barang_upd
DROP TRIGGER IF EXISTS `t_barang_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_barang_upd` AFTER UPDATE ON `inv_barang` FOR EACH ROW BEGIN
	update inv_konversi set nm_barang=New.Nama_Barang,nm_satuan=New.ID_Satuan,
	sat_beli=New.ID_Satuan
	where ID_Barang=OLD.ID and
	sat_beli=OLD.ID_Satuan;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_pinjaman_del
DROP TRIGGER IF EXISTS `t_pinjaman_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_pinjaman_del` AFTER DELETE ON `pinjaman` FOR EACH ROW BEGIN
	delete from pinjaman_bayar where ID_pinjaman=OLD.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_pinjaman_new
DROP TRIGGER IF EXISTS `t_pinjaman_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_pinjaman_new` AFTER INSERT ON `pinjaman` FOR EACH ROW BEGIN
insert into pinjaman_bayar (
  ID_pinjaman,ID_Agt,ID_Bulan,Tahun,Debet,saldo,keterangan) (
	select ID,ID_Agt,ID_Bulan,Tahun,pinjaman,pinjaman,keterangan
	from pinjaman where ID=NEW.ID);
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_pinjaman_upd
DROP TRIGGER IF EXISTS `t_pinjaman_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_pinjaman_upd` AFTER UPDATE ON `pinjaman` FOR EACH ROW BEGIN
	replace into pinjaman_bayar (
  	ID_pinjaman,ID_Agt,ID_Bulan,Tahun,Debet,saldo,keterangan) (
	select ID,ID_Agt,ID_Bulan,Tahun,pinjaman,pinjaman,keterangan
	from pinjaman where ID=OLD.ID);

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_setup_simpanan_log
DROP TRIGGER IF EXISTS `t_setup_simpanan_log`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_setup_simpanan_log` AFTER UPDATE ON `setup_simpanan` FOR EACH ROW BEGIN
insert into set_simpanan_log  select * from setup_simpanan where id_simpanan=OLD.id_simpanan;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_SimpSumDept_new
DROP TRIGGER IF EXISTS `t_SimpSumDept_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_SimpSumDept_new` AFTER INSERT ON `transaksi_new` FOR EACH ROW begin
	/*update table v_dept_trans (rekap transaksi per departemen)*/
end//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_transaksi_del
DROP TRIGGER IF EXISTS `t_transaksi_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_transaksi_del` AFTER DELETE ON `transaksi` FOR EACH ROW begin
/* 
jika data pada tabel transaksi di hapus otomatis data pada tabel transaksi new 
akan terhapus juga dan data yang di delete akan di simpan secara otomatis ke table transaksi log
dan jika no_perkiraan sesuai dengan di table temp stat akan kembali ke 0*/
delete from transaksi_new where ID=OLD.ID;
insert into transaksi_log (ID_trans,Keterangan,old_val,new_val) values(OLD.ID_Jurnal,concat('Delete ',OLD.Keterangan),OLD.Debet,OLD.Kredit);
update transaksi_temp set ID_stat='0' where ID_Perkiraan=OLD.ID_Perkiraan;
end//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_transaksi_new
DROP TRIGGER IF EXISTS `t_transaksi_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_transaksi_new` AFTER INSERT ON `transaksi` FOR EACH ROW begin
/* jika ada data baru di tabel transaksi akan tersimpan juga di table traksaksi new
Tabel transaksi new digunakan untuk mempermudah dan mempersingkat loading data*/

INSERT into transaksi_new 
	(ID,ID_Jurnal,ID_Perkiraan,ID_Dept,Debet,Kredit,Keterangan,
	 ID_Unit,ID_Tipe,Tanggal,ID_Bulan,Tahun,NoUrut,Nomor,Ket,ID_Mark)
	values
	(New.ID,New.ID_Jurnal,New.ID_Perkiraan,New.ID_Dept,
	New.Debet,New.Kredit,New.Keterangan,
	(select ID_Unit from jurnal where ID=new.ID_Jurnal),
	(select ID_Tipe from jurnal where ID=new.ID_Jurnal),
	(select Tanggal from jurnal where ID=new.ID_Jurnal),
	(select ID_Bulan from jurnal where ID=new.ID_Jurnal),
	(select Tahun from jurnal where ID=new.ID_Jurnal),
	(select NoUrut from jurnal where ID=new.ID_Jurnal),
	(select Nomor from jurnal where ID=new.ID_Jurnal),
	(select Keterangan from jurnal where ID=new.ID_Jurnal),
	(select ID_Mark from jurnal where ID=new.ID_Jurnal)
	);
	
end//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_transaksi_new_del
DROP TRIGGER IF EXISTS `t_transaksi_new_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_transaksi_new_del` AFTER DELETE ON `transaksi_new` FOR EACH ROW BEGIN
/* data yang di delete akan di simpan secara otomatis ke table transaksi_del
untuk keperluan restore jika diperlukan
*/
insert into transaksi_del select * from transaksi_new where ID=OLD.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_transaksi_upd
DROP TRIGGER IF EXISTS `t_transaksi_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_transaksi_upd` AFTER UPDATE ON `transaksi` FOR EACH ROW begin
/* 
	Jika table transaksi mengalami update akan otomatis data yang sama di table
	transaksi_new juga akan otomatis ter update
*/
replace into transaksi_new 
	(ID,ID_Jurnal,ID_Perkiraan,ID_Dept,Debet,Kredit,Keterangan,
	 ID_Unit,ID_Tipe,Tanggal,ID_Bulan,Tahun,NoUrut,Nomor,Ket,ID_Mark)
	values
	(New.ID,New.ID_Jurnal,New.ID_Perkiraan,New.ID_Dept,
	New.Debet,New.Kredit,New.Keterangan,
	(select ID_Unit from jurnal where ID=new.ID_Jurnal),
	(select ID_Tipe from jurnal where ID=new.ID_Jurnal),
	(select Tanggal from jurnal where ID=new.ID_Jurnal),
	(select ID_Bulan from jurnal where ID=new.ID_Jurnal),
	(select Tahun from jurnal where ID=new.ID_Jurnal),
	(select NoUrut from jurnal where ID=new.ID_Jurnal),
	(select Nomor from jurnal where ID=new.ID_Jurnal),
	(select Keterangan from jurnal where ID=new.ID_Jurnal),
	(select ID_Mark from jurnal where ID=new.ID_Jurnal)
	);
insert into transaksi_log (ID_trans,Keterangan,old_val,new_val) values(OLD.ID_Jurnal,'Hapus',OLD.Debet,OLD.Kredit);	
end//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_update_stat_pinjaman
DROP TRIGGER IF EXISTS `t_update_stat_pinjaman`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_update_stat_pinjaman` AFTER INSERT ON `pinjaman_bayar` FOR EACH ROW BEGIN

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_v_neraca_del
DROP TRIGGER IF EXISTS `t_v_neraca_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_v_neraca_del` AFTER DELETE ON `lap_subjenis` FOR EACH ROW BEGIN
	delete from v_neraca where ID=OLD.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_v_neraca_new
DROP TRIGGER IF EXISTS `t_v_neraca_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_v_neraca_new` AFTER INSERT ON `lap_subjenis` FOR EACH ROW BEGIN
	replace into v_neraca (ID_Head,ID_Jenis,ID_SubJenis,SubJenis,ID_Calc,ID_KBR,ID_USP) 
	select ID_Lap,ID_Jenis,ID,SubJenis,ID_Calc,ID_KBR,ID_USP
	from lap_subjenis where ID=new.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger putridb.t_v_neraca_upd
DROP TRIGGER IF EXISTS `t_v_neraca_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_v_neraca_upd` AFTER UPDATE ON `lap_subjenis` FOR EACH ROW BEGIN
	replace into v_neraca (ID_Head,ID_Jenis,ID_SubJenis,SubJenis,ID_Calc,ID_KBR,ID_USP) 
	select ID_Lap,ID_Jenis,ID,SubJenis,ID_Calc,ID_KBR,ID_USP
	from lap_subjenis where ID=new.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;