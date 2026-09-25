
                             # 51 SQL questions # 
USE ingale;

-- 1.	Retrieve all records from the students table. 
SELECT*FROM students;

-- 2.	Display only the name, department, and marks of all students. 
SELECT name,department,marks FROM students;

-- 3.	Find all students who scored more than 80 marks. 
SELECT*FROM students WHERE marks>80;

-- 4.	Find all students whose attendance is below 75%. 
SELECT*FROM students WHERE attendance<75;

-- 5.	Find all students between the ages of 18 and 22. 
SELECT*FROM students WHERE age between 18 and 22;

-- 6.	Display students who belong to the CS department.
SELECT*FROM students WHERE department='CS'; 

-- 7.	Find all students from Hyderabad. 
SELECT*FROM students WHERE city='Hyderabad';

-- 8.	Display students who have paid more than 7,000 in fees. 
SELECT*FROM students WHERE fees_paid>7000;

-- 9.	Find students whose names start with the letter A. 
SELECT*FROM students WHERE name LIKE 'A%';

-- 10.	Find students whose names contain the letter a. 
SELECT*FROM students WHERE name LIKE '%a%';

-- 11.	Display all students ordered by marks from highest to lowest. 
SELECT*FROM students ORDER BY marks DESC;

-- 12.	Display all students ordered by age from lowest to highest. 
SELECT*FROM students ORDER BY age ASC;

-- 13.	Display the top 10 students based on marks. 
SELECT*FROM students ORDER BY marks DESC LIMIT 10;

-- 14.	Find the minimum marks obtained by any student. 
SELECT MIN(marks) FROM students;

-- 15.	Find the maximum marks obtained by any student. 
SELECT MAX(marks) FROM students;

-- 16.	Calculate the average marks of all students. 
SELECT AVG(marks) FROM students;

-- 17.	Calculate the average attendance of all students. 
SELECT AVG(attendance)
 FROM students;

-- 18.	Calculate the total fees paid by all students. 
SELECT SUM(fees_paid) FROM students;

-- 19.	Count the total number of students. 
SELECT COUNT(*) FROM students;

-- 20.	Count the number of students in each department. 
SELECT department,COUNT(*) FROM students GROUP BY department;

-- 21.	Find the average marks for each department. 
SELECT department,AVG(marks) FROM students GROUP BY department;

-- 22.	Find the maximum marks for each department. 
SELECT department,MAX(marks) FROM students GROUP BY department;

-- 23.	Find the minimum marks for each department. 
SELECT department,MIN(marks) FROM students GROUP BY department;

-- 24.	Find the average attendance for each department. 
SELECT department,AVG(attendance) FROM students GROUP BY department;

-- 25.	Find the total fees paid by each department. 
SELECT department,SUM(fees_paid) FROM students GROUP BY department;

-- 26.	Count the number of students from each city. 
SELECT city,COUNT(*) FROM students GROUP BY city;

-- 27.	Find the average marks for each city. 
SELECT city,AVG(marks) FROM students GROUP BY city;

-- 28.	Find cities where the average marks are greater than 70. 
SELECT city,AVG(marks) FROM students GROUP BY city HAVING AVG(marks)>70; 

-- 29.	Find departments having more than 100 students. 
SELECT department,COUNT(*) FROM students GROUP BY department HAVING COUNT(*)>100;

-- 30.	Find the number of male and female students in each department. 
SELECT department,gender,COUNT(*) FROM students GROUP BY department,gender;

-- 31.	Find the average marks separately for male and female students. 
SELECT gender,AVG(marks) FROM students GROUP BY gender;

-- 32.	Find the department with the highest average marks. 
SELECT department,AVG(marks) FROM students GROUP BY department ORDER BY AVG(marks) DESC LIMIT 1 ;

-- 33.	 Find the department with the highest total fees collected.
SELECT department,SUM(fees_paid) FROM students GROUP BY department ORDER BY SUM(fees_paid) DESC LIMIT 1;

-- 34.	Find the student who scored the highest marks. 
SELECT*FROM students ORDER BY marks DESC LIMIT 1;

-- 35.	Find all students who scored the same marks as the highest-scoring student. 
SELECT*FROM students WHERE marks=(SELECT MAX(marks) FROM students);

-- 36.	Find students whose marks are above the overall average marks. 
SELECT*FROM students WHERE marks>(SELECT AVG(marks) FROM students);

-- 37.	Find students whose attendance is above the overall average attendance. 
SELECT*FROM students WHERE attendance>(SELECT AVG(attendance) FROM students);

-- 38.	Find students who have both marks greater than 80 and attendance greater than 75%. 
SELECT*FROM students WHERE marks>80 AND attendance>75;

-- 39.	Find students who have marks greater than 90 or attendance greater than 90%. 
SELECT*FROM students WHERE marks>90 OR attendance>90;

-- 40.	Categorize students as Excellent, Good, Average, or Poor based on their marks using CASE. 
SELECT name,marks,
CASE
  WHEN marks>90 THEN 'Excellent'
  WHEN marks>75 THEN 'Good'
  WHEN marks>50 THEN 'Average'
  ELSE 'Poor'
  END AS Grade
  FROM students;
  
-- 41.	Categorize students as High Attendance, Medium Attendance, or Low Attendance based on attendance. 
SELECT name,attendance,
CASE 
  WHEN attendance>75 THEN 'High'
  WHEN attendance>50 THEN 'Medium'
  ELSE 'Low'
  END AS Attendance_Category
  FROM students;
  
-- 42.	Calculate the difference between each student's marks and the overall average marks. 
SELECT name,marks,marks-(SELECT AVG(marks) FROM students) AS difference_from_average_marks FROM students;

-- 43.	Calculate each student's fees as a percentage of the total fees collected. 
SELECT name,fees_paid,(fees_paid * 100.0 / (SELECT SUM(fees_paid) FROM students)) AS Fees_Percentage FROM students;

-- 44.	Extract the year and month from admission_date. 
SELECT EXTRACT(Year FROM admission_date) AS Year
     ,EXTRACT(Month FROM admission_date) AS Month FROM students;
     
-- 45.	Count how many students were admitted in each year. 
SELECT EXTRACT(Year FROM admission_date) AS Year,COUNT(*) FROM students GROUP BY Year;

-- 46.	Find the number of students admitted in each month. 
SELECT EXTRACT(Month FROM admission_date)AS Month ,COUNT(*) FROM students GROUP BY Month;
        
-- 47.	Find the earliest and latest admission dates. 
SELECT MIN(admission_date) AS Earliest_Admission_Date,MAX(admission_date) AS Latest_Admission_Date FROM students;

-- 48.	Rank students within each department based on their marks. 
SELECT name,department, marks,
    RANK() OVER (
        PARTITION BY department 
        ORDER BY marks DESC
    ) AS Department_Rank
FROM students;

-- 49.	Find the top 3 students from each department based on marks. 
WITH ranked_students AS (
    SELECT name,department,marks,
        RANK() OVER (
            PARTITION BY department 
            ORDER BY marks DESC
        ) AS student_rank
    FROM students
)
SELECT name,department,marks,student_rank
FROM ranked_students
WHERE student_rank <= 3;

-- 50.	Find the second-highest marks in the entire dataset. 
SELECT MAX(marks)FROM students WHERE marks<(SELECT MAX(marks) FROM students);

-- 51.	Find the department-wise average marks, average attendance, total fees paid, student count, and highest marks in a single query. 
SELECT department,AVG(marks),AVG(attendance),SUM(fees_paid),COUNT(*),MAX(marks) FROM students GROUP BY department;
