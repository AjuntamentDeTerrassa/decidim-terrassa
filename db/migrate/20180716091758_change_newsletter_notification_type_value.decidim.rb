# frozen_string_literal: true
# This migration comes from decidim (originally 20180611121852)

class ChangeNewsletterNotificationTypeValue < ActiveRecord::Migration[5.2]
  class User < ApplicationRecord
    self.table_name = :decidim_users
  end

  def up
  end

  def down
  end
end
