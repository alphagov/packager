class Prometheus_server < FPM::Cookery::Recipe
  name 'prometheus'
  homepage 'https://prometheus.io'

  version '2.6.0'

  source "https://github.com/prometheus/prometheus/releases/download/v2.6.0/prometheus-2.6.0.linux-amd64.tar.gz"
  sha256 '8f1f9ca9dbc06e1dc99200e30526ca8343dfe80c2bd950847d22182953261c6c'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'LGPLv3'

  def build
  end

  def install
    # create directory for the binary
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    # create directory for holding the prometheus configuration
    safesystem "mkdir -p #{destdir}/etc/prometheus/"
    # copy the binary into place
    safesystem "cp -f #{builddir}/#{name}-#{version}.linux-amd64/#{name} #{destdir}/usr/local/bin/"
    # drop in the init script
    etc('init').install workdir('upstart-prometheus.conf'), 'prometheus.conf'
  end
end
