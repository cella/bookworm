class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null:false
      t.string :author, null: false
      t.integer :release_year, null: false
      t.text :description, null: false
      t.integer :page_count, null: false
    end
  end
end
