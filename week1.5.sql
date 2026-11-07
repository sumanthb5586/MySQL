use info;

select avg(salary)
from employees;

select
    employee_name,
    department,
    salary
from employees
where salary > (
    select avg(salary)
    from employees
);

select
    employee_name,
    department
from employees
where department in (
    select department_name
    from departments
    where department_id in (
        select department_id
        from projects
        where project_budget > 150000
    )
);

select
    department,
    average_salary
from (
    select
        department,
        round(avg(salary), 2) as average_salary
    from employees
    group by department
) as department_summary
where average_salary > 85000;

select
    e.employee_name,
    e.department,
    e.salary
from employees e
where e.salary > (
    select avg(e2.salary)
    from employees e2
    where e2.department = e.department
);

select
    e.employee_name,
    e.department,
    e.salary,
    round((
        select avg(e2.salary)
        from employees e2
        where e2.department = e.department
    ), 2) as department_avg_salary
from employees e;

select
    e.employee_name,
    e.department,
    e.salary
from employees e
where e.salary = (
    select max(e2.salary)
    from employees e2
    where e2.department = e.department
);

with department_avg as (
    select
        department,
        round(avg(salary), 2) as avg_salary
    from employees
    group by department
)
select
    department,
    avg_salary
from department_avg
where avg_salary > 85000;

with department_salary as (
    select
        department,
        sum(salary) as total_salary
    from employees
    group by department
),
salary_category as (
    select
        department,
        total_salary,
        case
            when total_salary >= 300000 then 'high'
            when total_salary >= 150000 then 'medium'
            else 'low'
        end as category
    from department_salary
)
select *
from salary_category
order by total_salary desc;


select *
from (
    select
        department,
        avg(salary) as avg_salary
    from employees
    group by department
) as department_avg
where avg_salary > 85000;


select employee_name, department
from employees
where department = 'Engineering'

union

select employee_name, department
from employees
where department = 'Finance';

select employee_name, department
from employees
where department = 'Engineering'

union all

select employee_name, department
from employees
where department = 'Finance';

select employee_name, department
from employees
where department = 'Engineering'

union

select employee_name, department
from employees
where salary > 100000;


select employee_name, department
from employees
where department = 'Engineering'

union all

select employee_name, department
from employees
where salary > 100000;

select
    employee_id,
    employee_name,
    'active' as employee_category
from employees
where status = 'Active'

union all

select
    employee_id,
    employee_name,
    'inactive' as employee_category
from employees
where status = 'Inactive';