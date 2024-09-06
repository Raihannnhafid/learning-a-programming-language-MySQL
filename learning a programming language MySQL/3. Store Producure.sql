CREATE DATABASE belajar_Stored_Procedure;

SELECT*FROM umkm_jabar;

-- --------------------------------------------------------
-- 1. Membuat stored procedure
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE getAllData ()
BEGIN
	SELECT*FROM umkm_jabar;
END $$
DELIMITER ;

-- --------------------------------------------------------
-- 2. Memanggil stored procedure
CALL getAllData(); 
-- --------------------------------------------------------

-- --------------------------------------------------------
-- 3. Mengecek stored procedure
SHOW PROCEDURE STATUS;
-- --------------------------------------------------------

-- ---------------------------------------------------------
-- 4. Menghapus stored procedure
-- --------------------------------------------------------
DROP PROCEDURE getAllData;


-- ---------------------------------------------------------
-- 5. Membuat stored procedure dengan parameter
-- 5.1 Parameter IN
-- ---------------------------------------------------------
	DELIMITER //
	CREATE PROCEDURE getDataUMKM
    (
		IN nama_kab VARCHAR(100)
    )
	BEGIN
     SELECT * FROM umkm_jabar WHERE nama_kabupaten_kota = nama_kab;
    END//
    DELIMITER ;
    
    CALL getDataUMKM('KABUPATEN BANDUNG');
    
-- ----------------------------------------------------------------------------------
-- 5.2 Parameter OUT
-- Variabel untuk menyimpan/menampung nilai yang diberikan oleh stored procedure
-- -----------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE getTotalRow
(
	OUT jumlah_row INT
)
BEGIN
	SELECT COUNT(*) INTO jumlah_row FROM umkm_jabar;
END $$
DELIMITER ;

CALL getTotalRow(@jumlah_row);
SELECT @jumlah_row;

-- -------------------------------------------
-- 5.3 PARAMETER INOUT
-- -------------------------------------------
DELIMITER $$
CREATE PROCEDURE getTotalRow2
(
	INOUT kode_kab FLOAT
)
BEGIN
	SELECT COUNT(*) INTO kode_kab FROM umkm_jabar WHERE kode_kabupaten_kota = kode_kab;
END $$
DELIMITER ;

SET @kode_kab_kota= 3204;
CALL getTotalRow2(@kode_kab_kota);
SELECT @kode_kab_kota; 

-- -------------------------------------------------------
-- 6. Loop
-- --------------------------------------------------------
CREATE TABLE id_mahasiswa (id INT);

SELECT * FROM id_mahasiswa;
INSERT INTO id_mahasiswa VALUES (0);

DELIMITER $$
CREATE PROCEDURE getIDMahasiswa()
BEGIN
	DECLARE Counter INT;
    SET COUNTER = 1;
    WHILE Counter <= 100 DO
		INSERT INTO id_mahasiswa (id) VALUES(Counter);
        SET Counter = Counter + 1;
	END WHILE;
END $$
DELIMITER ; 

CALL getIDMahasiswa();
SELECT * FROM id_mahasiswa;

-- --------------------------------------------------------
-- 7. Conditional (IF/THEN)
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE test
(
	IN bilangan INT,
    OUT hasil VARCHAR(100)
)
BEGIN
	IF bilangan > 50 THEN SET hasil = 'lebih dari 50';
    ELSE SET hasil = 'kurang dari 50 ';
    END IF;
END $$
DELIMITER ;

CALL test (100, @hasil_test);
SELECT @hasil_test;