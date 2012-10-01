name             "stingray"
maintainer       "Riverbed Technology, Inc."
maintainer_email "gosse.alex@gmail.com"
license          "All rights reserved"
description      "Installs/Configures stingray"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.10"

recipe "stingray::default","Does nothing."
recipe "stingray::install","Install the Stingray software."
recipe "stingray::uninstall","Uninstall the Stingray software."
recipe "stingray::reset_to_defaults","Removes the specified Stingray instance from it's current cluster (even if it's the only member)."
recipe "stingray::cluster_join","Joins the specified Stingray installation to another."
recipe "stingray::cluster_new","Creates a new cluster with the specified installation."
recipe "stingray::settings","Applies the settings.cfg template."
recipe "stingray::virtual_server","Creates (or updates) a virtual server."
recipe "stingray::pool","Creates (or updates) a pool."
recipe "stingray::persistence","Creates a session persistence class."
recipe "stingray::trafficipgroup", "Creates or updates a Traffic IP Group"

grouping 'stingray',
	:title => "Stingray options",
	:description => "Options for performing the installation and clustering operations."

grouping 'stingray/pool',
   :title => "Pool attributes",
   :description => "Options for creating, updating and deleting pools."

grouping "stingray/vserver",
	:title => "Virtual server option",
	:description => "Options for creating, updating and deleting virtual servers."

grouping "stingray/trafficipgroup",
	:title => "Traffic IP Group attributes",
	:description => "Attributes used to create, update or delete a Traffic IP Group."

grouping "stingray/persistence",
   :title => "Session Persistence attributes",
   :description => "Attributes to control session stickiness."

grouping "stingray/monitor",
    :title => "Monitoring attributed",
    :description => "Attributes to configure health monitoring."

# Stingray attributes
attribute "stingray/admin_pass",
	:display_name => "Administrative Password",
	:description => "The password to set for the admin user.",
	:required => "required",
	:recipes => ["stingray::cluster_new","stingray::cluster_join"]

attribute "stingray/accept_license",
	:display_name => "Riverbed EULA Acceptance",
	:description => "Whether or not you agree to the terms of Riverbed's
	EULA as described at http://www.riverbed.com/license.  This needs to
	be set to \"accept\" if you agreed to the terms.",
	:required => "required",
	:choice => ["accept","reject"],
   :recipes => ["stingray::install","stingray::cluster_new","stingray::cluster_join"]

attribute "stingray/license_key",
	:display_name => "License Key",
	:description => "The name of the license key file that will be used for the installation.",
	:required => "required",
	:recipes => ["stingray::cluster_new","stingray::cluster_join"]

attribute "stingray/name",
	:display_name => "Stingray Name",
	:description => "The name of the chef resource to use.",
	:required => "optional",
   :default => "default"

attribute "stingray/path",
   :display_name => "Installation Path",
   :description => "The path where Stingray is or will be located.",
   :required => "recommended",
	:default => "/opt/riverbed",
	:recipes => [
		"stingray::install",
		"stingray::cluster_new",
		"stingray::cluster_join",
		"stingray::reset_to_defaults",
		"stingray::settings",
      "stingray::virtual_server",
      "stingray::pool"
		]

attribute "stingray/tmpdir",
	:display_name => "Temporary directory",
	:description => "The name of the directory used to store temporary files.",
	:required => "optional",
	:default => "/tmp",
	:recipes => [
		"stingray::cluster_new",
		"stingray::cluster_join",
		"stingray::install",
		"stingray::reset_to_defaults"
		]

attribute "stingray/java_enabled",
	:display_name => "Java enabled",
	:description => "Whether or not Java Extensions should be enabled. Java requires separate licensing, so it is disabled by default.",
	:required => "recommended",
	:default => "no",
	:recipes => ["stingray::settings"]

attribute "stingray/ec2",
   :display_name => "EC2",
   :description => "Whether or not the instance is being launched in EC2.",
   :calculated => true,
   :recipes => ["stingray::cluster_new"]

# Traffic IP Group attributes

attribute "stingray/trafficipgroup/name",
	:display_name => "Traffic IP Group Name",
	:description => "The name of a Traffic IP Address Group",
	:required => "required",
	:recipes => ["stingray::trafficipgroup"]

attribute "stingray/trafficipgroup/enabled",
	:display_name => "TIPG Enabled",
	:description => "Whether or not this Traffic IP Address Group is enabled.",
	:required => "recommended",
	:default => "Yes",
	:recipes => ["stingray::trafficipgroup"]

attribute "stingray/trafficipgroup/ipaddresses",
	:display_name => "Addresses",
	:description => "A space-separated list of IP addresses that belong to this group.",
	:required => "required",
	:recipes => ["stingray::trafficipgroup"]

attribute "stingray/trafficipgroups/keeptogether",
	:display_name => "Keep-together",
	:description => "Whether or not each address in this group should always be hosted by the same traffic manager.",
	:required => "optional",
	:default => "No",
	:recipes => ["stingray::trafficipgroup"]

attribute "stingray/trafficipgroups/machines",
	:display_name => "Members",
	:description => "Which traffic managers should be allows to host this Traffic IP Group",
	:required => "required",
	:recipes => ["stingray::trafficipgroup"]

attribute "stingray/trafficipgroups/slaves",
	:display_name => "Passive Machines",
	:description => "The passive machines for this Traffic IP Group",
	:required => "optional",
	:recipes => ["stingray::trafficipgroup"]


# Virtual server attributes.
attribute "stingray/vserver/name",
	:display_name => "Virtual server name",
	:description => "The name of this virtual server",
	:required => "required",
	:recipes => ["stingray::virtual_server","stingray::application"]

attribute "stingray/vserver/enabled",
	:display_name => "Virtual server enabled",
	:description => "Whether or not this virtual server should listen.",
	:required => 'recommended',
	:default => "yes",
	:recipes => ["stingray::virtual_server","stingray::application"]

attribute "stingray/vserver/address",
	:display_name => "Virtual server address",
	:description => "The IP address(es) and/or Traffic IP Groups that this virtual server shoud listen on.",
	:required => 'required',
	:recipes => ["stingray::virtual_server","stingray::application"]

attribute "stingray/vserver/protocol",
	:display_name => "Application protocol",
	:description => "The protocol used deliver the application.  Note: For SSL-offload, this must be set to \"http\".",
	:choice => [
		"http",
		"https",
		"ftp",
		"imapv2",
		"imapv3",
		"imapv4",
		"imaps",
		"pop3",
		"pop3s",
		"smtp",
		"ldap",
		"ldaps",
		"telnet",
		"ssl",
		"udpstreaming",
		"udp",
		"dns",
		"dns_tcp",
		"sipudp",
		"siptcp",
		"rtsp",
		"server_first",
		"client_first",
		"stream"],
	:required => "required",
	:recipes => ["stingray::virtual_server","stingray::application"]

attribute "stingray/vserver/port",
	:display_name => "Virtual server port",
	:description => "The port that the virtual server listens on",
	:required => "recommended",
	:default => "80",
	:recipes => ["stingray::virtual_server","stingray::application"]

attribute "stingray/vserver/pool",
	:display_name => "Application pool",
	:description => "The name of the group of application servers.",
	:required => "recommended",
	:default => "discard",
	:recipes => ["stingray::virtual_server","stingray::application"]

attribute "stingray/vserver/ssl_decrypt",
	:display_name => "SSL Decrypt",
	:description => "Whether or not the virtual server should decrypt traffic.",
   :required => "optional",
	:recipes => ["stingray::virtual_server", "stingray::application"]

attribute "stingray/vserver/ssl_certificate",
	:display_name => "SSL Certiciate",
	:description => "The configuration-name of the SSL Certificate to use to decrypt traffic.",
   :required => "optional",
	:recipes => ["stingray::virtual_server", "stingray::application"]

attribute "stingray/vserver/private_key",
	:display_name => "Virtial server private key",
	:description => "The configuration-name of the private key to use to decrypt traffic.",
   :required => "optional",
	:calculated => true,
	:recipes => ["stingray::virtual_server", "stingray::application"]

attribute "stingray/vserver/timeout",
	:display_name => "Connection timeout",
	:description => "The client-side connection timeout value.",
   :required => "optional",
	:recipes => ["stingray::virtual_server", "stingray::application"]

attribute "stingray/vserver/rules",
	:display_name => "Request rules",
	:description => "A space-separated list of rules that should be applied to this virtual server.",
   :required => "optional",
	:recipes => ["stingray::virtual_server", "stingray::application"]

attribute "stingray/vserver/response_rules",
	:display_name => "Response rules",
	:description => "A space-separated list of response rules that should be applied to this virtual server.",
   :required => "optional",
	:recipes => ["stingray::virtual_server", "stingray::application"]

attribute "stingray/pool/name",
	:display_name => "Pool name",
	:description => "The name of a pool.",
	:required => "recommended",
	:recipes => ["stingray::pool"]

attribute "stingray/pool/nodes",
	:display_name => "Nodes",
	:description => "A space-separate list of nodes in the form \"host:port\"",
	:required => "recommended",
	:recipes => ["stingray::pool"]

attribute "stingray/pool/draining",
	:display_name => "Draining nodes",
	:description => "A space-separated list of nodes that should be draining.",
	:required => "optional",
	:recipes => ["stingray::pool"]

attribute "stingray/pool/disabled",
	:display_name => "Disabled nodes",
	:description => "A space-separated list of nodes that should be disabled.",
	:required => "optional",
	:recipes => ["stingray::pool"]

attribute "stingray/pool/monitors",
	:display_name => "Health Monitors",
	:description => "A space-sepated list of monitor classes to use for this pool.",
	:required => "optional",
	:recipes => ["stingray::pool"]

attribute "stingray/pool/maxconns",
	:display_name => "Maximum connections per-node.",
	:description => "The maximum number of connections that the traffic manager should make to each application server.",
	:required => "optional",
	:recipes => ["stingray::pool"]

attribute "stingray/pool/persistence",
	:display_name => "Session Persistence Class",
	:description => "The name of a session-persistence class to use.",
	:required => "optional",
	:recipes => ["stingray::pool"]

attribute "stingray/pool/weightings",
	:display_name => "Weightings",
	:description => "For the weighted load-balancing algorithms, the weight to apply to each node.",
	:required => "optional",
	:recipes => ["stingray::pool"]

attribute "stingray/pool/algorithm",
	:display_name => "Algorithm",
	:description => "The loadbalancing algorithm to use for the pool.",
	:required => "recommended",
	:default => "roundrobin",
   :choice => [
      "roundrobin", # Roundrobin
      "wroundrobin", # Weighted round-robin
      "cells", # Perceptive
      "connections", # Least Connections
      "wconnections", # Weighted Least-Connections
      "responsetimes", # Fastest response-time
      "random" # Random
      ],
	:recipes => ["stingray::pool"]

attribute "stingray/pool/priority",
	:display_name => "Node Priority Groups",
	:description => "A space separated list of nodes, and priority groups in the form: \"host:port:priority\".  Priority being an integer.",
	:required => "optional",
	:recipes => ["stingray::pool"]

attribute "stingray/persistence/name",
	:display_name => "Persistence class name",
	:description => "The name of a session persistence class.",
	:required => "recommended",
	:default => "default",
	:recipes => ["stingray::persistence"]


attribute "stingray/persistence/type",
	:display_name => "Persistence method",
	:description => "The method used for session persistence.",
	:required => "recommended",
   :choice => [
      "ip",       # IP-based
      "universal",# Universal
      "named",    # Named-node
      "sardine",  # Transparent session affinity
      "kipper",   # Application cookie - requires a cookie parameter.
      "j2ee",     # J2EE framework
      "asp",      # ASP, ASP.NET framework
      "x-zeus",   # X-Zeus-Backend cookie
      "ssl"       # SSL Session-ID
   ],
   :default => "sardine",
	:recipes => ["stingray::persistence"]

attribute "stingray/persistence/cookiename",
	:display_name => "Persistence cookie name",
	:description => "The name of the cookie that should be tracked,
   when using application cookie-based persistence.",
	:required => "optional",
	:default => "PHPSESSID",
	:recipes => ["stingray::persistence"]

attribute "stingray/monitors/name",
	:display_name => "Monitor name",
	:description => "The name of the health monitor.",
	:required => "optional",
	:recipes => ["stingray::monitor"]

attribute "stingray/monitors/can_use_ssl",
	:display_name => "Can use SSL",
	:description => "Whether or not the protocol that monitor is testing can be
    SSL-wrapped.",
	:required => "optional",
	:default => "Yes",
	:recipes => ["stingray::monitor"]

attribute "stingray/monitors/delay",
	:display_name => "Monitor delay",
	:description => "The delay time between monitor polls.",
	:required => "optional",
	:default => "5",
	:recipes => ["stingray::monitor"]

attribute "stingray/monitors/editable_keys",
	:display_name => "Editable keys",
	:description => "A list of input keys that are editable via the GUI.",
	:required => "optional",
	:default => "",
	:recipes => ["stingray::monitor"]

attribute "stingray/monitors/factory",
	:display_name => "Factory",
	:description => "Whether or not this monitor is one provided out-of-the-box by
    Riverbed.",
	:required => "optional",
	:default => "No",
	:recipes => ["stingray::monitor"]

attribute "stingray/monitors/failures",
	:display_name => "failures",
	:description => "The number of consecultive failures required to trigger a
    node failure event.",
	:required => "optional",
	:default => "3",
	:recipes => ["stingray::monitor"]

attribute "stingray/monitors/scope",
	:display_name => "Monitor scope",
	:description => "When set to pernode, each node is monitored separately.
    When set to perpool, a failure detected on a single node will cause the
    entire pool to be treated as failed.",
	:required => "optional",
	:default => "pernode",
	:recipes => ["stingray::monitor"]

attribute "stingray/monitors/timeout",
	:display_name => "Monitor timeout",
	:description => "The amount of time before a health monitor times out, once
    it has attempted to open a connection with a node.",
	:required => "optional",
	:default => "10",
	:recipes => ["stingray::monitor"]

attribute "stingray/monitors/type",
	:display_name => "Monitor type",
	:description => "The type of monitor; may be any of [ program, connect,
    tcp_transaction, ping, sip ]",
	:required => "optional",
	:default => "ping",
	:recipes => ["stingray::monitor"]

attribute "stingray/monitors/use_ssl",
	:display_name => "Monitor use SSL",
	:description => "Whether or not the monitor should wrap the poll in SSL.",
	:required => "optional",
	:default => "No",
	:recipes => ["stingray:monitor"]

=begin
attribute "",
	:display_name => "",
	:description => "",
	:required => "",
	:default => "",
	:recipes => ""
=end	
