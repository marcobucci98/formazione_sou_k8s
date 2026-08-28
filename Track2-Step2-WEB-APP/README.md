# WEB-APP

## INTRODUZIONE

Il progetto ha lo scopo di effettuare il build e il push di un'immagine Docker, con tag in uno specifico formato e il push in una specifica repository, usando gli strumenti sviluppati nello Step 1.

## VAGRANTFILE

Sono state aggiunte le istruzioni: 

`config.vm.provision "file", source: "./Dockerfile", destination: "/home/vagrant/Dockerfile"` e 

`config.vm.provision "file", source: "./app.py", destination: "/home/vagrant/app.py"` per la condivisione dei file necessari alla build dell'immagine.

## container.yml

Il playbook è stato modificato per supportare il meccanismo Docker-out-of-Docker (DooD), per permettere al container di eseguire comandi Docker tramite l'host.

`/var/run/docker.sock:/var/run/docker.sock`

`/usr/bin/docker:/usr/bin/docker`

`/home/vagrant:/home/vagrant`

## CONFIGURAZIONE DI JENKINS, JENKINS-AGENT E JENKINSFILE

Per accedere all'interfaccia di Jenkins: 

Accedere all'indirizzo `http://192.168.56.10:8080` tramite browser.

Recuperare la password che viene stampata durante l'esecuzione del playbook per accedere alla creazione dell'utente. 

### Configurazione jenkins-agent

Una volta configurato l'utente, passiamo alla configurazione dell'agent:

Nome agent: `jenkins-agent`.

Selezionare `Agente permanente`.

Remote root directory: `/home/jenkins/agent`.

Etichette : `jenkins-agent`

Modalità d'uso: `Usa questo nodo il più possibile`.

Metodo di avvio: `Avvia l'agente facendolo connettere al master`.

Disponibilità: `Mantieni questo agente online il più possibile`.

Salvare le modifiche ed entrare nel setup dell'agent appena creato, e copiare la chiave che viene stampata **-secret ...**.

Incollare la chiave nella variabile **jenkins_agent_secret** del playbook, salvare e lanciare il comando `vagrant provision`, una volta terminata l'esecuzione, aggiornare la pagina e l'agent sarà collegato e pronto per essere utilizzato.

### JENKINSFILE

Per la configurazione del Jenkinsfile:

Selezionare **Nuovo Elemento** -> **Pipeline** -> **Pipeline script from SCM**

SCM: **GIT**

URL REPOSITORY: **https://github.com/marcobucci98/formazione_sou_k8s.git**

Ramo: **main**

Script Path: **Track2-Step2-WEB-APP/Jenkinsfile**

Il Jenkinsfile è stato strutturato per permettere di eseguire lo script di build e push di un'immagine su Docker Hub tramite l'agent **jenkins-agent** :  

Il push viene strutturato come segue: 

• se lo script viene scaricato tramite il branch **main**, il tag sarà **latest**.

• se lo script viene scaricato tramite il branch **develop**, il tag sarà **develop** con l'aggiunta del identificativo del commit.

• se lo script viene scaricato tramite **tag**, il tag su Docker Hub corrisponderà al tag Github.

La forma finale sarà : **NOME_UTENTE/flask-app-example-build:TAG**.

**NOTA**: La pipeline fallirà l'esecuzione se non verranno impostate le credenziali per Docker Hub.

## DOCKERFILE

Il Dockerfile viene strutturato per utilizzare un'immagine **alpine** per supportare la web-app.

Viene impostata la cartella di lavoro, installazione di flask necessario per la web-app, copia del codice python **app.py** nella cartella di lavoro, esposizione della porta 5000 per la visualizzazione dell'applicazione tramite browser e i comandi necessari all'avviamento.

## AVVIO

Scaricare la cartella, e spostarsi nella cartella del progetto.

Utilizzare il comando `vagrant up`, il playbook verrà eseguito automaticamente.

Una volta completata l'esecuzione del Jenkinsfile:

Utilizzare `vagrant ssh` per accedere alla macchina virtuale.

Utilizzare `sudo su -` per accedere come amministratore.

Lanciare il comando `docker run -d -p 5000:5000 --name app-cont marcobuccidev/flask-app-example-build:latest`

Inserire l'indirizzo `http://192.168.56.10:5000` per visualizzare la web-app.

Indirizzo DockerHub: https://hub.docker.com/repositories/marcobuccidev