class RbenvRuby313 < FPM::Cookery::Recipe
  homepage 'https://www.ruby-lang.org/'
  name 'rbenv-ruby-3.1.3'
  version '1'

  source 'https://cache.ruby-lang.org/pub/ruby/3.1/ruby-3.1.3.tar.gz'
  sha256 '5ea498a35f4cd15875200a52dde42b6eb179e1264e17d78732c3a57cd1c6ab9e'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Ruby'

  build_depends 'autoconf', 'bison', 'build-essential', 'libssl-dev',
                'libyaml-dev', 'libreadline6-dev', 'zlib1g-dev',
                'libncurses5-dev', 'libffi-dev', 'libgdbm3', 'libgdbm-dev'

  depends 'rbenv', 'libssl1.0.0', 'libyaml-0-2', 'libreadline6', 'zlib1g',
          'libncurses5', 'libffi6', 'libgdbm3', 'libtinfo5'

  section 'interpreters'
  description 'Ruby version for use with rbenv.
Specific version of Ruby for use with a system install of rbenv.'

  def build
    ENV['CFLAGS'] = "-std=gnu99"
    configure prefix: '/usr/lib/rbenv/versions/3.1.3'
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
