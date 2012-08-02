stingray_virtual_server "#{node["stingray"]["path"]}/zxtm/conf/vservers/#{node["stingray"]["vserver"]["name"]}" do
   action :delete
end
