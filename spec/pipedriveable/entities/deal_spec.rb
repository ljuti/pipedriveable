# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipedriveable::Entities::Deal do
  before do
    Pipedriveable::Client.new.tap do |config|
      config.api_token = "api_token"
    end
  end
  
  describe "Initializing" do
    subject { described_class.new }

    it "can be initialized" do
      expect(subject).to be_instance_of described_class
    end
  end

  describe "Finders" do
    describe ".find" do
      let(:result) { File.read(fixture_file_path("deals/deal.json"))}

      before do
        stub_request(:get, "https://api.pipedrive.com/v1/deals?api_token=api_token").
          with(
            headers: {
              'Accept'=>'application/json',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Pipedriveable Ruby Client :: v0.0.1'
            }).to_return(status: 200, body: result, headers: { "Content-Type" => "application/json" })
      end
      
      subject { described_class.find(1) }
      
      it "responds to find method" do
        expect(described_class).to respond_to(:find)
      end

      it "returns a Pipedrive object" do
        expect(subject).to be_instance_of described_class
        expect(subject.organization).to be_instance_of Pipedriveable::Entities::Organization
        # expect(subject.value).to eq 5000
        expect(subject.id).to eq 1
      end
    end
  end
end