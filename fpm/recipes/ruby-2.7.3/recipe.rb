class RbenvRuby273 < FPM::Cookery::Recipe
  homepage 'https://www.ruby-lang.org/'
  name 'rbenv-ruby-2.7.3'
  version '1'

  source 'https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.3.tar.gz'
  sha256 '8925a95e31d8f2c81749025a52a544ea1d05dad18794e6828709268b92e55338'

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
    configure prefix: '/usr/lib/rbenv/versions/2.7.3'
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
