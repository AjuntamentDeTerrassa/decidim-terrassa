# frozen_string_literal: true

require "csv"

class UsersBlocker
  attr_reader :organization, :admin

  DELETE_REASON = "Automatic block"

  def initialize(path, organization, admin_id)
    @file = if path.is_a?(String)
              CSV.read(path, col_sep: ",", headers: true)
            elsif path.is_a?(ActiveRecord::Relation)
              path.map { |user| { "email" => user.email } }
            end
    @rows_count = @file.count
    @organization = organization
    @admin = organization.users.where(admin: true).find(admin_id)
  end

  def block_users
    @file.each_with_index do |row, i|
      print_step(i)

      if row["email"].blank?
        puts "- User with blank email skipped"
        next
      end

      user = Decidim::User.find_by(email: row["email"])
      if user.nil?
        puts "- User #{row["email"]} not found"
        next
      end

      if Decidim::Authorization.exists?(decidim_user_id: user.id)
        puts "- User #{row["email"]} with verifications skipped"
        next
      end

      if user.admin?
        puts "- User #{row["email"]} with admin role skipped"
        next
      end

      user.update_columns(
        newsletter_notifications_at: nil,
        notification_types: "none",
        direct_message_types: "followed-only",
        email_on_moderations: nil,
        notification_settings: {},
        notifications_sending_frequency: "none"
      )

      form = Decidim::Admin::BlockUserForm.from_model(user).with_context(current_organization: organization, current_user: admin)
      form.justification = DELETE_REASON

      Decidim::Admin::BlockUserWithoutNotification.call(form) do
        on(:ok) do
          puts "- Block performed"
        end

        on(:invalid) do
          puts "- There was an error trying to block user with email #{row["email"]}"
        end
      end

      delete_form = Decidim::DeleteAccountForm.new(delete_reason: DELETE_REASON)

      Decidim::DestroyAccount.call(user, delete_form) do
        on(:ok) do
          puts "- Deletion performed"
        end

        on(:invalid) do
          puts "- There was an error trying to delete user with email #{row["email"]}"
        end
      end
    end
  end

  def print_step(index)
    puts "\n\n\n"
    puts "========================================================================================="
    puts "========================================================================================="
    puts "#{@rows_count} / #{index + 1}"
    puts "========================================================================================="
    puts "========================================================================================="
    puts "\n\n\n"
  end
end
