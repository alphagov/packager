Getting started
===============

Prerequisites
-------------

Your host system should have [GnuPG](http://www.gnupg.org/index.html)
installed, and you should have
[generated a primary key pair](http://www.gnupg.org/gph/en/manual.html#AEN26).

Using the packager VM
---------------------

### Preparing

First, start the ubuntu package builder VM:

    $ vagrant up

Follow the instructions it gives you for setting up your environment, then

    $ vagrant ssh

### Using `build_source.py`

`build_source.py` collects source and metadata together into the _build_
directory such that `sbuild` can build them.

You need to create a `pkg/<package_name>` directory that describes your
package according to the prescribed [folder structure](folder_structure.md).

When you have created `pkg/<package_name>`, you can make source packages
by running `build_source.py <target>` in the `packager` directory. You will
be prompted to sign the source packages with your pre-existing GPG key.

    $ cd ~/packager
    $ ./build_source.py pkg/collectd

### Testing that the package builds with `sbuild`

To test that a binary package can be created from this source, you first need to
set up [sbuild](https://wiki.debian.org/sbuild):

    $ ./tools/sbuildinit  # follow the instructions about restarting your shell
    $ ./tools/sbuildinit

You can then build binary packages from the [`.dsc`](https://wiki.debian.org/dsc) file
produced by `./build_source.py`:

    $ sbuild -A -d precise-amd64 build/collectd/collectd_5.3.0-ppa4.dsc

Building packages for multiple series
-------------------------------------

Building packages for multiple series ("Precise", "Lucid", etc.) is slightly
more involved. See [`building_for_multiple_series.md`](building_for_multiple_series.md).

Submitting to Launchpad
-----------------------

Once you've verified that you're able to build a `.deb` from your `.dsc`, you can
[dput](https://help.launchpad.net/Packaging/PPA/Uploading) the original `.changes`
file for building on the [`gds/govuk`](https://launchpad.net/~gds/+archive/govuk)
Personal Package Archive
[(PPA)](http://en.wikipedia.org/wiki/Personal_Package_Archive) at Launchpad:

    $ dput ppa:gds/govuk build/collectd/collectd_5.3.0-ppa4_source.changes

Once you have uploaded the `.changes` file, you will get an email accepting
or rejecting your submission. Got an error? See
[common errors encountered during upload](https://help.launchpad.net/Packaging/UploadErrors).

**NOTE: read the [tips document](tips.md)**
