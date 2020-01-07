/** CONECTAR COM A BASE FILIAIS DESEJADA*/
SELECT DATAOPERACAOCHECKOUT, 
SUM(NVL(precounitariovenda,0)* NVL(quantidadevendida,0)) as VENDAS,
COUNT(DISTINCT(NUMEROCHECKOUT||SEQUENCIALOPERACAOCHECKOUT)) AS TRANS,
SUM(NVL(quantidadevendida,0)) AS QTD
from (SELECT   C.CODIGOLOJA,
C.DATAOPERACAOCHECKOUT, to_char(C.DATAOPERACAOCHECKOUT, 'YYYY-MM') AS ANO_MES,
a.NUMEROCHECKOUT, a.SEQUENCIALOPERACAOCHECKOUT,
a.NUMERONOTAVENDA, a.CODIGOBRASIF, C.NUMEROVOOPAX, 
a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, 
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, b.CODIGOCATEGORIADUFRY,
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
from itvet001 a, itemt027 b, CHCKT002 C, VNDAT004 D
where  C.dataoperacaocheckout between to_date('01/04/2016', 'dd/mm/yyyy') and to_date('24/04/2016', 'dd/mm/yyyy') 
and b.codigobrasif(+)=a.codigobrasif 
AND b.codigonegocio = '400' 
and a.NUMEROCHECKOUT = D.NUMEROCHECKOUT
and a.SEQUENCIALOPERACAOCHECKOUT = D.SEQUENCIALOPERACAOCHECKOUT
and a.NUMEROCHECKOUT = C.NUMEROCHECKOUT
and a.SEQUENCIALOPERACAOCHECKOUT = C.SEQUENCIALOPERACAOCHECKOUT
and NVL(d.INDICADORESTORNO,'N') = 'N')
GROUP BY DATAOPERACAOCHECKOUT





