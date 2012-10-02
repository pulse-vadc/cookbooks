action :configure do

    log "Configuring Health monitor #{new_resource.name}"
    nr = new_resource # Abbreviate new_resource
    cr = Monitor.new(nr.name) # Read current resource from disk

    template nr.name do
        cookbook "stingray"
        source "monitor.erb"
        mode "0644"
            variables(
                :can_use_ssl => defined?(nr.can_use_ssl).class != NilClass ? nr.can_use_ssl : cr.can_use_ssl,
                :delay => defined?(nr.delay).class != NilClass ? nr.delay : cr.delay,
                :editable_keys => defined?(nr.editable_keys).class != NilClass ? nr.editable_keys : cr.editable_keys,
                :factory => defined?(nr.factory).class != NilClass ? nr.factory : cr.factory,
                :failures => defined?(nr.failures).class != NilClass ? nr.failures : cr.failures,
                :scope => defined?(nr.scope).class != NilClass ? nr.scope : cr.scope,
                :timeout => defined?(nr.timeout).class != NilClass ? nr.timeout : cr.timeout,
                :type => defined?(nr.type).class != NilClass ? nr.type : cr.type,
                :use_ssl => defined?(nr.use_ssl).class != NilClass ? nr.use_ssl : cr.use_ssl
                )
	end

end

action :delete do

	log "Deleting monitor #{new_resource.name}"
	file "#{new_resource.name}" do
		action :delete
	end

end
