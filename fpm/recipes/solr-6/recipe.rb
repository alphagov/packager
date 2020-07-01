class Solr6 < FPM::Cookery::Recipe
  homepage    'https://lucene.apache.org/solr/'
  maintainer  'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'

  name    'solr'
  version '6.4.2'
  revision '1'
  license 'Apache-2.0'

  source "https://archive.apache.org/dist/lucene/solr/#{version}/solr-#{version}.tgz"
  sha256 '354e1affd9cad7d6e86cde8c03aaeb604876f0764129621d8e231cdb35b31c55'

  # this *is* a dependency, but provided to the target machines through a 3rd party
  # repo, and our current build system isn't equipped to handle 3rd party repos
  #depends 'openjdk-8-jdk'

  post_install   'post-install'
  post_uninstall 'post-uninstall'

  def build
  end

  def install
    install_dir = "#{destdir}/opt/solr"
    solr_home = "#{destdir}/var/lib/solr"
    solr_pid_dir = "#{destdir}/var/run/solr"
    solr_log_dir = "#{destdir}/var/log/solr"

    safesystem "mkdir -p #{install_dir} #{solr_home} #{solr_pid_dir} #{solr_log_dir}"
    safesystem "cp -r #{builddir}/solr-#{version}/* #{install_dir}"

    # add init script & config file
    etc('init.d').install workdir('init.solr'), 'solr'
    etc('default').install workdir('solr.in.sh'), 'solr.in.sh'

    safesystem "chmod 0755 #{destdir}/etc/init.d/solr"
  end
end
