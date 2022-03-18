# frozen_string_literal: true

class IndexExistingGroupsInSearches < ActiveRecord::Migration[6.0]
  def up
    Decidim::UserGroup.find_each(&:try_update_index_for_search_resource)
  end

  def down; end
end
