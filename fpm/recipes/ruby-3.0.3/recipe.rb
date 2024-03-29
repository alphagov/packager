class RbenvRuby303 < FPM::Cookery::Recipe
  homepage 'https://www.ruby-lang.org/'
  name 'rbenv-ruby-3.0.3'
  version '1'

  source 'https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.3.tar.gz'
  sha256 '3586861cb2df56970287f0fd83f274bd92058872d830d15570b36def7f1a92ac'

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
    configure prefix: '/usr/lib/rbenv/versions/3.0.3'
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
