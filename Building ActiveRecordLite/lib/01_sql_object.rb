require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    # debugger
    # data =
    return @colm if @colm.nil? == false
    data = DBConnection.execute2(<<-SQL)
    -- debugger
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    columns = []
    # data.class
    data[0].each do |key,value|
    # data.each do |key,value|
      columns << key.to_sym
    end
    @colm = columns
  end

  def self.finalize!
    # debugger
    self.columns
    @colm.each do |column|
      # debugger
      define_method(column) do
        self.attributes[column]
        # debugger
      end
      define_method("#{column}=") do |args|
        self.attributes[column] = args
      end
    end

  end

  def self.table_name=(table_name)
    @table_name = table_name
    # ...
  end

  def self.table_name
    # ...
    # p self.class
    # debugger

    single_entity = self.to_s.downcase
    table_name = single_entity + 's'
    @table_name = table_name
  end

  def self.all
    # debugger
    everything = DBConnection.execute2(<<-SQL, )
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{self.table_name}.id >= 1
    SQL
    result = []
    everything.each do |data|
      next if data.is_a?(Array)
      # debugger
      result << self.new(data)
    end
    result
    # ...
  end

  def self.parse_all(results)
    # ...
    # debugger
    resulting_obj = []
    results.each do |hash|
      # next if data.is_a?(Array)
      resulting_obj << self.new(hash)
    end
    resulting_obj
  end

  def self.find(id)
    # ...
    thing = DBConnection.execute2(<<-SQL, id)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{self.table_name}.id = ?
    SQL
    # debugger
    result = []
    return nil if thing.length == 1
    thing.each do |ans|
      next if ans.is_a?(Array)
      result = self.new(ans)
    end
    result
  end

  def initialize(params = {})
    # ...
    # self.columns
    # self.finalize!
    # debugger
    # self.columns
    params.each do |k,v|
      attrubutes = k.to_sym
        if self.class.instance_methods.include?(attrubutes)
          self.send("#{attrubutes}=", v)
        else
          raise "unknown attribute '#{k}'"
        end
      # end
      # raise "unknown attribute #{k}" if @colm.include?(k) == false
      # @attributes[k] = v
      # self.finalize!
    end
  end

  # def method_missing(method_name=(values))
  #   new_attribute = method_name
  #   if @colm.include?(new_attribute)
  #   end
  #   # return super if @colm.include?(name)
  #
  #
  # end

  def attributes
    # ...
    # debugger
    # f = method_missing(name)
    @attributes ||= {}
    # attributes = Hash.new {|h,k| h[k] = []}
    # @attributes = @colm.map {|colm| attributes[colm]}
    # unless instance_variables(false).include?(f)
    #   # print f
    # end

      # @attribute ={}
  end

  def attribute_values
    # values = []
    @attributes.map {|k,v| v}
      # values << v
    # end
    # values
  end

  def insert
    # ...
    # self.columns
    # debugger
    self.columns
    colm_names = @colm.join(", ")
    variables = ["?"]*(@colm.length).join(", ")
    DBConnection.execute2(<<-SQL, colm_names)
    INSERT INTO
      #{self.table_name} ()
    VALUES
      #{variables}
    SQL

  end

  def update
    # ...
  end

  def save
    # ...
  end
end
