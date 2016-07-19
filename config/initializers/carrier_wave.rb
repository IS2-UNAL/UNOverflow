require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider           => 'Rackspace',
    :rackspace_username => ENV["RACKSPACE_USERNAME"],
    :rackspace_api_key  => ENV["RACKSPACE_API_KEY"],
    :rackspace_region    => :dfw
  }
  config.fog_directory = 'unoverflow'
end
