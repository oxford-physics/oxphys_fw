class oxphys_fw::pre {

  Firewall {
    require => undef,
  }
  # Default firewall rules

  firewall { "000 management access":
   proto  => "tcp",
   dport =>  "22" ,
   action => "accept",
   source => '163.1.136.0/24' ,
   chain => INPUT,
  }->
  firewallchain { 'manualoverrides:filter:IPv4':
    ensure  => present,
    purge   => false,
  }->
  firewall { '001 manual override firewall INPUT CHAIN rules placed here will not be managed by puppet':
    chain   => 'INPUT',
    jump    => 'manualoverrides',
  }->
  firewallchain { 'puppet:filter:IPv4':
    ensure  => present,
    purge => true,
  }->
  firewall { '002 puppet firewall CHAIN':
    chain   => 'INPUT',
    jump    => 'puppet',
  }->

  firewall { '010 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
    chain => puppet,
  }->
  firewall { '011 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
    chain => puppet,
  }->
  firewall { '012 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
    chain => puppet,
  }

 firewall { "013 nagios access": 
   proto => "tcp", 
   dport=> "5666",
   action => accept,
   source => '163.1.136.128/32',
   chain => puppet,
 }

} 

