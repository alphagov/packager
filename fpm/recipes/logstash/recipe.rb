class Logstash < FPM::Cookery::Recipe
  description 'Logstash'

  name       'logstash'
  version    '1.1.9'
  license    'MIT'
  maintainer 'GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>'
  source     'file:///var/tmp/logstash-1.1.9-monolithic.jar'

  arch     'all'

  def build
  end

  def install
    var('tmp').install 'logstash-1.1.9-monolithic.jar'
  end
end
