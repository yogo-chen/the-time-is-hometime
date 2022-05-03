# frozen_string_literal: true

module GuestManager
  #
  # UpsertService will update a guest by guest email or create a new one if does not exist.
  #
  class UpsertService < ApplicationService
    attr_reader :data

    def initialize(context, data)
      super(context)
      @data = data
    end

    def call
      ActiveRecord::Base.transaction do
        guest = Guest.find_by_email(data[:email])

        if guest.nil?
          guest = Guest.create!(data)
        else
          guest.update!(data)
        end

        guest
      end
    end
  end
end
