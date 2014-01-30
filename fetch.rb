require_relative 'shared.rb'

class Fetch
  def self.tar_files
    files = Dir.entries(DemeritConfig.get['grade_dir'])
    tar_files = files.select { |file| file[-4, 4] == '.tar' }

    user_map = {}

    tar_files.each do |file|
      name = file[0..-5]
      user_map[name] = file
    end

    user_map
  end
end
