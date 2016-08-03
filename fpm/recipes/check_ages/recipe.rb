class CheckAges < FPM::Cookery::Recipe
  description 'Nagios plugin to alert on "old" files in a given directory.'
  homepage    'https://github.com/deanwilson/nagios-plugins/tree/master/check_ages'
  maintainer  'Dean Wilson <dean.wilson@gmail.com>'

  name    'nagios-plugins-check_ages'
  version '0.1.0'
  license 'GPLv2'
  arch    'all'

  source 'https://github.com/deanwilson/nagios-plugins.git',
    with: 'git',
    sha: '4073ee1bd36c8d59afef0a734c7c6867e50d11ed'

  def build
  end

  def install
    root('/usr/lib64/nagios/plugins').install 'check_ages/check_ages'
  end
end
