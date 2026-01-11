CREATE DATABASE college_db;
USE college_db;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    gender VARCHAR(10),
    dob DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    department_id INT,
    credits INT CHECK (credits > 0),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks_obtained INT CHECK (marks_obtained BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Departments VALUES
(1,'Computer Science'),
(2,'Mechanical'),
(3,'Electrical'),
(4,'Civil'),
(5,'Electronics');

INSERT INTO Students VALUES
(1,'Amit','amit@gmail.com','Male','2002-01-10',1),
(2,'Neha','neha@gmail.com','Female','2001-02-12',1),
(3,'Rohit','rohit@gmail.com','Male','2002-03-15',2),
(4,'Pooja','pooja@gmail.com','Female','2001-04-18',3),
(5,'Kiran','kiran@gmail.com','Male','2002-05-20',4),
(6,'Sneha','sneha@gmail.com','Female','2001-06-22',5),
(7,'Rahul','rahul@gmail.com','Male','2002-07-25',1),
(8,'Anita','anita@gmail.com','Female','2001-08-28',2),
(9,'Suresh','suresh@gmail.com','Male','2002-09-30',3),
(10,'Meena','meena@gmail.com','Female','2001-10-05',4);

INSERT INTO Courses VALUES
(101,'DBMS',1,4),
(102,'OS',1,3),
(103,'Thermodynamics',2,4),
(104,'Circuits',3,3),
(105,'Structures',4,4),
(106,'VLSI',5,3),
(107,'Data Structures',1,4),
(108,'Machine Design',2,4);

INSERT INTO Enrollments VALUES
(1,1,101,'2025-01-01'),
(2,1,102,'2025-01-02'),
(3,2,101,'2025-01-03'),
(4,3,103,'2025-01-04'),
(5,4,104,'2025-01-05'),
(6,5,105,'2025-01-06'),
(7,6,106,'2025-01-07'),
(8,7,107,'2025-01-08'),
(9,8,108,'2025-01-09'),
(10,9,104,'2025-01-10'),
(11,10,105,'2025-01-11'),
(12,2,102,'2025-01-12'),
(13,3,108,'2025-01-13'),
(14,4,101,'2025-01-14'),
(15,5,103,'2025-01-15');

INSERT INTO Marks VALUES
(1,1,101,85),
(2,1,102,78),
(3,2,101,90),
(4,3,103,70),
(5,4,104,88),
(6,5,105,60),
(7,6,106,75),
(8,7,107,92),
(9,8,108,65),
(10,9,104,80);

SELECT * FROM Students;

SELECT * FROM Students WHERE department_id = 2;

SELECT C.course_name, D.department_name
FROM Courses C
JOIN Departments D ON C.department_id = D.department_id;

SELECT student_id
FROM Enrollments
GROUP BY student_id
HAVING COUNT(course_id) > 1;

SELECT DISTINCT student_id
FROM Marks
WHERE marks_obtained > 75;

SELECT S.name, C.course_name, M.marks_obtained
FROM Marks M
JOIN Students S ON M.student_id = S.student_id
JOIN Courses C ON M.course_id = C.course_id;

SELECT name FROM Students
WHERE student_id NOT IN (SELECT student_id FROM Marks);

SELECT department_id, COUNT(*) AS total_students
FROM Students
GROUP BY department_id;

SELECT course_id, AVG(marks_obtained) AS avg_marks
FROM Marks
GROUP BY course_id;

SELECT student_id
FROM Marks
WHERE marks_obtained > (SELECT AVG(marks_obtained) FROM Marks);

SELECT student_id
FROM Marks
WHERE marks_obtained = (SELECT MAX(marks_obtained) FROM Marks);

SELECT course_id
FROM Courses
WHERE course_id NOT IN (SELECT course_id FROM Enrollments);

SELECT student_id
FROM Students
WHERE department_id = (
    SELECT department_id
    FROM Departments
    WHERE department_name = 'Computer Science'
);

CREATE VIEW student_course_marks AS
SELECT S.name, C.course_name, M.marks_obtained
FROM Students S
JOIN Marks M ON S.student_id = M.student_id
JOIN Courses C ON M.course_id = C.course_id;

CREATE VIEW department_performance AS
SELECT D.department_name, AVG(M.marks_obtained) AS average_marks
FROM Departments D
JOIN Students S ON D.department_id = S.department_id
JOIN Marks M ON S.student_id = M.student_id
GROUP BY D.department_name;

DELIMITER //
CREATE PROCEDURE student_marks(IN sid INT)
BEGIN
    SELECT C.course_name, M.marks_obtained
    FROM Marks M
    JOIN Courses C ON M.course_id = C.course_id
    WHERE M.student_id = sid;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION get_grade(marks INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF marks >= 75 THEN RETURN 'A';
    ELSEIF marks >= 60 THEN RETURN 'B';
    ELSEIF marks >= 40 THEN RETURN 'C';
    ELSE RETURN 'Fail';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER marks_check
BEFORE INSERT ON Marks
FOR EACH ROW
BEGIN
    IF NEW.marks_obtained > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks cannot be greater than 100';
    END IF;
END //
DELIMITER ;

SELECT S.name, C.course_name, M.marks_obtained, get_grade(M.marks_obtained) AS grade
FROM Students S
JOIN Marks M ON S.student_id = M.student_id
JOIN Courses C ON M.course_id = C.course_id;
