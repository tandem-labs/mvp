# frozen_string_literal: true

def accept_invitation(
  first_name:,
  last_name:,
  password_confirmation:,
  password:,
  user:
)
  visit accept_user_invitation_url(
    user,
    invitation_token: user.raw_invitation_token
  )

  fill_in "First Name", with: first_name
  fill_in "Last Name", with: last_name
  fill_in "Password", with: password
  fill_in "Confirm Password", with: password_confirmation
  click_button "Sign Up"
end

def login(email: nil, password: nil)
  visit "/login"
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_on "Log in"
end

def logout
  click_on "Logout"
end

def reset_password(email: nil)
  visit new_user_password_path
  fill_in "Email", with: email
  click_button "Send Reset Password Email"
end

def sign_up(
  email:,
  first_name:,
  last_name:,
  password_confirmation:,
  password:
)
  visit new_user_registration_path
  fill_in "First Name", with: first_name
  fill_in "Last Name", with: last_name
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Confirm Password", with: password_confirmation
  click_button "Sign Up"
end
