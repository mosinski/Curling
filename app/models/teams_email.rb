class TeamsEmail < ActiveRecord::Base
  attr_accessible :email, :kraj, :nazwa, :osoba_kontaktowa
  
  validates :nazwa, length: { minimum: 2 }, allow_blank: false
  validates :kraj, length: { minimum: 2 }, allow_blank: false
  validates :osoba_kontaktowa, length: { minimum: 2 }, allow_blank: false
  validates :email, length: { minimum: 2 }, allow_blank: false
end
