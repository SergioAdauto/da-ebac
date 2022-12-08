--query 1:
select * 
from transacoes
where valor > 30 and id_loja = 'magalu';

--query 2:
select * 
from transacoes
where valor > 30 or id_loja = 'magalu';

--query 3:
select * 
from transacoes
where id_loja in ('magalu','subway') and valor > 10;

--query 4:
select * 
from transacoes
where valor between 60.0 and 1000.0;

--query 5:
select * 
from transacoes
where id_loja like 'mag%';

--query 6:
select * 
from transacoes
where id_loja like '%sh%';


--query 7:
select id_cliente, id_loja, valor,
case
    when valor > 1000 then 'Compra com alto valor'
    when valor < 1000 then 'Compra com baixo valor'
end
as classeValor,
case
    when id_loja in ('giraffas','subway') then 'alimentacao'
    when id_loja in ('magalu','extra') then 'variedade'
    when id_loja in ('postoshell','seveneleven') then '24horas'
    else 'outros'
end
as tipo_compra
from transacoes;