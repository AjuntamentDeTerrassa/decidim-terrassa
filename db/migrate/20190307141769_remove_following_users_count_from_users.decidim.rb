# frozen_string_literal: true
# This migration comes from decidim (originally 20181204110723)

class RemoveFollowingUsersCountFromUsers < ActiveRecord::Migration[5.2]
  # This migration has wrong order and is executed before 20190311102113_add_missing_counters_to_users.rb
  def up
    return unless ActiveRecord::Base.connection.column_exists?(:decidim_users, :following_users_count)

    remove_column :decidim_users, :following_users_count
  end

  def down
    return if ActiveRecord::Base.connection.column_exists?(:decidim_users, :following_users_count)

    add_column :decidim_users, :following_users_count, :integer, null: false, default: 0

    Decidim::UserBaseEntity.find_each do |entity|
      following_users_count = Decidim::Follow.where(decidim_user_id: entity.id, decidim_followable_type: ["Decidim::UserBaseEntity", "Decidim::User", "Decidim::UserGroup"]).count
      entity.following_users_count = following_users_count
      entity.save
    end
  end
end
