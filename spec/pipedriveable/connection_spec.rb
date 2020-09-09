# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipedriveable::Connection do
  let(:client) do
    Pipedriveable::Client.new.tap do |client|
      client.config.api_token = "api_token"
    end
  end
  
  describe "Initializing" do
    describe "with API token" do
      subject { described_class.new(client: client) }
  
      it "must have API token available" do
        expect(subject).to respond_to(:api_token)
        expect(subject.api_token).not_to be_nil
      end
    end

    describe "without API token" do
      subject { described_class.new(client: Pipedriveable::Client.new) }

      it "raises error if API token is not set" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe "Connection object" do
    subject { described_class.new(client: client) }

    it "returns a connection object" do
      expect(subject).to respond_to(:connection)
      expect(subject.connection).to be_a Faraday::Connection
    end

    it "has proper handlers set" do
      connection = subject.connection
      expect(connection.builder.handlers).to include Faraday::Request::UrlEncoded
      expect(connection.builder.handlers).to include FaradayMiddleware::Mashify
      expect(connection.builder.handlers).to include FaradayMiddleware::ParseJson
    end

    it "has Pipedrive API options set" do
      connection = subject.connection
      expect(connection.url_prefix).to be_a URI
      expect(connection.url_prefix.to_s).to match /api.pipedrive.com/
    end
  end
end