# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    private

    def update_resource_params
      params
        .require(:user)
        .permit(
          :first_name,
          :invitation_token,
          :last_name,
          :password,
          :password_confirmation
        )
    end
  end
end
