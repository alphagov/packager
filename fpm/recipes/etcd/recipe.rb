class Etcd < FPM::Cookery::Recipe
  description 'Distributed reliable key-value store for the most critical data of a distributed system'
  homepage    'https://github.com/coreos/etcd'
  maintainer  'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'

  name    'etcd'
  version '3.0.1'
  license 'Apache-2.0'

  source "https://github.com/coreos/etcd/releases/download/v#{version}/etcd-v#{version}-linux-amd64.tar.gz"
  sha256 '7e5d8db2b8a7cec7a93e531c8ae0f3108c66c7d896a2fb6d8768c067923ce0aa'

  def build
  end

  def install
    bin_dir = "#{destdir}/usr/bin"

    safesystem "mkdir -p #{bin_dir}"
    safesystem "cp #{builddir}/etcd-v#{version}-linux-amd64/{etcd,etcdctl} #{bin_dir}/"

    # create the config directory.
    safesystem "mkdir -p #{destdir}/etc/etcd"

    # drop in the init script
    etc('init').install workdir('upstart-etcd.conf'), 'etcd.conf'
  end
end
