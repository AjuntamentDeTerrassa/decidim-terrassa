# -*- coding: utf-8 -*-
# frozen_string_literal: true

Decidim.configure do |config|
  config.application_name = "Participa a Terrassa"
  config.mailer_sender    = "Participa a Terrassa <notificacions.participa@terrassa.cat>"
  config.maximum_attachment_size = 50.megabytes

  config.unconfirmed_access_for = 2.days

  # Uncomment this lines to set your preferred locales
  config.available_locales = %w{ca es}
  config.default_locale = :ca

  # Geocoder configuration
  config.maps = {
    provider: :here,
    api_key: Rails.application.secrets.maps[:api_key],
    static: { url: "https://image.maps.ls.hereapi.com/mia/1.6/mapview" }
  }
  config.geocoder = {
    timeout: 5,
    units: :km
  }

  # Custom calculate reference method
  config.resource_reference_generator = lambda do |resource, feature|
    class_identifier = resource.class.name.demodulize[0..3].upcase
    "#{class_identifier}-#{resource.id}"
  end

  # Currency unit
  config.currency_unit = "€"

  # The number of reports which an object can receive before hiding it
  # config.max_reports_before_hiding = 3

  if ENV["HEROKU_APP_NAME"].present?
    config.base_uploads_path = ENV["HEROKU_APP_NAME"] + "/"
  end
end

Decidim::Verifications.register_workflow(:census_authorization_handler) do |auth|
  auth.form = "CensusAuthorizationHandler"
  auth.options do |options|
    options.attribute :district, type: :string, required: false
  end
end

Decidim.menu :menu do |menu|
  menu.item I18n.t("menu.normativa"),
    "/processes_groups/6",
    position: 3,
    active: :inclusive,
    if: Decidim::ParticipatoryProcess.where(decidim_participatory_process_group_id: 6).published.public_spaces.any?
end

# Disable SSL checking of the SMTP
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

