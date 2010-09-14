# git_badge/badge.rb

module GitBadge
   class Badge

      #Dynamic badges are now event driven, Re-awarded every time anything happens
      def self.dynamic( person )
         ############################################## 
         ## Clear all dynamic Badges
         ##############################################
         person.parent.people.each do |cperson|
            cperson.clear_dynamic_badge
         end

         ##############################################
         ## Whos is the top commiter
         ##############################################
         sorted_list_of_people =  (person.parent.people.sort_by { |person| person.total_commit_count }).reverse
         sorted_list_of_people[0].award_dynamic_badge( GitBadge::BADGES_DYNAMIC[:mostcommit] )
         
         ##############################################
         ##  Top Commiter
         ##############################################
         # DESC: top 50% of users 
         (0...(sorted_list_of_people.size/2)).each do |i|
            sorted_list_of_people[i].award_dynamic_badge( GitBadge::BADGES_DYNAMIC[:topcommit] )
         end

         ##############################################
         ##  Most Repositories
         ##############################################
         sorted_list_of_people =  (person.parent.people.sort_by { |person| person.repositories.size }).reverse
         sorted_list_of_people[0].award_dynamic_badge( GitBadge::BADGES_DYNAMIC[:mostrepo] )


      end

      # Badges once set are stored in the person
      def self.static( person )

         history     = person.all_history
         commits     = person.total_commit_count
         repo_count  = person.repositories.size
         
         #Cache person badges to stop constant look ups on the dynamic badges.
         badges      = person.badges

         # BUG repo_count still 1 behind at this stage
         # new_repository calls this before returning to the person requesting it.
         # Will Try deriving stats from logs 
         # Shortcut to count up stats from
         # http://stackoverflow.com/questions/569694/count-duplicate-elements-in-ruby-array
        
         stats = Hash.new(0)

         # iterate over the array, counting duplicate entries
         history.each do |line|
            stats[line] += 1
         end

         ##############################################
         ## Repo Creation Badges
         ##############################################
         if ( not badges.include?( GitBadge::BADGES_STATIC[:creator1] ) and stats["initialize"] >= 1 )
            #Award the Creator Badge
            person.award_static_badge(  GitBadge::BADGES_STATIC[:creator1] )
         end
         if       badges.include?( GitBadge::BADGES_STATIC[:creator1] )  and
            ( not badges.include?( GitBadge::BADGES_STATIC[:creator2] )) and
            ( stats["initialize"] >= 5)

               person.award_static_badge(  GitBadge::BADGES_STATIC[:creator2] )
         
         end
         if       badges.include?( GitBadge::BADGES_STATIC[:creator2] )  and
            ( not badges.include?( GitBadge::BADGES_STATIC[:creator3] )) and
            ( stats["initialize"] >= 25)

               person.award_static_badge(  GitBadge::BADGES_STATIC[:creator2] )
         end

         ##############################################
         ## Comiter Badges
         ##############################################
         if (not badges.include?( GitBadge::BADGES_STATIC[:commiter1] )) and commits >= 1
            person.award_static_badge(  GitBadge::BADGES_STATIC[:commiter1] )
         end
         if        badges.include?( GitBadge::BADGES_STATIC[:commiter1])   and
            ( not  badges.include?( GitBadge::BADGES_STATIC[:commiter2]) ) and
            ( commits >= 5)

               person.award_static_badge( GitBadge::BADGES_STATIC[:commiter2] )

         end
         if        badges.include?( GitBadge::BADGES_STATIC[:commiter2])   and
            ( not  badges.include?( GitBadge::BADGES_STATIC[:commiter3]) ) and
            ( commits >= 10)

               person.award_static_badge( GitBadge::BADGES_STATIC[:commiter3] )

         end
         if        badges.include?( GitBadge::BADGES_STATIC[:commiter3])   and
            ( not  badges.include?( GitBadge::BADGES_STATIC[:commiter4]) ) and
            ( commits >= 15)

               person.award_static_badge( GitBadge::BADGES_STATIC[:commiter4] )

         end




      end

   end
end
