class Dashboard < ActiveRecord::Base
  acts_as_commentable
  attr_accessible :tytul, :tekst

  validates :tytul, length: { minimum: 5 }, allow_blank: false, :uniqueness => true
  validates :tekst, length: { minimum: 15 }, allow_blank: false
  
  def self.search(search, page)
  paginate :per_page => 10, :page => page,
           :conditions => ['tytul like :q or tekst like :q', q: "%#{search}%"], :order => 'created_at'
  end
end
