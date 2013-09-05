class Tournament < ActiveRecord::Base
  attr_accessible :nazwa, :opis_pl, :opis_en, :termin_end, :termin_start
  
  
  validates :nazwa, length: { minimum: 10 }, allow_blank: false
  validates :opis_pl, length: { minimum: 25 }, allow_blank: false
end
