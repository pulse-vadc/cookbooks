

# Create a new service - basically the same as the manage a new serivce wizard does
# (From the Stingray GUI).

# XXX Perhaps we should invoke a differente recipe for SSL Keys?
template "#{stingray.dir}/zxtm/conf/ssl/server_keys/#{ssl_private_key}" do
	source "ssl_private_server_key"
	mode "0600"
end

template "#{stingray.dir}/zxtm/conf/ssl/server_keys/#{ssl_public_key}" do
	source "ssl_public_server_key"
	mode "0644"
end

template "#{stingray.dir}/zxtm/conf/pools/#{node.vhost}" do
	source "pools.erb"
	mode "0644"
end


