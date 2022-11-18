class GovukPython3715 < FPM::Cookery::Recipe
  homepage 'https://www.python.org/downloads/release/python-3715/'
  name 'govuk-python-3.7.15'
  version '1'
  
  source "https://www.python.org/ftp/python/3.7.15/Python-3.7.15.tgz"
  
  sha256 'cf2993798ae8430f3af3a00d96d9fdf320719f4042f039380dca79967c25e436'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Python 3.7 License'

  build_depends 'libgeos-dev', 'build-essential', 'libssl-dev',
                'libffi-dev', 'libpq-dev', 'libbz2-dev', 'libsqlite3-dev',
                'libreadline-gplv2-dev', 'libncursesw5-dev', 'tk-dev', 'libgdbm-dev', 'libc6-dev'

  depends 'libpq-dev', 'libbz2-dev', 'libsqlite3-dev', 'libssl-dev'

  ENV['LD_LIBRARY_PATH'] = '/openssl/lib/'
  ENV['LDFLAGS'] = '-L /openssl/lib -Wl,-rpath,/openssl/lib'

  def build

    safesystem """
      wget --no-check-certificate https://artfiles.org/openssl.org/source/old/1.1.1/openssl-1.1.1g.tar.gz && \
      tar zxvf openssl-1.1.1g.tar.gz && \
      cd openssl-1.1.1g && \
      ./config --prefix=/openssl --openssldir=/openssl no-ssl2 shared --prefix=/openssl && \
      make && make install && \
      mkdir -p lib && cp -r /openssl/lib/ ./
      """

    configure '--enable-loadable-sqlite-extensions', '--with-openssl=/openssl'
    make
  end

  def install
    make :altinstall, 'DESTDIR' => destdir
  end
end
