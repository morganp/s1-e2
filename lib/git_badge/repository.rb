# git_badge/repository.rb

module GitBadge
   class Repository
      
      attr_accessor  :name
      attr_reader    :clone_name
      attr_reader    :commit_count
      attr_reader    :branches
      attr_reader    :log

      def initialize( name, options={})
         @name          = name
         @commit_count  = 0
         @branches      = Array.new
         @log           = Array.new
         @parent        = options[:parent]
         @cloned        = options[:clone]

         log_action( get_mname )
      end

      def commit( options={} )
         @commit_count += 1
         log_action( get_mname ) 
      end
      
      def push( options={} )
         log_action( get_mname )
      end

      def pull( options={} )
         log_action( get_mname )
      end

      def clone( options={} )
         log_action( get_mname )
         #Users has 'downloaded a copy'
         #If you are not the owner then it is read only
      end

      def branch( name, options={} )
         log_action( get_mname )
      end

      ## This is to fix a late bug
      # When creating a new repo the log_action is called, 
      # then it returns and the new repo is added, there fore the repo count is 1 behind for that event.
      def check_for_new_badges
         #Analyse static badges.
         GitBadge::Badge.static(  @parent )
         GitBadge::Badge.dynamic( @parent )
      end

      private

      def log_action( function )
         @log << function

         #Analyse static badges.
         GitBadge::Badge.static(  @parent )
         GitBadge::Badge.dynamic( @parent )

      end

      # Get current method name
      # source http://www.ruby-forum.com/topic/75258
      # This will not be required in Ruby 1.9
      def get_mname
        caller[0][/`(.*?)'/, 1]  # note the first quote is a backtick
      end


   end
end
