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
  firewallchain { 'puppet:filter:IPv4':
    ensure  => present,
  }->
  firewall { '001 puppet firewall CHAIN':
    chain   => 'INPUT',
    jump    => 'puppet',
  }->

  firewall { '001 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
    chain => puppet,
  }->
  firewall { '002 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
    chain => puppet,
  }->
  firewall { '003 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
    chain => puppet,
  }

 firewall { "004 nagios access": 
   proto => "tcp", 
   dport=> "5666",
   action => accept,
   source => '163.1.136.128/32',
   chain => puppet,
 }
#  firewall { "003 management access":
#  proto  => "tcp",
#  dport => [ 1839, 834, 835] ,
#  action => "accept",
#  }
#  firewall { "004 file system access tcp":
#  proto  => "tcp",
#  dport => [ 2049, 111, 875, 32803, 892, 662] ,
#  action => "accept",
#  }->
#  firewall { "005 file system access udp":
#  proto  => "udp",
#  dport => [ 32769 ,] ,
#  action => "accept",
#  }->
#  firewall {"006 ypbind":
#  proto  => ["tcp", "udp"],
#  dport => [ 883] ,
#  action => "accept",
#  }

} 

