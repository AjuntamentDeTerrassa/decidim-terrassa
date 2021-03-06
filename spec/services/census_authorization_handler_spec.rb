# coding: utf-8
# frozen_string_literal: true
require "rails_helper"
require "decidim/dev/test/authorization_shared_examples"

describe CensusAuthorizationHandler do
  let(:subject) { handler }
  let(:handler) { described_class.from_params(params) }
  let(:document_number) { "12345678A" }
  let(:document_type) { :nie }
  let(:date_of_birth) { Date.civil(1987, 9, 17) }
  let(:params) do
    {
      document_number: document_number,
      document_type: document_type,
      date_of_birth: date_of_birth
    }
  end
  let(:xml) do
"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<Envelope>\n<Body>\n<existeixAmbDistricteResponse>\n<return>\n<districte>4</districte>\n<existeix>true</existeix>\n<missatgeError/>\n<resposta>0</resposta>\n</return>\n</existeixAmbDistricteResponse>\n</Body>\n</Envelope>\n"
  end

  before do
    handler.user = create(:user, nickname: "test_user")
  end

  context "with a valid response" do
    before do
      allow(handler)
        .to receive(:response)
        .and_return(Nokogiri::XML(xml).remove_namespaces!)
    end

    it_behaves_like "an authorization handler"

    describe "document_number" do
      context "when it isn't present" do
        let(:document_number) { nil }

        it { is_expected.not_to be_valid }
      end

      context "with an invalid format" do
        let(:document_number) { "(╯°□°）╯︵ ┻━┻" }

        it { is_expected.not_to be_valid }
      end
    end

    describe "document_type" do
      context "when it isn't present" do
        let(:document_type) { nil }

        it { is_expected.not_to be_valid }
      end

      context "when it has a weird value" do
        let(:document_type) { :driver_license }

        it { is_expected.not_to be_valid }
      end
    end

    describe "date_of_birth" do
      context "when it isn't present" do
        let(:date_of_birth) { nil }

        it { is_expected.not_to be_valid }
      end

      context "when it's under 16" do
        let(:date_of_birth) { 15.years.ago }

        it { is_expected.not_to be_valid }
      end

      context "when data from a date field is provided" do
        let(:params) do
          {
            "date_of_birth(1i)" => "2010",
            "date_of_birth(2i)" => "8",
            "date_of_birth(3i)" => "16"
          }
        end

        let(:date_of_birth) { nil }

        it "correctly parses the date" do
          expect(subject.date_of_birth.year).to eq(2010)
          expect(subject.date_of_birth.month).to eq(8)
          expect(subject.date_of_birth.day).to eq(16)
        end
      end
    end

    describe "district" do
      it "parses it from the response" do
        expect(subject.metadata).to eq(district: "4")
      end
    end

    context "when everything is fine" do
      it { is_expected.to be_valid }
    end
  end

  context "unique_id" do
    it "generates a different ID for a different document number" do
      handler.document_number = "ABC123"
      unique_id1 = handler.unique_id

      handler.document_number = "XYZ456"
      unique_id2 = handler.unique_id

      expect(unique_id1).to_not eq(unique_id2)
    end

    it "generates the same ID for the same document number" do
      handler.document_number = "ABC123"
      unique_id1 = handler.unique_id

      handler.document_number = "ABC123"
      unique_id2 = handler.unique_id

      expect(unique_id1).to eq(unique_id2)
    end

    it "hashes the document number" do
      handler.document_number = "ABC123"
      unique_id = handler.unique_id

      expect(unique_id).to_not include(handler.document_number)
    end
  end

  context "with an invalid response" do
    context "with a malformed response" do
      before do
        allow(handler)
          .to receive(:response)
          .and_return(Nokogiri::XML("Messed up response!").remove_namespaces!)
      end

      it { is_expected.to_not be_valid }
    end

    context "with an invalid response code" do
      before do
        allow(handler)
          .to receive(:response)
          .and_return(Nokogiri::XML("<codiRetorn>02</codiRetorn>").remove_namespaces!)
      end

      it { is_expected.to_not be_valid }
    end
  end
end
