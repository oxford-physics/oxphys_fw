class oxphys_fw::fw {
  $ip_range = hiera_hash ('oxphys_fw::fw::ip_range', {}) 
  create_resources(::oxphys_fw::fw_range, $ip_range) 
}
