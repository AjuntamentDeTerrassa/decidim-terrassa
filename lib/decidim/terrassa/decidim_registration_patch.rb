Decidim::Devise::SessionsController.class_eval do
  def after_sign_in_path_for(user)
    super
  end
end
