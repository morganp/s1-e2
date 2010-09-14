# examples/example1.rb

require  '../lib/git_badge'

# In this example Anne and Dave commit to some Repositories

app = GitBadge::Core.new

anne = app.new_person("Anne") 
dave = app.new_person("Dave")

anne.new_repository("RMU-entance-exam")
dave.new_repository("sinatra_with_rspec")

anne.repositories[0].commit
anne.repositories[0].commit
anne.repositories[0].commit
anne.repositories[0].commit
dave.repositories[0].commit
anne.repositories[0].commit

#Anne does lots of work
(0...20).each do
   anne.repositories[0].commit
end

# Anne tries to reach level 2 repo master
anne.new_repository("RMU-Project")
anne.new_repository("RMU-s1-e3")

app.report

puts
puts "Dave goes on a commiting binge to steal Most Commited"
(0...25).each do
   dave.repositories[0].commit
end

app.report


