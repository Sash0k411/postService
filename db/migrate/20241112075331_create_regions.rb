class CreateRegions < ActiveRecord::Migration[7.2]
  def change
    create_table :regions do |t|
      t.string :name
      t.integer :code

      t.timestamps
    end
  end
end