#!/usr/bin/env python
"""
Utility to create a Debian source package.

This takes our internally version controlled `debian/` directory and a
`srcurl` file containing a URL to the original source tarball, and turns
them into a source package consisting of `.dsc` and `.tar.gz` files.

This *appears* to be the sanest way to maintain our own packaging
metadata against upstream releases. It doesn't currently support cleaning
the `build/` directory.

The resulting source package can be built with `sbuild`.
"""

import re
import os
import sys
import tarfile
import urllib
import shutil

from subprocess import Popen, PIPE

class Changelog(object):
  """
  Parse a `debian/changelog` file.

  Has methods to return strings representing the directory and tarball names
  that debuild expects.
  """
  def __init__(self, path):
    self.path = path
    self.source = None
    self.version = None
    self.populate()

  def populate(self):
    p = Popen(['dpkg-parsechangelog', '-l' + self.path], stdout=PIPE)
    out = p.communicate()[0]
    matches = re.search(r"^Source: (.+)\nVersion: (?:\d+:)?([^-\n]+)", out)

    self.source = matches.group(1)
    self.version = matches.group(2)


class Package(object):
  def __init__(self, pkg_dir, debuild_args=None):
    self.debuild_args = debuild_args

    self.pkg_path = pkg_dir
    self.build_path = None

    self.url = None
    self.tarfile = None
    self.expanded_dir = None

    self.read_srcurl()
    self.read_changelog()

  def read_changelog(self):
    changelog_path = os.path.join(self.pkg_path, "debian", "changelog")
    cl = Changelog(changelog_path)

    debuild_dir_name = "%s-%s" % (cl.source, cl.version)
    self.build_path = os.path.join("build", debuild_dir_name)
    self.expanded_dir = os.path.join(self.build_path, debuild_dir_name)

    zip_suffix = "bz2" if self.url.endswith(".bz2") else "gz"
    tar_filename = "%s_%s.orig.tar.%s" % (cl.source, cl.version, zip_suffix)
    self.tarfile = os.path.join(self.build_path, tar_filename)

  def read_srcurl(self):
    src_url = os.path.join(self.pkg_path, "srcurl")

    with open(src_url, 'r') as f:
      self.url = f.read().rstrip()

  def make(self):
    self.__create_build_dir()
    self.__fetch_tarball()
    self.__expand_tarball()
    self.__copy_debian()
    return self.__debuild()

  def __create_build_dir(self):
    msg = "=> creating build directory"
    if os.path.isdir(self.build_path):
      print "%s [noop]" % msg
      return

    print msg
    os.mkdir(self.build_path)

  def __fetch_tarball(self):
    msg = "=> fetching tarball"
    if os.path.isfile(self.tarfile):
      print "%s [noop]" % msg
      return

    print msg
    urllib.urlretrieve(self.url, self.tarfile)

  def __expand_tarball(self):
    print "=> expanding tarball"
    with tarfile.open(self.tarfile) as tar:
      top_dir = os.path.join(
        self.build_path,
        os.path.commonprefix(tar.getnames())
      )
      shutil.rmtree(top_dir, ignore_errors=True)
      tar.extractall(path=self.build_path)

    if  os.path.normpath(self.expanded_dir) != os.path.normpath(top_dir):
      shutil.rmtree(self.expanded_dir, ignore_errors=True)
      shutil.move(top_dir, self.expanded_dir)

  def __copy_debian(self):
    print "=> copy new debian directory"
    src_dir = os.path.join(self.pkg_path, "debian")
    dst_dir = os.path.join(self.expanded_dir, "debian")

    if os.path.exists(dst_dir):
      shutil.rmtree(dst_dir)
    shutil.copytree(src_dir, dst_dir)

  def __debuild(self):
    print "=> debuild..."
    command = ["debuild", "-S"]

    if self.debuild_args:
      command.extend(self.debuild_args.split())

    p = Popen(command, cwd=self.expanded_dir)
    retcode = p.wait()
    return retcode

def main():
  if len(sys.argv) != 2:
    sys.stderr.write("Usage: %s <path_containing_debian_directory>\n" % sys.argv[0])
    sys.exit(2)

  pkg_dir = sys.argv[1]
  if not os.path.isdir(os.path.join(pkg_dir, "debian")):
    sys.stderr.write("ERROR: %r does not contain a debian/ directory\n" % pkg_dir)
    sys.exit(2)

  debuild_args = os.environ.get("DEBUILD_ARGS")
  pkg = Package(pkg_dir, debuild_args)

  retcode = pkg.make()
  sys.exit(retcode)

if __name__ == "__main__":
  main()
