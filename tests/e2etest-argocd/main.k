import datetime
import math
import models.io.upbound.dev.meta.v1alpha1 as metav1alpha1

_now = str(int(math.floor(datetime.ticks())))
_test_name = "e2e-argocd-" + _now

_items = [
    metav1alpha1.E2ETest {
        metadata.name = "argocd-helm"
        spec = {
            crossplane = {
                version = "2.0.2-up.5"
                autoUpgrade.channel = "None"
            }
            skipDelete = False
            extraResources = [
                {
                    apiVersion = "helm.crossplane.io/v1beta1"
                    kind = "ProviderConfig"
                    metadata.name = "default"
                    spec.credentials.source = "InjectedIdentity"
                }
            ]
            manifests = [
                {
                    apiVersion = "helm.hops.ops.com.ai/v1alpha1"
                    kind = "ArgoCD"
                    metadata = {
                        name = _test_name
                        namespace = "default"
                    }
                    spec = {
                        clusterName = _test_name
                        labels = {
                            "hops.ops.com.ai/e2etest" = "true"
                            "hops.ops.com.ai/test-run" = _now
                        }
                        providerConfigRef = {
                            name = "default"
                            kind = "ProviderConfig"
                        }
                        values = {
                            controller.resources.requests = {
                                cpu = "10m"
                                memory = "64Mi"
                            }
                            server.resources.requests = {
                                cpu = "10m"
                                memory = "64Mi"
                            }
                            repoServer.resources.requests = {
                                cpu = "10m"
                                memory = "64Mi"
                            }
                        }
                    }
                }
            ]
        }
    }
]
items = _items
