require File.join(File.dirname(__FILE__), '../config.rb')

$ubuntu_patch_path = '/tmp/perftools-ubuntu.patch'

package :ruby_enterprise do
  description 'Ruby Enterprise Edition'
  binaries = %w(erb gem irb rackup rails rake rdoc ree-version ri ruby testrb)

  # Used as part of download, and also for final verificaiton of complete install
  ruby_version_string = '2012.02'

  source "https://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2012.02.tar.gz" do
    custom_install 'sudo ./installer --auto=/usr/local/ruby-enterprise'
    binaries.each {|bin| post :install, "ln -sf #{REE_PATH}/bin/#{bin} /usr/local/bin/#{bin}" }

    pre :build, "patch ./source/distro/google-perftools-1.7/src/tcmalloc.cc < #{$ubuntu_patch_path}"

    # Rebuild all gems in case we updated to a newer version of Ruby
    post :install, "gem update --system"
    post :install, "gem pristine --all"
    # Passenger gets installed with an old fucked up version
    # that we don't want. Removing it saves us headache down the line
    # when we go to actually install passenger (in apache.rb).
    # post :install, "gem uninstall --version 3.0.7 -x passenger"

  end

  verify do
    has_executable_with_version(
      "#{REE_PATH}/bin/ruby", "Ruby Enterprise Edition #{ruby_version_string}"
    )
    binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
  end

  requires :ree_dependencies
  requires :perftools_ubuntu_patch
end

package :ree_dependencies do
  ree_packages = %w(zlib1g-dev libreadline-gplv2-dev libssl-dev)
  apt ree_packages
  verify { ree_packages.each { |pkg| has_apt pkg } }
  requires :build_essential
end



# simply upload the patch
package :perftools_ubuntu_patch do

  # This patch is b/c of https://code.google.com/p/rubyenterpriseedition/issues/detail?id=74
  transfer(
    File.join(File.dirname(__FILE__), 'files/perftools-ubuntu.patch'),
    $ubuntu_patch_path
  ) do
    post :install, "stat #{$ubuntu_patch_path}"
  end

  verify { has_file $ubuntu_patch_path }
end


