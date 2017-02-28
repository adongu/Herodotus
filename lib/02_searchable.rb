require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params.keys.map { |key| "#{key} = ?" }.join(" AND ")
    paramsValues = params.values
    DBConnection.execute(<<-SQL, *paramsValues)
      SELECT
        *
      WHERE
        where_line
      FROM
        #{self.table_name}
    SQL
  end
end

class SQLObject extend Searchable
end
