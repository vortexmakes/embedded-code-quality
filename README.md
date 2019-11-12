# C unit testing environment with Ceedling and friends
It includes other useful tools like static code analyzers and beautifier

## To use with bash shell
```bash
$ docker run --rm -v local/path/to/project:/usr/project -ti leanfrancucci/ceedling
```

## Assuming Ceedling project already setup, in CI use:
```bash
$ docker run --rm -v local/path/to/project:/usr/project -ti leanfrancucci/ceedling ceedling test:all
```

## Todo
- Integrate static code analyzers' scripts (uno, cppcheck, ...)
- Integrate beautifier script (uncrustify)
- 
