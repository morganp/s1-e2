# git_badge.rb

# The module that contains everything git_badge related:

module GitBadge
   #extend GitBadge::Version

   # A string representing the version of GitBadge.
   VERSION = "0.0.1"

   BADGES_STATIC = {
      :creator1   => "Creator",
      :creator2   => "Master Creator",
      :creator3   => "Creator of the Universe",
      :commiter1  => "Commiter",
      :commiter2  => "Commiter PlusPlus",
      :commiter3  => "Commiter Supreme" ,
      :commiter4  => "Commiter King", 
      :pusher1    => "Pusher",
      :puller1    => "Puller",
      :clone1     => "Clone",
      :brancher   => "Brancher",
      :befork     => "You have been Forked",
      :forked     => "Totally Forked"
   }
   

   BADGES_DYNAMIC = {
      :topcommit  => "Top Commiter",
      :mostcommit => "Most Commited",
      :mostrepo   => "Most Repositories"
   }
 
   class Core

      attr_reader :people
      
      def initialize
         @people = Array.new
      end
   
      def new_person( name, options={} )
         options[:parent] = self
         person = GitBadge::Person.new(name, options)
         @people << person
         return person
      end

      def report
         @people.each do |person|
            puts
            puts person.name + " Badges so far:"
            puts person.badges
         end
      end

   end

end

Dir.chdir( File.dirname( __FILE__ ) )

require 'git_badge/person'
require 'git_badge/repository'
require 'git_badge/badge'



