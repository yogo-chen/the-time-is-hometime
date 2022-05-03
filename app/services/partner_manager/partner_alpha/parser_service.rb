# frozen_string_literal: true

module PartnerManager
  module PartnerAlpha
    class ParserService < ApplicationService
      attr_reader :payload

      def initialize(context, payload)
        super(context)
        @payload = payload
      end

      def call
        result = PartnerAlphaPayloadContract.new.call(payload)
        raise StandardError, 'Failed to parse partner alpha payload' if result.failure? # TODO: error class

        {
          reservation: reservation_data(result),
          guest: guest_data(result)
        }
      end

      private

      def reservation_data(result)
        {
          code: result[:reservation_code],
          status: result[:status],
          nights: result[:nights],
          adults: result[:adults],
          children: result[:children],
          infants: result[:infants],
          total_guests: result[:guests],
          currency: result[:currency],
          payout_price: result[:payout_price],
          security_price: result[:security_price],
          total_price: result[:total_price],
          start_date: result[:start_date],
          end_date: result[:end_date]
        }
      end

      def guest_data(result)
        {
          first_name: result[:guest][:first_name],
          last_name: result[:guest][:last_name],
          email: result[:guest][:email],
          phone_number: result[:guest][:phone]
        }
      end
    end
  end
end
