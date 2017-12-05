#
# Cookbook:: swap-file
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

swap_file '/root/swapfile' do
  size      10000    # MBs
end
