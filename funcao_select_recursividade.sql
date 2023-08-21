
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