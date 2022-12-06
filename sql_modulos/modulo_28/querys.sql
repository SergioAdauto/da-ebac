/*query 1*/
select * from clientes;

/*query 2*/
select id, idade, limite_credito 
from clientes 
where sexo = 'M'
order by idade desc;

/*query 3*/
select sexo, avg(idade) as "media_idade_por_sexo"
from clientes
group by sexo;