class RubyHieraEyamlGpg < FPM::Cookery::Recipe
  # Do not use the RubyGemRecipe class as that will not cope with
  # environments running rbenv. Instead write a custom recipe that will
  # install ruby gems in standard ruby_vendors directory.
  name    'rubygem-hiera-eyaml-gpg'
  version '0.4'
  homepage 'https://github.com/sihil/hiera-eyaml-gpg'

  source "https://github.com/sihil/hiera-eyaml-gpg/archive/v#{version}.tar.gz"
  sha256 "bd1d3fb2197af14420efa9e598e99d6fc9b659dd429e58c70ea7c457b742dd16"

  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'

  depends 'hiera-eyaml (>=1.3.8)', 'ruby-gpgme (>=2.0.0)'

  def build
  end

  def install
    full_name = "hiera-eyaml-gpg-#{version}"
    safesystem "mkdir -p #{destdir}/usr/lib/ruby/vendor_ruby"
    safesystem "cp -fR #{builddir}/#{full_name}/lib/* #{destdir}/usr/lib/ruby/vendor_ruby/."
  end
end
