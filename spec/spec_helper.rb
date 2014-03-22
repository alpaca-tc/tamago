require 'rspec'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

RSpec.configure do |config|
  config.order = 'random'
  config.raise_errors_for_deprecations!
end
