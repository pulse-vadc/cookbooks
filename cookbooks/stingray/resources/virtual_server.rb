attribute :name, :kind_of => String,	:name_attribute => true
attribute :enabled, :kind_of => String, :default => "yes"
attribute :address, :kind_of => [String, Array],	:default => ["*"]
attribute :protocol, :kind_of => String, :default => "HTTP"
attribute :pool, :kind_of => String, :default => "discard"
attribute :port, :kind_of => String, :default => "80"
attribute :ssl_decrypt, :kind_of => String, :default => "no"
attribute :ssl_certificate, :kind_of => String
attribute :timeout, :kind_of => Integer
attribute :rules, :kind_of => String
attribute :response_rules, :kind_of => String

actions :configure, :start, :stop, :delete
