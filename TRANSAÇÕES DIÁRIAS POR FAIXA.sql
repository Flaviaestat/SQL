SELECT dataoperacaocheckout, cl_valor, 
count(distinct(numerocheckout||sequencialoperacaocheckout)) as transacoes,
SUM(VALORNOTAVENDABRUTO) AS VENDA_BRUTA
from(
select
numerocheckout,
sequencialoperacaocheckout,
numerocheckout||sequencialoperacaocheckout as chave,
dataoperacaocheckout,
to_char(dataoperacaocheckout, 'yyyy-mm') as ano_mes,
siglaaeroporto,
tipoloja,
codigoloja,
VALORNOTAVENDABRUTO,
decode(codigopaispax,'1','BRAZIL','BRA','BRAZIL','OTHERS') nacionalidade,
case
	when (nvl(valornotavendabruto,0))<50 then '0 a 49    '
	when (nvl(valornotavendabruto,0))>=50  and (nvl(valornotavendabruto,0))<100   then '50 a 99   '
	when (nvl(valornotavendabruto,0))>=100 and (nvl(valornotavendabruto,0))<150  then '100 a 149 '
	when (nvl(valornotavendabruto,0))>=150 and (nvl(valornotavendabruto,0))<200  then '150 a 199 '
	when (nvl(valornotavendabruto,0))>=200 and (nvl(valornotavendabruto,0))<250  then '200 a 249 '
	when (nvl(valornotavendabruto,0))>=250 and (nvl(valornotavendabruto,0))<300  then '250 a 299 '
	when (nvl(valornotavendabruto,0))>=300 and (nvl(valornotavendabruto,0))<350  then '300 a 349 '
	when (nvl(valornotavendabruto,0))>=350 and (nvl(valornotavendabruto,0))<400  then '350 a 399 '
	when (nvl(valornotavendabruto,0))>=400 and (nvl(valornotavendabruto,0))<450  then '400 a 449 '	
	when (nvl(valornotavendabruto,0))>=450 and (nvl(valornotavendabruto,0))<500  then '450 a 499 '	
	when (nvl(valornotavendabruto,0))>=500 then '>=500 '	
 end as cl_valor,
((nvl(valornotavendabruto,0))
-(nvl(valortotaldescontoestado,0))-(nvl(valortotaldescontotripulante,0))
-(nvl(valortotaldescontopreorder,0))) as vendaliq
from vndat004
where codigonegocio = '200' and
dataoperacaocheckout between to_date('01012008','ddmmyyyy') and to_date('28022008','ddmmyyyy')
and nvl(indicadorestorno,'N')  = 'N')
group by dataoperacaocheckout, cl_valor
