class Terraform < FPM::Cookery::Recipe
  name 'terraform'
  homepage 'https://www.terraform.io/'

  version '0.11.1'

  source "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  sha256 '4e3d5e4c6a267e31e9f95d4c1b00f5a7be5a319698f0370825b459cb786e2f35'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Mozilla Public License, version 2.0'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name}_#{version}_linux_amd64/* #{destdir}/usr/local/bin/"
  end
end
