# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    trait :superadmin do
      name { "superadmin" }
    end

    trait :user do
      name { "user" }
    end
  end
end
