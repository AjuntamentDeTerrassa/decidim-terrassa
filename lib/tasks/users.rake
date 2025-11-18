# frozen_string_literal: true

namespace :populate_tasks do
  namespace :users do
    desc "Block and remove users without authorizations from a CSV"
    task :block_and_remove_unauthorized_users_from_csv, [:csv_path, :admin_id] => [:environment] do |_t, args|
      raise "Please, provide a file path" if args[:csv_path].blank?
      raise "Please, provide an admin id" if args[:admin_id].blank?

      puts "Blocking and deleting users, please wait..."
      admin = Decidim::User.find_by(admin: true, id: args[:admin_id])
      organization = admin.organization
      importer = UsersBlocker.new(args[:csv_path], organization, args[:admin_id])
      importer.block_users
      puts "Users blocked and deleted."
    end
  end
end
