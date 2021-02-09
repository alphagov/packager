class PostGIS < FPM::Cookery::Recipe
  description "PostGIS"

  name "postgresql-9.6-postgis-3.1.1"
  version "3.1.1"
  maintainer "GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>"
  source "https://download.osgeo.org/postgis/source/postgis-3.1.1.tar.gz"
  sha256 "0e96afef586db6939d48fb22fbfbc9d0de5e6bc1722d6d553d63bb41441a2a7d"

  chain_package true
  chain_recipes ["../proj-4.9.3/recipe", "../geos-3.9.0/recipe", "../gdal-2.4.4/recipe"]

  def build
    configure "--with-projdir=#{builddir}/../../proj-4.9.3/tmp-dest/usr/lib/", "--with-gdalconfig=#{builddir}/../../gdal-2.4.4/tmp-dest/usr/bin/gdal-config", "--with-geosconfig=#{builddir}/../../geos-3.9.0/tmp-dest/usr/bin/geos-config", "--without-protobuf", "--without-raster", :prefix => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
