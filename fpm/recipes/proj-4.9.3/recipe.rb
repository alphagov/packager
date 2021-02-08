class PROJ < FPM::Cookery::Recipe
  description "PROJ"

  name "proj"
  version "4.9.3"
  maintainer "GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>"
  source "https://download.osgeo.org/proj/proj-#{version}.tar.gz"
  sha256 "6984542fea333488de5c82eea58d699e4aff4b359200a9971537cd7e047185f7"

  chain_package true
  chain_recipes ["../sqlite-3/recipe"]

  def build
    ENV["SQLITE3_CFLAGS"] = "#{builddir}/../../sqlite-3/tmp-build/sqlite-autoconf-3340100/"
    ENV["SQLITE3_LIBS"] = "#{builddir}/../../sqlite-3/tmp-build/sqlite-autoconf-3340100/.libs/"
    ENV["PATH"] = "#{builddir}/../../sqlite-3/tmp-build/sqlite-autoconf-3340100:#{ENV["PATH"]}"
    configure "--disable-tiff"
    make
  end

  def install
    make install: destdir
  end
end
