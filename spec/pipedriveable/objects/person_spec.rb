require "spec_helper"

RSpec.describe Pipedriveable::Objects::Person do
  describe "Initializing" do
    let(:data) { Hashie::Mash.new(JSON.parse(File.read(fixture_file_path("people/person.json")))) }

    subject { described_class.new(payload: data) }

    it "can be initialized with proper data" do
      expect(subject).to be_instance_of described_class
      expect(subject.name).to eq "Johnny Doe"
      expect(subject.id).to eq 1

      expect(subject.phone).to be_a Array
      expect(subject.phone).to match_array([
        be_instance_of(described_class::PhoneNumber)
      ])

      expect(subject.email).to be_a Array
      expect(subject.email).to match_array([
        be_instance_of(described_class::EmailAddress)
      ])

      expect(subject.organization).to be_instance_of Pipedriveable::Objects::Organization
      expect(subject.user).to be_instance_of Pipedriveable::Objects::User
    end
  end

  describe "Creating a new Person" do
    subject { described_class.new() }

    it "returns a Person object" do
      expect(subject).to be_instance_of described_class
    end
  end
end