class GovukPython2714 < FPM::Cookery::Recipe

  homepage 'https://www.python.org/'
  name 'govuk-python'
  version '2.7.14'

  description 'Self-compiled Python installation to live in /opt/python2.7, necessary due to TLS requirements not fulfilled in 2.7.6 (Trustys own)'

  source 'https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz'
  sha256 '304c9b202ea6fbd0a4a8e0ad3733715fbd4749f2204a9173a58ec53c32ea73e8'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Python 2.7 License'

  default_prefix '/opt/python2.7'

  build_depends 'autoconf', 'build-essential', 'libssl-dev',
                'libexpat1-dev', 'libncurses5-dev', 'libffi-dev',
                'multiarch-support'

  depends 'libc6', 'libssl1.0.0', 'mime-support', 'libreadline6', 'zlib1g',
          'libncursesw5', 'libffi6', 'libsqlite3-0', 'libdb5.3',
          'libtinfo5'

  def build
    configure :prefix => prefix 
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
