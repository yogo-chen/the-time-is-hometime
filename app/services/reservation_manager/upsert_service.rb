# frozen_string_literal: true

module ReservationManager
  #
  # UpsertService will update a reservation by reservation code or create a new one if does not exist.
  #
  class UpsertService < ApplicationService
    attr_reader :data

    def initialize(context, data)
      super(context)
      @data = data
    end

    def call
      ActiveRecord::Base.transaction do
        reservation = Reservation.find_by_code(data[:code])

        if reservation.nil?
          reservation = Reservation.create!(data)
        else
          reservation.update!(data)
        end

        reservation
      end
    end
  end
end
