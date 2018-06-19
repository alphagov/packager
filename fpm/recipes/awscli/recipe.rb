class AwsCli < FPM::Cookery::Recipe
  name     'awscli'
  version  '1.15.40'
  revision "1-govuk-#{ENV['DISTRO']}1"
  arch     'all'

  homepage 'https://docs.aws.amazon.com/cli/'
  source   "https://s3.amazonaws.com/aws-cli/awscli-bundle-#{version}.zip"
  sha256   '234976c3b0004a6275a77cfd039baa3590139da37be2c9a6ae21b473fee93912'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'

  description 'AWS Command Line Interface'

  depends 'python3'
  build_depends 'python3'

  def build
  end

  def install
    safesystem "python3", "./awscli-bundle/install", "-i", "#{destdir}/opt/awscli", "-b", "#{destdir}/usr/bin/aws"
    safesystem "rm", "#{destdir}/usr/bin/aws"
    safesystem "ln", "-s", "/opt/awscli/bin/aws", "#{destdir}/usr/bin/aws"
    safesystem 'sed', '-i', '1c #!/opt/awscli/bin/python3', "#{destdir}/opt/awscli/bin/aws"
  end
end
