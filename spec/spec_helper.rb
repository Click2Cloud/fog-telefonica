# TODO: remove when https://github.com/fog/fog-telefonica/issues/202 is fixed
# require 'coveralls'
# Coveralls.wear!

require 'minitest/autorun'
require 'vcr'
require 'fog/core'
require 'fog/telefonica'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/telefonica'
  c.hook_into :webmock
  c.debug_logger = nil # use $stderr to debug
end
