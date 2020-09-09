# frozen_string_literal: true

module Pipedriveable
  module Entities
    class Deal
      attr_reader :id, :organization

      def initialize(id = nil)
        @id = id
      end
      
      private

      def organization=(org)
        @organization = org
      end

      class << self
        def find(id)
          Pipedriveable::Client.find(entity: :deal, id: id)
        end
      end
    end
  end
end