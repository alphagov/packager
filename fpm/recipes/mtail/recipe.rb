class Mtail < FPM::Cookery::Recipe
  name        'mtail'
  version     '3.0.0-rc2'
  homepage    'https://github.com/google/mtail'
  maintainer  'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  description 'Extract whitebox monitoring data from application logs for collection in a timeseries database'

  source "https://github.com/google/mtail/archive/v#{version}.tar.gz"
  sha256 'e2802250ad37e2fa4302aa28d479213233aa6bc2e522100140d594db788510d4'

  post_install 'postinst'

  def build
    mkdir_p 'go/src/github.com/google'
    safesystem 'ln -s `pwd` go/src/github.com/google/mtail'
    safesystem 'export GOPATH=`pwd`/go && export PATH=$GOPATH/bin:$PATH && export GOBIN=$GOPATH/bin && make'
  end

  def install
    bin.install builddir("mtail-#{version}/go/bin/mtail-#{version}"), 'mtail'
    etc('mtail').mkpath
    var('log/mtail').mkpath
  end
end
