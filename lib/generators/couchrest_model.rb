require 'rails/generators/named_base'
require 'rails/generators/active_model'

module CouchrestModel
  module Generators
    class Base < Rails::Generators::NamedBase #:nodoc:

      def self.source_root
        @_couchrest_model_source_root ||= File.expand_path(
	File.join(File.dirname(__FILE__),'couchrest_model', generator_name, 'templates'))
      end
    end

    class ActiveModel < Rails::Generators::ActiveModel #:nodoc:
      def self.all(klass)
        "#{klass}.all"
      end

      def self.find(klass, params=nil)
        "#{klass}.first(#{params})"
      end

      def self.build(klass, params=nil)
        if params
          "#{klass}.new(#{params})"
        else
          "#{klass}.new"
        end
      end

      def save
        "#{name}.save"
      end

      def update_attributes(params=nil)
        "#{name}.update(#{params})"
      end

      def errors
        "#{name}.errors"
      end

      def destroy
        "#{name}.destroy"
      end
    end
  end
end

module Rails
  module Generators
    class GeneratedAttribute #:nodoc:
      def type_class
        return 'DateTime' if type.to_s == 'datetime'
        return type.to_s.camelcase
      end
    end
  end
end
