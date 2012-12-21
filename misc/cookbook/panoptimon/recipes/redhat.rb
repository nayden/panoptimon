# Cookbook Name:: panoptimon
# Recipe:: redhat
#
# Copyright 2012, Sourcefire
#
# All rights reserved - Do Not Redistribute
#
%w[ java-1.7.0-openjdk
    rubygem-eventmachine
    rubygem-daemons
    rubygem-thin
    rubygem-riemann-client
    rubygem-sys-filesystem
  ].each { |pkg| package pkg }

[ node[:panoptimon][:install_dir],
  node[:panoptimon][:conf_dir],
].each do |dir|
  directory dir do
    owner     node[:panoptimon][:user]
    group     node[:panoptimon][:group]
    mode      '00755'
    recursive true
  end
end

node[:panoptimon][:collectors].each do |col, cfg|
  directory "#{node['panoptimon']['conf_dir']}/collectors/#{col}" do
    owner 'root'
    group 'root'
    mode  '00755'
  end

  template"#{node['panoptimon']['conf_dir']}/collectors/#{col}/#{col}.json" do
    owner  'root'
    group  'root'
    mode   '00644'
    source "#{col}.collector.erb"
  end
end
