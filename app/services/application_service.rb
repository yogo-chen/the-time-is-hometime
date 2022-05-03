# frozen_string_literal: true

class ApplicationService
  attr_reader :context

  def initialize(context)
    @context = context
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
