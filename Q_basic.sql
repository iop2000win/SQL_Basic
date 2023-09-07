/*
Test 데이터셋 생성
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
GROUP 함수

	1. rollup
	2. grouping
	3. grouping sets
	4. cube
*/

	-- 1. rollup
	-- group by에 의해서 그룹핑되는 단위마다 subtotal을 제공하는 기능
	-- 아래의 예 경우, deptno 단위로 각 그룹이 생성되고, 각 그룹에 대한 sum(sal) 값이 계산되어 row로 추가되는 기능이다.
	select	IIF(deptno is null, '전체합계', cast(deptno as varchar)),
			sum(sal)
	from	#EMP
	group by	rollup(deptno);


	select	deptno,
			job,
			sum(sal)
	from	#EMP
	group by	rollup(deptno, job); -- MySql에서는 -> group by (col1, col2) with rollup


	-- 2. grouping
	-- rollup, cube, grouping sets에서 생성되는 합계값을 구분하기 위한 기능
	-- 생성된 합계값에 대해선 1을 반환, 아닌 경우는 0을 반환한다.
	select	deptno,
			grouping(deptno),
			job,
			grouping(job),
			sum(sal)
	from	#EMP
	group by	rollup(deptno, job);


	select	IIF(deptno is null, '전체합계', cast(deptno as varchar)),
			grouping(deptno),
			IIF(job is null, '부서합계', cast(job as varchar)),
			grouping(job),
			sum(sal)
	from	#EMP
	group by	rollup(deptno, job);


	select	deptno,
			IIF(grouping(deptno) = 1, '전체합계', NULL),
			job,
			IIF(grouping(job) = 1, '부서합계', NULL),
			sum(sal)
	from	#EMP
	group by	rollup(deptno, job);


	-- 3. grouping sets
	-- grouping sets에서 설정한 컬럼들에 대해서, 각각 그룹 함수를 적용한 후,
	-- 별개의 결과 데이터를 union하여 출력하는 개념
	-- 즉, grouping sets(deptno, (deptno, job)) == group by deptno + group by deptno, job
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
	-- 입력한 컬럼에 대해서 결합 가능한 모든 집계를 계산
	-- 리소스가 많이 든다.
	select	deptno,
			job,
			sum(sal)
	from	#EMP
	group by	cube(deptno, job) -- group by job + group by deptno + group by deptno, job + no grouping ***


/*
Window 함수
	
	1. 윈도우 함수
	2. 랭크 함수
	3. etc
*/

	-- 1. 윈도우 함수
	select	empno,
			ename,
			sal,
			sum(sal) over (										-- 어떤 윈도우 데이터에 대해서 함수를 적용할 것인지
							order by sal						-- 정렬 기준
							rows between unbounded preceding	-- 첫 번째 행을 의미
							and unbounded following				-- 마지막 행을 의미
						) totsal
							-- sal 기준으로 정렬한 후(order by), 첫 번째 행부터 마지막 행 사이의 행들을 선택(rows between ~)
							-- 해당 데이터에 대해서(over) 합계를 계산(sum(sal))
	from	#EMP

	select	empno,
			ename,
			sal,
			sum(sal) over (
							order by sal
							rows between unbounded preceding	-- 첫 번째 행부터
							and current row						-- 현재 행까지 (데이터의 집계가 행 단위로 이루어진다고 생각하면, 현재 행이 뭘 칭하는지 이해하기 쉽다)
						) totsal								-- 처음부터 현재까지의 sal의 합 > 누적합계(cumsum)이 계산된다. *** between의 입력값 순서가 중요하다.
	from	#EMP

	select	empno,
			ename,
			sal,
			sum(sal) over (
							order by sal
							rows between current row			-- 현재 행부터
							and unbounded following				-- 마지막 행까지
						) totsal								-- 누적합계의 역으로, 전체 총합에서 이전까지의 행 값을 뺀 결과를 얻을 수 있다.
	from	#EMP
	order by	sal


	-- 2. 랭크 함수
	-- rank : 순위를 계산하며, 동일한 순위에 대해서는 같은 순위 값 부여
	-- dense_rank : 순위를 계산하며, 순위 값은 동일한 순위의 여부와 관계없이 하나씩 증가한다. ex) 2등이 두명이어도 다음 등수는 4등이 아닌 3등
	-- row_number : row 수 카운트
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
	-- cume_dist		: 누적 백분율
	-- percent_rank		: 행의 순서별 백분율
	-- ntile			: 파티션별로 전체 건수를 n등분한 결과
	-- ratio_to_report	: SUM에 대한 백분율

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
									) as dept_a -- window 함수를 사용할 때는 row 지정이 매우 중요하다!
	from	#EMP
	order by deptno, sal desc

	-- lag, lead
	select	deptno,
			ename,
			sal,
			lag(sal) over (order by sal desc) as pre_sal_lag,		-- 지정한 컬럼에 대해서 이전 row의 값을 가져온다.
			lead(sal, 2) over (order by sal desc) as pre_sal_lead	-- 지정한 컬럼에 대해서 지정한 값만큼 아래에 있는 row 값을 가져온다. 인덱스로는 지정 숫자 + 1 만큼 이동
	from	#EMP

	-- percent_rank, ntile
	select	deptno,
			ename,
			sal,
			percent_rank() over (partition by deptno order by sal desc) as percent_sal
			--ntile(4) over (order by sal desc) as n_tile
	from	#EMP