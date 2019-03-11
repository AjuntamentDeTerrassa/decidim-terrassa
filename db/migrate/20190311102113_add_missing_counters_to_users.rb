class AddMissingCountersToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :decidim_users, :following_users_count, :integer, null: false, default: 0
  end

  def down
    remove_column :decidim_users, :following_users_count
  end
end
