class Terraform < FPM::Cookery::Recipe
  name 'terraform'
  homepage 'https://www.terraform.io/'

  version '0.7.0'

  source "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  sha256 'a196c63b967967343f3ae9bb18ce324a18b27690e2d105e1f38c5a2d7c02038d'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Mozilla Public License, version 2.0'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name}_#{version}_linux_amd64/* #{destdir}/usr/local/bin/"
  end
end
