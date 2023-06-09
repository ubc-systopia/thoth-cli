# thoth-cli

Command-line interface for the thoth provenance collection tool.

Install the thoth service here: https://github.com/ubc-systopia/thoth

### Build

To build project run:

`make all`

### Install

To install the thoth cli:

`make install`

### Run

First, start the thoth service using instructions [here](https://github.com/ubc-systopia/thoth).

Add directories to track using: 

`thoth --track-dir <directory_name>`

The provenance log will be stored in the `/tmp/` directory.
