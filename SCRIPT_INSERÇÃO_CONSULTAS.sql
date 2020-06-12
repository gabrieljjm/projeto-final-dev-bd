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


DROP USER if exists 'Admin'@'localhost';
DROP USER if exists 'UtilizadorComum'@'localhost';

-- Criação do utilizador Admin com todos os privilégios e com a possibilidade de conceção de privilégios a terceiros
CREATE USER 'Admin'@'localhost'
IDENTIFIED BY 'Admin123';
GRANT all privileges on Grupo2.*
to 'Admin'@'localhost' WITH
GRANT OPTION;

-- Criação do utilizador UtilizadorComum
CREATE USER 'UtilizadorComum'@'localhost'
IDENTIFIED BY 'UtilizadorComum123';

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

-- Atribuição de privilégios à ao UtilizadorComum
GRANT INSERT, SELECT, UPDATE, DELETE ON grupo2.Cliente TO 'UtilizadorComum'@'localhost';
show grants for current_user ();


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

INSERT INTO Cliente (primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values ('Francisco', 'Jacinto', 'Rua das Flores', 'Torres Vedras', '2300-243', '2190761@my.ipleiria.pt');
INSERT INTO Cliente (primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values ('Gabriel', 'Miranda', 'Rua do Pinheiro', 'Torres Novas', '2560-300', '2190765@my.ipleiria.pt');
INSERT INTO Cliente (primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values ('João', 'Pedro', 'Rua D.Afonso Henriques', 'Leiria', '2400-243', '111111@my.ipleiria.pt');
INSERT INTO Cliente (primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values ('Joana', 'Liz', 'Rua do Pinheiro', 'Lisboa', '2000-300', '2222222@my.ipleiria.pt');

INSERT INTO TelefonesCliente (nrTelefone, idCliente) values (941111111, 1);
INSERT INTO TelefonesCliente (nrTelefone, idCliente) values (942222222, 2);
INSERT INTO TelefonesCliente (nrTelefone, idCliente) values (941111111, 3);
INSERT INTO TelefonesCliente (nrTelefone, idCliente) values (942222222, 4);

INSERT INTO Marca (nome) values ('Mercedes');
INSERT INTO Marca (nome) values ('BMW');
INSERT INTO Marca (nome) values ('Ford');
INSERT INTO Marca (nome) values ('Peugeot');

INSERT INTO Modelo (idMarca, nome) values (1, 'Classe A');
INSERT INTO Modelo (idMarca, nome) values (1, 'Classe C');
INSERT INTO Modelo (idMarca, nome) values (1, 'Classe E');
INSERT INTO Modelo (idMarca, nome) values (1, 'Classe S');

INSERT INTO Modelo (idMarca, nome) values (2, 'X1');
INSERT INTO Modelo (idMarca, nome) values (2, 'X3');
INSERT INTO Modelo (idMarca, nome) values (2, 'X5');

INSERT INTO Modelo (idMarca, nome) values (3, 'Mustang');

INSERT INTO Modelo (idMarca, nome) values (4, '206');
INSERT INTO Modelo (idMarca, nome) values (4, '106');
INSERT INTO Modelo (idMarca, nome) values (4, '308');

INSERT INTO Stand (nome, rua, localidade, cod_postal, email) values ('Stand1', 'Rua do Stand1', 'Leiria', '2400-255', 'stand1@my.ipleiria.pt');
INSERT INTO Stand (nome, rua, localidade, cod_postal, email) values ('Stand2', 'Rua do Stand2', 'Leiria', '2400-243', 'stand2@my.ipleiria.pt');
INSERT INTO Stand (nome, rua, localidade, cod_postal, email) values ('Stand3', 'Rua do Stand3', 'Leiria', '2400-200', 'stand3@my.ipleiria.pt');
INSERT INTO Stand (nome, rua, localidade, cod_postal, email) values ('Stand4', 'Rua do Stand4', 'Leiria', '2400-201', 'stand4@my.ipleiria.pt');

INSERT INTO TelefonesStand (nrTelefone, idStand) values (268111111, 1);
INSERT INTO TelefonesStand (nrTelefone, idStand) values (268222222, 2);
INSERT INTO TelefonesStand (nrTelefone, idStand) values (268333333, 3);
INSERT INTO TelefonesStand (nrTelefone, idStand) values (268444444, 4);

select * from Veiculo where idStand = 4;
-- Veiculos Stand 1 - ID (1, 2)
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (1, 1, '2020-01-20', 2500, 2020, 3000, '99-32-ZS', 10000, 400, 5, 'B', 100000);
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (1, 2, '2020-01-10', 3000, 2019, 2700, '22-32-IO', 45000, 325, 2, 'B', 125000);
-- Veiculos Stand 2 - ID (3, 4, 5 ,6)
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (2, 5, '2020-04-24', 2500, 2018, 2500, '91-22-PT', 50000, 200, 5, 'B', 80000);
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (2, 6, '2020-03-01', 3000, 2016, 2300, '43-54-MJ', 95000, 235, 5, 'B', 45000);
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (2, 7, '2020-02-02', 2300, 2014, 2600, '11-12-UU', 30000, 190, 5, 'B', 100000);
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (2, 8, '2019-12-28', 2300, 2020, 2800, '77-88-OI', 30000, 320, 5, 'B', 50000);
-- Veiculos Stand 3 - ID (7, 8)
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (3, 9, '2019-04-24', 2500, 2018, 2500, '16-23-PY', 50000, 200, 5, 'B', 80000);
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (3, 10, '2017-03-01', 3000, 2016, 2300, '41-78-OI', 95000, 235, 5, 'B', 45000);
-- Veiculos Stand 4 - ID (9)
INSERT INTO Veiculo (idStand, idModelo, dataRececao, peso, ano, cilindrada, matricula, nrQuilometros, potencia, lotacao, categoria, preco) values (4, 11, '2016-04-24', 2500, 2018, 2500, '13-55-LI', 50000, 200, 5, 'B', 80000);

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

-- Vendedor Stand 3 - ID's (7)
INSERT INTO Funcionario(idStand, dataAdmissao, primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values (3, '2013-06-07', 'Almeida', 'Lopes', 'Avenida Humberto Delgado', 'Leiria', '2401-010', 'almeidalopes@mail.com');
-- Limpador Stand 3 - ID's (8)
INSERT INTO Funcionario(idStand, dataAdmissao, primeiroNome, ultimoNome, rua, localidade, cod_postal, email) values (3, '2002-01-02', 'Luis', 'Santos', 'Rua da Seda', 'Leiria', '2401-012', 'luissantos@mail.com');


INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('971111111', 1);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('972222222', 2);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('973333333', 3);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('974444444', 4);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('975555555', 5);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('976666666', 6);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('977777777', 7);
INSERT INTO TelefonesFuncionario (nrTelefone, idFuncionario) values ('978888888', 8);

-- Vendedores Stand 1
INSERT INTO Vendedor (idVendedor) values (1);
INSERT INTO Vendedor (idVendedor) values (2);
-- Vendedor Stand 2
INSERT INTO Vendedor (idVendedor) values (5);
-- Vendedor Stand 3
INSERT INTO Vendedor (idVendedor) values (7);

-- Limpador Stand 1
INSERT INTO Limpador (idLimpador) values (3);
INSERT INTO Limpador (idLimpador) values (4);
-- Limpador Stand 2
INSERT INTO Limpador (idLimpador) values (6);
-- Limpador Stand 3
INSERT INTO Limpador (idLimpador) values (8);



-- Vistas
CREATE VIEW PrecoCarroID2 AS SELECT preco FROM Veiculo where idVeiculo = 2;
CREATE VIEW PrecoCarroID5 AS SELECT preco FROM Veiculo where idVeiculo = 5;
CREATE VIEW PrecoCarroID9 AS SELECT preco FROM Veiculo where idVeiculo = 9;
CREATE VIEW PrecoCarroID1 AS SELECT preco FROM Veiculo where idVeiculo = 1;

INSERT INTO Venda (idcliente, idvendedor, datavenda) values (1, 1, '2020-03-24');
INSERT INTO Venda (idcliente, idvendedor, datavenda) values (1, 1, '2020-03-24');
INSERT INTO Venda (idcliente, idvendedor, datavenda) values (2, 5, '2020-03-11');
INSERT INTO Venda (idcliente, idvendedor, datavenda) values (3, 2, '2020-02-10');

INSERT INTO VeiculosVenda (idVeiculo, idVenda, preco) values (2, 1, (select * from PrecoCarroID2));
INSERT INTO VeiculosVenda (idVeiculo, idVenda, preco) values (5, 2, (select * from PrecoCarroID5));
INSERT INTO VeiculosVenda (idVeiculo, idVenda, preco) values (9, 3, (select * from PrecoCarroID9));
INSERT INTO VeiculosVenda (idVeiculo, idVenda, preco) values (1, 4, (select * from PrecoCarroID1));

INSERT INTO Limpeza (idLimpador, idVeiculo, dataLimpeza) values (3, 1, '2020-03-22');
INSERT INTO Limpeza (idLimpador, idVeiculo, dataLimpeza) values (6, 3, '2020-03-22');
INSERT INTO Limpeza (idLimpador, idVeiculo, dataLimpeza) values (8, 8, '2020-03-22');
INSERT INTO Limpeza (idLimpador, idVeiculo, dataLimpeza) values (4, 2, '2020-03-22');


-- Selects para testes
select * from Venda;
select * from Vendedor;
select * from VeiculosVenda;
select * from veiculo;
select * from Marca;
select * from modelo;
select * from Limpador;
select * from limpeza;
use Grupo2;
select * from Cliente;


-- Quantidade de veiculos em cada Stand
select count(*) as "Quantidade de Veiculos do Stand 1" from Veiculo
where Veiculo.idStand = 1;
select count(*) as "Quantidade de Veiculos do Stand 1" from Veiculo
where Veiculo.idStand = 2;

-- Quantidade de veiculos em cada Stand filtrados por marca
select count(*) as "Quantidade de Veiculos da Marca BMW do Stand 2" from Veiculo
inner join Modelo
on Veiculo.idModelo = Modelo.idModelo
inner join Marca
on Modelo.idMarca = Marca.idMarca
where Marca.nome = 'BMW' and Veiculo.idStand = 2;

-- Valor total em euros de todos os veiculos em cada Stand
select Stand.nome as "Nome do Stand", Concat(sum(Veiculo.preco), ' €' ) as "Valor total dos veiculos em cada Stand" from Veiculo
inner join stand
on Veiculo.idStand = Stand.idStand where Stand.idStand = 1
UNION select  Stand.nome, Concat(sum(Veiculo.preco), ' €' )  from Veiculo
inner join stand
on Veiculo.idStand = Stand.idStand where Stand.idStand = 2
UNION select  Stand.nome, Concat(sum(Veiculo.preco), ' €' )  from Veiculo
inner join stand
on Veiculo.idStand = Stand.idStand where Stand.idStand = 3
UNION select  Stand.nome, Concat(sum(Veiculo.preco), ' €' )  from Veiculo
inner join stand
on Veiculo.idStand = Stand.idStand where Stand.idStand = 4;

-- Detalhes sobre as vendas do Stand 2
select Funcionario.primeiroNome as "Nome Vendedor", TIMESTAMPDIFF(DAY, Veiculo.dataRececao, Venda.dataVenda) as "Dias em que o carro teve no Stand até à data da venda",
       VeiculosVenda.preco as "Preco Venda", Venda.dataVenda as "Data Venda", Cliente.primeiroNome as 'Primeiro Nome do Cliente',
       Cliente.ultimoNome as "Último Nome do Cliente ", TelefonesCliente.nrTelefone as "Nº Telefone", Marca.nome as "Marca", Modelo.nome as "Modelo", Veiculo.matricula as "Matrícula"
from Funcionario
inner join Vendedor
on Funcionario.idFuncionario = Vendedor.idVendedor
inner join Venda
on Vendedor.idVendedor = Venda.idVendedor
inner join Cliente
on Venda.idCliente = Cliente.idCliente
inner join TelefonesCliente
on Cliente.idCliente = TelefonesCliente.idCliente
inner join VeiculosVenda
on Venda.idVenda = VeiculosVenda.idVenda
inner join Veiculo
on VeiculosVenda.idVeiculo = Veiculo.idVeiculo
inner join Modelo
on Veiculo.idModelo = Modelo.idModelo
inner join Marca
on Modelo.idMarca = Marca.idMarca
where Veiculo.idStand = 2;

-- Detalhes sobre Limpeza dos carros do Stand 2
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
on Modelo.idMarca = Marca.idMarca
where Funcionario.idStand = 2;

-- Mostrar veiculos que estão no Stand 2 há mais de três meses
select Marca.nome as "Marca", Modelo.nome as "Modelo", Veiculo.matricula as "Matricula", Veiculo.dataRececao as "Data Receção Veículo" from Marca
inner join Modelo
on Marca.idMarca = Modelo.idMarca
inner join Veiculo
on Modelo.idModelo = Veiculo.idModelo
where TIMESTAMPDIFF(Month, Veiculo.dataRececao, NOW()) > 3 and Veiculo.idStand = 2;

-- Vendedores com mais carros vendidos por venda do Stand 1
select Venda.idVenda as "ID Venda", Vendedor.idVendedor as "ID Vendedor", Funcionario.primeiroNome as "Primeiro Nome Vendedor", Funcionario.ultimoNome as "Ultimo Nome Vendedor",
       Count(Vendedor.idVendedor) as "Quantidade de Carros na venda"
from Venda
inner join Vendedor
on Venda.idVendedor = Vendedor.idVendedor
inner join Funcionario
on Vendedor.idVendedor = Funcionario.idFuncionario
where Funcionario.idStand = 1
group by Vendedor.idVendedor
order by "Quantidade de Carros na venda" desc ;

-- Vendedores do Stand 3 que não teem vendas
select Vendedor.idVendedor as "ID Vendedor", Funcionario.primeiroNome as "Primeiro Nome Funcionário", Funcionario.ultimoNome as "Último Nome Funcionário" from Vendedor
inner join Funcionario
on Vendedor.idVendedor = Funcionario.idFuncionario
left join Venda
on Vendedor.idVendedor = Venda.idVendedor
where Venda.idVenda is null and Funcionario.idStand = 3;

-- Vendedores Stand 3
select Vendedor.idVendedor as "ID Vendedor", Funcionario.primeiroNome as "Primeiro Nome Funcionário", Funcionario.ultimoNome as "Último Nome Funcionário" from Vendedor
inner join Funcionario
on Vendedor.idVendedor = Funcionario.idFuncionario
inner join Stand
on Funcionario.idStand = Stand.idStand
where Stand.idStand = 3;

-- Clientes que não compraram nada
Select Cliente.primeiroNome as "Primeiro Nome Cliente", Cliente.ultimoNome as "Último Nome Cliente" from Cliente
left join Venda
on Cliente.idCliente = Venda.idCliente
where Venda.idVenda is null;

-- Veiculos do Stand 2 que não foram limpos
select Marca.nome as "Marca", Modelo.nome as "Modelo", Veiculo.matricula as "Matrícula", Veiculo.dataRececao as "Data em que o carro chegou ao Stand" from Veiculo
left join limpeza
on Veiculo.idVeiculo = Limpeza.idVeiculo
inner join Modelo
on Veiculo.idModelo = Modelo.idModelo
inner join Marca
on Modelo.idMarca = Marca.idMarca
where Limpeza.idLimpeza is null and Veiculo.idStand = 2;





