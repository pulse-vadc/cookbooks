attribute :name, :kind_of => String, :name_attribute => true
attribute :nodes, :kind_of => [ String, Array ]
attribute :draining, :kind_of => [String, Array]
attribute :disabled, :kind_of => [String, Array]
attribute :monitors, :kind_of => [String, Array]
attribute :maxconns, :kind_of => Integer
attribute :persistence, :kind_of => String
attribute :weightings, :kind_of => Hash
attribute :algorithm, :kind_of => String, :default => "roundrobin"
attribute :priority, :kind_of => [String, Array]

actions :configure, :delete
