# Puppet Collector Setup (LINUX)
Assistente de instalação - Puppet Collector para Linux<br>
Configurando sua máquina para rodar o Puppet Collector.

<h3>Manual de aquisição e execução</h3>
Passo 01<br>
Crie uma EC2 com protocolos de segurança SSH e RDP na AWS.<br><br>
Passo 02<br>
Localmente, crie um diretório e guarde nele a chave SSH da AWS.<br><br>
Passo 03<br>
Abra o diretório no terminal e execute:<br>
>>> sudo chmod 400 "suaChaveAWS.file" (Obs: "suaChaveAWS.file" é a sua chave gerada pela AWS.)<br><br>
Passo 04<br>
Se conecte à EC2 via protocolo SSH e em seguida execute os comandos:<br>
>>> cd /home/seuUsuario/Desktop (Obs: "seuUsuario" é o seu user linux.)<br><br>
Passo 05<br>
Baixe o Puppet Collector Setup<br>
>>> wget -O PuppetCollector-setup.sh https://github.com/gustavocomartins/assistente-instalacao-puppet-collector.git<br><br>
Passo 06<br>
Entrar no diretório via terminal e executar o assistente<br>
>>> cd assistente-instalacao-puppet-collector.git <br>
>>> sudo chmod +x PuppetCollector-setup.sh <br>
>>> ./PuppetCollector-setup.sh <br>

<h1>Pronto!</h1>
