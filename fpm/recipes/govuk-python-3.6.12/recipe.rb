class GovukPython3612 < FPM::Cookery::Recipe
  homepage 'https://www.python.org/downloads/release/python-3612/'
  name 'govuk-python'
  version '3.6.12'
  
  source "https://www.python.org/ftp/python/#{version}/Python-#{version}.tgz"
  sha256 '12dddbe52385a0f702fb8071e12dcc6b3cb2dde07cd8db3ed60e90d90ab78693'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Python 3.6 License'

  build_depends 'libgeos-dev', 'build-essential', 'libssl-dev',
                'libffi-dev', 'libpq-dev', 'libbz2-dev'

  def build
    configure :prefix => prefix 
    make
  end

  def install
    make :altinstall, 'DESTDIR' => destdir
  end
end
