require 'rspec'
require 'webmock'
require 'vcr'
require 'super_zombies_api'

RSpec.configure do |config|

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
    c.default_cassette_options = { :record => :once }
    c.hook_into :webmock
  end

end
