# frozen_string_literal: true

# This migration comes from decidim (originally 20161011141033)
# This file has been modified by `decidim upgrade:migrations` task on 2025-12-09 18:57:43 UTC
class AddBannerImageToProcesses < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_participatory_processes, :banner_image, :string
  end
end
