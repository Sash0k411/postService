class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :status
      t.integer :region_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
