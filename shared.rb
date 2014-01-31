require 'yaml'

module DemeritConfig
  @config_file = File.open('config.yml', 'r')
  @opts = YAML.load(@config_file)

  def self.get
    @opts
  end

  def self.set(key, val)
  	@opts[key] = val
  end
end