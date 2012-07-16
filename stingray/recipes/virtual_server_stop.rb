stingray_virtual_server "#{node["stingray"]["path"]}/zxtm/conf/vservers/#{node["stingray"]["virtual_server"]["name"]}" do
	action :stop
end
