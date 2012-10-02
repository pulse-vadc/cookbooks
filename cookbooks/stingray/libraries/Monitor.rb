class Monitor

   attr(:can_use_ssl)
   attr(:delay)
   attr(:editable_keys)
   attr(:factory)
   attr(:failures)
   attr(:scope)
   attr(:timeout)
   attr(:type)
   attr(:use_ssl)

   def initialize(resource)
      if ::File.exists?(resource) then
         file = ::File.open(resource,"r")
         @weightings = Hash.new
         while (line = file.gets)
            arry = line.split
            case arry[0]
               when nil
                  # Do nothing.
               when "can_use_ssl"
                  @can_use_ssl = arry[1]
               when "delay"
                  @delay = arry[1]
               when "editable_keys"
                  @editable_keys = arry[1..-1]
               when "factory"
                  @factory = arry[1]
               when "failures"
                  @failures = arry[1]
               when "scope"
                  @scope = arry[1]
               when "timeout"
                  @timeout = arry[1]
               when "type"
                  @type = arry[1]
               when "use_ssl"
                  @use_ssl = arry[1]
            end
         end
         file.close
      end
   end
end
