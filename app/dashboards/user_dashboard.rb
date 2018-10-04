# frozen_string_literal: true

require "administrate/base_dashboard"

# rubocop:disable Style/SymbolArray
class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    confirmation_sent_at: Field::DateTime,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    created_at: Field::DateTime,
    current_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String.with_options(searchable: false),
    deleted_at: Field::DateTime,
    email: Field::String,
    encrypted_password: Field::String,
    failed_attempts: Field::Number,
    first_name: Field::String,
    id: Field::String,
    invitation_accepted_at: Field::DateTime,
    invitation_sent_at: Field::DateTime,
    last_name: Field::String,
    last_sign_in_at: Field::DateTime,
    last_sign_in_ip: Field::String.with_options(searchable: false),
    locked_at: Field::DateTime,
    password_confirmation: Field::Password,
    password: Field::Password,
    remember_created_at: Field::DateTime,
    reset_password_sent_at: Field::DateTime,
    reset_password_token: Field::String,
    roles: Field::HasMany,
    sign_in_count: Field::Number,
    unconfirmed_email: Field::String,
    unlock_token: Field::String,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :email,
    :first_name,
    :last_name,
    :created_at,
    :updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :email,
    :first_name,
    :last_name,
    :sign_in_count,
    :last_sign_in_at,
    :confirmed_at,
    :confirmation_sent_at,
    :invitation_sent_at,
    :invitation_accepted_at,
    :unconfirmed_email,
    :failed_attempts,
    :locked_at,
    :created_at,
    :updated_at,
    :deleted_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :email,
    :roles
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  def display_resource(user)
    user.email
  end
end
# rubocop:enable Style/SymbolArray
