# HELM CHART PER WEB-APP

Questo Helm Chart distribuisce un la web-app "Hello World" su un cluster Kubernetes. 
Il chart è progettato per l'esposizione tramite **Traefik**.

## Requisiti

- Cluster
- Helm 3.x
- Traefik
- kubectl

## Installazione

Scaricare e spostarsi nella cartella dell'applicazione ed seguire gli step.

## STEP 1 - Helm Chart

Posizionati nella directory del chart ed esegui:

```
   helm install web-app .
```

Utilizzare i aseguenti comandi per installare le relative immagini:

```
   helm install web-app ./web-app/ --set image.tag="latest"
```

```
   helm install web-app ./web-app/ --set image.tag="develop-c4fc141"
```

```
   helm install web-app ./web-app/ --set image.tag="develop-1b855a9"
```

## STEP 2 - DNS

Il chart è configurato per rispondere al dominio ```formazionesou.local```, il browser non saprà come raggiungerlo, quindi devi mappare localmente questo dominio.

Essendo costruito per funzionare con Minikube e Traefik, esegui questi comandi:

```
helm repo add traefik https://traefik.github.io/charts
```
```
helm repo update
```

Per installare Traefik, esegui questo comando:

```
helm install traefik traefik/traefik --namespace traefik --create-namespace
``` 

Per associare un IP, aprire un nuovo terminale e lanciare il comando:

```
minikube tunnel
```

Per recuperare l'IP assegnato: 

```
kubectl get svc -n traefik
```

Nella colonna **EXTERNAL-IP** copiare l'IP associato a **traefik**.

Eseguire:

```
   sudo vim /etc/hosts
```

E inserire nel file:

```
   <IP_ADDRESS> formazionesou.local
```

## STEP 3 - Verifica

Tramite browser andare all'indirizzo **formazionesou.local** e verrà visualizzata la web-app.

