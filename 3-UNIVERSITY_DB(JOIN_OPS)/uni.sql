create database university;
use university;

create table course (course_name varchar(50),course_number varchar(10) primary key,credit_hours int,department varchar(10));
create table student (sname varchar(20),student_number varchar(10) primary key, class int,major varchar(10));
create table section (section_identifier varchar(10) primary key,course_number varchar(10), foreign key(course_number) references course(course_number),semester varchar(10),year int, instructor varchar(20));
create table grade_report(student_number varchar(20), foreign key(student_number) references student(student_number), section_identifier varchar(20), grade varchar(20), foreign key(section_identifier) references section(section_identifier));
create table prerequisite(course_number varchar(20), foreign key(course_number) references course(course_number),prerequisite_number varchar(20));
insert into student values('Smith','17',1,'CS');
insert into student values('Brown','8',2,'CS');
insert into student values('Alex','15',4,'CS');

insert into course values('intro to computer science','CS1310',4,'CS');
insert into course values('DATA STRUCTURES','CS3320',4,'CS');
insert into course values('DISCRETE MATHEMATICS','MATH2410',3,'MATH');
insert into course values('DATABASE','CS3380',3,'CS');
INSERT INTO section VALUES('85','MATH2410','FALL','07','KING');
INSERT INTO section VALUES('92','CS1310','FALL','07','ANDERSON');
INSERT INTO section VALUES('102','CS3320','SPRING','08','KNUTH');
INSERT INTO section VALUES('112','MATH2410','FALL','08','CHANG');
INSERT INTO section VALUES('119','CS1310','FALL','08','ANDERSON');
INSERT INTO section VALUES('135','CS3380','FALL','08','STONE');
INSERT INTO grade_report values('17','112','B');
INSERT INTO grade_report values('17','119','C');
INSERT INTO grade_report values('8','85','A');
INSERT INTO grade_report values('8','92','A');
INSERT INTO grade_report values('8','102','B');
INSERT INTO grade_report values('8','135','A');
INSERT INTO grade_report values('15','135','A');

INSERT INTO prerequisite values('CS3380','CS3320');
INSERT INTO prerequisite values('CS3380','MATH2410');
INSERT INTO prerequisite values('CS3320','CS1310');

#select course_number from section where section_identifier in (select section_identifier from grade_report where student_number="17" );




#3. Retrieve the list of all courses and gradesof‘Smith’
SELECT student.sname,grade_report.grade,course.course_name FROM student INNER JOIN grade_report ON student.student_number=grade_report.student_number INNER JOIN section ON grade_report.section_identifier=section.section_identifier INNER JOIN  course ON section.course_number=course.course_number WHERE student.sname='Smith';

#4. List the names of students who took the section of the ‘Database’ course offered in fall 2008 and their grades in that section.
SELECT student.sname,grade_report.grade,course.course_name FROM student INNER JOIN grade_report ON student.student_number=grade_report.student_number INNER JOIN section ON grade_report.section_identifier=section.section_identifier INNER JOIN  course ON section.course_number=course.course_number WHERE course.course_name='Database' AND section.semester='fall' AND section.year='08';

#5. List the prerequisites of the ‘Database’ course.	
SELECT prerequisite.prerequisite_number FROM prerequisite INNER JOIN course ON prerequisite.course_number=course.course_number WHERE course.course_name='Database';

#6. Retrieve the names of all senior students majoring in‘CS’(computerscience).
select sname from student where major='CS' and class=4;

#7. Retrieve the names of all courses taught by Professor King in 2007 and 2008.
SELECT course.course_name FROM section INNER JOIN course ON section.course_number=course.course_number WHERE section.instructor='king' AND section.year IN('07','08'); 

#8. For each section taught by Professor King, retrieve the course number,semester, year, and number of students who took the section
SELECT section.course_number,section.semester,section.year,count(DISTINCT grade_report.student_number) FROM section INNER JOIN grade_report ON grade_report.section_identifier=section.section_identifier WHERE section.instructor='king' GROUP BY grade_report.section_identifier;

#9. Retrieve the name and transcript of each senior student (Class = 4)majoring in CS. A transcript includes course name, course number, credit hours, semester, year, and grade for each course completed by the student.
SELECT student.sname,course.course_name,course.course_number,course.credit_hours,section.semester,section.year,grade_report.grade FROM student INNER JOIN grade_report ON grade_report.student_number=student.student_number INNER JOIN section ON section.section_identifier=grade_report.section_identifier INNER JOIN course ON course.course_number=section.course_number WHERE student.class=4;

#10 Write SQL update statements to do the following on the database schema
#A.Insertanewstudent,<‘Johnson’,25,1,‘Math’>,inthedatabase.
INSERT INTO student VALUES(25,'johnson',1,'Math');		
SELECT * FROM student;
								
#B.Change the class of student ‘Smith’ t o2.
UPDATE student SET class=2 WHERE sname='Smith';
SELECT * FROM student;

#C.Insertanewcourse,<‘KnowledgeEngineering’,‘CS4390’,3,‘CS’>
INSERT INTO course VALUES('KnowledgeEngineering','CS4390',3,'cs');
SELECT * FROM course;

#D.Delete therecord forthestudentwhose nameis ‘Smith’and whosestudent number is17.
DELETE FROM student WHERE sname='Smith' AND student_number=17;
SELECT * FROM student;

