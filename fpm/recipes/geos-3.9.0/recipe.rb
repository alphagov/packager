class GEOS < FPM::Cookery::Recipe
  description "GEOS"

  name "geos"
  version "3.9.0"
  maintainer "GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>"
  source "http://download.osgeo.org/geos/geos-#{version}.tar.bz2"
  sha256 "bd8082cf12f45f27630193c78bdb5a3cba847b81e72b20268356c2a4fc065269"

  def build
    configure
    make
  end

  def install
    make install: destdir
  end
end
