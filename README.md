# pxp-agent-vanagon

The pxp-agent-vanagon was created to build [pxp-agent](https://github.com/puppetlabs/pxp-agent/) and prepare a .tar.gz that will be used in [puppet-agent](https://github.com/puppetlabs/puppet-agent).

The project is built using [vanagon](https://github.com/puppetlabs/vanagon), a packaging utility.

**NOTE: the resulted archive cannot be used to run pxp-agent, it is created to be used in the puppet-agent build process.**

Available components in the final archive include pxp-agent, cpp-hocon, cpp-pcp-client, leatherman.
See the [configs/components directory](configs/components) for a full list.

## Build instructions

To build the pxp-agent project:

- Ruby and [bundler](http://bundler.io/) must be installed
- You must have root ssh access to a VM to build on

First, install the gem dependencies:

```
$ bundle install
```

Next, if you are building on infrastructure outside of Puppet, you will need to
modify some package dependency names in the [configs directory](configs). Any
references to pl-gcc, pl-cmake, pl-yaml-cpp, etc. in these files will need to
be changed to refer to equivalent installable packages on your target platform.
In many cases, you can drop the `pl-` prefix and ensure that `CXX` or `CC`
environment variables are what they should be.

You can build the project using vanagon like this:

```
$ bundle exec build pxp-agent <platform> <target-vm>
```

Where:
- `platform` is the name of a platform supported by vanagon and configured in
  the [configs/platforms](configs/platforms) directory
- `target-vm` is the hostname of the VM you will build on. You must have root
  ssh access configured for this host, and it must match the target platform.
