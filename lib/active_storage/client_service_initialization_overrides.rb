# frozen_string_literal: true

require "active_support/concern"

module ActiveStorage
  module ClientServiceInitializationOverrides
    extend ActiveSupport::Concern

    def initialize(options = {})
      opts = options.dup.except(:public)
      @client = options[:client] || Aws::S3::Client.new(opts)
    end
  end
end
