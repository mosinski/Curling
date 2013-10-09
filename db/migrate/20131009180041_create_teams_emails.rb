class CreateTeamsEmails < ActiveRecord::Migration
  def change
    create_table :teams_emails do |t|
      t.string :nazwa
      t.string :email
      t.string :osoba_kontaktowa
      t.string :kraj

      t.timestamps
    end
  end
end
