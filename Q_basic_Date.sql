/*

날짜 관련 데이터 타입을 다룰 때 사용하는 기능들 정리

*/

/*

GETDATE()
현재 시간을 구한다. 주로 SELECT 구문이나 조건절에 사용한다.

CONVERT()
시간을 원하는 형태로 변경한다. convert style 관련 표가 있으며, 해당 값을 입력해주면 그 형태로 변형할 수 있다.

FORMAT() / DATE_FORMAT() (MySQL)
포맷팅을 통해서 시간을 변형하는 함수로, MSSQL에서는 FORMAT, MySQL에서는 DATE_FORMAT을 사용한다.
MySQL에서는 파이썬과 동일하게 %형식으로 포맷팅 형식을 작성해줘야하고,
MSSQL에서는 %없이 문자만 입력해줘야 한다.

*/
	select	getdate() as 'NOW'

	select	convert(date, getdate()) as 'TODAY'
	select	convert(time, getdate()) as 'TIME'
	select	convert(char(8), getdate(), 112) as 'DATE'

	select	getdate() as 'NOW',
			convert(date, getdate()) as 'TODAY',
			convert(time, getdate()) as 'TIME'

	select	format(getdate(), 'yyyy-MM-dd')

/*

DATEADD()
-- 시간 관련 연산에 사용한다.(덧셈, 뺄셈)
-- 기본 문법
	dateadd(연산 단위, 연산량, 연산 대상 날짜)
	연산 단위에는, (year, month, day, hour, minute, sencond 모두 사용 가능하며, 약어도 존재)

	년	YEAR	YY, YYYY
	월	MONTH	MM, M
	일	DAY	DD, D
	시	HOUR	HH
	분	MINUTE	MI, N
	초	SECOND	SS, S
	밀리초	MILLISECOND	MS 
	주	WEEK	WK, WW
	분기	QUARTER	QQ, Q
*/

	select	dateadd(day, -1, getdate()) as '어제',
			dateadd(day, 1, getdate()) as '내일'

	select	convert(date, dateadd(day, -1, getdate())) as '어제',
			convert(date, dateadd(day, 0, getdate())) as '오늘',
			convert(date, dateadd(day, 1, getdate())) as '내일'

	select	convert(date, dateadd(year, -1, getdate())) as [작년],
			convert(date, dateadd(year, 1, getdate())) as [내년]

