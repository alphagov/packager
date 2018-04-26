class GdsLocalPip1001 < FPM::Cookery::Recipe

  homepage 'https://pip.pypa.io/en/stable/'
  name 'gds-local_pip'
  version '10.0.1'

  description 'Pip for self-compiled Python installation to live in /usr/local, necessary due to TLS requirements not fulfilled in 2.7.6 (Trustys own)'

  source 'https://github.com/pypa/pip/archive/10.0.1.zip'
  sha256 '1812905ce4d87360f63b7bc30444790c8f0be7553aed5516513ada93a85a77b0'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'MIT'

  build_depends 'gds-local_python','gds_local_setuptools'

  depends 'gds-local_python','gds-local_setuptools'

  def build
    sh "cd pip-10.0.1 && /usr/local/bin/python setup.py build"
  end

  def install
    sh "cd pip-10.0.1 && /usr/local/bin/python setup.py install"
  end
end
