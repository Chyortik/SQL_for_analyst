/*1.	Создайте таблицу с мобильными телефонами, используя графический интерфейс. Заполните БД данными.
*/ 
CREATE TABLE `shop`.`sellphones` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NULL,
  `manufacturer` VARCHAR(45) NULL,
  `product_count` INT NULL,
  `price` DOUBLE NULL,
  PRIMARY KEY (`id`));

INSERT INTO `sellphones` 
VALUES 
(1,'iPhone X','Apple',3,75000),
(2,'iPhone 8 Pro','Apple',2,50000),
(3,'Galaxy s9','Samsung',5,46000),
(4,'Galaxy s10','Samsung',4,64000);


-- 2. 	Выведите название, производителя и цену для товаров, количество которых превышает 2

SELECT 
	product_name, manufacturer, price, product_count
FROM shop.sellphones
WHERE product_count > 2;

-- 3.  Выведите весь ассортимент товаров марки “Samsung”

SELECT *
FROM shop.sellphones
WHERE manufacturer = 'Samsung';