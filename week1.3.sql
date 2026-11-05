use info;
select * from employees;

select count(*) as total_employees
from employees;
select
    count(*) as total_employees,
    count(bonus) as employees_with_bonus,
    count(city) as employees_with_city
from employees;      

select sum(salary) as total_salary
from employees;

select sum(salary) as total_salary,
       sum(bonus) as total_bonus
from employees;       

select round(avg(salary),2) as average_salary
from employees;

select avg(bonus) as average_known_bonus,
       round(avg(coalesce(bonus,0)),2) as average_bonus_all_employees
from employees;       

select count(*) as total_employees,
       sum(salary) as total_salary,
       round(avg(salary),2) as average_salary,
       min(salary) as minimum_salary,
       max(salary) as maximum_salary
from employees;   

select count(distinct department) as total_departments
from employees;

select
    department,
    count(*) as total_employees
from employees
group by department;

select
    department,
    count(*) as total_employees,
    sum(salary) as total_salary,
    round(avg(salary), 2) as average_salary,
    min(salary) as lowest_salary,
    max(salary) as highest_salary
from employees
group by department;

select department,
       count(*) as active_employees,
       round(avg(salary),2) as average_salary
from employees
where status = 'Active'
group by department;       

select department,
       city,
       count(*) as total_employees
from employees      
group by department, city
order by department, city;

select
    department,
    round(avg(salary), 2) as average_salary
from employees
group by department
order by average_salary desc;

select department,
       round(avg(salary),2) as average_salary
from employees
group by department
having avg(salary) > 90000;       

select
    department,
    count(*) as total_employees
from employees
where salary > 80000
group by department;

select
    department,
    count(*) as total_employees
from employees
group by department
having count(*) > 2;

select
    department,
    count(*) as total_employees,
    round(avg(salary), 2) as average_salary
from employees
where status = 'Active'
group by department
having count(*) >= 2
   and avg(salary) > 85000;

select
    department,
    sum(salary) as total_salary,
    max(salary) as highest_salary
from employees
group by department
having sum(salary) > 200000
   and max(salary) > 100000;

select
    count(*) as total_employees,
    sum(case when status = 'Active' then 1 else 0 end) as active_employees,
    sum(case when status = 'Inactive' then 1 else 0 end) as inactive_employees
from employees;

select
    sum(case when status = 'Active' then salary else 0 end)
        as active_salary,

    sum(case when status = 'Inactive' then salary else 0 end)
        as inactive_salary
from employees;

select
    department,
    round(avg(case when status = 'Active' then salary end), 2)
        as active_avg_salary,

    round(avg(case when status = 'Inactive' then salary end), 2)
        as inactive_avg_salary
from employees
group by department;