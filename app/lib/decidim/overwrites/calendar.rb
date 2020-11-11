# frozen_string_literal: true
module Decidim
  # Holds decidim-calendar version
  module Calendar
    def self.where(query)
      return unless query.fetch(:organization).is_a?(Decidim::Organization)
      Decidim::Calendar::Event.all(query[:organization])
    end
  end
end
