define oxphys_fw::fw_range ($ip, $port, $proto='tcp') {
#  $name = $ip 
 firewall { "${port} - ${ip} - $proto":
   proto    => $proto,
   state    => ['NEW'],
   action   => 'accept',
   dport     => $port,
   source   => $ip,
   require  => Class['oxphys_fw'] ,
   chain => puppet,
 } 

}
