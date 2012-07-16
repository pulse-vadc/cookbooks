attribute :name, :kind_of => String, :name_attribute => true
attribute :enabled, :kind_of => String, :default => "Yes"
attribute :ipaddresses, :kind_of => [String, Array]
attribute :keeptogether, :kind_of => String, :default => "No", :required => true
attribute :machines, :kind_of => String
attribute :slaves, :kind_of => String

actions :configure, :delete
