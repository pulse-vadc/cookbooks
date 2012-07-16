action :configure do
   nr = new_resource
   cr = GlobalCfg.new(nr.name)

   # Write new values.
   template nr.name do
      cookbook "stingray"
      backup false
      source "globalcfg.erb"
      mode "0644"
      variables(
         :gid => nr.gid ? nr.gid : cr.gid,
         :uid => nr.uid ? nr.uid : cr.uid,
         :controlport => nr.controlport ? nr.controlport : cr.controlport,
         :control_certificate => nr.control_certificate ? nr.control_certificate : cr.control_certificate,
         :java_port => nr.java_port ? nr.java_port : cr.java_port,
         :ec2_availability_zone => nr.ec2_availability_zone ? nr.ec2_availability_zone : cr.ec2_availability_zone,
         :ec2_instanceid => nr.ec2_instanceid ? nr.ec2_instanceid : cr.ec2_instanceid,
         :external_ip => nr.external_ip ? nr.external_ip : cr.external_ip
      )
   end

end
