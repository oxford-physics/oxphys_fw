class oxphys_fw { 
  resources { "firewall":
  purge => true
  }

  

  include 'firewall'
  class { 'oxphys_fw::pre': }
  -> class {'oxphys_fw::post':}
#  include  oxphys_fw::fw_ssh
   include  oxphys_fw::fw 
}

