# 1.Query the existence of 1 course
SELECT c.*
FROM course c
WHERE c.id = 1;

# 2.Query the presence of both 1 and 2 courses
SELECT c.*
FROM course c
WHERE c.id = 1 and c.id = 2;

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
SELECT
  sc.studentId,
  s.`name`,
  avg(sc.score)
FROM student_course sc LEFT JOIN student s
    ON sc.studentId = s.id
GROUP BY sc.studentId
HAVING avg(sc.score) >= 60;

# 4.Query the SQL statement of student information that does not have grades in the student_course table
SELECT *
FROM student
WHERE student.id NOT IN (SELECT DISTINCT sc.studentId
                         FROM student_course sc);

# 5.Query all SQL with grades
select * from student
where id in (SELECT DISTINCT sc.studentId
             FROM student_course sc);

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
SELECT s.*
FROM student s, (
                  SELECT sc.studentId
                  FROM student_course sc, course c
                  WHERE sc.courseId = c.id AND c.id IN (1, 2)
                  GROUP BY sc.studentId
                  HAVING count(DISTINCT c.id) = 2) tbl
WHERE s.id = tbl.studentId;

# 7.Retrieve 1 student score with less than 60 scores in descending order
SELECT s.*
FROM student s
WHERE s.id IN (
  SELECT sc.studentId
  FROM student_course sc
  WHERE sc.courseId = 1 AND sc.score < 60
  ORDER BY sc.score DESC);

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
SELECT
  sc.courseId,
  avg(sc.score) avg_score
FROM student_course sc
GROUP BY sc.courseId
ORDER BY avg_score, sc.courseId;

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
SELECT s.*
FROM student_course sc INNER JOIN student s ON sc.studentId = s.id
WHERE sc.score < 60 AND sc.courseId IN (SELECT c.id
                                        FROM course c
                                        WHERE c.`name` = 'Math');
