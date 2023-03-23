-- 1.Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными

create database HomeWork2;
use HomeWork2;

create table sales
(
    id int auto_increment primary key,
    order_date date,
    bucket varchar(45)
);

select * from sales;
insert into sales (order_date, bucket)
values
('2021-01-01','101 to 300'),
('2021-01-02','101 to 300'),
('2021-01-03','less tnen equal to 100'),
('2021-01-04','101 to 300'),
('2021-01-05','greater to 300');

-- 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.

select bucket,
case
    when bucket = 'less tnen equal to 100'
    	then 'маленький заказ'
    when bucket = '101 to 300'
    	then 'средний заказ'
    when bucket = 'greater to 300'
    	then 'большой заказ'
end as stasus
from sales;

-- 3.Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE

create table orders
(
	orderid int auto_increment primary key,
    employeeid varchar(3),
  	amount double,
  	orderstatus varchar(15)
);

select * from orders;
insert into orders (employeeid, amount, orderstatus)
values
('e03', 15, 'OPEN'),
('e01', 25.5, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED'),
('e04', 99.99, 'OPEN');

select orderid, amount, orderstatus,
case
	when orderstatus = 'OPEN'
    	then 'Order is in open state'
    when orderstatus = 'CLOSED'
    	then 'Order is closed'
   	when orderstatus = 'CANCELLED'
    	then 'Order is cancelled'
end as order_summary
from orders;

/*3. NULL отличается от 0 тем, что NULL не представляет никакое значение,
 то есть отсутствие какого-либо значения в поле, в то время как 0 представляет
 арифметическое значение нуля, то есть поле (ячейка) имеет данные.*/


