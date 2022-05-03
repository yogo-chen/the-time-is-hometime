# frozen_string_literal: true

module Api
  module V1
    class ReservationsController < ApplicationController
      def upsert
        data = PartnerManager::DynamicParserService.call(context, json_body)
        reservation = nil

        ActiveRecord::Base.transaction do
          guest = GuestManager::UpsertService.call(context, data[:guest])
          reservation = ReservationManager::UpsertService.call(context, data[:reservation].merge(guest: guest))
        end

        render_resource(reservation)
      end
    end
  end
end
