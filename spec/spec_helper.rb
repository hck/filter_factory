MODELS = File.join(File.dirname(__FILE__), 'models')

require 'rubygems'

require 'mongoid'
require 'active_record'
require 'database_cleaner'
require 'factory_girl'

require 'filter_factory'

Dir["#{MODELS}/*.rb"].each { |f| require f }

Mongoid.configure do |config|
  config.connect_to 'mongoid_filter_factory_test'
end
#Mongoid.logger = Logger.new($stdout)
#Moped.logger = Logger.new($stdout)

ActiveRecord::Base.establish_connection(
  adapter: "mysql2",
  database: "active_record_filter_factory_test"
)
ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS ar_posts")
ActiveRecord::Base.connection.create_table(:ar_posts) do |t|
  t.string :title
  t.string :author
  t.integer :views
end
#ActiveRecord::Base.logger = Logger.new($stdout)
#ActiveRecord::Base.logger.level = Logger::DEBUG

FactoryGirl.definition_file_paths = [File.join(File.dirname(__FILE__), 'factories')]
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.mock_with :rspec
  config.color_enabled = true

  config.before(:suite) do
    mongoid = DatabaseCleaner[:mongoid]
    mongoid.strategy = :truncation
    mongoid.clean_with(:truncation)

    active_record = DatabaseCleaner[:active_record]
    active_record.strategy = :truncation
    active_record.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end