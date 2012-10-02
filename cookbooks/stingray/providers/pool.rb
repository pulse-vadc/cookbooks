action :configure do

    # create the resource for the new pool and read the old configuration if there is one.
    log "Configuring pool #{new_resource.name}"
    nr = new_resource # Abbreviate new_resource
    cr = Pool.new(nr.name) # Read current resource from disk

    # Log to output the old and new nodes for ease of debug
    log "New nodes: #{nr.nodes}"
    log "Current nodes: #{cr.nodes}" if cr.nodes

    persistence, algorithm = Array.new

    # Setup and ensure the requirements are present for persistence algoritm etc
    if ! nr.persistence then
      persistence = cr.persistence ? cr.persistence : [ node["stingray"]["persistence"] ]
      log "persistence: #{persistence}"

      persistence nr.name do
        action :configure
      end
    end

    algorithm = [ "cells" ]

    # Here as notes for remaining requirements.
#    if ! nr.monitors then
#      nr.monitors = cr.monitors ? cr.monitors : node["stingray"]["monitors"]
#    end
#    if ! nr.algorithm then
#      nr.algorithm = cr.algorithm ? cr.algorithm : node["stingray"]["algorithm"]
#    end

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
                :algorithm => algorithm,
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
