require "dry/schema"

module Pipedriveable
  module Api
    module Schema
      PhoneNumber = Dry::Schema.JSON do
        required(:value).filled(:string)
        required(:primary).value(:boolean)
      end

      Person = Dry::Schema.JSON do
        required(:name).filled(:string)
        required(:first_name).filled(:string)
        required(:last_name).filled(:string)
        required(:phone).array(PhoneNumber)
      end
    end
  end
end