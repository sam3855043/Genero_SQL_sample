MAIN
    DEFINE h base.SqlHandle
    CONNECT TO ":memory:+driver='dbmsqt'"
    CALL create_table()
    LET h = base.SqlHandle.create()
    CALL h.prepare("SELECT * FROM t1 ORDER BY pkey")
    CALL h.openScrollCursor()
    CALL h.fetchFirst()
    DISPLAY h.getResultValue(1), " / ", h.getResultValue(2)
    CALL h.fetchLast()
    DISPLAY h.getResultValue(1), " / ", h.getResultValue(2)
    CALL h.fetchPrevious()
    DISPLAY h.getResultValue(1), " / ", h.getResultValue(2)
    CALL h.fetch()
    DISPLAY h.getResultValue(1), " / ", h.getResultValue(2)
    CALL h.fetchAbsolute(2)
    DISPLAY h.getResultValue(1), " / ", h.getResultValue(2)
    CALL h.fetchRelative(2)
    DISPLAY h.getResultValue(1), " / ", h.getResultValue(2)
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