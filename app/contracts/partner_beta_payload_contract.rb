# frozen_string_literal: true

class PartnerBetaPayloadContract < ApplicationContract
  params do
    required(:reservation).hash do
      required(:code).filled(:string)
      required(:start_date).filled(:date)
      required(:end_date).filled(:date)
      required(:expected_payout_amount).filled(:decimal)
      required(:guest_details).hash do
        required(:localized_description).filled(:string)
        required(:number_of_adults).filled(:integer)
        required(:number_of_children).filled(:integer)
        required(:number_of_infants).filled(:integer)
      end
      required(:guest_email).filled(:string)
      required(:guest_first_name).filled(:string)
      required(:guest_last_name).filled(:string)
      required(:guest_phone_numbers).array(:str?)
      required(:listing_security_price_accurate).filled(:decimal)
      required(:host_currency).filled(:string)
      required(:nights).filled(:integer)
      required(:number_of_guests).filled(:integer)
      required(:status_type).filled(:string)
      required(:total_paid_amount_accurate).filled(:decimal)
    end
  end
end
