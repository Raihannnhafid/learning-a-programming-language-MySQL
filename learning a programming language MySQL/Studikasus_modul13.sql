CREATE DATABASE ds;

SELECT * FROM ds_salaries;

-- Apakah ada nilai null ?
SELECT * 
FROM ds_salaries 
WHERE work_year IS NULL;

-- Melihat ada job title apa aja
SELECT DISTINCT job_title
FROM ds_salaries
ORDER BY job_title;

-- Job title apa aja yang termasuk dengan title data analys
SELECT DISTINCT job_title
FROM ds_salaries
WHERE job_title LIKE '%data_analyst%'
ORDER BY job_title;

-- Berapa gaji rata2
SELECT (AVG (salary_in_usd) * 15494.85) / 12 AS salary_in_rupiah_mothly FROM ds_salaries; 

-- Berapa rata2 gaji data analyst berdasarkan experiance levennya
SELECT experience_level, 
	(AVG (salary_in_usd) * 15494.85) / 12 AS salary_in_rupiah_mothly 
FROM ds_salaries
GROUP BY experience_level;

-- Berapa rata2 gaji data analyst berdasarkan experiance level, employment dan job_title
SELECT experience_level, 
	employment_type,
    job_title,
	(AVG (salary_in_usd) * 15494.85) / 12 AS salary_in_rupiah_mothly 
FROM ds_salaries
GROUP BY experience_level,
	employment_type,
    job_title
ORDER BY experience_level,
	employment_type,
	job_title;
    
-- Negara dengan gaji full time dengan posisi data analyst, full time, exprience kerjanya entery level dan menengah / mid
SELECT company_location,
	job_title,
	AVG(salary_in_usd) AS avg_salary_in_usd
FROM ds_salaries
WHERE job_title LIKE '%data analyst%'
	AND employment_type = 'FT'
    AND experience_level IN ('MI', 'EN')
GROUP BY company_location,
	job_title
HAVING avg_salary_in_usd >= 2000;

-- Ditahun berapa keanikan gaji dari mind ke senior itu memiliki kenaikan gaji tertinggi ?
-- (untuk pekerjaan yang berkaitan dengan data analyst yang waktu penuh)

WITH ds_1 AS (
	SELECT work_year,
		AVG (salary_in_usd) sal_in_usd_ex
	FROM ds_salaries
    WHERE
		employment_type = 'FT'
        AND experience_level = 'EX'
        AND job_title LIKE '%data analyst%'
	GROUP BY work_year
), ds_2 AS (
SELECT work_year,
		AVG (salary_in_usd) sal_in_usd_mi
	FROM ds_salaries
    WHERE
		employment_type = 'FT'
        AND experience_level = 'MI'
        AND job_title LIKE '%data analyst%'
	GROUP BY work_year
), t_year AS (
	SELECT DISTINCT work_year
    FROM ds_salaries
) SELECT t_year.work_year,
	ds_1.sal_in_usd_ex,
    ds_2.sal_in_usd_mi,
    ds_1.sal_in_usd_ex - ds_2.sal_in_usd_mi differences 
FROM t_year
LEFT JOIN ds_1 ON ds_1.work_year = t_year.work_year
LEFT JOIN ds_2 ON ds_2.work_year = t_year.work_year;



