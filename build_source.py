#!/usr/bin/env python

import re
import os
import sys
import tarfile
import urllib
import shutil

from subprocess import Popen, PIPE

class Changelog(object):
  def __init__(self, path):
    self.path = path
    self.source = None
    self.version = None
    self.populate()

  def populate(self):
    p = Popen(['dpkg-parsechangelog', '-l' + self.path], stdout=PIPE)
    out = p.communicate()[0]
    matches = re.search(r"^Source: (.+)\nVersion: ([^-]+)", out)

    self.source = matches.group(1)
    self.version = matches.group(2)

  def debuild_tar_name(self):
    return "%s_%s.orig.tar.gz" % (self.source, self.version)

  def debuild_dir_name(self):
    return "%s-%s" % (self.source, self.version)


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

    self.build_path = os.path.join("build", cl.debuild_dir_name())
    self.expanded_dir = os.path.join(self.build_path, cl.debuild_dir_name())
    self.tarfile = os.path.join(self.build_path, cl.debuild_tar_name())

  def read_srcurl(self):
    src_url = os.path.join(self.pkg_path, "srcurl")

    with open(src_url, 'r') as f:
      self.url = f.read()

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

    if self.expanded_dir != top_dir:
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
  pkg_dir = sys.argv[1]
  debuild_args = os.environ.get("DEBUILD_ARGS")
  pkg = Package(pkg_dir, debuild_args)

  retcode = pkg.make()
  sys.exit(retcode)

if __name__ == "__main__":
  main()
