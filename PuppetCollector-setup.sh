#!/bin/bash

#-----------------------------------------------------------
#--ASCII ART HOME PROGRAM-----------------------------------
#-----------------------------------------------------------
home="
============================================================
||........................................................||
||...........___.._..._..___...___.._____.______..........||
||..........||..|.||..|.||..|.||..|.||......||............||
||..........||__|.||..|.||__|.||__|.||__....||............||
||..........||....||..|.||....||....||......||............||
||..........||....||__|.||....||....||___...||............||
||........................................................||
||...............C..O..L..L..E..C..T..O..R................||
||........................................................||
||................AUXILIAR.DE.CONFIGURAÇÃO................||
||........................................................||
============================================================"
echo "$home"

#-----------------------------------------------------------
#--INFORMATIVO PARA O CLIENTE-------------------------------
#-----------------------------------------------------------
descricaoI="
============================================================
||             Puppet Collector Setup Infos               ||
============================================================
||                                                        ||
|| NOME DO PROGRAMA: Puppet Collector Setup               ||
|| AUTOR: Puppet Server Monitoring                        ||
|| VERSAO: 1.0                                            ||
|| CONTATO: puppet.com.br/contato                         ||
|| DESCRICAO: Script que configura o ambiente para coleta.||
||                                                        ||
============================================================
|| >>> O que sera feito em sua maquina ?                  ||
============================================================
|| 01 - Configura a senha do user root.                   ||
|| 02 - Configura a senha do user default ubuntu.         ||
|| 03 - Cria um novo ADM user.                            ||
|| 04 - Atualiza e aprimora pacotes.                      ||
|| 05 - Instala protocolo RDP e a GUI XRDP.               ||
|| 06 - Instala Java 11.                                  ||
|| 07 - Instala Docker.                                   ||
|| 08 - Sobe Container MySQL.                             ||
|| 09 - Cria database local de backup de coletas.         ||
|| 10 - Instala o PuppetCollector                         ||
============================================================"
echo "$descricaoI"

#-----------------------------------------------------------
#--FUNCOES DO PROGRAMA--------------------------------------
#-----------------------------------------------------------
#CONFIGURAR USUARIOS
configurarRoot(){
	echo "============================================================"
	echo "|| >>> Configurando usuario ROOT                          ||"
	echo "============================================================"
	sleep 2
	sudo passwd root
	echo ">>> Ubuntu configurado com sucesso."
}

configurarUbuntu(){
	echo "============================================================"
	echo "|| >>> Configurando usuario Ubuntu                         ||"
	echo "============================================================"
	sleep 2
	sudo passwd ubuntu
	echo ">>> Ubuntu configurado com sucesso."
}

criarUrubu100User(){
	echo "============================================================"
	echo "|| >>> Criando usuario Urubu100                           ||"
	echo "============================================================"
	sleep 2
	sudo adduser urubu100
	mkdir /home/urubu100/setup
	usermod -aG sudo adm
	echo ">>> User adm criado com sucesso."
}
#-----------------------------------------------------------
#INSTALACOES
atualizarPacotes(){
	echo "============================================================"
	echo "|| >>> Atualizando pacotes...                             ||"
	echo "============================================================"
	sleep 2
	sudo apt update && sudo  apt upgrade -y
	echo ">>> Pacotes atualizados com sucesso."
}

instalarGUI(){
	echo "============================================================"
	echo "|| >>> Instalando RDP e RDESKTOP (Interface Grafica)      ||"
	echo "============================================================"
	sleep 2
	sudo apt-get install xrdp lxde-core lxde tigervnc-standalone-server -y
	sudo apt install rdesktop
	echo ">>> Protocolo RDP e RDesktop instalados com sucesso.\n"
}

instalarJava(){
	echo "============================================================"
	echo "|| >>> Instalando JAVA...                                 ||"
	echo "============================================================"
	sleep 2
	sudo apt-get install openjdk-11-jdk -y
}

instalarDocker(){
	echo "============================================================"
	echo "|| >>> Instalando e ativando Docker...                    ||"
	echo "============================================================"
	sleep 1
	sudo apt install docker.io -y
	sudo systemctl start docker
	sudo systemctl enable docker		
}
#-----------------------------------------------------------
#DOCKER E CONTAINER MYSQL
configurarContainerMySQL(){
	echo "============================================================"
	echo "|| >>> Instalando imagem MySQL e criando database local...||"
	echo "============================================================"
	sleep 1
	sudo docker pull mysql:latest		
	sudo docker create -p 3306:3306 --name collectorBackup -e "MYSQL_DATABASE=puppetCollectorBackup" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:latest
	sudo docker cp ./tables.sql collectorBackup:docker-entrypoint-initdb.d/tables.sql
	sudo docker start collectorBackup
	echo ">>> Conteiners MySQL:"
	echo "-------------------------------------------------"
	sudo docker images
	echo "-------------------------------------------------\n"
	echo "======================================"
	echo "|| CONTEINER: collectorBackup       ||"
	echo "|| DATABASE:  puppetCollectorBackup ||"
	echo "|| SENHA:     urubu100              ||"
	echo "======================================"
	echo "Guarde a senha do conteiner."
	sleep 5	
}

#-----------------------------------------------------------
#INSTALANDO O PUPPET COLLECTOR
instalarCollector(){
	echo "============================================================"
	echo "|| >>> Instalando Puppet Collector                        ||"
	echo "============================================================"
	cd /home/urubu100/setup
	wget -O PuppetColector.jar https://github.com/gustavocomartins/puppet-colector-exe/raw/main/Puppet%20Colector.jar
	chmod +x PuppetColector.jar
	echo ">>> Puppet Collector instalado com sucesso."
}

configurarTudo(){
	configurarRoot
	configurarUbuntu
	criarUrubu100User
	atualizarPacotes
	instalarGUI
	instalarJava
	instalarDocker
	configurarContainerMySQL
	instalarCollector
	echo ""
	echo "============================================================"	
	echo "||        SUA MAQUINA FOI CONFIGURADA COM SUCESSO         ||"	
	echo "============================================================"	
}
echo "Voce deseja continuar com a configuracao ? (s/n)"
read inst
if [ "$inst" == "s" ]
	then
	echo "Iniciando configuracao..."
	sleep 2
	configurarTudo
	else 
	if [ "$inst" == "n" ]
	        then
	        echo "Ok!"
	        else
	        echo "Parametro invalido."
	fi
fi
