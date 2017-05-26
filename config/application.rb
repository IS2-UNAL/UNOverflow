require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module UnOverflow
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.tinymce.install = :compile

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_mailer.default_url_options = { host: 'unoverflow.herokuapp.com' }
  end
end
