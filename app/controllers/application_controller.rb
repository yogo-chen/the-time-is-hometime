# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from Exception, with: :render_internal_server_error
  rescue_from Errors::HometimeError, with: :render_error

  def context
    @context ||= Context.new
  end

  def json_body
    JSON.parse(request.raw_post)
  rescue StandardError
    nil
  end

  def render_resource(resource, status: 200)
    render(
      json: {
        data: resource,
        meta: {
          http_status: status
        }
      },
      status: status
    )
  end

  def render_error(err)
    render(
      json: {
        error: {
          message: err.message,
          code: err.code
        },
        meta: {
          http_status: err.http_status
        }
      },
      status: err.http_status
    )
  end

  def render_internal_server_error
    render_error(Errors::InternalServerError.new)
  end
end
