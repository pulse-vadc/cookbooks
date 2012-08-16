#Overview

This is a repo of chef cookbooks for managing Riverbed's Stingray Traffic
Manager. The philosophy of this implementation is that chef should be the thing
that replicates config, and not the admin server.  So, you will observe that the
providers will generally write files directly, and the values that get written
into each file come from node attributes.

#Cookbooks

##stingray

###resources

####stingray

###providers

####stingray90

####stingray90r2

###recipes

###templates

###files

#Other Resources

##Official Documentation

##Live Users

###RightScale

The Stingray Traffic Manager series ServerTemplates&reg; on RightScale&tm;
