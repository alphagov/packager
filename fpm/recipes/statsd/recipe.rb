class Statsd < FPM::Cookery::Recipe
  description 'Simple daemon for easy stats aggregation'

  name       'statsd'
  version    '0.8.0'
  license    'MIT'
  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  homepage   'https://github.com/etsy/statsd'
  source     'https://github.com/etsy/statsd.git', :with => :git, :tag => "v#{version}"

  arch     'all'

  build_depends 'nodejs', 'npm'
  depends       'nodejs'

  post_install   'post-install'
  post_uninstall 'post-uninstall'

  config_files '/etc/statsd/config.js'

  def build
  end

  def install
    share('statsd').install Dir['*']
    etc('statsd').install workdir('statsd.config.js'), 'config.js'
    etc('init').install workdir('statsd.upstart'), 'statsd.conf'
    etc('systemd/system').install workdir('statsd.service'), 'statsd.service'
  end
end
