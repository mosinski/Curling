class News < ActiveRecord::Base
  acts_as_commentable
  attr_accessible :tekst_en, :tekst_pl, :termin, :tytul

  validates :tytul, length: { minimum: 5 }, allow_blank: false, :uniqueness => true
  validates :tekst_pl, length: { minimum: 15 }, allow_blank: false
  
  def self.search(search, page)
  paginate :per_page => 10, :page => page,
           :conditions => ['tytul like :q or tekst_pl like :q or tekst_en like :q', q: "%#{search}%"], :order => 'termin'
  end
end
