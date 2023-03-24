/*

��¥ ���� ������ Ÿ���� �ٷ� �� ����ϴ� ��ɵ� ����

*/

/*

GETDATE()
-- ���� �ð��� ���Ѵ�. �ַ� SELECT �����̳� �������� ����Ѵ�.

*/

select	getdate() as 'NOW'
select	convert(date, getdate()) as 'TODAY'
select	convert(time, getdate()) as 'TIME'
select	convert(char(8), getdate(), 112) as 'DATE'

select	getdate() as 'NOW',
		convert(date, getdate()) as 'TODAY',
		convert(time, getdate()) as 'TIME'


/*

DATEADD()
-- �ð� ���� ���꿡 ����Ѵ�.(����, ����)
-- �⺻ ����
	dateadd(���� ����, ���귮, ���� ��� ��¥)
	���� ��������, (year, month, day, hour, minute, sencond ��� ��� �����ϸ�, �� ����)

	��	YEAR	YY, YYYY
	��	MONTH	MM, M
	��	DAY	DD, D
	��	HOUR	HH
	��	MINUTE	MI, N
	��	SECOND	SS, S
	�и���	MILLISECOND	MS 
	��	WEEK	WK, WW
	�б�	QUARTER	QQ, Q
*/

select	dateadd(day, -1, getdate()) as '����',
		dateadd(day, 1, getdate()) as '����'

select	convert(date, dateadd(day, -1, getdate())) as '����',
		convert(date, dateadd(day, 0, getdate())) as '����',
		convert(date, dateadd(day, 1, getdate())) as '����'

select	convert(date, dateadd(year, -1, getdate())) as [�۳�],
		convert(date, dateadd(year, 1, getdate())) as [����]