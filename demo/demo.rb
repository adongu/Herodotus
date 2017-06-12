require_relative "../lib/db_connection.rb"
require_relative "../lib/associatable.rb"
require_relative "../lib/sql_object.rb"

DB = "car.db"
SQL = "car.sql"


class Owner < SQLObject
  has_one :car
  has_many_through :parts, :car, :parts

  finalize!
end

class Car < SQLObject
  has_many :owner
  has_many :parts

  finalize!
end

class Repair < SQLObject
  belongs_to :car
  has_one_through :owner, :car, :owner

  finalize!
end
