class GDAL < FPM::Cookery::Recipe
  description "Geospatial Data Abstraction Library"

  name "gdal"
  version "1.11.5"
  license "MIT"
  maintainer "GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>"
  homepage "http://www.gdal.org/"
  source "https://download.osgeo.org/gdal/#{version}/gdal-#{version}.tar.gz"
  sha256 "49f99971182864abed9ac42de10545a92392d88f7dbcfdb11afe449a7eb754fe"

  def build
    configure
    make
  end

  def install
    make install: destdir
  end
end
