class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :tytul
      t.string :przydzial
      t.integer :przydzial_id
      t.date :termin

      t.timestamps
    end
  end
end
