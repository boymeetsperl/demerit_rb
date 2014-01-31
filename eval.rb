require_relative 'shared.rb'
class Eval

  def self.spawn(args, input)
    output = []
    IO.popen(args, 'w+') do |pipe|
      pipe.puts input
      pipe.close_write
      pipe.each_line do |line|
        output << line
      end
    end
    output
  end

  def self.program(path)
    arg_list = []
    arg_list << path

    unless DemeritConfig.get['argv'] == 'none'
      arg_list << DemeritConfig.get['argv']
    end

    begin
      output = spawn(arg_list, DemeritConfig.get['stdin'])
    rescue => e
      puts e.inspect
      puts 'something bad happened'
    end
    output
  end

  def self.all(exe_map)
    user_out = {}

    exe_map.each do |student, exe|
      if exe == 'failed'
        user_out[student] = 'did not run'
      else
        user_out[student] = program(exe)
      end
    end
    user_out
  end

  # a function which verifies output using checking_proc
  # I really like this function :)
  def self.check(output, checking_proc)
    return false if output == 'did not run'
    return true if checking_proc.call(output)
    false
  end

  # method to check the output of everything in the map
  def self.check_all(output_map, checking_proc)
    correct = {}
    output_map.each do |user, output|
      correct[user] = check(output, checking_proc)
    end
  end

end
