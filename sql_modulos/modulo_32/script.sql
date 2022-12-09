--Criar tabela:
CREATE EXTERNAL TABLE IF NOT EXISTS default.heartattack (
`age` int,
`sex` int,
`cp` int,
`trtbps` int,
`chol` int,
`fbs` int,
`restecg` int,
`thalachh` int,
`exng` int,
`oldpeak` double,
`slp` int,
`caa` int,
`thall` int,
`output` int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
'serialization.format' = ',',
'field.delim' = ','
) LOCATION 's3://heart-attack-sergio-ebac/'
TBLPROPERTIES ('has_encrypted_data'='false');


--query 1:
select * from heartattack limit 10;

--query 2:
SELECT COUNT(age) AS QUANTIDADE_LINHAS
FROM heartattack

--query 3:
SELECT COUNT(age) AS QUANTIDADE,
        CASE
            WHEN output =1 THEN ' more chance of heart attack'
            ELSE 'less chance of heart attack'
        END AS output
FROM heartattack
GROUP BY output;


--query 4:
SELECT MAX(age), 
       MIN(age), 
       AVG(age), 
       output
FROM heartattack
GROUP BY output;


--query 5:
SELECT MAX(age), MIN(age), AVG(age), output ,sex
FROM heartattack
GROUP BY output, sex;


--query 6:
SELECT COUNT(output), 
	  output, 
	  sex
FROM heartattack
GROUP BY output, sex
having COUNT(output) > 25;
