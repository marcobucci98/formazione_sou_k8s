# Track 2 - Step 4 - Installazione Chart con Jenkins

L'esercizio prevede di configurare il cluster Kubernetes, con Jenkins, in modo tale che raggiunga il namespace "formazione-sou", e poi, scrivere una pipeline che installi il chart riposto sulla propria repository GitHub, sviluppato nello Step 3, ed effettui l'installazione sul namespace "formazione-sou".

---
## Preparazione ed Esecuzione 

Avviare Jenkins e creare l'agent ```cluster-agent```.

Impostare la pipeline seguendo queste indicazioni:

Definition: ```Pipeline script from SCM``` 

URL Repository: ```https://github.com/marcobucci98/formazione_sou_k8s.git```

Ramo: ```main``` 

Script Path: ```Track2-Step4-HELM-INSTALL/Jenkinsfile```

Per avviare il cluster.```minikube start -p nome_cluster```

Successivamente avviare la pipeline e installare Traefik (vedi Step 3), e lanciare il comando ```minikube tunnel -p nome_cluster``` in un nuovo terminale e lasciarlo in esecuzione.

Recuperare l'indirizzo ip: ```kubectl get ingress -n formazione-sou``` e applicarlo al file ```/etc/hosts``` con ```sudo vim /etc/hosts``` --> ```indirizzo_ip formazionesou.local```.

Aprire il browser e andare all'indirizzo ```formazionesou.local```.


