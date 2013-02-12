require 'ostruct'

module Autotest

  CONFIGURATIONS_FILE_NAME = File.expand_path '../../config.yml', __FILE__

  @config = nil
  @ostruct = nil
  if File.exists? CONFIGURATIONS_FILE_NAME
    @config = YAML.load IO.read CONFIGURATIONS_FILE_NAME
    @ostruct = OpenStruct.new(@config)
  end

  Autotest.const_set :CONFIG, @ostruct
end