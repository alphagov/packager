Folder Structure for Package under Packager
-------------------------------------------

```
.
├── build
├── pkg
│   ├── pkg_name
│   │   ├── debian
│   │   │   ├── changelog
│   │   │   ├── compat
│   │   │   ├── control
│   │   │   ├── copyright
│   │   │   ├── patches
│   │   │   │   ├── 000n-this-is-a-patch.patch
│   │   │   ├── rules
│   │   │   ├── source
│   │   │   │   └── format
│   │   └── srcurl
```

* Packages reside under the _pkg_ folder (the above example has a package called `pkg_name`).
* _srcurl_ contains the path to a `.tar.gz` or `tar.bz2` file containing the package's source
* _debian_ is a folder containing metadata about how to build the source in the _srcurl_ archive (see ["Required files under the _debian_ directory"](http://www.debian.org/doc/manuals/maint-guide/dreq.en.html)). We use this bare minimum plus _compat_ and _source/format_:
    * _changelog_ contains information about the author and changes
      made. It should be in the Debian
      [changelog format](http://www.debian.org/doc/debian-policy/ch-source.html#s-dpkgchangelog)
    * _compat_ contains the compatibility mode for
      [debhelper](http://manpages.ubuntu.com/manpages/raring/en/man7/debhelper.7.html#contenttoc8). It's just a number - `7` for packages here at time of writing
    * _control_ contains package management information in the Debian [control file format](http://www.debian.org/doc/manuals/maint-guide/dreq.en.html#control). Content should adhere to the [Debian Policy Manual](http://www.debian.org/doc/debian-policy/ch-archive.html#s-subsections)
    * _rules_ contains rules used by `dpkg-buildpackage` for creating the
      actual package. Here you can customise input to the
      [debhelper command](http://www.tin.org/bin/man.cgi?section=7&topic=debhelper)
      using any of the [variables available](http://cdbs-doc.duckcorp.org/en/cdbs-doc.xhtml#id466191).
    * _source/format_ specifies the patch format, and (for us) usually contains only the content `3.0 (quilt)`

Should you need it, there is more [information about other files in the _debian_ folder](http://www.debian.org/doc/manuals/maint-guide/dother.en.html#compat).

`./build_source.py` collates source and metadata in the _build_ folder for Debian build tools to work with. The `.dsc` file you find here can be fed to `sbuild` to build the package. Once satisfied that the package builds correctly, you [submit to Launchpad](https://github.com/alphagov/packager/blob/master/doc/getting_started.md#submitting-to-launchpad) with `dput`.

