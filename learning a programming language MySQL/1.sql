CREATE DATABASE universitas;

CREATE TABLE dosen (
id_dosen VARCHAR(50),
nama_dosen VARCHAR(100),
program_studi VARCHAR(100),
PRIMARY KEY (id_dosen)
);

CREATE TABLE dosen (
id_dosen VARCHAR(50) PRIMARY KEY,
nama_dosen VARCHAR(100),
program_studi VARCHAR(100)
);

DESCRIBE dosen;

DROP TABLE dosen;

CREATE TABLE mahasiswa (
	id_mahasiswa VARCHAR (50),
	nama_mahasiswa VARCHAR (100),
    nama_programstd VARCHAR (100),
    id_dosen_wali VARCHAR (50),
    FOREIGN KEY (id_dosen_wali) REFERENCES dosen (id_dosen)
);

DESCRIBE mahasiswa;

SELECT * FROM dosen;

INSERT INTO universitas.dosen (id_dosen, nama_dosen, program_studi)
VALUES
	('J0303042018', 'Jono. ST', 'Teknik Mesin'),
    ('J0303042028', 'Joni. ST', 'Teknik Industri'),
    ('J0303042089', 'Jone. ST', 'Teknik Sipil'),
    ('J0303042070', 'Jons. ST', 'Manajamen');
    
-- ALTER TABLE
-- 1. Menambahkan kolom pada tabel
ALTER TABLE dosen ADD golongan_darah VARCHAR (3);

-- 2. Menghapus kolom pada tabel
ALTER TABLE dosen DROP COLUMN golongan_darah; 

-- 3. Mengubah nama kolom pada tabel
ALTER TABLE dosen CHANGE COLUMN id_dosen nomer_induk_dosen VARCHAR (50);

-- 4. Mengubah tipe data kolom pada tabel
DESCRIBE dosen;
ALTER TABLE dosen MODIFY COLUMN nama_dosen VARCHAR (200);
