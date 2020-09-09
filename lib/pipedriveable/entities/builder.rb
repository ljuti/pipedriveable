module Pipedriveable
  module Entities
    class Builder
      class << self
        def build(kind, data)
          object = initialize_object(kind, data.fetch(:data).fetch(:id))
          resolve_organization(object, data.fetch(:data).fetch(:org_id))
          object
        end

        def initialize_object(kind, id)
          case kind
          when :deal
            Pipedriveable::Entities::Deal.new(id)
          end
        end

        def resolve_organization(object, data)
          object.__send__(:organization=, build_organization(data))
        end

        def build_organization(data)
          org = Pipedriveable::Entities::Organization.new(data.fetch(:value))
          org.build_from(data)
          org
        end
      end
    end
  end
end