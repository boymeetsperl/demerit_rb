require_relative 'shared.rb'
require_relative 'fetch.rb'
require_relative 'extract.rb'
require_relative 'compile.rb'
require_relative 'eval.rb'

DemeritConfig.set('assign_name', 'project')
puts DemeritConfig.get['assign_name']
user_map = Fetch.tar_files
assign_dir = Extract.all(user_map)
exes = Compile.all(assign_dir)

output = Eval.all(exes)
output.each { |user, val| puts "#{user}: #{val}"}

checking_proc = Proc.new do |res|
	puts res
	puts 'is this correct'
	gets.chomp == 'yes' ? true : false
end

# for some reason this is getting filled with wrong 
# results... outputs, not true/false values

correct = Eval.check_all(output, checking_proc)

correct.each do |user, status|
	puts "#{user}: #{status}"
end