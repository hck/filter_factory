MODELS = File.join(File.dirname(__FILE__), 'models')

require 'rubygems'

require 'mysql2'
require 'mongoid'
require 'active_record'
require 'factory_girl'

require 'filter_factory'

require 'models/ar_post'
require 'models/m_post'

Mongoid.configure do |config|
  config.connect_to 'mongoid_filter_factory_test'
end
Mongoid.logger.level = Logger::ERROR
Mongo::Logger.logger.level = Logger::ERROR

# create mysql database
client = Mysql2::Client.new(host: '127.0.0.1', username: 'root', password: nil)
client.query('CREATE DATABASE IF NOT EXISTS active_record_filter_factory_test')
client.close

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  database: 'active_record_filter_factory_test'
)

# create mysql table if not exists
ActiveRecord::Base.connection.execute('DROP TABLE IF EXISTS ar_posts')
ActiveRecord::Base.connection.create_table(:ar_posts) do |t|
  t.string :title
  t.string :author
  t.integer :views
end

FactoryGirl.definition_file_paths = [File.join(File.dirname(__FILE__), 'factories')]
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.mock_with :rspec

  config.after(:each) do
    ARPost.delete_all
    MPost.delete_all
  end
end
