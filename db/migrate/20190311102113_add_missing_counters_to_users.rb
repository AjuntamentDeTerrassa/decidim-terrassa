class AddMissingCountersToUsers < ActiveRecord::Migration[5.2]
  # This migration has wrong order and is executed after 20190307141769_remove_following_users_count_from_users.decidim.rb
  def up
    return if ActiveRecord::Base.connection.column_exists?(:decidim_users, :following_users_count)

    # This addition is unnecessary if executed after 20190307141769_remove_following_users_count_from_users.decidim.rb
    # add_column :decidim_users, :following_users_count, :integer, null: false, default: 0
  end

  def down
    return unless ActiveRecord::Base.connection.column_exists?(:decidim_users, :following_users_count)

    # remove_column :decidim_users, :following_users_count
  end
end
