CASE
WHEN SUBSTR(a.NUMEROVOOPAX, 1, 2)='MX' THEN ('AM'||REPLACE(a.NUMEROVOOPAX,'MX', ''))
WHEN SUBSTR(a.NUMEROVOOPAX, 1, 2)='GL' THEN ('G3'||REPLACE(a.NUMEROVOOPAX,'GL', '')) 
WHEN SUBSTR(a.NUMEROVOOPAX, 1, 2)='SW' THEN ('LX'||REPLACE(a.NUMEROVOOPAX,'SW', ''))  
WHEN   A.NUMEROVOOPAX in ('ET0507', 'ET507')    THEN   'ET0506'
WHEN   A.NUMEROVOOPAX='IB6825'    THEN   'IB6827'
WHEN   A.NUMEROVOOPAX='AR2240'    THEN   'AR1240'
WHEN   A.NUMEROVOOPAX='JJ8083'    THEN   'JJ8093'
WHEN   A.NUMEROVOOPAX='AR2244'    THEN   'AR1244'
WHEN   A.NUMEROVOOPAX in ('QR0921','QR921')    THEN   'QR0771'
WHEN   A.NUMEROVOOPAX='AR2224'    THEN   'AR2220'
WHEN   A.NUMEROVOOPAX='AR2274'    THEN   'AR1274'
WHEN   A.NUMEROVOOPAX='AR1222'    THEN   'AR2222'
WHEN   A.NUMEROVOOPAX in ('CU0352','CU352')    THEN   'CU2352'
WHEN   A.NUMEROVOOPAX in ('QR0922', 'QR922')    THEN   'QR0772'
WHEN   A.NUMEROVOOPAX in ('AA0233', 'AA233')    THEN   'AA2433'
WHEN   A.NUMEROVOOPAX in ('DL0121', 'DL121')    THEN   'DL0471'
WHEN   A.NUMEROVOOPAX in ('DL0047', 'DL47')    THEN   'DL0053'
WHEN   A.NUMEROVOOPAX in ('DL0257', 'DL257')    THEN   'DL0053'
WHEN   A.NUMEROVOOPAX in ('5Q0612', '5Q612')    THEN   '5Q0618'
WHEN   A.NUMEROVOOPAX in ('TP0083', 'TP83')    THEN   'TP0089'
WHEN   A.NUMEROVOOPAX='JJ8082'    THEN   'JJ8092'
WHEN   A.NUMEROVOOPAX='AR2241'    THEN   'AR1241'
WHEN   A.NUMEROVOOPAX='AR2245'    THEN   'AR1245'
WHEN   A.NUMEROVOOPAX='AR2225'    THEN   'AR2221'
WHEN   A.NUMEROVOOPAX='AR2275'    THEN   'AR1275'
WHEN   A.NUMEROVOOPAX='AR1223'    THEN   'AR2223'
WHEN   A.NUMEROVOOPAX in ('CU0353', 'CU353')  THEN   'CU1353'
WHEN   A.NUMEROVOOPAX in ('AA0234','AA234')   THEN   'AA2434'
WHEN   A.NUMEROVOOPAX in ('OB0734','OB734')   THEN   'OB0739'
WHEN   A.NUMEROVOOPAX in ('EK0262','EK262')   THEN   'EK8262'
WHEN   A.NUMEROVOOPAX in ('DL0120','DL120')   THEN   'DL0472'
WHEN   A.NUMEROVOOPAX in ('5Q0613','5Q613')   THEN   '5Q0619'
WHEN   A.NUMEROVOOPAX in ('UA0043','UA43')    THEN   'UA0979'
WHEN   A.NUMEROVOOPAX in ('OB0734','OB734')    THEN   'OB0739'
WHEN   A.NUMEROVOOPAX in ('AV0288','AV288')    THEN   'AV0248'
WHEN   A.NUMEROVOOPAX in ('DL0256','DL256')    THEN   'DL0048'
WHEN   A.NUMEROVOOPAX in ('DL0257','DL257')    THEN   'DL0047'
WHEN   A.NUMEROVOOPAX in ('CM0113','CM113')    THEN   'CM0216'
WHEN   A.NUMEROVOOPAX in ('UA0978','UA978')    THEN   'UA6871'
WHEN   A.NUMEROVOOPAX='G37625'    THEN   'G37623'
WHEN   A.NUMEROVOOPAX='G37624'    THEN   'G37622'
WHEN   A.NUMEROVOOPAX='AR2200'    THEN   'AR2220'
WHEN   A.NUMEROVOOPAX='AR1220'    THEN   'AR2222'
WHEN   A.NUMEROVOOPAX='AR1221'    THEN   'AR2221'
WHEN   A.NUMEROVOOPAX='AR2233'    THEN   'AR2223'
WHEN   A.NUMEROVOOPAX='OB0737'    THEN   'OB0739'
WHEN   A.NUMEROVOOPAX='BQB632'    THEN   'BQ0632'
WHEN   A.NUMEROVOOPAX='AR2240'    THEN   'AR1242'
WHEN   A.NUMEROVOOPAX='G37452'    THEN   'G37662'
ELSE SUBSTR(a.NUMEROVOOPAX, 1, 2)||REPLACE(a.NUMEROVOOPAX,SUBSTR(a.NUMEROVOOPAX, 1, 2), '') 
END AS NUMEROVOOPAX2,
