attribute :name, :kind_of => String, :name_attribute => true
attribute :can_use_ssl, :kind_of => String, :default => "Yes"
attribute :delay, :kind_of => Integer, :default => 5
attribute :editable_keys, :kind_of => [ String, Array ]
attribute :factory, :kind_of => String, :default => "No"
attribute :failures, :kind_of => Integer, :default => 3
attribute :scope, :kind_of => Integer, :default => "pernode"
attribute :timeout, :kind_of => Integer, :default => 10
attribute :type, :kind_of => String, :default => "http"
attribute :use_ssl, :kind_of => String, :default => "No"

actions :configure, :delete
