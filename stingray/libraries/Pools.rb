class Pool

   # List of nodes - must exist!
   attr(:nodes)

   # List of nodes that are disabled.
   attr(:disabled)

   # List of nodes that are draining.
   attr(:draining)

   # The named health monitors from the catalog.
   attr(:monitors)

   # The maximum number of connections per-node.
   attr(:maxconns)

   # The session persistence class; optional.
   attr(:persistence)

   # The load-balancing weightings
   attr(:weightings)

   # The loadbalancing algoritms.
   attr(:algorithm)

   # The priority list for the pool.
   attr(:priority)

   def initialize(resource)
   # XXX Certain config objects contain whitespace and are quoted.  These will get
   # chopped up by the split operation.  This isn't a problem as they will get joined
   # again by the template if the current settings are maintained.
   # You won't be able to *compare* the config options unless you cleverly join
   # spaced&quoted configuration objects in the array first.

      if ::File.exists?(resource) then
         file = ::File.open(resource,"r")
         @weightings = Hash.new
         while (line = file.gets)
            arry = line.split
            case arry[0]
               when nil
                  # Do nothing.
               when "nodes"
                  @nodes = arry[1..-1]
               when "disabled"
                  @disabled = arry[1..-1]
               when "draining"
                  @draining = arry[1..-1]
               when "monitors"
                  @monitors = arry[1..-1]
               when "max_connections_pernode"
                  @maxconns = arry[1]
               when "persistence"
                  @persistence = arry[1]
               when "load_balancing!algorithm"
                  @algorithm = arry[1]
               when "priority!values"
                  # The "better way"
                  @priority = arry[1..-1]
               when arry[0].start_with?("load_balancing!weighting!")
                  # The "wrong way"
                  # What RID-DICulous config file format!
                  # Read the node name out of the first array element
                  # Store the node name => weight in our weighting Hash
                  @weightings.store(arry[0].partition("load_balancing!weighting!")[2],arry[1])
            end
         end
         file.close
      end
   end
end
