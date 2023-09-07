/*
Test �����ͼ� ����
*/

	create table	#EMP
	(
		empno	numeric(10) primary key,
		ename	varchar(20),
		deptno	numeric(10),
		mgr		numeric(10),
		job		varchar(20),
		sal		numeric(10)
	)

	insert into #EMP values (1000, 'TEST1', 20, NULL, 'CLERK', 800)
	insert into #EMP values (1001, 'TEST2', 30, 1000, 'SALESMAN', 1600)
	insert into #EMP values (1002, 'TEST3', 30, 1000, 'SALESMAN', 1250)
	insert into #EMP values (1003, 'TEST4', 20, 1000, 'MANAGER', 2975)
	insert into #EMP values (1004, 'TEST5', 30, 1000, 'SALESMAN', 1250)
	insert into #EMP values (1005, 'TEST6', 30, 1001, 'MANAGER', 2850)
	insert into #EMP values (1006, 'TEST7', 10, 1001, 'MANAGER', 2450)
	insert into #EMP values (1007, 'TEST8', 20, 1006, 'ANALYST', 3000)
	insert into #EMP values (1008, 'TEST9', 30, 1006, 'PRESIDENT', 5000)
	insert into #EMP values (1009, 'TEST10', 30, 1002, 'SALESMAN', 1500)
	insert into #EMP values (1010, 'TEST11', 20, 1002, 'CLERK', 1100)
	insert into #EMP values (1011, 'TEST12', 30, 1001, 'CLERK', 950)
	insert into #EMP values (1012, 'TEST13', 20, 1000, 'ANALYST', 3000)
	insert into #EMP values (1013, 'TEST14', 10, 1000, 'CLERK', 1300)

	select	*
	from	#EMP


/*
GROUP �Լ�

	1. rollup
	2. grouping
	3. grouping sets
	4. cube
*/

	-- 1. rollup
	-- group by�� ���ؼ� �׷��εǴ� �������� subtotal�� �����ϴ� ���
	-- �Ʒ��� �� ���, deptno ������ �� �׷��� �����ǰ�, �� �׷쿡 ���� sum(sal) ���� ���Ǿ� row�� �߰��Ǵ� ����̴�.
	select	IIF(deptno is null, '��ü�հ�', cast(deptno as varchar)),
			sum(sal)
	from	#EMP
	group by	rollup(deptno);


	select	deptno,
			job,
			sum(sal)
	from	#EMP
	group by	rollup(deptno, job); -- MySql������ -> group by (col1, col2) with rollup


	-- 2. grouping
	-- rollup, cube, grouping sets���� �����Ǵ� �հ谪�� �����ϱ� ���� ���
	-- ������ �հ谪�� ���ؼ� 1�� ��ȯ, �ƴ� ���� 0�� ��ȯ�Ѵ�.
	select	deptno,
			grouping(deptno),
			job,
			grouping(job),
			sum(sal)
	from	#EMP
	group by	rollup(deptno, job);


	select	IIF(deptno is null, '��ü�հ�', cast(deptno as varchar)),
			grouping(deptno),
			IIF(job is null, '�μ��հ�', cast(job as varchar)),
			grouping(job),
			sum(sal)
	from	#EMP
	group by	rollup(deptno, job);


	select	deptno,
			IIF(grouping(deptno) = 1, '��ü�հ�', NULL),
			job,
			IIF(grouping(job) = 1, '�μ��հ�', NULL),
			sum(sal)
	from	#EMP
	group by	rollup(deptno, job);


	-- 3. grouping sets
	-- grouping sets���� ������ �÷��鿡 ���ؼ�, ���� �׷� �Լ��� ������ ��,
	-- ������ ��� �����͸� union�Ͽ� ����ϴ� ����
	-- ��, grouping sets(deptno, (deptno, job)) == group by deptno + group by deptno, job
	select	deptno,
			job,
			sum(sal)
	from	#EMP
	group by	grouping sets(deptno, (deptno, job))

	
	select	deptno,
			sum(sal) as sum_sal
	from	#EMP
	group by	deptno

	select	deptno,
			job,
			sum(sal) as sum_sal
	from	#EMP
	group by	deptno, job
	order by	deptno, job


	-- 4. cube
	-- �Է��� �÷��� ���ؼ� ���� ������ ��� ���踦 ���
	-- ���ҽ��� ���� ���.
	select	deptno,
			job,
			sum(sal)
	from	#EMP
	group by	cube(deptno, job) -- group by job + group by deptno + group by deptno, job + no grouping ***


/*
Window �Լ�
	
	1. ������ �Լ�
	2. ��ũ �Լ�
	3. etc
*/

	-- 1. ������ �Լ�
	select	empno,
			ename,
			sal,
			sum(sal) over (										-- � ������ �����Ϳ� ���ؼ� �Լ��� ������ ������
							order by sal						-- ���� ����
							rows between unbounded preceding	-- ù ��° ���� �ǹ�
							and unbounded following				-- ������ ���� �ǹ�
						) totsal
							-- sal �������� ������ ��(order by), ù ��° ����� ������ �� ������ ����� ����(rows between ~)
							-- �ش� �����Ϳ� ���ؼ�(over) �հ踦 ���(sum(sal))
	from	#EMP

	select	empno,
			ename,
			sal,
			sum(sal) over (
							order by sal
							rows between unbounded preceding	-- ù ��° �����
							and current row						-- ���� ����� (�������� ���谡 �� ������ �̷�����ٰ� �����ϸ�, ���� ���� �� Ī�ϴ��� �����ϱ� ����)
						) totsal								-- ó������ ��������� sal�� �� > �����հ�(cumsum)�� ���ȴ�. *** between�� �Է°� ������ �߿��ϴ�.
	from	#EMP

	select	empno,
			ename,
			sal,
			sum(sal) over (
							order by sal
							rows between current row			-- ���� �����
							and unbounded following				-- ������ �����
						) totsal								-- �����հ��� ������, ��ü ���տ��� ���������� �� ���� �� ����� ���� �� �ִ�.
	from	#EMP
	order by	sal


	-- 2. ��ũ �Լ�
	-- rank : ������ ����ϸ�, ������ ������ ���ؼ��� ���� ���� �� �ο�
	-- dense_rank : ������ ����ϸ�, ���� ���� ������ ������ ���ο� ������� �ϳ��� �����Ѵ�. ex) 2���� �θ��̾ ���� ����� 4���� �ƴ� 3��
	-- row_number : row �� ī��Ʈ
	select	ename,
			job,
			sal,
			rank() over (order by sal desc) all_rank,
			dense_rank() over (order by sal desc) 'dense_rank',
			row_number() over (order by sal desc) 'row_number',
			rank() over (partition by job order by sal desc) job_rank,
			dense_rank() over (partition by job order by sal desc) job_dense_rank,
			row_number() over (partition by job order by sal desc) jon_row_number
	from	#EMP
	order by sal desc


	-- 3. etc
	-- first_value = min
	-- last_value = max
	-- lag
	-- lead
	-- cume_dist		: ���� �����
	-- percent_rank		: ���� ������ �����
	-- ntile			: ��Ƽ�Ǻ��� ��ü �Ǽ��� n����� ���
	-- ratio_to_report	: SUM�� ���� �����

	-- first_value
	select	deptno,
			ename,
			sal,
			first_value(ename) over (partition by deptno order by sal desc 
									 rows unbounded preceding
									 ) as dept_a
	from	#EMP

	-- last_value
	select	deptno,
			ename,
			sal,
			last_value(ename) over (partition by deptno order by sal desc
									rows between current row and unbounded following
									) as dept_a
	from	#EMP
	order by deptno, sal desc

	select	deptno,
			ename,
			sal,
			last_value(ename) over (partition by deptno order by sal desc
									rows between unbounded preceding and unbounded following
									) as dept_a -- window �Լ��� ����� ���� row ������ �ſ� �߿��ϴ�!
	from	#EMP
	order by deptno, sal desc

	-- lag, lead
	select	deptno,
			ename,
			sal,
			lag(sal) over (order by sal desc) as pre_sal_lag,		-- ������ �÷��� ���ؼ� ���� row�� ���� �����´�.
			lead(sal, 2) over (order by sal desc) as pre_sal_lead	-- ������ �÷��� ���ؼ� ������ ����ŭ �Ʒ��� �ִ� row ���� �����´�. �ε����δ� ���� ���� + 1 ��ŭ �̵�
	from	#EMP

	-- percent_rank, ntile
	select	deptno,
			ename,
			sal,
			percent_rank() over (partition by deptno order by sal desc) as percent_sal
			--ntile(4) over (order by sal desc) as n_tile
	from	#EMP