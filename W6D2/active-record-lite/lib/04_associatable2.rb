require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    t_opts = assoc_options[through_name]

    # SELECT
    #   houses.*
    # FROM
    #   humans
    # JOIN
    #   houses ON humans.house_id = houses.id
    # WHERE
    #   humans.id = ?
    define_method(name) do
      s_opts = t_opts.model_class.assoc_options[source_name]
      s_table = s_opts.table_name
      t_table = t_opts.table_name
      val = send(t_opts.foreign_key)
      res = DBConnection.execute(<<-SQL, val)
        SELECT #{s_table}.*
        FROM #{t_table}
        JOIN #{s_table}
        ON #{t_table}.#{s_opts.foreign_key} = #{s_table}.#{s_opts.primary_key}
        WHERE #{t_table}.#{t_opts.primary_key} = ?
      SQL
      s_opts.model_class.parse_all(res).first
    end
  end
end
