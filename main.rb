require_relative 'shared.rb'
require_relative 'fetch.rb'
require_relative 'extract.rb'
require_relative 'compile.rb'
require_relative 'eval.rb'

user_map = Fetch.tar_files
assign_dir = Extract.assignments(user_map)
exes = Compile.all(assign_dir)
output = Eval.all(exes)

checking_proc = Proc.new do |output|
	puts output
	puts 'is this correct'
	pgets.chomp == 'yes' ? true : false
end

# for some reason this is getting filled with wrong 
# results... outputs, not true/false values
correct = Eval.check_all(output, checking_proc)

correct.each do |user, status|
	puts "#{user}: #{status}"
end


