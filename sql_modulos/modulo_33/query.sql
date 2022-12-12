--criando tabelas cliente:

CREATE EXTERNAL TABLE IF NOT EXISTS default.cliente (
`id_cliente` int,
`nome` string,
`valor_compra` double,
`loja_cadastro` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
'serialization.format' = ',',
'field.delim' = ','
) LOCATION 's3://modulo6-sergio-ebac/cliente/'
TBLPROPERTIES ('has_encrypted_data'='false');



--criando tabela transações:
CREATE EXTERNAL TABLE IF NOT EXISTS default.transacoes (
`id_cliente` int,
`id_transacao` int,
`valor_compra` double,
`id_loja` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
'serialization.format' = ',',
'field.delim' = ','
) LOCATION 's3://modulo6-sergioa-ebac/transacoes/'
TBLPROPERTIES ('has_encrypted_data'='false');


--query 1:
SELECT id_cliente FROM transacoes
UNION
SELECT id_cliente FROM cliente;


--query 2:
SELECT transacoes.id_cliente, cliente.nome
FROM transacoes
INNER JOIN cliente
ON transacoes.id_cliente = cliente.id_cliente;

--query 3:
SELECT *
FROM cliente
CROSS JOIN transacoes;

--query 4:
SELECT *
FROM transacoes
LEFT JOIN cliente
ON cliente.id_cliente = transacoes.id_cliente;

--query 5:
SELECT *
FROM transacoes
RIGHT JOIN cliente
ON cliente.id_cliente = transacoes.id_cliente;


