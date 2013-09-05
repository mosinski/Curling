class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :nazwa
      t.date :termin_start
      t.date :termin_end
      t.text :opis_pl
      t.text :opis_en

      t.timestamps
    end
  end
end
