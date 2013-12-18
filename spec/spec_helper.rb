require 'rspec'
require 'palo'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'

  # declare an exclusion filter
  config.filter_run_excluding :broken => true
end