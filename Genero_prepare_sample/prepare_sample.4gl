
IMPORT os
PUBLIC TYPE BookID INTEGER
PUBLIC TYPE CoffeeSaleType RECORD
    SupplierID INTEGER,
    ProductName VARCHAR(30),
    Origin VARCHAR(30),
    RoastLevel INTEGER,
    PricePerKg DECIMAL(10, 2),
    StockKg DATE
END RECORD
PUBLIC TYPE BookType RECORD
    id BookID,
    title STRING,
    description STRING,
    author STRING
END RECORD
PRIVATE DEFINE books DYNAMIC ARRAY OF BookType

MAIN

    DEFINE ls_sql STRING
    DEFINE i,n INTEGER
    DEFINE var1 CHAR(20)
    DEFINE var2 INTEGER

    CONNECT TO "./Webserver_info.db+driver='dbmsqt'"
    TRY 
        DROP TABLE CoffeeProducts
    CATCH
       DISPLAY 'STATUS',STATUS
    END TRY
    TRY 
        DROP TABLE books
    CATCH
       DISPLAY 'STATUS',STATUS
    END TRY

    CREATE TABLE CoffeeProducts (
        SupplierID INTEGER,
        ProductName  VARCHAR(30),
        Origin VARCHAR(30),
        RoastLevel INTEGER,
        PricePerKg DECIMAL(10, 2),
        StockKg DATE
    )
    #https://4js.com/online_documentation/fjs-fgl-3.21.05-manual-html/#fgl-topics/t_fgl_odiagsqt_003.html
    CREATE TABLE books (
        id INT PRIMARY KEY,
        title  VARCHAR(30),
        description  VARCHAR(30)
    )

    INSERT INTO CoffeeProducts (SupplierID, ProductName, Origin, RoastLevel, PricePerKg, StockKg)
    VALUES (1, "Ethiopian Yirgacheffe", "Ethiopia", "Medium", 25.50, 200);

    INSERT INTO CoffeeProducts (SupplierID, ProductName, Origin, RoastLevel, PricePerKg, StockKg)
        VALUES (1, "Colombian Supremo", "Colombia", "Dark", 23.75, 150);

    INSERT INTO CoffeeProducts (SupplierID, ProductName, Origin, RoastLevel, PricePerKg, StockKg)
        VALUES (2, "Sumatra Mandheling", "Indonesia", "Light", 28.00, 100);

    INSERT INTO CoffeeProducts (SupplierID, ProductName, Origin, RoastLevel, PricePerKg, StockKg)
        VALUES (2, "Kenyan AA", "Kenya", "Medium", 30.00, 50);

    

    INSERT INTO books ( title, description) 
         VALUES ('Introduction to Genero', 'A comprehensive guide to developing applications using Genero');
    
    INSERT INTO books (title, description) 
        VALUES ('Advanced Genero Programming', 'Techniques and best practices for experienced developers');
    
    INSERT INTO books (title, description) 
        VALUES ('Genero Web Services', 'Building and deploying RESTful services with Genero');
    
    INSERT INTO books (title, description) 
        VALUES ('Database Optimization', 'Improving performance for database-driven applications');
    
    INSERT INTO books (title, description) 
        VALUES ('Frontend Design with Genero', 'Creating responsive user interfaces using Genero tools');

    LET ls_sql = "SELECT id, title,description from books"


    #https://4js.com/online_documentation/fjs-fgl-manual-html/index.html#fgl-topics/c_fgl_result_sets_FOREACH.html
    #https://4js.com/online_documentation/fjs-fgl-manual-html/index.html#fgl-topics/c_fgl_result_sets_001.html 
    #prepare with foreach example
    PREPARE browse_pre FROM ls_sql
    DECLARE book_search CURSOR FOR  browse_pre
    LET i=1
    FOREACH book_search INTO books[i].title, books[i].description
        DISPLAY books[i].*
        LET i=i+1
    END FOREACH  
    FREE browse_pre

    #https://4js.com/online_documentation/fjs-fgl-manual-html/index.html#fgl-topics/c_fgl_DynamicSql_EXECUTE_IMMEDIATE.html
    #EXECUTE IMMEDIATE
    EXECUTE IMMEDIATE "UPDATE books SET title='Frontend Design with Genero' WHERE id=2"

    #https://4js.com/online_documentation/fjs-fgl-manual-html/index.html#fgl-topics/c_fgl_DynamicSql_EXECUTE.html
    # EXECUTE example
    LET n = 2
    PREPARE s1 FROM "DELETE FROM books WHERE id=?"
    EXECUTE s1 USING n
    FREE s1


    #https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_fgl_DynamicSql_EXECUTE.html
    PREPARE s2 FROM "UPDATE books SET title=? WHERE id=?"
    LET var1 = "aaaa"
    LET var2 = 2
    EXECUTE s2 USING var1, var2

    PREPARE s3 FROM "SELECT title FROM books WHERE id=?"
    LET var2 = 2
    EXECUTE s3 USING var2 INTO var1

    #PREPARE s4 FROM "CALL myproc(?,?)"
    #LET var1 = 'abc'
    #EXECUTE s4 USING var1 IN, var2 OUT

    #https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_fgl_result_sets_FETCH.html
    #FETCH example
    DECLARE c1 SCROLL CURSOR FOR SELECT id, title,description from books 
    OPEN c1
    FETCH c1 INTO books[1].*
    FETCH LAST c1 INTO books[2].* 
    FETCH PREVIOUS c1 INTO  books[3].* 
    FETCH FIRST c1 INTO books[4].*
    FETCH LAST c1 -- INTO clause is optional
    FETCH FIRST c1 -- INTO clause is optional
    CLOSE c1


END MAIN
