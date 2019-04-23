class RbenvRuby263 < FPM::Cookery::Recipe
  homepage 'https://www.ruby-lang.org/'
  name 'rbenv-ruby-2.6.3'
  version '1'

  source 'https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.3.tar.gz'
  sha256 '577fd3795f22b8d91c1d4e6733637b0394d4082db659fccf224c774a2b1c82fb'

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
    configure prefix: '/usr/lib/rbenv/versions/2.6.3'
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
