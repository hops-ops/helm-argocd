import models.io.upbound.dev.meta.v1alpha1 as metav1alpha1

_items = [
    metav1alpha1.CompositionTest {
        metadata.name = "minimal-renders-helm-release"
        spec = {
            compositionPath = "apis/argocds/composition.yaml"
            xrdPath = "apis/argocds/definition.yaml"
            timeoutSeconds = 60
            validate = False
            xr = {
                apiVersion = "helm.hops.ops.com.ai/v1alpha1"
                kind = "ArgoCD"
                metadata.name = "test-argocd"
                spec = {
                    clusterName = "test-cluster"
                }
            }
            assertResources = [
                {
                    apiVersion = "helm.m.crossplane.io/v1beta1"
                    kind = "Release"
                    metadata.name = "test-argocd"
                }
            ]
        }
    }

    metav1alpha1.CompositionTest {
        metadata.name = "custom-labels-merged-with-defaults"
        spec = {
            compositionPath = "apis/argocds/composition.yaml"
            xrdPath = "apis/argocds/definition.yaml"
            timeoutSeconds = 60
            validate = False
            xr = {
                apiVersion = "helm.hops.ops.com.ai/v1alpha1"
                kind = "ArgoCD"
                metadata.name = "labeled-argocd"
                spec = {
                    clusterName = "test-cluster"
                    labels = {
                        team = "platform"
                    }
                }
            }
            assertResources = [
                {
                    apiVersion = "helm.m.crossplane.io/v1beta1"
                    kind = "Release"
                    metadata = {
                        name = "labeled-argocd"
                        labels = {
                            "hops.ops.com.ai/managed" = "true"
                            "hops.ops.com.ai/argocd" = "labeled-argocd"
                            team = "platform"
                        }
                    }
                }
            ]
        }
    }
]

items = _items
