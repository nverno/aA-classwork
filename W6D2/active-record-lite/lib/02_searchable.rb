require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    pars = params.keys.map { |key| "#{key} = ?" }.join(' AND ')
    res = DBConnection.execute(<<-SQL, *params.values)
    SELECT * FROM #{table_name} WHERE #{pars}
    SQL
    parse_all(res)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
