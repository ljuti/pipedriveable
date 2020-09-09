module Pipedriveable
  module Endpoints
    class Deal

      def initialize(client)
        @client = client
      end

      def find(id)
        data = @client.connection.call(action: :find, entity: :deal, id: id)

        Pipedriveable::Entities::Builder.build(:deal, data)
      end

    end
  end
end