class GovukPip1001 < FPM::Cookery::Recipe

  homepage 'https://pip.pypa.io/en/stable/'
  name 'govuk-python-pip'
  version '10.0.1'

  description 'Pip for self-compiled Python installation to live in /usr/local, necessary due to TLS requirements not fulfilled in 2.7.6 (Trustys own)'

  source 'https://github.com/pypa/pip/archive/10.0.1.zip'
  sha256 '1812905ce4d87360f63b7bc30444790c8f0be7553aed5516513ada93a85a77b0'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'MIT'

  build_depends 'govuk-python','govuk-python-setuptools'

  depends 'govuk-python','govuk-python-setuptools'

  def build
    sh "PATH=/opt/python2.7/bin:${PATH} && PYTHONHOME=/opt/python2.7 && PYTHONPATH=/opt/python2.7/lib/python2.7/dist-packages && cd pip-10.0.1 && python setup.py build"
  end

  def install
    sh "PATH=/opt/python2.7/bin:${PATH} && PYTHONHOME=/opt/python2.7 && PYTHONPATH=/opt/python2.7/lib/python2.7/dist-packages && cd pip-10.0.1 && python setup.py install --prefix /opt/python2.7 --root #{destdir} --install-lib /opt/python2.7/lib/python2.7/site-packages"
  end
end
