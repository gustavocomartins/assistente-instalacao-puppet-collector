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
	echo ">>> Configuracao do usuario Root...\n"
	sleep 2
	sudo passwd root
	echo ">>> Ubuntu configurado com sucesso.\n"
}

configurarUbuntu(){
	echo ">>> Configuracao do usuario ubuntu...\n"
	sleep 2
	sudo passwd ubuntu
	echo ">>> Ubuntu configurado com sucesso.\n"
}

criarAdmUser(){
	echo ">>> Criando user adm com permissao de sudo...\n"
	sleep 2
	sudo adduser adm
	mkdir /home/adm/puppetSetup
	cd /home/adm/puppetSetup
	usermod -aG sudo adm
	echo ">>> User adm criado com sucesso.\n"
}
#-----------------------------------------------------------
#INSTALACOES
atualizarPacotes(){
	echo ">>> Atualizando os pacotes...\n"
	sleep 2
	sudo apt update && sudo  apt upgrade -y
	echo ">>> Pacotes atualizados com sucesso.\n"
}

instalarGUI(){
	echo ">>> Instalando protocolo RDP e Interface grafica...\n"
	sleep 2
	sudo apt-get install xrdp lxde-core lxde tigervnc-standalone-server -y
	echo ">>> Protocolo RDP e GUI instalados com sucesso.\n"
}

instalarJava(){
	[ ! -x $(which java) ] && sudo apt-get install openjdk-11-jdk
}

instalarDocker(){
	echo ">>> Instalando Docker...\n"
	sleep 1
	sudo apt install docker.io -y
	sudo system start docker
	sudo system enable docker		
}
#-----------------------------------------------------------
#DOCKER E CONTAINER MYSQL
configurarContainerMySQL(){
	echo ">>> Instalando imagem MySQL...\n"
	sleep 1		
	sudo docker create -d -p 3306:3306 --name collectorBackup -e "MYSQL_DATABASE=puppetCollectorBackup" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:latest
	sudo docker cp ./tables.sql collectorBackup:docker-entrypoint-initdb.d/tables.sql
	sudo docker start collectorBackup
	echo ">>> Conteiners MySQL:\n"
	echo "-------------------------------------------------"
	sudo docker images
	echo "-------------------------------------------------\n"
	echo "\n---------------------------------"
	echo "CONTEINER: collectorBackup       ||"
	echo "DATABASE:  puppetCollectorBackup ||"
	echo "SENHA:     urubu100              ||"
	echo "-----------------------------------"
	echo "\n>>>Guarde a senha do conteiner."
	sleep 5	
}

#-----------------------------------------------------------
#INSTALANDO O PUPPET COLLECTOR
instalarCollector(){
	echo ">>> Instalando o Puppet Collector...\n"
	wget -O PuppetColector.jar https://github.com/gustavocomartins/puppet-colector-exe/raw/main/Puppet%20Colector.jar
	echo ">>> Puppet Collector instalado com sucesso.\n"
}

configurarTudo(){
	configurarRoot
	configurarUbuntu
	criarAdmUser
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
