MAIN
    DEFINE h base.SqlHandle
    DEFINE pkey INTEGER
    CONNECT TO ":memory:+driver='dbmsqt'"
    CALL create_table()
    LET h = base.SqlHandle.create()
    CALL h.prepare("UPDATE t1 SET crea = ? WHERE pkey = ?")
    CALL h.setParameterType(1,"DATE")
    CALL h.setParameter(1,TODAY)
    CALL h.setParameter(2,pkey)
    TRY
        CALL h.execute()
    CATCH
        DISPLAY "SQL Error:", sqlca.sqlcode
    END TRY
END MAIN

FUNCTION create_table()
    DEFINE v_date DATE
    CREATE TABLE t1 ( pkey INTEGER PRIMARY KEY,
                      name VARCHAR(50),
                      crea DATE )
    LET v_date = TODAY
    INSERT INTO t1 VALUES ( 101, 'aaaaa', v_date )
    INSERT INTO t1 VALUES ( 102, 'bbbbbbbb', v_date )
END FUNCTION