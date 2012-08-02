action :configure do
   nr = new_resource
   cr = Persistence.new(nr.name)

   # Write new values.
   template nr.name do
      cookbook "stingray"
      backup false
      source "persistence.erb"
      mode "0644"
      variables(
         :type => nr.type ? nr.type : cr.type,
         :cookie => nr.cookie ? nr.cookie : cr.cookie
      )
   end

end

action :delete do

   file new_resource.name do
      backup false
      action :delete
   end

end
