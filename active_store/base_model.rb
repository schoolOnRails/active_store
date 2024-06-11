module ActiveStore
  class BaseModel
    class << self
      attr_accessor :store, :attributes_with_schema

      def inherited(subclass)
        subclass.store = []
        subclass.attributes_with_schema = {}
      end

      def attributes(attributes_with_schema)
        @attributes_with_schema = attributes_with_schema

        attributes_with_schema.each do |attr, type|
          define_method(attr) { instance_variable_get("@#{attr}") }
          define_method("#{attr}=") { |value| instance_variable_set("@#{attr}", value) }
        end

        define_method(:initialize) do |**kwargs|
          kwargs.each do |key, value|
            raise ArgumentError, "Unknown attribute: #{key}" unless attributes_with_schema.key?(key)
            validate_type(key, value, attributes_with_schema[key])
            instance_variable_set("@#{key}", value)
          end
          self.class.store << self
        end
      end

      def create(**kwargs)
        new(**kwargs)
      end

      def all
        store
      end

      def find_by(**kwargs)
        store.find do |record|
          kwargs.all? { |key, value| record.send(key) == value }
        end
      end

      def update(id, **kwargs)
        record = find_by(id: id)
        return nil unless record

        kwargs.each do |key, value|
          raise ArgumentError, "Unknown attribute: #{key}" unless @attributes_with_schema.key?(key)
          record.send("#{key}=", value)
        end
        record
      end

      def delete(id)
        record = find_by(id: id)
        store.delete(record) if record
        record
      end

      def clear_store
        self.store = []
      end
    end

    def to_h
      self.class.attributes_with_schema.keys.each_with_object({}) do |attr, hash|
        hash[attr.to_s] = instance_variable_get("@#{attr}")
      end
    end

    private

    def validate_type(attr, value, type)
      unless value.is_a?(type)
        raise ArgumentError, "Invalid type for attribute '#{attr}': expected #{type}, got #{value.class}"
      end
    end
  end
end

