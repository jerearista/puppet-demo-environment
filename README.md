# Puppet demo Environment

This is an environment (intended for use with puppet directory-environments) to
setup basic demos of Arista EOS types, providers, plugins, and such.

If not puppet is not configured for directory environments, then you may need to further adjust puppet.conf and the included environments.conf.

## Usage

```
cd /etc/puppet/environments/
git clone https://github.com/jerearista/puppet-demo-environment demo
git submodule init
```

Verify that your /etc/puppet/hiera.yaml has similar content to the included [hiera.yaml](hiera.yam).   You may, also, want to create a link between /etc/puppet/hiera.yaml and /etc/hiera.yaml.

```
ln -s /etc/puppet/hiera.yaml /etc/hiera.yaml
```

## From the client

On the client node, add the `--environment demo` command line option to `puppet agent` or configure `environment=demo` in /etc/puppetlabs/puppet/puppet.conf:

```
Arista# bash sudo puppet agent --environment demo --test
```

