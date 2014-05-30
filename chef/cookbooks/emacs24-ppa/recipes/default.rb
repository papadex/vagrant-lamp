#
# Cookbook Name:: ubuntu
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
case node[:platform]
  when "debian", "ubuntu"
    apt_repository "emacs24-ppa" do
    uri "http://ppa.launchpad.net/cassou/emacs/ubuntu"
    distribution node['lsb']['codename']
    components ['main']
    keyserver "keyserver.ubuntu.com"
    key "CEC45805"
  end
end

if node['emacs24-ppa']['use_snapshot']
  to_install = ["emacs-snapshot-el", "emacs-snapshot-gtk", "emacs-snapshot"]
  to_remove  = ["emacs24", "emacs24-el", "emacs24-common-non-dfsg"]
else
  to_install = ["emacs24", "emacs24-el", "emacs24-common-non-dfsg"]
  to_remove  = ["emacs-snapshot-el", "emacs-snapshot-gtk", "emacs-snapshot"]
end

to_remove.each do |pkgname|
  package(pkgname) { action :remove }
end

to_install.each do |pkgname|
  package(pkgname) { action :install }
end

remote_directory "/home/vagrant/.emacs.d" do
  mode "0700"
  files_owner "vagrant"
  files_group "vagrant"
  owner "vagrant"
  group "vagrant"
  source "emacsd"
end

