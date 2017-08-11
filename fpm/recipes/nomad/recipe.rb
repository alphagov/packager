class Nomad< FPM::Cookery::Recipe
  name 'nomad'
  homepage 'https://www.nomadproject.io/'

  version '0.6.0'

  source "https://releases.hashicorp.com/nomad/#{version}/nomad_#{version}_linux_amd64.zip"
  sha256 'fcf108046164cfeda84eab1c3047e36ad59d239b66e6b2f013e6c93064bc6313'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Mozilla Public License, version 2.0'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name}_#{version}_linux_amd64/* #{destdir}/usr/local/bin/"
  end
end
