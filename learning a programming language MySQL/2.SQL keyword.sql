CREATE DATABASE belajar_keyword;

SELECT * FROM sales;

SELECT quantity,
SUM(total_amount) total,
AVG(total_amount) rerata
FROM sales
GROUP BY 1;

-- Soal nomer 3
SELECT quantity, total_amount,
CASE WHEN total_amount <=100 and quantity = '1-2' THEN 'Low'
	WHEN total_amount = '101-300' and quantity = '3-5' THEN 'Medium'
    WHEN total_amount >300 and quantity >5 THEN 'High'
END customer_category
FROM sales;

-- Soal nomer 1
SELECT sale_date, total_amount,
	AVG(total_amount) OVER() rerata_order
FROM sales;

-- Soal nomer 2
SELECT customer_id , 
	total_amount,
	RANK() OVER( ORDER BY total_amount DESC) rank_hasil
FROM sales;
    
SELECT sale_date, quantity, total_amount,
	SUM(quantity) OVER(PARTITION BY quantity ORDER BY sale_date 
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as total
FROM sales
ORDER BY quantity, total_amount;


