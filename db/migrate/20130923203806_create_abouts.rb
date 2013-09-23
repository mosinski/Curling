class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.text :tekst_pl
      t.text :tekst_en

      t.timestamps
    end
  end
end
