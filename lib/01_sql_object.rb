 require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # cols is hash of value
    @cols ||= (DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    )
    # array of columns in :names
    @syms ||= @cols.first.map do |col|
      col.to_sym
    end

  end

  def self.finalize!
    self.columns.each do |col|
      define_method("#{col}") do
        self.attributes[col]
      end

      define_method("#{col}=") do |new_val|
        self.attributes[col] = new_val
      end
    end

  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= "cats"
  end

  def self.all
    # array of hashes of rows

  rows = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    parse_all(rows)
  end
# results is array of hashes of rows
  def self.parse_all(results)
    results.map do |el|
      self.new(el)
    end
  end

  def self.find(id)
    hash = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
      LIMIT
        1
    SQL

    hash.first.nil? ? nil : self.new(hash.first)
  end

  def initialize(params = {})
    params.each do |col, val|
      raise "unknown attribute '#{col}'" unless self.class.columns.include?(col.to_sym)
      self.send("#{col}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    @attributes.map do |col, val|
      val
    end
    #
  end

  def insert
    #  array of columns in :names
    num_commas = self.class.columns.length - 1
    commas = ["?"] * num_commas

    col = attributes.keys.join(",")
    quest_marks = commas.join(",")

    DBConnection.execute(<<-SQL, attribute_values)
      INSERT INTO
        #{self.class.table_name}, #{col}
      VALUES
        #{quest_marks}
    SQL
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
