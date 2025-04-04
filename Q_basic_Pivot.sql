/*
�⺻���� ����

select	*
from	(�Ǻ� ��� ���̺�) as a
pivot	(
			�׷� �Լ�([���� �÷�]) for [�ǹ� ��� �÷�]
			in ([�ǹ� �÷�1], [�ǹ� �÷�2]], ..., [�ǹ� �÷�n])
		) as pivot_result
		�ǹ� �÷� ���� ���ȣ�� �� �ٿ��� �ϸ�, ���� from ������ ������ ���̺�� pivot ��� ���̺��� ��Ī�� �� �ٿ��� �Ѵ�.
*/

	create table	#emp (
							empno		int,
							ename		varchar(128),
							job			varchar(128),
							mgr			int,
							hiredate	date,
							sal			int,
							comm		int,
							deptno		int
						);

	insert into	#emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
	values	
			(7839, 'KING', 'PRESIDENT', NULL, CONVERT(DATE, '1981-11-17'), 5000, NULL, 10),
			(7698, 'BLAKE', 'MANAGER', 7839, CONVERT(DATE, '1981-05-01'), 2850, NULL, 30),
			(7782, 'CLARK', 'MANAGER', 7839, CONVERT(DATE, '1981-06-09'), 2450, NULL, 10),
			(7566, 'JONES', 'MANAGER', 7839, CONVERT(DATE, '1981-04-02'), 2975, NULL, 20),
			(7788, 'SCOTT', 'ANALYST', 7566, CONVERT(DATE, '1987-04-19'), 3000, NULL, 20),
			(7902, 'FORD', 'ANALYST', 7566, CONVERT(DATE, '1981-12-03'), 3000, NULL, 20),
			(7369, 'SMITH', 'CLERK', 7902, CONVERT(DATE, '1980-12-17'), 800, NULL, 20),
			(7499, 'ALLEN', 'SALESMAN', 7698, CONVERT(DATE, '1981-02-20'), 1600, 300, 30),
			(7521, 'WARD', 'SALESMAN', 7698, CONVERT(DATE, '1981-02-22'),1250, 500, 30),
			(7654, 'MARTIN', 'SALESMAN', 7698, CONVERT(DATE, '1981-09-28'), 1250, 1400, 30),
			(7844, 'TURNER', 'SALESMAN', 7698, CONVERT(DATE, '1981-09-08'), 1500, 0, 30),
			(7876, 'ADAMS', 'CLERK', 7788, CONVERT(DATE, '1987-05-23'), 1100, NULL, 20),
			(7900, 'JAMES', 'CLERK', 7698, CONVERT(DATE, '1981-12-03'), 950, NULL, 30),
			(7934, 'MILLER', 'CLERK', 7782, CONVERT(DATE, '1982-01-23'), 1300, NULL, 10)

	select	*
	from	#emp

	select	distinct job
	from	#emp

	select	distinct deptno
	from	#emp


-- Q1. ������(job), �ٹ�����(deptno) �޿� �հ�
	
	select	*
	from	(
				select	job, deptno, sal -- pivot ����� ����� �÷��� ���ܳ��´�.
				from	#emp
			) a
	pivot	(
				sum(sal) for deptno in ([10], [20], [30])
			) as pivot_result
	order by	job

-- Q2. ������(job), ����� �Ի� �Ǽ�

	select	*
	from	(
				select	job, left(hiredate, 7) as ym, empno
				from	#emp
			) a
	pivot	(
				count(empno) for job in ([president], [manager], [analyst], [clerk], [salesman])
			) as pivot_result
	order by	left(ym, 7)