
DROP DATABASE IF EXISTS PowerTechSolutions;

CREATE DATABASE IF NOT EXISTS PowerTechSolutions;

USE PowerTechSolutions;

-- Criação das tabelas 

CREATE TABLE IF NOT EXISTS Grupo_Empresa(
	IDGrupo_Empresa INT PRIMARY KEY AUTO_INCREMENT,
    Apelido_Interno_Grupo VARCHAR(100),
    Razao_social VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Unidade_de_negocio(
	IDUnidade INT PRIMARY KEY AUTO_INCREMENT,
    Cnpj CHAR(14),
    Apelido_interno VARCHAR(100),
	Nome_Fantasia VARCHAR(100),
    FKGrupo_empresa INT,
		CONSTRAINT FKGrupo_Com_Unidade FOREIGN KEY (FKGrupo_empresa)
			REFERENCES Grupo_Empresa(IDGrupo_Empresa)
);

CREATE TABLE IF NOT EXISTS Endereco_Unidade(
	IDEndereco_unidade INT PRIMARY KEY AUTO_INCREMENT,
    Cep VARCHAR(8),
    Logradouro VARCHAR(100),
    Bairro VARCHAR(100),
    Localidade VARCHAR(100),
    UF CHAR(2),
    FKUnidade_negocio INT,
		CONSTRAINT FKUnidade_Endereco FOREIGN KEY (FKUnidade_negocio)
			REFERENCES Unidade_de_negocio(IDUnidade)
);

CREATE TABLE IF NOT EXISTS Permissoes(
	IDPermissao INT PRIMARY KEY AUTO_INCREMENT,
    Visualizar TINYINT,
    Editar TINYINT,
    Cadastrar TINYINT,
    Deletar TINYINT
);

CREATE TABLE IF NOT EXISTS Nivel_acesso(
	IDNivel_acesso INT AUTO_INCREMENT,
    Apelido VARCHAR(60),
	FKPermissao INT,
		CONSTRAINT FKNivel_Permissao FOREIGN KEY (FKPermissao)
			REFERENCES Permissoes(IDPermissao),
		CONSTRAINT PKNivel_permissao PRIMARY KEY (IDNivel_acesso,FKPermissao)
);

CREATE TABLE IF NOT EXISTS Usuario_Dashboard(
	IDUsuario INT AUTO_INCREMENT,
	Nome VARCHAR(150),
    Email VARCHAR(150),
    Cpf CHAR(11),
    Senha CHAR(8),
    FKUnidade INT,
    FKNivel_acesso INT,
		CONSTRAINT FKUnidade_Usuario FOREIGN KEY (FKUnidade)
			REFERENCES Unidade_de_negocio(IDUnidade),
		CONSTRAINT FKNivel_Usuario FOREIGN KEY (FKNivel_acesso)
			REFERENCES Nivel_acesso(IDNivel_acesso),
		CONSTRAINT PKUsuario_Nivel_acesso PRIMARY KEY (IDUsuario,FKNivel_acesso)
);

CREATE TABLE IF NOT EXISTS Tipo_maquina(
	IDTipo INT PRIMARY KEY AUTO_INCREMENT,
    Apelido VARCHAR(80)
);

CREATE TABLE IF NOT EXISTS Maquinas(
	IDMaquina INT PRIMARY KEY AUTO_INCREMENT,
    Apelido VARCHAR(100),
    FKFuncionario INT,
		CONSTRAINT FKFuncionario_maquina FOREIGN KEY (FKFuncionario)
			REFERENCES Usuario_Dashboard(IDUsuario),
	FKTipo_maquina INT,
		CONSTRAINT FKTipo_maquina FOREIGN KEY (FKTipo_maquina)
			REFERENCES Tipo_maquina(IDTipo)
);

-- novo tabela da Kaori

CREATE TABLE IF NOT EXISTS Tempo_de_Execucao(
	IDTempo INT PRIMARY KEY AUTO_INCREMENT,
    Data_Hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    Total_captura time, 
	FKTempo_maquina INT,
		CONSTRAINT FKTempo_maquina FOREIGN KEY (FKTempo_maquina)
			REFERENCES Maquinas(IDMaquina)
);
-- termina aqui

CREATE TABLE IF NOT EXISTS Redes_conectadas(
	IDConexao INT PRIMARY KEY AUTO_INCREMENT,
    Data_Hora_Conexao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Servidor_DNS VARCHAR(45),
    FKMaquina INT,
		CONSTRAINT FKMaquina_Rede FOREIGN KEY (FKMaquina)
			REFERENCES Maquinas(IDMaquina)
);

CREATE TABLE IF NOT EXISTS Janelas_Abertas(
	IDRegistro INT PRIMARY KEY AUTO_INCREMENT,
    IDJanela INT,
    PIDJanelas INT,
    Nome_Janelas VARCHAR(500),
	Data_Hora_Conexao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FKMaquina INT,
		CONSTRAINT FKMaquina_Janelas FOREIGN KEY (FKMaquina)
			REFERENCES Maquinas(IDMaquina)
);

CREATE TABLE IF NOT EXISTS Dispositivos_USB(
	IDRegistro INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Dispositivo VARCHAR(300),
    Data_Hora_Conexao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FKMaquina INT,
		CONSTRAINT FKMaquina_Usb FOREIGN KEY (FKMaquina)
			REFERENCES Maquinas(IDMaquina)
);

CREATE TABLE IF NOT EXISTS Tipo_componente(
	IDTipo INT PRIMARY KEY AUTO_INCREMENT,
    Apelido VARCHAR(80)
);

CREATE TABLE IF NOT EXISTS Componentes_maquina(
	IDComponente INT PRIMARY KEY AUTO_INCREMENT,
    Apelido VARCHAR(100),
    FKMaquina INT,
		CONSTRAINT FKMaquina_Componente FOREIGN KEY (FKMaquina)
			REFERENCES Maquinas(IDMaquina),
	FKTipo_componente INT,
		CONSTRAINT FKTipo_Componente FOREIGN KEY (FKTipo_componente)
			REFERENCES Tipo_componente(IDTipo)
);

CREATE TABLE IF NOT EXISTS Parametros_componente(
	IDParametro INT PRIMARY KEY AUTO_INCREMENT,
    Parametro DOUBLE,
    FKComponente INT,
		CONSTRAINT FKComponente_Parametro FOREIGN KEY (FKComponente)
			REFERENCES Componentes_maquina(IDComponente)
);

CREATE TABLE IF NOT EXISTS Componentes_cadastrados(
	IDComponente_cadastrado INT PRIMARY KEY AUTO_INCREMENT,
    Apelido VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Componentes_monitorados(
	IDComponente_monitorado INT AUTO_INCREMENT,
    FKComponente_cadastrado INT,
    FKMaquina INT,
		CONSTRAINT FKCompoenente_C_Componente_M FOREIGN KEY (FKComponente_cadastrado)
			REFERENCES Componentes_cadastrados(IDComponente_cadastrado),
		CONSTRAINT FKMaquina_Componente_M FOREIGN KEY (FKMaquina)
			REFERENCES Maquinas(IDMaquina),
		CONSTRAINT PKComponente_C_Componente_M PRIMARY KEY (IDComponente_monitorado,FKComponente_cadastrado)
);

CREATE TABLE IF NOT EXISTS Monitoramento_RAW(
	IDMonitoramento INT PRIMARY KEY AUTO_INCREMENT,
    Data_Hora_Captura DATETIME DEFAULT CURRENT_TIMESTAMP,
    Total DOUBLE,
    Free Double, 
    Uso Double, 
    Porcentagem Double,
    FKComponente_Monitorado INT,
		CONSTRAINT FKMonitoramento_RAW_Componente_maquina FOREIGN KEY (FKComponente_Monitorado)
			REFERENCES Componentes_monitorados(IDComponente_monitorado)
);

CREATE TABLE IF NOT EXISTS Monitoramento_Trusted(
	IDMonitoramento INT PRIMARY KEY,
    Data_Hora_Captura DATETIME DEFAULT CURRENT_TIMESTAMP,
    Dado_Capturado VARCHAR(30),
    FKComponente_Monitorado INT,
    CONSTRAINT FKMonitoramento_TRUSTED_Componente_maquina FOREIGN KEY (FKComponente_Monitorado)
			REFERENCES Componentes_monitorados(IDComponente_monitorado)
);

CREATE TABLE IF NOT EXISTS Nivel_alerta(
	IDNivel_alerta INT PRIMARY KEY AUTO_INCREMENT,
    Nivel VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Alertas(
	IDAlerta INT PRIMARY KEY AUTO_INCREMENT,
    Alerta VARCHAR(100),
    Data_Hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    FKMonitoramento INT,
    FKNivel_alerta INT,
    FKUnidade_negocio INT,
		CONSTRAINT FKMonitoramento_alerta FOREIGN KEY (FKMonitoramento)
			REFERENCES Monitoramento_Trusted(IDMonitoramento),
		CONSTRAINT FKNivel_alerta FOREIGN KEY (FKNivel_alerta)
			REFERENCES Nivel_alerta(IDNivel_alerta),
		CONSTRAINT FKUnidade_negocio_alerta FOREIGN KEY (FKUnidade_negocio)
			REFERENCES Unidade_de_negocio(IDUnidade)
);
	

CREATE TABLE IF NOT EXISTS Processos (
id_proc INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(80),
tempo_user DOUBLE,
dthora_captura DATETIME,
produtividade_maquina VARCHAR(90),
fkmaquina_processo INT,
FOREIGN KEY (fkmaquina_processo) REFERENCES Maquinas(IDMaquina)
);
    

-- Aréa de inserts para testes de funcionalidade 

SELECT IDMaquina FROM Maquinas WHERE FKFuncionario = 1;

INSERT INTO Grupo_Empresa VALUES
(null,'EDP Smart','EDP ENERGIAS DO BRASIL S.A.'),
(null,'Matrix','Matrix Comercio e Servicos LTDA'),
(null,'AES Tietê','AES TIETE INTEGRA SOLUCOES EM ENERGIA LTDA.');

INSERT INTO Unidade_de_negocio VALUES
(null,'28630316000186','EDP Smart Sede','EDP Energias do Brasil',1),
(null,'28630316000286','EDP Smart Faria Lima','EDP Energias do Brasil',1),
(null,'28630316000386','EDP Smart Suzano','EDP Energias do Brasil',1),
(null,'01564634000130','Matrix Sede','Matrix',2),
(null,'01564634000230','Matrix Mogi das Cruzes','Matrix',2),
(null,'26203837000121','AES Tiete Sede','AES TIETE INTEGRA',3);

INSERT INTO Permissoes VALUES
(NULL,1,1,1,1),
(NULL,1,0,0,0);

INSERT INTO Nivel_acesso VALUES
(NULL,'Eng NOC',1),
(NULL,'Gestor',2);

INSERT into Usuario_Dashboard VALUES
(NULL,'davi','davi@teste.com','48372073830','12345678',1,1),
(NULL,'henry','henry@teste.com','12345678910','87654321',1,2);

INSERT into Usuario_Dashboard VALUES
(NULL,'gabriella','gabi@teste.com','10987654321','18080226',1,2);


INSERT INTO Componentes_cadastrados values
(null,'CPU'),
(null,'RAM'),
(null,'DISCO'),
(null,'REDE'),
(null,'JANELAS'),
(null,'USB');


INSERT INTO Nivel_alerta (nivel) VALUES 
("Atenção"),
("Perigo"),
("Critico");

INSERT INTO Tipo_maquina VALUES
(null,"FISICA"),
(null,"VIRTUAL");

INSERT INTO Maquinas VALUES
(null,'teste01',1,2),
(null,'teste02',1,1),
(null,'teste03',1,1);

INSERT INTO Maquinas VALUES 
(NULL,'maquina1_setorA',3,1),
(NULL,'maquina2_setorA',3,1);

INSERT INTO Componentes_monitorados VALUES
(NULL,1,1),
(NULL,2,1),
(NULL,3,1),
(NULL,4,1),
(NULL,5,1),
(NULL,6,1),
(NULL,1,2),
(NULL,2,2),
(NULL,3,2),
(NULL,4,3),
(NULL,5,3),
(NULL,6,3);

select * from processos;