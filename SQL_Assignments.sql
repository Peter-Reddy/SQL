create database DEMO;

USE DEMO;

CREATE TABLE EMP
(EID CHAR(5) ,
NAME VARCHAR(30) ,
ADDR VARCHAR (40) ,
CITY VARCHAR (25) ,
DOB DATE ,
PHONE CHAR (15) ,
EMAILID VARCHAR (50)) ;

insert into emp (eid,name, addr,city,dob,phone,emailid)
values ('E0001','peter','siriresidency thanda', 'khammam','5-7-1998', 9573161212,'peterjoel123@gmail.com');

insert into emp
values ('E0002','joel','hno 123 askhok nagar','hyderabad','5-7-1996',9573164431,'peterjo22@gmail.com');

insert into emp 
values ('E0003','ashok','hno 123 hyath nagar','hyderabad','5-7-2000',9573164221,'peterj@gmail.com');

insert into emp
values ('E0004','viram','hno 343 ram nagar','hyderabad','4-5-2001',23904805344,'vikarm@gmail.com');

insert into emp
values ('E0005','raj kuamr','hno 144 kautilya','secundrabad','5-2-1994',9892829320,'Rajkumar@gmail.com');

insert into emp(Name,addr,city,eid,dob,emailid,phone)
values ('ramesh','hno 1923 viraj nagar','hyderabad','E0006','5-7-1995','ramesh@gmail.com',9738333434);

insert into emp
values ('E0007','mahesh','hno 989 chikadpally', 'hyderabad', '3-12-2005',2343490834,'mahesh@gmail.com');

insert into emp
values('E0008','kcrao','hno 293 rtc cross roads', 'hyderabad','5-2-2021',9039839234,'kcrao@gmail.com');

insert into emp
values ('E0009','ktrao','hno 321 jublihills', 'hyderabad','8-9-1888',90786789738,'ktrao@gmail.com');

insert into emp
values ('E0010','raghunandhan rao','hno 293 siricila','medak','9-3-1993',0987857698,'raghunandhan@gmail.com');

select *from EMP;



CREATE TABLE EMP_SAL
(EID CHAR(5),
DEPT VARCHAR (20),
DESI VARCHAR (30),
DOJ DATE, 
SALARY INT);

insert into emp_sal(EID,DEPT,DESI,DOJ,SALARY)
values ('E0001','HR','MGR','2019-01-15',55000);

insert into emp_sal
values ('E0002','MIS','ASSO','2022-07-03',50000);

insert into emp_sal
values ('E0003','OPS','ASSO','2023-01-02',35000);

insert into emp_sal
values ('E0004','HR','VP','2020-06-05',45000);

insert into emp_sal 
values ('E0005','OPS','MGR','2021-07-03',55000);

insert into emp_sal
values ('E0006','TEMP','MGR','2018-02-12',34000);

insert into emp_sal
values ('E0007','IT ADMIN','DIR','2016-01-01',90000);

select * from emp_sal;

alter table emp
add constraint pk primary key (eid);

alter table emp
alter column eid varchar (5) not null;

alter table emp
alter column name varchar (30) not null;

alter table emp
add constraint chk1 check (addr not like '%uttam nagar%');

alter table emp 
add constraint chk2 check ( city in('DEL','GGN','FBD','NOIDA'));
-- chaning city names --
update emp
set city = 'DEL'
where city ='khammam';

update emp
set city = 'GGN'
WHERE city = 'medak';

update emp
set city = 'FBD'
where city = 'secundrabad';

update emp 
set city = 'NOIDA'
Where city ='hyderabad';


alter table emp
add constraint unk unique (phone);

alter table emp
add constraint chk3 check (emailid like '%gmailid%' or   emailid like '%yahoo%'); --------GETTING ERROR-----------

ALTER TABLE EMP
ADD CONSTRAINT CHK3 CHECK (EMAILID LIKE '%@gmail.com%' OR EMAILID LIKE '%@yahoo.com%');

alter table emp
drop constraint chk3;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'emp' AND CONSTRAINT_TYPE = 'CHECK';



alter table emp
add constraint chk4 check (DOB <='2000-1-1'); -----GETTING ERROR------------------


ALTER TABLE emp_sal
ADD CONSTRAINT fk_emp_sal_emp
FOREIGN KEY (eid) REFERENCES emp(eid);

alter table emp_sal
add constraint chk5 check (dept in('HR','MIS','OPS','IT ADMIN','TEMP'));

update emp_sal
set dept = 'IT ADMIN'
where dept = 'admin';

update emp_sal
set dept = 'OPS'
where dept= 'it';

delete from emp_sal
where dept = 'it admin';

insert into emp_sal
values ('E0002','MIS','Assistent manager','3-july-2022',40000);

insert into emp_sal
values ('E0006','TEMP','Regional manager','12-feb-2018',34000);

insert into emp_sal
values ('E0007','IT ADMIN','Id director','1-jan-2016',90000); 

alter table emp_sal
add constraint chk6 check (desi in ('ASSO','MGR','VP','DIR'));

UPDATE emp_sal
set desi= 'DIR'
WHERE desi = 'id director';

update emp_sal 
set desi = 'VP'
where desi = 'recruitment manager';

update emp_sal 
set desi = 'ASSO'
where desi = 'assistent manager';

update emp_sal 
set desi = 'MGR'
where desi = 'Regional manager';

alter table emp_sal
add constraint chk7 check (salary >=20000);

ALTER TABLE emp_sal
ADD CONSTRAINT dlf DEFAULT ('TEMP') FOR dept;

--- 4th assingment---------------------------

select city, count(*) as 'employee_count'
from emp
group by city
order by employee_count desc;
 --- another type of code for same problem---
 select city, count(eid) as 'employee_count'
from emp
group by city
order by count(eid) desc;

select * from emp
where EMAILID not like '%yahoo%';

select desi, sum(salary) as 'desi wise total salary', count(*)as 'employee_count'
from emp_sal
group by desi
order by employee_count desc;


---- 5th Assignment-------------

select emp.eid,name,city,doj,dept,desi,salary
from emp
inner join emp_sal
on emp.eid=emp_sal.eid
where city='del';

select emp.eid,*
from emp
LEFT join emp_sal
on emp.eid=emp_sal.eid
where EMP_SAL.EID IS NULL;

select PRODUCT_ID,PRODUCT_DESCRIPTION,CATEGORY,SUPPLIER_NAME,SUPPLIER_CITY
from PRODUCT
inner join supplier
on product.SUPPLIER_ID=supplier.SUPPLIER_ID;

select ORDER_ID,ORDER_DATE,CUSTOMER_NAME,CUSTOMER_ADDR,CUSTOMER_PHONE,PRODUCT_DESCRIPTION,PRICE,ORDER_QTY,PRICE*ORDER_QTY AS'AMOUNT'
FROM ORDERS
INNER JOIN PRODUCT
ON ORDERS.PRODUCT_ID=PRODUCT.PRODUCT_ID
INNER JOIN CUSTOMER
ON CUSTOMER.CUSTOMER_ID=ORDERS.CUSTOMER_ID;

select * from SUPPLIER;
use INVENTORY

SELECT ORDER_ID,ORDER_DATE,PRICE,
FROM CUSTOMER



SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'emp' AND CONSTRAINT_TYPE = 'CHECK';

---------------------------------------------------------
----ASSIGNMENT 6TH ------------------------------------

CREATE VIEW V6EMPA_SAL
AS
   SELECT EMP.EID,NAME,DOJ,DEPT,DESI,SALARY AS 'BASIC',SALARY*0.15 AS'HRA',SALARY*0.09 AS 'PF',SALARY+SALARY*0.15+SALARY*0.09 AS 'NET',SALARY+SALARY*0.15+SALARY*0.09-SALARY*0.09 AS 'GROSS'
   FROM EMP
   INNER JOIN EMP_SAL
   ON EMP.EID=EMP_SAL.EID;

SELECT * FROM V6EMPA_SAL;


CREATE VIEW V6_MGRS
AS 
SELECT EMP.EID,NAME,DOJ,DESI,DEPT
FROM EMP
INNER JOIN EMP_SAL
ON EMP.EID= EMP_SAL.EID
WHERE DESI = 'MGR' AND year (DOJ)= 2019;

SELECT * FROM V6_MGRS;

CREATE VIEW V6_DEPT
AS
SELECT DEPT,CITY,COUNT(*)AS 'NO_OF_EMPLOYEES',SUM(SALARY)AS'TOTAL SALARY',AVG(SALARY)AS'AVG SALARY'
FROM EMP_SAL
INNER JOIN EMP
ON EMP.EID=EMP_SAL.EID
GROUP BY CITY,DEPT;

SELECT * FROM V6_DEPT;


USE INVENTORY;

CREATE VIEW BILL
AS
SELECT ORDER_ID,ORDER_DATE,CUSTOMER_NAME,CUSTOMER_ADDR,CUSTOMER_PHONE,PRODUCT_DESCRIPTION,PRICE,ORDER_QTY,PRICE*ORDER_QTY AS 'AMOUNT'
FROM ORDERS
INNER JOIN CUSTOMER
ON CUSTOMER.CUSTOMER_ID=ORDERS.CUSTOMER_ID
INNER JOIN PRODUCT
ON PRODUCT.PRODUCT_ID=ORDERS.PRODUCT_ID;     

SELECT * FROM BILL;   

------------------------------------------------------------------------------------------------------------------------------------
--ASSIGNMENT 7TH ----

SELECT DEPT,COUNT(*)AS 'TEAM SIZE',AVG(SALARY)AS'AVERAGE SALARY'
FROM EMP_SAL
GROUP BY DEPT;

SELECT COUNT(EID) 
FROM EMP_SAL
WHERE DESI = 'MGR';



SELECT
  MAX(SALARY) AS MAXIMUM_SALARY,
  MIN(SALARY) AS MINIMUM_SALARY
FROM EMP_SAL
INNER JOIN EMP
ON EMP.EID = EMP_SAL.EID
WHERE DESI = 'ASSO';



SELECT
  DEPT,
  COUNT(*) AS TEAM_SIZE,
  AVG(SALARY) AS AVERAGE_SALARY
FROM EMP_SAL
INNER JOIN EMP
ON EMP.EID = EMP_SAL.EID
WHERE CITY = 'DEL'
GROUP BY DEPT;
 

SELECT EID, NAME, UPPER(CONCAT(LEFT(NAME, 1), RIGHT(NAME, LEN(NAME) - CHARINDEX(' ', NAME)), RIGHT(EID, 3), '@RCG.COM'))AS'OFFICE EMAIL' 
FROM EMP;

SELECT EID,NAME,PHONE,EMAILID
FROM EMP
WHERE DATEDIFF(YEAR,DOB,GETDATE()) >=40;

SELECT EMP.EID,NAME,DOJ
FROM EMP
INNER JOIN EMP_SAL
ON EMP.EID=EMP_SAL.EID
WHERE DATEDIFF(YEAR,DOJ,GETDATE()) >=5;

SELECT *
FROM EMP
INNER JOIN EMP_SAL
ON EMP.EID=EMP_SAL.EID
WHERE MONTH(DOB)= MONTH(GETDATE())AND DESI='MGR';

SELECT EID,DEPT,DESI,SALARY 
FROM EMP_SAL
WHERE SALARY =(SELECT MAX (SALARY) FROM EMP_SAL);

SELECT top 1 EID,NAME
FROM EMP
ORDER BY LEN (NAME) DESC 

SELECT EID, NAME 
FROM Emp
WHERE LEN(NAME) = (SELECT MAX(LEN(NAME))FROM Emp);

-------------------------------------------------------------------
---ASSIGNMENT 7TH------
--1Q
CREATE FUNCTION CALC (@A AS INT,@B AS INT)
RETURNS INT
AS 
  BEGIN
       DECLARE @C AS INT
	   SET @C = @A+@B
	   RETURN @C
  END;

SELECT DBO.CALC(10,20);
--2Q
CREATE FUNCTION GenerateEmail(@Name VARCHAR(50), @EID CHAR(5))
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @FirstName VARCHAR(20);
DECLARE @LastName VARCHAR(20);
DECLARE @EmailID VARCHAR(50);

SET @FirstName = LEFT(@Name, 1);
SET @LastName = LEFT(RIGHT(@Name, LEN(@Name) - CHARINDEX(' ', @Name)), 1);
SET @EmailID = CONCAT(@FirstName, @LastName, RIGHT(@EID, 3), '@RCG.COM');

RETURN @EmailID;
END;

--3Q--
CREATE FUNCTION SPE_DEPT(@DEPARTMENT as varchar(20))
RETURNS TABLE 
AS 
  RETURN (SELECT EMP.EID,NAME,DESI,DEPT,SALARY
  FROM EMP
  INNER JOIN EMP_SAL
  ON EMP.EID=EMP_SAL.EID);

SELECT * FROM DBO.SPE_DEPT('HR');

--4Q--

CREATE FUNCTION EMPDOM()
RETURNS TABLE
AS
  RETURN(SELECT EMP.EID,NAME,DEPT,DESI,CITY
  FROM EMP
  INNER JOIN EMP_SAL
  ON EMP.EID=EMP_SAL.EID
  WHERE MONTH(DOB)=MONTH(GETDATE()));

SELECT * FROM DBO.EMPDOM();

--5Q--
CREATE FUNCTION WORKYRS()
RETURNS TABLE 
AS 
   RETURN (SELECT NAME,DEPT,DOJ
   FROM EMP
   INNER JOIN EMP_SAL
   ON EMP.EID=EMP_SAL.EID
   WHERE DATEDIFF(YEAR,DOJ,GETDATE()) >=5 );

SELECT * FROM DBO.WORKYRS();
------------------------------------------------------------------------------------------------------

--ASSIGNMENT 7_ATH-----
--1Q
SELECT EID,NAME,CITY
FROM EMP
WHERE CITY='GURGAON';

--2Q
SELECT EMP.EID,NAME,DOJ,DEPT,DESI,SALARY
FROM EMP
INNER JOIN EMP_SAL
ON EMP.EID=EMP_SAL.EID
WHERE DESI='MGR';

--3Q
UPDATE EMP_SAL
SET SALARY= SALARY-SALARY*0.1
WHERE EID IN (SELECT EID FROM EMP WHERE CITY ='DEL');

-- or ---
UPDATE EMP_SAL
SET SALARY= SALARY-SALARY*0.1
FROM EMP
INNER JOIN EMP_SAL
ON EMP.EID=EMP_SAL.EID
WHERE CITY='DEL';

--4Q
select emp.EID, NAME, CITY, DOJ, DEPT, DESI, SALARY 
from emp 
join emp_sal
on emp.eid=emP_sal.eid
where emp.eid IN  (select EID from emp where name in( 'peter','ashok')
union select dept from emp_sal where eid in('E0001','E0003')
union select eid from emp_sal where dept in ('hr','ops'))
--OR--
SELECT EMP.EID, NAME, CITY, DOJ, DEPT, DESI, SALARY
FROM EMP
INNER JOIN EMP_SAL
ON EMP.EID=EMP_SAL.EID
WHERE EMP.EID IN(
  SELECT EID FROM EMP_SAL 
     WHERE DEPT IN(SELECT DEPT FROM EMP_SAL 
        WHERE EID IN(SELECT EID FROM EMP WHERE NAME IN ('peter','ashok'))));
--5Q-
create table TRANINING (
EID CHAR(5),
NAME VARCHAR(20),
DEPT VARCHAR(20));
 
INSERT INTO TRANINING (EID,NAME,DEPT)
SELECT EMP.EID,NAME,DEPT
FROM EMP
JOIN EMP_SAL
ON EMP.EID=EMP_SAL.EID
WHERE DEPT='OPS'

--6Q
DELETE FROM TRANINING
WHERE EID IN (SELECT EID FROM EMP_SAL WHERE DESI LIKE 'DIRECTOR%');

--7Q

SELECT *
FROM EMP_SAL e1
WHERE EXISTS (
    SELECT *
    FROM EMP_SAL e2
    WHERE e1.DEPT = e2.DEPT AND e2.SALARY > 60000
---------------------------------------
SELECT * FROM  EMP_SAL 
WHERE EXISTS(SELECT * FROM EMP_SAL WHERE AND SALARY >60000);


--------------------------------------------------------------------------------------------------------------------------------------------


--ASSIGNMENT 8TH---








SELECT * FROM EMP;

SELECT * FROM EMP_SAL;





DELETE TRANINING;










USE DEMO;
CREATE INDEX L1I1 
ON EMP(CITY);    

DROP INDEX L1I1
ON EMP;    

CREATE INDEX L2I2
ON EMP(CITY,ADDR);   

CREATE CLUSTERED INDEX L3I3
ON EMP (CITY);  -----Msg 1902, Level 16, State 3, Line 300
--Cannot create more than one clustered index on table 'EMP'. 
--Drop the existing clustered index 'pk' before creating another.

CREATE VIEW Q1
AS
SELECT DEPT,SUM(SALARY)as 'TOTAL COST'
FROM EMP_SAL
GROUP BY DEPT
ORDER BY DEPT DESC;

CREATE VIEW Q2
AS
SELECT DEPT,SUM (SALARY) AS 'TOTAL COST'
FROM EMP_SAL
GROUP BY DEPT
HAVING 'TOTAL COST'>50000


SELECT DEPT FROM EMP_SAL