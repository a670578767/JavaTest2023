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

# 练习 ：查询部门为10,20,30部门的员工信息
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
SELECT last_name,salary
FROM employees
ORDER BY salary DESC
# LIMIT 0,1;
LIMIT 1;