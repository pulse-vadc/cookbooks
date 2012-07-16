class TrafficIPGroup

=begin

Currently, if you create a TIPG without a machines attr, it will create a broken TIPG.
We should be able to get a complete list of LB devices in the cluster, simply by `ls`ing the
../conf/zxtms directory, but we need a way to feed that to the TrafficIPGroup class.

It might "infer" it, using regex on it's own name.

=end

   attr( :enabled )
   attr( :ipaddresses )
   attr( :keeptogether )
   attr( :machines )
   attr( :slaves )

   def initialize(resource)

      if ::File.exists?(resource) then
         file = ::File.open(resource,"r")
         while (line = file.gets)
            arry = line.split
            case arry[0]
               when nil
                  # Do nothing
               when "enabled"
                  @enabled = arry[1]
               when "ipaddresses"
                  @ipaddresses = arry[1..-1]
               when "keeptogether"
                  @keeptogether = arry[1]
               when "machines"
                  @machines = arry[1..-1]
               when "slaves"
                  @slaves = arry[1..-1]
            end
         end
         file.close
      end
   end
end
