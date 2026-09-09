#!/bin/bash
# shebang

EXPORT_FILE="export-deployment.yaml" # file yaml dell'export del Deployment
NAMESPACE="formazione-sou" # namespace
SERVICE_ACCOUNT="web-app-service-account" # service account per l'autenticazione
DEPLOYMENT="web-app-deployment" # deployment
RBAC_FILE="rbac.yaml" # file rbac

# definizioni delle funzioni

apply_rbac() {
    local path="$1" # percorso manifest rbac

    # verifica dell'esistenza del file 
    if [[ ! -f "$path" ]]; then
        echo "Errore: il file $path non esiste!"
        exit 1 
    fi

    # applicazione manifest rbac 
    if kubectl apply -f "$path"; then
        echo "Esecuzione applicata con successo!"
    else
        echo "Errore durante l'esecuzione del file $path !"
        exit 1
    fi
}

export_and_validate() {
    # token temporaneo per il service account 
    TOKEN=$(kubectl create token "$SERVICE_ACCOUNT" -n "$NAMESPACE")

    # export del deployment con autenticazione del token generato
    if kubectl --token="$TOKEN" get deployment "$DEPLOYMENT" -n "$NAMESPACE" -o yaml > "$EXPORT_FILE"; then
        echo "Export eseguito con successo!"
    else
        echo "Errore, export non riuscito!"
        exit 2
    fi

    # verifica di readinessProbe
    if ! grep "readinessProbe" "$EXPORT_FILE" > /dev/null 2>&1; then
        echo "Errore, non è presente la readinessProbe!" 
        exit 
    fi

    # verifica di livenessProbe
    if ! grep "livenessProbe" "$EXPORT_FILE" > /dev/null 2>&1; then
        echo "Errore, non è presente la livenessProbe!" 
        exit 4  
    fi

    # verifica dei limits
    if ! grep "limits" "$EXPORT_FILE" > /dev/null 2>&1; then
        echo "Errore, non sono presenti i limits!"
        exit 5  
    fi

    # verifica delle requests
    if ! grep "requests" "$EXPORT_FILE" > /dev/null 2>&1; then
        echo "Errore, non sono presenti i requests!" 
        exit 6  
    fi

    echo "Tutti i parametri sono presenti!"

}

# funzioni 
apply_rbac "$RBAC_FILE"  
export_and_validate      