class oxphys_fw::pre {

Firewall {
    require => undef
}

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }->
  firewall { "003 management access":
   proto  => "tcp",
   port =>  "22" ,
   action => "accept",
   source => '163.1.136.0/24' 
  }

#  firewall { "003 management access":
#  proto  => "tcp",
#  port => [ 22, 1839, 834, 835, 5666] ,
#  action => "accept",
#  }
#  firewall { "004 file system access tcp":
#  proto  => "tcp",
#  port => [ 2049, 111, 875, 32803, 892, 662] ,
#  action => "accept",
#  }->
#  firewall { "005 file system access udp":
#  proto  => "udp",
#  port => [ 32769 ,] ,
#  action => "accept",
#  }->
#  firewall {"006 ypbind":
#  proto  => ["tcp", "udp"],
#  port => [ 883] ,
#  action => "accept",
#  }

} 

