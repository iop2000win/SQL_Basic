/*

	������ SQL���� ���� ���� ����
	- ���ǹ�
	- �ݺ���
	- ���ν���
	- �Լ�
	- Ʈ����

*/

/*
	���ǹ�
	- CASE WHEN
	- IF ELSE
*/
	-- CASE WHEN
	case	
		when (������) then (������)
		when (������) then (������)
		else (������)
	end

	-- IF ELSE
	if (������)
		(������)
	else if (������)
		(������)
	else if (������)
		(������)
	else
		(������)


/*
	�ݺ���
	- LOOP
	- FOR-LOOP
	- WHILE-LOOP * ms������ WHILE�� ����?

	- �ݺ��������� �б�ó�� (���̽��� continue, pass, break ���� ���)
*/
	-- ���� ���ϱ�
	declare
	@num	int = 1,
	@sum	int = 0,
	@time	int = 10;

	while @num <= @time
	begin
		set	@sum = @sum + @num
		set	@num = @num + 1
	end;

	print(str(@time) + '��°������ �� = ' + str(@sum))


	-- ������ �����غ��� (2�ܺ��� 9�ܱ���)
	declare
	@level	int = 2,
	@num	int = 1; -- ���� ����� ���ÿ� �ʱ�ȭ
		-- set	@num = 0;
		-- set�� �̿��Ͽ� ������ ���� �Ҵ��� �� �ִ�.
	
	while (@level <= 9)
	begin
		while (@num <= 9)
		begin
			print(@level * @num)
			
			set	@num += 1;
		end
		
		set	@level += 1;
		set	@num = 1;
	end


/*
	���ν��� ����
*/
	create procedure [���ν�����] ([�Ķ����])