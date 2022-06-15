#query
use depart;
create table EMPLOYEE(empId int primary key,name varchar(20),dept varchar(20));
insert into employee values(1,'Ram','SALES');
insert into employee values(2,'Ankit','SALES');
insert into employee values(3,'','account');
select f1();
#function
CREATE DEFINER=`root`@`localhost` FUNCTION `f1`() RETURNS int(11)
BEGIN
declare c int default 0;
select count(*) into c from EMPLOYEE;
RETURN c;
END
