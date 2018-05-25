Rails.application.routes.draw do
  devise_for :authors, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :author do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_login_session
  end

  resources :articles do
    resources :comments
  end

  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
