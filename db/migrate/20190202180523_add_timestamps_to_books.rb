class AddTimestampsToBooks < ActiveRecord::Migration[5.2]
  def change
    change_table(:books) { |t| t.timestamps }
  end
end
