# frozen_string_literal: true

require "decidim/maintenance"

namespace :decidim do
  namespace :taxonomies do
    desc "Removes filters from each tmp/taxonomies/*_plan.json (rewrites files in place)"
    task :remove_filters_from_all_plans, [] => :environment do |_task, _args|
      files = Rails.root.glob("tmp/taxonomies/*_plan.json")
      if files.empty?
        log.warn "No *_plan.json files found in tmp/taxonomies"
        next
      end

      files.each do |file_path|
        log.info "Removing filters from #{file_path}"
        TaxonomiesFiltersRemover.call(file_path)
      end
      log.info "Done."
    end
  end
end
