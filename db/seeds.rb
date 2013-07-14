# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:username => ENV['user1_login'], :password => ENV['user1_password'], :password_confirmation => ENV['user1_password'], :email => "mylosz@yahoo.pl", :name_surname => "Milosz Osinski", :born => "1990-02-24", :pesel => "90022413470", :role => "admin", :potwierdzenie => 1, :avatar => "https://secure.gravatar.com/avatar/6a3fa657913ece25faf01ff43e8420b7?s=420&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png")
