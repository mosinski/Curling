class AddBornToUser < ActiveRecord::Migration
  def change
    add_column :users, :name_surname, :string
    add_column :users, :born, :date
    add_column :users, :pesel, :integer
    add_column :users, :role, :string, :default => "user"
    add_column :users, :potwierdzenie, :integer, :default => 0
    add_column :users, :avatar, :string, :default => "/avatar.jpg"
    add_column :users, :login_count, :integer, :null => false, :default => 0
    add_column :users, :failed_login_count, :integer, :null => false, :default => 0
    add_column :users, :last_request_at , :datetime
    add_column :users, :current_login_at , :datetime
    add_column :users, :last_login_at , :datetime
    add_column :users, :current_login_ip, :string
    add_column :users, :last_login_ip, :string

  end
end
