class JenkinsAgent < FPM::Cookery::Recipe
  description 'The Jenkins swarm plugin enables slaves to auto-discover nearby Jenkins master and join it automatically, thereby forming an ad-hoc cluster.'
  name 'jenkins-agent'
  homepage 'https://jenkins.io/'

  version '2.2'

  source "https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/#{version}/swarm-client-#{version}-jar-with-dependencies.jar"
  sha256 'fc5ad10aaca1a3563c1ec650ad9bcb8ecbea0be9cd10053421f89647daeef8eb'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'

  def build
  end

  def install
    package_name = "swarm-client-#{version}-jar-with-dependencies.jar"

    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{package_name}/#{package_name} #{destdir}/usr/local/bin/jenkins-agent"
  end

end
