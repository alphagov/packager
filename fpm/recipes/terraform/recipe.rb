class Terraform < FPM::Cookery::Recipe
  name 'terraform'
  homepage 'https://www.terraform.io/'

  version '0.8.0'

  source "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  sha256 '9f99258396dad71746fb96036bf421e05fb3f36f402b89c3f16b453f3f0ee9cf'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Mozilla Public License, version 2.0'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name}_#{version}_linux_amd64/* #{destdir}/usr/local/bin/"
  end
end
