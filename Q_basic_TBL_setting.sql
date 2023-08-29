sp_helpstatus

-- 1. 테이블 생성

	create table	#sample_table
	(
		col1	INT not null primary key, -- 기본키를 약식으로 설정하는 방법
		col2	varchar(10),
		col3	varchar(10),
		col4	varchar(10),
		col5	varchar(10),
		col6	varchar(10),
		col7	varchar(10)
	)

	create table	#sample_table2
	(
		col1	INT not null, -- 기본키를 약식으로 설정하는 방법
		col2	varchar(10),
		col3	varchar(10),
		col4	varchar(10),
		col5	varchar(10),
		col6	varchar(10),
		col7	varchar(10),
		
		constraint primary_key_name primary key (col1) -- 기본키를 설정하는 방법
		-- 2개 이상의 컬럼을 묶어서 기본키를 설정하고 싶을 경우 아래와 같은 방식으로설정
		-- constraint primary_key_name primary key (col1, col2)
	)


-- 1-1. 외래키를 이용한 테이블 생성
	-- 테이블 간 데이터의 참조 무결성을 지키기 위해서 매우 유용한 기능!

	create table	#sample_table3
	(
		col1	INT not null foreign key references	#sample_table(col1),
		col_a	varchar(10) not null,
		col_b	varchar(10)

		constraint primary_key_name primary key (col1, col_a)
	)


-- 2. 컬럼 값 속성 변경

	alter table	TEMP_MART.dbo.NS_DATA_PROCESS_SCHEDULE
	alter column	proc_prd_vlu varchar(10) not null;

	alter table	TEMP_MART.dbo.NS_DATA_PROCESS_SCHEDULE
	alter column	process_code int not null;


-- 3. primary key 설정

	-- 1) primary key 생성
	alter table	TEMP_MART.dbo.NS_DATA_PROCESS_SCHEDULE
	add constraint schedule_pk primary key (proc_prd_vlu, process_code)

	-- 2) primary key 삭제
	alter table	TEMP_MART.dbo.NS_DATA_PROCESS_SCHEDULE
	drop constraint	schedule_pk

	-- 3) primary key 조회
	select	*
	from	information_schema.key_column_usage
	where	table_name = 'NS_DATA_PROCESS_SCHEDULE'


-- 4. 컬럼 추가

	alter table	TEMP_MART.dbo.NS_MAT_LIST_UPDATE_LOG
	add	data_cnt int


-- 5. 데이터 추가
	-- 1) 1개 row 추가
	insert into	table_name	(col1, col2, col3)
	values					(val1, val2, val3)

	insert into	table_name
	values		(val1, val2, val3)

	-- 2) multi row 추가
	insert into	table_name	(col1, col2, col3)
	values					(val1, val2, val3),
							(val4, val5, val6),
							(val7, val8, val9)


-- 6. 컬럼 갯수 확인
	select	count(*)
	from	TEMP_MART.sys.columns
	where	object_id = OBJECT_ID('TEMP_MART.dbo.M_MONTH_202302_TEST')


-- 7. 컬럼 구성 확인
	select	*
	from	information_schema.columns
	where	table_name = ''