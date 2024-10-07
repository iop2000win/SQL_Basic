/*

WINDOW 함수에 대한 내용을 정리한 문서

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
	RANK 기능

	- RANK: 특정 컬럼에 대한 정렬 기준으로 rank를 매겨주는 기능
		동일한 값에 대해서는 동일한 순위를 부여하며, 동일 순위만큼 다음 순위가 밀려난다.
		
		RANK() OVER (ORDER BY column_name ASC/DESC)
		RANK() OVER (PARTITION BY sep_column_name ORDER BY column_name ASC/DESC)
		
		column_name = 정렬 기준이 되는 컬럼
		sep_column_name = 그룹핑 기준이 되는 컬럼
		ASC/DESC = 기준 컬럼에 대해서 오름차순/내림차순 정렬 결정

	- DENSE_RANK: 특정 컬럼에 대한 정렬 기준으로 rank를 매겨주는 기능
		동일한 값에 대해서는 동일한 순위를 부여하며, 동일 순위에 상관없이 다음 순위는 순서대로 이어진다.
		
		DENSE_RANK OVER (ORDER BY column_name ASC/DESC)
		DENSE_RANK OVER (PARTITION BY sep_column_name ORDER BY column_name ASC/DESC)
	
	- ROW_NUMBER: 특정 컬럼에 대한 정렬 기준으로 순번을 매겨주는 기능
		동일한 값에 대해서도 순서대로 번호를 부여한다. 순서대로 개수를 세는 개념

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
		-- group by와 함께 사용할 경우, group by 기준으로 그룹핑 된 그룹 내에서
		-- partition by와 order by가 적용되어 집계된다.
		-- 아래 with문과 비교하면 동일한 결과가 나오는 것을 알 수 있다.
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
	Shift 기능

	- LAG : 컬럼에서 정렬 기준 내에서 n번째 이전 데이터를 가져오는 기능
		
		LAG(expression, offset, default)
		
		expression = 대상이 되는 컬럼
		offset = 몇 번째 이전의 데이터를 가져올 것인지 설정, 기본값은 1
		* offset >= 0, 0일 경우 자기 자신을 그대로 가져온다.
		default = 가져올 값이 없을 경우, 어떤 값으로 채울 것인지 설정, 기본값은 null
		* coalesce, isnull 기능을 사용하지 않아도 된다!

	- LEAD : 컬럼에서 정렬 기준 내에서 n번째 이후 데이터를 가져오는 기능
		
		LEAD(expression, offset, default)
		
		expression = 대상이 되는 컬럼
		offset = 몇 번째 이후의 데이터를 가져올 것인지 설정, 기본값은 1
		default = 가져올 값이 없을 경우, 어떤 값으로 채울 것인지 설정, 기본값은 null
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
	윈도우 함수를 이용한 집계 함수의 활용
	SUM, AVG
*/

select	category, product,
		sum(quantity * price) as sales,
		sum(sum(quantity * price)) over (partition by category order by product) as cum_sales,
		-- partition by 기준으로 그룹핑하여 order by 순으로 누적 계산
		sum(sum(quantity * price)) over (partition by category) as category_total_sales,
		-- order by가 없으면 partition by 기준으로 그룹핑하여 해당 그룹 전체에 대해 계산을 진행
		sum(sum(quantity * price)) over () as total_sales
		-- 나누는 기준 없이 전체 데이터 집계
from	#sales
group by	category, product

select	*,
		avg(quantity) over (partition by category order by product),
		-- 누적 평균의 경우, partition by 기준 범위 내에서, order by 기준의 합 / 행수 로 계산
		avg(quantity) over (partition by category),
		-- 그룹 평균은 partition by 기준 범위 합 / 행 개수
		avg(quantity) over ()
		-- 전체 평균 계산
from	#sales
