require File.join(File.dirname(__FILE__), '../config.rb')


# Sprinkle setup script for our CI server (Ruby 1.9)
# Partially copied from https://gist.github.com/slainer68/1165512
#

 
package :ruby do
  description 'Ruby Virtual Machine'
  version '1.9.3'
  source "http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p392.tar.gz" do
     # Rebuild all gems in case we updated to a newer version of Ruby
    post :install, "gem update --system"
    post :install, "gem pristine --all"
  end
  requires :ruby_dependencies
  verify do
    has_executable_with_version(
      "#{REE_PATH}/bin/ruby", "Ruby Enterprise Edition #{version}"
    )
    #binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
  end
end
 
package :ruby_dependencies do
  description 'Ruby Virtual Machine Build Dependencies'
  apt %w(bison zlib1g-dev libssl-dev libreadline5-dev libncurses5-dev file)
  verify do
    has_apt "bison"
    has_apt "zlib1g-dev"
    has_apt "libssl-dev"
    has_apt "libreadline5-dev"
    has_apt "libncurses5-dev"
    has_apt "file"
  end
end



# package :ruby_enterprise do
#   description 'Ruby Enterprise Edition'
#   binaries = %w(erb gem irb rackup rails rake rdoc ree-version ri ruby testrb)

#   # Used as part of download, and also for final verificaiton of complete install
#   ruby_version_string = '2012.02'

#   source "https://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2012.02.tar.gz" do
#     custom_install 'sudo ./installer --auto=/usr/local/ruby-enterprise'
#     binaries.each {|bin| post :install, "ln -sf #{REE_PATH}/bin/#{bin} /usr/local/bin/#{bin}" }

#     pre :build, "patch ./source/distro/google-perftools-1.7/src/tcmalloc.cc < #{$ubuntu_patch_path}"

#     # Rebuild all gems in case we updated to a newer version of Ruby
#     post :install, "gem update --system"
#     post :install, "gem pristine --all"
#     # Passenger gets installed with an old fucked up version
#     # that we don't want. Removing it saves us headache down the line
#     # when we go to actually install passenger (in apache.rb).
#     # post :install, "gem uninstall --version 3.0.7 -x passenger"

#   end

#   verify do
#     has_executable_with_version(
#       "#{REE_PATH}/bin/ruby", "Ruby Enterprise Edition #{ruby_version_string}"
#     )
#     binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
#   end

#   requires :ree_dependencies
# end

# package :ree_dependencies do
#   ree_packages = %w(zlib1g-dev libreadline-gplv2-dev libssl-dev)
#   apt ree_packages
#   verify { ree_packages.each { |pkg| has_apt pkg } }
#   requires :build_essential
# end





