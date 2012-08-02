action :configure do

    log "Configuring pool #{new_resource.name}"
    nr = new_resource # Abbreviate new_resource
    cr = Pool.new(nr.name) # Read current resource from disk

    template nr.name do
        backup false
        cookbook "stingray"
        source "pool.erb"
        mode "0644"
        variables(
                :nodes => nr.nodes ? nr.nodes : cr.nodes,
                :disabled => nr.disabled ? nr.disabled : cr.disabled,
                :draining => nr.draining ? nr.draining : cr.draining,
                :monitors => nr.monitors ? nr.monitors : cr.monitors,
                :maxconns => nr.maxconns ? nr.maxconns : cr.maxconns,
                :persistence => nr.persistence ? nr.persistence : cr.persistence,
                :weightings => nr.weightings ? nr.weightings : cr.weightings,
                :algorithm => nr.algorithm ? nr.algorithm : cr.algorithm,
                :priority => nr.priority ? nr.priority : cr.priority
                )
    end

end

action :delete do

    log "Deleting pool #{new_resource.name}"

    file "#{new_resource.name}" do
        action :delete
    end

end
