class CreateShelves < ActiveRecord::Migration[5.2]
  def change
    create_table :shelves do |t|
      t.string :title, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
