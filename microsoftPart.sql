/**Create employee table**/
create table emp(EMPID int PRIMARY KEY NOT NULL,
 Ename varchar(20),
 Esurname varchar(20),
 Address varchar(65),
 Ejob varchar(25),
 zip int,
 sal money,
 country varchar(16));


/**Add data to EMP table**/
INSERT INTO EMP VALUES (123, 'Jason', 'Smith', 'Koszykowa, 52', 'CLERK', 89000, 5000, 'USA');
INSERT INTO EMP VALUES (222, 'Linus', 'Torvalds', 'California, 12', 'PROGRAMMER', 45646, 1236, 'Ukraine');
INSERT INTO EMP VALUES (312, 'Bill', 'Gates', 'Al. Lotnikow, 4', 'SYSADMIN', 57843, 1000, 'USA');
INSERT INTO EMP VALUES (412, 'Steve', 'Wozniak', 'Dolna, 99', 'MECHANIC', 32467, 7453, 'Poland');
INSERT INTO EMP VALUES (536, 'Linus', 'Tech Tips', 'Toronto, 87', 'CLERK', 82300, 4667, 'Poland');
INSERT INTO EMP VALUES (601, 'Donald', 'Tusk', 'Keystores, 09', 'CLERK', 46643, 9999, 'Uganda');

/**Create customer table**/
CREATE TABLE CUSTOMER
(CUSTID int NOT NULL PRIMARY KEY,
CNAME VARCHAR(15),
CSURNAME VARCHAR(15),
CADDRESS VARCHAR(65),
CZIP int,
COUNTRY VARCHAR(16));

/**Add data to CUSTOMER table**/
INSERT INTO CUSTOMER VALUES (12, 'Ewa', 'Turska', 'Charnomorska, 52', 56743, 'Poland');
INSERT INTO CUSTOMER VALUES (22, 'Viktor', 'Litovchenko', 'Dolna, 12', 46532, 'Poland');
INSERT INTO CUSTOMER VALUES (42, 'Ihor', 'Yukion', 'Plac Zawisy, 4', 96543, 'USA');
INSERT INTO CUSTOMER VALUES (41, 'Artem', 'Andreoli', 'Sample, 99', 43521, 'Uganda');
INSERT INTO CUSTOMER VALUES (56, 'Mykola', 'Janos', 'London, 87', 11111, 'Germany');
INSERT INTO CUSTOMER VALUES (61, 'Artur', 'Bryk', 'Kiev, 09', 04932, 'USA');
INSERT INTO CUSTOMER VALUES (72, 'Artsion', 'Paliaschuk', 'Minsk, 32', 34223, 'Belarus');

/**Create emp holidays table**/
CREATE TABLE EMPHOLIDAYS
(HOLID int NOT NULL PRIMARY KEY,
EMPID int,
Foreign key (EMPID) references EMP(EMPID),
DATE_START DATE,
DATE_END DATE);

/**Add data to EMPHOLIDAYS table**/
INSERT INTO EMPHOLIDAYS VALUES (12, 123, '2017-03-20', '2017-03-21');
INSERT INTO EMPHOLIDAYS VALUES (23, 222, '2018-08-05', '2018-09-16');
INSERT INTO EMPHOLIDAYS VALUES (34, 312, '2018-04-19', '2018-04-30');
INSERT INTO EMPHOLIDAYS VALUES (45, 412, '2018-12-10', '2018-12-12');
INSERT INTO EMPHOLIDAYS VALUES (56, 536, '2018-03-15', '2018-03-26');
INSERT INTO EMPHOLIDAYS VALUES (67, 601, '2016-11-07', '2016-11-10');

CREATE TABLE BIKETYPE
(BIKETYPEID int NOT NULL PRIMARY KEY,
BIKE_TYPE VARCHAR(30),
BIKE_MATERIAL VARCHAR(30));

/**Add data to BIKETYPE table**/
INSERT INTO BIKETYPE VALUES (11, 'Road bicycles', 'Carbon');
INSERT INTO BIKETYPE VALUES (22, 'Touring bicycles', 'Titanium');
INSERT INTO BIKETYPE VALUES (33, 'Randonneur', 'Bamboo');
INSERT INTO BIKETYPE VALUES (44, 'Hybrid bicycles', 'Lugged');
INSERT INTO BIKETYPE VALUES (55, 'Cyclo-cross bike', 'Titanium');
INSERT INTO BIKETYPE VALUES (66, 'Utility bicycles', 'Carbon');
INSERT INTO BIKETYPE VALUES (77, 'Other bicycles', null);

/**Create bike table**/
CREATE TABLE BIKE
(BIKEID int NOT NULL PRIMARY KEY,
MANUFACTURER VARCHAR(20),
BMODEL VARCHAR(20),
BCOLOR VARCHAR(20),
BIKETYPEID int,
Foreign key (BIKETYPEID) references BIKETYPE(BIKETYPEID));

/**Add data to BIKE table**/
INSERT INTO BIKE VALUES (10, 'Hercules', 'Carbon', 'Black', 11);
INSERT INTO BIKE VALUES (20, 'KROSS', 'K10', 'Green', 22);
INSERT INTO BIKE VALUES (30, 'Hero', 'Urban 26T ', 'Red', 66);
INSERT INTO BIKE VALUES (40, 'Titan', 'Egoist', 'Blue', 55);
INSERT INTO BIKE VALUES (50, 'Discovery', 'Flipper', 'White', 44);
INSERT INTO BIKE VALUES (60, 'Titan', 'Tornado', 'Purple', 55);

/**Create order table**/
CREATE TABLE ORDER_TABLE
(ORDERID int NOT NULL PRIMARY KEY,
BIKEID int,
CUSTID int,
EMPID int,
Foreign key (BIKEID) references BIKE(BIKEID),
Foreign key (CUSTID) references CUSTOMER(CUSTID),
Foreign key (EMPID) references EMP(EMPID),
PRICE int);

/**Add data to ORDER_TABLE table**/
INSERT INTO ORDER_TABLE VALUES (100, 10, 12, 123, 120);
INSERT INTO ORDER_TABLE VALUES (200, 20, 22, 222, 30);
INSERT INTO ORDER_TABLE VALUES (300, 30, 42, 312, 40);
INSERT INTO ORDER_TABLE VALUES (400, 40, 41, 412, 56);
INSERT INTO ORDER_TABLE VALUES (500, 50, 56, 536, 198);
INSERT INTO ORDER_TABLE VALUES (600, 60, 61, 601, 356);
INSERT INTO ORDER_TABLE VALUES (700, 40, 42, 222, 120);

/*Query 1 - minimal salary for Clerk**/
select 'The smallest salary for clerk is ' + convert(varchar(10), min(sal)) + ' zl'
from emp
where ejob = 'CLERK';

/**Query 2**/
select ename, esurname, empid, ejob
from emp
where ename = 'Linus' and (ejob !='SYSADMIN' and ejob !='MECHANIC');

/**Query 3 - select users with surnames with T beggining or th ending. And which is not from Ukraine**/
select *
from emp
where (esurname like 'T%' or esurname like '%th') and country !='Ukraine';

/*Query 4 - show orders where employee sal is bigger than 4500 and bike have some chosen specifications**/
select *
from order_table
where EMPID in (SELECT empid
         FROM emp
         WHERE sal > 4500) and BIKEID in (SELECT BIKEID
         FROM bike
        WHERE bmodel in( 'Carbon', 'K10' , 'Egoist','Titan'));

/*Query 5 - return orders with bikes in orders and with chosen colors */
select *
from order_table
WHERE EXISTS (Select *
from bike
where order_table.bikeid = bikeid and bcolor in ('Black', 'Red', 'White', 'Blue'));

/*Query 6*/
select ename, ejob,  sal*12 as ansal
from emp;

/*Query 7 - get bike information by order**/
SELECT *
FROM bike
WHERE BIKEID = (SELECT BIKEID FROM ORDER_TABLE WHERE CUSTID = 61);

/*Query 8 - count number of customers from different countries*/
SELECT COUNT(CUSTID), Country
FROM customer
GROUP BY Country;

/**Query 9 - count number of customers in descending by country*/
SELECT COUNT(CUSTID), Country
FROM customer
GROUP BY Country
ORDER BY COUNT(CUSTID) DESC;

/**Query 10 - show summary income where price is bigger than 40**/
select 'Total income from orders with price bigger than 40 zl is ' + convert(varchar(10), SUM(price))
from order_table
where price > 40;

/*Query 11 - Union countries from customers and employees excepting Uganda*/
SELECT 'Customer' As Type, Country, cname, csurname
FROM Customer
WHERE Country!='Uganda'
UNION
SELECT 'Employee' As Type, COUNTRY, ename, esurname
FROM Emp
WHERE Country!='Uganda'
ORDER BY Country;

/**Query 12 - get id of order and some info about customer**/
SELECT order_table.ORDERID, customer.CNAME, customer.CSURNAME
FROM ORDER_TABLE
INNER JOIN customer ON ORDER_TABLE.CUSTID = customer.CUSTID;

/**Query 13 - show data about holidays in a selected time range**/
SELECT h.HOLID, h.EMPID, h.DATE_START, h.DATE_END, emp.ename, emp.ESURNAME
FROM empholidays h, emp
WHERE DATE_START BETWEEN '14-MAR-18' AND  '17-SEP-18' and emp.EMPID = h.EMPID;

/**Query 14 - select bikes by material*/
select *
from bike
where BIKETYPEID IN  (select BIKETYPEID
from biketype
where BIKE_MATERIAL='Lugged');

/**Query 15 - select biketypes where material is not null**/
SELECT * FROM biketype
WHERE BIKE_MATERIAL IS NOT NULL;

/**Query 16 - show total income for employee from employee orders**/
select sum(price), empid
from order_table
group by empid;

/**Query 17 - show biggest income from single order**/
select 'The biggest income from one order (currently) is ' +  convert(varchar(15), max(PRICE)) + '!'
from order_table;

/**Query 18 - show people who earn more then the average sal in their country*/
SELECT ENAME, ESURNAME, sal, ejob, country
FROM emp a
WHERE sal >(SELECT AVG(sal)
FROM emp
WHERE COUNTRY = a.COUNTRY);

/**Query 19 - select bike types that  doesn't apply to any bike in BIKE table**/
SELECT *
FROM biketype d
WHERE NOT EXISTS (SELECT *
FROM bike
WHERE BIKETYPEID
= d.BIKETYPEID);

/*Query 20 - select customers who spent more than 100 zl in total*/
select *
from customer m
where 100 < (select sum(price)
from order_table
where m.CUSTID = CUSTID);

 /*TRIGGERS**/
--Trigger 1 - EMP table //BEFORE UPDATE - on row
drop trigger NoHighSal;
Create trigger NoHighSal On emp
for update
as
begin
if (select sal from inserted) > 4999
Begin
print('we do not want to pay you so much');
rollback;
end;
end;

update emp set sal = 7000 where ename = 'Jason' and esurname = 'Smith';

select *
  from emp;


--Trigger 2 - count number of bikes after inserting //AFTER INSERT - on table
drop trigger Afterinsertingnewbike;
CREATE TRIGGER Afterinsertingnewbike on bike
AFTER INSERT
as
BEGIN
declare @X as int;
declare @Y as int;
Select @Y = count(BIKEID)
from BIKE;
Select @X = (count(BIKEID)-1)
from BIKE;
--DBMS_output.put_line('We had ' || x || ' bikes, now we have ' || y || ' bikes');
print('We had ' + convert(varchar(25), @x) + ' bikes, now we have ' + convert(varchar(25), @y) + ' bikes');
END;

insert into bike values (70, 'Tornado', 'K25', 'Green', 22);

select *
  from ORDER_TABLE;

--Trigger 3 - show details about deleted order after deleting//AFTER DELETE - on row
drop trigger Orderdeleting;
Create trigger Orderdeleting on ORDER_TABLE
After delete
as
Begin
declare @CLIENTNAME as varchar(65), @CLIENTSURNAME varchar(65), @CLIENTBIKE varchar(65), @CLIENTBIKEMODEL varchar(65);
select @CLIENTNAME = CNAME
from deleted, CUSTOMER
where  deleted.CUSTID = CUSTOMER.CUSTID;
select @CLIENTSURNAME = CSURNAME
from deleted, CUSTOMER
where  deleted.CUSTID = CUSTOMER.CUSTID;
select @CLIENTBIKE = MANUFACTURER
from deleted, BIKE
where deleted.BIKEID = BIKE.BIKEID;
select @CLIENTBIKEMODEL = BMODEL
from deleted, BIKE
where deleted.BIKEID = BIKE.BIKEID;
print('We deleted order from customer ' + @CLIENTNAME + ' ' + @CLIENTSURNAME + ' which ordered ' + @CLIENTBIKE + ' ' + @CLIENTBIKEMODEL + ' bike.')
END;

delete from order_table where BIKEID=40;

--function

drop function  getInfoAboutCustomer

CREATE FUNCTION getInfoAboutCustomer(@in_person_id INT)
RETURNS VARCHAR(300)
AS BEGIN
  Declare @person_info VARCHAR(200);
  Declare @person_orders VARCHAR(200);
  select @person_info = '[PERSON INFO]
        Full name: ' + CNAME + ' ' + CSURNAME + ',
        Address: ' +  CADDRESS + ',
        Country: ' + country + ',
        ZIP Code: ' + convert(varchar(25), czip)
  from CUSTOMER
  where @in_person_id = CUSTOMER.CUSTID;

  select @person_orders = '[ORDERS INFO]
        N of orders: ' + convert(varchar(25), count(ORDERID)) +',
        AVG: '+ convert(varchar(25), avg(PRICE)) + ',
        Total: '+ convert(varchar(25), sum(PRICE))
  from ORDER_TABLE
  where @in_person_id = ORDER_TABLE.CUSTID;
  RETURN @person_info + ' ' + @person_orders
END

SELECT dbo.getInfoAboutCustomer(12)
AS Info

select *
from ORDER_TABLE;


--Procedures

--Procedure 1
--Add new customer without specifying id OR update existing customer if it exists (based on name, surname and zip)
drop procedure addCustomer

Create procedure addCustomer(@customerName varchar(65), @customerSurname varchar(65), @addressC varchar(30), @customerZip INT, @customerCountry varchar(50))
as
BEGIN
DECLARE @X int;
DECLARE @Y int;
DECLARE @Z int;

select @Y = count(custid)
from customer;
if(@Y > 0)
  BEGIN
    select @Z = count(CUSTID)
from customer
where CNAME = @customerName;
select @X = max(CUSTID)
from customer;
if(@z = 0)
BEGIN
INSERT INTO CUSTOMER VALUES (@X + 11, @customerName, @customerSurname, @addressC, @customerZip, @customerCountry);
PRINT 'insert case';
END
else
 BEGIN
Update CUSTOMER set CNAME = @customerName, CSURNAME = @customerSurname, CADDRESS = @addressC, czip = @customerZip, COUNTRY = @customerCountry where CNAME = CNAME and CSURNAME = @customerSurname and czip = @customerZip;
PRINT 'update case';
END;
  end
else
  BEGIN
    print 'Sorry, seems like there is no any customers';
   END;
end;

addCustomer 'Ewa', 'Turska', 'Spacerowa, 17', 56743, 'Poland';
addCustomer 'Marcin', 'Sydow', 'Truskawiecka, 27', 54742, 'Poland';

select *
from CUSTOMER;


--Procedure 2
--If number of holiday days for employee is less than 7, increase his salary by 10 %
CREATE procedure holidaysSal(@employeeID int)
as
begin
Declare @HolidaysCounting int;
Declare @CorrectHolidays int;
select @HolidaysCounting = count(HOLID)
from EMPHOLIDAYS;
if(@HolidaysCounting = 0)
Begin
  print 'Sorry, seems like there is no any holidays';
end;

select @CorrectHolidays = count(Holid)
from EMPHOLIDAYS
where DATEDIFF(DAY, DATE_START, DATE_END) < 7 and EMPID = @employeeID;

if(@CorrectHolidays = 1)
begin
  update emp set sal = sal + (sal*0.10) where EMPID = @employeeID;
end;
else
  begin
    print('Hmm, looks like this worker does not have holidays OR have more than 1 holiday (which is also not good!)')
  end
end;

EXEC holidaysSal 123;

--Procedure 3  with result set
--Get information about orders of a specific person
create procedure getInformationAboutAllOrdersOfCustomer(@customerID int)
as
begin
select ord.ORDERID, b.BMODEL, c.CNAME, c.CSURNAME, e.Ename, e.Ejob, sum()
from ORDER_TABLE ord, emp e, CUSTOMER c, BIKE b
where ord.CUSTID = @customerID and ord.BIKEID = b.BIKEID and ord.CUSTID = c.CUSTID and e.EMPID = ord.EMPID;
end;

exec getInformationAboutAllOrdersOfCustomer 22

--Procedure 4 OUTPUT
--Return average income of some employee from all orders having his as a given parameter
  drop procedure getIncomeByName
 create procedure getIncomeByName @empID int, @income money output
 as
   BEGIN
  set nocount on;
  select avg(PRICE)
  from ORDER_TABLE
  where EMPID = @empID;
return @income
end;

declare @totalEarningFromOrders money;
exec getIncomeByName 536, @income = @totalEarningFromOrders output;
print 'This employee at average earned from all orders: ' + cast(@totalEarningFromOrders as varchar);

   select *
from ORDER_TABLE
