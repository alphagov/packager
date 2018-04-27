class TerraformDocs < FPM::Cookery::Recipe
  description 'Generate docs from terraform modules'
  homepage    'https://github.com/segmentio/terraform-docs'
  maintainer  'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'

  name    'terraform-docs'
  version '0.3.0'
  license 'MIT'

  source "https://github.com/segmentio/terraform-docs/releases/download/v#{version}/terraform-docs_linux_amd64"
  sha256 '339c157dfbabc1ad22091b07d5793902611eee6c3c5e95c5fc7c6b55540c542a'

  def build; end

  def install
    bin.install builddir('terraform-docs_linux_amd64/terraform-docs_linux_amd64'), 'terraform-docs'
    chmod 0755, destdir('usr/bin/terraform-docs')
  end
end
