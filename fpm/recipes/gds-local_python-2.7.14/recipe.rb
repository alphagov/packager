class GdsLocalPython2714 < FPM::Cookery::Recipe

  homepage 'https://www.python.org/'
  name 'gds-local_python'
  version '2.7.14'

  description 'Self-compiled Python installation to live in /usr/local, necessary due to TLS requirements not fulfilled in 2.7.6 (Trustys own)'

  source 'https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz'
  sha256 '304c9b202ea6fbd0a4a8e0ad3733715fbd4749f2204a9173a58ec53c32ea73e8'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Python 2.7 License'

  build_depends 'autoconf', 'build-essential', 'libssl-dev',
                'libexpat1-dev', 'libncurses5-dev', 'libffi-dev',
                'multiarch-support'

  depends 'libc6', 'libssl1.0.0', 'mime-support', 'libreadline6', 'zlib1g',
          'libncursesw5', 'libffi6', 'libsqlite3-0', 'libdb5.3',
          'libtinfo5'

  def build
    configure
    make
  end

  def install
    make :install
  end
end
