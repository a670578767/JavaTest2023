# 显示 departments 表中的表结构 describe 描述，形容;
describe departments;
select *
from departments;
# LEAST 从一系列表达式中返回最小值的函数。
select LEAST(first_name, last_name)
from employees;
# BETWEEN (条件下限) AND （条件上限）
select employee_id, last_name, salary
from employees
where salary between 5000 AND 8000;

# 练习 : 查询部门为10,20,30部门的员工信息
select last_name, salary, first_name
from employees
where department_id = 10
   or department_id = 20
   or department_id = 30;

select last_name, salary, first_name
from employees
where department_id in (10, 20, 30);
# like : 模糊查询  % 不确定个数的字符   _ 代表一个不确定的字符  \ 转意字符

select last_name
from employees
where last_name like '%a%';

# B站 P21 第四章课后练习题
# 1.选择工资不在5000-12000的员工的姓名和工资。
select last_name, salary
from employees
where salary not between 5000 and 12000
order by salary;
# 2.选择在20或50号部门工作的员工姓名和部门号。
select last_name, department_id
from employees
where department_id in (20, 50);
# 3.选择公司中没有管理者的员工姓名及job_id   null 不能用等号，要用is，或者 <=>
select last_name, job_id, manager_id
from employees
# where manager_id is null;
where manager_id <=> null;
# 4.选择公司中没有将近的员工姓名，工资和奖金级别
select last_name, salary, commission_pct
from employees
where commission_pct is not null;
# alter table employees modify commission_pct double(2,2) comment '奖金级别';
# 5.选择员工姓名的第三个字母是a的员工和姓名
select last_name
from employees
where last_name like '__a%';
# 6.选择姓名中有字母a和k的员工姓名
select last_name
from employees
where last_name like '%a%k%'
   or '%k%a%';
# 7.显示出表 employess 表中 first_name 以‘e’结尾的员工信息
select *
from employees
where first_name like '%e';
# 8.显示出表 employess 部门编号在80-100之间的姓名，工种
select last_name, job_id
from employees
where department_id between 80 and 100;
# 9，显示出表 employess 的 manager_id 是 100,101,110 的员工姓名，工资，管理者ID
select first_name, last_name, salary, manager_id
from employees
where manager_id in (100, 101, 110);

/*
   P22 宋红康
   数据排序: order by 子句排序， ASC:升序，DESC:降序 二级排序

   P23 LIMIT实现分页操作
*/
# 使用limit实现数据的分页显示
SELECT employee_id, last_name
FROM employees
# limit (偏移量) , (显示条目数)
LIMIT 0 , 20;
# 显示第二页
SELECT employee_id, last_name
FROM employees
LIMIT 20, 20;
# 显示第三页
SELECT employee_id, last_name
FROM employees
LIMIT 40, 20;
# 每页显示pageSize条记录，此时显示第pageNo页:
# 公式 LIMIT (pageNo - 1) * pageSize;
SELECT employee_id, last_name
FROM employees
WHERE salary > 6000
ORDER BY salary DESC
#简写
LIMIT 20;
# 练习:表里有107条数据，只显示32,33条数据。
SELECT employee_id, last_name
FROM employees
LIMIT 31, 2;
# 8.0 新特性 另一种写法
SELECT employee_id, last_name
FROM employees
LIMIT 2 offset 31;
# 练习:查询员工表中工资最高的员工信息
SELECT last_name, salary
FROM employees
ORDER BY salary DESC
# LIMIT 0,1;
LIMIT 1;
/*
   P24 第五章练习
*/
# 1.查询员工的姓名和部门号和年薪，按年薪降序，按姓名升序显示
select last_name, salary * 12 salary_salary
FROM employees
order by salary desc, last_name;
# 2.选择工资不在8000到17000的员工的姓名和工资，按工资降序，显示第21到40位置的数据
select last_name, salary
from employees
where salary not between 8000 and 17000
order by salary desc
limit 20,20;
# 3.查询邮箱中包含e的员工信息，并先按邮箱的字节数降序，再按部门号升序。 LENGTH 长度函数
select *
from employees
where email like '%e%'
order by LENGTH(email) desc, department_id;

/*
  P25 多表查询
*/
SELECT employee_id, department_name
from employees,
     departments
WHERE employees.department_id = departments.department_id;
# 如果查询语句中出现了多个表中都存在的字段，则必须指明此字段所在的表
# 建议从SQL优化的角度，建议多表查询时，每个字段钱都指明所在表的表
# 可以给表起别名，在select和where中使用表的别名
SELECT a.employee_id, b.department_name, a.department_id
from employees a,
     departments b
WHERE a.department_id = b.department_id;
# 6.练习:查询员工信息，如果有n个表实现多表的查询，则需要n-1个连接条件，至少。
select employee_id, last_name, department_name, city
from employees e,
     departments d,
     locations l
where e.department_id = d.department_id
  and l.location_id = d.location_id;

/*
提出问题
角度1：等值连接 VS 非等值连接
角度2：自连接 VS 非自连接
角度3：内连接 VS 外连接
*/

#7.1 不等值连接
SELECT last_name, salary, grade_level
FROM employees e,
     job_grades j
# WHERE e.salary between j.lowest_sal and highest_sal;
WHERE e.salary >= j.lowest_sal
  AND e.salary <= highest_sal;
#7.2 自连接 vs 非自连接
# 查询员工id，员工姓名及其管理者的id和姓名 , 自连接，自己连接自己
SELECT e.employee_id, e.last_name, em.employee_id, em.last_name
FROM employees e,
     employees em
WHERE e.manager_id = em.employee_id;
#7.3 内连接 vs 外连接
/*
  内连接:合并具有同一列的两个以上的表的行，结果集中不包含一个表与另一个表不匹配的行
  外连接:两个表在连接过程中除了返回，满足连接条件的行意外还返回左（右）表中不满足条件的行之外，
        还查询到了左表 或 右表的中不匹配的行。
  外连接:左外连接，又外连接
*/

# 查询所有的员工的last_name , department_name  查询‘ 所有的 ’，外连接。
#SQL99 实现内连接
SELECT last_name, department_name
FROM employees e
         inner JOIN #内连接
    departments d ON
    e.department_id = d.department_id;
#SQL99 左外连接 :  107结果  right OUTER JOIN #右外连接    122结果
SELECT last_name, department_name
FROM employees e
         LEFT OUTER JOIN
     departments d
     ON
         e.department_id = d.department_id;
