# frozen_string_literal: true

require 'rspec'

# Add the spec directory to the load path
$LOAD_PATH.unshift(File.dirname(__FILE__))

# Auto-load all Ruby files in the lib directory.
Dir["#{File.dirname(__FILE__)}/../lib/*.rb"].sort.each { |file| require file }
