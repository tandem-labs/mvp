# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    def create
      super
    end

    protected

    def successfully_sent?(_resource)
      true
    end

    def after_sending_reset_password_instructions_path_for(_resource_name)
      set_flash_message :notice, :send_instructions
      new_user_session_path
    end
  end
end
