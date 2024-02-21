drop database Library_management;
create database if not exists Library_management;
use Library_management;

create table if not exists Employee (
    emp_Id varchar(10),																		
    name char(20),
    department varchar(10),
	position varchar(20),
    primary key (emp_Id)
);


create table if not exists Student (
    stu_Id varchar(10),
    name char(20),
    DOB Date,
    department varchar(10),
    position varchar(32), 
    major varchar(10),
    primary key (stu_Id)
);



create table if not exists Staff (
    Staff_Id varchar(10),
    name char(20),
    DOB date,
    department varchar(10),
    position varchar(20),
    primary key (staff_id)
);
 


create table if not exists Books (
    Book_Id varchar(10),
    name varchar(64),
    Author char(20),
    Category char(20),
    Published_year Year,
    edition varchar(5),
    Publication_name varchar(30),
    primary key (book_id)
);


create table if not exists JAM (
    jam_Id varchar(10),
    name varchar(30),
    Author char(20),
    category char(20),
    Published_year Year,
    edition varchar(5),
    Publication_name varchar(30),
    primary key (jam_id)
);


create table if not exists Person (
	person_Id integer,
	person_type varchar(32),
	stu_id varchar(10),
	staff_id varchar(10),
	emp_id varchar(10),
	name varchar(30),
	Position varchar(30),
    primary key (person_id)
);


create table if not exists Material (
    Mat_Id varchar(10) not null,
    mat_type varchar (16),
    Book_id varchar(10),
    JAM_id varchar(10),
    name varchar(32),
    primary key (mat_id)
);

create table if not exists return_book(
	ID varchar(10),
    P_id integer,
    m_id varchar(10),
    r_date Date,
    primary key (ID),
    foreign key (p_id) references person(person_id),
    foreign key (m_id) references material(mat_id)
);




create table if not exists no_books(
    P_id integer,
    no_books int,
    foreign key (p_id) references person(person_id)
);


create table if not exists borrow(
	ID varchar(10),
    P_id integer,
    m_id varchar(10),
    b_date Date,
    primary key (ID),
    foreign key (p_id) references person(person_id),
    foreign key (m_id) references material(mat_id)
);

create table if not exists settelments (
	settelments_ID varchar(10),
    Person_id integer,
    mat_id varchar(10),
    amount int,
    primary key (settelments_ID),
    foreign key (person_id) references person (person_id),
    foreign key (mat_id) references material (mat_id)
);

create table if not exists locker (
	locker_id varchar(10),
    availability boolean,
    primary key (locker_id)
);

create table if not exists orders (
	order_id varchar(10),
    order_name varchar(15),
    order_amount int,
    date date,
    primary key (order_id)
);

create table if not exists payment (
	payment_id varchar(10),
    payment_amount int,
    payment_method varchar(15),
    date date,
    primary key (payment_id)
);

create table if not exists product (
	product_id varchar(10),
    product_name varchar(15),
    price int,
    primary key (product_id)
);

create table if not exists QuickShop_list (
	order_id varchar(10),
    product_id varchar(10),
    product_quantity int,
    amount int,
    foreign key (order_id) references orders (order_id),
    foreign key (product_id) references product (product_id)
);

create table if not exists locker_Reserves (
	locker_id varchar(10),
    person_id integer,
    start_date date,
    end_date date,
    foreign key (locker_id) references locker (locker_id),
    foreign key (person_id) references person (person_id)
); 

create table if not exists Faculty(
	facultyId int,
    name varchar(50),
    phone char(16),
    primary key (facultyId)
);

create table if not exists Guest (
	memberId int,
    name varchar(50),
    phone varchar(16), 
    primary key (memberId)
);
 



create table if not exists lab(
	labId char(4),
    capacity int,
    l_type varchar(15),
    primary key (labId)
);

create table if not exists Printer(
	printerId char(4),
    p_type varchar(15),
    location varchar(30),
    primary key (printerId)
);

create table if not exists membership (
    id int,
	memberId int,
    startDate date,
    endDate date,
    primary key (memberId), 
	foreign key (memberId) references Guest(memberId)
);


create table if not exists Studyroom (
	roomId int,
    capacity int,
    occupied bit,
    primary key (roomId)
);

create table if not exists Lecturehall(
	hallId int,
    capacity int,
    occupied bit,
    primary key (hallId)
);

create table if not exists Studyroom_reservation (
	stu_Id varchar(10),
    roomId int, 
    re_Date Date,
    startTime time,
    endTime time,
    primary key (stu_Id, roomId, re_Date), 
	foreign key (stu_Id) references Student(stu_Id), 
    foreign key (roomId) references Studyroom(roomId)
);

create table if not exists Lecturehall_reservation (
    facultyId int, 
	hallId int,
    re_Date Date,
    startTime time,
    endTime time,
    primary key (facultyId, hallId, re_Date), 
    foreign key (facultyId) references Faculty(facultyId),
	foreign key (hallId) references Lecturehall(hallId)
);

DELIMITER $$
create trigger emp 
After insert on Employee for each row
BEGIN
declare id integer;
set id = Auto_gen();
insert into person values (id,"Employee",null,null,new.emp_id,new.name,new.position);
END;
$$
DELIMITER ;
select * from person;
DELIMITER $$
create function Auto_gen() returns integer
READS SQL DATA deterministic
BEGIN
declare count integer;
select count(*) into count from person;
set count =  count + 1;
return count;
END;
$$
DELIMITER ;

DELIMITER $$
create function Auto_genm() returns integer
READS SQL DATA deterministic
BEGIN
declare count integer;
select count(*) into count from Material;
set count =  count + 1;
return count;
END;
$$
DELIMITER ;


DELIMITER $$
create trigger stu 
After insert on Student for each row
BEGIN
declare id integer;
set id = Auto_gen();
insert into person values (id,"Student",new.stu_id,null,null,new.name,new.position);
END;
$$
DELIMITER ;

DELIMITER $$
create trigger staff 
After insert on staff for each row
BEGIN
declare id integer;
set id = Auto_gen();
insert into person values (id,"staff",null,new.staff_id,null,new.name,new.position);
END;
$$
DELIMITER ;


DELIMITER $$
create trigger books 
After insert on books for each row
BEGIN
declare id integer;
set id = Auto_genm();
insert into material values (id,"book",new.book_id,null,new.name);
END;
$$
DELIMITER ;


DELIMITER $$
create trigger JAM 
After insert on JAM for each row
BEGIN
declare id integer;
set id = Auto_genm();
insert into material values (id,"book",null,new.JAM_id,new.name);
END;
$$
DELIMITER ;

insert ignore into Studyroom values(1001, 3, 0),
(1002, 3, 0),
(1003, 3, 0),
(2001, 5, 0),
(2002, 5, 1),
(2003, 5, 1);

insert ignore into Lecturehall values(101, 30, 1),
(102, 30, 1),
(201, 50, 1),
(202, 50, 1),
(301, 100, 0);


insert ignore into Faculty values(2200001, 'Lisa', '435-232-1436'),
(2200002, 'Jack', '435-426-1254'),
(2200003, 'Kevin', '435-433-1856'),
(2200004, 'Mary', '435-334-2376')
;

insert ignore into lab values('L101', 30, 'Computerlab'),
('L102', 30, 'Computerlab'),
('L301', 5, 'VR'),
('L302', 5, 'VR');

insert ignore into Printer values('P101', 'black and white', '1st_floor_north'),
('P102', 'black and white', '1st_floor_north'),
('P103', 'color', '1st_floor_south'),
('P104', 'color', '1st_floor_south');

insert ignore into Guest values(100001, 'Smith', '435-231-1456'),
(100002, 'Bob', '435-456-1234'),
(100003, 'John', '435-233-1756'),
(100004, 'Rebecca', '435-234-1876'),
(100005, 'Jessica', '435-562-1956');

insert ignore into membership values(1, 100001, '2022-06-1', '2022-12-1'),
(2, 100002, '2022-02-1', '2022-08-1'),
(3, 100003, '2021-02-1', '2021-08-1'),
(4, 100004, '2021-06-1', '2021-12-1'),
(5, 100005, '2022-02-1', '2022-05-1');

-- insert ignore into Lecturehall_reservation values(1, 100001, '2022-06-1', '2022-12-1'),
-- (2, 100002, '2022-02-1', '2022-08-1'),
-- (3, 100003, '2021-02-1', '2021-08-1'),
-- (4, 100004, '2021-06-1', '2021-12-1'),
-- (5, 100005, '2022-02-1', '2022-05-1');

insert into employee values("E01","DanJohnson","CS","Lib.Asst");
insert into employee values("E02","NateDonson","AS","Lib.Admin");
insert into employee values("E03","PetePeterson","BI","Lib.Asst");
insert into employee values("E04","AmySantiago","BS","Lib.Asst");
insert into employee values("E05","Trinitythomson","ZS","Lib.Asst");


Insert into student values
("S01","Jakeperalta","1998-10-07","CS","Graduate","CS"),
("S02","TonyAnderson","1976-01-07","CS","Graduate","DS"),
("S03","PeterSmith","1997-05-31","CS","Graduate","CI"),
("S04","SamJose","1999-07-06","CS","Graduate","AI"),
("S05","DaianaDwell","1984-10-31","CS","UNDER Graduate","ML");

Insert into STAFF values
("ST01","JOSEperalta","1998-10-07","CS","ASST.PROF"),
("ST02","TANYAnderson","1976-01-07","CS","ASST.PROF"),
("ST03","SANDYSmith","1997-05-31","CS","PROF"),
("ST04","ROSEJose","1999-07-06","CS","MANAGER"),
("ST05","KATIEDwell","1984-10-31","CS","VICE CHAIR");



Insert into Books values
("B01","Becoming","MichelleObama","Biogarphy","2018",null,"VR publications"),
("B02","Wings of fire","AbdulKalam","Fiction","1999",null,"MK publications"),
("B03","Visualization","AndrewMaltz","Computer","2004","1","sera publications"),
("B04","Python for beginers","AnaBell","Computer","2014","6","code world"),
("B05","How computers works","RonnWhite","Computer","2014","10","HT publications");


Insert into JAM values
("J01","article1","person1","Biogarphy","2009",null,"VR publications"),
("J02","Managazine1","person2","business","2019",null,"MK publications"),
("J03","Journel1","person3","Computer","2004",null,"sera publications"),
("J04","article2","person4","Electrical","2014",null,"code world"),
("J05","article3","person5","Robotics","2016",null,"HT publications");



Insert into return_book values
("R01","1","1","2022-10-31"),
("R02","1","2","2022-11-02"),
("R03","2","3","2022-10-22"),
("R04","2","4","2022-09-08"),
("R05","3","5","2022-10-01");


Insert into borrow values
("B01","1","1","2022-10-24"),
("B02","1","2","2022-11-01"),
("B03","2","3","2022-10-19"),
("B04","2","4","2022-09-01"),
("B05","3","5","2022-09-24");


Insert into locker values
("L01","0"),
("L02","0"),
("L03","1"),
("L04","1"),
("L05","0");


Insert into orders values
("O01","Jake","45","2022-11-21"),
("O02","pete","15","2022-10-22"),
("O03","nate","10","2022-09-20"),
("O04","kyle","30","2022-11-14"),
("O05","lara","35","2022-10-18");


Insert into payment values
("P01","45","card","2022-11-21"),
("P02","15","card","2022-10-22"),
("P03","10","card","2022-09-20"),
("P04","30","cash","2022-11-14"),
("P05","35","venmo","2022-10-18");

 insert into product values 
 ("pr01","icecream","6"),
 ("pr02","icecream","6"),
 ("pr03","salad","10"),
 ("pr04","milkshake","15"),
 ("pr05","coffee","9");
 
 insert into locker_Reserves values 
 ("L01","1","2022-10-11","2022-10-11"),
 ("L02","1","2022-11-21","2022-11-21"),
 ("L03","2","2022-12-15","2022-12-15"),
 ("L04","6","2022-11-13","2022-11-13"),
 ("L05","8","2022-11-04","2022-11-04");

Select name, phone from Faculty f, Lecturehall_reservation l_re
Where f.facultyId = l_re.facultyId and f.facultyId = 2;

Select  startTime, endTime 
from Lecturehall_reservation
Where (facultyId, hallId, re_Date) = (1, 100001, '2022-06-1');

Update Lecturehall
set occupied = 0 
where hallId = 101;

Select * from Studyroom;
Select * from student;
Select * from Studyroom_reservation;
select * from Lecturehall;
Select * from Printer;
Select * from faculty;
Select * from membership;
Select * from guest;

