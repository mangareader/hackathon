Create cluster using terraform using defaults other than the project:

    ```bash
    # obtain user access credentials to use for Terraform commands
    gcloud auth application-default login

    # continue in /terraform directory
    cd terraform
    export TF_VAR_project=$PROJECT_ID
    terraform init
    terraform plan
    terraform apply
    ```
    
Install nginx:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml
    ```

Install promtail for logging:
    ```bash
    helm repo add grafana https://grafana.github.io/helm-charts
    helm repo update
    helm install --values values_loki.yaml loki grafana/loki
    helm install --values values_promtail.yaml promtail grafana/promtail
    ```
Install prometheus for monitoring:
    ```bash
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm install --values values_prometheus.yaml prometheus prometheus-community/prometheus
    ```
Install grafana:
    ```bash
    helm repo add grafana https://grafana.github.io/helm-charts
    helm repo update
    helm install grafana grafana/grafana
    ```