# Puppet Collector Setup (LINUX)
Assistente de instalação - Puppet Collector para Linux<br>
Configurando sua máquina para rodar o Puppet Collector.

<h3>Manual de aquisição e execução</h3>
Passo 01<br>
Crie uma EC2 com protocolos de segurança SSH e RDP na AWS.<br><br>
Passo 02<br>
Execute localmente o comando abaixo para poder acessar a EC2 com GUI:<br>
>>> sudo apt install rdesktop<br>
Em seguida, crie um diretório e guarde nele a chave SSH da AWS.<br><br>
Passo 03<br>
Abra o diretório no terminal e execute:<br>
>>> sudo chmod 400 "suaChaveAWS.file" (Obs: "suaChaveAWS.file" é a sua chave gerada pela AWS.)<br><br>
Passo 04<br>
Se conecte à EC2 via protocolo SSH e em seguida execute os comandos:<br>
>>> sudo su<br>
>>> cd<br><br>
Passo 05<br>
Baixe o Puppet Collector Setup e o script MySQL<br>
>>> wget -O PuppetCollector-setup.sh https://raw.githubusercontent.com/gustavocomartins/assistente-instalacao-puppet-collector/main/PuppetCollector-setup.sh<br>
>>> wget -O tables.sql https://raw.githubusercontent.com/gustavocomartins/assistente-instalacao-puppet-collector/main/tables.sql<br><br>
Passo 06<br>
Entrar no terminal e executar o assistente<br>
>>> sudo chmod +x PuppetCollector-setup.sh <br>
>>> ./PuppetCollector-setup.sh <br><br>
Passo 07<br>
Copie o IP publico da sua EC2 na AWS e execute o comando:<br>
>>> rdesktop -u urubu100 -g 85% -PKD "ip_publico_ec2"<br>
OBS: troque "ip_publico_ec2" pelo seu IP copiado.

<h1>Pronto!</h1>
