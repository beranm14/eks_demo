{
  apiVersion: 'argoproj.io/v1alpha1',
  kind: 'Application',
  metadata: {
    name: 'kube-prometheus-stack-crds',
    namespace: 'argocd',
  },
  spec: {
    destination: {
      namespace: 'prometheus',
      server: 'https://kubernetes.default.svc',
    },
    project: 'default',
    source: {
      path: 'charts/kube-prometheus-stack/crds/',
      repoURL: 'https://github.com/prometheus-community/helm-charts.git',
      targetRevision: 'kube-prometheus-stack-45.9.1',
    },
    syncPolicy: {
      syncOptions: [
        'CreateNamespace=true',
      ],
    },
  },
}
