create function fn_buildPOStockFileForGF()
  returns text
  BEGIN
    DECLARE output TEXT;


    DECLARE file_data TEXT DEFAULT '';

    SET @file_type = 6;
    SET @file_name = 'CSSTOCK.TXT';
    SET @file_id = 1;
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
  END;

