require File.join(File.dirname(__FILE__), '../config.rb')

package :build_essential do
  description 'Build tools'
  apt 'build-essential' do
    # Update the sources and upgrade the lists before we build essentials
    pre :install, ['aptitude update', 'aptitude safe-upgrade', 'aptitude full-upgrade']
  end
  verify { has_apt 'build-essential' }
end