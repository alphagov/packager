class Wkhtmltopdf < FPM::Cookery::Recipe
  name 'wkhtmltopdf'
  homepage 'https://wkhtmltopdf.org/'

  version '0.12.4'

  source "https://downloads.wkhtmltopdf.org/#{minor_version}/#{version}/wkhtmltox-#{version}_linux-generic-amd64.tar.xz"
  sha256 '049b2cdec9a8254f0ef8ac273afaf54f7e25459a273e27189591edc7d7cf29db'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'LGPLv3'

  def minor_version
    version.split('.').take(2).join('.')
  end

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/bin/#{name} #{destdir}/usr/local/bin/"
  end
end
