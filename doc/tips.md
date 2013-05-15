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
