Folder Structure for Package under Packager
-------------------------------------------
``
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
│   │   │   │   ├── 000n-this-is-a-patche.patch
│   │   │   ├── rules
│   │   │   ├── source
│   │   │   │   └── format
│   │   └── srcurl
``

* Packages reside under _pkg_ folder (e.g. pkg_name above).
* _srcurl_ file contains the path to tar.gz for the package
* _debian_ folder contains meta data about package for making the
  debian from tar.gz
    * _changelog_ contains information about the author and changes
      made. For more information on changelog look
      [here](http://www.debian.org/doc/debian-policy/ch-source.html#s-dpkgchangelog)
    * _compact_ file talks about the compatibility mode for debhelper
      [here](http://manpages.ubuntu.com/manpages/raring/en/man7/debhelper.7.html#contenttoc8)
    * _control_ contains package management information. Some
      helpful links are:
        * http://www.debian.org/doc/manuals/maint-guide/dreq.en.html#control
        * http://www.debian.org/doc/debian-policy/ch-archive.html#s-subsections
    * You can get more information about other files and folders
      [here](http://www.debian.org/doc/manuals/maint-guide/dother.en.html#compat). Another useful link [here](http://www.debian.org/doc/manuals/maint-guide/dreq.en.html)

The build folder's contains intermediary files, generated while building
(using build_source script).
