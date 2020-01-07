/*****************************************************************************************************/
/*BASE COM MARCAÇÕES NECESSÁRIAS PARA ESCOLHER OS PROPENSOS - ESSA BASE POSSUI TODOS OS CLIENTES !!!*/
/*****************************************************************************************************/

drop table FL_REL_CLI_Agosto;
drop table FL_MAILING_PROP_ATIVOS;
drop table FL_MAILING_PROP_INATIVOS;
drop table FL_MAILING_PROP_COMPRADORES1;
drop table FL_MAILING_PROP_COMPRADORES2;
drop table FL_MAILING_PROP_COMPRADORES3


/**** VIGÊNCIA: MÊS AGOSTO DE 2011 *****/
create table FL_REL_CLI_Agosto as select 
	TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX, 
	MAX(DATAOPERACAOCHECKOUT) as RECENCIA, 
	SUM(NVL(PRECOUNITARIOVENDA,0)* NVL(QUANTIDADEVENDIDA,0)) as VENDAS,
	SUM(NVL(QUANTIDADEVENDIDA,0)) as QTD,
	SUM(FREQ_2ANOS_DF) as FREQ_2ANOS_DF,
	SUM(VENDAS_2ANOS_DF) as VENDAS_2ANOS_DF,
	MAX(MA12) as MA12,
	MAX(MA11) as MA11,
	MAX(MA10) as MA10,
	MAX(MA9) as MA9,
	MAX(MA8) as MA8,
	MAX(MA7) as MA7,
	MAX(MA6) as MA6,
	MAX(MA5) as MA5,
	MAX(MA4) as MA4,
	MAX(MA3) as MA3,
	MAX(MA2) as MA2,
	MAX(MA1) as MA1
from 
	(select 
		a.DATAOPERACAOCHECKOUT,
		a.CODIGOLOJA,
		a.TIPOLOJA,
	case
		when a.DATAOPERACAOCHECKOUT between to_date('01/08/2008', 'dd/mm/yyyy') and to_date('31/07/2010', 'dd/mm/yyyy') then '1'
		end as FREQ_2ANOS_DF,
	case
		when a.DATAOPERACAOCHECKOUT between to_date('01/08/2008', 'dd/mm/yyyy') and to_date('31/07/2010', 'dd/mm/yyyy') then (a.PRECOUNITARIOVENDA*a.QUANTIDADEVENDIDA)
		end as VENDAS_2ANOS_DF, /*REPETE DATA DE CIMA*/
	/*   "ANDAR" COM AS DATAS ABAIXO   */
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2010-08' then '1'
		end as MA12,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2010-09' then '1'
		end as MA11,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2010-10' then '1'
		end as MA10,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2010-11' then '1'
		end as MA9,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2010-12' then '1'
		end as MA8,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2011-01' then '1'
		end as MA7,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2011-02' then '1'
		end as MA6,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2011-03' then '1'
		end as MA5,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2011-04' then '1'
		end as MA4,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2011-05' then '1'
		end as MA3,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2011-06' then '1'
		end as MA2,
	case
		when TO_CHAR(a.DATAOPERACAOCHECKOUT, 'YYYY-MM')='2011-07' then '1'
		end as MA1,
	a.NUMEROCHECKOUT, a.TIPODOCUMENTOPAX, a.NUMERODOCUMENTOPAX,
	a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA,
	b.CODIGOGRUPO, b.CODIGOSUBGRUPO, b.CODIGOCATEGORIADUFRY,
	b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
	from itvet001 a, itemt027 b
	where  a.dataoperacaocheckout between to_date('01/08/2008', 'dd/mm/yyyy') and to_date('31/07/2011', 'dd/mm/yyyy') /*mês corrente Agosto*/
	and a.codigonegocio = '200'
	and (b.codigobrasif(+)=a.codigobrasif
	and a.codigonegocio = b.codigonegocio(+))
	and nvl(a.indicadorestorno, 'N')='N')
group by TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX


select * from FL_REL_CLI_Agosto

/**************************************************/
/*SELEÇÃO CLIENTES PROPENSOS A COMPRAR EM AGOSTO */
/**************************************************/

/*** COMPRADORES DO ÚLTIMO ANO ****/
create table FL_MAILING_PROP_ATIVOS as select TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX from FL_REL_CLI_Agosto
where (
(MA1=1 and MA2=1 and MA3=1) or
(MA1=1 and MA2=1 and MA3=0) or
(MA1=0 and MA2=1 and MA3=1) or
(MA1=1 and MA2=0 and MA3=1) or
(MA1=0 and MA2=0 and MA3=0 and (MA4=1 or MA5=1 or MA6=1 or MA7=1 or MA8=1 or MA9=1 or MA10=1 or MA11=1 ) and MA12=1 ) or
(MA12=1 and MA6=1) or
(MA12=1 and MA7=1) or
(MA12=1 and MA5=1) or
(MA12=1 and MA4=1) or
(MA12=1 and MA3=1) or
(MA11=1 and MA7=1) or
(MA11=1 and MA6=1) or
(MA1 + MA2 +  MA3 +  MA4)>=3 )

/*** INATIVOS NO ÚLTIMO ANO ****/
create table FL_MAILING_PROP_INATIVOS as select TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX from FL_REL_CLI_MES
where (NVL(MA1,0) + NVL(MA2,0) + NVL(MA3,0)  + NVL(MA4,0) + NVL(MA5,0) + NVL(MA6,0) + NVL(MA7,0) + NVL(MA8,0) + NVL(MA9,0) + NVL(MA10,0) + NVL(MA11,0) + NVL(MA12,0))=0 and 
((VENDAS_2ANOS_DF >= 304.6500 and VENDAS_2ANOS_DF < 507.2500 and FREQ_2ANOS_DF =2) or
(VENDAS_2ANOS_DF >= 198.9500  and  VENDAS_2ANOS_DF < 222.3500  and FREQ_2ANOS_DF = 3) or
(VENDAS_2ANOS_DF >= 402.7000 and VENDAS_2ANOS_DF < 472.3000 and FREQ_2ANOS_DF =3) or 
(VENDAS_2ANOS_DF >= 519.1000 and VENDAS_2ANOS_DF < 1463.2500  and FREQ_2ANOS_DF =2) or
(VENDAS_2ANOS_DF >= 507.2500 and VENDAS_2ANOS_DF < 623.0500 and FREQ_2ANOS_DF=4 ) or 
(VENDAS_2ANOS_DF >= 666.6000 and VENDAS_2ANOS_DF < 1113.3750 and (FREQ_2ANOS_DF =3 or FREQ_2ANOS_DF=4)) or 
(VENDAS_2ANOS_DF >= 1397.5000 and VENDAS_2ANOS_DF < 1531.9500 and FREQ_2ANOS_DF=3) or 
(VENDAS_2ANOS_DF >= 1113.5000 and VENDAS_2ANOS_DF < 1386.0000 and FREQ_2ANOS_DF = 4) or
(VENDAS_2ANOS_DF >= 1603.1499 and FREQ_2ANOS_DF =3) or 
(VENDAS_2ANOS_DF >= 1603.1499 and VENDAS_2ANOS_DF < 2703.7002 and FREQ_2ANOS_DF =4))



select * from FL_REL_CLI_Agosto
select * from FL_MAILING_PROP_ATIVOS
select * from FL_MAILING_PROP_INATIVOS
select * from FL_MAILING_PROP_COMPRADORES1
select * from FL_MAILING_PROP_COMPRADORES2
select * from FL_MAILING_PROP_COMPRADORES3

/* VENDA REAL DE AGOSTO */

create table FL_MAILING_PROP_COMPRADORES1 as select TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX
from 
(select 
a.SIGLAAEROPORTO,  
a.CODIGOLOJA,
a.TIPOLOJA,
a.DATAOPERACAOCHECKOUT, 
to_char(a.DATAOPERACAOCHECKOUT, 'YYYY-MM') as ANO_MES,
a.INDICADORESTORNO, 
a.TIPODOCUMENTOPAX, 
a.NUMERODOCUMENTOPAX,
a.NUMERONOTAVENDA,
a.CODIGOBRASIF,
a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, b.CODIGOCATEGORIADUFRY,
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
from itvet001 a, itemt027 b, FL_MAILING_PROP_ATIVOS C
where  a.dataoperacaocheckout between to_date('01/08/2011', 'dd/mm/yyyy') and to_date('31/08/2011', 'dd/mm/yyyy') 
and a.codigonegocio = '200'
and a.tipodocumentopax = c.tipodocumentopax
and a.numerodocumentopax = c.numerodocumentopax
and (b.codigobrasif(+)=a.codigobrasif and a.codigonegocio = b.codigonegocio(+))
and nvl(A.indicadorestorno, 'N')='N')
group by TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX


create table FL_MAILING_PROP_COMPRADORES2 as select TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX
from 
(select 
a.SIGLAAEROPORTO,  
a.CODIGOLOJA,
a.TIPOLOJA,
a.DATAOPERACAOCHECKOUT, 
to_char(a.DATAOPERACAOCHECKOUT, 'YYYY-MM') as ANO_MES,
a.INDICADORESTORNO, 
a.TIPODOCUMENTOPAX, 
a.NUMERODOCUMENTOPAX,
a.NUMERONOTAVENDA,
a.CODIGOBRASIF,
a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, b.CODIGOCATEGORIADUFRY,
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
from itvet001 a, itemt027 b, FL_MAILING_PROP_INATIVOS C
where  a.dataoperacaocheckout between to_date('01/08/2011', 'dd/mm/yyyy') and to_date('31/08/2011', 'dd/mm/yyyy') 
and a.codigonegocio = '200'
and a.tipodocumentopax = c.tipodocumentopax
and a.numerodocumentopax = c.numerodocumentopax
and (b.codigobrasif(+)=a.codigobrasif and a.codigonegocio = b.codigonegocio(+))
and nvl(A.indicadorestorno, 'N')='N')
group by TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX



create table FL_MAILING_PROP_COMPRADORES3 as select TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX
from 
(select 
a.SIGLAAEROPORTO,  
a.CODIGOLOJA,
a.TIPOLOJA,
a.DATAOPERACAOCHECKOUT, 
to_char(a.DATAOPERACAOCHECKOUT, 'YYYY-MM') as ANO_MES,
a.INDICADORESTORNO, 
a.TIPODOCUMENTOPAX, 
a.NUMERODOCUMENTOPAX,
a.NUMERONOTAVENDA,
a.CODIGOBRASIF,
a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, b.CODIGOCATEGORIADUFRY,
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
from itvet001 a, itemt027 b, FL_REL_CLI_Agosto C
where  a.dataoperacaocheckout between to_date('01/08/2011', 'dd/mm/yyyy') and to_date('31/08/2011', 'dd/mm/yyyy') 
and a.codigonegocio = '200'
and a.tipodocumentopax = c.tipodocumentopax
and a.numerodocumentopax = c.numerodocumentopax
and (b.codigobrasif(+)=a.codigobrasif and a.codigonegocio = b.codigonegocio(+))
and nvl(A.indicadorestorno, 'N')='N')
group by TIPODOCUMENTOPAX, NUMERODOCUMENTOPAX






-- TESTE - GERSON
SELECT  COUNT(NVL(NUMEROPEDIDO,'NA')) FROM ITPVV001
WHERE NVL(NUMEROPEDIDO,'NA') <> 'NA'


SELECT * FROM ITEMT027
SELECT * FROM ITEMT027 
WHERE SUBSTR(DESCRICAOITEM,0,11) LIKE 'BOLSA COURO'


SELECT NUMEROCHECKOUT, SUM(PRECOUNITARIOVENDA*QUANTIDADEVENDIDA) FROM  Itvet001 
WHERE SEQUENCIALOPERACAOCHECKOUT IN (50835,50837,50836,50834,50833,50833) AND NUMEROCHECKOUT = 83 AND QUANTIDADEVENDIDA IN (2,3)
GROUP BY NUMEROCHECKOUT

SELECT *
 FROM ITVET001 -- bASE DE PREÇOS
 
 SELECT SUBSTR(CPF,0,3)||'.'|| SUBSTR(CPF,3,3)||'.'||SUBSTR(CPF,6,3)||' - '||SUBSTR(CPF,8,2) AS cpf FROM CLIET018
 
