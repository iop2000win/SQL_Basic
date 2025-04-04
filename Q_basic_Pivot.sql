/*
기본적인 사용법

select	*
from	(피봇 대상 테이블) as a
pivot	(
			그룹 함수([집계 컬럼]) for [피벗 대상 컬럼]
			in ([피벗 컬럼1], [피벗 컬럼2]], ..., [피벗 컬럼n])
		) as pivot_result
		피벗 컬럼 값에 대괄호는 꼭 붙여야 하며, 또한 from 절에서 지정한 테이블과 pivot 결과 테이블의 별칭은 꼭 붙여야 한다.
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


-- Q1. 직군별(job), 근무지별(deptno) 급여 합계
	
	select	*
	from	(
				select	job, deptno, sal -- pivot 결과에 사용할 컬럼만 남겨놓는다.
				from	#emp
			) a
	pivot	(
				sum(sal) for deptno in ([10], [20], [30])
			) as pivot_result
	order by	job

-- Q2. 직군별(job), 년월별 입사 건수

	select	*
	from	(
				select	job, left(hiredate, 7) as ym, empno
				from	#emp
			) a
	pivot	(
				count(empno) for job in ([president], [manager], [analyst], [clerk], [salesman])
			) as pivot_result
	order by	left(ym, 7)