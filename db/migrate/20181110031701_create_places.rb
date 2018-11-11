class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.text :name
      t.text :address
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :places, [:user_id, :created_at]
  end
end
