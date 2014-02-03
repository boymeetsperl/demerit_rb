class Compile
  def self.gen_mk(assign_dir, assign_name)
    c_files = Dir.entries(assign_dir).select { |file| file[-2, 2] == '.c' }

    makefile_lines = []
    makefile_lines << ('TARGET = ' + assign_name + "\n")
    makefile_lines << ('SOURCES = ' + c_files.join(' ') + "\n")
    makefile_lines << ("CFLAGS = -ansi -pedantic -Wall -lm\n")
    makefile_lines << ('include ' + DemeritConfig.get['demerit_dir'] +
                       '/resources/edam.mk' + "\n")
    makefile_lines
  end

  def self.create_mk(assign_dir, assign_name)
    begin
      makefile_path = File.join(assign_dir, 'Makefile')
      File.open(makefile_path, 'w') do |f|
        gen_mk(assign_dir, assign_name).each { |line| f.puts(line) }
      end
    rescue
      puts 'problem opening makefile for writing'
      return false
    end
    true
  end

  def self.dir(dir_path)
    makefile_path = File.join(dir_path, 'Makefile')
    return false unless File.exists?(makefile_path)

    Dir.chdir(dir_path)
    begin
      IO.popen(['make'], 'r', err: [:child, :out]) { |pipe| pipe.read }
      return true unless $? != 0
    rescue
      print 'failed to compile #{dir_path}'
      return false
    end

  end

  def self.all(assign_dir_map)
    user_exe_map = {}

    assign_dir_map.each do |student, direc|
      create_mk(direc, student) if DemeritConfig.get['gen_makefile']

      if dir(direc)
        exec_path = File.join(direc, student)
        user_exe_map[student] = exec_path
      else
        user_exe_map[student] = 'failed'
      end

    end
    user_exe_map
  end

end
