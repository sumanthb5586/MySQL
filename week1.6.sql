use info;

select
    department,
    round(avg(salary),2) as avg_salary
from employees
group by department;


select
    employee_name,
    department,
    salary,
    round(avg(salary) over (
        partition by department
    ), 2) as department_avg_salary
from employees;

select
    employee_name,
    department,
    salary,
    row_number() over (
        order by salary desc
    ) as row_num
from employees;


with ranked_employees as (
    select
        employee_name,
        department,
        salary,
        row_number() over (
            partition by department
            order by salary desc, employee_id
        ) as row_num
    from employees
)
select
    employee_name,
    department,
    salary,
    row_num
from ranked_employees
where row_num <= 2;

select
    employee_name,
    department,
    salary,
    row_number() over (
        order by salary desc
    ) as row_num,
    rank() over (
        order by salary desc
    ) as salary_rank,
    dense_rank() over (
        order by salary desc
    ) as dense_salary_rank
from employees
order by salary desc;


select
    employee_name,
    experience_years,
    row_number() over (
        order by experience_years desc, employee_id
    ) as row_num,
    rank() over (
        order by experience_years desc
    ) as experience_rank,
    dense_rank() over (
        order by experience_years desc
    ) as dense_experience_rank
from employees
order by experience_years desc, employee_id;


select
    employee_name,
    department,
    salary,
    rank() over (
        partition by department
        order by salary desc
    ) as department_rank
from employees
order by department, department_rank;


with salary_ranking as (
    select
        employee_name,
        department,
        salary,
        dense_rank() over (
            partition by department
            order by salary desc
        ) as salary_rank
    from employees
)
select
    employee_name,
    department,
    salary
from salary_ranking
where salary_rank = 2;

select
    employee_name,
    department,
    salary,
    sum(salary) over (
        partition by department
    ) as department_total_salary
from employees;


select
    employee_name,
    department,
    salary,
    sum(salary) over (
        partition by department
    ) as department_total_salary,
    round(
        salary * 100.0 /
        nullif(sum(salary) over (
            partition by department
        ), 0),
        2
    ) as salary_percentage
from employees
order by department, salary desc;


select
    employee_name,
    department,
    salary,
    lag(salary) over (
        order by salary desc
    ) as previous_salary
from employees;

select
    employee_name,
    department,
    salary,
    lead(salary) over (
        order by salary desc
    ) as next_salary
from employees;

select
    employee_name,
    salary,
    lag(salary) over (
        order by salary desc
    ) as previous_salary,
    lead(salary) over (
        order by salary desc
    ) as next_salary
from employees
order by salary desc;

select
    employee_name,
    department,
    salary,
    lag(salary) over (
        partition by department
        order by salary desc
    ) as previous_department_salary
from employees
order by department, salary desc;