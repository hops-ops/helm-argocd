# helm-argocd

A Crossplane Configuration package that installs the Argo CD Helm chart with a minimal, stable interface.

## Quick Start

```yaml
apiVersion: pkg.crossplane.io/v1
kind: Configuration
metadata:
  name: helm-argocd
spec:
  package: ghcr.io/hops-ops/helm-argocd:latest
```

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: ArgoCD
metadata:
  name: argocd
  namespace: example-env
spec:
  clusterName: example-cluster
```

## Development

```bash
make render
make validate
make test
```
