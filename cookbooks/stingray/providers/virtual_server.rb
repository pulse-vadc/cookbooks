action :configure do
	log "Configuring virtual server #{new_resource.name}"

   nr = new_resource
   cr = VirtualServer.new(nr.name)

	template nr.name do
      cookbook "stingray"
		source "virtual_server.erb"
		mode "0644"
		variables(
			:enabled          => nr.enabled ? nr.enabled : cr.enabled,
			:port             => nr.port ? nr.port : cr.port,
			:protocol         => nr.protocol ? nr.protocol : cr.protocol,
			:pool             => nr.pool ? nr.pool : cr.pool,
			:address          => nr.address ? nr.address : cr.address,
			:response_rules   => nr.response_rules ? nr.response_rules : cr.response_rules,
			:rules            => nr.rules ? nr.rules : cr.rules,
			:timeout          => nr.timeout ? nr.timeout : cr.timeout,
			:ssl_decrypt      => nr.ssl_decrypt ? nr.ssl_decrypt : cr.ssl_decrypt,
			:ssl_certificate  => nr.ssl_certificate ? nr.ssl_certificate : cr.ssl_certificate
		)
	end

end

action :delete do

   log "Deleting virtual server #{nr.name}"
   file nr.name do
      action :delete
   end

end
