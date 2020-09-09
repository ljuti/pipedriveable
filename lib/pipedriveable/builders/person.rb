module Pipedriveable
  module Builders
    class Person
      OBJECT_KEYS = [
        :id,
        :name,
        :first_name,
        :last_name,
        :phone,
        :email
      ]

      def deserialize(data)
        Pipedriveable::Objects::Person.new(data: data)
      end
    end
  end
end