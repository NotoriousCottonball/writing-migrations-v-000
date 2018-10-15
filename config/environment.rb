require 'bundler/setup'
Bundler.require
#Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
#Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}
#Dir[File.join(File.dirname(__FILE__), "../lib/**/*.rb")].each { |f| require f }
#Dir[File.join(File.dirname(__FILE__), "../app/**/*.rb")].each { |f| require f }
require_all '../lib/support', '../app/models'

ENV["SCHOOL_ENV"] ||= "development"

DBRegistry[ENV["SCHOOL_ENV"]].connect!
DB = ActiveRecord::Base.connection

if ENV["SCHOOL_ENV"] == "test"
  ActiveRecord::Migration.verbose = false
end

def drop_db
  DB.tables.each do |table|
    DB.execute("DROP TABLE #{table}")
  end
end
