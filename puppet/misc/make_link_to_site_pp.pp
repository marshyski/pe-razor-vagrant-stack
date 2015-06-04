
file { [ '/etc/puppetlabs/puppet/environments', '/etc/puppetlabs/puppet/environments/production', '/etc/puppetlabs/puppet/environments/production/manifests' ] :
  ensure => directory,
}

file { '/etc/puppetlabs/puppet/environments/production/manifests/site.pp':  
  ensure => link, 
  target => '/tmp/puppet/manifests/site.pp',
}

file { '/etc/puppetlabs/puppet/manifests/site.pp':  
  ensure => link, 
  target => '/tmp/puppet/manifests/site.pp',
}
