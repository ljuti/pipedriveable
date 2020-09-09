require "spec_helper"

RSpec.describe Pipedriveable::Endpoints::Deal do
  let(:client) do
    Pipedriveable::Client.new.tap do |config|
      config.api_token = "api_token"
    end
  end

  describe "Finders" do
    let(:result) { File.read(fixture_file_path("deals/deal.json"))}
    before do
      stub_request(:get, "https://api.pipedrive.com/v1/deals?api_token=api_token").
        with(
          headers: {
            'Accept'=>'application/json',
            'User-Agent'=>'Pipedriveable Ruby Client :: v0.0.1'
          }
        ).to_return(status: 200, body: result, headers: { "Content-Type" => "application/json" })
    end

    subject { described_class.new(client).find(1) }

    it "finds a deal with specific ID" do
      expect(subject).to be_instance_of Pipedriveable::Entities::Deal
      expect(subject.id).to eq 1
    end
  end
end