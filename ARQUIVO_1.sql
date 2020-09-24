/*00 - TRAZER VENDA BRUTA E LÍQUIDA POR LOJA E MÊS*/


/*01 - JOIN PARA TRAZER GRUPO, SUBGRUPO*/

/* A - GROUP BY CATEGORIA*/
select ANO_MES, CODIGOCATEGORIADUFRY, 
SUM(NVL(precounitariovenda,0)* NVL(quantidadevendida,0)) as vendas,
COUNT(DISTINCT(NUMEROCHECKOUT||SEQUENCIALOPERACAOCHECKOUT||NUMERONOTAVENDA)) AS TRANS,
SUM(NVL(quantidadevendida,0)) AS qtd
from 
(SELECT 
a.SIGLAAEROPORTO,  
a.CODIGOLOJA,
a.TIPOLOJA,
a.DATAOPERACAOCHECKOUT, 
to_char(a.DATAOPERACAOCHECKOUT, 'YYYY-MM') AS ANO_MES,
a.INDICADORESTORNO, 
a.NUMEROCHECKOUT, 
a.SEQUENCIALOPERACAOCHECKOUT,
a.NUMERONOTAVENDA,
a.CODIGOBRASIF,
a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, b.CODIGOCATEGORIADUFRY,
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
from itvet001 a, itemt027 b
where  a.dataoperacaocheckout between '01-JAN-2007' and '31-DEZ-2007'
and a.codigonegocio = '200'
and (b.codigobrasif(+)=a.codigobrasif and a.codigonegocio = b.codigonegocio(+))
and nvl(a.indicadorestorno, 'N')='N')
group by ANO_MES, CODIGOCATEGORIADUFRY

/*arome*/
select ano_mes, codigocategoriadufry, 
sum(NVL(precounitariovenda,0)* NVL(quantidadevendida,0)) as vendas
from 
(SELECT 
a.SIGLAAEROPORTO,  
a.CODIGOLOJA,
a.TIPOLOJA,
a.DATAOPERACAOCHECKOUT, 
to_char(a.DATAOPERACAOCHECKOUT,'yyyy-mm') as ano_mes, 
a.INDICADORESTORNO, 
a.NUMEROCHECKOUT, 
a.SEQUENCIALOPERACAOCHECKOUT, 
a.CODIGOBRASIF,
a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.codigocategoriadufry, b.CODIGOSUBGRUPO, 
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
from itvet001 a, itemt027 b
where  a.dataoperacaocheckout between '01-jan-2007' and '30-abr-2007'
and a.codigonegocio = '500'
and (b.CODIGOGRUPO||b.CODIGOSUBGRUPO) not in ('040l','040L','0512')
and (b.codigobrasif(+)=a.codigobrasif and a.codigonegocio = b.codigonegocio(+))
and nvl(a.indicadorestorno, 'N')='N')
group by ano_mes, codigocategoriadufry




/* A - GROUP BY AEROPORTO - DUTY FREE*/
select SIGLAAEROPORTO, 
(CODIGOGRUPO||CODIGOSUBGRUPO), 
dataoperacaocheckout, 
sum(NVL(precounitariovenda,0)* NVL(quantidadevendida,0)) as vendas,
sum(NVL(quantidadevendida,0)) as quantidadevendida
from 
(SELECT 
a.SIGLAAEROPORTO,  
a.CODIGOLOJA,
a.TIPOLOJA,
a.DATAOPERACAOCHECKOUT, 
a.INDICADORESTORNO, 
a.NUMEROCHECKOUT, 
a.SEQUENCIALOPERACAOCHECKOUT, 
a.CODIGOBRASIF,
a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, 
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
from itvet001 a, itemt027 b
where  a.dataoperacaocheckout between '01-AGO-2007' and '12-AGO-2007'
and a.codigonegocio = '200'
AND a.siglaaeroporto in ('AISP', 'AIRJ', 'AISA', 'AIPA', 'AIRE', 'DIPS')
and (b.codigobrasif(+)=a.codigobrasif and a.codigonegocio = b.codigonegocio(+))
and (b.codigogrupo) in ('04','05')
and nvl(a.indicadorestorno, 'N')='N')
group by SIGLAAEROPORTO, codigogrupo, codigosubgrupo, dataoperacaocheckout


/* A - GROUP BY LOJA - DUTY PAID - TRAZENDO O NOME DA LOJA TAMBÉM*/
SELECT 
A.CODIGOLOJA,
MAX(B.NOMELOJA),
SUM(NVL(A.VALORNOTAVENDABRUTO,0)) AS VALOR_TOTAL,
COUNT(*) AS TRANSACOES,
COUNT(DISTINCT(A.TIPODOCUMENTOPAX||'|'||A.NUMERODOCUMENTOPAX)) AS NUM_CLIENTES
FROM VNDAV004 A, LOJAT001 B
WHERE NVL(A.INDICADORESTORNO, 'N')='N'
AND A.CODIGOLOJA=B.CODIGOLOJA(+)
AND A.CODIGONEGOCIO IN ('400')
AND A.DATAOPERACAOCHECKOUT BETWEEN '01-MAR-2007' AND '31-MAR-2007'
GROUP BY A.CODIGOLOJA




/*02 - CONTAR TRANSAÇÕES E CLIENTES*/

/* A - DA BASE AGG TRANS*/
CREATE TABLE YYYY AS SELECT 
DATAOPERACAOCHECKOUT, 
CODIGOLOJA, 
SUM(NVL(VALORNOTAVENDABRUTO),0)) AS VALOR_TOTAL,
COUNT(*) AS TRANSACOES,
COUNT(DISTINCT(TIPODOCUMENTOPAX||'|'||NUMERODOCUMENTOPAX)) AS NUM_CLIENTES
FROM VNDAV004
WHERE NVL(INDICADORESTORNO, 'N')='N'
AND DATAOPERACAOCHECKOUT BETWEEN '01-JUL-2006' AND '31-JUL-2007'
GROUP BY DATAOPERACAOCHECKOUT, CODIGOLOJA


/* B - DA BASE AGG ITENS*/
CREATE TABLE XXX AS SELECT 
DATAOPERACAOCHECKOUT, 
CODIGOLOJA, 
SUM(NVL(PRECOUNITARIOVENDA),0)* NVL(QUANTIDADEVENDIDA),0)) AS VALORVENDA_BRUTA,
COUNT(DISTINCT(NUMEROCHECKOUT||'|'||SEQUENCIALOPERACAOCHECKOUT||'|'||NUMERONOTAVENDA)) AS TRANSACOES,
COUNT(DISTINCT(TIPODOCUMENTOPAX||'|'||NUMERODOCUMENTOPAX)) AS NUM_CLIENTES
FROM itvet001
WHERE NVL(INDICADORESTORNO, 'N')='N'
AND DATAOPERACAOCHECKOUT BETWEEN '01-JUL-2006' AND '31-JUL-2007'
GROUP BY DATAOPERACAOCHECKOUT, CODIGOLOJA


/* C - DA BASE AGG ITENS COM JOIN DE SUBGRUPO*/
CREATE TABLE XXX AS SELECT 
DATAOPERACAOCHECKOUT, 
CODIGOLOJA, 
SUM(NVL(PRECOUNITARIOVENDA),0)* NVL(QUANTIDADEVENDIDA),0)) AS VALOR_TOTAL,
COUNT(DISTINCT(NUMEROCHECKOUT||'|'||SEQUENCIALOPERACAOCHECKOUT||'|'||NUMERONOTAVENDA)) AS TRANSACOES,
COUNT(DISTINCT(TIPODOCUMENTOPAX||'|'||NUMERODOCUMENTOPAX)) AS NUM_CLIENTES
FROM 
(SELECT 
a.SIGLAAEROPORTO,  
a.CODIGOLOJA,
a.TIPOLOJA,
a.DATAOPERACAOCHECKOUT, 
a.INDICADORESTORNO, 
a.NUMEROCHECKOUT, 
a.SEQUENCIALOPERACAOCHECKOUT, 
a.CODIGOBRASIF,
a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, 
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
from itvet001 a, ITEMT027 b
where  a.DATAOPERACAOCHECKOUT between '01-AGO-2007' and '12-AGO-2007'
and a.CODIGONEGOCIO = '200'
AND a.SIGLAAEROPORTO in ('AISP', 'AIRJ', 'AISA', 'AIPA', 'AIRE', 'DIPS')
and (b.CODIGOBRASIF(+)=a.CODIGOBRASIF and b.CODIGONEGOCIO=a.CODIGONEGOCIO)
and (b.CODIGOGRUPO) in ('04','05')
and nvl(a.INDICADORESTORNO, 'N')='N')
GROUP BY DATAOPERACAOCHECKOUT, CODIGOLOJA

/*VENDA DIÁRIA*/

/*DUTY FREE*/
SELECT ano_mes, CODIGOLOJA,
sum(nvl(valornotavendabruto,0)) AS GROSS_AMOUNT,
sum(nvl(valornotavendabruto,0))- sum(nvl(valortotaldescontoestado,0))-sum(nvl(valortotaldescontoetiqueta,0))
- sum(nvl(valortotaldescontopreorder,0))- sum(nvl(valortotaldescontotripulante,0)) - sum(nvl(VALORDESCONTONOTA,0)) AS NET_AMOUNT
FROM 
(SELECT CODIGOLOJA, VALORNOTAVENDABRUTO, valortotaldescontoestado, valortotaldescontoetiqueta,
valortotaldescontopreorder, valortotaldescontotripulante, VALORDESCONTONOTA,
TO_CHAR(DATAOPERACAOCHECKOUT,'YYYY-MM') as ano_mes
FROM VNDAV004
WHERE DATAOPERACAOCHECKOUT BETWEEN '01-JAN-2005' AND '31-DEZ-2007'
AND NVL(INDICADORESTORNO,'N')='N'
AND CODIGONEGOCIO='200')
GROUP BY ANO_MES,CODIGOLOJA


/*DUTY PAID*/
SELECT ano_mes, CODIGOLOJA,
sum(nvl(valornotavendabruto,0)) AS GROSS_AMOUNT_R$,
sum(nvl(valornotavendabruto,0))- sum(nvl(valortotaldescontoestado,0))-sum(nvl(valortotaldescontoetiqueta,0))
- sum(nvl(valortotaldescontopreorder,0))- sum(nvl(valortotaldescontotripulante,0)) - sum(nvl(VALORDESCONTONOTA,0)) AS NET_AMOUNT_R$,
sum(nvl(valornotavendabruto_US$,0)) AS GROSS_AMOUNT_US$,
sum(nvl(valornotavendabruto_US$,0))- sum(nvl(valortotaldescontoest_US$,0))-sum(nvl(valortotaldescontoetiq_US$,0))
- sum(nvl(valortotaldescontopo_US$,0))- sum(nvl(valortotaldescontotrip_US$,0)) - sum(nvl(VALORDESCONTONOTA_US$,0)) AS NET_AMOUNT_US$
FROM 
(SELECT A.CODIGOLOJA, 
A.VALORNOTAVENDABRUTO, 
A.valortotaldescontoestado, 
A.valortotaldescontoetiqueta,
A.valortotaldescontopreorder, 
A.valortotaldescontotripulante, 
A.VALORDESCONTONOTA,
(A.VALORNOTAVENDABRUTO/B.VALORIND) AS VALORNOTAVENDABRUTO_US$, 
(A.valortotaldescontoestado/B.VALORIND) AS valortotaldescontoest_US$, 
(A.valortotaldescontoetiqueta/B.VALORIND) AS valortotaldescontoetiq_US$, 
(A.valortotaldescontopreorder/B.VALORIND) AS valortotaldescontopo_US$, 
(A.valortotaldescontotripulante/B.VALORIND) AS valortotaldescontotrip_US$, 
(A.VALORDESCONTONOTA/B.VALORIND) AS VALORDESCONTONOTA_US$,
CASE
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Jan' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '01')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Fev' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '02')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Mar' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '03')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Abr' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '04')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Mai' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '05')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Jun' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '06')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Jul' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '07')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Ago' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '08')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Set' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '09')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Out' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '10')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Nov' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '11')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Dez' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '12')
end as ano_mes,
B.VALORIND AS COT_DOLAR
FROM VNDAV004 A, VLINDREAL B
WHERE A.DATAOPERACAOCHECKOUT BETWEEN '01-JAN-2005' AND '31-DEZ-2007'
AND A.DATAOPERACAOCHECKOUT =B.DATAINDICE
AND B.INDICE='003'
AND NVL(A.INDICADORESTORNO,'N')='N'
AND A.CODIGONEGOCIO='400')
GROUP BY ANO_MES,CODIGOLOJA


/*EMAC*/
SELECT ano_mes, CODIGOLOJA,
sum(nvl(valornotavendabruto,0)) AS GROSS_AMOUNT_R$,
sum(nvl(valornotavendabruto,0))- sum(nvl(valortotaldescontoestado,0))-sum(nvl(valortotaldescontoetiqueta,0))
- sum(nvl(valortotaldescontopreorder,0))- sum(nvl(valortotaldescontotripulante,0)) - sum(nvl(VALORDESCONTONOTA,0)) AS NET_AMOUNT_R$,
sum(nvl(valornotavendabruto_US$,0)) AS GROSS_AMOUNT_US$,
sum(nvl(valornotavendabruto_US$,0))- sum(nvl(valortotaldescontoest_US$,0))-sum(nvl(valortotaldescontoetiq_US$,0))
- sum(nvl(valortotaldescontopo_US$,0))- sum(nvl(valortotaldescontotrip_US$,0)) - sum(nvl(VALORDESCONTONOTA_US$,0)) AS NET_AMOUNT_US$
FROM 
(SELECT A.CODIGOLOJA, 
A.VALORNOTAVENDABRUTO, 
A.valortotaldescontoestado, 
A.valortotaldescontoetiqueta,
A.valortotaldescontopreorder, 
A.valortotaldescontotripulante, 
A.VALORDESCONTONOTA,
(A.VALORNOTAVENDABRUTO/B.VALORIND) AS VALORNOTAVENDABRUTO_US$, 
(A.valortotaldescontoestado/B.VALORIND) AS valortotaldescontoest_US$, 
(A.valortotaldescontoetiqueta/B.VALORIND) AS valortotaldescontoetiq_US$, 
(A.valortotaldescontopreorder/B.VALORIND) AS valortotaldescontopo_US$, 
(A.valortotaldescontotripulante/B.VALORIND) AS valortotaldescontotrip_US$, 
(A.VALORDESCONTONOTA/B.VALORIND) AS VALORDESCONTONOTA_US$,
CASE
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Jan' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '01')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Fev' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '02')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Mar' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '03')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Abr' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '04')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Mai' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '05')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Jun' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '06')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Jul' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '07')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Ago' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '08')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Set' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '09')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Out' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '10')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Nov' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '11')
WHEN (SUBSTR(A.DATAOPERACAOCHECKOUT, 4, 3)) ='Dez' then concat((SUBSTR(A.DATAOPERACAOCHECKOUT, 8, 4)), '12')
end as ano_mes,
B.VALORIND AS COT_DOLAR
FROM VNDAV004 A, VLINDREAL B
WHERE A.DATAOPERACAOCHECKOUT BETWEEN '01-JAN-2005' AND '31-DEZ-2007'
AND A.DATAOPERACAOCHECKOUT =B.DATAINDICE
AND B.INDICE='003'
AND NVL(A.INDICADORESTORNO,'N')='N'
AND A.CODIGONEGOCIO='500')
GROUP BY ANO_MES,CODIGOLOJA





/* D - IDENTIFICADOS E NÃO IDENTIFICADOS DA BASE DA DUFRY SHOPPING: 
   Y:\ÁREA DE TRANSFERÊNCIA\Flávia Costa\15 Vendas BS*/
   

/*03 - BASE DE PAGAMENTO ARRUMADA - COM DUPLI DE FORMA DE PAGAMENTO*/

/*A*/
CREATE TABLE WWWWWW AS SELECT 
DATAOPERACAOCHECKOUT AS DATAVENDA, 
(NUMEROCHECKOUT||'|'||SEQUENCIALOPERACAOCHECKOUT||'|'||NUMERONOTAVENDA) AS NUM_NOTA,
(TIPODOCUMENTOPAX||'|'||NUMERODOCUMENTOPAX) AS DOC_CLIENTE,
CODIGOLOJA,
TIPOLOJA,
VALORPAGAMENTOUS$,
VALORTROCOMOEDABASE,
NVL(VALORPAGAMENTOUS$, 0) - NVL(VALORTROCOMOEDABASE, 0) AS VENDA_LÍQUIDA,
CASE
	WHEN codigomoeda = '1' then 'DOLAR'
	WHEN codigomoeda = '13' then 'REAL'
	WHEN codigomoeda is null then '   '
	   		ELSE 'OUTRAS'
END AS MOEDA_PGTO_CASH,
CASE
	WHEN codigomoedacartao = '1' then 'DOLAR'
	WHEN codigomoedacartao = '13' then 'REAL'
	WHEN codigomoedacartao IS NULL then '   '
	   		ELSE 'OUTRAS'
END AS MOEDA_PGTO_CARTAO,
NUMEROPARCELASCARTAO,
CASE
	WHEN TIPOPARCELAMENTOCARTAO = 'AV' then 'A VISTA'
	WHEN TIPOPARCELAMENTOCARTAO = 'PSJ' then 'PARCELADO SEM JUROS'
	WHEN TIPOPARCELAMENTOCARTAO = 'PCJ' then 'PARCELADO COM JUROS'
	   		ELSE 'OUTROS'
               END AS PARCELAMENTOCARTAO
FROM PGTOV001
where nvl(indicadorestorno,'N')  = 'N'
and codigonegocio = '200'
and dataoperacaocheckout between to_date('18072007','ddmmyyyy') and to_date('18072007','ddmmyyyy')


/*B - BASE DE PAGAMENTO ARRUMADA - COM DUPLI DE FORMA DE PAGAMENTO - COM FAIXAS DE VALOR*/
CREATE TABLE UUUUUUU AS SELECT 
DATAOPERACAOCHECKOUT AS DATAVENDA, 
(NUMEROCHECKOUT||'|'||SEQUENCIALOPERACAOCHECKOUT||'|'||NUMERONOTAVENDA) AS NUM_NOTA,
(TIPODOCUMENTOPAX||'|'||NUMERODOCUMENTOPAX) AS DOC_CLIENTE,
CODIGOLOJA,
TIPOLOJA,
VALORPAGAMENTOUS$,
VALORTROCOMOEDABASE,
NVL(VALORPAGAMENTOUS$, 0) - NVL(VALORTROCOMOEDABASE, 0) AS VENDA_LÍQUIDA,
case
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<50 then '0 a 49    '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=50  and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<100   then '50 a 99   '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=100 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<150  then '100 a 149 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=150 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<200  then '150 a 199 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=200 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<250  then '200 a 249 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=250 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<300  then '250 a 299 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=300 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<350  then '300 a 349 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=350 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<400  then '350 a 399 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=400 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<450  then '400 a 449 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=450 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<500  then '450 a 499 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=500 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<600  then '500 a 599 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=600 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<700  then '600 a 699 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=700 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<800  then '700 a 799 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=800 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<900  then '800 a 899 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=900 and ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))<1000  then '900 a 999 '
	when ((nvl(valorpagamentous$,0))-(nvl(valortrocomoedabase,0)))>=1000 then '>= a 1000 '
end
as FX_VENDA_LIQUIDA,
CASE
	WHEN codigomoeda = '1' then 'DOLAR'
	WHEN codigomoeda = '13' then 'REAL'
	WHEN codigomoeda is null then '   '
	   		ELSE 'OUTRAS'
END AS MOEDA_PGTO_CASH,
CASE
	WHEN codigomoedacartao = '1' then 'DOLAR'
	WHEN codigomoedacartao = '13' then 'REAL'
	WHEN codigomoedacartao IS NULL then '   '
	   		ELSE 'OUTRAS'
END AS MOEDA_PGTO_CARTAO,
NUMEROPARCELASCARTAO,
CASE
	WHEN TIPOPARCELAMENTOCARTAO = 'AV' then 'A VISTA'
	WHEN TIPOPARCELAMENTOCARTAO = 'PSJ' then 'PARCELADO SEM JUROS'
	WHEN TIPOPARCELAMENTOCARTAO = 'PCJ' then 'PARCELADO COM JUROS'
	   		ELSE 'OUTROS'
               END AS PARCELAMENTOCARTAO
FROM PGTOV001
where nvl(indicadorestorno,'N')  = 'N'
and codigonegocio = '200'
and dataoperacaocheckout between to_date('18072007','ddmmyyyy') and to_date('18072007','ddmmyyyy')

