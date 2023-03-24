sp_helpstatus

-- 1. 테이블 생성

	create table	sample_table
	(
		col1	INT not null primary key,
		col2	varchar(10),
		col3	varchar(10),
		col4	varchar(10),
		col5	varchar(10),
		col6	varchar(10),
		col7	varchar(10)
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