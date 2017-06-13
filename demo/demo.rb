require_relative "../lib/db_connection.rb"
require_relative "../lib/associatable.rb"
require_relative "../lib/sql_object.rb"

DB = "car.db"
SQL = "car.sql"


class Owner < SQLObject
  has_many :cars
  has_many_through :repairs, :car, :repairs

  finalize!
end

class Car < SQLObject
  belongs_to :owner
  has_many :repairs

  finalize!
end

class Repair < SQLObject
  belongs_to :car
  has_one_through :owner, :car, :owner

  finalize!
end
