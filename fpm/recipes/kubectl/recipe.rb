class Kubectl < FPM::Cookery::Recipe
  description 'Command line interface for running commands against Kubernetes clusters'
  homepage    'https://kubernetes.io/docs/user-guide/kubectl-overview'

  name    'kubectl'
  version '1.6.2'

  source "https://storage.googleapis.com/kubernetes-release/release/v#{version}/bin/linux/amd64/kubectl"

  def build
  end

  def install
    root('/usr/local/bin').install 'kubectl'
  end
end
