CREATE SEQUENCE IF NOT EXISTS recursiva_seq; 

CREATE TABLE IF NOT EXISTS recursiva(
	id BIGINT DEFAULT nextval('recursiva_seq'::regclass) ,
	recursivaid BIGINT DEFAULT NULL, 
	descricao VARCHAR(200) , 
	CONSTRAINT recursiva_pkey PRIMARY KEY(id ) , 
	CONSTRAINT fk_recursiva_recursiva_id FOREIGN KEY (recursivaid) REFERENCES recursiva(id)
);
COMMIT ;
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


	CREATE OR REPLACE FUNCTION recursiva_with()

	RETURNS TEXT AS 
	$body$
	DECLARE
	biMaximum  BIGINT;
	iTotalPrincipais INTEGER := 0 ;
	biMinimum BIGINT ; 
	rRecord RECORD ;

	BEGIN
	
	SELECT MAX(id) FROM recursiva INTO biMaximum ; 
	SELECT MIN(id) FROM recursiva INTO biMinimum  WHERE recursivaid IS NULL ; 
	WHILE biMinimum <  biMaximum 
	LOOP 
	WITH RECURSIVE rsv(descricao ,id ,recursivaid) AS (
	SELECT descricao , id , recursivaid FROM recursiva AS b WHERE id =biMinimum AND recursivaid IS NULL 
	UNION ALL
	SELECT b.descricao , b.id , b.recursivaid FROM rsv 
	JOIN recursiva AS b ON b.recursivaid = rsv.id)
	SELECT * INTO rRecord FROM rsv ;

	iTotalPrincipais := iTotalPrincipais +1 ;
	SELECT CASE WHEN MIN(id) IS NULL THEN 999999 ELSE MIN(id) END  FROM recursiva INTO biMinimum  WHERE recursivaid IS NULL AND id > biMinimum ; 
	
	END LOOP ;

	RETURN 'Total de principais = '||iTotalPrincipais;
	END ;
	$body$
	LANGUAGE plpgsql;

	

	CREATE OR REPLACE FUNCTION recursiva_select()

	RETURNS TEXT AS 
	$body$
	DECLARE 

	biNodeAnterior BIGINT ;
	rRecord RECORD ;
	biMaximum BIGINT ; 
	biMinimum BIGINT ; 
	iTotalPrincipais INTEGER  := 0 ;
	 
	BEGIN 
	SELECT MAX(id) FROM recursiva INTO biMaximum ; 
	SELECT MIN(id) FROM recursiva INTO biMinimum  WHERE recursivaid IS NULL ; 


	WHILE biMinimum < biMaximum
	LOOP

	SELECT id INTO biNodeAnterior FROM recursiva WHERE id = biMinimum ;
	SELECT * INTO rRecord FROM recursiva WHERE id = biMinimum;

	WHILE (SELECT id FROM recursiva WHERE recursivaid = biNodeAnterior) IS NOT NULL 
	LOOP
	SELECT * INTO rRecord FROM recursiva WHERE recursivaid = biNodeAnterior ;
	SELECT id INTO biNodeAnterior FROM recursiva WHERE recursivaid = biNodeAnterior;

	END LOOP ;

	iTotalPrincipais := iTotalPrincipais +1 ;
	SELECT CASE WHEN MIN(id) IS NULL THEN 999999 ELSE MIN(id) END  FROM recursiva INTO biMinimum  WHERE recursivaid IS NULL AND id > biMinimum ; 

	END LOOP; 

	RETURN 'Total de principais = '||iTotalPrincipais;
	END ;
	$body$
	LANGUAGE plpgsql ;