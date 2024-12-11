MAIN
    DEFINE h base.SqlHandle,
           v VARCHAR(50),
           i INTEGER
    CONNECT TO ":memory:+driver='dbmsqt'"
    CALL create_table()
    LET h = base.SqlHandle.create()
    CALL h.prepare("SELECT * FROM t1 WHERE name>? ORDER BY pkey")

    LET v = "a"
    CALL h.setParameter(1, v)
    CALL h.open()
    WHILE TRUE
        CALL h.fetch()
        IF sqlca.sqlcode==NOTFOUND THEN
           EXIT WHILE
        END IF
        DISPLAY "-----------------"
        FOR i=1 TO h.getResultCount()
            DISPLAY i, ":", h.getResultName(i),
                    " / ", h.getResultType(i),
                    " = ", h.getResultValue(i)
        END FOR
    END WHILE
    CALL h.close()
END MAIN

FUNCTION create_table()
    CREATE TABLE t1 ( pkey INTEGER PRIMARY KEY,
                      name VARCHAR(50) )
    INSERT INTO t1 VALUES ( 101, 'aaaaa' )
    INSERT INTO t1 VALUES ( 102, 'bbbbbbbb' )
    INSERT INTO t1 VALUES ( 103, 'cccccc' )
    INSERT INTO t1 VALUES ( 104, 'ddddddd' )
END FUNCTION