show databases;
use info;
select * from employees;


select
    employee_name,
    upper(employee_name) AS uppercase_name,
    lower(department) AS lowercase_department
from employees;

select
    employee_name,
    concat(employee_name, ' - ', department) AS employee_details
from employees;

select
    employee_name,
    substring(employee_name, 1, 4) AS short_name
from employees;

select
    department,
    replace(department, 'Engineering', 'Technology')
        as updated_department
from employees;

select
    employee_name,
    length(employee_name) AS byte_length,
    char_length(employee_name) AS character_count
from employees;

select upper(employee_name) as employee,lower(department) as department_name
from employees;

select
    current_date() as today,
    now() as current_datetime;

select
    year('2026-11-03') as year_value,
    month('2026-11-03') as month_value,
    day('2026-11-03') as day_value;
select
    date_add('2026-11-03', interval 10 day) as future_date,
    date_sub('2026-11-03', interval 7 day) as past_date;

select
    round(125.6789, 2) as result_1,
    round(125.6789, 0) as result_2,
    round(125.6789, 1) as result_3;

select
    employee_name,
    salary,
    round(salary * 1.075, 2) as revised_salary
from employees;

select
    ceil(12.1) as result_1,
    ceil(12.9) as result_2,
    ceil(12.0) as result_3;

select
    floor(12.1) as result_1,
    floor(12.9) as result_2,
    floor(12.0) as result_3;

select
    abs(-150) as result_1,
    abs(150) as result_2,
    abs(-25.75) as result_3;
select
    mod(10, 3) as result_1,
    mod(20, 5) as result_2,
    mod(17, 4) as result_3;

select
    employee_id,
    employee_name,
    mod(employee_id, 3) as batch_group
from employees;

select
    employee_id,
    trim(employee_name) as employee_name,
    upper(trim(department)) as department,
    coalesce(city, 'Unknown') as city
from employees;

select
    employee_name,
    department,
    salary,
    experience_years,
    status,
    case
        when status = 'Active' and experience_years >= 5 and salary < 100000
        then 'Eligible'
        else 'Not Eligible'
    end as review_eligibility
from employees;