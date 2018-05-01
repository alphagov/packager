class GdsLocalSetuptools3901 < FPM::Cookery::Recipe

  homepage 'https://pypi.org/project/setuptools/'
  name 'gds-local-setuptools'
  version '39.0.1'

  description 'Setuptools for self-compiled Python installation to live in /usr/local, necessary due to TLS requirements not fulfilled in 2.7.6 (Trustys own)'

  source 'https://github.com/pypa/setuptools/archive/v39.0.1.zip'
  sha256 '25e3b711d035890c9ae8f662fc7e71f31d156fdeb62b824d05e4fe961b6f3284'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'MIT'

  build_depends 'gds-local-python'

  depends 'gds-local-python'

  def build
    sh "cd setuptools-39.0.1 && /usr/local/bin/python bootstrap.py"
    sh "cd setuptools-39.0.1 && /usr/local/bin/python setup.py build"
  end

  def install
    sh "cd setuptools-39.0.1 && /usr/local/bin/python setup.py install"
  end
end
