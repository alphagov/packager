class Terraform < FPM::Cookery::Recipe
  name 'terraform'
  homepage 'https://www.terraform.io/'

  version '0.7.7'

  source "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  sha256 '478c4fe311392804ffc449995e8d7f903abab56f7483f317c1f120d8c21b1a81'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Mozilla Public License, version 2.0'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name}_#{version}_linux_amd64/* #{destdir}/usr/local/bin/"
  end
end
