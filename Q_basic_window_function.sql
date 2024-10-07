/*

WINDOW �Լ��� ���� ������ ������ ����

*/
create table #employees (
							employee_id INT,
							employee_name VARCHAR(50),
							department_id INT,
							salary DECIMAL(10, 2),
							salary_change_date DATE
						);

insert into	#employees (employee_id, employee_name, department_id, salary, salary_change_date)
values
		(1, 'Alice', 1, 6000, '2020-05-01'),
		(1, 'Alice', 1, 6500, '2021-05-01'),
		(1, 'Alice', 1, 7000, '2022-05-01'),

		(2, 'Bob', 2, 7000, '2019-04-21'),
		(2, 'Bob', 2, 7500, '2020-04-21'),
		(2, 'Bob', 2, 8000, '2021-04-21'),

		(3, 'Charlie', 1, 7500, '2018-07-10'),
		(3, 'Charlie', 1, 8000, '2019-07-10'),
		(3, 'Charlie', 1, 8500, '2020-07-10'),

		(4, 'David', 3, 5000, '2021-02-11'),
		(4, 'David', 3, 5500, '2022-02-11'),

		(5, 'Eve', 2, 6700, '2020-01-15'),
		(5, 'Eve', 2, 7200, '2021-01-15'),
		(5, 'Eve', 2, 7700, '2022-01-15'),

		(6, 'Frank', 1, 8000, '2017-03-17'),
		(6, 'Frank', 1, 8500, '2018-03-17'),
		(6, 'Frank', 1, 9000, '2019-03-17'),

		(7, 'Grace', 3, 5500, '2019-12-05'),
		(7, 'Grace', 3, 6000, '2020-12-05'),

		(8, 'Henry', 1, 7200, '2019-06-11'),
		(8, 'Henry', 1, 7700, '2020-06-11'),
		(8, 'Henry', 1, 8200, '2021-06-11');

select	*
from	#employees

create table	#sales (
						sale_id INT PRIMARY KEY,
						category VARCHAR(50),
						product VARCHAR(50),
						quantity INT,
						price DECIMAL(10, 2),
						sale_date DATE
					);

insert into	#sales (sale_id, category, product, quantity, price, sale_date)
values
		(1, 'Electronics', 'Laptop', 5, 1000.00, '2023-01-05'),
		(2, 'Electronics', 'Smartphone', 10, 800.00, '2023-01-10'),
		(3, 'Electronics', 'Tablet', 8, 600.00, '2023-01-15'),
		(4, 'Clothing', 'T-shirt', 20, 25.00, '2023-01-20'),
		(5, 'Clothing', 'Jeans', 15, 50.00, '2023-01-25'),
		(6, 'Clothing', 'Jacket', 5, 100.00, '2023-02-05'),
		(7, 'Furniture', 'Chair', 10, 75.00, '2023-02-10'),
		(8, 'Furniture', 'Table', 2, 200.00, '2023-02-15'),
		(9, 'Furniture', 'Desk', 3, 150.00, '2023-02-20'),
		(10, 'Electronics', 'Laptop', 7, 1000.00, '2023-02-25'),
		(11, 'Clothing', 'Jacket', 8, 100.00, '2023-03-01'),
		(12, 'Furniture', 'Desk', 5, 150.00, '2023-03-05'),
		(13, 'Electronics', 'Smartphone', 6, 800.00, '2023-03-10'),
		(14, 'Clothing', 'T-shirt', 25, 25.00, '2023-03-15'),
		(15, 'Furniture', 'Chair', 12, 75.00, '2023-03-20');

select	*
from	#sales

/*
	RANK ���

	- RANK: Ư�� �÷��� ���� ���� �������� rank�� �Ű��ִ� ���
		������ ���� ���ؼ��� ������ ������ �ο��ϸ�, ���� ������ŭ ���� ������ �з�����.
		
		RANK() OVER (ORDER BY column_name ASC/DESC)
		RANK() OVER (PARTITION BY sep_column_name ORDER BY column_name ASC/DESC)
		
		column_name = ���� ������ �Ǵ� �÷�
		sep_column_name = �׷��� ������ �Ǵ� �÷�
		ASC/DESC = ���� �÷��� ���ؼ� ��������/�������� ���� ����

	- DENSE_RANK: Ư�� �÷��� ���� ���� �������� rank�� �Ű��ִ� ���
		������ ���� ���ؼ��� ������ ������ �ο��ϸ�, ���� ������ ������� ���� ������ ������� �̾�����.
		
		DENSE_RANK OVER (ORDER BY column_name ASC/DESC)
		DENSE_RANK OVER (PARTITION BY sep_column_name ORDER BY column_name ASC/DESC)
	
	- ROW_NUMBER: Ư�� �÷��� ���� ���� �������� ������ �Ű��ִ� ���
		������ ���� ���ؼ��� ������� ��ȣ�� �ο��Ѵ�. ������� ������ ���� ����

		ROW_NUMBER OVER (ORDER BY column_name ASC/DESC)
		ROW_NUMBER OVER (PARTITION BY sep_column_name ORDER BY column_name ASC/DESC)
*/

select
		employee_id,
		employee_name,
		department_id,
		salary,
		rank() over (partition by department_id order by salary desc) as rank_f,
		dense_rank() over (partition by department_id order by salary desc) as d_rank_f,
		row_number() over (partition by department_id order by salary desc) as row_num
from	#employees;

select
		employee_id,
		employee_name,
		department_id,
		sum(salary) as salary,
		rank() over (partition by department_id order by sum(salary) desc) as rank_f,
		dense_rank() over (partition by department_id order by sum(salary) desc) as d_rank_f,
		row_number() over (partition by department_id order by sum(salary) desc) as row_num
		-- group by�� �Բ� ����� ���, group by �������� �׷��� �� �׷� ������
		-- partition by�� order by�� ����Ǿ� ����ȴ�.
		-- �Ʒ� with���� ���ϸ� ������ ����� ������ ���� �� �� �ִ�.
from	#employees
group by	department_id, employee_id, employee_name;

with t as
(
	select
			employee_id,
			employee_name,
			department_id,
			sum(salary) as salary
	from	#employees
	group by	department_id, employee_id, employee_name
)
select	*,
		rank() over (partition by department_id order by salary desc) as rank_f,
		dense_rank() over (partition by department_id order by salary desc) as d_rank_f,
		row_number() over (partition by department_id order by salary desc) as row_num
from	t

/*
	Shift ���

	- LAG : �÷����� ���� ���� ������ n��° ���� �����͸� �������� ���
		
		LAG(expression, offset, default)
		
		expression = ����� �Ǵ� �÷�
		offset = �� ��° ������ �����͸� ������ ������ ����, �⺻���� 1
		* offset >= 0, 0�� ��� �ڱ� �ڽ��� �״�� �����´�.
		default = ������ ���� ���� ���, � ������ ä�� ������ ����, �⺻���� null
		* coalesce, isnull ����� ������� �ʾƵ� �ȴ�!

	- LEAD : �÷����� ���� ���� ������ n��° ���� �����͸� �������� ���
		
		LEAD(expression, offset, default)
		
		expression = ����� �Ǵ� �÷�
		offset = �� ��° ������ �����͸� ������ ������ ����, �⺻���� 1
		default = ������ ���� ���� ���, � ������ ä�� ������ ����, �⺻���� null
*/

select	*, lag(salary) over(order by employee_id, salary_change_date)
from	#employees

select	*, lead(salary) over(order by employee_id, salary_change_date)
from	#employees

select	
		employee_id,
		employee_name,
		department_id,
		salary,
		lag(salary) over (partition by employee_id order by salary_change_date) as prev_salary,
		salary_change_date,
		lag(salary_change_date) over (partition by employee_id order by salary_change_date) as prev_date,
		datediff(
					month,
					lag(salary_change_date) over (partition by employee_id order by salary_change_date),
					salary_change_date
				) as duration
from	#employees

select
		employee_id,
		employee_name,
		department_id,
		salary,
		lag(salary, 1, salary) over (partition by employee_id order by salary_change_date) as prev_salary,
		lead(salary, 1, salary) over (partition by employee_id order by salary_change_date) as post_salary,
		salary_change_date,
		lag(salary_change_date, 1, salary_change_date) over (partition by employee_id order by salary_change_date) as prev_date,
		lead(salary_change_date, 1, salary_change_date) over (partition by employee_id order by salary_change_date) as post_date,
		datediff(
					month,
					lag(salary_change_date, 1, salary_change_date) over (partition by employee_id order by salary_change_date),
					salary_change_date
				) as duration
from	#employees


/*
	������ �Լ��� �̿��� ���� �Լ��� Ȱ��
	SUM, AVG
*/

select	category, product,
		sum(quantity * price) as sales,
		sum(sum(quantity * price)) over (partition by category order by product) as cum_sales,
		-- partition by �������� �׷����Ͽ� order by ������ ���� ���
		sum(sum(quantity * price)) over (partition by category) as category_total_sales,
		-- order by�� ������ partition by �������� �׷����Ͽ� �ش� �׷� ��ü�� ���� ����� ����
		sum(sum(quantity * price)) over () as total_sales
		-- ������ ���� ���� ��ü ������ ����
from	#sales
group by	category, product

select	*,
		avg(quantity) over (partition by category order by product),
		-- ���� ����� ���, partition by ���� ���� ������, order by ������ �� / ��� �� ���
		avg(quantity) over (partition by category),
		-- �׷� ����� partition by ���� ���� �� / �� ����
		avg(quantity) over ()
		-- ��ü ��� ���
from	#sales
