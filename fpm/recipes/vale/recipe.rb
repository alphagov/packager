class Vale < FPM::Cookery::Recipe
  name 'vale'
  homepage 'https://github.com/ValeLint/vale'

  version '0.10.0'

  source "https://github.com/ValeLint/vale/releases/download/#{version}/vale_#{version}_Linux_64-bit.tar.gz"
  sha256 '3f6b5aaa3bcc1a5f925d7f2782404a76d744cb166e2d5c01eb964a265a7d77c5'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'LGPLv3'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/vale #{destdir}/usr/local/bin/"
  end
end
