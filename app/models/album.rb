class Album < ActiveRecord::Base
  attr_accessible :przydzial, :przydzial_id, :tytul, :termin
  
  validates :tytul, length: { minimum: 5 }, allow_blank: false, :uniqueness => true
end
