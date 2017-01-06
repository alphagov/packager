# fpm

Packages built for GOV.UK using [fpm](https://github.com/jordansissel/fpm).

## Running fpm-cookery

```
cd recipes/terraform/
bundle exec fpm-cook --target deb
```

## Building LocksmithCtl

Because the [locksmithctl](https://github.com/coreos/locksmith) recipe compiles a binary it should be compiled in an environment that matches the one which it will be run on. To aid this there is a xenial vagrant box which can be started using

```
vagrant up
```

The locksmith recipe can then be built as usual by navigating to the `/vagrant` directory
