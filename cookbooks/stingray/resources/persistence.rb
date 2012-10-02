actions :configure, :delete

attribute :name, :kind_of => String, :name_attribute => true

# Sardine is transparent session affinity.
attribute :type, :kind_of => String, :default => "sardine"
attribute :failuremode, :kind_of => String, :default => "newnode"
attribute :cookie, :kind_of => String
