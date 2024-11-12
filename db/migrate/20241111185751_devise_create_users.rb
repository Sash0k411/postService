# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      ## Devise fields
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      # Additional fields
      t.string :full_name
      t.integer :region_id
      t.integer :role, default: 0 # Default role is 'user'

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
