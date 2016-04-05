class Terraform < FPM::Cookery::Recipe
  name 'terraform'
  homepage 'https://www.terraform.io/'

  version '0.6.14'

  source "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  sha256 '6d93290f980df15a453e907ea9a2ca8f8fed41143c220953c911b5174c3e3ab0'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Mozilla Public License, version 2.0'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name}_#{version}_linux_amd64/* #{destdir}/usr/local/bin/"
  end
end
