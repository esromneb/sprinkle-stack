require File.join(File.dirname(__FILE__), '../config.rb')

require 'ruby_19'

# Handles manual log parsing through CRON script, or via Scout app

package :rails_log_analyzer do
  description 'Provides log parsing tools for Hodel3000 compliant logger.'
  runner "bash -c 'source /etc/profile.d/rvm.sh; rvmsudo gem install production_log_analyzer rails_analyzer_tools request-log-analyzer'" do
  # gem 'production_log_analyzer rails_analyzer_tools request-log-analyzer' do
    post :install, "ln -sf /usr/local/rvm/gems/ruby-1.9.3-p392/gems/production_log_analyzer-1.5.1/bin/pl_analyze /usr/local/bin/pl_analyze"
  end
  
  verify do
    rvm_has_gem 'production_log_analyzer'
    rvm_has_gem 'rails_analyzer_tools'
    rvm_has_gem 'request-log-analyzer'
    has_executable 'pl_analyze'
  end
  
  requires :ruby
end