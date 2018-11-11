class AddPictureToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :picture, :string
  end
end
