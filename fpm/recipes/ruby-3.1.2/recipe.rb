class RbenvRuby310 < FPM::Cookery::Recipe
  homepage 'https://www.ruby-lang.org/'
  name 'rbenv-ruby-3.1.2'
  version '1'

  source 'https://cache.ruby-lang.org/pub/ruby/3.1/ruby-3.1.2.tar.gz'
  sha256 '61843112389f02b735428b53bb64cf988ad9fb81858b8248e22e57336f24a83e'

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
    configure prefix: '/usr/lib/rbenv/versions/3.1.2'
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
