/*

	절차형 SQL문에 대한 내용 정리
	- 조건문
	- 반복문
	- 프로시저
	- 함수
	- 트리거

*/

/*
	조건문
	- CASE WHEN
	- IF ELSE
*/
	-- CASE WHEN
	case	
		when (조건절) then (실행절)
		when (조건절) then (실행절)
		else (실행절)
	end

	-- IF ELSE
	if (조건절)
		(실행절)
	else if (조건절)
		(실행절)
	else if (조건절)
		(실행절)
	else
		(실행절)


/*
	반복문
	- LOOP
	- FOR-LOOP
	- WHILE-LOOP * ms에서는 WHILE만 제공?

	- 반복문에서의 분기처리 (파이썬의 continue, pass, break 등의 기능)
*/
	-- 숫자 더하기
	declare
	@num	int = 1,
	@sum	int = 0,
	@time	int = 10;

	while @num <= @time
	begin
		set	@sum = @sum + @num
		set	@num = @num + 1
	end;

	print(str(@time) + '번째까지의 합 = ' + str(@sum))


	-- 구구단 구현해보기 (2단부터 9단까지)
	declare
	@level	int = 2,
	@num	int = 1; -- 변수 선언과 동시에 초기화
		-- set	@num = 0;
		-- set을 이용하여 변수에 값을 할당할 수 있다.
	
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
	프로시저 생성
*/
	create procedure [프로시저명] ([파라미터])