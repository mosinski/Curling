class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :tytul
      t.text :tekst_pl
      t.text :tekst_en
      t.date :termin

      t.timestamps
    end
  end
end
