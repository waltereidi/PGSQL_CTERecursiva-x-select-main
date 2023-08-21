CREATE SEQUENCE IF NOT EXISTS recursiva_seq; 

CREATE TABLE IF NOT EXISTS recursiva(
	id BIGINT DEFAULT nextval('recursiva_seq'::regclass) ,
	recursivaid BIGINT DEFAULT NULL, 
	descricao VARCHAR(200) , 
	CONSTRAINT recursiva_pkey PRIMARY KEY(id ) , 
	CONSTRAINT fk_recursiva_recursiva_id FOREIGN KEY (recursivaid) REFERENCES recursiva(id)
);