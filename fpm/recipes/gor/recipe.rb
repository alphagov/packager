class Gor < FPM::Cookery::Recipe
  name 'gor'
  homepage 'https://gortool.com/'

  version '0.14.1'

  source "https://github.com/buger/gor/releases/download/v#{version}/#{name}_v#{version}_x64.tar.gz"
  sha256 'b1d46fd9383b8309077dceaaa24b8165635763722585c8bfca73a40f47fca6e5'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'LGPLv3'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name} #{destdir}/usr/local/bin/"
  end
end
