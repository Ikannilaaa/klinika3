CREATE DATABASE klinika3;

CREATE TABLE pegawai(
	pegawai_ID INT NOT NULL PRIMARY KEY,
	nama VARCHAR(30) NOT NULL,
	alamat VARCHAR(75) NOT NULL,
	jabatan VARCHAR(30) NOT NULL,
	tgl_lahir DATE NOT NULL, /*YYYY-MM-DD*/
	email VARCHAR(50) NOT NULL,
	telepon VARCHAR(15) NOT NULL,
	jenis_kelamin CHAR(2) NOT null
);

CREATE TABLE pasien(
	pasien_ID INT NOT NULL PRIMARY KEY,
	nama VARCHAR(30) NOT NULL,
	tgl_lahir DATE NOT NULL,
	wali VARCHAR(30) NOT NULL,
	alamat VARCHAR(75) NOT NULL,
	telepon VARCHAR(15) NOT NULL
);

CREATE TABLE spesialis(
	spesialis_ID INT NOT NULL PRIMARY KEY,
	jenis VARCHAR(30) NOT NULL,
	deksripsi VARCHAR(100) NOT NULL
);

CREATE TABLE dokter(
	dokter_ID INT NOT NULL PRIMARY KEY,
	spesialis_ID INT NOT NULL,
	nama VARCHAR(30) NOT NULL,
	jenis_kelamin CHAR(2) NOT NULL,
	alamat VARCHAR(75) NOT NULL,
	email VARCHAR(50) NOT NULL,
	telepon VARCHAR(15) NOT NULL,
	biaya DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (spesialis_ID) REFERENCES spesialis(spesialis_ID)
);

CREATE TABLE obat(
	obat_ID INT NOT NULL PRIMARY KEY,
	nama VARCHAR(30) NOT NULL,
	jenis VARCHAR(30) NOT NULL,
	merk VARCHAR(30) NOT NULL,
	stok INT,
	harga DECIMAL(10,2) NOT null
);

CREATE TABLE rekam_medis(
	RM_ID INT PRIMARY KEY NOT NULL,
	dokter_ID INT NOT NULL,
	pasien_ID INT NOT NULL,
	tgl_rm DATE NOT NULL,
	tinggi_badan INT NOT NULL,
	berat_badan INT NOT NULL,
	tekanan_darah INT NOT NULL,
	keluhan VARCHAR(100) NOT NULL,
	tindakan VARCHAR(100) NOT NULL,
	FOREIGN KEY (dokter_ID) REFERENCES dokter(dokter_ID),
	FOREIGN KEY (pasien_ID) REFERENCES pasien(pasien_ID)
);

CREATE TABLE resep(
	resep_ID INT PRIMARY KEY NOT NULL,
	dokter_ID INT NOT NULL,
	pasien_ID INT NOT NULL,
	FOREIGN KEY (dokter_ID) REFERENCES dokter(dokter_ID),
	FOREIGN KEY (pasien_ID) REFERENCES pasien(pasien_ID)
);

CREATE TABLE resep_detail(
	RD_ID INT PRIMARY KEY NOT NULL,
	obat_ID INT NOT NULL,
	resep_ID INT NOT NULL,
	pegawai_ID INT NOT NULL,
	dosis INT NOT NULL,
	FOREIGN KEY (obat_ID) REFERENCES obat(obat_ID),
	FOREIGN KEY (resep_ID) REFERENCES resep(resep_ID),
	FOREIGN KEY (pegawai_ID) REFERENCES pegawai(pegawai_ID)
);

CREATE TABLE transaksi(
	transaksi_ID INT NOT NULL PRIMARY KEY,
	pegawai_ID INT NOT NULL,
	RD_ID INT, /*Bisa tidak diisi apabila pasien tidak dpt rujukan obat*/
	pasien_ID INT NOT NULL,
	dokter_ID INT NOT NULL,
	tgl_transaksi DATE NOT NULL,
	total_tagihan DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (pegawai_ID) REFERENCES pegawai(pegawai_ID),
	FOREIGN KEY (RD_ID) REFERENCES resep_detail(RD_ID),
	FOREIGN KEY (pasien_ID) REFERENCES pasien(pasien_ID),
	FOREIGN KEY (dokter_ID) REFERENCES dokter(dokter_ID)
);

INSERT INTO pegawai(pegawai_ID, nama, alamat, jabatan, tgl_lahir, email, telepon, jenis_kelamin)
VALUES
('1001', 'Michael Morales', 'Jalan Alam Sutera Boulevard Kav. 21', 'Direktur Utama', '1970-06-16', 'michaelmorales@gmail.com', '62919972169534', 'M'),
('1002', 'Tiffany Miller', 'Jalan Graha Raya Bintaro No. 38', 'Keuangan', '1976-06-22', 'tiffanymiller@gmail.com', '62918147302939', 'F'),
('1003', 'Brad Hartman', 'Jl. Boulevard Diponegoro No.105', 'Administrasi', '1973-08-04', 'bradhartman@gmail.com', '628066000666', 'M'),
('1004', 'Andre Jackson', 'Jl. KH Hasyim Ashari No.28F', 'Administrasi', '1980-10-07', 'andrejackson@gmail.com', '628065975430', 'M'),
('1005', 'Albert Prince', 'Jl. M.H. Thamrin Kav. Blok B7 01-06', 'Keuangan', '1975-07-24', 'albertprince@gmail.com', '628065600000', 'M'),
('1006', 'James Garcia', 'Jl. Pahlawan Seribu. Lot 12.A', 'Apotik', '1983-08-01', 'jamesgarcia@gmail.com', '628049653564', 'M'),
('1007', 'Chris Gregory', 'Jl. Pamulang Raya No.D2', 'Apotik', '1992-02-02',	'chrisgregory@gmail.com', '628049653548', 'M'),
('1008', 'Michelle Collins', 'Jl. Prof Sediyatmo No.1-A', 'Apotik', '1982-12-19',	'michellecollins@gmail.com', '628049653547', 'M'),
('1009', 'Allison Jones', 'Jl. Prof Sediyatmo No.2-D', 'Bagian Umum', '1976-04-21',	'allisonjones@gmail.com', '628049653521', 'F'),
('1010', 'Debra Miller', 'Jl. Raya Rawa Buntu No.27', 'Bagian Umum', '1984-07-29',	'debramiller@gmail.com', '628049653393', 'F'),
('1011', 'Gabriel Davidson', 'Jalan Casa No.170', 'Bagian Umum', '1995-01-06',	'gabrieldavidson@gmail.com', '628049653268', 'M'),
('1012', 'Timothy Reynolds', 'Jalan Cikini Raya No.75', 'Perawat', '1973-05-15',	'timothyreynolds@gmail.com', '628049653266', 'M'),
('1013', 'Alyssa Miller', 'Jalan Kebon Kacang Raya', 'Perawat', '1975-06-30',	'alyssamiller@gmail.com', '628049653234', 'F'),
('1014', 'Jennifer Wang', 'Jalan M. Khafi 1 No. 123', 'Perawat', '1993-02-18', 'jenniferwang@gmail.com', '628049653042', 'F'),
('1015', 'Amanda Stevens', 'Jalan Raya Joglo no 14', 'Bidan', '1975-06-11',	'amandastevens@gmail.com', '628049652867', 'F'),
('1016', 'Sandra Chen', 'Jl. Anggrek Cakra No 20', 'Bidan', '1984-06-03',	'sandrachen@gmail.com', '628049652857', 'F'),
('1017', 'Alicia Cooley', 'Jl. Arteri Pd. Indah', 'Bidan', '1991-04-06',	'aliciacooley@gmail.com', '628049652725', 'F'),
('1018', 'Taylor Best', 'Jl. Cempaka Putih Raya No.12B', 'Bidan', '1984-10-14',	'taylorbest@gmail.com', '628049652607', 'F'),
('1019', 'Jimmy Branch', 'Jl. Cideng Timur No. 59', 'Analis Laboratorium', '1970-09-22',	'jimmybranch@gmail.com', '628049652498', 'M'),
('1020', 'Chris Hughes', 'Jl. Cipete Raya No.2A', 'Perawat', '1987-02-28',	'chrishughes@gmail.com', '628049652445', 'M'),
('1021', 'Ian Murphy', 'Jl. Citra Garden VI', 'Analis Laboratorium', '1989-05-03', 'ianmurphy@gmail.com', '628049652445', 'M'),
('1022', 'Whitney Ramirez', 'Jl. Daan Mogot Raya No. 95C', 'Analis Laboratorium', '1993-03-14', 'whitneyramirez@gmail.com', '628049652198', 'F'),
('1023', 'Lindsay Elliott', 'Jl. Danau Sunter Utara No 2', 'Radiologi', '1987-11-11', 'lindsayelliott@gmail.com', '628049652156', 'F'),
('1024', 'Darren Andrews', 'Jl. Gading Kirana Timur IX No.49', 'Radiologi', '1976-12-19', 'darrenandrews@gmail.com', '628049577715', 'M'),
('1025', 'Elizabeth Morris', 'Jl. Gajahmada No. 211', 'Radiologi', '1985-07-24',	'elizabethmorris@gmail.com', '628049569558', 'F');

INSERT INTO pasien(pasien_ID, nama, tgl_lahir, wali, alamat, telepon)
VALUES
('2001', 'Sue Edwards', '1997-12-26', 'George Baker', 'Jl. H. R. Rasuna Said No.Kav. 22', '628048668939'),
('2002', 'Michael Santiago', '1988-01-05', 'Michael Santiago', 'Jl. H. R. Rasuna Said No.Kav. C-22', '628048664811'),
('2003', 'Lauren Mills', '1990-09-30', 'Deborah Pearson', 'Jl. Haji Baun No 46', '628048653961'),
('2004', 'Luis Barber', '1985-07-05', 'Kimberly Richardson', 'Jl. Jambore No. 14', '628048542442'),
('2005', 'Kenneth Alvarez', '1976-05-05', 'Kenneth Alvarez', 'Jl. Jend. Basuki Rachmat No.1A', '628048533260'),
('2006', 'Gregory Johnson', '2000-10-06', 'Angela Lester', 'Jl. Jend. Sudirman No.Kav 25', '628046640404'),
('2007', 'Misty Richards', '1999-04-10', 'Brittney York', 'Jl. Jend. Sudirman No.kav 29', '628045128807'),
('2008', 'Kimberly Richardson', '1987-06-27', 'Luis Barber', 'Jl. Jambore No. 14', '628045128775'),
('2009', 'Brittney York', '1998-02-02', 'Andrew Aguilar', 'Jl. Kalibata Raya No. 1', '628045128750'),
('2010', 'Stephanie Oliver', '1994-01-10', 'Richard Moore', 'Jl. Kebagusan 1 No 5', '628042297555');

INSERT INTO spesialis(spesialis_ID, jenis, deksripsi)
VALUES
('4001', 'Penyakit Dalam', 'Sp.PD, disebut juga dengan internis, dokter yang memiliki spesialisasi untuk mendiagnosis dan menangani sejumlah masalah kesehatan yang dialami pasien dewasa atau lansia.'),
('4002', 'Anak', 'Sp.A, disebut juga dengan pediatris, adalah dokter yang memiliki spesialisasi dalam mendiagnosis dan menangani pasien berusia 0–18 tahun.'),
('4003', 'Kandungan', 'Sp.OG, memiliki keahlian khusus di 2 bidang, yaitu keahlian seputar kehamilan dan proses melahirkan (obstetri) dan keahlian seputar kesehatan reproduksi (ginekologi).'),
('4004', 'THT', 'Sp.THT atau otolaringologis, adalah dokter yang memiliki spesialisasi untuk mendiagnosis, menangani, dan merawat penderita gangguan telinga, hidung, dan tenggorokan.'),
('4005', 'Psikiater', 'Menguasai ilmu kesehatan jiwa dan perilaku. Psikiater menangani masalah-masalah yang berhubungan dengan gangguan emosional, kejiwaan, dan perilaku pasien melalui konseling dan pengobatan.'),
('4006', 'Gigi', 'Dokter yang khusus menangani masalah kesehatan gigi dan mulut.'),
('4007', 'Umum', 'Dokter yang berfokus untuk menangani gejala dan penyakit pada pasien secara umum. Merupakan dokter layanan tingkat pertama yang berperan dalam memberikan pencegahan, diagnosis, penanganan awal, dan rujukan ke dokter spesialis jika diperlukan.');

INSERT INTO dokter(dokter_ID, spesialis_ID, nama, jenis_kelamin, alamat, email, telepon, biaya)
VALUES
('3001', (select spesialis_id from spesialis WHERE jenis = 'Umum'), 'Francisco Singh', 'M', 'Jl. Kembangan Raya No. 46', 'franciscosingh@gmail.com', '628042292888', '200000');

INSERT INTO dokter(dokter_ID, spesialis_ID, nama, jenis_kelamin, alamat, email, telepon, biaya)
VALUES
('3002', (select spesialis_id from spesialis WHERE jenis = 'Penyakit Dalam'), 'James Davis', 'M', 'Jl. Kesehatan Raya no. 7', 'jamesdavis@gmail.com', '628042198037', '250000'),
('3003', (select spesialis_id from spesialis WHERE jenis = 'Anak'), 'Terry Romero', 'M', 'jl. Letjen S. Parman No.28',	'terryromero@gmail.com', '628042151252', '150000'),
('3004', (select spesialis_id from spesialis WHERE jenis = 'Kandungan'), 'Brittney Gates', 'F', 'Jl. Lingkar Luar Selatan. No. 6', 'brittneygates@gmail.com', '628042136088', '400000'),
('3005', (select spesialis_id from spesialis WHERE jenis = 'THT'), 'Kenneth Mcmillan', 'M', 'Jl. M.H. Thamrin No.9',	'kennethmcmillan@gmail.com', '628042124293', '150000'),
('3006', (select spesialis_id from spesialis WHERE jenis = 'Psikiater'), 'Maria Ramirez', 'F', 'Jl. M.H. Thamrin No.Kav. 28-30',	'mariaramirez@gmail.com', '628042112211', '150000'),
('3007', (select spesialis_id from spesialis WHERE jenis = 'Gigi'), 'Pamela Norman', 'F', 'Jl. Margasatwa No.2',	'pamelanorman@gmail.com', '628042088686', '300000'),
('3008', (select spesialis_id from spesialis WHERE jenis = 'Penyakit Dalam'), 'Nicole Combs', 'F', 'Jl. Kesehatan Raya no. 7', 'nicolecombs@gmail.com', '628042024092', '350000'),
('3009', (select spesialis_id from spesialis WHERE jenis = 'Anak'), 'William Hines', 'M', 'Jl. Marina Raya No.2',	'williamhines@gmail.com', '628042017174', '200000'),
('3010', (select spesialis_id from spesialis WHERE jenis = 'Kandungan'), 'Dawn Smith', 'F', 'Jl. Pahlawan Revolusi No. 14 ',	'dawnsmith@gmail.com', '628042014000', '200000'),
('3011', (select spesialis_id from spesialis WHERE jenis = 'THT'), 'Alex Fowler', 'M', 'Jl. Pesanggrahan no.168',	'alexfowler@gmail.com', '628042010153', '100000'),
('3012', (select spesialis_id from spesialis WHERE jenis = 'Psikiater'), 'Daniel Kemp', 'M', 'Jl. Petogogan 1 no.21',	'danielkemp@gmail.com', '628041808777', '150000'),
('3013', (select spesialis_id from spesialis WHERE jenis = 'Gigi'), 'Jennifer Terry', 'F', 'Jl. Prof DR. Satrio No. 164',	'jenniferterry@gmail.com', '628041716035', '300000'),
('3014', (select spesialis_id from spesialis WHERE jenis = 'Umum'), 'Steven Lang', 'M', 'Jl. Rawamangun Muka Timur No.60',	'stevenlang@gmail.com', '628041714161', '100000');

INSERT INTO obat(obat_ID, nama, jenis, merk, stok, harga)
VALUES
('5001', 'Abacavir', 'Anti Virus', 'A', 100, '500000'), /*HIV*/
('5002', 'Abrocitinib', 'Imunosupresan', 'B', 150, '300000'), /*Dermatitik Atopik*/
('5003', 'Acarbose', 'Anti Diabetes', 'C', 50, '250000'), /*Diabetes*/
('5004', 'Basiliximab', 'Imunosupresan', 'D', 10, '1000000'), /*Transplatasi organ*/
('5005', 'Bifonazole', 'Anti Jamur', 'E', 200, '25000'), /*Jamur*/
('5006', 'Ceteme', 'Anti Alergi', 'F', 200, '5000'), /*Gejala Alergi*/
('5007', 'Clozapine', 'Anti Psikotik', 'G', 40, '150000'), /*Skizofrenia*/
('5008', 'Dextrose', 'Infus', 'H', 500, '50000'), /*Infus*/
('5009', 'Hydromorphone', 'Anti Nyeri', 'I', 30, '120000'),
('5010', 'Isradipine', 'Anti Hipertensi', 'J', 50, '130000'); /*Hipertensi*/

INSERT INTO resep(resep_ID, dokter_ID, pasien_ID)
VALUES
('6001', (select dokter_id from dokter WHERE dokter_ID = '3006'), (select pasien_id from pasien WHERE pasien_ID = '2001')); /*5007*/

INSERT INTO resep(resep_ID, dokter_ID, pasien_ID)
VALUES
('6002', (select dokter_id from dokter WHERE dokter_ID = '3014'), (select pasien_id from pasien WHERE pasien_ID = '2002')), /*5006*/
('6003', (select dokter_id from dokter WHERE dokter_ID = '3008'), (select pasien_id from pasien WHERE pasien_ID = '2003')), /*5001*/
('6004', (select dokter_id from dokter WHERE dokter_ID = '3013'), (select pasien_id from pasien WHERE pasien_ID = '2004')), /*5008*/
('6005', (select dokter_id from dokter WHERE dokter_ID = '3001'), (select pasien_id from pasien WHERE pasien_ID = '2005')); /*5005*/

INSERT INTO resep_detail(RD_ID, obat_ID, resep_ID, pegawai_ID, dosis)
VALUES
('7001', (select obat_id from obat WHERE obat_ID = '5006'), (select resep_id from resep WHERE resep_ID = '6002'), (select pegawai_id FROM pegawai WHERE pegawai_ID = '1003'), 50),
('7002', (select obat_id from obat WHERE obat_ID = '5001'), (select resep_id from resep WHERE resep_ID = '6003'), (select pegawai_id FROM pegawai WHERE pegawai_ID = '1004'), 20),
('7003', (select obat_id from obat WHERE obat_ID = '5008'), (select resep_id from resep WHERE resep_ID = '6004'), (select pegawai_id FROM pegawai WHERE pegawai_ID = '1003'), 10),
('7004', (select obat_id from obat WHERE obat_ID = '5005'), (select resep_id from resep WHERE resep_ID = '6005'), (select pegawai_id FROM pegawai WHERE pegawai_ID = '1004'), 90),
('7005', (select obat_id from obat WHERE obat_ID = '5007'), (select resep_id from resep WHERE resep_ID = '6001'), (select pegawai_id FROM pegawai WHERE pegawai_ID = '1004'), 100);

INSERT INTO rekam_medis(RM_ID, dokter_ID, pasien_ID, tgl_rm, tinggi_badan, berat_badan, tekanan_darah, keluhan, tindakan)
VALUES
('8001', (select dokter_id from dokter WHERE dokter_ID = '3014'), (select pasien_id from pasien WHERE pasien_ID = '2002'), '2023-06-03', 198, 70, 120, 'Asthma', 'Emergency'),
('8002', (select dokter_id from dokter WHERE dokter_ID = '3008'), (select pasien_id from pasien WHERE pasien_ID = '2003'), '2024-02-14', 156, 40, 111, 'Diabetes', 'Elective'),
('8003', (select dokter_id from dokter WHERE dokter_ID = '3013'), (select pasien_id from pasien WHERE pasien_ID = '2004'), '2023-06-20', 145, 65, 98, 'Arthritis', 'Urgent'), 
('8004', (select dokter_id from dokter WHERE dokter_ID = '3001'), (select pasien_id from pasien WHERE pasien_ID = '2005'), '2024-12-08', 178, 55, 110, 'Panic Attack', 'Emergency'),
('8005', (select dokter_id from dokter WHERE dokter_ID = '3006'), (select pasien_id from pasien WHERE pasien_ID = '2001'), '2023-10-10', 167, 49, 120, 'Cancer', 'Urgent');

INSERT INTO transaksi(transaksi_ID, pegawai_ID, RD_ID, dokter_ID, pasien_ID, tgl_transaksi, total_tagihan)
VALUES
('9001', (select pegawai_id FROM pegawai WHERE pegawai_ID = '1003'), (select RD_ID FROM resep_detail WHERE RD_ID = '7001'), (select dokter_id from dokter WHERE dokter_ID = '3014'), (select pasien_id from pasien WHERE pasien_ID = '2002'), '2023-06-03', 500000),
('9002', (select pegawai_id FROM pegawai WHERE pegawai_ID = '1004'), (select RD_ID FROM resep_detail WHERE RD_ID = '7002'), (select dokter_id from dokter WHERE dokter_ID = '3008'), (select pasien_id from pasien WHERE pasien_ID = '2003'), '2024-02-14', 350000),
('9003', (select pegawai_id FROM pegawai WHERE pegawai_ID = '1003'), (select RD_ID FROM resep_detail WHERE RD_ID = '7003'), (select dokter_id from dokter WHERE dokter_ID = '3013'), (select pasien_id from pasien WHERE pasien_ID = '2004'), '2023-06-20', 1000000), 
('9004', (select pegawai_id FROM pegawai WHERE pegawai_ID = '1004'), (select RD_ID FROM resep_detail WHERE RD_ID = '7004'), (select dokter_id from dokter WHERE dokter_ID = '3001'), (select pasien_id from pasien WHERE pasien_ID = '2005'), '2024-12-08', 755000),
('9005', (select pegawai_id FROM pegawai WHERE pegawai_ID = '1004'), (select RD_ID FROM resep_detail WHERE RD_ID = '7005'), (select dokter_id from dokter WHERE dokter_ID = '3006'), (select pasien_id from pasien WHERE pasien_ID = '2001'), '2023-10-10', 90000000);
