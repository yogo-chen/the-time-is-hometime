# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationManager::UpsertService do
  describe '.call' do
    let(:context) { Context.new }
    let(:data) do
      {
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
      }
    end
    let(:reservation) { Reservation.new(data) }

    context 'when reservation with a reservation code is not exist' do
      it 'create a new reservation' do
        expect(Reservation).to receive(:find_by_code).with(data[:code]).and_return(nil)
        expect(Reservation).to receive(:create!).with(data).and_return(reservation)

        result = described_class.call(context, data)

        expect(result).to eq(reservation)
      end
    end

    context 'when reservation with a reservation code is already exist' do
      it 'update the reservation' do
        expect(Reservation).to receive(:find_by_code).with(data[:code]).and_return(reservation)
        expect(reservation).to receive(:update!).with(data).and_return(reservation)
        expect(Reservation).not_to receive(:create!)

        result = described_class.call(context, data)

        expect(result).to eq(reservation)
      end
    end
  end
end
