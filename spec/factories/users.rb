# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    transient do
      secure_pass { Faker::Internet.password }
    end

    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { secure_pass }
    password_confirmation { secure_pass }

    trait :superadmin do
      roles { [Role.find_or_create_by(name: "superadmin")] }
    end

    trait :user do
      # this is the default, but good to be able to be explicit
      roles { [Role.find_or_create_by(name: "user")] }
    end
  end
end
