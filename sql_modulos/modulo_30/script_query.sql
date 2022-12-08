CREATE EXTERNAL TABLE transacoes(
id_cliente BIGINT,
id_transacao BIGINT,
valor FLOAT,
id_loja STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('separatorChar' = ',', 'quoteChar' = '"', 'escapeChar' = '\\')
STORED AS TEXTFILE
LOCATION 's3://bucket-transacoes-my/'


--query 1:
SELECT * from transacoes


--query 2:
SELECT id_cliente , valor, id_loja AS nome_loja FROM transacoes;

--query 3:
SELECT DISTINCT id_loja AS nome_loja FROM transacoes;


--query 4:
SELECT id_cliente, valor FROM transacoes ORDER BY valor DESC LIMIT 2;
