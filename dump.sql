-- we don't know how to generate schema kooka (class Schema) :(
create or replace table if not exists k_creditorlist
(
	id int auto_increment
		primary key,
	creditor_code varchar(255) not null,
	creditor_name varchar(255) not null,
	short_code varchar(255) null,
	active int default 1 not null
)
charset=utf8
;

create or replace table if not exists k_fgstore
(
	id int auto_increment
		primary key,
	itemcode varchar(100) not null,
	qty decimal(10,2) not null,
	location varchar(100) not null,
	type varchar(10) not null,
	branch varchar(100) default 'HQ' not null,
	sublocation varchar(100) null,
	barstock int(10) default 0 null,
	barstock_maxi int(55) not null,
	autopr tinyint default 0 not null,
	daily_usage int(55) not null,
	site int(10) default 1 not null,
	reserved_qty decimal(11,2) not null
)
charset=utf8
;

create or replace table if not exists k_jrtransfer
(
	id int auto_increment
		primary key,
	docno varchar(200) not null,
	docdate date not null,
	from_branch varchar(10) not null,
	to_branch varchar(10) not null,
	trandate timestamp default current_timestamp() not null,
	done_by int not null,
	receive int default 0 not null,
	status int not null
)
charset=utf8
;

create or replace table if not exists k_jrtransferdetail
(
	id int auto_increment
		primary key,
	transid int not null,
	docno varchar(200) not null,
	itemcode varchar(255) not null,
	transferqty decimal(19,2) not null,
	receive int default 0 not null,
	status int not null,
	branch varchar(50) not null
)
charset=utf8
;

create or replace table if not exists k_mat_inout
(
	id int auto_increment
		primary key,
	itemcode varchar(255) not null,
	docno varchar(100) not null,
	doctype varchar(100) not null,
	in_out varchar(100) not null,
	qty decimal(10,2) not null,
	branch varchar(50) not null,
	sublocation varchar(100) null,
	emp varchar(100) null,
	createddate timestamp default current_timestamp() not null on update current_timestamp(),
	createdby int not null,
	qty_before int not null,
	qty_after int not null,
	remarks varchar(255) not null,
	rollno int default 0 not null,
	containerno varchar(200) not null,
	roll int default 0 not null
)
charset=utf8
;

create or replace table if not exists k_material
(
	nprrqID int auto_increment
		primary key,
	material_itemcode varchar(200) not null,
	jr_newitemcode varchar(255) not null,
	jr_supplier varchar(255) not null,
	gu_type varchar(255) not null,
	material_name varchar(200) not null,
	material_description varchar(200) not null,
	size varchar(200) not null,
	size_new varchar(155) not null,
	sizeid int(15) not null,
	logo varchar(200) not null,
	colour varchar(200) not null,
	ink_packing varchar(155) not null,
	nw_kg varchar(155) not null,
	barcode varchar(200) not null,
	materialtype int not null,
	materialgroup int not null,
	fgtype int not null,
	so_no varchar(100) not null,
	qty int default 0 not null,
	uom varchar(20) not null,
	uomid int(15) not null,
	itemcode varchar(200) not null,
	debtid int not null,
	required_date datetime not null,
	postdate timestamp default current_timestamp() not null,
	salesid int default 0 not null,
	remarks varchar(255) not null,
	purchaseid int not null,
	approveddate datetime not null,
	status tinyint default 1 not null,
	active tinyint(1) default 1 not null,
	reason_inactivated varchar(200) not null,
	papermill tinyint(1) not null,
	rollsize double not null,
	ply double not null,
	gsm double not null,
	fsc varchar(100) not null,
	notes varchar(255) not null,
	site int(10) default 1 not null,
	accountid int not null,
	accountaddeddate datetime null
)
charset=utf8
;

create index material_itemcode
	on k_material (material_itemcode)
;

create or replace table if not exists k_matinout_detail
(
	id int auto_increment
		primary key,
	itemcode varchar(200) null,
	docno varchar(200) null,
	doctype varchar(100) null,
	in_out varchar(100) null,
	qty decimal(19,2) null,
	branch varchar(50) null,
	sublocation varchar(100) null,
	matinout_id int null,
	emp varchar(100) null,
	createddate datetime default current_timestamp() null,
	created_by int(2) null,
	qty_before int(1) null,
	qty_after int(1) null,
	remarks varchar(200) null,
	rollno int(2) null,
	containerno varchar(200) null
)
charset=utf8
;

create or replace table if not exists k_po
(
	id int auto_increment
		primary key,
	podockey int not null,
	pono varchar(255) not null,
	podate datetime not null,
	creditorcode varchar(255) not null,
	creditorname varchar(255) not null,
	purchaseagent varchar(255) null,
	createdby varchar(100) not null,
	refdocno varchar(100) null,
	location varchar(20) not null,
	closed tinyint(1) not null,
	currency_code varchar(10) not null,
	currency_rate decimal(19,12) not null,
	total decimal(19,2) not null,
	nettotal decimal(19,2) not null,
	totaltax decimal(19,2) not null,
	tmn_ref int default 1 null
)
charset=utf8
;

create or replace table if not exists k_podetail
(
	id int auto_increment
		primary key,
	podockey int not null,
	podocdtlkey int not null,
	pono varchar(255) not null,
	itemcode varchar(255) not null,
	location varchar(10) not null,
	uom varchar(100) not null,
	qty int not null,
	further_description varchar(255) null,
	pi_no varchar(255) null,
	deliverydate datetime null,
	deliveredqty int not null,
	delivered tinyint(1) default 0 not null,
	unitprice decimal(19,8) not null,
	subtotal decimal(19,2) not null,
	tax decimal(19,2) null,
	taxrate decimal(19,6) null,
	active tinyint(1) default 1 not null
)
charset=utf8
;

create or replace table if not exists k_storeink
(
	id int auto_increment
		primary key,
	container_do varchar(255) not null,
	rollno int not null,
	invno varchar(255) not null,
	itemcode varchar(255) not null,
	weight decimal(19,2) not null,
	width int null,
	fsc varchar(100) null,
	materialtype int default 0 not null,
	suppliercode varchar(100) null,
	date_in datetime default current_timestamp() not null,
	branch varchar(10) not null,
	sublocation varchar(100) null,
	balance_qty int default 1 not null,
	issued_kg decimal(19,2) default 0.00 not null,
	issued int default 0 not null,
	issue_pendingdoc varchar(255) null,
	pendingdoc_detailid int default 0 not null,
	pendingdoctype varchar(255) null,
	machine_no varchar(10) null,
	exp_date date null,
	receivedoc varchar(255) null,
	docdtlkey varchar(255) null,
	doctype varchar(50) null,
	status int default 0 not null
)
charset=utf8
;

create or replace table if not exists k_storejumborolltransfer
(
	id int(13) auto_increment
		primary key,
	transferdetail_id int not null,
	jumborollstore_id int not null,
	itemcode varchar(200) not null,
	containerno varchar(200) not null,
	rollno varchar(100) not null,
	ref_no varchar(100) not null,
	transferto varchar(100) not null,
	transferfrom varchar(10) not null,
	transferqty decimal(19,2) not null,
	branch varchar(50) not null,
	transferdate datetime default current_timestamp() not null,
	trackby int(50) not null,
	status int not null,
	receive int not null
)
charset=utf8
;

create or replace table if not exists k_tpteri
(
	teriid int auto_increment
		primary key,
	tkey varchar(10) not null,
	tvalue varchar(50) not null,
	biz_name varchar(200) not null,
	address1 varchar(200) not null,
	address2 varchar(200) not null,
	postcode int not null,
	city varchar(50) not null,
	state varchar(50) not null,
	tel varchar(100) not null,
	fax varchar(100) not null,
	area_flag int default 0 not null,
	constraint tkey
		unique (tkey)
)
charset=utf8
;

create or replace table if not exists k_unloadingchecklist
(
	id int(15) auto_increment
		primary key,
	suppliername varchar(255) not null,
	code_supplier varchar(100) null,
	pono varchar(100) not null,
	itemcode varchar(200) not null,
	containerno varchar(200) not null,
	total_weight decimal(19,2) not null,
	total_rolls int not null,
	unloading_date date not null,
	conditions int null,
	examination1 int null,
	examination2 int null,
	invno varchar(200) null,
	status int(5) not null,
	branch varchar(35) null,
	sublocation varchar(100) null,
	trackby int(100) null
)
charset=utf8
;

create or replace table if not exists k_unloadingdetail
(
	id int(15) auto_increment
		primary key,
	checkid int not null,
	pono varchar(200) not null,
	itemcode varchar(200) not null,
	containerno varchar(200) not null,
	rollno int(250) not null,
	invno varchar(200) not null,
	width decimal(19,2) null,
	weight decimal(19,2) not null,
	fsc varchar(50) null,
	unloading_date date not null,
	branch varchar(30) null,
	sublocation varchar(100) null,
	trackby int(100) null
)
;

create or replace function fn_buildBranchFileForGF () returns longtext
BEGIN
    DECLARE output TEXT;


    DECLARE file_data TEXT DEFAULT '';

    SET @file_type = 6;
    SET @file_name = 'BRANCH.TXT';
    SET @file_id = 1;

    SET @otherheaders = CONCAT('O_EN=Select Branch' ,CHAR(10),
                               'SEARCH_COL=3;6,1,BRANCH.TXT;2,1',CHAR(10),
                               'COL_DESC=3',CHAR(10),
                               'COL_CODE=2',CHAR(10),
                               'COL_IDX=1',CHAR(10));


    SET file_data = '';

    SELECT CONCAT(file_data, GROUP_CONCAT(rex SEPARATOR '
'), CHAR(10)) INTO file_data
    FROM (SELECT concat(teriid, '|', tkey, '|', COALESCE(biz_name, tkey), '|0|') as rex
          FROM k_tpteri
          GROUP BY tkey
          ORDER BY tkey ASC) X;

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);

    RETURN output;
  END
;

create or replace function fn_buildContainerFile () returns longtext
BEGIN
    DECLARE output TEXT;


    DECLARE file_data TEXT DEFAULT '';

    SET @file_type = 6;
    SET @file_name = 'CNTAINER.TXT';
    SET @file_id = 1;

    SET @otherheaders = CONCAT('SCAN=1', CHAR(10),
                               'O_EN=Please select one ', CHAR(10),
                               'SEARCH_COL=2;6,1,LOCMAP.TXT;1,3', CHAR(10));


    SET file_data = ''; -- CONCAT('-1|N/A|0|', CHAR(10));

    SELECT CONCAT(file_data, GROUP_CONCAT(rex SEPARATOR '
'), CHAR(10)) INTO file_data
    FROM (SELECT concat(id, '|', container_do, '|0|') as rex
          FROM k_storeink
          WHERE status = 1
          GROUP BY container_do
          ORDER BY container_do ASC) X;

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);


    RETURN output;
  END
;

create or replace function fn_buildContainerFileForGF () returns longtext
BEGIN
    DECLARE output LONGTEXT;


    DECLARE file_data LONGTEXT DEFAULT '';

    SET @file_type = 6;
    SET @file_name = 'CSSTORE.TXT';
    SET @file_id = 1;

    SET @otherheaders = CONCAT('O_EN=Select Container' ,CHAR(10),
                               'SEARCH_COL=3;6,1,CSSTORE.TXT;2,1',CHAR(10),
                               'COL_DESC=3',CHAR(10),
                               'COL_CODE=2',CHAR(10),
                               'COL_IDX=1',CHAR(10),
                               'SCHEMA_COL=,,,,stock_code.t', CHAR(10),
                               'SCHEMA_INDEXED_COL=5', CHAR(10));


    SET file_data = CONCAT('-1|N/A|0|', CHAR(10));

    SELECT CONCAT(file_data, GROUP_CONCAT(rex SEPARATOR '
'), CHAR(10)) INTO file_data
    FROM (SELECT concat(id, '|', container_do, '|', container_do, '|0|', itemcode, '|') as rex
          FROM k_storeink
          WHERE status = 1
          GROUP BY container_do
          ORDER BY itemcode ASC, container_do ASC) X;

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);


    RETURN output;
  END
;

create or replace function fn_buildPOFile () returns longtext
BEGIN
    DECLARE output LONGTEXT;


    DECLARE file_data LONGTEXT DEFAULT '';

    SET @file_type = 7;
    SET @file_name = 'PO.LST';
    SET @file_id = 1;

    SET @otherheaders = CONCAT('O_EN=Select PO' ,CHAR(10));


    SET file_data = '';

    SELECT CONCAT(file_data, GROUP_CONCAT(rex SEPARATOR '
'), CHAR(10)) INTO file_data
    FROM (SELECT concat(id, '|', pono, '|', tmn_ref, '|0|') as rex
          FROM k_po

          GROUP BY pono
          ORDER BY pono ASC) X;

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);


    RETURN output;
  END
;

create or replace function fn_buildPOFileForGF () returns longtext
BEGIN
    DECLARE output LONGTEXT;


    DECLARE file_data LONGTEXT DEFAULT '';

    SET @file_type = 6;
    SET @file_name = 'PO.TXT';
    SET @file_id = 1;

    SET @otherheaders = CONCAT('O_EN=Select PO' ,CHAR(10),
                               'SEARCH_COL=3;6,1,PO.TXT;2,1',CHAR(10),
                               'COL_DESC=3',CHAR(10),
                               'COL_CODE=2',CHAR(10),
                               'COL_IDX=1',CHAR(10));


    SET file_data = '';

    SELECT CONCAT(file_data, GROUP_CONCAT(rex SEPARATOR '
'), CHAR(10)) INTO file_data
    FROM (SELECT concat(id, '|', pono, '|', creditorname, '|0|') as rex
          FROM k_po

          GROUP BY pono
          ORDER BY pono ASC) X;

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);


    RETURN output;
  END
;

create or replace function fn_buildPOStockFileForGF () returns longtext
BEGIN
    DECLARE output LONGTEXT DEFAULT '';


    DECLARE file_data LONGTEXT DEFAULT '';
    DECLARE done INT DEFAULT FALSE;
    DECLARE _id BIGINT;
    DECLARE _tmn_ref BIGINT;
    DECLARE _pono VARCHAR(100);
    DECLARE _file_id BIGINT;
    DECLARE _otherheaders TEXT;
    DECLARE _cursor CURSOR FOR SELECT tmn_ref, pono FROM k_po GROUP BY pono ORDER BY pono ASC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET @file_type = 6;
    SET @file_name = 'POSTOCK.TXT';
    SET @sess_id = hex(CEILING(RAND() * 1000000));

    OPEN _cursor;
    _loop: LOOP
      FETCH _cursor
      INTO _tmn_ref, _pono;

      IF done THEN
        LEAVE _loop;
      END IF;

      SET _otherheaders = CONCAT('O_EN=select or scan stock code' ,CHAR(10) ,
                                 'SEARCH_COL=3;6,',_tmn_ref,',POSTOCK.TXT;2,1' , CHAR(10) ,
                                 'COL1IDX=6,',_tmn_ref,',POSTOCK.X1' , CHAR(10) ,
                                 'COL2IDX=6,',_tmn_ref,',POSTOCK.TXT;X2' , CHAR(10) ,
                                 'COL3IDX=6,',_tmn_ref,',POSTOCK.X3' , CHAR(10),
                                 'COL_DESC=2' , CHAR(10) ,
                                 'COL_CODE=3' , CHAR(10) ,
                                 'COL_IDX=1' , CHAR(10) ,
                                 'COL_MAINFILE_LINENUM=4' , CHAR(10) ,
                                 'COL_SORTED_LINENUM=4' , CHAR(10) ,
                                 'IDX_SESS_ID=' , @sess_id , CHAR(10));

      SET file_data = '';
      SELECT CONCAT(file_data, GROUP_CONCAT(rex SEPARATOR '
'), CHAR(10)) INTO file_data
      FROM (SELECT concat(id, '|', COALESCE(itemcode,''), '|', COALESCE(itemcode,''), '|', id, '|', COALESCE(itemcode,''), '|') as rex
            FROM k_podetail
            WHERE pono = _pono
            GROUP BY itemcode
            ORDER BY itemcode ASC) X;

      SET @fd_data = CONCAT(
          'T=', hex(@file_type), CHAR(10),
          'I=', hex(_tmn_ref), CHAR(10),
          'R=1', CHAR(10),
          'L=', @file_name, CHAR(10),
          'M=1', CHAR(10),
          _otherheaders,
          'D=', CHAR(10),
          COALESCE(file_data, ''));

      SET @datalength = LENGTH(@fd_data);

      SET output = CONCAT(output, 'B=', @datalength, CHAR(10), @fd_data);




    END loop;
    CLOSE _cursor;

    RETURN output;
  END
;

create or replace function fn_buildRollsFileForGF () returns longtext
BEGIN
    DECLARE output LONGTEXT;


    DECLARE file_data LONGTEXT DEFAULT '';

    SET SESSION group_concat_max_len = 20000000000;
    SET @file_type = 6;
    SET @file_name = 'CSROLLS.TXT';
    SET @file_id = 1;

    SET @otherheaders = CONCAT('O_EN=Select Container' ,CHAR(10),
                               'SEARCH_COL=2;6,1,CSROLLS.TXT;2,1',CHAR(10),
                               'COL_DESC=2',CHAR(10),
                               'COL_CODE=2',CHAR(10),
                               'COL_IDX=1',CHAR(10),
                               'SCHEMA_COL=,,stock_code.t,container_no.t', CHAR(10),
                               'SCHEMA_INDEXED_COL=3,4', CHAR(10));

    SET file_data = '';

    SELECT CONCAT(file_data, GROUP_CONCAT(rex SEPARATOR '
'), CHAR(10)) INTO file_data
    FROM (SELECT concat(id, '|', rollno, ' (', weight, ' KGs)|', itemcode, '|', container_do, '|') as rex
          FROM k_storeink
          WHERE status = 1
          GROUP BY itemcode, container_do
         ORDER BY itemcode ASC, container_do ASC, rollno ASC
         ) X;

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);


    RETURN output;
  END
;

create or replace function fn_buildStockFileForGF () returns longtext
BEGIN
    DECLARE output LONGTEXT;


    DECLARE file_data LONGTEXT DEFAULT '';

    SET @file_type = 6;
    SET @file_name = 'CSSTOCK.TXT';
    SET @file_id = -1;
    SET @sess_id = hex(CEILING(RAND() * 1000000));

    SET @otherheaders = CONCAT('O_EN=select or scan stock code' ,CHAR(10) ,
                               'SEARCH_COL=3;6,1,CSSTOCK.TXT;2,1' , CHAR(10) ,
                               'COL1IDX=6,1,CSSTOCK.X1' , CHAR(10) ,
                               'COL2IDX=6,1,CSSTOCK.TXT;2' , CHAR(10) ,
                               'COL3IDX=6,1,CSSTOCK.X3' , CHAR(10),
                               'COL_DESC=2' , CHAR(10) ,
                               'COL_CODE=3' , CHAR(10) ,
                               'COL_IDX=1' , CHAR(10) ,
                               'COL_MAINFILE_LINENUM=4' , CHAR(10) ,
                               'COL_SORTED_LINENUM=4' , CHAR(10) ,
                               'IDX_SESS_ID=' , @sess_id , CHAR(10));


    SET file_data = '';

    SELECT CONCAT(file_data, GROUP_CONCAT(rex SEPARATOR '
'), CHAR(10)) INTO file_data
    FROM (SELECT concat(id, '|', itemcode, '|', itemcode, '|', id, '|') as rex
          FROM k_fgstore
          GROUP BY itemcode
          ORDER BY itemcode ASC) X;

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);


    RETURN output;
  END
;

create or replace function fn_buildStoreFile () returns longtext
BEGIN
    DECLARE output LONGTEXT;


    DECLARE file_data LONGTEXT DEFAULT '';

    SET @file_type = 6;
    SET @file_name = 'STORE.LST';
    SET @file_id = 1;

    SET @otherheaders = CONCAT('SCAN=1', CHAR(10),
                               'O_EN=Please select one ', CHAR(10),
                               'SEARCH_COL=2;6,1,LOCMAP.TXT;1,3', CHAR(10));


    SET file_data = CONCAT('-1|N/A|0|', CHAR(10));

    SELECT CONCAT(file_data, GROUP_CONCAT(rex SEPARATOR '
'), CHAR(10)) INTO file_data
    FROM (SELECT concat(container_do, '|', id, '|', container_do, '|0|') as rex
          FROM k_storeink
          WHERE status = 1
          GROUP BY container_do
          ORDER BY container_do ASC) X;

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);


    RETURN output;
  END
;

create or replace function fn_buildTerminalStepTemplateJrReceive () returns text
BEGIN
    DECLARE output TEXT;

    DECLARE file_data TEXT DEFAULT '';

    SET @file_type = 7;
    SET @file_name = 'JRRCVE.DAT';
    SET @file_id = 1;

    SET @otherheaders = '';


    SET file_data = '{
   "id":"jr_receive",
   "form":{
      "title":"Jumbo Roll Details",
      "layout":[
         {
            "ctrl":"input",
            "id":"invoice_no",
            "label":"Invoice Number",
            "type":"string",
            "minlen":1,
            "maxlen":255,
            "keyin":null,
            "title":null
         },{
            "ctrl":"input",
            "id":"container_no",
            "label":"Container No",
            "type":"string",
            "minlen":1,
            "maxlen":255,
            "keyin":null,
            "title":null
         },
         {
            "ctrl":"input",
            "id":"stock_no",
            "label":"Stock Code",
            "type":"lbox",
            "def":{
               "t":"N/A",
               "k":"-1"
            },
            "dsrc":"6,=REF,POSTOCK.TXT",
            "nline":3
         },
         {
            "ctrl":"input",
            "id":"rolls_cnt",
            "label":"No. of Rolls",
            "type":"number",
            "minlen":1,
             "maxlen":255,
             "keyin":null,
             "title":null
         },
         {
            "ctrl":"input",
            "id":"total_weight",
            "label":"Total Weight",
            "type":"number",
            "minlen":1,
             "maxlen":255,
             "keyin":null,
             "title":null

         },{
            "ctrl":"input",
            "id":"listref",
            "label":"JR Detail",
            "type":"listform",
            "minlen":1,
            "maxlen":0,
            "keyin":"stock",
            "title":"Please scan or key in item",
            "autoadd":1,"form":{
               "title":"Enter Roll Weight Detail",
               "layout":[
                  {
                     "ctrl":"input",
                     "id":"roll_no",
                     "label":"Roll No",
                     "type":"number",
                     "minlen":1,
                     "maxlen":255,
                     "keyin":null,
                     "title":null
                  },
                  {
                     "ctrl":"input",
                     "id":"roll_weight",
                     "label":"Roll Weight",
                     "type":"number",
                     "minlen":1,
                     "maxlen":255,
                     "keyin":null,
                     "title":null
                  }
               ]
            }}
      ]
   }
}';

    SET @holder = '{
   "id":"jr_receive",
   "form":{
      "title":"Jumbo Roll Details",
      "layout":[
         {
            "ctrl":"input",
            "id":"po_no",
            "label":"PO No",
            "type":"lbox",
            "dsrc":"6,1,PO.TXT",
            "nline":3
         },
         {
            "ctrl":"input",
            "id":"invoice_no",
            "label":"Invoice Number",
            "type":"string",
            "minlen":1,
            "maxlen":255,
            "keyin":null,
            "title":null
         },{
            "ctrl":"input",
            "id":"container_no",
            "label":"Container No",
            "type":"string",
            "minlen":1,
            "maxlen":255,
            "keyin":null,
            "title":null
         },
         {
            "ctrl":"input",
            "id":"stock_no",
            "label":"Stock Code",
            "type":"lbox",
            "def":{
               "t":"N/A",
               "k":"-1"
            },
            "dsrc":"6,1,CSSTOCK.TXT",
            "nline":3
         },
         {
            "ctrl":"input",
            "id":"rolls_cnt",
            "label":"No. of Rolls",
            "type":"number",
            "minlen":1,
             "maxlen":255,
             "keyin":null,
             "title":null
         },
         {
            "ctrl":"input",
            "id":"total_weight",
            "label":"Total Weight",
            "type":"number",
            "minlen":1,
             "maxlen":255,
             "keyin":null,
             "title":null

         },
         {
            "ctrl":"input",
            "id":"listref",
            "label":"JR Detail",
            "type":"listform",
            "minlen":1,
            "maxlen":0,
            "keyin":"stock",
            "title":"Please scan or key in item",
            "autoadd":1,
            "form":{
               "title":"Scan, key in or select from list",
               "layout":[
                  {
                     "ctrl":"input",
                     "id":"roll_no",
                     "label":"Roll No",
                     "type":"number",
                     "minlen":1,
                     "maxlen":255,
                     "keyin":null,
                     "title":null
                  },
                  {
                     "ctrl":"input",
                     "id":"roll_weight",
                     "label":"Roll Weight",
                     "type":"number",
                     "minlen":1,
                     "maxlen":255,
                     "keyin":null,
                     "title":null
                  }
               ]
            }
         }
      ]
   }
}';

    SET  file_data = trim(replace(replace(file_data, '
',''),'   ',''));

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''), CHAR(10));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);


    RETURN output;
  END
;

create or replace function fn_buildTerminalStepTemplateJrTransfer () returns text
BEGIN
    DECLARE output TEXT;


    DECLARE file_data TEXT DEFAULT '';

    SET @file_type = 7;
    SET @file_name = 'JRTRF.DAT';
    SET @file_id = 1;

    SET @otherheaders = '';


    SET file_data = '{
   "id":"jr_transfer",
   "form":{
      "title":"Jumbo Roll Details",
      "layout":[
         {
            "ctrl":"input",
            "id":"doc_no",
            "label":"Document Number",
            "type":"string",
            "minlen":1,
            "maxlen":255,
            "keyin":null,
            "title":null
         },{
            "ctrl":"input",
            "id":"branch_id",
            "label":"Branch",
            "type":"lbox",
            "dsrc":"6,1,BRANCH.TXT",
            "nline":3
         },
         {
            "ctrl":"input",
            "id":"listref",
            "label":"JR Detail",
            "type":"listform",
            "minlen":1,
            "maxlen":0,
            "keyin":"stock_code",
            "title":"Please scan or key in item",
            "form":{
               "title":"Scan, key in or select from list",
               "layout":[
                  {
                    "ctrl":"input",
                    "id":"stock_code",
                    "label":"Stock Code",
                    "type":"lbox",
                    "def":{
                       "t":"N/A",
                       "k":"-1"
                    },
                    "dsrc":"6,-1,CSSTOCK.TXT",
                    "nline":3
                 },{
                    "ctrl":"input",
                    "id":"container_no",
                    "label":"Container Number",
                    "type":"lbox",
                    "def":{
                       "t":"N/A",
                       "k":"-1"
                    },
                    "dsrc":"6,1,CSSTORE.TXT",
                    "filt":"stock_code.t",
                    "nline":3
                 },{
                    "ctrl":"input",
                    "id":"roll_no",
                    "label":"Roll Number",
                    "type":"lbox",
                    "def":{
                       "t":"N/A",
                       "k":"-1"
                    },
                    "dsrc":"6,1,CSROLLS.TXT",
                    "filt":"stock_code.t&&container_no.t",
                    "nline":3
                 }
               ]
            }
         }
      ]
   }
}';

    SET  file_data = trim(replace(replace(file_data, '
',''),'   ',''));

    SET @fd_data = CONCAT(
        'T=', hex(@file_type), CHAR(10),
        'I=', hex(@file_id), CHAR(10),
        'R=1', CHAR(10),
        'L=', @file_name, CHAR(10),
        'M=1', CHAR(10),
        @otherheaders,
        'D=', CHAR(10),
        COALESCE(file_data, ''),CHAR(10));

    SET @datalength = LENGTH(@fd_data);

    SET output = CONCAT('B=', @datalength, CHAR(10), @fd_data);


    RETURN output;
  END
;

create or replace function fn_formulate_outputstring (buzzer varchar(10), lcd_line1 varchar(300), lcd_line2 varchar(300), lcd_line3 varchar(300), lcd_line4 varchar(300), printer varchar(4096)) returns varchar(4000)
BEGIN
    DECLARE B VARCHAR(10);
    DECLARE ret VARCHAR(4096);
    SET ret = '';

    IF buzzer = '3'
    THEN
      SET buzzer = 'A';
      SET B = 'B`';
    ELSE IF buzzer = '1'
    THEN
      SET B = '';
      SET buzzer = 'A';

    ELSE
      SET buzzer = 'E';
      SET B = 'B`';
    END IF;

      SET ret = CONCAT(ret, '{', B, buzzer, '`}');
      SET lcd_line1 = RTRIM(lcd_line1);
      SET lcd_line2 = RTRIM(lcd_line2);
      SET lcd_line3 = RTRIM(lcd_line3);
      SET lcd_line4 = RTRIM(lcd_line4);
      IF LENGTH(lcd_line1) > 0 OR LENGTH(lcd_line2) > 0 OR LENGTH(lcd_line3) > 0 OR LENGTH(lcd_line4) > 0
      THEN
        SET ret = CONCAT(ret, '{L`');
        IF LENGTH(lcd_line1) > 0
        THEN
          SET ret = CONCAT(ret, '[1`', lcd_line1, '`]');
        END IF;

        IF LENGTH(lcd_line2) > 0
        THEN
          SET ret = CONCAT(ret, '[2`', lcd_line2, '`]');
        END IF;
        IF LENGTH(lcd_line3) > 0
        THEN
          SET ret = CONCAT(ret, '[3`', lcd_line3, '`]');
        END IF;
        IF LENGTH(lcd_line4) > 0
        THEN
          SET ret = CONCAT(ret, '[4`', lcd_line4, '`]');
        END IF;
        SET ret = CONCAT(ret, '`}');
      END IF;

      SET printer = LTRIM(RTRIM(printer));

      IF LENGTH(printer) > 10
      THEN
        SET ret = CONCAT(ret, '{P`', '[T`', printer, '`]`}');
      END IF;

    END IF;

    RETURN ret;


  END
;

create or replace procedure sp_buildAllFiles (IN `_tmn_hw_id` bigint, OUT output longtext)
proc: BEGIN

  SET SESSION GROUP_CONCAT_MAX_LEN = 2000000000;
    SELECT (CONCAT(
              fn_buildContainerFile(),
              fn_buildTerminalStepTemplateJrReceive(),
              fn_buildTerminalStepTemplateJrTransfer(),
              fn_buildContainerFileForGF(),
              fn_buildBranchFileForGF(),
              fn_buildStockFileForGF(),
              fn_buildPOFileForGF(),
              fn_buildPOStockFileForGF(),
              fn_buildPOFile(),
              fn_buildRollsFileForGF()
        )) INTO output;


  end
;

create or replace procedure sp_tmn_offline_action (IN `_data` longtext, IN action varchar(100), OUT output text)
proc: BEGIN
    DECLARE cardno VARCHAR(20);
    DECLARE version VARCHAR(20);
    DECLARE ip_address VARCHAR(30);
    DECLARE txndate DATETIME;
    DECLARE tmntxnid BIGINT;
    DECLARE p1 TEXT;
    DECLARE p54 TEXT;
    DECLARE p128 JSON;
    DECLARE seq BIGINT;
    DECLARE _action_id BIGINT;
    DECLARE _tmn_hw_id BIGINT;

    DECLARE _staff_id BIGINT;
    DECLARE _staff_name VARCHAR(200);
    DECLARE _po_id BIGINT;
    DECLARE _pono VARCHAR(200);
    DECLARE _supplier_code VARCHAR(200);
    DECLARE _supplier_name VARCHAR(200);
    DECLARE _container_no VARCHAR(50);
    DECLARE _invoice_no VARCHAR(50);
    DECLARE _current_item BLOB;
    DECLARE _i INT UNSIGNED DEFAULT 0;
    DECLARE _cnt INT UNSIGNED DEFAULT NULL;

    SET group_concat_max_len = 20000000;

    SET cardno = JSON_UNQUOTE(JSON_EXTRACT(_data, "$.cardno"));
    SET version = JSON_UNQUOTE(JSON_EXTRACT(_data, "$.v"));
    SET txndate = JSON_UNQUOTE(JSON_EXTRACT(_data, "$.txndate"));
    SET seq = JSON_UNQUOTE(JSON_EXTRACT(_data, "$.seq"));
    SET _action_id = JSON_UNQUOTE(JSON_EXTRACT(_data, "$.act"));
    SET p128 = JSON_UNQUOTE(JSON_EXTRACT(_data, "$.p128"));
    SET _po_id = JSON_UNQUOTE(JSON_EXTRACT(_data, "$.p54"));

    IF (action = 'jr_receive') THEN
      SET p128 = JSON_UNQUOTE(JSON_EXTRACT(p128, "$.jr_receive"));
      SET _container_no = JSON_UNQUOTE(JSON_EXTRACT(p128, "$.container_no"));
      SET _invoice_no = JSON_UNQUOTE(JSON_EXTRACT(p128, "$.invoice_no"));
      SET @stock_id = JSON_UNQUOTE(JSON_EXTRACT(JSON_UNQUOTE(JSON_EXTRACT(p128, "$.stock_no")), "$.k"));
      SET @stock_code = JSON_UNQUOTE(JSON_EXTRACT(JSON_UNQUOTE(JSON_EXTRACT(p128, "$.stock_no")), "$.c"));
      SET @stock_name = JSON_UNQUOTE(JSON_EXTRACT(JSON_UNQUOTE(JSON_EXTRACT(p128, "$.stock_no")), "$.t"));
      SET @total_rolls = JSON_UNQUOTE(JSON_EXTRACT(p128, "$.rolls_cnt"));
      SET @total_weight = JSON_UNQUOTE(JSON_EXTRACT(p128, "$.total_weight"));
      SET @roll_detail = JSON_EXTRACT(p128, "$.listref");

      SELECT creditorname, creditorcode, pono
      INTO _supplier_name, _supplier_code, _pono
      FROM k_po
      WHERE id =_po_id;

      INSERT INTO k_unloadingchecklist (suppliername, code_supplier, pono, itemcode, containerno, total_weight, total_rolls, unloading_date, invno, status, branch)
      VALUES (_supplier_name, _supplier_code, _pono, @stock_code, _container_no, @total_weight, @total_rolls,txndate, _invoice_no, 2, _tmn_hw_id);

      SET @idx = LAST_INSERT_ID();
      -- iterate over the rolls detail array
      SET _i = 0;
      SET _cnt = JSON_LENGTH(@roll_detail);
    -- loop from 0 to the last item
      WHILE _i < _cnt DO
        SET _current_item :=
        JSON_EXTRACT(@roll_detail, CONCAT('$[', _i, ']'));
        -- insert detail ::
        INSERT INTO k_unloadingdetail (checkid, pono, itemcode, containerno, rollno, invno, weight, unloading_date, branch)
        VALUES (@idx, _pono, @stock_code, _container_no, JSON_UNQUOTE(JSON_EXTRACT(_current_item, "$.roll_no")), _invoice_no, JSON_UNQUOTE(JSON_EXTRACT(_current_item, "$.roll_weight")), JSON_UNQUOTE(JSON_EXTRACT(_current_item, "$._dt_")), _tmn_hw_id);
        SET _i := _i + 1;
      END WHILE;
      SET output = fn_formulate_outputstring('2', 'SUCCESS', 'JR Receive logged', '', '', '');
    end if;


  end
;

