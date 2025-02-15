CREATE TABLE STOCK (ID INTEGER, PROD CHAR(1), PRE INTEGER);
INSERT INTO STOCK (ID, PROD, PRE) VALUES
    (1, 'A', 17),
    (2, 'A', 23),
    (3, 'B', 19),
    (4, 'B', 28);


SELECT * 
    FROM (
         SELECT ID, PROD, PRE, 
                ROW_NUMBER() OVER (PARTITION BY PROD ORDER BY PRE) AS row_num
            FROM STOCK
        )
    WHERE row_num = 1
    ;

    SELECT ID, PROD, PRE, 
    FROM qt
    QUALIFY ROW_NUMBER() OVER (PARTITION BY PROD ORDER BY PRE) < 20
    ;
