/*
Convert
데이터의 타입을 변환할 때 사용한다.

기본 문법
	convert(data_type(length), 변경 대상 column, 변경 형태)
	변경형태는 지정된 코드값을 통해 입력한다. -- cast와의 차이점
	https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/
*/

	select	convert(datetime, '2023-01-17 08:23:30')
	select	convert(varchar, getdate(), 112) -- 112 와 같은 코드 값을 통해 출력 형태를 결정할 수 있음




/*

Cast

기본 문법
	cast(변경 대상 as data_type(length))

*/