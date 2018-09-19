require "sidekiq/web"
Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount Decidim::Core::Engine => '/'
  mount Decidim::FileAuthorizationHandler::AdminEngine => '/admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
