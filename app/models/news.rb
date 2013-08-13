class News < ActiveRecord::Base
  acts_as_commentable
  attr_accessible :tekst_en, :tekst_pl, :termin, :tytul

  validates :tytul, length: { minimum: 5 }, allow_blank: false, :uniqueness => true
  validates :tekst_pl, length: { minimum: 15 }, allow_blank: false
  validates :tekst_en, length: { minimum: 15 }, allow_blank: false
end
