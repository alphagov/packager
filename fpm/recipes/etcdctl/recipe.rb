class Etcd < FPM::Cookery::Recipe
  description 'Distributed reliable key-value store for the most critical data of a distributed system'
  homepage    'https://github.com/coreos/etcd'
  maintainer  'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'

  name    'etcdctl'
  version '3.2.7'
  license 'Apache-2.0'

  source "https://github.com/coreos/etcd/releases/download/v#{version}/etcd-v#{version}-linux-amd64.tar.gz"
  sha256 'f4e7a282eed333bb6c00eaad2644d17d23e111953e19e4fab1fc390249d6353a'

  def build
  end

  def install
    bin_dir = "#{destdir}/usr/local/bin"

    safesystem "mkdir -p #{bin_dir}"
    safesystem "cp #{builddir}/etcd-v#{version}-linux-amd64/etcdctl #{bin_dir}/"

  end
end
