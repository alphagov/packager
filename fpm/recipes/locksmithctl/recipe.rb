class Locksmithctl < FPM::Cookery::Recipe
  name        'locksmithctl'
  version     '0.2.3' # Latest 0.4.2
  homepage    'https://github.com/coreos/locksmith'
  maintainer  'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  description 'Simple client to control a distributed mutex to control reboots'


  source "https://github.com/coreos/locksmith/archive/v#{version}.tar.gz"
  sha256 '6fe7e6262fa9bd368cf73e45b49b644c48abba2677f46d21b28c93a01d646063'

  def build
    ENV['GOPATH'] = builddir("locksmith-#{version}")

    # We need to make sure that all of the current dir is in the GOPATH but
    # with the structure expected.
    mkdir_p 'src/github.com/coreos'
    safesystem 'ln -s `pwd` src/github.com/coreos/locksmith'
    safesystem 'cd locksmithctl && go build -o locksmithctl'
  end

  def install
    # Put it in /usr/bin
    bin.install builddir("locksmith-#{version}/locksmithctl/locksmithctl"), 'locksmithctl'
  end
end
