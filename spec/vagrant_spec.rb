require 'spec_helper'

def home_directory
  if os[:family] == 'solaris'
    '/export/home/vagrant'
  else
    '/home/vagrant'
  end
end

def synced_folder_fstype
  case host_inventory[:virtualization][:system]
  when 'vbox'
    'vboxsf'
  when 'vmware'
    if %w(arch fedora).include?(os[:family])
      'fuse.vmhgfs-fuse'
    elsif os[:family] == 'ubuntu' && os[:release] == '16.04'
      'fuse.vmhgfs-fuse'
    else
      'vmhgfs'
    end
  end
end

describe user('vagrant') do
  it { should exist }
  it { should belong_to_group 'vagrant' }
  it { should have_home_directory home_directory }
end

describe file("#{home_directory}/.ssh") do
  it { should be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }
  it { should be_mode 700 }
end

describe file("#{home_directory}/.ssh/authorized_keys") do
  it { should be_file }
  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }
  it { should be_mode 600 }
end

describe file('/etc/vagrant_box_build_time') do
  it { should be_file }
end

describe file('/vagrant'), unless: %w(freebsd openbsd).include?(os[:family]) do
  it { should be_mounted.with type: synced_folder_fstype }
  it { should be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }
end
