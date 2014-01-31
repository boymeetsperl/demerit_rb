require_relative 'shared.rb'
require 'subprocess'

class Extract

  def self.all(user_map)
    assign_dir_map = {}

    user_map.each do |user, arc|
      grade_dir = DemeritConfig.get['grade_dir']
      curr_dir = grade_dir + "/#{user}"
      curr_archive = grade_dir + "/#{arc}"

      Dir.mkdir(curr_dir) if Dir.exists?(curr_dir) != true

      begin
        command = ['tar', '-xf', curr_archive, '--directory', curr_dir]
        Subprocess.check_call(command)
        assign_dir_map[user] = curr_dir
      rescue
        puts "problem extracting #{arc}"
        assign_dir_map[user] = 'did not extract'
      end

    end
    assign_dir_map
  end

end
