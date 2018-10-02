# frozen_string_literal: true

class EnableUuidExtension < ActiveRecord::Migration[5.1]
  def change
    enable_extension "pgcrypto"
  end
end
