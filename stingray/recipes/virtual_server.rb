stingray_virtual_server "#{node["stingray"]["path"]}/zxtm/conf/vservers/#{node["stingray"]["vserver"]["name"]}" do

	enabled        node["stingray"]["vserver"]["enabled"]
	protocol       node["stingray"]["vserver"]["protocol"]
	port           node["stingray"]["vserver"]["port"]
	address        node["stingray"]["vserver"]["address"]
	pool           node["stingray"]["vserver"]["pool"]
	timeout        node["stingray"]["vserver"]["timeout"]
	rules          node["stingray"]["vserver"]["rules"]
	response_rules node["stingray"]["vserver"]["response_rules"]

   action :configure

end
