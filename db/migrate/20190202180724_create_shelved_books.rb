class CreateShelvedBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :shelved_books do |t|
      t.references :shelf
      t.references :book
      t.timestamps
    end
  end
end
