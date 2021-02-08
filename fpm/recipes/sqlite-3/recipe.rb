class SQLite < FPM::Cookery::Recipe
  description "SQLite"

  name "sqlite"
  version "3.34.1"
  maintainer "GOV.UK <govuk-dev@digital.cabinet-office.gov.uk>"
  source "https://sqlite.org/2021/sqlite-autoconf-3340100.tar.gz"
  sha256 "2a3bca581117b3b88e5361d0ef3803ba6d8da604b1c1a47d902ef785c1b53e89"

  def build
    configure
    make
  end

  def install
    make install: destdir
  end
end
