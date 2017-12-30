require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

def self.table_name
  self.to_s.downcase.pluralize
end

def self.column_names
  DB[:conn].results_as_hash = true

  sql = "pragma table_info('#{table_name}')"

  table_info = DB[:conn].execute(sql)
  column_names = []
  table_info.map { |row| column_names << row["name"] }
  column_names.compact
end

def initialize(options={})
  options.each do |property, value|
    self.send("#{property}=", value)
  end
  #options.each { |property, value| self.send("#{property}=", value) }
end

def save
  sql = "INSERT INTO #{table_name_for_insert} (#{col_names_for_insert})"

end

def table_name_for_insert
  self.class.table_name
end

end
