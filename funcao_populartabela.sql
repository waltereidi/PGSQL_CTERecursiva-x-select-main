
CREATE OR REPLACE FUNCTION popular_recursiva()
	RETURNS  TEXT AS 

	$body$
	DECLARE 
	iCount INTEGER := 1 ;
	BEGIN 

	

	WHILE(iCount < 10000)
	LOOP 

	
	INSERT INTO recursiva 
	VALUES( iCount , NULL , RANDOM()::varchar(200)  );
	INSERT INTO recursiva 
	VALUES (iCount+1 ,  iCount   ,RANDOM()::varchar(200) );

	INSERT INTO recursiva 
	VALUES (iCount+2 ,  iCount+1 ,RANDOM()::varchar(200)   );

	INSERT INTO recursiva 
	VALUES (iCount+3 ,  iCount+2 ,RANDOM()::varchar(200)   );

	INSERT INTO recursiva 
	VALUES (iCount+4 ,  iCount+3 ,RANDOM()::varchar(200)   );

	INSERT INTO recursiva 
	VALUES (iCount+5 ,  iCount+4 ,RANDOM()::varchar(200)   );
	
	iCount := iCount+6;
	
	END LOOP; 
    
    RETURN 'ok';
	END ;
	$body$
	LANGUAGE plpgsql ;
