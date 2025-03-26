-- Calculando quantidade de promoções que as compras do Cassio encaixam nas regras
SELECT 
    P.NomePromocao AS 'Promoção',
    COUNT(*) AS 'Total de Transações Válidas'
FROM 
    TRANSACOES T
JOIN 
    CLIENTE C ON T.CodigoCliente = C.CodigoCliente
JOIN 
    PROMOCAO P ON T.DataCompra BETWEEN P.DataInicio AND P.DataFim
    AND P.NomePromocao LIKE '%Sorteio%'
WHERE 
    C.Nome = 'Cassio'
    AND (
        (P.NomePromocao = 'SorteioCarro' AND T.ValorCompra > 10) 
        OR 
        (P.NomePromocao = 'SorteioCasa' AND T.ValorCompra > 20)
    )
GROUP BY 
    P.NomePromocao;
