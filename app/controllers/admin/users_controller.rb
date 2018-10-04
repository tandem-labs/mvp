# frozen_string_literal: true

module Admin
  class UsersController < Admin::ApplicationController
    def create
      User.invite!(user_params)
      flash[:success] = "Successfully invited user"
      redirect_to admin_users_path
    end

    private

    def user_params
      params
        .require(:user)
        .permit(
          :email,
          role_ids: []
        )
    end
  end
end
