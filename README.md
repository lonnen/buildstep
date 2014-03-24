# Doozer

Builds dockers that run tests. Forked from the Dokku buildstep component, and for compatibility with Davis-CI's dokku libs it still mirrors the buildstep api file names.

Parses `.travis.yml` files and respects a very minimal subset of the options available to get things running. Right now that means only `env` vars and the `script` entry point. There is no build matrix; all env vars are dumped in at once. It doesn't respect the pre-build install steps that you might usually use to set up your deps, or the language field. Instead all projects default to a an omni-env with a bunch of stuff on the PATH.

Currently supports the following interpreters:

    java       1.6.0_27
    ruby       1.9.3
    ruby1.8    1.8.7
    python     2.7.4
    python3    3.3.1
    node       0.10.25

as well as whatever binaries you want to compile against an otherwise stock ubuntu:raring machine. Vendor those and any deps you have before submitting.

## Requirements

 * Docker
 * Git


## Building Doozer

The buildstep script relies on a base container that needs to be built. It must be created before you can use the buildstep script. To create it, run:

    $ make build

This will create a container called `lonnen/buildstep` that contains the builder script that will actually perform the build.

## Building an App

Running the buildstep script will take an application tar via STDIN and an application container name as an argument. It will put the application in a new container based on `lonnen/buildstep` with the specified name. Then it runs the builder script inside the container, which creates the docker testrunner.

    $ cat myapp.tar | ./buildstep myapp

If you didn't already have an application tar, you can create one on the fly.

    $ tar cC /path/to/your/app . | ./buildstep myapp

The resulting container has a built app ready to go. Run your tests with:

    $ docker run -d myapp /bin/bash -c "/start"

## Extending and Developing

Buildstep does not support `.travis.yml` entry points for installing additional packages. Vendor what you can. If you need to make fundamental changes you can add additional packages in `stack/packages` or `stack/prepare` and rebuild buildstep.

Modifications to `stack/builder` do not require a recompile of buildstep, and should take effect the next time you build a container.

## License

MIT
