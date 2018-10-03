# frozen_string_literal: true

# auto-generated Class -- don't lint
# rubocop:disable Rails/HasAndBelongsToMany, Style/HashSyntax
class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource,
             :polymorphic => true,
             :optional => true

  validates :name, presence: true, uniqueness: true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  def slug
    return nil if name.blank?

    name.parameterize.underscore.to_sym
  end
end
# rubocop:enable Rails/HasAndBelongsToMany, Style/HashSyntax
