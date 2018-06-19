class AwsCli < FPM::Cookery::Recipe
  homepage 'https://docs.aws.amazon.com/cli/'
  source   'https://s3.amazonaws.com/aws-cli/awscli-bundle.zip'
  sha256   'd0130984b77e2c5839fe9aad8b5f464b752fcf1016e6bdcfff4452ce9f8f1655'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'

  name     'awscli'
  version  '1.15.37'
  revision "1-govuk-#{ENV['DISTRO']}1"
  arch     'all'

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
