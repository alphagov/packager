class Sops < FPM::Cookery::Recipe
  name 'sops'
  homepage 'https://github.com/mozilla/sops'

  version '3.0.2'

  source "https://github.com/mozilla/sops/releases/download/#{version}/sops-#{version}.linux"
  sha256 '726837b44023507c8f71ba28deb25617cd3ad3222c2d5ae8256da76b375302b5'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'LGPLv3'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "chmod +x #{builddir}/sops-#{version}.linux/*"
    safesystem "cp -f #{builddir}/sops-#{version}.linux/* #{destdir}/usr/local/bin/sops"
  end
end
