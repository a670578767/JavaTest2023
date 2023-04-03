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

# 8 UNION 合并查询结果 操作符返回两个查询的结果集并集，去除重复纪录  去重
#   UNION ALL 操作符返回两个查询的结果集并集。对于两个结果集的重复部分，不去重

# 第六章练习题
#1.显示所有的员工的姓名，部门号和部门名称
SELECT last_name, e.department_id, department_name
FROM employees e
         LEFT JOIN departments d ON e.department_id = d.department_id;
#2.查询90号部门员工的job_id 和 90号部门的location_id
SELECT e.job_id, d.location_id
FROM employees e
         JOIN departments d on e.department_id = d.department_id
WHERE d.department_id = 90;
# 3.选择所有的奖金的员工的last_name，department_name，location_id，city
SELECT e.last_name, e.commission_pct, d.department_name, d.location_id, l.city
FROM employees e
         left JOIN departments d on e.department_id = d.department_id
         left JOIN locations l on d.location_id = l.location_id
WHERE commission_pct IS NOT NULL;
# 4.选择city在Toronto 工作的员工的last_name , job_id ,department_id,department_name
SELECT e.last_name, e.job_id, d.department_id, d.department_name
FROM employees e
         JOIN departments d on e.department_id = d.department_id
         JOIN locations l on d.location_id = l.location_id
WHERE l.city = 'Toronto';
# 5.查询员工所在的部门名称，部门地址，姓名，工作，工资，其中员工在部门的部门名称为“Executive”
SELECT department_name, street_address, last_name, job_id, salary
FROM employees e
         JOIN departments d on d.department_id = e.department_id
         JOIN locations l on l.location_id = d.location_id
WHERE department_name = 'Executive';

# 6.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
SELECT emp.last_name "employees ", emp.employee_id "Emp#", egr.last_name "manager", egr.employee_id "Mgr#"
FROM employees emp
         left join employees egr on emp.manager_id = egr.employee_id;
# 7.查询哪些部门没有员工
SELECT d.department_id, e.department_id
FROM departments d
         left join employees e on d.department_id = e.department_id
WHERE e.department_id is null;

# 8.查询哪些部门没有员工
SELECT l.location_id, l.city
FROM locations l
         left join departments d on l.location_id = d.location_id
WHERE d.location_id is null;

# 9.查询部门名为Sales 或 IT 的员工信息
SELECT e.employee_id, e.department_id, e.department_id
FROM employees e
         JOIN departments d on d.department_id = e.department_id
WHERE d.department_name in ('Sales', 'IT');

# 第八章 常见的聚合函数
#1，常见的几个聚合函数

#3. HAVING的使用
#4. SQL底层执行原理
# count :
/*
  count : 作用 计算指定字段中在查询结果中出现的个数
  COUNT(*) (1) (字段名)：字段为null时，不计算，容易出错
*/
SELECT COUNT(employee_id) ID, COUNT(salary) SA
FROM employees;

SELECT COUNT(*)
FROM employees;

# 2. GROUP BY 的使用
# 1.Select中出现的非组的函数的字段必须声明在Group By中，反之Group By中声明的字段可以不出现在Select中。
# 2.GROUP BY声明在From后面，where后面，Order by前面，limit前面。
# 3.MySQL中的Group by中使用with rollup
select department_id, AVG(salary)
from employees
group by department_id
with rollup;

# 3.having 用来过滤数据
#查询各个部门中最高工资比10000高的部门信息。
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
having MAX(salary) > 10000;
#结论过滤条件使用了聚合函数，则必须使用having来替换where。
#行，已经被分组，使用聚合函数，满足having字句中条件的分组将被显示，having不能单独使用，必须药跟Group BY一起使用

#方式 1 : 查询部门ID为10,20,30，40这4个部门中最高工资比10000高的部门信息
SELECT department_id, MAX(salary)
FROM employees
WHERE department_id IN (10, 20, 30, 40)
GROUP BY department_id
HAVING MAX(salary) > 10000;

#方式 2
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000
   AND department_id IN (10, 20, 30, 40);

/*
  Where 和 having 的对比
  #当过滤条件中有聚合函数时，则此过滤条件必须声明在having，当过滤条件没有聚合函数时，则此过滤条件声明在where中或having。
  1.从适用范围来讲，having的适用范围更广。
  2.如果过滤条件中没有聚合函数，这种情况下，where的执行效率高于having
  3.互相不排斥
*/

#第八章
# 1.查询公司员工工资的最大值，最小值，平均值，总和。
SELECT MAX(salary), MIN(salary), AVG(salary), SUM(salary)
FROM employees;
# 2.查询各个job_id的员工工资的最大值，最小值，平均值，总和。
# 3.选择具有各个job_id的员工人数
SELECT job_id, count(*)
FROM employees
GROUP BY job_id;
# 5.查询员工最高工资和最低工资的的差距，
SELECT MAX(salary) - MIN(salary) "disparity"
FROM employees;
# 6.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
SELECT MIN(salary), manager_id
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >= 6000;
#7. 查询所有部门名字，location_id，员工数量和平均工资，并按平均工资降序。
SELECT department_name, location_id, count(employee_id), AVG(salary)
from departments d
         LEFT JOIN employees e on d.department_id = e.department_id
group by department_name, location_id
HAVING AVG(salary) IS NOT NULL
ORDER BY AVG(salary) DESC;
# 查询每个工种，每个部门的部门名，工种名和最低工资。
SELECT department_name, job_id, MIN(salary)
FROM departments d
         LEFT JOIN employees e on d.department_id = e.department_id
GROUP BY department_name, job_id;
# 子查询 : 子查询会在主查询之前一次执行完成。子查询的结果被主查询使用。
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');
# 查询工资大于149号员工工资的员工信息
select *
from employees
where salary > (select salary
                from employees
                where employee_id = '149');
# 返回job_id 与 141号员工相同，salary 比 143号员工多的员工姓名，job_id和工资
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where employee_id = 141)
  and salary > (select salary
                from employees
                where employee_id = 143);
#返回公司工资最少的员工的last_name，job_id和salary
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees)