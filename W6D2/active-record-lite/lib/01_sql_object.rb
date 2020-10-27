require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns ||= DBConnection
                   .execute2("SELECT * FROM #{table_name}")
                   .first.map(&:to_sym)
    @columns
  end

  def self.finalize!
    columns.each do |col|
      define_method(col) do
        attributes[col]
      end
      define_method("#{col}=") do |val|
        attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= ActiveSupport::Inflector.tableize(self.name)
  end

  def self.all
    parse_all(DBConnection.execute("SELECT * FROM #{table_name}"))
  end

  def self.parse_all(results)
    results.map { |obj| new(obj) }
  end

  def self.find(id)
    res = DBConnection.execute(<<-SQL)
    SELECT * FROM #{table_name} WHERE id = #{id} LIMIT 1
    SQL
    res.size.nonzero? ? new(*res) : nil
  end

  def initialize(params = {})
    params.each do |name, val|
      raise Exception, "unknown attribute '#{name}'"\
        unless self.class.columns.include?(name.to_sym)

      send("#{name}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| send(col) }
  end

  def insert
    cols = self.class.columns
    cs = cols.join(',')
    qs = (['?'] * cols.size).join(',')
    # puts "INSERT INTO #{self.class.table_name} (#{cs}) VALUES (#{qs})"
    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO #{self.class.table_name} (#{cs}) VALUES (#{qs})
    SQL
    # update id for instance with SQL assigned value
    send('id=', DBConnection.last_insert_row_id)
  end

  def update
    set = self.class.columns.map { |col| "#{col} = ?" }.join(',')
    DBConnection.execute(<<-SQL, *attribute_values, id)
    UPDATE #{self.class.table_name}
    SET #{set}
    WHERE id = ?
    SQL
  end

  def save
    id ? update : insert
  end
end
