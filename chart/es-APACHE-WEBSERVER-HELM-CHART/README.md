# Apache Webserver Helm Chart

Questo Helm Chart distribuisce un web server **Apache** su un cluster Kubernetes. 
Il chart è progettato per l'esposizione tramite **Ingress (NGINX)** e la configurazione automatica per permettere il funzionamento dell'applicazione in **HTTPS**.

## Requisiti

- Cluster
- Helm 3.x
- Nginx Ingress Controller
- kubectl

## Installazione

## STEP 1 - Generazione dei certificati e creazione del Secret

Spostati nella cartella del progetto, i certificati vengono generati localmente sul tuo PC, poi caricati nel cluster come Secret.

```
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt \
  -subj "/CN=apache.esk8s.com/O=ApacheTest"
```

## STEP 2 - Creazione del Secret

Esegui questo comando per la creazione del Secret:

```
   kubectl create secret tls apache-tls-secret --cert=./tls.crt --key=./tls.key -n default
```

## STEP 3 - Helm Chart

Posizionati nella directory del chart ed esegui:

```
   helm install apache .
```

## STEP 4 - DNS

Il chart è configurato per rispondere al dominio ```apache.esk8s.com```, il browser non saprà come raggiungerlo, quindi devi mappare localmente questo dominio.

Essendo costruito per funzionare con Minikube e Nginx Ingress Controller, esegui questi comandi:

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```
```
helm repo update
```

Per installare Nginx Ingress Controller, esegui questo comando:

```
helm install ingress-nginx ingress-nginx/ingress-nginx \
--create-namespace \
--namespace ingress-nginx \
--set controller.service.type=LoadBalancer
``` 

Per associare un IP, aprire un nuovo terminale e lanciare il comando:

```
minikube tunnel
```

Per recuperare l'IP assegnato: 

```
kubectl get svc -n ingress-nginx
```

Nella colonna **EXTERNAL-IP** copiare l'IP associato a **ingress-nginx-controller**.

Eseguire:

```
   sudo vim /etc/hosts
```

E inserire nel file:

```
   <IP_ADDRESS> apache.esk8s.com
```

## STEP 5 - Verifica

Tramite browser andare all'indirizzo **https://apache.esk8s.com/** e verrà visualizzata la scritta **"It works!"**.

