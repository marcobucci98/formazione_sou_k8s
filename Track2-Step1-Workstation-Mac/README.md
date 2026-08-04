# WORKSTATION MAC ROCKY LINUX 9

## INTRODUZIONE

Il seguente progetto, configura una macchina virtuale Rocky Linux 9 totalmente automatizzata, vengono sfruttati due file:

**Vagrantfile** per la configurazione iniziale della virtual machine, con la definizione dei parametri di base, con installazione di Ansible.

Viene copiato il playbook nella VM per fare poi l'esecuzione.

Vengono concessi i permessi di root per fare le verifiche di creazione dei container. 

**container.yml** playbook per l'installazione di Docker e l'avvio dei container per l'utilizzo di Jenkins.

## AVVIO 

1. Scaricare la cartella del progetto. 
2. Spostarsi nella cartella del `Vagrantfile`.
3. Lanciare il comando `vagrant up` per l'avvio della macchina virtuale.
4. Una volta completato il setup iniziale, la macchina lancerà il comando `ansible-playbook /home/vagrant/container.yml` per l'esecuzione del playbook. 
5. Per lo step Jenkins, andare all'indirizzo `http://192.168.56:8080`, e incollare la password che viene stampata a schermo durante l'esecuzione del playbook, per accedere alla configurazione dell'utente Jenkins. 

Per la verifica della creazione dei container:
1. `sudo su -` per diventare ROOT.
2. `docker ps` per visualizzare i container attivi.
