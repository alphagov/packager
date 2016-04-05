# Building packages for multiple series

It's not uncommon to want to build a package for multiple distribution series
("Trusty", "Precise", etc.) from a single set of debian control files. This is
actually pretty easy to do, but if you want to submit the resulting packages to
Launchpad there are a few more hoops to jump through. This document contains
instructions on building for multiple series.

## Version number

Launchpad will only permit one set of binaries for a given package at a given
version within a single PPA. This means that you cannot have, for example,
`collectd-5.3.0-ppa8` for Precise and `collectd-5.3.0-ppa8` for Trusty published
to the same PPA.

The simplest way to work around this is to put the distribution series code name
into the version number. A common pattern is to append `~trusty` or `~precise` as
appropriate.

I recommend you append `~trusty1` or similar, so that if you have to modify the
build scripts (and not the underlying package) in a way that affects only one
series, you have the ability to bump the version number to `~trusty2` and release
a new version.

## The process

Let's say you're have `collectd` at version `5.3.0-ppa8` and you wish to release
`5.3.0-ppa9` for both Trusty and Precise.

Make sure your package builds on all series you wish to build for:

    $ ./build_source.py pkg/collectd
    $ sbuild -A -d precise-amd64 build/collectd/collectd_5.3.0-ppa8.dsc
    $ sbuild -A -d trusty-amd64 build/collectd/collectd_5.3.0-ppa8.dsc

If this is successful, then for *both* Trusty and Precise, you will need to add
an entry to the changelog, rebuild the source package, and submit the `.changes`
file to Launchpad:

    $ cd build/collectd/collect-5.3.0/
    $ dch -v '5.3.0-ppa9~trusty1' -D trusty
    $ cd ../../../
    $ ./build_source.py pkg/collectd
    $ dput ppa:gds/govuk build/collectd/collectd_5.3.0-ppa9~trusty1_source.changes
    $ cd build/collectd/collect-5.3.0/
    $ dch -v '5.3.0-ppa9~precise1' -D precise
    $ cd ../../../
    $ ./build_source.py pkg/collectd
    $ dput ppa:gds/govuk build/collectd/collectd_5.3.0-ppa9~precise1_source.changes

Use the same changelog message for both versions. Usually the message should
denote the changes in the build, not the fact that the build is for one or other
distro series.
