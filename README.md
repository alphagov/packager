packager
========

This repository contains some scripts to aid the building of debian source
packages (.dsc) files for submission to Launchpad or another buildd server for
building into binary debian packages (.deb)

Usage
-----

First, start the ubuntu package builder VM:

    $ vagrant up

Follow the instructions it gives you for setting up your environment. Then,
logged into the box, you should be able to make source packages by running `make
<target>` in the `packager` directory:

    $ cd ~/packager
    $ make collectd

To test a binary package build, you first need to set up sbuild:

    $ ./tools/sbuildinit  # follow the instructions about restarting your shell
    $ ./tools/sbuildinit

You can then build binary packages from .dsc files:

    $ sbuild -A -d precise-amd64 build/collectd/collectd_5.3.0-ppa4.dsc
