require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider           => 'Rackspace',
    :rackspace_username => 'agutierrezt',
    :rackspace_api_key  => '27a1e5b31549420d81ce68c454c55ac3',
    :rackspace_region    => :dfw
  }
  config.fog_directory = 'unoverflow'
end
