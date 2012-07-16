stingray_virtual_server "#{node["stingray"]["path"]}/zxtm/conf/vservers/#{node["stingray"]["vserver"]["name"]}" do
	enabled        "yes"
   action :configure
end
