-- Here I put the queries for each of the requested points:

-- DATA ANALYSIS

-- 1- Employee number, last name, first name, sex, salary
SELECT emp.emp_no, emp.Last_name, emp.First_name, emp.Sex, sal.Salary
FROM Employees AS emp
INNER JOIN Salaries as sal ON emp.emp_no = sal.emp_no;


-- 2- First name, last name, and hire date for the employees who were hired in 1986.
SELECT First_name, Last_name, Hire_date 
FROM Employees
WHERE Hire_date LIKE '%1986%';


-- 3- List the manager of each department, their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, emp.last_name, emp.first_name
FROM Departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN Employees emp ON dm.emp_no = emp.emp_no


-- 4- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no, de.emp_no, emp.last_name, emp.first_name, d.dept_name
FROM dept_emp de
JOIN Employees emp ON de.emp_no = emp.emp_no
JOIN Departments d ON de.dept_no = d.dept_no;

-- 5- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' AND Last_name LIKE 'B%';

-- 6- List each employee in the Sales department, including their employee number, last name, and first name.
-- Sales has the dept_no 'd007'
SELECT de.emp_no, emp.last_name, emp.first_name, de.dept_no
FROM Employees emp
JOIN dept_emp de ON emp.emp_no = de.emp_no
WHERE dept_no = 'd007';


-- 7- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- Developement has dept_no 'd005'
SELECT de.emp_no, emp.last_name, emp.first_name, de.dept_no, d.dept_name
FROM Employees emp
JOIN dept_emp de ON emp.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
WHERE d.dept_no = 'd007' OR d.dept_no = 'd005';

-- 8- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS count
FROM employees
GROUP BY last_name
ORDER BY count DESC;
