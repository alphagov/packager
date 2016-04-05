class Gof3r < FPM::Cookery::Recipe
  name 'gof3r'
  homepage 'https://github.com/rlmcpherson/s3gof3r'

  version '0.5.0'

  source "https://github.com/rlmcpherson/s3gof3r/releases/download/v#{version}/gof3r_#{version}_linux_amd64.tar.gz"
  sha256 'd88f199d1580d8c8cac26ba39e15dc6e2126d20e56c3894bd37a226e8b3e665c'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name}_#{version}_linux_amd64/* #{destdir}/usr/local/bin/"
  end
end
