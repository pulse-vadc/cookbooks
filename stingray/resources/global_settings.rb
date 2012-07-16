attribute :name, :kind_of => String, :name_attribute => true
attribute :gid, :kind_of => [NilClass, String]
attribute :uid, :kind_of => [NilClass, String]
attribute :controlport, :kind_of => [NilClass, String]
attribute :control_certificate, :kind_of => [NilClass, String]
attribute :java_port, :kind_of => [NilClass, String]
attribute :ec2_availability_zone, :kind_of => [NilClass, String]
attribute :ec2_instanceid, :kind_of => [NilClass, String]
attribute :external_ip, :kind_of => [NilClass, String]

actions :configure
