# Track 2 - Step 5 - Kubernetes Deployment Validation & RBAC Automation

## Descrizione

Lo Step 5 prevede di scrivere uno script Bash, che applichi la configurazione di un file YAML per ServiceAccount, Role e RoleBinding nel namespace ```formazione-sou```, con la generazione di un token temporaneo per l'autenticazione associato al Service Account. 

Verifica  della configurazione nell' export del file YAML del Deployment dei parametri di limits, resources, readinessProbe, livenessProbe, e la gestione degli errori nel caso queste risorse vengano meno nella configurazione, con l'opportuno messaggio di errore relativo al parametro mancante. 

Il file YAML dell'export viene generato nella stessa cartella del progetto.

---

## Struttura

* **`export-deployment.sh`**: Lo script è completamente automatizzato, sia per l'applicazione del file YAML, che per la generazione e autenticazione del token. 
Lo script è stato diviso in due funzioni:
- **apply_rbac**: che si occupa di verificare l'esistenza e di applicare il file YAML RBAC.

- **export_and_validate**: che si occupa invece dell'export, di validare i parametri, e la gestione degli errori.

* **`rbac.yaml`**: Il manifesto Kubernetes che definisce le risorse RBAC.

---

## Requisiti

* **Kubernetes Cluster** 
* **kubectl**.
* Namespace `formazione-sou` creato automaticamente con l'esecuzione della Pipeline Jenkins dello Step 4.
* Deployment `web-app-deployment` presente nel namespace.

---

## Esecuzione

Scaricare e spostarsi nella cartella del progetto e assegnare i permessi di esecuzione allo script Bash:

```
chmod +x export-deployment.sh
```

eseguire il comando:

```
./export-deployment.sh
```