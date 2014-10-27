case Rails.env

when "development"
puts "********Seeduje Dane na localhost************"
User.create(:username => "localAdministrator", :password => "password", :password_confirmation => "password", :email => "hansskowron@interia.pl", :name_surname => "Henryk Skowronski", :born => "1990-02-24", :pesel => "11062113570", :role => "admin", :potwierdzenie => 1)

User.create(:username => "Gosc", :password => "password", :password_confirmation => "password", :email => "gosc@asd.pl", :name_surname => "Gosc Niezalogowany", :born => "1900-01-01", :pesel => "11111111111", :role => "gosc", :potwierdzenie => 0)

when "production"
puts "********Seeduje Dane na heroku************"
User.create(:username => ENV['user1_login'], :password => ENV['user1_password'], :password_confirmation => ENV['user1_password'], :email => "mylosz@yahoo.pl", :name_surname => "Milosz Osinski", :born => "1990-02-24", :pesel => "90022413470", :role => "admin", :potwierdzenie => 1, :avatar => "https://secure.gravatar.com/avatar/6a3fa657913ece25faf01ff43e8420b7?s=420&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png")

User.create(:username => ENV['user2_login'], :password => ENV['user2_password'], :password_confirmation => ENV['user2_password'], :email => "hansskowron@interia.pl", :name_surname => "Henryk Skowronski", :born => "1990-02-24", :pesel => "11062113570", :role => "admin", :potwierdzenie => 1)

User.create(:username => ENV['user3_login'], :password => ENV['user3_password'], :password_confirmation => ENV['user3_password'], :email => "gosc@asd.pl", :name_surname => "Gosc Niezalogowany", :born => "1900-01-01", :pesel => "11111111111", :role => "gosc", :potwierdzenie => 0)
end
