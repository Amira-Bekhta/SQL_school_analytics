--Creating schemas, tables, and inserting data:

CREATE SCHEMA students;
CREATE SCHEMA teachers;
CREATE SCHEMA courses;

CREATE TABLE students.student_info (
  student_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  gender CHAR(1),
  birth_date DATE,
  grade_level INT,
  city VARCHAR(50)
);

CREATE TABLE teachers.teacher_info (
  teacher_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  subject VARCHAR(50),
  hire_date DATE,
  salary NUMERIC(10, 2)
);

CREATE TABLE courses.course_info (
  course_id SERIAL PRIMARY KEY,
  course_name VARCHAR(100),
  teacher_id INT REFERENCES teachers.teacher_info(teacher_id),
  credits INT
);

CREATE TABLE students.enrollments (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT REFERENCES students.student_info(student_id),
  course_id INT REFERENCES courses.course_info(course_id),
  grade INT
);


INSERT INTO students.student_info (first_name, last_name, gender, birth_date, grade_level, city)
VALUES
('Amina', 'Haddad', 'F', '2006-05-21', 11, 'Algiers'),
('Youssef', 'Benali', 'M', '2007-02-11', 10, 'Oran'),
('Lina', 'Mebarki', 'F', '2005-09-30', 12, 'Constantine'),
('Karim', 'Zeroual', 'M', '2006-12-17', 11, 'Tlemcen'),
('Samira', 'Bouchareb', 'F', '2008-04-09', 9, 'Annaba'),
('Nassim', 'Boufarès', 'M', '2006-07-02', 11, 'Algiers'),
('Rania', 'Cherfaoui', 'F', '2007-09-17', 10, 'Oran'),
('Malek', 'Dahmani', 'M', '2005-11-25', 12, 'Constantine'),
('Sabrina', 'Meziane', 'F', '2008-02-19', 9, 'Tlemcen'),
('Omar', 'Benkirane', 'M', '2007-06-10', 10, 'Annaba'),
('Nadia', 'Bouzid', 'F', '2006-04-05', 11, 'Algiers'),
('Hakim', 'Aït', 'M', '2005-12-23', 12, 'Oran'),
('Meriem', 'Belaid', 'F', '2007-10-14', 10, 'Constantine'),
('Sofiane', 'Hamdi', 'M', '2008-08-28', 9, 'Tlemcen'),
('Farah', 'Zerari', 'F', '2006-01-09', 11, 'Annaba');


INSERT INTO teachers.teacher_info (first_name, last_name, subject, hire_date, salary)
VALUES
('Nadia', 'Khelifi', 'Math', '2015-09-01', 250000),
('Mourad', 'Slimani', 'Physics', '2012-03-15', 275000),
('Fatiha', 'Belkacem', 'English', '2018-10-10', 230000),
('Imad', 'Cherif', 'Computer Science', '2020-01-12', 240000),
('Rachida', 'Messaoud', 'History', '2016-04-22', 260000),
('Lounes', 'Brahimi', 'Biology', '2014-05-17', 245000),
('Kenza', 'Saidi', 'Chemistry', '2017-11-09', 238000),
('Tarek', 'Amrane', 'Geography', '2019-09-30', 225000);

INSERT INTO courses.course_info (course_name, teacher_id, credits)
VALUES
('Algebra', 1, 3),
('Calculus', 1, 4),
('Mechanics', 2, 4),
('Optics', 2, 3),
('Literature', 3, 2),
('Writing Skills', 3, 2),
('Programming', 4, 4),
('Web Development', 4, 3),
('World History', 5, 3),
('Ancient Civilizations', 5, 2),
('Biology Basics', 6, 3),
('Genetics', 6, 4),
('Organic Chemistry', 7, 3),
('Inorganic Chemistry', 7, 3),
('Geography', 8, 2);

INSERT INTO students.enrollments (student_id, course_id, grade)
VALUES
(1, 1, 88), (1, 7, 92), (1, 9, 80),
(2, 2, 75), (2, 3, 83), (2, 11, 77),
(3, 5, 90), (3, 6, 84), (3, 7, 93),
(4, 9, 85), (4, 10, 88), (4, 3, 82),
(5, 1, 74), (5, 5, 79), (5, 12, 81),
(6, 2, 91), (6, 4, 86), (6, 14, 89),
(7, 13, 78), (7, 8, 84), (7, 9, 75),
(8, 7, 95), (8, 15, 80), (8, 10, 83),
(9, 3, 71), (9, 5, 85), (9, 6, 88),
(10, 4, 89), (10, 9, 90), (10, 12, 84),
(11, 1, 93), (11, 2, 87), (11, 13, 79),
(12, 11, 85), (12, 15, 88), (12, 7, 90),
(13, 5, 80), (13, 10, 82), (13, 9, 88),
(14, 4, 75), (14, 14, 77), (14, 15, 85),
(15, 2, 79), (15, 5, 83), (15, 8, 91);

-- 1- Get the full names of students and the names of the courses they’re enrolled in:
SELECT s.first_name, s.last_name, c.course_name
FROM students.student_info s
JOIN students.enrollments e 
  ON s.student_id = e.student_id
JOIN courses.course_info c 
  ON e.course_id = c.course_id;

-- 2- Find the average grade per course:

SELECT c.course_name, ROUND(AVG(e.grade), 2) as average_grade
FROM courses.course_info c
JOIN students.enrollments e
ON e.course_id = c.course_id
GROUP BY c.course_name;

-- 3- teachers who earn more than the average salary:

SELECT first_name, last_name, salary
FROM teachers.teacher_info
WHERE salary > (
  SELECT AVG(salary)
  FROM teachers.teacher_info
);

-- 4- List students who are taking more than one course:

SELECT s.first_name, s.last_name, COUNT(e.course_id) as course_count
FROM students.student_info s
JOIN students.enrollments e
ON s.student_id = e.student_id
GROUP BY s.first_name, s.last_name
HAVING (SELECT COUNT(e.course_id)) > 2;

-- 5- Find the youngest student and which city they’re from:

SELECT first_name, last_name, city, AGE(birth_date)
FROM students.student_info
ORDER BY birth_date DESC
LIMIT 1;
