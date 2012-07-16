stingray_persistence "#{node["stingray"]["path"]}/zxtm/conf/persistence/#{node["stingray"]["persistence"]["name"]}" do

   type     node["stingray"]["persistence"]["type"]
   cookie   node["stingray"]["persistence"]["cookie"]

   action :configure

end
