# frozen_string_literal: true

module PartnerManager
  module PartnerBeta
    class ParserService < ApplicationService
      attr_reader :payload

      def initialize(context, payload)
        super(context)
        @payload = payload
      end

      def call
        result = PartnerBetaPayloadContract.new.call(payload)
        puts result.inspect
        raise StandardError, 'Failed to parse partner beta payload' if result.failure? # TODO: error class

        {
          reservation: reservation_data(result),
          guest: guest_data(result)
        }
      end

      private

      def reservation_data(result)
        {
          code: result[:reservation][:code],
          status: result[:reservation][:status_type],
          nights: result[:reservation][:nights],
          adults: result[:reservation][:guest_details][:number_of_adults],
          children: result[:reservation][:guest_details][:number_of_children],
          infants: result[:reservation][:guest_details][:number_of_infants],
          total_guests: result[:reservation][:number_of_guests],
          currency: result[:reservation][:host_currency],
          payout_price: result[:reservation][:expected_payout_amount],
          security_price: result[:reservation][:listing_security_price_accurate],
          total_price: result[:reservation][:total_paid_amount_accurate],
          start_date: result[:reservation][:start_date],
          end_date: result[:reservation][:end_date]
        }
      end

      def guest_data(result)
        {
          first_name: result[:reservation][:guest_first_name],
          last_name: result[:reservation][:guest_last_name],
          email: result[:reservation][:guest_email],
          phone_number: result[:reservation][:guest_phone_numbers].first
        }
      end
    end
  end
end
