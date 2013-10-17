require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'
  require 'capybara/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # ## Mock Framework
    config.mock_with :rspec

    # Devise
    config.include Devise::TestHelpers, :type => :controller
    config.include Devise::TestHelpers, :type => :view

    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"

    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    config.include Capybara::DSL

    #Database cleaner
    # config.before(:suite) do
    #   DatabaseCleaner.strategy = :truncation
    # end

    # config.before(:each) do
    #   DatabaseCleaner.start
    # end

    # config.after(:each) do
    #   DatabaseCleaner.clean
    # end
  end
end

Spork.each_run do
  # Подгружаем файлы из директории app/
  Dir["#{Rails.root}/app/**/*.rb"].each {|file| load file }
  # Подгружаем файл маршрутов rails
  load "#{Rails.root}/config/routes.rb"
  # Перезагружаем фабрики
  FactoryGirl.reload
end


