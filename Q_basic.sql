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
	select	IIF(deptno is null, '전체합계', cast(deptno as varchar)),
			sum(sal)
	from	#EMP
	group by	rollup(deptno);


	select	deptno,
			job,
			sum(sal)
	from	#EMP
	group by	rollup(deptno, job);


	-- 2. grouping
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


/*

ROW NUMBER()

윈도우 함수(이게 정확히 뭘까 ?) 중 하나로 결과 집합의 행 일련 번호를 매겨주는 함수(넘버링)

PARTITION BY 구문과 함께 사용하게 되면,
PARTITION BY 를 통해 지정해준 기준을 통해 데이터를 그룹핑하여, 각 그룹마다 넘버링을 할 수 있다.
(넘버링은 0이 아닌 1부터 진행된다.)

RANK 기능과의 차이점은,
말 그대로 RANK는 순위를 매겨주는 것이고, ROW_NUMBER는 순번을 매겨주는 것이다.
동일한 값에 대해서 RANK는 공동 순위가 부여되어 동일한 값이 부여되지만,
ROW_NUMBER는 정렬 기준에 따라 순서대로 값이 부여된다.
# RANK 기능도 사용해보자

*/


WITH emp AS (
    SELECT 7839 empno, 'KING'   ename, 'PRESIDENT' job, NULL mgr, CONVERT(DATE, '1981-11-17') hiredate, 5000 sal, NULL comm, 10 deptno UNION ALL
    SELECT 7698 empno, 'BLAKE'  ename, 'MANAGER'   job, 7839 mgr, CONVERT(DATE, '1981-05-01') hiredate, 2850 sal, NULL comm, 30 deptno UNION ALL
    SELECT 7782 empno, 'CLARK'  ename, 'MANAGER'   job, 7839 mgr, CONVERT(DATE, '1981-06-09') hiredate, 2450 sal, NULL comm, 10 deptno UNION ALL
    SELECT 7566 empno, 'JONES'  ename, 'MANAGER'   job, 7839 mgr, CONVERT(DATE, '1981-04-02') hiredate, 2975 sal, NULL comm, 20 deptno UNION ALL
    SELECT 7788 empno, 'SCOTT'  ename, 'ANALYST'   job, 7566 mgr, CONVERT(DATE, '1987-04-19') hiredate, 3000 sal, NULL comm, 20 deptno UNION ALL
    SELECT 7902 empno, 'FORD'   ename, 'ANALYST'   job, 7566 mgr, CONVERT(DATE, '1981-12-03') hiredate, 3000 sal, NULL comm, 20 deptno UNION ALL
    SELECT 7369 empno, 'SMITH'  ename, 'CLERK'     job, 7902 mgr, CONVERT(DATE, '1980-12-17') hiredate, 800  sal, NULL comm, 20 deptno UNION ALL
    SELECT 7499 empno, 'ALLEN'  ename, 'SALESMAN'  job, 7698 mgr, CONVERT(DATE, '1981-02-20') hiredate, 1600 sal, 300  comm, 30 deptno UNION ALL
    SELECT 7521 empno, 'WARD'   ename, 'SALESMAN'  job, 7698 mgr, CONVERT(DATE, '1981-02-22') hiredate, 1250 sal, 500  comm, 30 deptno UNION ALL
    SELECT 7654 empno, 'MARTIN' ename, 'SALESMAN'  job, 7698 mgr, CONVERT(DATE, '1981-09-28') hiredate, 1250 sal, 1400 comm, 30 deptno UNION ALL
    SELECT 7844 empno, 'TURNER' ename, 'SALESMAN'  job, 7698 mgr, CONVERT(DATE, '1981-09-08') hiredate, 1500 sal, 0    comm, 30 deptno UNION ALL
    SELECT 7876 empno, 'ADAMS'  ename, 'CLERK'     job, 7788 mgr, CONVERT(DATE, '1987-05-23') hiredate, 1100 sal, NULL comm, 20 deptno UNION ALL
    SELECT 7900 empno, 'JAMES'  ename, 'CLERK'     job, 7698 mgr, CONVERT(DATE, '1981-12-03') hiredate, 950  sal, NULL comm, 30 deptno UNION ALL
    SELECT 7934 empno, 'MILLER' ename, 'CLERK'     job, 7782 mgr, CONVERT(DATE, '1982-01-23') hiredate, 1300 sal, NULL comm, 10 deptno
)

SELECT JOB, ENAME, SAL,
		RANK() OVER (ORDER BY SAL DESC) RANK,
		ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUMBER
FROM EMP;


WITH emp AS (
    SELECT 7839 empno, 'KING'   ename, 'PRESIDENT' job, NULL mgr, CONVERT(DATE, '1981-11-17') hiredate, 5000 sal, NULL comm, 10 deptno UNION ALL
    SELECT 7698 empno, 'BLAKE'  ename, 'MANAGER'   job, 7839 mgr, CONVERT(DATE, '1981-05-01') hiredate, 2850 sal, NULL comm, 30 deptno UNION ALL
    SELECT 7782 empno, 'CLARK'  ename, 'MANAGER'   job, 7839 mgr, CONVERT(DATE, '1981-06-09') hiredate, 2450 sal, NULL comm, 10 deptno UNION ALL
    SELECT 7566 empno, 'JONES'  ename, 'MANAGER'   job, 7839 mgr, CONVERT(DATE, '1981-04-02') hiredate, 2975 sal, NULL comm, 20 deptno UNION ALL
    SELECT 7788 empno, 'SCOTT'  ename, 'ANALYST'   job, 7566 mgr, CONVERT(DATE, '1987-04-19') hiredate, 3000 sal, NULL comm, 20 deptno UNION ALL
    SELECT 7902 empno, 'FORD'   ename, 'ANALYST'   job, 7566 mgr, CONVERT(DATE, '1981-12-03') hiredate, 3000 sal, NULL comm, 20 deptno UNION ALL
    SELECT 7369 empno, 'SMITH'  ename, 'CLERK'     job, 7902 mgr, CONVERT(DATE, '1980-12-17') hiredate, 800  sal, NULL comm, 20 deptno UNION ALL
    SELECT 7499 empno, 'ALLEN'  ename, 'SALESMAN'  job, 7698 mgr, CONVERT(DATE, '1981-02-20') hiredate, 1600 sal, 300  comm, 30 deptno UNION ALL
    SELECT 7521 empno, 'WARD'   ename, 'SALESMAN'  job, 7698 mgr, CONVERT(DATE, '1981-02-22') hiredate, 1250 sal, 500  comm, 30 deptno UNION ALL
    SELECT 7654 empno, 'MARTIN' ename, 'SALESMAN'  job, 7698 mgr, CONVERT(DATE, '1981-09-28') hiredate, 1250 sal, 1400 comm, 30 deptno UNION ALL
    SELECT 7844 empno, 'TURNER' ename, 'SALESMAN'  job, 7698 mgr, CONVERT(DATE, '1981-09-08') hiredate, 1500 sal, 0    comm, 30 deptno UNION ALL
    SELECT 7876 empno, 'ADAMS'  ename, 'CLERK'     job, 7788 mgr, CONVERT(DATE, '1987-05-23') hiredate, 1100 sal, NULL comm, 20 deptno UNION ALL
    SELECT 7900 empno, 'JAMES'  ename, 'CLERK'     job, 7698 mgr, CONVERT(DATE, '1981-12-03') hiredate, 950  sal, NULL comm, 30 deptno UNION ALL
    SELECT 7934 empno, 'MILLER' ename, 'CLERK'     job, 7782 mgr, CONVERT(DATE, '1982-01-23') hiredate, 1300 sal, NULL comm, 10 deptno
)

SELECT JOB, ENAME, SAL,
		RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) RANK,
		ROW_NUMBER() OVER (PARTITION BY JOB  ORDER BY SAL DESC) ROW_NUMBER
FROM EMP;