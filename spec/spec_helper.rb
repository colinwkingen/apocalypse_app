ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.after(:each) do
    Amount.all().each() do |amount|
      amount.destroy()
    end
    Resource.all().each() do |resource|
      resource.destroy()
    end
    User.all().each() do |user|
      user.destroy()
    end
    Scenario.all().each() do |scenario|
      scenario.destroy()
    end
  end
end
