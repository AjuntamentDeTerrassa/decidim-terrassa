# frozen_string_literal: true

require "json"

class TaxonomiesFiltersRemover
  # Parses the plan JSON and removes, from every
  #   imported_taxonomies -> <taxonomy_key> -> <label_key> -> filters
  # array, any filter element whose "items" array is blank (nil or empty).
  #
  # @param input_path  [String] path to the source JSON file
  # @param output_path [String] path where the cleaned JSON will be written
  # @return [Hash] the cleaned data structure
  def self.call(input_path, output_path = nil)
    output_path ||= input_path
    data = JSON.parse(File.read(input_path))

    imported = data["imported_taxonomies"]

    if imported.is_a?(Hash)
      imported.each do |_taxonomy_key, taxonomy_value|
        # Each taxonomy value is a Hash whose keys are labels (e.g. "~ Categories")
        next unless taxonomy_value.is_a?(Hash)

        taxonomy_value.each do |_label_key, label_value|
          next unless label_value.is_a?(Hash)

          filters = label_value["filters"]
          next unless filters.is_a?(Array)

          # Keep only filters where "items" is present AND non-empty
          label_value["filters"] = clean(filters)
        end
      end
    end

    File.write(output_path, JSON.pretty_generate(data))
  end

  def self.clean(filters)
    filters.reject do |filter|
      items = filter["items"]
      items.nil? || (items.respond_to?(:empty?) && items.empty?)
    end
  end
end
