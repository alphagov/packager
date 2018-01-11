class RbenvRuby250 < FPM::Cookery::Recipe

  homepage 'https://www.ruby-lang.org/'
  name 'rbenv-ruby-2.5.0'
  version '1'

  source 'https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz'
  sha256 '46e6f3630f1888eb653b15fa811d77b5b1df6fd7a3af436b343cfe4f4503f2ab'

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  license 'Ruby'

  build_depends 'autoconf', 'bison', 'build-essential', 'libssl-dev',
                'libyaml-dev', 'libreadline6-dev', 'zlib1g-dev',
                'libncurses5-dev', 'libffi-dev', 'libgdbm3', 'libgdbm-dev'

  depends 'rbenv', 'libssl1.0.0', 'libyaml-0-2', 'libreadline6', 'zlib1g',
          'libncurses5', 'libffi6', 'libgdbm3', 'libtinfo5'

  section 'interpreters'
  description 'Ruby version for use with rbenv
Specific version of Ruby for use with a system install of rbenv.'

  def build
    configure prefix: '/usr/lib/rbenv/versions/2.5.0'
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
