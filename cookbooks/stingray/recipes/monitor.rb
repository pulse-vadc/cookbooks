stingray_healthmonitor "#{node["stingray"]["path"]}/zxtm/conf/monitors/#{node["stingray"]["monitor"]["name"]}" do

   can_use_ssl          node["stingray"]["monitor"]["can_use_ssl"]
   delay                node["stingray"]["monitor"]["delay"]
   editable_keys        node["stingray"]["monitor"]["editable_keys"]
   factory              node["stingray"]["monitor"]["factory"]
   failures             node["stingray"]["monitor"]["failures"]
   scope                node["stingray"]["monitor"]["scope"]
   timeout              node["stingray"]["monitor"]["timeout"]
   type                 node["stingray"]["monitor"]["type"]
   use_ssl              node["stingray"]["monitor"]["use_ssl"]

   action :configure

end
