{
  apiVersion: 'argoproj.io/v1alpha1',
  kind: 'Application',
  metadata: {
    name: 'cert-manager',
    namespace: 'argocd',
  },
  spec: {
    project: 'default',
    source: {
      repoURL: 'https://charts.jetstack.io',
      targetRevision: 'v1.11.0',
      path: '',
      chart: 'cert-manager',
      helm: {
        releaseName: 'cert-manager',
        parameters: [
          {
            name: 'installCRDs',
            value: 'true',
          }
        ],
      },
    },
    destination: {
      server: 'https://kubernetes.default.svc',
      namespace: 'cert-manager',
    },
    syncPolicy: {
      syncOptions: [
        'CreateNamespace=true',
      ],
    },
  },
}
