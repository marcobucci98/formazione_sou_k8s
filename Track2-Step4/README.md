## Track 2 - Step 4 - Installazione Chart con Jenkins

L'esercizio prevede di configurare il cluster Kubernetes, con Jenkins, in modo tale che raggiunga il namespace "formazione-sou", e poi, scrivere una pipeline che installi il chart riposto sulla propria repository GitHub, sviluppato nello Step 3, ed effettui l'installazione sul namespace "formazione-sou".

---

```kubectl start -p step4``` : per avviare il cluster.

```kubectl create ns formazione-sou``` : per creare il namespace formazione-sou

```kubectl config set-context --current --namespace=formazione-sou``` : per spostarci nel ns "formazione-sou"



