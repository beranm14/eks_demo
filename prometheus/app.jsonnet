local prometheusParams = (import 'params.libsonnet');

{
  apiVersion: 'argoproj.io/v1alpha1',
  kind: 'Application',
  metadata: {
    name: 'prometheus',
    namespace: 'argocd',
  },
  spec: {
    project: 'default',
    source: {
      repoURL: 'https://prometheus-community.github.io/helm-charts',
      targetRevision: '45.9.1',
      path: '',
      chart: 'kube-prometheus-stack',
      helm: {
        releaseName: 'kube-prometheus-stack',
        skipCrds: true,
        parameters: prometheusParams,
      },
    },
    destination: {
      server: 'https://kubernetes.default.svc',
      namespace: 'prometheus',
    },
    ignoreDifferences: [
      {
        group: 'apps',
        kind: 'DaemonSet',
        name: 'kube-prometheus-stack-prometheus-node-exporter',
      },
    ],
    syncPolicy: {
      syncOptions: [
        'CreateNamespace=true',
      ],
    },
  },
}
