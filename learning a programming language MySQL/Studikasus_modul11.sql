CREATE DATABASE bs;

SELECT * FROM studentsperformance;

-- -------------------------------------
-- 1.Pertanyaan pertama
-- ------------------------------------
DELIMITER $$
CREATE PROCEDURE getAllStudents()
BEGIN
	SELECT * FROM studentsperformance;
END$$
DELIMITER ;

CALL getAllStudents;

-- --------------------------------------------
-- 2.Pertanyaan dua
-- --------------------------------------------
DELIMITER $$
CREATE PROCEDURE getDataGolonganSuku
(
	IN golongan_suku VARCHAR (50)
)
BEGIN
	SELECT * FROM studentsperformance WHERE race_or_ethnicity = golongan_suku;
END$$
DELIMITER ;

CALL getDataGolonganSuku('group A');

-- ------------------------------
-- 3a. Pertanyaan tiga a
-- ------------------------------
DELIMITER $$
CREATE PROCEDURE getDataRata2 
(
	OUT data_rata2 FLOAT
)
BEGIN
	SELECT AVG (studentsperformance.math_score) INTO data_rata2 FROM studentsperformance;
END $$
DELIMITER ;

CALL getDataRata2 (@data_rata2);
SELECT @data_rata2;

DROP PROCEDURE getDataRata2;

-- -------------------------------
-- 3b.Pertanyaan tiga b
-- ------------------------------
SELECT * FROM studentsperformance WHERE READING_SCORE > @data_rata2;

-- -------------------------------
-- 4. Pertanyaan empat
-- --------------------------------
DELIMITER $$
CREATE PROCEDURE getDataRata
(
	IN rata_jenis_gender VARCHAR (225), OUT data_rata2 FLOAT
)
BEGIN
	SELECT AVG (studentsperformance.math_score) INTO data_rata2 FROM studentsperformance
    WHERE gender = rata_jenis_gender;
END$$
DELIMITER ;

SET @jenis_gender = 'male';
CALL getDataRata(@jenis_gender, @data_rata2);
SELECT @jenis_gender,@data_rata2;

DROP PROCEDURE getDataRata;

-- -----------------------------
-- 5. Pertanyaan kelima
-- -----------------------------
CREATE TABLE id_buku (id INT);

SELECT * FROM id_buku;
INSERT INTO id_buku VALUES (0);

DELIMITER $$
CREATE PROCEDURE buatidbukuku()
BEGIN
		DECLARE Counter INT;
        SET
			Counter = 0;
		WHILE Counter <=  5 DO
			INSERT INTO id_buku (id) VALUES (Counter);
		SET
        Counter = Counter + 1;
        END WHILE;
END$$
DELIMITER ;

CALL buatidbukuku();
SELECT * FROM id_buku;

-- ------------------------------
-- 6. Pertanyaan enam
-- ------------------------------
DELIMITER $$
CREATE PROCEDURE menghitung_luas
(
	IN jenis_bangun_datar VARCHAR(200),
    IN x FLOAT,
    IN y FLOAT,
    OUT hasil_luas FLOAT,
    OUT keterangan VARCHAR(200)
)
BEGIN
	CASE
        WHEN jenis_bangun_datar = 'segitiga' THEN SET hasil_luas = 0.5 * x * y, keterangan = 'Perhitungan berhasil!';
        WHEN jenis_bangun_datar = 'persegi panjang' THEN SET hasil_luas = x * y, keterangan = 'Perhitungan berhasil!';
        ELSE SET hasil_luas = NULL ; SET keterangan = 'Perhitungan gagal. Bangun datar tidak didukung';
    END CASE;
END$$
DELIMITER ;

SET @jenis_bangun_datar = 'segitiga';-- atau SET @jenis_bangun_datar = 'persegi panjang'
SET @x = 10 ; -- atau angka berapapun, jenis data FLOAT
SET @y = 20 ; -- atau angka berapapun, jenis data FLOAT

CALL menghitung_luas(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
SELECT @jenis_bangun_datar, @x, @y, @luas, @keterangan;

-- Persegi panjang
SET @jenis_bangun_datar = 'persegi panjang';-- atau SET @jenis_bangun_datar = 'persegi panjang'
SET @x = 10 ; -- atau angka berapapun, jenis data FLOAT
SET @y = 20 ; -- atau angka berapapun, jenis data FLOAT

CALL menghitung_luas(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
SELECT @jenis_bangun_datar, @x, @y, @luas, @keterangan;

-- Lingkarang
SET @jenis_bangun_datar = 'lingkaran';-- atau SET @jenis_bangun_datar = 'persegi panjang'
SET @x = 10 ; -- atau angka berapapun, jenis data FLOAT
SET @y = 20 ; -- atau angka berapapun, jenis data FLOAT

CALL menghitung_luas(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
SELECT @jenis_bangun_datar, @x, @y, @luas, @keterangan;


