stingray node["stingray"]["name"] do
   accept_license node["stingray"]["accept_license"]
   admin_pass     node["stingray"]["admin_pass"]
   license_key    node["stingray"]["license_key"]
   tmpdir         node["stingray"]["tmpdir"]
   java_enabled   node["stingray"]["java_enabled"]
   path           node["stingray"]["path"]
   ec2            node["stingray"]["ec2"]
   action [:new_cluster]
end
