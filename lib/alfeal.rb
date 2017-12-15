require 'alfeal/api'
require 'yaml'
require 'byebug'

module Alfeal
  class << self
    def setup
      [:config].each { |service| send(service) }
    end

    def index(person, number)
      this_is_ugly = [
        [1, 2, 2],
        [3, 5, 7],
        [4, 6, 8],
        [9, 11, 13],
        [10, 12, 14]
      ]

      this_is_ugly[person][number]
    end

    # Returns application version
    #
    # @return [String] App version
    def version
      @version ||= IO.read(root.join('VERSION')).strip
    end

    # Returns application configuration file path
    #
    # @return [String] App configuration file path
    def config_file
      root.join('config/config.yml')
    end

    # Returns application configuration
    #
    # @return [Hash] App configuration
    def config
      @config ||= begin
        begin
          yml = YAML.load_file(config_file)

          yml[env].empty? ? fail(NoConfigFileForEnvError) : yml[env]
        rescue Errno::ENOENT
          raise NoConfigFileError
        end
      end
    end

    # Returns application enviroment
    #
    # @return [String] App environment
    def env
      if defined?(RACK_ENV)
        RACK_ENV
      else
        ENV['RACK_ENV'] || 'development'
      end
    end

    # Returns application root directory
    #
    # @return [String] App root directory
    def root
      @root ||= Pathname.new(File.dirname(File.expand_path('../', __FILE__)))
    end
  end
end
