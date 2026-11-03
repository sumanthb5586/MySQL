create database info;
use info;
create table employees(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    city VARCHAR(50),
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    experience_years INT,
    status VARCHAR(20)

);
SHOW TABLES;
INSERT INTO employees VALUES
(101, 'John Smith', 'Engineering', 'Houston', 95000, 8000, 6, 'Active'),
(102, 'Sarah Johnson', 'Engineering', 'Dallas', 110000, NULL, 8, 'Active'),
(103, 'Michael Brown', 'Finance', 'Houston', 85000, 5000, 5, 'Active'),
(104, 'Emily Davis', 'HR', 'Austin', 72000, NULL, 4, 'Active'),
(105, 'David Wilson', 'Engineering', 'Houston', 125000, 12000, 10, 'Active'),
(106, 'Jessica Miller', 'Finance', 'Dallas', 90000, 6000, 7, 'Inactive'),
(107, 'Robert Taylor', 'HR', NULL, 68000, 3000, 3, 'Active'),
(108, 'Linda Anderson', 'Sales', 'Austin', 78000, NULL, 5, 'Active'),
(109, 'James Thomas', 'Sales', 'Houston', 82000, 7000, 6, 'Inactive'),
(110, 'Jennifer Moore', 'Engineering', 'Dallas', 105000, 9000, 7, 'Active'),
(111, 'Daniel Martin', 'Sales', NULL, 75000, 4000, 4, 'Active'),
(112, 'Nancy Jackson', 'Finance', 'Austin', 88000, NULL, 6, 'Active');

select * from employees;

select employee_name,salary 
from employees
where salary>90000
order by salary desc;

select DISTINCT department,city
from employees;

select employee_name,department,salary
from employees
where salary>85000 and department='Engineering'
order by experience_years;

select distinct department
from employees;

select distinct city
from employees;

select employee_name,salary,department
from employees
where salary>80000
order by salary desc;


select employee_name 
from employees
where status='Active' and city = 'Houston';

select *
from employees
where department in ('Engineering','Finance','Sales');

select *
from employees
where department not in ('Engineering','HR','Sales');

select employee_name,experience_years
from employees
where experience_years between 5 and 8;

select *
from employees
where status='Active' and department in ('Engineering','Finance')
and salary>85000;

select * 
from employees
where city in ('Houston','Dallas','Austin') and experience_years between 5 and 8
and status= 'Active';

select employee_name,bonus
from employees;

select employee_name, bonus
from employees
where bonus is null;

select employee_name, bonus
from employees
where bonus is not null;

select employee_name,salary,bonus,salary+bonus as total_compensation
from employees;

select employee_name,bonus,salary+coalesce(bonus,0) as total_compensation
from employees;

select employee_name, coalesce(city,'Unknown') as city
from employees;

select  employee_name,department,coalesce(city,'Unknown') as city,salary+coalesce(bonus,0) as total_compensation
from employees
order by total_compensation desc;


select employee_name,salary,
case when salary>=100000 then 'High'
     when salary>=80000 then 'Medium'
     else 'Low'
end as salary_category
from employees;

select employee_name,department,salary,
case when department = 'Engineering' and salary>=100000 then 'Senior Engineering pay'
     when department = 'Engineering' then 'Engineering'
     else 'Other'
end as employee_group
from employees;

select employee_name, experience_years,
case when experience_years>=8 then 'Senior'
     when experience_years>=5 then 'Mid-level'
     else 'Junior'
end as experience_level
from employees;
