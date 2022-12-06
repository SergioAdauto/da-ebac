CREATE EXTERNAL TABLE clientes(
 id BIGINT,
 idade BIGINT,
 sexo STRING,
 dependentes BIGINT,
 escolaridade STRING,
 tipo_cartao STRING,
 limite_credito DOUBLE,
 valor_transacoes_12m DOUBLE,
 qtd_transacoes_12m BIGINT)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('separatorChar' = ',', 'quoteChar' = '"',
'escapeChar' = '\\')
STORED AS TEXTFILE
LOCATION 's3://ebac-<nome_do_bucket>-modulo1/'
