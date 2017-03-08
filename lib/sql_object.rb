require_relative 'db_connection'
require 'active_support/inflector'
class SQLObject
  def self.columns
    @cols ||= (DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    )
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

  rows = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    parse_all(rows)
  end
  def self.parse_all(results)
    debugger
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
      self.send("#{col.to_sym}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    debugger
    self.class.columns.map { |attr|
      self.send(attr)
    }
  end

  def insert
    num_commas = self.class.columns.length - 1
    quest_marks = (["?"] * num_commas).join(",")

    col = attributes.keys.join(",")
    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col})
      VALUES
        (#{quest_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    col = self.class.columns.drop(1).map { |attr_name| "#{attr_name}=?" }.join(",")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      update
        #{self.class.table_name}
      SET
        #{col}
      WHERE
        id = (#{self.id})
    SQL

  end

  def save
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end
end
