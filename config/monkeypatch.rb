module Sprinkle
  module Verifiers
    module Ruby

      
      # Checks if a gem exists by calling "gem list" and grepping against it.
      def rvm_has_gem(name, version = nil)
        version = version ? "--version '#{version}'" : '' 
        @commands << "bash -c \"source /etc/profile.d/rvm.sh; gem list '#{name}' --installed #{version} > /dev/null\""
        # @commands << "bash -c 'source /etc/profile.d/rvm.sh; gem list 'mysql2' --installed'"
      end


    end
  end
end