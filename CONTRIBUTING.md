# Contributing to the project

The following document summarizes some core concepts around the development of
the class scheduler, and should be read before contributing to the project.
Suggestions of change to this document are always welcome.

## Configuring the development environment

Installation of a compatible [clingo](https://potassco.org/clingo/) solver can
be done using the Python package manager [pip](https://pypi.org/project/pip/).
We recommend the use of virtual environments, since it greatly reduces the
number of dependency problems during development. The following Bash snippet
creates and configures a working development environment using Python's
[venv](https://docs.python.org/3/library/venv.html) :

```bash
# Create a virtual environment in the hidden directory ".venv"
python -m venv .venv
# Activate the virtual environment and install dependencies
source .venv/bin/activate
pip install -r requirements.txt
# Deactivates the virtual environment
deactivate
```

The clingo solver can now be run by:

1. Activating the python virtual environment;
2. Running the executable with `python -m clingo [clingo args]`.
