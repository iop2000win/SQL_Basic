/*
Convert
�������� Ÿ���� ��ȯ�� �� ����Ѵ�.

�⺻ ����
	convert(data_type(length), ���� ��� column, ���� ����)
	�������´� ������ �ڵ尪�� ���� �Է��Ѵ�. -- cast���� ������
	https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/
*/

	select	convert(datetime, '2023-01-17 08:23:30')
	select	convert(varchar, getdate(), 112) -- 112 �� ���� �ڵ� ���� ���� ��� ���¸� ������ �� ����




/*

Cast

�⺻ ����
	cast(���� ��� as data_type(length))

*/