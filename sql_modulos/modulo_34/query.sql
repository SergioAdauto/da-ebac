--criando tabela cliente:
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
) LOCATION 's3://modulo7-sergio-ebac/cliente/'
TBLPROPERTIES ('has_encrypted_data'='false');


--criando tabela transações:
CREATE EXTERNAL TABLE IF NOT EXISTS default.transacoes (
`id_cliente` int,
`id_transacao` bigint,
`valor_compra` double,
`id_loja` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
'serialization.format' = ',',
'field.delim' = ','
) LOCATION 's3://modulo7-sergio-ebac/transacoes/'
TBLPROPERTIES ('has_encrypted_data'='false');

-- validando as criações:
Query successful.

--query 1:
SELECT id_loja, id_cliente, id_transacao from transacoes
WHERE id_loja IN
(SELECT cliente.loja_cadastro from cliente where cliente.valor_compra > 160 )



--Criando a tabela particionada das transações:
CREATE EXTERNAL TABLE transacoes_part(
id_cliente BIGINT,
id_transacoes BIGINT,
valor DOUBLE)
PARTITIONED BY (id_loja string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
'serialization.format' = ',',
'field.delim' = ','
)
LOCATION 's3://transacoes-partition-sergio/'

--carregando as partições:
MSCK REPAIR TABLE transacoes_part;


--query 2:
SELECT * FROM transacoes_part where id_loja = 'magalu'


--query 3 (criando um temp view):
CREATE VIEW transacoesv100 AS
SELECT id_cliente , valor AS valor_compra, id_loja AS nome_loja FROM transacoes where valor > 100

select * from transacoesv100;


--query 4:
CREATE VIEW clientevalor AS
SELECT id_cliente, valor AS valor_compra FROM transacoes ORDER BY valor_compra DESC LIMIT 2;

select * from clientevalor;

--Analisando as descrições do temp view:
describe clientevalor;

--Observando as colunas do temp view:
show columns in clientevalor;

--Observando todas as temp view:
show views;

--Apagando a temp view Clientevalor:
drop view clientevalor;

