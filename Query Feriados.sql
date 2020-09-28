SELECT DATAOPERACAOCHECKOUT, 
MAX(IDA_CARNAVAL) AS IDA_CARNAVAL,
MAX(VOLTA_CARNAVAL) AS VOLTA_CARNAVAL,
MAX(CARNAVAL) AS CARNAVAL,
MAX(IDA_3DIAS) AS IDA_3DIAS, 
MAX(VOLTA_3DIAS) AS VOLTA_3DIAS, 
MAX(IDA_4DIAS) AS IDA_4DIAS, 
MAX(VOLTA_4DIAS) AS VOLTA_4DIAS, 
MAX(IDA_ANONOVO) AS IDA_ANONOVO, 
MAX(VOLTA_ANONOVO) AS VOLTA_ANONOVO, 
MAX(NATAL) AS NATAL, 
TO_CHAR(DATAOPERACAOCHECKOUT, 'YYYY') AS ANO,
TO_CHAR(DATAOPERACAOCHECKOUT, 'MM') AS MES,
MOD(NVL(to_CHAR(DATAOPERACAOCHECKOUT, 'IW'),0),4)  AS SEMANAS_MES,
TO_CHAR(DATAOPERACAOCHECKOUT, 'D') AS DIA_SEM, AVG(VALORIND) AS DOLAR,
SUM(VALORNOTAVENDABRUTO) / COUNT(DISTINCT(NUMEROCHECKOUT||SEQUENCIALOPERACAOCHECKOUT)) AS VENDA_MÉDIA
From (SELECT a.VALORNOTAVENDABRUTO, a.TIPOLOJA, a.DATAOPERACAOCHECKOUT, a.SIGLAAEROPORTO,
CASE WHEN a.TIPOLOJA = 'E' THEN 1 ELSE 0 END AS EMBARQUE,

CASE
WHEN a.dataoperacaocheckout  = to_date('12/02/2010', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('13/02/2010', 'dd/mm/yyyy') THEN 0.7
WHEN a.dataoperacaocheckout  = to_date('14/02/2010', 'dd/mm/yyyy') THEN 0.5
WHEN a.dataoperacaocheckout  = to_date('04/03/2011', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('05/03/2011', 'dd/mm/yyyy') THEN 0.7
WHEN a.dataoperacaocheckout  = to_date('16/03/2011', 'dd/mm/yyyy') THEN 0.5
WHEN a.dataoperacaocheckout  = to_date('17/02/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('18/02/2012', 'dd/mm/yyyy') THEN 0.7
WHEN a.dataoperacaocheckout  = to_date('19/02/2012', 'dd/mm/yyyy') THEN 0.5
ELSE 0
END AS IDA_CARNAVAL,
CASE
WHEN a.dataoperacaocheckout  = to_date('17/02/2010', 'dd/mm/yyyy') THEN 0.7
WHEN a.dataoperacaocheckout  = to_date('20/02/2010', 'dd/mm/yyyy') THEN 0.5
WHEN a.dataoperacaocheckout  = to_date('21/02/2010', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('11/03/2011', 'dd/mm/yyyy') THEN 0.7
WHEN a.dataoperacaocheckout  = to_date('12/03/2011', 'dd/mm/yyyy') THEN 0.5
WHEN a.dataoperacaocheckout  = to_date('13/03/2011', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('24/02/2012', 'dd/mm/yyyy') THEN 0.7
WHEN a.dataoperacaocheckout  = to_date('25/02/2012', 'dd/mm/yyyy') THEN 0.5
WHEN a.dataoperacaocheckout  = to_date('26/02/2012', 'dd/mm/yyyy') THEN 1
ELSE 0
END AS VOLTA_CARNAVAL,
CASE
WHEN a.dataoperacaocheckout  = to_date('16/02/2010', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('08/03/2011', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('21/02/2012', 'dd/mm/yyyy') THEN 1
ELSE 0
END AS CARNAVAL,

CASE
WHEN a.dataoperacaocheckout  = to_date('06/04/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('07/09/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('12/10/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('02/11/2012', 'dd/mm/yyyy') THEN 1
ELSE 0
END AS IDA_3DIAS,

CASE
WHEN a.dataoperacaocheckout  = to_date('08/04/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('09/09/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('14/10/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('04/11/2012', 'dd/mm/yyyy') THEN 1
ELSE 0
END AS VOLTA_3DIAS,

CASE
WHEN a.dataoperacaocheckout  = to_date('01/05/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('07/06/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('15/11/2012', 'dd/mm/yyyy') THEN 1
ELSE 0
END AS IDA_4DIAS,

CASE
WHEN a.dataoperacaocheckout  = to_date('10/06/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('18/11/2012', 'dd/mm/yyyy') THEN 1
ELSE 0
END AS VOLTA_4DIAS,

CASE
WHEN a.dataoperacaocheckout  = to_date('28/12/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('29/12/2012', 'dd/mm/yyyy') THEN 0.8
ELSE 0
END AS IDA_ANONOVO,

CASE
WHEN a.dataoperacaocheckout  = to_date('08/01/2012', 'dd/mm/yyyy') THEN 1
WHEN a.dataoperacaocheckout  = to_date('06/01/2013', 'dd/mm/yyyy') THEN 1
ELSE 0
END AS VOLTA_ANONOVO,

CASE
WHEN a.dataoperacaocheckout  = to_date('23/12/2012', 'dd/mm/yyyy') THEN 0.5
WHEN a.dataoperacaocheckout  = to_date('24/12/2012', 'dd/mm/yyyy') THEN 0.8
WHEN a.dataoperacaocheckout  = to_date('25/12/2012', 'dd/mm/yyyy') THEN 1
ELSE 0
END AS NATAL,

a.NUMEROCHECKOUT, a.SEQUENCIALOPERACAOCHECKOUT, C.VALORIND From vndat004 a, vlindreal C
Where  a.dataoperacaocheckout between to_date('01/01/2012', 'dd/mm/yyyy') and to_date('10/03/2013', 'dd/mm/yyyy')
and a.codigonegocio = '200' AND a.TIPOLOJA IN ('E','D') AND a.SIGLAAEROPORTO ='AIRJ'
AND C.dataindice(+) = a.dataoperacaocheckout
AND C.INDICE='003' and nvl(A.indicadorestorno, 'N')='N')
GROUP BY DATAOPERACAOCHECKOUT




SELECT DATAOPERACAOCHECKOUT, 
SUM(NVL(quantidadevendida,0)) / COUNT(DISTINCT(NUMEROCHECKOUT||SEQUENCIALOPERACAOCHECKOUT)) AS IPT
From (SELECT a.SIGLAAEROPORTO,  a.CODIGOLOJA,a.TIPOLOJA,a.DATAOPERACAOCHECKOUT, 
to_char(a.DATAOPERACAOCHECKOUT, 'YYYY-MM') AS ANO_MES,
a.NUMEROCHECKOUT, a.SEQUENCIALOPERACAOCHECKOUT,
a.NUMERONOTAVENDA, a.CODIGOBRASIF, a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, b.CODIGOCATEGORIADUFRY,
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA From itvet001 a, itemt027 b
Where  a.dataoperacaocheckout between to_date('01/01/2012', 'dd/mm/yyyy') and to_date('10/03/2013', 'dd/mm/yyyy')
and a.codigonegocio = '200' AND a.TIPOLOJA IN ('E','D') AND a.SIGLAAEROPORTO ='AISP'
and (b.codigobrasif(+)=a.codigobrasif and a.codigonegocio = b.codigonegocio(+))
and nvl(A.indicadorestorno, 'N')='N')
GROUP BY DATAOPERACAOCHECKOUT



SELECT DATAOPERACAOCHECKOUT, 
COUNT(DISTINCT(NUMEROCHECKOUT||SEQUENCIALOPERACAOCHECKOUT)) AS TRANS
From (SELECT a.SIGLAAEROPORTO,  a.CODIGOLOJA,a.TIPOLOJA,a.DATAOPERACAOCHECKOUT, 
to_char(a.DATAOPERACAOCHECKOUT, 'YYYY-MM') AS ANO_MES,
a.NUMEROCHECKOUT, a.SEQUENCIALOPERACAOCHECKOUT,
a.NUMERONOTAVENDA, a.CODIGOBRASIF, a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, b.CODIGOCATEGORIADUFRY,
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA From itvet001 a, itemt027 b
Where  a.dataoperacaocheckout between to_date('01/01/2012', 'dd/mm/yyyy') and to_date('10/03/2013', 'dd/mm/yyyy')
and a.codigonegocio = '200' AND a.TIPOLOJA IN ('E','D') AND a.SIGLAAEROPORTO ='AIRJ'
and (b.codigobrasif(+)=a.codigobrasif and a.codigonegocio = b.codigonegocio(+))
and nvl(A.indicadorestorno, 'N')='N')
GROUP BY DATAOPERACAOCHECKOUT
