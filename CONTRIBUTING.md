# Contributing to the project

The following document summarizes some core concepts around the development of
the class scheduler, and should be read before contributing to the project.
Suggestions of change to this document are always welcome.

## Configuring the development environment

Installation of a compatible [clingo](https://potassco.org/clingo/) solver and
all of the Python dependencies can be done using [docker
compose](https://docs.docker.com/compose/). There are currently two relevant
services, `dev` and `test`, that can be used to run a interactive shell in the
preconfigured environment and to run the constraints unit test routine,
respectively

The following `bash` snippet runs a `bash` shell in the development environment:

```bash
docker compose run --rm dev bash
```
The following `bash` snippet runs all tests for the project:

```bash
docker compose up test
```


