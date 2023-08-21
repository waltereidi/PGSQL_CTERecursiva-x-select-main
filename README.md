Tempos de execução

WITH RECURSIVE :

Query OK (execution time: 62 ms; total time: 125 ms)
Return Value: Total de principais = 1667


SELECT com programação para verificar recursividade 
Query OK (execution time: 15.359 sec; total time: 15.422 sec)
Return Value: Total de principais = 1667

123000% , 123 vezes mais rápido para fazer a mesma operação e retornar a mesma quantidade de registros com 5 níveis de herança e 10000 linhas na tabela.

O teste verifica a diferença de performance entre a operação nativa do postgres para fazer recursividade e 
a manobra de select que é possivel fazer para verificar se há filhos de registros contidos na mesma tabela.

![image](https://user-images.githubusercontent.com/91134093/195223437-0eea453f-b549-41ef-a5a2-6be5357fbcf2.png)
