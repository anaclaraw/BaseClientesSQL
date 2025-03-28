-- O cliente Ricardo questionou quantas cupons tem para a promoção SorteioCarro

-- Analise dos dados
-- Conferindo se o valor mínimo arrecadado e as datas da compra e periodo promoção batem
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
    C.Nome = 'Ricardo';
    

-- Resultados seguindo todas as condições
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
    C.Nome = 'Ricardo' AND T.ValorCompra > 10;