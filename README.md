# GOV.UK packaging

This repo creates packages for GOV.UK.

## fpm

This is the way we create packages now. It is easier than using debuild
because it's just one command instead of creating Debian packaging files
by hand.

## legacy-debuild

This is how we used to do things.

## test-your-package

Used for testing your created package. Relies on Docker.

Set up:

```
$ cd test-your-package
$ docker build -t trusty .
```

Check your setup is working:

```
$ docker run -v ~/Downloads:/home -w /home trusty ls
# should see your downloaded package in the output
```

Verify that your package can be imported:

```
$ docker run -v ~/Downloads:/home -w /home trusty sudo dpkg -i ./rbenv-ruby-2.6.9_1_amd64.deb
Selecting previously unselected package rbenv-ruby-2.6.9.
(Reading database ... 19423 files and directories currently installed.)
Preparing to unpack ./rbenv-ruby-2.6.9_1_amd64.deb ...
Unpacking rbenv-ruby-2.6.9 (1) ...
Setting up rbenv-ruby-2.6.9 (1) ...
```

If there are no errors, your package is good to go.
