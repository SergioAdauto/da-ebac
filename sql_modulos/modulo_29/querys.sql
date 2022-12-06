--query 1:
SELECT id, idade, sexo, dependentes FROM clientes;


--query 2:
SELECT id, 
	  valor_transacoes_12m 
FROM clientes 
WHERE escolaridade = 'mestrado' and sexo = 'F';


--query 3:
SELECT sexo, 
	  AVG(idade) AS "media_idade_por_sexo" 
FROM clientes 
GROUP BY sexo;


--query 4:
SELECT * FROM clientes;

--query 5:
--primeiro particionar a tabela por sexo:
CREATE EXTERNAL TABLE clientes_part(
id BIGINT,
idade BIGINT,
dependentes BIGINT,
escolaridade STRING,
tipo_cartao STRING,
limite_credito DOUBLE,
valor_transacoes_12m DOUBLE,
qtd_transacoes_12m BIGINT)
PARTITIONED BY (sexo string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('separatorChar' = ',', 'quoteChar' = '"', 'escapeChar' = '\\')
STORED AS TEXTFILE
LOCATION 's3://ebac-bucket-partitioned/'
--carregar as partições:
MSCK REPAIR TABLE clientes_part;
--verificando o resultados:
select * from clientes_part where sexo = 'F';


--query 6:
SELECT id, 
	idade, 
	limite_credito 
FROM clientes_part 
WHERE sexo = 'M' 
ORDER BY limite_credito DESC;


--query 7:
--adicionando a coluna estado:
ALTER TABLE clientes ADD COLUMNS (estado string)
--visualizando o resultado:
SELECT * from clientes;


--Excluindo a coluna clientes:
DROP TABLE clientes

