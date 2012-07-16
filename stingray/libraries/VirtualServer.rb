class VirtualServer

   attr( :enabled) 
   attr( :port) 
   attr( :protocol) 
   attr( :pool) 
   attr( :address) 
   attr( :timeout) 
   attr( :rules) 
   attr( :response_rules) 
   attr( :ssl_decypt) 
   attr( :ssl_certificate) 

   def hello
      Chef::Log.info "Hello!"
   end

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
               when "port"
                  @port = arry[1]
               when "protocol"
                  @protocol = arry[1]
               when "pool"
                  @pool = arry[1]
               when "address"
                  @address = arry[1..-1]
               when "timeout"
                  @timeout = arry[1]
               when "rules"
                  @rules = arry[1..-1] 
               when "response_rules"
                  @response_rules = arry[1..-1]
               when "public_cert"
                  @ssl_certificate = arry[1].chomp(".public")
            end
         end
         file.close
      end
   end
end
