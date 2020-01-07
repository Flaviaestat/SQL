
CREATE TABLE fl_base_incentivo AS
SELECT ANO, MES, DIA, ANO_MES, TIPOLOJA, SIGLAAEROPORTO,
SUM(NVL(precounitariovenda,0)* NVL(quantidadevendida,0)) as VENDAS,
COUNT(DISTINCT(NUMEROCHECKOUT||SEQUENCIALOPERACAOCHECKOUT)) AS TRANS,
SUM(NVL(quantidadevendida,0)) AS QTD
from (SELECT a.SIGLAAEROPORTO,   a.CODIGOLOJA,
a.TIPOLOJA, a.DATAOPERACAOCHECKOUT, to_char(a.DATAOPERACAOCHECKOUT, 'YYYY-MM') AS ANO_MES,
to_char(a.DATAOPERACAOCHECKOUT, 'YYYY') AS ANO,
to_char(a.DATAOPERACAOCHECKOUT, 'MM') AS MES, to_char(a.DATAOPERACAOCHECKOUT, 'DD') AS DIA,
a.NUMEROCHECKOUT, a.SEQUENCIALOPERACAOCHECKOUT,
a.NUMERONOTAVENDA, a.CODIGOBRASIF,
a.PRECOUNITARIOVENDA, a.QUANTIDADEVENDIDA, c.NOMELOJA,
b.CODIGOGRUPO, b.CODIGOSUBGRUPO, b.CODIGOCATEGORIADUFRY,
b.DESCRICAOITEM,  b.IDENTIFICACAOMARCA
from itvet001 a, itemt027 b, lojat001 c
where  a.dataoperacaocheckout between to_date('01/03/2014', 'dd/mm/yyyy') and to_date('10/03/2015', 'dd/mm/yyyy') 
and a.codigoloja = c.codigoloja (+)
and a.codigonegocio = '200' 
and (b.codigobrasif(+)=a.codigobrasif and a.codigonegocio = b.codigonegocio(+))
and nvl(A.indicadorestorno, 'N')='N')
GROUP BY ANO, MES, DIA, ANO_MES, TIPOLOJA, SIGLAAEROPORTO




select * from TEMP_FL_EVO_DP

drop table TEMP_FL_EVO_DP

