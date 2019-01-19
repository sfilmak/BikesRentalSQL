DROP TABLE EMPHOLIDAYS; /*TRIGGER 2**/
DROP TABLE ORDER_TABLE; /**TRIGGER 4**/
DROP TABLE EMP; /*TRIGGER 1**/
DROP TABLE CUSTOMER; /**TRIGGER 6**/
DROP TABLE BIKE;  /**TRIGGER 3**/
DROP TABLE BIKETYPE; /**TRIGGER 5**/

/**Create employee table**/
CREATE TABLE EMP
(EMPID NUMBER(3) NOT NULL PRIMARY KEY,
ENAME VARCHAR2(10),
ESURNAME VARCHAR2(10),
ADDRESS VARCHAR2(65),
EJOB  VARCHAR2(25),
ZIP NUMBER(5),
SAL NUMBER(7),
COUNTRY VARCHAR2(16));

/**Add data to EMP table**/
INSERT INTO EMP VALUES (123, 'Jason', 'Smith', 'Koszykowa, 52', 'CLERK', 89000, 5000, 'USA');
INSERT INTO EMP VALUES (222, 'Linus', 'Torvalds', 'California, 12', 'PROGRAMMER', 45646, 1236, 'Ukraine');
INSERT INTO EMP VALUES (312, 'Bill', 'Gates', 'Al. Lotnikow, 4', 'SYSADMIN', 57843, 1000, 'USA');
INSERT INTO EMP VALUES (412, 'Steve', 'Wozniak', 'Dolna, 99', 'MECHANIC', 32467, 7453, 'Poland');
INSERT INTO EMP VALUES (536, 'Linus', 'Tech Tips', 'Toronto, 87', 'CLERK', 82300, 4667, 'Poland');
INSERT INTO EMP VALUES (601, 'Donald', 'Tusk', 'Keystores, 09', 'CLERK', 46643, 9999, 'Uganda');

/**Create customer table**/
CREATE TABLE CUSTOMER
(CUSTID NUMBER(2) NOT NULL PRIMARY KEY,
CNAME VARCHAR2(15),
CSURNAME VARCHAR2(15),
CADDRESS VARCHAR2(65),
CZIP NUMBER(5), 
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
(HOLID NUMBER NOT NULL PRIMARY KEY,
EMPID NUMBER,
Foreign key (EMPID) references EMP(EMPID),
DATE_START DATE,
DATE_END DATE);
/**Add data to EMPHOLIDAYS table**/
INSERT INTO EMPHOLIDAYS VALUES (12, 123, TO_DATE('20-MAR-2017', 'DD-MON-YYYY'), TO_DATE('21-MAR-2017', 'DD-MON-YYYY'));
INSERT INTO EMPHOLIDAYS VALUES (23, 222, TO_DATE('05-AUG-2018', 'DD-MON-YYYY'), TO_DATE('16-SEP-2018', 'DD-MON-YYYY'));
INSERT INTO EMPHOLIDAYS VALUES (34, 312, TO_DATE('19-APR-2018', 'DD-MON-YYYY'), TO_DATE('30-APR-2018', 'DD-MON-YYYY'));
INSERT INTO EMPHOLIDAYS VALUES (45, 412, TO_DATE('10-DEC-2017', 'DD-MON-YYYY'), TO_DATE('12-DEC-2017', 'DD-MON-YYYY'));
INSERT INTO EMPHOLIDAYS VALUES (56, 536, TO_DATE('15-MAR-2018', 'DD-MON-YYYY'), TO_DATE('26-MAR-2018', 'DD-MON-YYYY'));
INSERT INTO EMPHOLIDAYS VALUES (67, 601, TO_DATE('07-NOV-2016', 'DD-MON-YYYY'), TO_DATE('11-NOV-2016', 'DD-MON-YYYY'));

/**Create bike type table**/
CREATE TABLE BIKETYPE
(BIKETYPEID NUMBER NOT NULL PRIMARY KEY,
BIKE_TYPE VARCHAR2(30),
BIKE_MATERIAL VARCHAR2(30));

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
(BIKEID NUMBER NOT NULL PRIMARY KEY,
MANUFACTURER VARCHAR2(20),
BMODEL VARCHAR2(20),
BCOLOR VARCHAR2(20),
BIKETYPEID NUMBER,
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
(ORDERID NUMBER NOT NULL PRIMARY KEY,
BIKEID NUMBER,
CUSTID NUMBER,
EMPID NUMBER,
Foreign key (BIKEID) references BIKE(BIKEID),
Foreign key (CUSTID) references CUSTOMER(CUSTID),
Foreign key (EMPID) references EMP(EMPID),
PRICE NUMBER);

/**Add data to ORDER_TABLE table**/
INSERT INTO ORDER_TABLE VALUES (100, 10, 12, 123, 120);
INSERT INTO ORDER_TABLE VALUES (200, 20, 22, 222, 30);
INSERT INTO ORDER_TABLE VALUES (300, 30, 42, 312, 40);
INSERT INTO ORDER_TABLE VALUES (400, 40, 41, 412, 56);
INSERT INTO ORDER_TABLE VALUES (500, 50, 56, 536, 198);
INSERT INTO ORDER_TABLE VALUES (600, 60, 61, 601, 356);
INSERT INTO ORDER_TABLE VALUES (700, 40, 42, 222, 120);

/*Query 1 - minimal salary for Clerk**/
select 'The smallest salary for clerk is ' || min(sal) || ' zl'
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

/**Query 4 - show orders where employee sal is bigger than 4500 and bike have some choosen specifications**/
select *
from order_table
where EMPID in (SELECT empid 
         FROM emp 
         WHERE sal > 4500) and BIKEID in (SELECT BIKEID 
         FROM bike 
        WHERE bmodel in( 'Carbon', 'K10' , 'Egoist','Titan'));     

/*Query 5 - return orders with bikes in orders and with choosen colors */
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

/**Query 10- show average sal bigger than 1000 by jobs**/
/*select ejob, avg(sal)
from emp 
having avg(sal) > 1000
group by ejob;*/

/**Query 11 - show summary income where price is bigger than 40**/
select 'Total income from orders with price bigger than 40 zl is ' || SUM(price)
from order_table
where price > 40;

/*Query 12 - Union countries from customers and employees excepting Uganda*/
SELECT 'Customer' As Type, Country, cname, csurname
FROM Customer
WHERE Country!='Uganda'
UNION
SELECT 'Employee' As Type, COUNTRY, ename, esurname
FROM Emp
WHERE Country!='Uganda'
ORDER BY Country;

/**Query 13 - get id of order and some info about customer**/
SELECT order_table.ORDERID, customer.CNAME, customer.CSURNAME
FROM ORDER_TABLE
INNER JOIN customer ON ORDER_TABLE.CUSTID = customer.CUSTID;

/**Query 14 - show data about holidays in a selected time range**/
SELECT h.HOLID, h.EMPID, h.DATE_START, h.DATE_END, emp.ename, emp.ESURNAME
FROM empholidays h, emp
WHERE DATE_START BETWEEN '14-MAR-18' AND  '17-SEP-18' and emp.EMPID = h.EMPID;

/**Query 15 - select bikes by material*/
select *
from bike
where BIKETYPEID IN  (select BIKETYPEID
from biketype
where BIKE_MATERIAL='Lugged');

--NEW QUERIES
/**Query 16 - select biketypes there material is not null**/
SELECT * FROM biketype
WHERE BIKE_MATERIAL IS NOT NULL;

/**Query 17 - show total income for employee from employee orders**/
select sum(price), empid
from order_table
group by empid;

/**Query 18 - show biggest income from single order**/
select 'The biggest income from one order (currently) is ' || max(PRICE) || '!'
from order_table;

/**Query 19 - show people who earn more then the average sal in their country*/
SELECT ENAME, ESURNAME, sal, ejob, country
FROM emp a
WHERE sal >(SELECT AVG(sal)
FROM emp
WHERE COUNTRY = a.COUNTRY);

/**Query 20 - select bike types that  doesn't apply to any bike in BIKE table**/
SELECT *
FROM biketype d
WHERE NOT EXISTS (SELECT *
FROM bike
WHERE BIKETYPEID
= d.BIKETYPEID);

/*Query 21 - select customers who spend more than 100 zl in total*/
select *
from customer m
where 100 < (select sum(price)
from order_table
where m.CUSTID = CUSTID);

 /*TRIGGERS**/
--Trigger 1 - EMP table //BEFORE UPDATE - on row
--drop trigger NoHighSal;
/*Set ServerOutput ON
Create or replace trigger NoHighSal
Before update 
On emp
For each row
Begin
if :new.sal > 4999
then raise_application_error(-20003, 'we do not want to pay you so much');
end if;
END;*/
drop trigger NoHighSal;
Update emp set sal = 4000 where empid = 229;

--Trigger 2 - generate ID if missed EMPHOLIDAYS //BEFORE INSERT - on row
--drop trigger GenerateID;
drop trigger GenerateID;
Set ServerOutput ON
Create or replace trigger GenerateID
Before insert 
On EMPHOLIDAYS
For each row
Begin
Select nvl(max(HOLID)+11, 12) into :new.HOLID
from EMPHOLIDAYS;
END;

INSERT INTO EMPHOLIDAYS(EMPID, DATE_START, DATE_END) VALUES (412, TO_DATE('20-MAR-2018', 'DD-MON-YYYY'), TO_DATE('25-MAR-2018', 'DD-MON-YYYY'));

--Trigger 3 - count number of bikes after inserting //AFTER INSERT - on table
drop trigger Afterinsertingnewbike;
CREATE OR REPLACE TRIGGER Afterinsertingnewbike
AFTER INSERT
on bike
Declare 
Y integer;
X integer;
BEGIN
Select count(BIKEID) INTO Y
from BIKE;
Select (count(BIKEID)-1) INTO X
from BIKE;
DBMS_output.put_line('We had ' || x || ' bikes, now we have ' || y || ' bikes');
END;

insert into bike values (70, 'Discovery', 'Planet', 'Green', 44);

select *
from bike;

--Trigger 4 - show details about deleted order after deleting//AFTER DELETE - on row
drop trigger Orderdeleting;
Set ServerOutput ON
Create or replace trigger Orderdeleting
After delete 
On order_table
For each row
Declare 
CLIENTNAME varchar2(65);
CLIENTSURNAME varchar2(65);
CLIENTBIKE varchar2(65);
CLIENTBIKEMODEL varchar2(65);
Begin
select CNAME into CLIENTNAME
from customer CV
WHERE CV.CUSTID = :OLD.CUSTID;
select CSURNAME into CLIENTSURNAME
from customer CV
WHERE CV.CUSTID = :OLD.CUSTID;
select MANUFACTURER into CLIENTBIKE
from bike CV
WHERE CV.BIKEID = :OLD.BIKEID;
select BMODEL into CLIENTBIKEMODEL
from bike CV
WHERE CV.BIKEID = :OLD.BIKEID;
DBMS_output.put_line('We deleted order from customer ' || CLIENTNAME || ' ' || CLIENTSURNAME || ' which ordered ' || CLIENTBIKE || ' ' || CLIENTBIKEMODEL || ' bike.');
END;

delete from order_table where BIKEID=40;

select *
from order_table;

--Trigger 5 - add new bike type before deleting existing one //BEFORE DELETE on table
drop trigger Addnewbiketype;
CREATE OR REPLACE TRIGGER Addnewbiketype
BEFORE DELETE
on biketype
Declare 
Y integer;
BEGIN
Select nvl(max(BIKETYPEID)+10, 11) into Y
from biketype;
insert into biketype values (Y, 'Hey', 'Titanium');
DBMS_output.put_line('New bike type with ID ' || y || ' was added before deleting another bike from the table.');
END;

delete from biketype where BIKETYPEID = 108;

--Trigger 6 -  - //AFTER UPDATE on rows
drop trigger Getinfo;
CREATE OR REPLACE TRIGGER Getinfo
AFTER UPDATE
ON customer
FOR EACH ROW
Declare 
AVGY varchar2(50);
SUMX varchar2(50);
NUM_ORDERS int;
BEGIN
select avg(price) into AVGY
from order_table
where order_table.CUSTID = :old.CUSTID;
select sum(price) into SUMX
from order_table
where order_table.CUSTID = :new.CUSTID;
DBMS_output.put_line('We changed info about customer ' || :old.cname || ' - now customer name is ' || :new.cname || ' and average price of orders from this customer is ' || AVGY || ' and sum of all orders is ' || SUMX);
DBMS_output.put_line('~And that is not all~');
select count(ORDERID) into NUM_ORDERS
from order_table
where order_table.CUSTID = :new.CUSTID;
DBMS_output.put_line('Number of total orders of this customer is ' || NUM_ORDERS);
END;

update customer set CNAME = 'Ewa' where CUSTID = 42;

select *
from customer;

select *
from order_table;


/*SBD*/

/*Procedure 1 with cursor*/
--If number of holiday days for employee is less than 7, increase his salary by 10 %
Create or replace procedure holidaysSal
as
NoHolidays exception;
NoEmployees exception;
HolidaysCounting number;
EmployeesCounting number;
D NUMBER;
Cursor getEmployees is
select EMPID
from EMPHOLIDAYS
where TO_date(DATE_END) - TO_date(DATE_START) < 7 ;
Begin
select count(HOLID) into HolidaysCounting
from EMPHOLIDAYS;
if(HolidaysCounting = 0) 
then
raise NoHolidays;
end if;
select count(empid) into EmployeesCounting
from emp;
if(EmployeesCounting = 0) 
then
raise NoEmployees;
end if;
OPEN getEmployees;
LOOP
FETCH getEmployees INTO D;
EXIT WHEN getEmployees%NOTFOUND;
update emp set sal = sal + (sal*0.10) where EMPID = d;
end loop;
commit;
close getEmployees;
Exception
When NoHolidays then DBMS_output.put_line('Sorry, seems like there is no any holidays');
When NoEmployees then DBMS_output.put_line('Sorry, seems like there is no any employees');
end;

execute holidaysSal;

--Procedure 2
--Add new customer without specifying id OR update existing customer if it exists (based on name, surname and zip)
create or replace procedure addCustomer(customerName varchar2, customerSurname varchar2, addressC varchar2, customerZip number, customerCountry varchar2)
as
NoCustomers exception;
X number;
Y number;
Z number;
Begin
select count(custid) into Y
from customer;
if(Y = 0) 
then
raise NoCustomers;
end if;
select count(CUSTID) into Z
from customer
where CNAME = customerName;
select max(CUSTID) into X
from customer;
if(z = 0) 
then 
INSERT INTO CUSTOMER VALUES (X + 11, customerName, customerSurname, addressC, customerZip, customerCountry);
DBMS_output.put_line('insert case');
else 
Update CUSTOMER set CNAME = customerName, CSURNAME = customerSurname, CADDRESS = addressC, czip = customerZip, COUNTRY = customerCountry where CNAME = CNAME and CSURNAME = customerSurname and czip = customerZip;
DBMS_output.put_line('update case');
end if;
Exception
When NoCustomers then DBMS_output.put_line('Sorry, seems like there is no any customers');
end;

execute addCustomer('Ewa', 'Turska', 'Spacerowa, 17', 56743, 'Poland');
execute addCustomer('Marcin', 'Sydow', 'Truskawiecka, 27', 54742, 'Poland');

select *
from customer;

--Procedure 3 with cursor--
--If price of some orders is bigger than average price of all orders, cut price for that orders by 20 %
create or replace procedure updateOrdersPrice
as
NoOrders exception;
X number;
D NUMBER;
Cursor ordersCursor is
select ORDERID from order_table where PRICE > (select avg(price) from order_table);
Begin
select count(ORDERID) into X
from order_table;
if(x = 0) 
then 
raise NoOrders;
end if;
OPEN ordersCursor;
LOOP
FETCH ordersCursor INTO D;
EXIT WHEN ordersCursor%NOTFOUND;
update order_table set price = price - (price*0.20) where orderid = d;
end loop;
commit;
close ordersCursor;
Exception
When NoOrders then DBMS_output.put_line('No orders!');
end;

execute updateOrdersPrice;

select *
from order_table;

select *
from emp;
--Trigger
drop trigger programmersEarnMoreThanClerks;
drop procedure updateProgrammersSalary;
--Update salaries of all Programmers and Sysadmins if their avarage salary is less than average salary of newly added clerk
Set ServerOutput ON
Create or replace trigger programmersEarnMoreThanClerks
Before insert
On emp
For each row
Declare 
X number;
Z number;
Begin
if :new.ejob = 'CLERK'
then 
select avg(sal) into X
from emp
where ejob = 'PROGRAMMER' or ejob = 'SYSADMIN';
select avg(sal) into Z
from emp
where ejob = 'CLERK';
if X < Z
then
DBMS_output.put_line('This Clerk now earns more than programmers and sysadmins! It is time to change salaries');
updateProgrammersSalary();
end if;
end if;
END;

create or replace procedure updateProgrammersSalary
as
NoProgrammers exception;
NoEmployees exception;
X number;
Y number;
D NUMBER;
Cursor programmerCursor is
select empid from emp where ejob = 'PROGRAMMER' or ejob = 'SYSADMIN';
Begin
select count(empid) into X
from emp;
select count (empid) into Y
from emp
where ejob = 'PROGRAMMER' or ejob = 'SYSADMIN';
if(x = 0) 
then 
raise NoEmployees;
end if;
if(y = 0) 
then
raise NoProgrammers;
end if;
OPEN programmerCursor;
LOOP
FETCH programmerCursor INTO D;
EXIT WHEN programmerCursor%NOTFOUND;
update emp set sal = sal + sal*0.2 where empid = d;
end loop;
--commit;
close programmerCursor;
Exception
When NoProgrammers then DBMS_output.put_line('No programmers or sysadmins!');
when NoEmployees then DBMS_output.put_line('No employees at all!');
end;

insert into emp values (954, 'Lesha', 'Jolygolf', 'Praga, 12', 'CLERK', 82000, 5000, 'Poland');

select *
from emp;

--Function
create or replace FUNCTION getInfoAboutCustomer(in_person_id IN NUMBER) 
RETURN VARCHAR2
IS person_details VARCHAR2(200);
person_orders VARCHAR2(200);
BEGIN 
SELECT '[PERSON INFO] 
        Full name: '||person.CNAME||' '|| person.CSURNAME||', 
        Address: '|| person.CADDRESS ||', 
        Country: '||person.country||', 
        ZIP Code: '||person.czip
INTO person_details
FROM customer person
where in_person_id = person.custid;
SELECT '[ORDERS INFO] 
        Number of orders: '|| count(ORDERID)||', 
        Average price of orders: '|| avg(PRICE) ||', 
        Total price of orders: '||sum(PRICE)
        INTO person_orders
FROM ORDER_TABLE 
where CUSTID = in_person_id;
RETURN(person_details || '
' || person_orders); 
END getInfoAboutCustomer;
 
EXECUTE dbms_output.put_line(getInfoAboutCustomer(42));

select *
from customer;

select *
from ORDER_TABLE;