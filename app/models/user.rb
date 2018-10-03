# frozen_string_literal: true

class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  acts_as_paranoid

  after_create :assign_default_role

  devise \
    :confirmable,
    :database_authenticatable,
    :invitable,
    :lockable,
    :recoverable,
    :registerable,
    :rememberable,
    :trackable,
    :validatable

  rolify

  validates :email, presence: true, uniqueness: true
  validates :email, email: true, unless: proc { |u| u.email.blank? }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password,
            presence: true,
            unless: proc { |u| u.encrypted_password.present? }
  validates :password,
            length: { in: 6..24 },
            unless: proc { |u| u.password.blank? }
  validates :password_confirmation,
            presence: true,
            unless: proc { |u| u.password.blank? }

  def name
    [first_name, last_name].compact.join(" ")
  end

  def role
    roles.blank? ? nil : roles.last.name
  end

  def role=(role_name)
    new_role = Role.find_by(name: role_name)

    new_role ? self.roles = [new_role] : nil
  end

  def superadmin?
    has_role?(:superadmin)
  end

  private

  def assign_default_role
    add_role(:user) if roles.blank?
  end
end
