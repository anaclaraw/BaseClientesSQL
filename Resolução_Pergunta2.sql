    
-- Conferindo se o valor, email e as datas da compra e periodo promoção batem
SELECT 
    C.Nome AS Cliente,
    C.Email,
    C.Idade,
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
    AND P.NomePromocao = 'Retorno50'
WHERE 
    C.Nome = 'Paulo';
    
SELECT 
    C.Nome AS Cliente,
    COUNT(T.ValorCompra) AS TotalCompras,
    SUM(T.ValorCompra) AS ValorTotalCompras
FROM 
    TRANSACOES T
JOIN 
    CLIENTE C ON T.CodigoCliente = C.CodigoCliente
JOIN 
    PROMOCAO P ON P.NomePromocao = 'Retorno50'
WHERE 
    C.Nome = 'Paulo'
    AND T.DataCompra BETWEEN P.DataInicio AND P.DataFim;
    