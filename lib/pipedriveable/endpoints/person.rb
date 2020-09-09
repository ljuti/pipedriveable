module Pipedriveable
  module Endpoints
    class Person
      def initialize(client)
        @client = client
      end

      def find(id)
        response = @client.connection.call(action: :find, entity: :person, id: id)
        if response.success?
          builder.deserialize(response.data)
        end
      end

      def builder
        Pipedriveable::Builders::Person.new
      end
    end
  end
end