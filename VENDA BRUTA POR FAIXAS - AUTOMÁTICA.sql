select valornotavendabruto, 
mod(valornotavendabruto, 100), 
(valornotavendabruto- mod(valornotavendabruto, 100)) as resto,
case when mod(valornotavendabruto, 100)>50 then (valornotavendabruto- mod(valornotavendabruto, 100))+50
else (valornotavendabruto- mod(valornotavendabruto, 100))
end as faixa_inicio,
case when mod(valornotavendabruto, 100)>50 then (valornotavendabruto- mod(valornotavendabruto, 100))+100
else (valornotavendabruto- mod(valornotavendabruto, 100))+50
end as faixa_fim
from vndat004
where dataoperacaocheckout between '01-jan-2009' and '01-jan-2009'
