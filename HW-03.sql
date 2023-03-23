# Урок 3. SQL – выборка данных, сортировка, агрегатные функции
-- Условие:
-- Таблица для работы на слайде.
# Задание 1
-- 1.0 Для выполнения заданий создадим базу данных и таблицы в ней

create database HW_03;

use HW_03;

drop table if exists salespeople;
create table salespeople
(
    snum int,
    sname varchar(45),
    city varchar(45),
    comm varchar(45)
);

select * from salespeople;
insert into salespeople (snum, sname, city, comm)
values
(1001, 'Peel', 'London', '.12'),
(1002, 'Serres', 'San Jose', '.13'),
(1004, 'Motika', 'London', '.11'),
(1007, 'Rifkin', 'Barcelona', '.15'),
(1003, 'Axelrod', 'New York', '.10');


drop table if exists customers;
create table customers
(
    cnum int,
    cname varchar(45),
    city varchar(45),
    rating int,
    snum int
);

select * from customers;
insert into customers (cnum, cname, city, rating, snum)
values
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanni', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 200, 1002),
(2004, 'Grass', 'Berlin', 300, 1002),
(2006, 'Clemens', 'London', 100, 1001),
(2008, 'Cisneros', 'San Jose', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);


drop table if exists orders;
create table orders
(
    onum int,
    amt decimal(10, 2),
    odate date,
    cnum int,
    snum int
);

-- select FORMAT(GETDATE(), 'dd/mm/yyyy', 'en-us') as date;

select * from orders;
insert into orders (onum, amt, odate, cnum, snum)
values
(3001, 18.69, '1990-10-03', 2008, 1007),
(3003, 767.19, '1990-10-03', 2001, 1001),
(3002, 1900.10, '1990-10-03', 2007, 1004),
(3005, 5160.45, '1990-10-03', 2003, 1002),
(3006, 1098.16, '1990-10-03', 2008, 1007),
(3009, 1713.23, '1990-10-04', 2002, 1003),
(3007, 75.75, '1990-10-05', 2004, 1002),
(3008, 4723.00, '1990-10-05', 2006, 1001),
(3010, 1309.95, '1990-10-06', 2004, 1002),
(3011, 9891.88, '1990-10-06', 2006, 1001);

/* 1.1 Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке:
 city, sname, snum, comm. (к первой или второй таблице, используя SELECT)*/

select city, sname, snum, comm from salespeople;


/* 1.2 Напишите команду SELECT, которая вывела бы оценку(rating),
 сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”)*/

select rating, cname from customers
	where city = 'San Jose';

/* 1.3 Напишите запрос, который вывел бы значения snum всех продавцов 
из таблицы заказов без каких бы то ни было повторений.
(уникальные значения в “snum“ “Продавцы”) */

select distinct snum from orders;


/* 1/4 *. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются
 с буквы G. Используется оператор "LIKE": (“заказчики”)
 https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html*/

select * from customers
	where cname like 'G%';

/* 1.5 Напишите запрос, который может дать вам все заказы со значениями
суммы выше чем $1,000. (“Заказы”, “amt” - сумма)*/

select * from orders
	where amt > 1000;

/* 1.6 Напишите запрос который выбрал бы наименьшую сумму заказа.
(Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение) */

select min(amt) from orders;

/* 1.7 Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков,
у которых рейтинг больше 100 и они находятся не в Риме.*/

select * from customers
	where rating > 100 or not city = 'Rome';

# Задание 2
-- перенес скрипт создания таблицы из работы на семинаре

create table workers (
id int primary key auto_increment,
name varchar(50) not null,
surname varchar(50) not null,
speciality varchar(50) not null,
seniority int not null default(0),
salary int not null default(3000),
age int not null default(18)
);
insert into workers (name,surname,speciality,seniority,salary,age)
values
("Вася","Васькин","начальник",40,100000,60),
("Петя","Петькин","начальник",8,70000,30),
("Катя","Каткина","инженер",2,70000,25),
("Саша","Сашкин","инженер",12,50000,35),
("Иван","Иванов","рабочий",40,30000,59),
("Петр","Петров","рабочий",20,25000,40),
("Сидор","Сидоров","рабочий",10,20000,35),
("Антон","Антонов","рабочий",8,19000,28),
("Юра","Юркин","рабочий",5,15000,25),
("Максим","Воронин","рабочий",2,11000,22),
("Юра","Галкин","рабочий",3,12000,24),
("Люся","Люськина","уборщик",10,10000,49);

/* 2.1 Отсортируйте поле “зарплата” в порядке убывания и возрастания*/
-- возрастание
select * from workers
order by salary;

-- убывание
select * from workers
order by salary desc;

/* 2.2 ** Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк
с наибольшей заработной платой (возможен подзапрос)*/

select * from workers
order by salary
limit 5 offset 7;

/* 2.3 Выполните группировку всех сотрудников по специальности,
суммарная зарплата которых превышает 100000 */

select speciality,sum(salary) from workers
group by speciality
having sum(salary) > 10000;
