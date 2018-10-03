# frozen_string_literal: true

class UserMailer < Devise::Mailer
  layout "mailer"
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: "devise/mailer"
end
