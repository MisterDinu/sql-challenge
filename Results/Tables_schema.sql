-- This creates the tables at the correct format

    CREATE TABLE Employees (
        Emp_no INT PRIMARY KEY NOT NULL,
        Emp_title_id VARCHAR(10),
        Birth_date VARCHAR(20),
        Emp_title_id VARCHAR(10),
        First_name VARCHAR(30),
        Last_name VARCHAR(30),
        Sex VARCHAR(10),
        Hire_date VARCHAR(20)
    );

    CREATE TABLE Departments(
        Dept_no VARCHAR(10) PRIMARY KEY NOT NULL,
        Dept_name VARCHAR(30)
    );

    CREATE TABLE Dept_emp(
        Emp_no INT NOT NULL,
        Dept_no VARCHAR(10),
    );

    CREATE TABLE Titles(
        Title_id VARCHAR(10) PRIMARY KEY,
        Title VARCHAR(30)
    );

    CREATE TABLE Salaries(
        Emp_no INT NOT NULL,
        Salary INT
    );

    CREATE TABLE Dept_manager(
        Dept_no VARCHAR(10) NOT NULL,
        Emp_no INT
    );

-- Then I use this queries to reference the foreign keys

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

    -- Then I import all the data from the CSV files to the database