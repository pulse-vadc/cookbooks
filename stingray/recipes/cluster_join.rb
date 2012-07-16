if node["stingray"]["join_cluster_host"]

   stingray node["stingray"]["name"] do

      accept_license    node["stingray"]["accept_license"]
      admin_user        node["stingray"]["admin_user"]
      admin_pass        node["stingray"]["admin_pass"]
      license_key       node["stingray"]["license_key"]
      join_cluster_host node["stingray"]["join_cluster_host"]
      join_cluster_port node["stingray"]["join_cluster_port"]
      path              node["stingray"]["path"]
      tmpdir            node["stingray"]["tmpdir"]
      action :join_cluster

   end

end
