## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Define filebucket 'main':
filebucket { 'demo':
  server => 'puppet',
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'demo' }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

################################################################################
# Example:
#
#   Classifying based on a regex over the hostname:
# https://docs.puppetlabs.com/puppet/latest/reference/lang_node_definitions.html
#

node /\-dc01\-spine\d/ {
  # Datacenter 01 - Spine nodes
  $application_tier = "prod"
  hiera_include('classes')
}

node /\-dc01\-rack03\-tor\d/ {
  # Datacenter 01 - ToR nodes in rack 03
  $application_tier = "stage"
  hiera_include('classes')
}

node /\-dc01\-rack04\-tor\d/ {
  # Datacenter 01 - ToR nodes in rack 04
  $application_tier = "dev"
  hiera_include('classes')
}

node /\-dc01\-.*\-tor\d/ {
  # Datacenter 01 - ToR nodes (except racks 03-04 caught above)
  $application_tier = "prod"
  hiera_include('classes')
}

node /\-dc01\-/ {
  # Datacenter 01 - all-other nodes
  $application_tier = "prod"
  hiera_include('classes')
}

#
################################################################################

node /^veos\d+$/ {
  #
  # Use hiera for classification
  #
  hiera_include('classes')
}

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  #   include my_class

  notify { "Node ${::fqdn} is unclassified in ${::environment}/manifests/site.pp - ***default***": }

}
