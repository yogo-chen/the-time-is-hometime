# frozen_string_literal: true

module PartnerManager
  #
  # DynamicParserService will take a request payload and parse it using several partner parsers.
  # It will return the first successful parsed result.
  # When there are no successful parser, it will raise parser error.
  # The result will be a hash containing guest data on `guest` hash key
  # and reservation data on `reservation` hash key.
  #
  class DynamicParserService < ApplicationService
    PARSER_SERVICES = [
      PartnerAlpha::ParserService,
      PartnerBeta::ParserService
    ].freeze

    attr_reader :payload

    def initialize(context, payload)
      super(context)
      @payload = payload
    end

    def call
      PARSER_SERVICES.each do |parser_service|
        result = call_parser_service(parser_service)
        return result unless result.nil?
      end
      raise 'Failed to dynamically parse partner payload' # TODO: error class
    end

    private

    def call_parser_service(parser_service)
      parser_service.call(context, payload)
    rescue StandardError
      nil
    end
  end
end
