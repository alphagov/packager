class Prometheus_node_exporter < FPM::Cookery::Recipe
  name 'node_exporter'
  homepage 'https://prometheus.io'

  version '0.17.0'

  source "https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-amd64.tar.gz"
  sha256 'd2e00d805dbfdc67e7291ce2d2ff151f758dd7401dd993411ff3818d0e231489'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'LGPLv3'

  def build
  end

  def install
    # create directory for the binary
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    # copy the binary into place
    safesystem "cp -f #{builddir}/#{name}-#{version}.linux-amd64/#{name} #{destdir}/usr/local/bin/"
    # drop in the init script
    etc('init').install workdir('upstart-node-exporter.conf'), 'node-exporter.conf'
  end
end
