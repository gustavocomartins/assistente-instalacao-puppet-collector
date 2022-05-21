use puppetCollectorBackup;

create table dadosColetados(
id int primary key auto_increment,
fkMaquinaVirtual int,
usoDisco double,
usoRAM double,
usoProcessador double,
datahora datetime
)auto_increment = 1;

create table controleDeAcesso(
id int primary key auto_increment,
fkUsuario int,
fkmaquinaVirtual int,
dataHora datetime
)auto_increment = 1;

create table alertas(
id int primary key  auto_increment,
fkDadosColetados int not null,
dataHora datetime,
descricao varchar(255),
categoria varchar(10)
)auto_increment = 1;
