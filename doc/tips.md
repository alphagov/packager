# Tips

## debuild arguments

Additional arguments can be passed to `build_source.py`/`debuild` by using
the environment variable `DEBUILD_ARGS`.

### Unsigned source packages

Useful for testing packages locally before rebuilding for submission:
```
DEBUILD_ARGS="-uc -us" ./build_source.py pkg/foo
```

### Sign against a different GPG key

Useful if your GPG key email address differs from the changelog entry:
```
DEBUILD_ARGS="-k12345678" ./build_source.py pkg/foo
```

## sbuild

### Inspect a failed build

Instruct `sbuild` to not purge the build directory or chroot session:
```
sbuild --purge never --purge-session never [...]
```

Attach to the session and look in the `/build` directory:
```
vagrant@packager:~/packager$ schroot -r -c
precise-amd64-7c376c42-0b8d-49ac-abb2-0dd659a11551
(precise-amd64)vagrant@packager:~/packager$ ls -al /build
total 12
drwxrws--- 1 sbuild  sbuild 4096 May 14 16:09 .
drwxr-xr-x 1 root    root   4096 May 14 16:09 ..
drwxr-x--- 4 vagrant sbuild 4096 May 14 16:14 foo-E8JFbs
```
