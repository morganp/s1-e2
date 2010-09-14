# examples/example1.rb

require  '../lib/git_badge'

# In this example Anne and Dave create some Repositories (no commits)

app = GitBadge::Core.new

anne = app.new_person("Anne") 
dave = app.new_person("Dave")

anne.new_repository("RMU-entance-exam")
anne.new_repository("RMU-s1-e1")
anne.new_repository("RMU-s1-e2")
anne.new_repository("RMU-final-exam")

require 'pp'
anne.repositories.each do |repo|
   msg_start = ("Repository: " + repo.name).ljust(30)
   puts msg_start + " Commits: " + repo.commit_count.to_s
end

#Dave has a go
dave.new_repository("RMU-entance-exam")
dave.new_repository("RMU-s1-e1")
dave.new_repository("RMU-s1-e2")
dave.new_repository("RMU-final-exam")

# Anne tries to reach level 2 repo master
anne.new_repository("RMU-Project")
anne.new_repository("RMU-s1-e3")

app.report
