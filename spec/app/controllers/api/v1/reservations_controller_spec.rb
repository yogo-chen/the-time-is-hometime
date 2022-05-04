# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe 'POST upsert' do
    context 'when given partner alpha payload' do
      it 'return status 200' do
        post(:upsert, body: file_fixture('partner_alpha_payload.json').read)
        expect(response.status).to eq 200
      end
    end

    context 'when given partner beta payload' do
      it 'return status 200' do
        post(:upsert, body: file_fixture('partner_beta_payload.json').read)
        expect(response.status).to eq 200
      end
    end

    context 'when given malformed payload' do
      it 'return status 400' do
        post(:upsert, body: 'not json string')
        expect(response.status).to eq 400
      end
    end
  end
end
