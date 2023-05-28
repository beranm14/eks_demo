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
          },
          {
            name: 'serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn',
            value: 'arn:aws:iam::168194167032:role/cert-manager',
          },
          {
            name: 'extraEnv.env[0].name',
            value: 'AWS_SDK_LOAD_CONFIG',
          },
          {
            name: 'extraEnv.env[0].value',
            value: '"true"',
          },
          {
            name: 'extraEnv.env[1].name',
            value: 'POD_NAMESPACE',
          },
          {
            name: 'extraEnv.env[1].value',
            value: 'cert-manager',
          },
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
