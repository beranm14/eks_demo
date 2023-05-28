{
  apiVersion: 'argoproj.io/v1alpha1',
  kind: 'Application',
  metadata: {
    name: 'chartmuseum',
    namespace: 'argocd',
  },
  spec: {
    project: 'default',
    source: {
      repoURL: 'https://chartmuseum.github.io/charts',
      targetRevision: '3.9.3',
      path: '',
      chart: 'chartmuseum',
      helm: {
        releaseName: 'chartmuseum',
        parameters: [
          {
            name: 'env.open.STORAGE',
            value: 'amazon',
          },
          {
            name: 'env.open.STORAGE_AMAZON_BUCKET',
            value: 'chart-museum-5n1y92wq',
          },
          {
            name: 'env.open.STORAGE_AMAZON_PREFIX',
            value: '',
          },
          {
            name: 'env.open.STORAGE_AMAZON_REGION',
            value: 'eu-west-1',
          },
          {
            name: 'env.open.AWS_SDK_LOAD_CONFIG',
            value: 'true',
          },
          {
            name: 'serviceAccount.create',
            value: 'true',
          },
          {
            name: 'serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn',
            value: 'arn:aws:iam::168194167032:role/chart-museum',
          },
        ],
      },
    },
    destination: {
      server: 'https://kubernetes.default.svc',
      namespace: 'chartmuseum',
    },
    syncPolicy: {
      syncOptions: [
        'CreateNamespace=true',
      ],
    },
  },
}
