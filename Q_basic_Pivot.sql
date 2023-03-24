/*
�⺻���� ����

SELECT *
FROM (�Ǻ� ��� ���̺�) as A
PIVOT (�׷� �Լ�(���� �÷�)
FOR �ǹ� ��� �÷�
IN ([�ǹ� �÷�1], [�ǹ� �÷�2], ..., [�ǹ� �÷�n])) as RESULT -- �ǹ� �÷� ���� ���ȣ�� �� �ٿ��� �ϸ�, ���� FROM������ ������ ���̺�� PIVOT ��� ���̺��� ��Ī�� �� �ٿ��� �Ѵ�.
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

--SELECT * FROM emp
-- Q1. ������(job), �ٹ�����(deptno) �޿� �հ�

--SELECT *
--FROM (SELECT job, deptno, sal FROM emp) as A
--PIVOT (SUM(sal)
--FOR deptno
--IN ([10], [20], [30])) as RESULT


-- Q2. ������(job), ����� �Ի� �Ǽ�
SELECT *
FROM (SELECT job, LEFT(hiredate, 7) as YM FROM emp) as A
PIVOT (COUNT(job)
FOR job
IN ([PRESIDENT], [MANAGER], [ANALYST], [CLERK], [SALESMAN])) as RESULT