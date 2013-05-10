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
    matches = re.search(r"^Source: (.+)\nVersion: (.+)-", out)

    self.source = matches.group(1)
    self.version = matches.group(2)

  def debuild_tar_name(self):
    return "%s_%s.orig.tar.gz" % (self.source, self.version)

  def debuild_dir_name(self):
    return "%s-%s" % (self.source, self.version)

class Package(object):

  def __init__(self, pkg_name):
    self.name = pkg_name
    self.pkg_path = os.path.join("pkg", pkg_name)
    self.build_path = os.path.join("build", pkg_name)

    self.url = None
    self.tarfile = None
    self.expanded_dir = None

    self.read_srcurl()
    self.read_changelog()

  def read_changelog(self):
    changelog_path = os.path.join(self.pkg_path, "debian", "changelog")

    cl = Changelog(changelog_path)
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
    self.__debuild()
    
  def __create_build_dir(self):
    print "=> creating build directory"
    if not os.path.isdir(self.build_path):
      os.mkdir(self.build_path)

  def __fetch_tarball(self):
    print "=> fetching tarball"
    if not os.path.isfile(self.tarfile):
      urllib.urlretrieve(self.url, self.tarfile)

  def __expand_tarball(self):
    print "=> expanding tarball"
    with tarfile.open(self.tarfile) as tar:
      tar.extractall(path=self.build_path)

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
    p = Popen(command, cwd=self.expanded_dir)
    p.wait()


def main():
  pkg_name = sys.argv[1]
  pkg = Package(pkg_name)
  pkg.make()

if __name__ == "__main__":
  main()
