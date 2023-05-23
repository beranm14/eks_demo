{
  apiVersion: 'argoproj.io/v1alpha1',
  kind: 'Application',
  metadata: {
    name: 'external-dns',
    namespace: 'argocd',
  },
  spec: {
    project: 'default',
    source: {
      repoURL: 'https://charts.bitnami.com/bitnami',
      targetRevision: '6.20.1',
      path: '',
      chart: 'external-dns',
      helm: {
        releaseName: 'external-dns',
        parameters: [
          {
            name: 'domainFilters[0]',
            value: 'trustsoft.beranm.cz',
          },
          {
            name: 'txtOwnerId',
            value: 'Z04333023IJ7G2JUEJXMX',
          },
          {
            name: 'aws.region',
            value: 'eu-west-1',
          },
          {
            name: 'aws.zoneType',
            value: 'public',
          },
          {
            name: "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn",
            value: 'arn:aws:iam::168194167032:role/external-dns',
          }
        ],
      },
    },
    destination: {
      server: 'https://kubernetes.default.svc',
      namespace: 'default',
    },
    syncPolicy: {
      syncOptions: [
        'CreateNamespace=true',
      ],
    },
  },
}
