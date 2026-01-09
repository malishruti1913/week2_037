create database college_db;
Query OK, 1 row affected (0.04 sec)

mysql> use college_db;
Database changed
mysql> create table deparments(department_id int primary key,deparment_name varchar(50) not null);
Query OK, 0 rows affected (0.07 sec)

mysql> desc deparments;
+----------------+-------------+------+-----+---------+-------+
| Field          | Type        | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| department_id  | int         | NO   | PRI | NULL    |       |
| deparment_name | varchar(50) | NO   |     | NULL    |       |
+----------------+-------------+------+-----+---------+-------+
2 rows in set (0.02 sec)

mysql> create table students( student_id int primary key,name varchar(50),email varchar(50) unique,gender varchar(10),dob date,department_id int,foreign key(department_id) references departments(department_id));
ERROR 1824 (HY000): Failed to open the referenced table 'departments'
mysql> create table students( student_id int primary key,name varchar(50),email varchar(50) unique,gender varchar(10),dob date,department_id int,foreign key(department_id) references deparments(department_id));
Query OK, 0 rows affected (0.05 sec)

mysql> desc students;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| student_id    | int         | NO   | PRI | NULL    |       |
| name          | varchar(50) | YES  |     | NULL    |       |
| email         | varchar(50) | YES  | UNI | NULL    |       |
| gender        | varchar(10) | YES  |     | NULL    |       |
| dob           | date        | YES  |     | NULL    |       |
| department_id | int         | YES  | MUL | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
6 rows in set (0.00 sec)

mysql> create table courses(course_id int primary key,course_name varchar(50),department_id int,credits int check(credits>0),foregin key(department_id)references deparments(department_id));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'key(department_id)references deparments(department_id))' at line 1
mysql> CREATE TABLE Courses (
    ->     course_id INT PRIMARY KEY,
    ->     course_name VARCHAR(50),
    ->     department_id INT,
    ->     credits INT CHECK (credits > 0),
    ->     FOREIGN KEY (department_id) REFERENCES Departments(department_id)
    -> );
ERROR 1824 (HY000): Failed to open the referenced table 'departments'
mysql> CREATE TABLE Courses (
    ->     course_id INT PRIMARY KEY,
    ->     course_name VARCHAR(50),
    ->     department_id INT,
    ->     credits INT CHECK (credits > 0),
    ->     FOREIGN KEY (department_id) REFERENCES Deparments(department_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> desc courses;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| course_id     | int         | NO   | PRI | NULL    |       |
| course_name   | varchar(50) | YES  |     | NULL    |       |
| department_id | int         | YES  | MUL | NULL    |       |
| credits       | int         | YES  |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> CREATE TABLE Enrollments (
    ->     enrollment_id INT PRIMARY KEY,
    ->     student_id INT,
    ->     course_id INT,
    ->     enrollment_date DATE,
    ->     FOREIGN KEY (student_id) REFERENCES Students(student_id),
    ->     FOREIGN KEY (course_id) REFERENCES Courses(course_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> desc Enrollments;
+-----------------+------+------+-----+---------+-------+
| Field           | Type | Null | Key | Default | Extra |
+-----------------+------+------+-----+---------+-------+
| enrollment_id   | int  | NO   | PRI | NULL    |       |
| student_id      | int  | YES  | MUL | NULL    |       |
| course_id       | int  | YES  | MUL | NULL    |       |
| enrollment_date | date | YES  |     | NULL    |       |
+-----------------+------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> CREATE TABLE Marks (
    ->     mark_id INT PRIMARY KEY,
    ->     student_id INT,
    ->     course_id INT,
    ->     marks_obtained INT CHECK (marks_obtained BETWEEN 0 AND 100),
    ->     FOREIGN KEY (student_id) REFERENCES Students(student_id),
    ->     FOREIGN KEY (course_id) REFERENCES Courses(course_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> desc Marks;
+----------------+------+------+-----+---------+-------+
| Field          | Type | Null | Key | Default | Extra |
+----------------+------+------+-----+---------+-------+
| mark_id        | int  | NO   | PRI | NULL    |       |
| student_id     | int  | YES  | MUL | NULL    |       |
| course_id      | int  | YES  | MUL | NULL    |       |
| marks_obtained | int  | YES  |     | NULL    |       |
+----------------+------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> INSERT INTO Departments VALUES
    -> (1,'Computer Science'),
    -> (2,'Mechanical'),
    -> (3,'Electrical'),
    -> (4,'Civil'),
    -> (5,'Electronics');
ERROR 1146 (42S02): Table 'college_db.departments' doesn't exist
mysql> INSERT INTO Deparments VALUES
    -> (1,'Computer Science'),
    -> (1,'Computer Science'),
    -> ^C
mysql> INSERT INTO Deparments VALUES
    -> (1,'Computer Science'),
    -> (2,'Mechanical'),
    -> (3,'Electrical'),
    -> (4,'Civil'),
    -> (5,'Electronics');
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select *from deparments;
+---------------+------------------+
| department_id | deparment_name   |
+---------------+------------------+
|             1 | Computer Science |
|             2 | Mechanical       |
|             3 | Electrical       |
|             4 | Civil            |
|             5 | Electronics      |
+---------------+------------------+
5 rows in set (0.00 sec)

mysql> INSERT INTO Students VALUES
    -> (1,'Amit','amit@gmail.com','Male','2002-01-10',1),
    -> (2,'Neha','neha@gmail.com','Female','2001-02-12',1),
    -> (3,'Rohit','rohit@gmail.com','Male','2002-03-15',2),
    -> (4,'Pooja','pooja@gmail.com','Female','2001-04-18',3),
    -> (5,'Kiran','kiran@gmail.com','Male','2002-05-20',4),
    -> (6,'Sneha','sneha@gmail.com','Female','2001-06-22',5),
    -> (7,'Rahul','rahul@gmail.com','Male','2002-07-25',1),
    -> (8,'Anita','anita@gmail.com','Female','2001-08-28',2),
    -> (9,'Suresh','suresh@gmail.com','Male','2002-09-30',3),
    -> (10,'Meena','meena@gmail.com','Female','2001-10-05',4);
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select *from students;
+------------+--------+------------------+--------+------------+---------------+
| student_id | name   | email            | gender | dob        | department_id |
+------------+--------+------------------+--------+------------+---------------+
|          1 | Amit   | amit@gmail.com   | Male   | 2002-01-10 |             1 |
|          2 | Neha   | neha@gmail.com   | Female | 2001-02-12 |             1 |
|          3 | Rohit  | rohit@gmail.com  | Male   | 2002-03-15 |             2 |
|          4 | Pooja  | pooja@gmail.com  | Female | 2001-04-18 |             3 |
|          5 | Kiran  | kiran@gmail.com  | Male   | 2002-05-20 |             4 |
|          6 | Sneha  | sneha@gmail.com  | Female | 2001-06-22 |             5 |
|          7 | Rahul  | rahul@gmail.com  | Male   | 2002-07-25 |             1 |
|          8 | Anita  | anita@gmail.com  | Female | 2001-08-28 |             2 |
|          9 | Suresh | suresh@gmail.com | Male   | 2002-09-30 |             3 |
|         10 | Meena  | meena@gmail.com  | Female | 2001-10-05 |             4 |
+------------+--------+------------------+--------+------------+---------------+
10 rows in set (0.00 sec)

mysql> INSERT INTO Courses VALUES
    -> (101,'DBMS',1,4),
    -> (102,'OS',1,3),
    -> (103,'Thermodynamics',2,4),
    -> (104,'Circuits',3,3),
    -> (105,'Structures',4,4),
    -> (106,'VLSI',5,3),
    -> (107,'Data Structures',1,4),
    -> (108,'Machine Design',2,4);
Query OK, 8 rows affected (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> select *from courses;
+-----------+-----------------+---------------+---------+
| course_id | course_name     | department_id | credits |
+-----------+-----------------+---------------+---------+
|       101 | DBMS            |             1 |       4 |
|       102 | OS              |             1 |       3 |
|       103 | Thermodynamics  |             2 |       4 |
|       104 | Circuits        |             3 |       3 |
|       105 | Structures      |             4 |       4 |
|       106 | VLSI            |             5 |       3 |
|       107 | Data Structures |             1 |       4 |
|       108 | Machine Design  |             2 |       4 |
+-----------+-----------------+---------------+---------+
8 rows in set (0.00 sec)

mysql> INSERT INTO Enrollments VALUES
    -> (1,1,101,'2025-01-01'),
    -> (2,1,102,'2025-01-02'),
    -> (3,2,101,'2025-01-03'),
    -> (4,3,103,'2025-01-04'),
    -> (5,4,104,'2025-01-05'),
    -> (6,5,105,'2025-01-06'),
    -> (7,6,106,'2025-01-07'),
    -> (8,7,107,'2025-01-08'),
    -> (9,8,108,'2025-01-09'),
    -> (10,9,104,'2025-01-10'),
    -> (11,10,105,'2025-01-11'),
    -> (12,2,102,'2025-01-12'),
    -> (13,3,108,'2025-01-13'),
    -> (14,4,101,'2025-01-14'),
    -> (15,5,103,'2025-01-15');
Query OK, 15 rows affected (0.01 sec)
Records: 15  Duplicates: 0  Warnings: 0

mysql> select *from Enrollments;
+---------------+------------+-----------+-----------------+
| enrollment_id | student_id | course_id | enrollment_date |
+---------------+------------+-----------+-----------------+
|             1 |          1 |       101 | 2025-01-01      |
|             2 |          1 |       102 | 2025-01-02      |
|             3 |          2 |       101 | 2025-01-03      |
|             4 |          3 |       103 | 2025-01-04      |
|             5 |          4 |       104 | 2025-01-05      |
|             6 |          5 |       105 | 2025-01-06      |
|             7 |          6 |       106 | 2025-01-07      |
|             8 |          7 |       107 | 2025-01-08      |
|             9 |          8 |       108 | 2025-01-09      |
|            10 |          9 |       104 | 2025-01-10      |
|            11 |         10 |       105 | 2025-01-11      |
|            12 |          2 |       102 | 2025-01-12      |
|            13 |          3 |       108 | 2025-01-13      |
|            14 |          4 |       101 | 2025-01-14      |
|            15 |          5 |       103 | 2025-01-15      |
+---------------+------------+-----------+-----------------+
15 rows in set (0.00 sec)

mysql> INSERT INTO Marks VALUES
    -> (1,1,101,85),
    -> (2,1,102,78),
    -> (3,2,101,90),
    -> (4,3,103,70),
    -> (5,4,104,88),
    -> (6,5,105,60),
    -> (7,6,106,75),
    -> (8,7,107,92),
    -> (9,8,108,65),
    -> (10,9,104,80);
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select *from Marks;
+---------+------------+-----------+----------------+
| mark_id | student_id | course_id | marks_obtained |
+---------+------------+-----------+----------------+
|       1 |          1 |       101 |             85 |
|       2 |          1 |       102 |             78 |
|       3 |          2 |       101 |             90 |
|       4 |          3 |       103 |             70 |
|       5 |          4 |       104 |             88 |
|       6 |          5 |       105 |             60 |
|       7 |          6 |       106 |             75 |
|       8 |          7 |       107 |             92 |
|       9 |          8 |       108 |             65 |
|      10 |          9 |       104 |             80 |
+---------+------------+-----------+----------------+
10 rows in set (0.00 sec)

mysql> SELECT student_id, name, email, gender, dob, department_id
    -> FROM Students;
+------------+--------+------------------+--------+------------+---------------+
| student_id | name   | email            | gender | dob        | department_id |
+------------+--------+------------------+--------+------------+---------------+
|          1 | Amit   | amit@gmail.com   | Male   | 2002-01-10 |             1 |
|          2 | Neha   | neha@gmail.com   | Female | 2001-02-12 |             1 |
|          3 | Rohit  | rohit@gmail.com  | Male   | 2002-03-15 |             2 |
|          4 | Pooja  | pooja@gmail.com  | Female | 2001-04-18 |             3 |
|          5 | Kiran  | kiran@gmail.com  | Male   | 2002-05-20 |             4 |
|          6 | Sneha  | sneha@gmail.com  | Female | 2001-06-22 |             5 |
|          7 | Rahul  | rahul@gmail.com  | Male   | 2002-07-25 |             1 |
|          8 | Anita  | anita@gmail.com  | Female | 2001-08-28 |             2 |
|          9 | Suresh | suresh@gmail.com | Male   | 2002-09-30 |             3 |
|         10 | Meena  | meena@gmail.com  | Female | 2001-10-05 |             4 |
+------------+--------+------------------+--------+------------+---------------+
10 rows in set (0.00 sec)

mysql> SELECT student_id, name
    -> FROM Students
    -> WHERE department_id = 2;
+------------+-------+
| student_id | name  |
+------------+-------+
|          3 | Rohit |
|          8 | Anita |
+------------+-------+
2 rows in set (0.01 sec)

mysql> SELECT C.course_id, C.course_name, D.department_name
    -> FROM Courses C, Departments D
    -> WHERE C.department_id = D.department_id;
ERROR 1146 (42S02): Table 'college_db.departments' doesn't exist
mysql> FROM Courses C, Deparments D
    -> WHERE department_id = 2;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'FROM Courses C, Deparments D
WHERE department_id = 2' at line 1
mysql> SELECT C.course_id, C.course_name, D.department_name
    -> FROM Courses C, Deparments D
    -> WHERE C.department_id = D.department_id;
ERROR 1054 (42S22): Unknown column 'D.department_name' in 'field list'
mysql> SELECT C.course_id, C.course_name, D.deparment_name
    -> FROM Courses C, Deparments D
    -> WHERE C.department_id = D.department_id;
+-----------+-----------------+------------------+
| course_id | course_name     | deparment_name   |
+-----------+-----------------+------------------+
|       101 | DBMS            | Computer Science |
|       102 | OS              | Computer Science |
|       107 | Data Structures | Computer Science |
|       103 | Thermodynamics  | Mechanical       |
|       108 | Machine Design  | Mechanical       |
|       104 | Circuits        | Electrical       |
|       105 | Structures      | Civil            |
|       106 | VLSI            | Electronics      |
+-----------+-----------------+------------------+
8 rows in set (0.00 sec)

mysql> SELECT C.course_id, C.course_name, D.department_name
    -> FROM Courses C, Departments D
    -> WHERE C.department_id = D.depar^C
mysql> SELECT student_id
    -> FROM Enrollments
    -> GROUP BY student_id
    -> HAVING COUNT(*) >= 2;
+------------+
| student_id |
+------------+
|          1 |
|          2 |
|          3 |
|          4 |
|          5 |
+------------+
5 rows in set (0.01 sec)

mysql> SELECT student_id, marks_obtained
    -> FROM Marks
    -> WHERE marks_obtained > 75;
+------------+----------------+
| student_id | marks_obtained |
+------------+----------------+
|          1 |             85 |
|          1 |             78 |
|          2 |             90 |
|          4 |             88 |
|          7 |             92 |
|          9 |             80 |
+------------+----------------+
6 rows in set (0.00 sec)

mysql> SELECT S.name, C.course_name, M.marks_obtained
    -> FROM Marks M
    -> JOIN Students S ON M.student_id = S.student_id
    -> JOIN Courses C ON M.course_id = C.course_id;
+--------+-----------------+----------------+
| name   | course_name     | marks_obtained |
+--------+-----------------+----------------+
| Amit   | DBMS            |             85 |
| Neha   | DBMS            |             90 |
| Amit   | OS              |             78 |
| Rohit  | Thermodynamics  |             70 |
| Pooja  | Circuits        |             88 |
| Suresh | Circuits        |             80 |
| Kiran  | Structures      |             60 |
| Sneha  | VLSI            |             75 |
| Rahul  | Data Structures |             92 |
| Anita  | Machine Design  |             65 |
+--------+-----------------+----------------+
10 rows in set (0.00 sec)

mysql> SELECT name FROM Students
    -> WHERE student_id NOT IN (SELECT student_id FROM Marks);
+-------+
| name  |
+-------+
| Meena |
+-------+
1 row in set (0.01 sec)

mysql> SELECT department_id, COUNT(*) AS total_students
    -> FROM Students
    -> GROUP BY department_id;
+---------------+----------------+
| department_id | total_students |
+---------------+----------------+
|             1 |              3 |
|             2 |              2 |
|             3 |              2 |
|             4 |              2 |
|             5 |              1 |
+---------------+----------------+
5 rows in set (0.00 sec)

mysql> SELECT course_id, AVG(marks_obtained) AS avg_marks
    -> FROM Marks
    -> GROUP BY course_id;
+-----------+-----------+
| course_id | avg_marks |
+-----------+-----------+
|       101 |   87.5000 |
|       102 |   78.0000 |
|       103 |   70.0000 |
|       104 |   84.0000 |
|       105 |   60.0000 |
|       106 |   75.0000 |
|       107 |   92.0000 |
|       108 |   65.0000 |
+-----------+-----------+
8 rows in set (0.00 sec)

mysql> SELECT student_id FROM Marks
    -> WHERE marks_obtained >
    -> (SELECT AVG(marks_obtained) FROM Marks);
+------------+
| student_id |
+------------+
|          1 |
|          2 |
|          4 |
|          7 |
|          9 |
+------------+
5 rows in set (0.01 sec)

mysql> SELECT student_id FROM Marks
    -> WHERE marks_obtained =
    -> (SELECT MAX(marks_obtained) FROM Marks);
+------------+
| student_id |
+------------+
|          7 |
+------------+
1 row in set (0.00 sec)

mysql> SELECT course_id FROM Courses
    -> WHERE course_id NOT IN
    -> (SELECT course_id FROM Enrollments);
Empty set (0.00 sec)

mysql>
mysql> SELECT student_id FROM Students
    -> WHERE department_id =
    -> (SELECT department_id FROM Departments
    ->  WHERE department_name='Computer Science');
ERROR 1146 (42S02): Table 'college_db.departments' doesn't exist
mysql> SELECT student_id FROM Students
    -> WHERE department_id =
    -> (SELECT department_id FROM Deparments
    ->  WHERE department_name='Computer Science');
ERROR 1054 (42S22): Unknown column 'department_name' in 'where clause'
mysql> SELECT student_id FROM Students
    -> WHERE department_id =
    -> (SELECT department_id FROM Deparments
    ->  WHERE deparment_name='Computer Science');
+------------+
| student_id |
+------------+
|          1 |
|          2 |
|          7 |
+------------+
3 rows in set (0.00 sec)

mysql> SELECT S.name, C.course_name, M.marks_obtained
    -> FROM Marks M
    -> JOIN Students S ON M.student_id = S.student_id
    -> JOIN Courses C ON M.course_id = C.course_id;
+--------+-----------------+----------------+
| name   | course_name     | marks_obtained |
+--------+-----------------+----------------+
| Amit   | DBMS            |             85 |
| Neha   | DBMS            |             90 |
| Amit   | OS              |             78 |
| Rohit  | Thermodynamics  |             70 |
| Pooja  | Circuits        |             88 |
| Suresh | Circuits        |             80 |
| Kiran  | Structures      |             60 |
| Sneha  | VLSI            |             75 |
| Rahul  | Data Structures |             92 |
| Anita  | Machine Design  |             65 |
+--------+-----------------+----------------+
10 rows in set (0.00 sec)

mysql> SELECT D.department_name, AVG(M.marks_obtained) AS avg_marks
    -> FROM Marks M
    -> JOIN Courses C ON M.course_id = C.course_id
    -> JOIN Departments D ON C.department_id = D.department_id
    -> GROUP BY D.department_name;
ERROR 1146 (42S02): Table 'college_db.departments' doesn't exist
mysql> SELECT D.department_name, AVG(M.marks_obtained) AS avg_marks
    -> FROM Marks M
    -> JOIN Courses C ON M.course_id = C.course_id
    -> JOIN Deparments D ON C.department_id = D.department_id
    -> GROUP BY D.department_name;
ERROR 1054 (42S22): Unknown column 'D.department_name' in 'field list'
mysql> SELECT D.department_name, AVG(M.marks_obtained) AS avg_marks
    -> FROM Marks M
    -> JOIN Courses C ON M.course_id = C.course_id
    -> JOIN Deparments D ON C.department_id = D.department_id
    -> GROUP BY D.deparment_name;
ERROR 1054 (42S22): Unknown column 'D.department_name' in 'field list'
mysql> DELIMITER //
mysql> CREATE PROCEDURE student_marks(IN sid INT)
    -> BEGIN
    ->     SELECT C.course_name, M.marks_obtained
    ->     FROM Marks M
    ->     JOIN Courses C ON M.course_id = C.course_id
    ->     WHERE M.student_id = sid;
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql> DELIMITER ;
mysql> call procedure students_marks;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'procedure students_marks' at line 1
mysql> call  students_marks;
ERROR 1305 (42000): PROCEDURE college_db.students_marks does not exist
mysql> DELIMITER //
mysql> CREATE FUNCTION get_grade(marks INT)
    -> RETURNS VARCHAR(10)
    -> DETERMINISTIC
    -> BEGIN
    ->     IF marks >= 75 THEN RETURN 'A';
    ->     ELSEIF marks >= 60 THEN RETURN 'B';
    ->     ELSEIF marks >= 40 THEN RETURN 'C';
    ->     ELSE RETURN 'Fail';
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> DELIMITER //
mysql> CREATE TRIGGER check_marks
    -> BEFORE INSERT ON Marks
    -> FOR EACH ROW
    -> BEGIN
    ->     IF NEW.marks_obtained > 100 THEN
    ->         SIGNAL SQLSTATE '45000'
    ->         SET MESSAGE_TEXT = 'Marks cannot be greater than 100';
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql> DELIMITER ;
mysql> SELECT S.name AS Student_Name,
    ->        C.course_name AS Course_Name,
    ->        M.marks_obtained AS Marks,
    ->        get_grade(M.marks_obtained) AS Grade
    -> FROM Marks M
    -> JOIN Students S ON M.student_id = S.student_id
    -> JOIN Courses C ON M.course_id = C.course_id;
+--------------+-----------------+-------+-------+
| Student_Name | Course_Name     | Marks | Grade |
+--------------+-----------------+-------+-------+
| Amit         | DBMS            |    85 | A     |
| Neha         | DBMS            |    90 | A     |
| Amit         | OS              |    78 | A     |
| Rohit        | Thermodynamics  |    70 | B     |
| Pooja        | Circuits        |    88 | A     |
| Suresh       | Circuits        |    80 | A     |
| Kiran        | Structures      |    60 | B     |
| Sneha        | VLSI            |    75 | A     |
| Rahul        | Data Structures |    92 | A     |
| Anita        | Machine Design  |    65 | B     |
+--------------+-----------------+-------+-------+
10 rows in set (0.01 sec)