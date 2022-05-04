# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PartnerManager::PartnerAlpha::ParserService do
  describe '.call' do
    let(:context) { Context.new }

    context 'when payload is correct' do
      it 'return correct result' do
        payload = JSON.parse(file_fixture('partner_alpha_payload.json').read)

        result = described_class.call(context, payload)

        expect(result).to be_kind_of Hash
        expect(result).to eq(
          reservation: {
            code: 'YYY12345678',
            status: 'accepted',
            nights: 4,
            adults: 2,
            children: 2,
            infants: 0,
            total_guests: 4,
            currency: 'AUD',
            payout_price: 4200.0,
            security_price: 500.0,
            total_price: 4700.0,
            start_date: Date.new(2021, 4, 14),
            end_date: Date.new(2021, 4, 18)
          },
          guest: {
            first_name: 'Wayne',
            last_name: 'Woodbridge',
            email: 'wayne_woodbridge@bnb.com',
            phone_number: '639123456789'
          }
        )
      end
    end

    context 'when payload is unparseable' do
      it 'raise unparseable error' do
        payload = 'not json string'

        expect { described_class.call(context, payload) }.to raise_error Errors::UnparseablePayloadError
      end
    end
  end
end
