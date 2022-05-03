# frozen_string_literal: true

class ApplicationController < ActionController::API
  def context
    @context ||= Context.new
  end

  def json_body
    JSON.parse(request.raw_post)
  rescue StandardError
    nil
  end
end
