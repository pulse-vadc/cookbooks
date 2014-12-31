#
# Provider Name:: stingray
# Provider:: default
#
# Copyright 2012, Riverbed Technology, Inc.
#
# All rights reserved - Do Not Redistribute
#
action :install do

    short_version = new_resource.version.gsub('.', '')

    if new_resource.gold then

        packagename =
        "ZeusTM_#{short_version}_Linux-#{new_resource.arch}-Gold"

    else

        packagename = "ZeusTM_#{short_version}_Linux-#{new_resource.arch}"

    end

    packageurl =
      case new_resource.version
      when '9.1'
        'https://support.riverbed.com/download.htm?sid=c26o2rd0sn2d46m9nlkb8lc2u4'
      when '9.1r2'
        'https://support.riverbed.com/download.htm?sid=mg1k8t5ib0t1ejh9f62jbp2li6'
      when '9.2'
        'https://support.riverbed.com/download.htm?sid=1d4quq8su3kuhaoor93mlb104d'
      when '9.3'
        'https://support.riverbed.com/download.htm?sid=qbr1k45ualc3gijn0qavnjaei7'
      when '9.3r1'
        'https://support.riverbed.com/download.htm?sid=t01dd49gtrl85lqus3q7md6qkl'
      when '9.4'
        'https://support.riverbed.com/download.htm?sid=biuhlvmnlt3jna7kq8ab2u69jk'
      when '9.5'
        'https://support.riverbed.com/download.htm?sid=faudva1r9hrbcie5a6b509aoti'
      when '9.6'
        'https://support.riverbed.com/download.htm?sid=vdg19dt684868npc3fggd750pn'
      when '9.6r1'
        'https://support.riverbed.com/bin/support/download?sid=9c3387134vofrjui9e6osj1h1g'
      when '9.7'
        'https://support.riverbed.com/bin/support/download?sid=tmedbt7phjf2g69b22cesdkb4g'
      when '9.8'
        'https://support.riverbed.com/bin/support/download?sid=b1rnr2r4fvo7t6jdsrgolb8qeu'
      when '9.8r1'
        'https://support.riverbed.com/bin/support/download?sid=irte05ss3m60br45h8o2vt37l9'
      when '9.8r2'
        'https://support.riverbed.com/bin/support/download?sid=p2rmalibflneacije5b4sdac2q'
      else
        raise 'Unsupported version'
      end

   directory "#{new_resource.tmpdir}/#{packagename}" do
      recursive true
      action :nothing
   end

   execute "Download Stingray Binaries" do
      creates "#{new_resource.tmpdir}/#{packagename}.tgz"
      cwd new_resource.tmpdir
      # Resume partial transfers, print no console output.
      command "wget --continue --quiet -O #{packagename}.tgz #{packageurl}"
   end

   template "#{new_resource.tmpdir}/install_replay" do
      not_if { ::File.exists? new_resource.path+"/zxtm" }
      cookbook "stingray"
      mode "0644"
      source "stingray_install.erb"
      variables(
         :accept_license => new_resource.accept_license,
         :path => new_resource.path
         )
   end

   execute "deploy_binaries" do
      creates new_resource.path
      cwd "#{new_resource.tmpdir}"
      command "\
      tar xzvf #{packagename}.tgz &&
      #{packagename}/zinstall --replay-from=#{new_resource.tmpdir}/install_replay"
   end

   directory "#{new_resource.tmpdir}/#{packagename}" do
      recursive true
      action :delete
   end

   template "#{new_resource.tmpdir}/install_replay" do
      action :delete
   end

   file "#{new_resource.tmpdir}/#{packagename}.tgz" do
      action :delete
   end

end

action :uninstall do

   # FIXME There might be other instances running on this box that we don't want to nuke.
   execute "kill zeus.* processes" do
      command "pkill -9 zeus.*"
      ignore_failure true
   end

   execute "   delete *zeus initscripts" do
      command "find /etc/ -name *zeus -exec rm '{}' \\;"
      ignore_failure true
   end

   directory new_resource.path do
      recursive true
      action :delete
      ignore_failure true
   end

end

action :new_cluster do
   
   template "#{new_resource.path}/zxtm/conf/settings.cfg" do
      not_if { ::File.exists?(new_resource.path + "/rc.d/S20zxtm") }
      backup false
      cookbook "stingray"
      source "settings.erb"
      mode "0644"
      variables(
         :controlallow => "127.0.0.1",
         :java_enabled => new_resource.java_enabled,
         :flipper_unicast => "9090",
         :errorlog => "%zeushome%/zxtm/log/errors",
         :flipper_autofailback => new_resource.ec2 ? "No" : "Yes",
         :flipper_frontend_check_addrs => new_resource.ec2 ? "" : "%gateway%",
         :flipper_heartbeat_method => new_resource.ec2 ? "unicast" : "multicast",
         :flipper_monitor_interval => new_resource.ec2 ? "2000" : "500",
         :flipper_monitor_timeout => new_resource.ec2 ? "15" : "5"
         )
   end

   template "#{new_resource.tmpdir}/new_cluster_replay" do
      not_if { ::File.exists?(new_resource.path + "/rc.d/S20zxtm") }
      backup false
      cookbook "stingray"
      source "new_cluster.erb"
      mode "0644"
      variables(
         :accept_license => new_resource.accept_license,
         :admin_password => new_resource.admin_pass,
         :license_path => new_resource.license_key == "" ? "" : new_resource.license_key
      )

   end

   execute "new_cluster" do
      creates "#{new_resource.path}/rc.d/S20zxtm"
      cwd "#{new_resource.path}/zxtm"
      command "./configure --replay-from=#{new_resource.tmpdir}/new_cluster_replay"
      notifies :delete,
      resources(
         :template => "#{new_resource.path}/zxtm/conf/settings.cfg",
         :template => "#{new_resource.tmpdir}/new_cluster_replay"
      )
   end

end

action :join_cluster do

   template "#{new_resource.tmpdir}/join_cluster_replay" do
      cookbook "stingray"
      not_if { ::File.exists?(new_resource.path + "/rc.d/S20zxtm")}
      backup false
      source "join_cluster.erb"
      "mode 0644"
      variables(
         :accept_license		=> new_resource.accept_license,
         :admin_username		=> new_resource.admin_user,
         :admin_password		=> new_resource.admin_pass,
         :join_cluster_host=> new_resource.join_cluster_host,
         :join_cluster_port=> new_resource.join_cluster_port,
         :license_path			=> "#{new_resource.tmpdir}/#{new_resource.license_key}"
         )
   end

   execute "join_cluster" do
      cwd "#{new_resource.path}/zxtm"
      command "./configure --replay-from=#{new_resource.tmpdir}/join_cluster_replay"
      creates "#{new_resource.path}/rc.d/S20zxtm"

      notifies :delete, resources(
         :template => "#{new_resource.tmpdir}/join_cluster_replay"
      ), :delayed
   end

end

action :reset_to_defaults do

   template "#{new_resource.tmpdir}/reset_replay" do
      cookbook "stingray"
      only_if { ::File.exists?(new_resource.path + "/rc.d/S20zxtm") }
      source "leave_cluster.erb"
      mode "0644"
   end

   execute "reset_to_defaults" do
      only_if { ::File.exists?(new_resource.path + "/rc.d/S20zxtm")}
      cwd "#{new_resource.path}/zxtm"
      command "./configure --replay-from=#{new_resource.tmpdir}/reset_replay"
      notifies :delete, resources(
         :template => "#{new_resource.tmpdir}/reset_replay"
      ), :delayed
   end

end

action :restart do

   execute "Restart Stingray" do
      cwd "#{new_resource.path}"
      command "./restart-zeus"
   end

end
