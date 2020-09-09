require "spec_helper"

RSpec.describe Pipedriveable::Entities::Person do
  describe "Initialization" do
    let(:data) do
      {
        first_name: "John",
        last_name: "Doe",
        phones: [
          {
            number: "+358501234567",
            primary: true
          }
        ]
      }
    end

    subject { described_class.new(data) }
    
    it "can be initialized" do
      expect(subject).to be_instance_of described_class
      expect(subject.first_name).to eq "John"
    end
  end
end