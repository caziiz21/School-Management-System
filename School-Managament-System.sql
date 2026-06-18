CREATE DATABASE school_db;
GO

USE school_db;
GO

CREATE TABLE teachers
(
    teacher_id INT PRIMARY KEY IDENTITY(1,1),
    teacher_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    phone VARCHAR(20) UNIQUE,
    salary DECIMAL(10,2),
    subject_name VARCHAR(100)
);

INSERT INTO teachers
(teacher_name,gender,phone,salary,subject_name)
VALUES
('Ali Hassan','Male','0611111111',500,'Database'),
('Ahmed Noor','Male','0611111112',450,'Networking'),
('Amina Yusuf','Female','0611111113',600,'Programming'),
('Hodan Ali','Female','0611111114',550,'Web Design'),
('Mohamed Farah','Male','0611111115',700,'Cyber Security'),
('Safa Omar','Female','0611111116',400,'English'),
('Abdi Karim','Male','0611111117',650,'AI'),
('Ikraan Ahmed','Female','0611111118',500,'Data Analysis'),
('Fadumo Nur','Female','0611111119',450,'Accounting'),
('Yasin Ali','Male','0611111120',550,'Business');

CREATE TABLE courses
(
    course_id INT PRIMARY KEY IDENTITY(1,1),
    course_name VARCHAR(100),
    duration_months INT,
    teacher_id INT,

    FOREIGN KEY (teacher_id)
    REFERENCES teachers(teacher_id)
);

INSERT INTO courses
(course_name,duration_months,teacher_id)
VALUES
('Database',6,1),
('Networking',5,2),
('Programming',8,3),
('Web Design',4,4),
('Cyber Security',7,5),
('English',3,6),
('AI',9,7),
('Data Analysis',6,8),
('Accounting',5,9),
('Business',6,10);

CREATE TABLE students
(
    student_id INT PRIMARY KEY IDENTITY(1,1),
    full_name VARCHAR(100),
    gender VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100),

    course_id INT,

    fee_amount DECIMAL(10,2),
    paid_amount DECIMAL(10,2),

    fee_status VARCHAR(20),

    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
);

INSERT INTO students
(full_name,gender,phone,email,course_id,
fee_amount,paid_amount,fee_status)
VALUES
('Abdi Ahmed','Male','0622222221','abdi@gmail.com',1,500,500,'Paid'),
('Asha Ali','Female','0622222222','asha@gmail.com',2,500,300,'Unpaid'),
('Mohamed Hassan','Male','0622222223','mohamed@gmail.com',3,600,600,'Paid'),
('Hodan Nur','Female','0622222224','hodan@gmail.com',4,400,200,'Unpaid'),
('Yusuf Omar','Male','0622222225','yusuf@gmail.com',5,700,700,'Paid'),
('Fadumo Ali','Female','0622222226','fadumo@gmail.com',6,300,100,'Unpaid'),
('Ahmed Yusuf','Male','0622222227','ahmed@gmail.com',7,800,800,'Paid'),
('Safa Hassan','Female','0622222228','safa@gmail.com',8,500,400,'Unpaid'),
('Ali Noor','Male','0622222229','ali@gmail.com',9,450,450,'Paid'),
('Ikraan Mohamed','Female','0622222230','ikraan@gmail.com',10,600,300,'Unpaid');

CREATE TABLE attendance
(
    attendance_id INT PRIMARY KEY IDENTITY(1,1),

    student_id INT,

    attendance_date DATE,

    status VARCHAR(20),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id)
);

INSERT INTO attendance
(student_id,attendance_date,status)
VALUES
(1,'2026-05-01','Present'),
(2,'2026-05-01','Absent'),
(3,'2026-05-01','Present'),
(4,'2026-05-01','Present'),
(5,'2026-05-01','Absent'),
(6,'2026-05-01','Present'),
(7,'2026-05-01','Present'),
(8,'2026-05-01','Absent'),
(9,'2026-05-01','Present'),
(10,'2026-05-01','Present');

CREATE TABLE marks
(
    mark_id INT PRIMARY KEY IDENTITY(1,1),

    student_id INT,

    subject_name VARCHAR(100),

    marks INT,

    grade VARCHAR(5),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id)
);

INSERT INTO marks
(student_id,subject_name,marks,grade)
VALUES
(1,'Database',90,'A'),
(2,'Networking',70,'B'),
(3,'Programming',95,'A'),
(4,'Web Design',60,'C'),
(5,'Cyber Security',88,'A'),
(6,'English',55,'C'),
(7,'AI',98,'A'),
(8,'Data Analysis',75,'B'),
(9,'Accounting',80,'B'),
(10,'Business',65,'C');

CREATE TABLE payments
(
    payment_id INT PRIMARY KEY IDENTITY(1,1),

    student_id INT,

    payment_date DATE,

    amount_paid DECIMAL(10,2),

    payment_method VARCHAR(50),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id)
);

INSERT INTO payments
(student_id,payment_date,amount_paid,payment_method)
VALUES
(1,'2026-05-01',500,'EVC'),
(2,'2026-05-01',300,'Cash'),
(3,'2026-05-01',600,'Bank'),
(4,'2026-05-01',200,'EVC'),
(5,'2026-05-01',700,'Cash'),
(6,'2026-05-01',100,'Bank'),
(7,'2026-05-01',800,'EVC'),
(8,'2026-05-01',400,'Cash'),
(9,'2026-05-01',450,'Bank'),
(10,'2026-05-01',300,'EVC');



select *from students

select full_name,phone from students

select *from students
where fee_status='Paid'

select *from students
where fee_status='Unpaid'

select *from students
where course_id=3

select *from students
order by paid_amount desc

select grade from marks
order by grade asc

select count(*)from students

select sum(amount_paid)from payments

select Avg(marks)from marks

select max(marks)from marks

select min(marks)from marks

select full_name,course_name
from students join courses
on students.course_id=courses.course_id

select teacher_name,course_name
from teachers join courses
on teachers.teacher_id=courses.teacher_id

select full_name,subject_name,marks
from students join marks
on students.student_id=marks.student_id

select full_name,amount_paid
from students join payments
on students.student_id=payments.student_id

select course_name,count(*)
from courses
group by course_name

select course_name,Avg(marks) As Avg_marks
from courses join students on 
courses.course_id=students.course_id
join marks on marks.student_id=students.student_id
group by course_name

select course_name, sum(fee_amount)As total_fee
from courses join students 
on courses.course_id=students.course_id
group by course_name

select*,Row_number()over(order by marks desc)As num1 from marks


SELECT
    s.full_name,
    m.marks,
    RANK() OVER(ORDER BY m.marks DESC) AS ranking
FROM students s
INNER JOIN marks m
    ON s.student_id = m.student_id;


CREATE VIEW vw_paid_students
AS
SELECT *
FROM students
WHERE fee_status='Paid';



CREATE VIEW vw_top_students
AS
SELECT s.full_name,
       m.marks
FROM students s
INNER JOIN marks m
ON s.student_id=m.student_id
WHERE m.marks>=90;


CREATE PROC sp_all_students
AS
BEGIN
    SELECT *
    FROM students;
END;



CREATE PROC sp_paid_students
AS
BEGIN
    SELECT *
    FROM students
    WHERE fee_status='Paid';
END;



EXEC sp_paid_students


CREATE TRIGGER trg_delete_student
ON students
AFTER DELETE
AS
BEGIN
    PRINT 'Student deleted successfully';
END;


CREATE TRIGGER trg_update_fee_status
ON students
AFTER UPDATE
AS
BEGIN
    UPDATE students
    SET fee_status='Paid'
    WHERE paid_amount=fee_amount;

    UPDATE students
    SET fee_status='Unpaid'
    WHERE paid_amount<fee_amount;
END;



BEGIN TRANSACTION;

UPDATE students
SET paid_amount=500
WHERE student_id=2;

COMMIT;


SELECT
    s.full_name,
    m.marks,
    ROW_NUMBER() OVER(ORDER BY m.marks DESC) AS row_num
FROM students s
INNER JOIN marks m
ON s.student_id=m.student_id;



SELECT
    s.full_name,
    m.marks,
    RANK() OVER(ORDER BY m.marks DESC) AS ranking
FROM students s
INNER JOIN marks m
ON s.student_id=m.student_id;



SELECT
    s.full_name,
    m.marks,
    DENSE_RANK() OVER(ORDER BY m.marks DESC) AS ranking
FROM students s
INNER JOIN marks m
ON s.student_id=m.student_id;





