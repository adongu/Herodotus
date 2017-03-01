require_relative '02_searchable'
require 'active_support/inflector'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.camelcase.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @class_name = options[:class_name] ? options[:class_name] : name.capitalize
    @primary_key = options[:primary_key] ? options[:primary_key] : :id
    @foreign_key = options[:foreign_key] ? options[:foreign_key] : "#{name}_id".to_sym

  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @class_name = options[:class_name] ? options[:class_name] : name.singularize.capitalize
    @primary_key = options[:primary_key] ? options[:primary_key] : :id
    @foreign_key = options[:foreign_key] ? options[:foreign_key] : "#{self_class_name}_id".downcase.to_sym
  end
end

module Associatable
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options{})
    define_method(name) do
      options = self.class.assoc_options[name]
    end

  end

  def has_many(name, options = {})

  end

  def assoc_options

  end
end

class SQLObject
end
