# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :roles

      root to: "users#index"
    end
  devise_for \
    :users,
    controllers: {
      confirmations: "users/confirmations",
      invitations: "users/invitations",
      passwords: "users/passwords",
      registrations: "users/registrations",
      sessions: "users/sessions"
    },
    path: "",
    path_names: { sign_in: "login", sign_out: "logout", sign_up: "signup" }

  root to: "pages#home"
end
