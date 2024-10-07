create table #purchases (
						  purchase_id  INT IDENTITY (1, 1) NOT NULL PRIMARY KEY,
						  user_id INT,
						  purchase_date DATE
						);

insert into	#purchases (user_id, purchase_date)
values
		(101, '2024-07-02'),
		(102, '2024-07-03'),
		(103, '2024-07-10'),
		(101, '2024-07-15'),
		(104, '2024-07-20'),
		(105, '2024-07-25'),
		(106, '2024-07-28'),
		(101, '2024-08-01'),
		(102, '2024-08-05'),
		(103, '2024-08-08'),
		(104, '2024-08-15'),
		(106, '2024-08-20'),
		(107, '2024-08-22'),
		(108, '2024-08-25'),
		(109, '2024-08-27'),
		(101, '2024-09-01'),
		(102, '2024-09-03'),
		(103, '2024-09-05'),
		(104, '2024-09-07'),
		(105, '2024-09-09'),
		(106, '2024-09-10'),
		(110, '2024-09-12'),
		(101, '2024-09-13'),
		(111, '2024-09-15'),
		(107, '2024-09-17'),
		(108, '2024-09-18'),
		(102, '2024-09-19'),
		(103, '2024-09-20'),
		(112, '2024-09-22'),
		(113, '2024-09-23'),
		(109, '2024-09-25'),
		(114, '2024-09-26'),
		(110, '2024-09-27');

select	*
from	#purchases;

-- 첫 구매 케이스
with case_1 as (
				select	
						user_id,
						convert(char(6), min(purchase_date), 112) as first_date
				from	#purchases
				group by	user_id
				)
select	
		first_date,
		'case1' as 'type',
		count(user_id) as cnt
from	case_1
group by	first_date;

-- 두달 연속 구매 케이스
with case_2 as (
				select	
						user_id,
						convert(char(6), purchase_date, 112) as ym,
						lag(convert(char(6), purchase_date, 112), 1) over (partition by user_id order by convert(char(6), purchase_date, 112)) as prev_1_ym,
						lag(convert(char(6), purchase_date, 112), 2) over (partition by user_id order by convert(char(6), purchase_date, 112)) as prev_2_ym
				from	#purchases
				group by	convert(char(6), purchase_date, 112), user_id
				)
select
		ym,
		'case2' as 'type',
		count(user_id) as cnt
from	case_2
where	dateadd(month, -1, convert(date, left(ym, 4) + '-' + right(ym, 2) + '-01', 23)) = convert(date, left(prev_1_ym, 4) + '-' + right(prev_1_ym, 2) + '-01', 23)
	and	prev_2_ym is null
group by	ym;

-- 세달 연속 구매 케이스
with case_3 as (
				select	
						user_id,
						convert(char(6), purchase_date, 112) as ym,
						lag(convert(char(6), purchase_date, 112), 1) over (partition by user_id order by convert(char(6), purchase_date, 112)) as prev_1_ym,
						lag(convert(char(6), purchase_date, 112), 2) over (partition by user_id order by convert(char(6), purchase_date, 112)) as prev_2_ym
				from	#purchases
				group by	convert(char(6), purchase_date, 112), user_id
				)
select	
		ym,
		'case3' as 'type',
		count(user_id) as cnt
from	case_3
where	prev_1_ym is not null
	and	prev_2_ym is not null
group by	ym;

-- 이달 구매하고, 전달 X, 전전달 구매 케이스
with case_4 as (
				select	
						user_id,
						convert(char(6), purchase_date, 112) as ym,
						lag(convert(char(6), purchase_date, 112), 1) over (partition by user_id order by convert(char(6), purchase_date, 112)) as prev_1_ym,
						lag(convert(char(6), purchase_date, 112), 2) over (partition by user_id order by convert(char(6), purchase_date, 112)) as prev_2_ym
				from	#purchases
				group by	convert(char(6), purchase_date, 112), user_id
				)
select	
		ym,
		'case4' as 'type',
		count(user_id) as cnt
from	case_4
where	dateadd(month, -2, convert(date, left(ym, 4) + '-' + right(ym, 2) + '-01', 23)) = convert(date, left(prev_1_ym, 4) + '-' + right(prev_1_ym, 2) + '-01', 23)
	and	prev_2_ym is null
group by	ym;