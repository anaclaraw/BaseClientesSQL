# **Análise de Dados: Reclamações de Clientes**  

**Autor:** Ana Clara Melo  
**Data:** 25/03/2025 
**Versão:** 1.0  

## **Introdução**  
Este relatório tem como objetivo analisar as possíveis falhas na promoção após a reclamação de clientes. Será utilizado consultas SQL, imagens e explicações detalhadas para cada questão levantada. As análises serão posteriormente compartilhadas como time SAC.  

##  **Tabela de Conteúdos**  
- [Dados utilizados na análise](#dados-utilizados-na-análise)  
- [Condições a serem validadas sobre as promoções](#condições-a-serem-validadas-sobre-as-promoções)  
- [Pergunta 1](#pergunta-1)  
- [Pergunta 2](#pergunta-2)  
- [Pergunta 3](#pergunta-3)  
- [Pergunta 4](#pergunta-4)  
- [Pergunta 5](#pergunta-5)  
- [Pergunta 6](#pergunta-6)  
- [Pergunta 7](#pergunta-7)  
 

## Dados utilizados na análise
- [Perguntas](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/perguntas.txt)
- [Base de dados](https://github.com/anaclaraw/BaseClientesSQL/blob/main/base_dados_csv.xlsx)

### Condições a serem validadas sobre as promoções

#### **Promoção 1 – Crédito de R$ 50**  
- O cliente recebe **R$ 50,00 em crédito** se acumular **R$ 200,00 ou mais** dentro do período da promoção.  
- **Critérios de participação:**  
  - **Ter um e-mail cadastrado**.  
  - **Ser maior de 18 anos**.  

####  **Promoção 2 – Sorteio de Carro**  
- O cliente recebe **um cupom por compra** se o valor da compra for **maior ou igual a R$ 10,00** dentro do período da promoção.  
- **Todos os clientes podem participar.**  

####  **Promoção 3 – Sorteio de Casa**  
- O cliente recebe **um cupom por compra** se o valor da compra for **maior ou igual a R$ 20,00** dentro do período da promoção.  
- **Todos os clientes podem participar.**  

 
---


##  **Pergunta 1** 
O cliente Luís reclamou que recebeu apenas um cupom na promoção SorteioCarro, porém deveria ter recebido três. Analisar a reclamação do cliente, e informar se ele está correto ou se houve algum problema.   

###  **Consulta SQL**  
```sql
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
```

### 📊 **Visualização da Análise**  
![Descrição da Imagem](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta1.png)
_Ao realizar  a consulta podemos notar visualmente que uma das condições não está sendo seguida, a de valor mínimo de R$10 por compra._  
Então ao adicionar no script a seguinte condição:
```sql
WHERE 
    C.Nome = 'Luis' and  T.ValorCompra >= 10 ;	
```
Temos como retorno apenas um resultado.
![Tipos de Reclamações](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta1_2.png)

### 📈 **Análise**  
- O engano aconteceu pois, o cliente Luís não cumprir o valor mínimo na sua primeira compra, mesmo estando no perioodo da promoção. 

---

##  **Pergunta 2**  
 O cliente Paulo alegou que não recebeu os R$ 50,00 devidos pela promoção Retorno50. Análisar se o cliente tem direito ao crédito.

### **Consulta SQL bucando registros de compras de Paulo dentro do periodo da promoção Retorno 50**  
```sql
    
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
 
```
### 📊 **Visualização da Análise** 
![Pergunta2](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta2.png)
Aqui podemos notar que Paulo realizou 3 transações no periodo da promoção, possui maioridade e email cadastrado.
Segunda consulta:
```sql    
SELECT 
    C.Nome AS Cliente,
    COUNT(T.ValorCompra) AS 'Total Compras',
    SUM(T.ValorCompra) AS 'Valor Total Compras'
FROM 
    TRANSACOES T
JOIN 
    CLIENTE C ON T.CodigoCliente = C.CodigoCliente
JOIN 
    PROMOCAO P ON P.NomePromocao = 'Retorno50'
WHERE 
    C.Nome = 'Paulo'
    AND T.DataCompra BETWEEN P.DataInicio AND P.DataFim;
    
```

### 📊 **Visualização da Análise**  
![Pergunta2](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta2_2.png)
Aqui temos que o valor total de suas trnsações não cumpriram o valor mínimo de R$200 arrecadados.

### 📈 **Análise**  
- A falha foi o cliente não ter arrecadado o valor mínimo exigido pela promoção em suas transações. 

---

## **Pergunta 3**  
O cliente Ricardo questionou quantas cupons tem para a promoção SorteioCarro

###  **Consulta SQL**  
```sql
-- Conferindo se Ricardo possui transações durante o periodo da promoção
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
```

### 📊 **Visualização da Análise** 
![Pergunta2](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta3.png)

Aqui podemos notar que Ricardo realizou 3 transações ao todo no periodo da promoção.
Adicionando condição do valor minímo á consulta:
```sql
WHERE 
    C.Nome = 'Ricardo' AND T.ValorCompra > 10;
```


### 📊 **Visualização da Análise** 
![Pergunta2](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta3_2.png)
Cumprindo todas as regras da promoção SorteioCarro essa foi a quantidade de registros encontrados

### 📈 **Análise**  
- Ao todo Ricardo deve ser creditado com dois cupons. 

---

## **Pergunta 4**  
A cliente Nathalia alegou que não recebeu os R$ 50,00 da promoção Retorno50. Verificar o motivo.  

###  **Consulta SQL validano transações realizadas por nathalis durante o periodo da promoção Retorno50**  
```sql
    

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
    C.Nome = 'Nathalia';

```
Ao analisarmos as transações de Nathalia no período corrente da promoção temos:
### 📊 **Visualização da Consulta**  
![Pergunta4](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta4_1.png)  
Aqui podemos notar que nathalia realizou transações no periodo da promoção, e possui mais de 18 anos.

Segunta colsulta:
```sql
 -- Motivo pela não creditação do benefício
SELECT Nome, Email FROM CLIENTE where Nome = 'Nathalia';
```
### 📊 **Visualização da Consulta**  
![Pergunta4](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta4.png)  
Nathalia não possui Email cadastrado.



### 📈 **Análise**  
- Nathalia não recebeu seu cupom pois não possui email cadastrado, que é uma das exigências da promoção Retorno50. 

---

## **Pergunta 5**  
O cliente Cassio está questionando quantas chances possui na promoção de sorteio.

###  **Consulta SQL**  
```sql
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

```
### 📊 **Visualização da Consulta** 
![Pergunta4](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta5.png) 
Ao realizar a soma de transações cumprindo os requisitos de valor mínimo de cada sorteio temos o resultado a cima.

### 📈 **Análise**  
- Através da consulta podemos concluir que Cassio tem 2 chances em cada um dos Sorteios. 

---

## **Pergunta 6**  
A cliente Giovana quer saber quantas chances ela tem na promoção SorteioCasa

###  **Consulta SQL**  
```sql
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
```

### 📊 **Visualização da Consulta** 
![Pergunta4](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta6_2.png)
<br>
Não há registros de transações cumprindo os requisitos do sorteio em nome da Cliente Giovana.

Segunda consulta:
```sql
select * from cliente where Nome = 'Giovana';
```

### 📊 **Visualização da Consulta** 
![Pergunta4](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta6.png) 
Não há registros de Cliente Chamada Giovana no banco de dados.

### 📈 **Análise**  
- Giovana não realizou transações.

---

## **Pergunta 7**  
O cliente Paulo informa que deveria ter 3 cupons na promoção SorteioCarro porém não visualiza. Verificar!

###  **Consulta SQL**
```sql
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
    C.Nome = 'Paulo';
```



### 📊 **Visualização da Consulta** 
![Pergunta7-2](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imgem_pergunta7_2.png) 
<br>
Aqui podemos notar que durante o periodo da promoção Sorteio carro Paulo realizou apenas uma transação.

Segunda colsulta:
```sql
-- Conferindo se Paulo possui outras transações
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
    PROMOCAO P ON T.DataCompra 
    AND P.NomePromocao = 'SorteioCarro'
WHERE 
    C.Nome = 'Paulo';

```

### 📊 **Visualização da Consulta** 
![Pergunta7](https://github.com/anaclaraw/BaseClientesSQL/blob/main/images/imagem_pergunta7.png) 
Paulo realizou sim outras transações que cumpririam o requisito de valor mínimo, porém foi fora do periodo da promoção

### 📈 **Análise**  
- Apenas um registro com todas as exigências da promoção. 
- Paulo realizou sim outras compras e esse pode ter sido o motivo da afirmação de Paulo, porém foram realizadas em épocas fora do intervalo do sorteio.  

---

## Conclusão
- Ao concluir a análise podemos notar que não houve falhas na creditação do beneficio, apenas falhas por parte dos clientes em se atentarem as condições de cada promoção.
- Proposta de solução: Deixar as regras de cada promoção mais claras.


