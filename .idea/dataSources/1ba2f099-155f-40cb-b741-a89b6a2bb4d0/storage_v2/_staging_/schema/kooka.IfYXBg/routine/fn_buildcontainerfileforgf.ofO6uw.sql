create function fn_buildBranchFileForGF()
  returns text
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
    FROM (SELECT concat(id, '|', container_do, '|', container_do, '|0|') as rex
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
  END;

