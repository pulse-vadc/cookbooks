class GlobalCfg

   attr(:gid)
   attr(:uid)
   attr(:controlport)
   attr(:control_certificate)
   attr(:java_port)
   attr(:ec2_availability_zone)
   attr(:ec2_instanceid)
   attr(:external_ip)

   def initialize(resource)

      if ::File.exists?(resource) then
         file = ::File.open(resource,"r")
         while (line = file.gets)
            arry = line.split(" ")
            case arry[0]
               when nil
                  # Do nothing.
               when "gid"
                  @gid = arry[1]
               when "uid"
                  @uid = arry[1]
               when "controlport"
                  @controlport = arry[1]
               when "control!certificate"
                  @control_certificate = arry[1]
               when "java!port"
                  @java_port = arry[1]
               when "ec2!availability_zone"
                  @ec2_availability_zone = arry[1]
               when "ec2!instanceid"
                  @ec2_instanceid = arry[1]
               when "externalip"
                  @external_ip = arry[1]
            end
         end
         file.close
      end
   end
end
