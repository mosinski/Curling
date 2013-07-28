class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.text :tekst

      t.timestamps
    end
  end
end
