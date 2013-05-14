require File.join(File.dirname(__FILE__), '../config.rb')


# Sprinkle setup script for our CI server (Ruby 1.9)
# Partially copied from https://gist.github.com/slainer68/1165512
#

 
package :ruby do
  description 'Ruby Virtual Machine'
  version '1.9.3'

  binaries = %w(erb gem irb rake rdoc ri ruby testrb)


  runner 'source /etc/profile.d/rvm.sh; rvmsudo rvm install 1.9.3' do
   
    # not sure if this goes here?
    # pre :prepare, "source /usr/local/rvm/scripts/rvm"

    # pre :prepare, 'source /etc/profile.d/rvm.sh'

    # hardcoding for now, will automate later
    install_path = '/usr/local/rvm/rubies/ruby-1.9.3-p392'

    # Link ruby binaries (this pretty much ignores rvm's switching capabilities)
    # binaries.each {|bin| post :install, "ln -sf #{install_path}/bin/#{bin} /usr/local/bin/#{bin}" }


    # Link rvm so we can switch using sudo etc

    #post :isntall "ln -sf /usr/local/rvm/bin/rvm /usr/local/bin/rvm"


    # can't figure out how to get rvm to swich this itself, so lets do it
    # post :isntall, 'unlink /usr/local/rvm/rubies/default ; ln -sf /usr/local/rvm/rubies/ruby-1.9.3-p392/ /usr/local/rvm/rubies/default'

    # post :isntall, "rvm use 1.9.3 --default"
    post :install, "source /etc/profile.d/rvm.sh; rvmsudo rvm alias create default ruby-1.9.3-p392", :sudo =>false
 
    # post :install, "gem update --system"
    # post :install, "gem pristine --all"
    
    # post :install, cmd
  end

  verify do
    has_executable_with_version(
      "ruby", "ruby #{version}"
    )
  end


  requires :ruby_dependencies



  # verify do
  #   has_executable_with_version(
  #     "#{REE_PATH}/bin/ruby", "Ruby Enterprise Edition #{version}"
  #   )
  #   binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
  # end
end
 
package :ruby_dependencies do
  description 'RVM as root'
  apt 'curl' do
    post :install, 'curl -L https://get.rvm.io -o /tmp/rvm-installer'
    post :install, 'chmod +x /tmp/rvm-installer'
    post :install, '/tmp/rvm-installer --autolibs=enabled stable'
    # post :install, "return 1 && bash -c 'curl -L https://get.rvm.io | bash -s stable --autolibs=enabled'"
    # post :install, "/usr/local/rvm/scripts/rvm pkg install libyaml"
  end
  
  verify { file_contains '/usr/local/rvm/bin/rvm', "rvm_rvmrc_files"}
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





