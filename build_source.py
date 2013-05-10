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

class Package(object):

  def __init__(self, pkg_name):
    self.name = pkg_name
    self.pkg_path = os.path.join("pkg", pkg_name)
    self.changelog_path = os.path.join(self.pkg_path, "debian", "changelog")
    self.build_path = os.path.join("build", pkg_name)

    self.url = None
    self.tarfile = None
    self.expanded_dir = None

    self.read_srcurl()

  def read_srcurl(self):
    src_url = os.path.join(self.pkg_path, "srcurl")

    with open(src_url, 'r') as f:
      self.url, expanded_dir = f.read().split()

    self.expanded_dir = os.path.join(self.build_path, expanded_dir)
    self.tarfile = os.path.join(
        self.build_path,
        Changelog(self.changelog_path).debuild_tar_name()
    )

  def make(self):
    self.create_build_dir()
    self.fetch_tarball()
    self.expand_tarball()
    self.copy_debian()
    self.debuild()
    
  def create_build_dir(self):
    print "=> creating build directory"
    if not os.path.isdir(self.build_path):
      os.mkdir(self.build_path)

  def fetch_tarball(self):
    print "=> fetching tarball"
    if not os.path.isfile(self.tarfile):
      urllib.urlretrieve(self.url, self.tarfile)

  def expand_tarball(self):
    print "=> expanding tarball"
    with tarfile.open(self.tarfile) as tar:
      tar.extractall(path=self.build_path)

  def copy_debian(self):
    print "=> copy new debian directory"
    src_dir = os.path.join(self.pkg_path, "debian")
    dst_dir = os.path.join(self.expanded_dir, "debian")

    if os.path.exists(dst_dir):
      shutil.rmtree(dst_dir)
    shutil.copytree(src_dir, dst_dir)

  def debuild(self):
    print "=> debuild..."
    command = ["debuild", "-S"]
    Popen(command, cwd=self.expanded_dir)


def main():
  pkg_name = sys.argv[1]
  pkg = Package(pkg_name)
  pkg.make()

if __name__ == "__main__":
  main()
