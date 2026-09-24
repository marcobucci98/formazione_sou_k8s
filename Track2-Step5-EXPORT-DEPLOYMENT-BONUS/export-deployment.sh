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
    # rimuove il file export se già creato
    rm -f "$EXPORT_FILE" 2>/dev/null || true

    # token temporaneo per il service account
    TOKEN=$(kubectl create token "$SERVICE_ACCOUNT" -n "$NAMESPACE")
    API_SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')


    if curl -sfk \
        -H "Authorization: Bearer $TOKEN" \
        -H "Accept: application/yaml" \
        "$API_SERVER/apis/apps/v1/namespaces/$NAMESPACE/deployments/$DEPLOYMENT" | \
        yq eval 'del(.metadata.managedFields)' - > "$EXPORT_FILE"; then
        echo "Export eseguito con successo!"
    else
        echo "Errore, export non riuscito!"
        exit 2
    fi

    # verifica del file 
    if [[ ! -r "$EXPORT_FILE" ]]; then
        echo "Errore critico: il file $EXPORT_FILE non è leggibile."
        echo "Verifica i permessi con: ls -l $EXPORT_FILE"
        exit 2
    fi

    # verifica di readinessProbe
    if ! yq eval '.spec.template.spec.containers[].readinessProbe' "$EXPORT_FILE" | grep -qv "^null$"; then
        echo "Errore, non è presente la readinessProbe!"
        exit 3
    fi

    # verifica di livenessProbe
    if ! yq eval '.spec.template.spec.containers[].livenessProbe' "$EXPORT_FILE" | grep -qv "^null$"; then
        echo "Errore, non è presente la livenessProbe!"
        exit 4
    fi

    # verifica dei limits
    if ! yq eval '.spec.template.spec.containers[].resources.limits' "$EXPORT_FILE" | grep -qv "^null$"; then
        echo "Errore, non sono presenti i limits!"
        exit 5
    fi

    # verifica delle requests
    if ! yq eval '.spec.template.spec.containers[].resources.requests' "$EXPORT_FILE" | grep -qv "^null$"; then
        echo "Errore, non sono presenti i requests!"
        exit 6
    fi

    echo "Tutti i parametri sono presenti!"
}

# esecuzione funzioni 
apply_rbac "$RBAC_FILE"
export_and_validate
