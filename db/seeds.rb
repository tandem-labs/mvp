# frozen_string_literal: true

# rubocop:disable Rails/Output

def create_default_roles
  %w[superadmin user].each do |name|
    Role.find_or_create_by(name: name)
  end
end

def create_dev_seeds
  puts "Creating Development Seed Data"
  create_default_roles
end

def create_production_seeds
  puts "Creating Production Seed Data"
  create_default_roles
end

create_dev_seeds if Rails.env.development?
create_production_seeds if Rails.env.production?

# rubocop:enable Rails/Output
