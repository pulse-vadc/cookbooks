stingray_trafficipgroup "#{node["stingray"]["path"]}/zxtm/conf/flipper/#{node["stingray"]["trafficipgroup"]["name"]}" do

   enabled        node["stingray"]["trafficipgroup"]["enabled"]
   ipaddresses    node["stingray"]["trafficipgroup"]["ipaddresses"]
   keeptogether   node["stingray"]["trafficipgroup"]["keeptogether"]
   machines       node["stingray"]["trafficipgroup"]["machines"]
   slaves         node["stingray"]["trafficipgroup"]["slaves"]
   
   action :configure
end
