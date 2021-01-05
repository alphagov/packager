class Prometheus_server < FPM::Cookery::Recipe
  name 'prometheus'
  homepage 'https://prometheus.io'

  version '2.23.0'

  source "https://github.com/prometheus/prometheus/releases/download/v2.23.0/prometheus-2.23.0.linux-amd64.tar.gz"
  sha256 '0f54cefdb946852947e35d4db8cfce394911ff586486f927c3887db4183cb643'

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
