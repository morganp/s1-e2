# git_badge/people.rb

module GitBadge
   class Person

      attr_reader :name
      attr_reader :repositories
      attr_reader :parent

      # Setup a new person
      def initialize( name, options={} )
         @parent           = options[:parent]
         @name             = name
         @repositories     = Array.new
         @badges_static    = Array.new
         @badges_dynamic   = Array.new
      end

      def new_repository( name, options={} )
         #Including parent for call back
         options[:parent]=self
         @repositories <<  GitBadge::Repository.new( name, options )
         #This fixes the out of sync commit badges but means every event casues 2 loops of badge code 
         @repositories[0].check_for_new_badges
      end

      def badges
         return  @badges_static + @badges_dynamic
      end
      
      def award_dynamic_badge( badge )
         @badges_dynamic << badge
         #This was getting verbose as every action retriggered all the dynamic badges
         # Leaving inplace for debugging 
         #puts @name + " has been awarded the " + badge + " badge!"
      end

      def remove_dynamic_badge( badge )
         @badges_dynamic.delete( badge )
      end

      def clear_dynamic_badge
         @badges_dynamic = Array.new
      end



      def award_static_badge( badge )
         @badges_static << badge
         puts @name + " has been awarded the " + badge + " badge!"
      end

      def all_history
         complete_history = Array.new
         @repositories.each do |repo|
            complete_history += repo.log
         end
         return complete_history
      end

      def total_commit_count
         commits = 0
         @repositories.each do |repo|
            commits += repo.commit_count
         end
         return commits
      end
   end
end
