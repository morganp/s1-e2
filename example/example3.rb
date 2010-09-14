# examples/example3.rb

require  '../lib/git_badge'

# In this example Anne and Dave  are joined by bev and cath
#Bev and Cath do not do too much leaving the Top Commiter Positions free for the taking

app = GitBadge::Core.new

anne = app.new_person("Anne") 
bev  = app.new_person("Bev")
dave = app.new_person("Dave")
cath = app.new_person("Cath")

anne.new_repository("RMU-entance-exam")
anne.new_repository("RMU-project")
bev.new_repository("RMU-entance-exam")
dave.new_repository("sinatra_with_rspec")
cath.new_repository("RMU-entance-exam")

anne.repositories[0].commit
anne.repositories[0].commit
dave.repositories[0].commit
dave.repositories[0].commit
bev.repositories[0].commit
cath.repositories[0].commit

app.report


