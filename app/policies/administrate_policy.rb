# frozen_string_literal: true

class AdministratePolicy
  attr_reader :record, :user

  def initialize(user, record)
    @record = record
    @user = user
  end

  def administrate?
    user&.superadmin?
  end
end
