# frozen_string_literal: true

class UserMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    UserMailer.confirmation_instructions(user, "INVALID_TOKEN")
  end

  def reset_password_instructions
    UserMailer.reset_password_instructions(user, "INVALID_TOKEN")
  end

  def unlock_instructions
    UserMailer.unlock_instructions(user, "INVALID_TOKEN")
  end

  private

  def user
    User.new(
      email: "hello@example.com",
      first_name: "Example",
      last_name: "User"
    )
  end
end
