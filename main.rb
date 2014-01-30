require_relative 'shared.rb'
require_relative 'fetch.rb'
require_relative 'extract.rb'
require_relative 'compile.rb'
require_relative 'eval.rb'

user_map = Fetch.tar_files
assign_dir = Extract.assignments(user_map)
exes = Compile.all(assign_dir)
output = Eval.all(exes)
output.each { |user, out| puts "#{user}: #{out}" }