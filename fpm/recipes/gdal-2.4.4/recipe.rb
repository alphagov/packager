class GDAL < FPM::Cookery::Recipe
  description "Geospatial Data Abstraction Library"

  name "gdal"
  version "2.4.4"
  license "MIT"
  maintainer "GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>"
  homepage "http://www.gdal.org/"
  source "https://download.osgeo.org/gdal/#{version}/gdal-#{version}.tar.gz"
  sha256 "e6a2456907610639d73fc6a82bb10aa6fa02e2d03b24edacde34a16b6aa91080"

  def build
    configure
    make
  end

  def install
    make install: destdir
  end
end
