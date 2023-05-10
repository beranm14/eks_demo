{
  apiVersion: 'argoproj.io/v1alpha1',
  kind: 'Application',
  metadata: {
    name: 'aws-load-balancer-controller',
    namespace: 'argocd',
  },
  spec: {
    destination: {
      namespace: 'kube-system',
      server: 'https://kubernetes.default.svc',
    },
    project: 'default',
    source: {
      repoURL: 'https://aws.github.io/eks-charts',
      targetRevision: '1.5.2',
      path: '',
      chart: 'aws-load-balancer-controller',
      helm: {
        releaseName: 'aws-load-balancer-controller',
        parameters: [
          {
            name: 'clusterName',
            value: 'arn:aws:eks:eu-west-1:168194167032:cluster/beranm-testing-01',
          },
          {
            name: 'ingressClassParams.name',
            value: 'aws-load-balancer',
          },
        ],
      },
    },
    syncPolicy: {
      syncOptions: [
        'CreateNamespace=true',
      ],
    },
  },
}
