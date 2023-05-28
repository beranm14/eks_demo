{
  apiVersion: 'argoproj.io/v1alpha1',
  kind: 'Application',
  metadata: {
    name: 'sayhi',
    namespace: 'argocd',
  },
  spec: {
    project: 'default',
    source: {
      repoURL: 'http://chartmuseum.chartmuseum.svc:8080/',
      targetRevision: 'v1.0.6',
      path: '',
      chart: 'sayhi',
      helm: {
        releaseName: 'sayhi',
        parameters: [
          {
            name: 'general.metadata.namespace',
            value: 'sayhi',
          },
          {
            name: 'general.port',
            value: '3002',
          },
        ],
      },
    },
    destination: {
      server: 'https://kubernetes.default.svc',
      namespace: 'sayhi',
    },
    syncPolicy: {
      automated: {
        prune: true,
        selfHeal: true,
      },
      syncOptions: [
        'CreateNamespace=true',
        'applyOutOfSyncOnly=true',
      ],
    },
  },
}
