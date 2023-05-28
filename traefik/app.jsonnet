{
  apiVersion: 'argoproj.io/v1alpha1',
  kind: 'Application',
  metadata: {
    name: 'traefik',
    namespace: 'argocd',
  },
  spec: {
    project: 'default',
    source: {
      repoURL: 'https://traefik.github.io/charts',
      targetRevision: '23.0.1',
      path: '',
      chart: 'traefik',
      helm: {
        releaseName: 'traefik',
        parameters: [
          {
            name: 'deployment.kind',
            value: 'DaemonSet',
          },
          {
            name: 'ingressClass.isDefaultClass',
            value: 'false',
          },
          {
            name: 'service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type',
            value: 'nlb'
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
