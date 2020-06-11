/*
TeSP_PSI_1920_CDBD
Sistema de Informação para a Gestão de Stand de Automóveis
Francisco José dos Santos Jacinto, estudante n.º 2190761
Gabriel José Jesus Miranda, estudante n.º 2190765
…
*/
drop schema if exists Grupo2;
create database Grupo2;

use Grupo2;

-- Criação de tabelas

CREATE TABLE Cliente (
idCliente INT unsigned NOT NULL AUTO_INCREMENT,
primeiroNome VARCHAR(30),
ultimoNome VARCHAR(30),
rua VARCHAR(30),
localidade VARCHAR(30),
cod_postal VARCHAR(8),
email VARCHAR(50),

primary key (idCliente)
)engine=InnoDB;

CREATE TABLE TelefonesCliente (
nrTelefone int unsigned,
idCliente int unsigned not null,

primary key (nrTelefone, idCliente),
CONSTRAINT fk_TelefonesCliente_Cliente_idCliente foreign key (idCliente) references Cliente(idCliente)
)engine=InnoDB;

CREATE TABLE Marca (
idMarca INT unsigned NOT NULL AUTO_INCREMENT,
nome varchar(20),

primary key (idMarca)
)engine=InnoDB;

CREATE TABLE Modelo (
idModelo INT unsigned NOT NULL AUTO_INCREMENT,
idMarca int unsigned,
nome varchar(20),

Primary key (idModelo),
CONSTRAINT fk_Modelo_Marca_idMarca foreign key (idMarca) references Marca(idMarca)
)engine=InnoDB;

CREATE TABLE Stand (
idStand INT unsigned NOT NULL AUTO_INCREMENT,
nome VARCHAR(30),
rua VARCHAR(30),
localidade VARCHAR(30),
cod_postal VARCHAR(8),
email VARCHAR(50),

primary key (idStand),
CONSTRAINT uk_stand_email unique (email)
)engine=InnoDB;

CREATE TABLE TelefonesStand (
nrTelefone int unsigned,
idStand int unsigned,

primary key (nrTelefone, idStand),
CONSTRAINT fk_TelefonesStand_Stand_idStand foreign key (idStand) references Stand(idStand)
)engine=InnoDB;

CREATE TABLE Veiculo (
idVeiculo INT unsigned NOT NULL AUTO_INCREMENT,
idStand int unsigned,
idModelo int unsigned,
dataRececao date,
peso double,
ano int,
cilindrada int,
matricula varchar(10),
nrQuilometros double,
potencia int,
lotacao int,
categoria varchar(5),
preco double,

primary key (idVeiculo),
CONSTRAINT fk_Veiculo_Stand_idStand foreign key (idStand) references Stand(idStand),
CONSTRAINT fk_Veiculo_Modelo_idModelo foreign key (idModelo) references Modelo(idModelo)
)engine=InnoDB;

CREATE TABLE Funcionario (
idFuncionario INT unsigned NOT NULL AUTO_INCREMENT,
idStand int unsigned,
dataAdmissao date,
primeiroNome VARCHAR(30),
ultimoNome VARCHAR(30),
rua VARCHAR(30),
localidade VARCHAR(30),
cod_postal VARCHAR(8),
email VARCHAR(50),

primary key (idFuncionario),
CONSTRAINT uk_funcionario_email unique (email),
CONSTRAINT fk_funcionario_stand_idStand foreign key (idStand) references Stand(idStand)
)engine=InnoDB;

CREATE TABLE TelefonesFuncionario (
nrTelefone int unsigned,
idFuncionario int unsigned,

primary key (nrTelefone,idFuncionario),
CONSTRAINT fk_TelefonesFuncionario_Funcionario_idFuncionario foreign key (idFuncionario) references Funcionario(idFuncionario)
)engine=InnoDB;

CREATE TABLE Vendedor (
idVendedor int unsigned,

primary key (idVendedor),
CONSTRAINT fk_Vendedor_idVendedor foreign key (idVendedor) references Funcionario(idFuncionario)
)engine=InnoDB;

CREATE TABLE Venda(
idVenda INT unsigned NOT NULL AUTO_INCREMENT,
idCliente int unsigned,
idVendedor int unsigned,
dataVenda date,

primary key (idVenda),
CONSTRAINT fk_Venda_Cliente_idCliente foreign key (idCliente) references Cliente(idCliente),
CONSTRAINT fk_Venda_Vendedor_idVendedor foreign key (idVendedor) references Vendedor(idVendedor)
)engine=InnoDB;

CREATE TABLE VeiculosVenda(
idVeiculo int unsigned,
idVenda int unsigned,
preco double,

primary key (idVeiculo),
CONSTRAINT fk_VeiculosVenda_idVeiculo foreign key (idVeiculo) references Veiculo(idVeiculo),
CONSTRAINT fk_VeiculosVenda_Venda_idVenda foreign key (idVenda) references Venda(idVenda)
)engine=InnoDB;

CREATE TABLE Limpador (
idLimpador int unsigned,

primary key (idLimpador),
CONSTRAINT fk_Limpador_idLimpador foreign key (idLimpador) references Funcionario(idFuncionario)
)engine=InnoDB;

CREATE TABLE Limpeza(
idLimpeza INT unsigned NOT NULL AUTO_INCREMENT,
idLimpador int unsigned,
idVeiculo int unsigned,
dataLimpeza date,

primary key (idLimpeza),
CONSTRAINT fk_Limpeza_Limpador_idLimpador foreign key (idLimpador) references Limpador(idLimpador),
CONSTRAINT fk_Limpeza_Veiculo_idVeiculo foreign key (idVeiculo) references Veiculo(idVeiculo)
)engine=InnoDB;





-- Inserir dados nas tabelas

INSERT INTO Cliente (primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values ('Francisco', 'Jacinto', 'Rua das Flores', 'Torres Vedras', '2560-243', '2190761@my.ipleiria.pt');
INSERT INTO Cliente (primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values ('Gabriel', 'Miranda', 'Rua do Pinheiro', 'Torres Vedras', '2560-300', '2190765@my.ipleiria.pt');

INSERT INTO TelefonesCliente (nrTelefone, idCliente) values (941111111, 1);
INSERT INTO TelefonesCliente (nrTelefone, idCliente) values (942222222, 2);

INSERT INTO Marca (nome) values ('Mercedes');
INSERT INTO Marca (nome) values ('BMW');
INSERT INTO Marca (nome) values ('Ford');

INSERT INTO Modelo (idMarca, nome) values (1, 'Classe A');
INSERT INTO Modelo (idMarca, nome) values (1, 'Classe C');
INSERT INTO Modelo (idMarca, nome) values (1, 'Classe E');
INSERT INTO Modelo (idMarca, nome) values (1, 'Classe S');

INSERT INTO Modelo (idMarca, nome) values (2, 'X1');
INSERT INTO Modelo (idMarca, nome) values (2, 'X3');
INSERT INTO Modelo (idMarca, nome) values (2, 'X5');
INSERT INTO Modelo (idMarca, nome) values (3, 'Mustang');

INSERT INTO Stand (nome, rua, localidade, cod_postal, email) values ('Stand1', 'Rua do Stand1', 'Leiria', '2400-255', 'stand1@my.ipleiria.pt');
INSERT INTO Stand (nome, rua, localidade, cod_postal, email) values ('Stand2', 'Rua do Stand2', 'Leiria', '2400-243', 'stand2@my.ipleiria.pt');

INSERT INTO TelefonesStand (nrTelefone, idStand) values (268111111, 1);
INSERT INTO TelefonesStand (nrTelefone, idStand) values (268222222, 2);

-- Veiculos Stand 1 - ID's (1, 2)

INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (1, 1, '2020-01-20', 2500, 2020, 3000, '99-32-ZS', 10000, 400, 5, 'B', 100000);
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (1, 2, '2020-01-10', 3000, 2019, 2700, '22-32-IO', 45000, 325, 2, 'B', 125000);
-- Veiculos Stand 2 - ID's (3, 4, 5)
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (2, 5, '2020-04-24', 2500, 2018, 2500, '91-22-PT', 50000, 200, 5, 'B', 80000);
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (2, 6, '2020-03-01', 3000, 2016, 2300, '43-54-MJ', 95000, 235, 5, 'B', 45000);
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (2, 7, '2020-02-02', 2300, 2014, 2600, '11-12-UU', 30000, 190, 5, 'B', 100000);
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (2, 8, '2019-12-28', 2300, 2020, 2800, '77-88-OI', 30000, 320, 5, 'B', 50000);

-- Vendedores Stand 1 - ID's (1, 2)

INSERT INTO Funcionario(idStand, dataAdmissao, primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values (1, '2018-12-02', 'João', 'Alberto', 'Rua do Touro', 'Lisboa', '1000-010', 'joaoalberto@mail.com');
INSERT INTO Funcionario(idStand, dataAdmissao, primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values (1, '2019-08-15', 'Tomás', 'Silva', 'Rua do Trovão', 'Lisboa', '1000-012', 'tomassilva@mail.com');
-- Limpadores Stand 1 - ID's (3, 4)
INSERT INTO Funcionario(idStand, dataAdmissao, primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values (1, '2020-06-10','Rodrigo', 'Martinho', 'Rua do Foguete', 'Lisboa', '1000-017', 'rodrigomartinho@mail.com');
INSERT INTO Funcionario(idStand, dataAdmissao, primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values (1, '2020-06-07' ,'António', 'Gomes', 'Rua do Ouro', 'Lisboa', '1000-020', 'antoniogomes@mail.com');

-- Vendedor Stand 2 - ID's (5)
INSERT INTO Funcionario(idStand, dataAdmissao, primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values (2, '2019-06-07', 'Nelson', 'Lopes', 'Rua da Fonte', 'Leiria', '2400-010', 'nelsonlopes@mail.com');
-- Limpador Stand 2 - ID's (6)
INSERT INTO Funcionario(idStand, dataAdmissao, primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values (2, '2020-01-02', 'Fábio', 'Santos', 'Rua da Marmita', 'Leiria', '2400-012', 'fabiosantos@mail.com');

INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('971111111', 1);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('972222222', 2);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('973333333', 3);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('974444444', 4);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('975555555', 5);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('976666666', 6);

-- Vendedores Stand 1
INSERT INTO Vendedor (idVendedor) values (1);
INSERT INTO Vendedor (idVendedor) values (2);
-- Vendedor Stand 2
INSERT INTO Vendedor (idVendedor) values (5);

-- Vistas
CREATE VIEW PrecoCarroID2 AS SELECT preco FROM Veiculo where idVeiculo = 2;
CREATE VIEW PrecoCarroID5 AS SELECT preco FROM Veiculo where idVeiculo = 5;

INSERT INTO Venda (idcliente, idvendedor, datavenda) values (1, 1, '2020-03-24');
INSERT INTO Venda (idcliente, idvendedor, datavenda) values (2, 5, '2020-03-11');

INSERT INTO VeiculosVenda (idVeiculo, idVenda, preco) values (2, 1, (select * from PrecoCarroID2));
INSERT INTO VeiculosVenda (idVeiculo, idVenda, preco) values (5, 2, (select * from PrecoCarroID5));

-- Limpador Stand 1
INSERT INTO Limpador (idLimpador) values (3);
INSERT INTO Limpador (idLimpador) values (4);
-- Limpador Stand 2
INSERT INTO Limpador (idLimpador) values (6);

INSERT INTO Limpeza (idLimpador, idVeiculo, dataLimpeza) values (3, 1, '2020-03-22');
INSERT INTO Limpeza (idLimpador, idVeiculo, dataLimpeza) values (6, 3, '2020-03-22');



-- Selects para testes
select * from VeiculosVenda;
select * from veiculo;
select * from Marca;
select * from modelo;


-- Quantidade de veiculos em cada Stand

select count(*) as "Quantidade de Veiculos do Stand 1" from Veiculo where Veiculo.idStand = 1;
select count(*) as "Quantidade de Veiculos do Stand 1" from Veiculo where Veiculo.idStand = 2;

-- Quantidade de veiculos em cada Stand filtrados por marca

select count(*) as "Quantidade de Veiculos da Marca BMW do Stand 2" from Veiculo
inner join Modelo
on Veiculo.idModelo = Modelo.idModelo
inner join Marca
on Modelo.idMarca = Marca.idMarca where Marca.nome = 'BMW' and Veiculo.idStand = 2;

select count(*) as "Quantidade de Veiculos da Marca BMW do Stand 1" from Veiculo
inner join Modelo
on Veiculo.idModelo = Modelo.idModelo
inner join Marca
on Modelo.idMarca = Marca.idMarca where Marca.nome = 'BMW' and Veiculo.idStand = 1;

select count(*) as "Quantidade de Veiculos da Marca Mercedes do Stand 2" from Veiculo
inner join Modelo
on Veiculo.idModelo = Modelo.idModelo
inner join Marca
on Modelo.idMarca = Marca.idMarca where Marca.nome = 'Mercedes' and Veiculo.idStand = 2;

select count(*) as "Quantidade de Veiculos da Marca Mercedes do Stand 1" from Veiculo
inner join Modelo
on Veiculo.idModelo = Modelo.idModelo
inner join Marca
on Modelo.idMarca = Marca.idMarca where Marca.nome = 'Mercedes' and Veiculo.idStand = 1;


-- Detalhes sobre a venda

select Funcionario.primeiroNome as "Nome Vendedor", TIMESTAMPDIFF(DAY, Veiculo.dataRececao, Venda.dataVenda) as "Dias em que o carro teve no Stand até à data da venda",
       VeiculosVenda.preco as "Preco Venda", Venda.dataVenda as "Data Venda", Cliente.primeiroNome as 'Primeiro Nome do Cliente',
       Cliente.ultimoNome as "Último Nome do Cliente " , Marca.nome as "Marca", Modelo.nome as "Modelo", Veiculo.matricula as "Matrícula"
from Funcionario
inner join Vendedor
on Funcionario.idFuncionario = Vendedor.idVendedor
inner join Venda
on Vendedor.idVendedor = Venda.idVendedor
inner join Cliente
on Venda.idCliente = Cliente.idCliente
inner join VeiculosVenda
on Venda.idVenda = VeiculosVenda.idVenda
inner join Veiculo
on VeiculosVenda.idVeiculo = Veiculo.idVeiculo
inner join Modelo
on Veiculo.idModelo = Modelo.idModelo
inner join Marca
on Modelo.idMarca = Marca.idMarca;

-- Detalhes sobre Limpeza dos carros

select Funcionario.primeiroNome as "Nome Limpador", Limpeza.dataLimpeza as "Data Limpeza",
       Marca.nome as "Marca", Modelo.nome as "Modelo",  Veiculo.matricula as "Matrícula"
from Funcionario
inner join Limpador
on Funcionario.idFuncionario = Limpador.idLimpador
inner join Limpeza
on Limpador.idLimpador = Limpeza.idLimpador
inner join Veiculo
on Limpeza.idVeiculo = Veiculo.idVeiculo
inner join Modelo
on Veiculo.idModelo = Modelo.idModelo
inner join Marca
on Modelo.idMarca = Marca.idMarca;