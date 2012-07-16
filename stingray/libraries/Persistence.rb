class Persistence

   attr(:type)
   attr(:cookie)

   def initialize(resource)

      if ::File.exists?(resource) then
         file = ::File.open(resource,"r")
         while (line = file.gets)
            arry = line.split(" ")
            case arry[0]
               when nil
                  # Do nothing.
               when "type"
                  @type = arry[1]
               when "cookie"
                  @cookie = arry[1]
            end
         end
         file.close
      end
   end
end
