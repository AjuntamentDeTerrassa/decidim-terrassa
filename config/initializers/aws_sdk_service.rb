# frozen_string_literal: true

require "aws-sdk-s3"
require "active_storage/client_service_initialization_overrides"

Aws::S3::Resource.class_eval do
  prepend ActiveStorage::ClientServiceInitializationOverrides
end
