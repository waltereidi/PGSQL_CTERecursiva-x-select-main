
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
