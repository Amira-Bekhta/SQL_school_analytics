# 🎓 School Database Project

This project simulates a mini school database system built with **PostgreSQL**.  
It includes separate schemas for **students**, **teachers**, and **courses**, along with realistic data and example SQL queries for analysis.

---

## 🧱 Database Structure

### Schemas
- `students`
- `teachers`
- `courses`

### Tables
- **students.student_info** – basic info about each student (name, birth date, city, etc.)
- **teachers.teacher_info** – teacher details and salaries
- **courses.course_info** – course data linked to teachers
- **students.enrollments** – relationships between students and courses, with grades

All tables are connected with foreign key relationships for consistency.

---

## 💾 Data

Each table is populated with multiple realistic entries (15 students, 8 teachers, 15 courses).  
This allows testing various joins, aggregates, and subqueries easily.

---

## 🧠 SQL Tasks & Results

Below are screenshots of outputs of each task/query ⬇️

### 1️⃣ Students and Their Courses
![Alt text](Screenshots\1.png)
### 2️⃣ Average Grade per Course
![Alt text](Screenshots\2.png)
### 3️⃣ Teachers Earning Above Average
![Alt text](Screenshots\3.png)
### 4️⃣ Students Taking More Than Two Courses
![Alt text](Screenshots\4.png)
### 5️⃣ Youngest Student
![Alt text](Screenshots\5.png)


## 🧱 Tools used
- PostgreSQL
- pgAdmin 4
- SQL Joins, Aggregates, Subqueries, and Window Functions