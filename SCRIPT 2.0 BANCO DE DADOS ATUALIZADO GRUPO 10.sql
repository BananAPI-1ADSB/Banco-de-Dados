create database BANANAPI;
use BANANAPI;

create table empresa (
idEmpresa int primary key auto_increment,
nome varchar(100) not null,
CNPJ char(14) not null,
dataCadastro datetime default current_timestamp );

create table usuario (
idUsuario int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
senha varchar(250) not null,
fkEmpresa int,
foreign key (fkEmpresa) references empresa(idEmpresa) );

create table entreposto (
idEntreposto int primary key auto_increment,
nome varchar(100) not null, 
dataCadastro datetime default current_timestamp,
fkEmpresa int,
foreign key (fkEmpresa) references empresa (idEmpresa) ) auto_increment = 100;

create table endereco (
idEndereco int primary key auto_increment,
CEP varchar(10) not null,
Rua varchar(45) not null,
Bairro varchar(45) not null,
numero varchar(10) not null,
complemento varchar(45),
cidade varchar(45) not null,
siglaEstado char(2) not null,
fkEmpresa int,
fkEntreposto int,
foreign key (fkEmpresa) references empresa(idEmpresa),
foreign key (fkEntreposto) references entreposto(idEntreposto) );

create table camara (
idCamara int primary key auto_increment,
nome varchar(50) not null,
tipo varchar(50) not null,
fkEntreposto int,
foreign key (fkEntreposto) references entreposto(idEntreposto) );

create table sensor (
idSensor int primary key auto_increment,
modelo varchar(50),
status varchar(20),
pontoDeReferencia varchar(45),
fkCamara int,
foreign key (fkCamara) references camara(idCamara) );

create table leitura (
idLeitura int auto_increment,
temperatura decimal (5,2) not null,
dataHora datetime default current_timestamp not null,
fkSensor int,
primary key (idLeitura, fkSensor) );

create table alerta (
idAlerta int, 
mensagem varchar(250),
dataHora datetime default current_timestamp,
fkLeitura int,
primary key (idAlerta, fkLeitura) );

INSERT INTO empresa (nome, CNPJ) VALUES 
('Banana Tech Soluções', '12345678000199');

INSERT INTO usuario (nome, email, senha, fkEmpresa) VALUES 
('João Silva', 'joao.silva@bananapi.com', 'senha123', 1);

INSERT INTO entreposto (nome, fkEmpresa) VALUES 
('Entreposto Central SP', 1);

INSERT INTO endereco (CEP, Rua, Bairro, numero, cidade, siglaEstado, fkEntreposto) VALUES 
('01001-000', 'Av. Paulista', 'Bela Vista', '1000', 'São Paulo', 'SP', 100);

INSERT INTO camara (nome, tipo, fkEntreposto) VALUES 
('Câmara Fria 01', 'Congelamento', 100);

INSERT INTO sensor (modelo, status, pontoDeReferencia, fkCamara) VALUES 
('DHT22-B', 'Ativo', 'Canto Superior Direito', 1);

INSERT INTO leitura (idLeitura, temperatura, fkSensor) VALUES 
(1, -15.50, 1),
(2, -15.80, 1);

INSERT INTO alerta (idAlerta, mensagem, fkLeitura) VALUES 
(1, 'Temperatura crítica detectada', 1);

------------------------------------------------------------------------------

SELECT 
    e.nome AS Empresa,
    ent.nome AS Entreposto,
    c.nome AS Camara,
    s.modelo AS Sensor,
    l.temperatura,
    l.dataHora AS Momento_Leitura
FROM empresa AS e
JOIN entreposto AS ent ON e.idEmpresa = ent.fkEmpresa
JOIN camara AS c ON ent.idEntreposto = c.fkEntreposto
JOIN sensor AS s ON c.idCamara = s.fkCamara
JOIN leitura AS l ON s.idSensor = l.fkSensor; -- SELECT 1 COM MUITOS JOINS 

------------------------------------------------------------------------------

SELECT 
    e.nome AS Empresa,
    ent.nome AS Entreposto,
    end.cidade,
    end.siglaEstado,
    c.nome AS Camara
FROM empresa AS e
LEFT JOIN entreposto AS ent ON e.idEmpresa = ent.fkEmpresa
LEFT JOIN endereco AS end ON ent.idEntreposto = end.fkEntreposto
LEFT JOIN camara AS c ON ent.idEntreposto = c.fkEntreposto; -- SELECT 2 COM LEFT JOIN

-- -----------------------------------------------------------------------

SELECT 
    u.nome AS Funcionario,
    u.email,
    e.nome AS Empresa_Trabalho,
    e.CNPJ
FROM usuario AS u
JOIN empresa AS e ON u.fkEmpresa = e.idEmpresa; -- SELECT 3 COM JOIN SIMPLES

-- -------------------------------------------------------------------------

SELECT 
    c.nome AS Camara,
    s.idSensor,
    s.modelo,
    s.status,
    l.temperatura,
    l.dataHora
FROM leitura AS l
RIGHT JOIN sensor AS s ON l.fkSensor = s.idSensor
JOIN camara AS c ON s.fkCamara = c.idCamara; -- SELECT 4 COM RIGHT JOIN

-- --------------------------------------------------------------------------





