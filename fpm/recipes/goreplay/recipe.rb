class Gor < FPM::Cookery::Recipe
  name 'goreplay'
  homepage 'https://goreplay.org/'

  version '0.16.1'

  source "https://github.com/buger/goreplay/releases/download/v#{version}/gor_#{version}_x64.tar.gz"
  sha256 '25587cd4c88b0608ac4004a3c7c9722e10a9086cfcc77d1fb26d9f07bd48d245'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'LGPLv3'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name} #{destdir}/usr/local/bin/"
  end
end
