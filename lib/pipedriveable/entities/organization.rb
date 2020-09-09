module Pipedriveable
  module Entities
    class Organization
      attr_reader :id, :name

      def initialize(id)
        @id = id
      end

      def build_from(data)
        @name = data.fetch(:name, "")
      end
    end
  end
end