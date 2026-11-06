use info;
create table departments (
    department_id int primary key,
    department_name varchar(50) unique not null,
    location varchar(50)

);

show tables;

insert into departments values 
(1,'Engineering', 'Houston'),
(2, 'Finance', 'Dallas'),
(3, 'HR', 'Austin'),
(4, 'Sales', 'Chicago'),
(5, 'Marketing', 'Seattle');

select * from departments;

select e.employee_id,
       e.employee_name,
       e.department,
       d.location
from employees e 
inner join departments d
       on e.department = d.department_name;


select d.department_name,
       e.employee_name
from departments d
left join employees e
        on d.department_name = e.department;

select d.department_name,
       e.employee_name
from departments d
right join employees e
        on d.department_name = e.department;

create table projects (
    project_id int primary key,
    project_name varchar(100),
    department_id int,
    project_budget decimal(12,2),
    foreign key (department_id)
        references departments(department_id)
);

insert into projects values
(1, 'Cloud Migration', 1, 250000),
(2, 'Data Pipeline', 1, 180000),
(3, 'Financial Reporting', 2, 120000),
(4, 'Recruitment Portal', 3, 80000),
(5, 'Sales Analytics', 4, 150000);

select
    e.employee_name,
    d.department_name,
    d.location,
    p.project_name,
    p.project_budget
from employees e
inner join departments d
    on e.department = d.department_name
inner join projects p
    on d.department_id = p.department_id;


alter table employees
add column manager_id int null;

update employees

set manager_id = case
    when employee_id in (101, 102, 105) then 110
    when employee_id in (103, 106) then 112
    when employee_id in (104, 107) then 108
    when employee_id in (109, 111) then 108
    else null
end;

select
    e.employee_name,
    m.employee_name as manager
from employees e
inner join employees m
    on e.manager_id = m.employee_id
where m.employee_name = 'Jennifer Moore';


select
    d.department_name,
    count(p.project_id) as total_projects
from departments d
inner join projects p
    on d.department_id = p.department_id
group by d.department_id, d.department_name
having count(p.project_id) > 1;


with employee_summary as (
    select
        department,
        count(*) as total_employees
    from employees
    group by department
),
project_summary as (
    select
        department_id,
        sum(project_budget) as total_budget
    from projects
    group by department_id
)
select
    d.department_name,
    coalesce(e.total_employees, 0) as total_employees,
    coalesce(p.total_budget, 0) as total_project_budget
from departments d
left join employee_summary e
    on d.department_name = e.department
left join project_summary p
    on d.department_id = p.department_id
order by total_project_budget desc;