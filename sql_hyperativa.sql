create database bd_hyperativa;
use bd_hyperativa;

create table CLIENTE(
	CodigoCliente integer primary key auto_increment,
    Nome varchar(64) not null,
    Idade int null,
    Email varchar(64) null
);

-- Inserting data into CLIENTE table
INSERT INTO CLIENTE (CodigoCliente, Nome, Idade, Email) VALUES
(1, 'Luis', 47, 'luis@teste.com.br'),
(2, 'Nathalia', 58, NULL),
(3, 'Ricardo', 17, 'ricardo@teste.com.br'),
(4, 'Paulo', 60, 'paulo@teste.com.br'),
(5, 'Cassio', NULL, 'cassio@teste.com.br');

create table PROMOCAO(
	CodigoPromocao integer primary key auto_increment,
	NomePromocao varchar(32) not null,
    DataInicio date not null,
    DataFim date not null
);

-- Inserting data into PROMOCAO table
INSERT INTO PROMOCAO (CodigoPromocao, NomePromocao, DataInicio, DataFim) VALUES
(1, 'Retorno50', '2020-01-01', '2020-03-01'),
(2, 'SorteioCarro', '2020-01-25', '2020-02-10'),
(3, 'SorteioCasa', '2020-02-01', '2020-04-01');

create table TRANSACOES(
	CodigoCliente integer,
    DataCompra date not null,
    ValorCompra decimal(10,2) not null,
    FOREIGN KEY (CodigoCliente) REFERENCES CLIENTE(CodigoCliente)
);

-- Inserting data into TRANSACOES table
INSERT INTO TRANSACOES (CodigoCliente, DataCompra, ValorCompra) VALUES
(1, '2020-01-20', 80),
(1, '2020-01-27', 7),
(1, '2020-02-03', 160),
(2, '2020-01-15', 25),
(2, '2020-01-30', 250),
(2, '2020-01-13', 40),
(3, '2020-01-25', 3),
(3, '2020-01-31', 90),
(3, '2020-02-01', 80),
(4, '2020-12-29', 50),
(4, '2020-01-16', 40),
(4, '2020-01-20', 90),
(4, '2020-01-25', 30),	
(5, '2020-02-02', 15),
(5, '2020-01-21', 70),	
(5, '2020-03-03', 60),
(5, '2020-02-09', 70);


