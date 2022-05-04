# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PartnerManager::DynamicParserService do
  describe '.call' do
    let(:context) { Context.new }

    context 'when given partner alpha payload' do
      it 'return parsed partner alpha payload data' do
        payload = JSON.parse(file_fixture('partner_alpha_payload.json').read)

        result = described_class.call(context, payload)

        expect(result).to be_kind_of Hash
      end
    end

    context 'when given partner beta payload' do
      it 'return parsed partner beta payload data' do
        payload = JSON.parse(file_fixture('partner_beta_payload.json').read)

        result = described_class.call(context, payload)

        expect(result).to be_kind_of Hash
      end
    end

    context 'when given unparseable payload' do
      it 'raise unparseable error' do
        payload = 'not json string'

        expect { described_class.call(context, payload) }.to raise_error Errors::UnparseablePayloadError
      end
    end
  end
end
