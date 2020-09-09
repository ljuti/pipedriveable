# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipedriveable::Client do
  describe "Configuration" do
    subject { described_class.new }

    it "is configurable" do
      expect(subject).to respond_to(:config)
      expect(subject.config).to respond_to(:api_token)
    end
  end

  describe "Finders" do
    describe "#find" do
      let(:result_set) { File.read(fixture_file_path("people/person.json")) }

      before do
        stub_request(:get, "https://api.pipedrive.com/v1/persons?api_token=api_token").
          with(
            headers: {
              'Accept'=>'application/json',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Pipedriveable Ruby Client :: v0.0.1'
          }).to_return(status: 200, body: result_set, headers: { "Content-Type" => "application/json" })
      end
      
      subject { described_class.new.configure.find(entity: :person, id: 1) }

      it "returns a Pipedrive object" do
        expect(subject).to be_truthy
        expect(subject).to be_instance_of Pipedriveable::Objects::Person
        expect(subject.name).to eq "Johnny Doe"
        subject.phone.each do |number|
          expect(number).to be_instance_of Pipedriveable::Objects::Person::PhoneNumber
        end

        subject.email.each do |email|
          expect(email).to be_instance_of Pipedriveable::Objects::Person::EmailAddress
        end
      end
    end
    
    describe ".find" do
      describe "Success" do
        let(:result_set) { File.read(fixture_file_path("deals/deal.json")) }

        before do
          stub_request(:get, "https://api.pipedrive.com/v1/deals?api_token=api_token").
            with(headers: {
              'Accept'=>'application/json',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Pipedriveable Ruby Client :: v0.0.1'
              }
            ).
            to_return(status: 200, body: result_set, headers: { "Content-Type" => "application/json" })
        end

        subject { described_class.find(entity: :deal, id: 1) }

        it "returns a Pipedrive object" do
          expect(subject).to be_instance_of Pipedriveable::Entities::Deal
          expect(subject.id).to eq 1
        end
      end
    end
  end
end