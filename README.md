# sql-challenge




Here I put the pieces of code I used in pgAdmin

--- First I create all the tables where I'll put the data

    CREATE TABLE Employees (
        Emp_no INT PRIMARY KEY,
        Emp_title_id VARCHAR(10),
        FOREIGN KEY (Emp_title_id) REFERENCES Titles (Title_id),
        Birth_date DATE,
        Emp_title_id VARCHAR(10),
        First_name VARCHAR(30),
        Last_name VARCHAR(30),
        Sex VARCHAR(10),
        Hire_date DATE
    );

    CREATE TABLE Departments(
        Dept_no VARCHAR(10) PRIMARY KEY,
        Dept_name VARCHAR(30)
    );

    CREATE TABLE Dept_emp(
        Emp_no INT,
        Dept_no VARCHAR(10),
        FOREIGN KEY (Emp_no) REFERENCES Employees (Emp_no),
        FOREIGN KEY (Dept_no) REFERENCES Departments (Dept_no)
    );

    CREATE TABLE Titles(
        Title_id VARCHAR(10) PRIMARY KEY,
        Title VARCHAR(30)
    );

    CREATE TABLE Salaries(
        Emp_no INT,
        FOREIGN KEY (Emp_no) REFERENCES Employees (Emp_no),
        Salary INT
    );

    CREATE TABLE Dept_manager(
        Dept_no VARCHAR(10),
        FOREIGN KEY (Dept_no) REFERENCES Departments (Dept_no),
        Emp_no INT,
        FOREIGN KEY (Emp_no) REFERENCES Employees (Emp_no)
    );

--- As I couldn't create the references in the previous code, I used alter to create the reference to Foreign Keys after creating the tables

    ALTER TABLE Employees
    ADD CONSTRAINT FK_Employees_Title
    FOREIGN KEY (Emp_title_id) REFERENCES Titles(Title_id);

    ALTER TABLE Dept_emp
    ADD CONSTRAINT FK_Dept_emp_Employees
    FOREIGN KEY (Emp_no) REFERENCES Employees(Emp_no),
    ADD CONSTRAINT FK_Dept_emp_Departments
    FOREIGN KEY (Dept_no) REFERENCES Departments(Dept_no);

    ALTER TABLE Salaries
    ADD CONSTRAINT FK_Salaries_Employees
    FOREIGN KEY (Emp_no) REFERENCES Employees(Emp_no);

    ALTER TABLE Dept_manager
    ADD CONSTRAINT FK_Dept_manager_Departments
    FOREIGN KEY (Dept_no) REFERENCES Departments(Dept_no),
    ADD CONSTRAINT FK_Dept_manager_Employees
    FOREIGN KEY (Emp_no) REFERENCES Employees(Emp_no);

--- At this point I import all the data from the csv files
    As I could't import the data from employees, I tried to use VARCHAR instead of DATE or TIMESTAMP in all the dates columns
    I also verify that the tables returns the information I want
SELECT * FROM Departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM Employees;
SELECT * FROM Salaries;
SELECT * FROM Titles;

-- DATA ANALYSIS

1- Employee number, last name, first name, sex, salary

SELECT emp.emp_no, emp.Last_name, emp.First_name, emp.Sex, sal.Salary
FROM Employees AS emp
INNER JOIN Salaries as sal ON emp.emp_no = sal.emp_no;


2- First name, last name, and hire date for the employees who were hired in 1986.
SELECT First_name, Last_name, Hire_date 
FROM Employees
WHERE Hire_date LIKE '%1986%';


3- List the manager of each department, their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, emp.last_name, emp.first_name
FROM Departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN Employees emp ON dm.emp_no = emp.emp_no


4- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no, de.emp_no, emp.last_name, emp.first_name, d.dept_name
FROM dept_emp de
JOIN Employees emp ON de.emp_no = emp.emp_no
JOIN Departments d ON de.dept_no = d.dept_no;

5- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' AND Last_name LIKE 'B%';

6- List each employee in the Sales department, including their employee number, last name, and first name.
-- Sales has the dept_no 'd007'
SELECT de.emp_no, emp.last_name, emp.first_name, de.dept_no
FROM Employees emp
JOIN dept_emp de ON emp.emp_no = de.emp_no
WHERE dept_no = 'd007';


7- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no, emp.last_name, emp.first_name, de.dept_no, d.dept_name
FROM Employees emp
JOIN dept_emp de ON emp.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
WHERE d.dept_no = 'd007' OR d.dept_no = 'd005';

8- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS count
FROM employees
GROUP BY last_name
ORDER BY count DESC;
