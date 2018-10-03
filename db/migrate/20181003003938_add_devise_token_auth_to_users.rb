# frozen_string_literal: true

class AddDeviseTokenAuthToUsers < ActiveRecord::Migration[5.1]
  def up
    change_table :users, bulk: true do |t|
      t.string :provider, null: false, default: "email"
      t.string :uid, null: false, default: ""
      t.json :tokens
    end

    # rubocop:disable Rails/SkipsModelValidations
    User.update_all("uid = email")
    # rubocop:enable Rails/SkipsModelValidations

    add_index :users, %i[uid provider], unique: true
  end

  def down
    remove_index :users, %i[uid provider]

    change_table :users, bulk: true do |t|
      t.remove :provider
      t.remove :uid
      t.remove :tokens
    end
  end
end
