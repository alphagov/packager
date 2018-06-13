class GovukSetuptools3901 < FPM::Cookery::Recipe

  homepage 'https://pypi.org/project/setuptools/'
  name 'govuk-python-setuptools'
  version '39.0.1'

  description 'Setuptools for self-compiled Python installation to live in /opt, necessary due to TLS requirements not fulfilled in 2.7.6 (Trustys own)'

  source 'https://github.com/pypa/setuptools/archive/v39.0.1.zip'
  sha256 '25e3b711d035890c9ae8f662fc7e71f31d156fdeb62b824d05e4fe961b6f3284'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'MIT'

  build_depends 'govuk-python'

  depends 'govuk-python'

  def build
    sh "PATH=/opt/python2.7/bin:${PATH} && PYTHONHOME=/opt/python2.7 && cd setuptools-39.0.1 && python bootstrap.py"
    sh "PATH=/opt/python2.7/bin:${PATH} && PYTHONHOME=/opt/python2.7 && cd setuptools-39.0.1 && python setup.py build"
  end

  def install
   sh "PATH=/opt/python2.7/bin:${PATH} && PYTHONHOME=/opt/python2.7 && cd setuptools-39.0.1 && python setup.py install --prefix /opt/python2.7 --root #{destdir} --install-lib /opt/python2.7/lib/python2.7/site-packages"
  end

end
