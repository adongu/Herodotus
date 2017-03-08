require_relative 'db_connection'
require_relative 'sql_object'

module Searchable
  def where(params)
    where_line = params.map { |key, _| "#{key.to_sym} = ?" }.join(" AND ")
    paramsValues = params.values
    query = DBConnection.execute(<<-SQL, *paramsValues)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL
    parse_all(query)
  end
end

class SQLObject
  extend Searchable
end
