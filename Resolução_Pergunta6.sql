-- A cliente Giovana quer saber quantas chances ela tem na promoção SorteioCasa

-- Analise dos dados
-- Conferindo quantas vezes a Cliente Giovana concorre a promoção SorteioCasa
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
    AND P.NomePromocao = 'SorteioCasa'
WHERE 
    C.Nome = 'Giovana' and T.ValorCompra >= 20;
    

