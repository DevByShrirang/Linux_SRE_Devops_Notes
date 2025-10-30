helm search - search for charts
helm pull  - download a chart to your local directory to view
helm push  -push chart to remote
helm install -upload a chart to kubernetes
hem create 
helm list    - list release of charts
helm uninstall - uninstall a realease
helm repo add - 
          list
          remove
          update
          index
helm env 

helm template   -->  helm templates locally(dry run) --> helm template myapp ./helm/myapp -f values.yaml
helm lint       --> for troubleshooting to validate chart --> helm install --dry-run --debug - to test templates before deployment
helm upgrade --install --deployment happens even if the release doesnt exists

helm list -n production   --> w e can check this. eg we install chart1 then we fail chart2
we get revision and application status.
helm history mock-app -n dev-ns
helm status my-app -n production  --> we get current status(failed/deployed/pending?
helm rollback myapp 1 -n production -
