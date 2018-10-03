# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :hide_navbar

    def sign_up_params
      params
        .require(:user)
        .permit(
          :first_name,
          :last_name,
          :email,
          :password,
          :password_confirmation
        )
    end

    private

    def hide_navbar
      @show_navbar = false
    end
  end
end
