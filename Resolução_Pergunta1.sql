-- O cliente Luís reclamou que recebeu apenas um cupom na promoção SorteioCarro, porém deveria ter recebido três. Analisar a reclamação do cliente, e informar se ele está correto ou se houve algum problema. 

-- Analise dos dados
-- Conferindo se o valor mínimo e as datas da compra e periodo promoção batem
SELECT 
    C.Nome AS Cliente,
    DATE_FORMAT(T.DataCompra, "%d/%m/%Y") as 'Data da Compra',
    T.ValorCompra as 'Valor da Compra',
    P.NomePromocao as 'Promoção',
    DATE_FORMAT(P.DataInicio, "%d/%m/%Y") as 'Data de início da Promoção',
    DATE_FORMAT(P.DataFim, "%d/%m/%Y") as 'Data de início da promoção'
FROM 
    TRANSACOES T
JOIN 
    CLIENTE C ON T.CodigoCliente = C.CodigoCliente
JOIN 
    PROMOCAO P ON T.DataCompra BETWEEN P.DataInicio AND P.DataFim
    AND P.NomePromocao = 'SorteioCarro'
WHERE 
    C.Nome = 'Luis';	