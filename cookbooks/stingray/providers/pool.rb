action :configure do

    # create the resource for the new pool and read the old configuration if there is one.
    log "Configuring pool #{new_resource.name}"
    nr = new_resource # Abbreviate new_resource
    cr = Pool.new(nr.name) # Read current resource from disk

    # Log to output the old and new nodes for ease of debug
    log "New nodes: #{nr.nodes}"
    log "Current nodes: #{cr.nodes}" if cr.nodes

    #pool_algorithm = node["stingray"]["algorithm"]

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
                :algorithm => pool_algorithm,
                #:algorithm => nr.algorithm ? nr.algorithm : cr.algorithm,
                :priority => nr.priority ? nr.priority : cr.priority
                )
    end

end

action :delete do

    log "Deleting pool #{new_resource.name}"

    file "#{new_resource.name}" do
        backup false
        action :delete
    end

end
