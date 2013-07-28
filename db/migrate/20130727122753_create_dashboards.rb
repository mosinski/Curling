class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.string :tytul
      t.text :tekst

      t.timestamps
    end
  end
end
