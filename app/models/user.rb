class User < ActiveRecord::Base
  acts_as_authentic
    
  has_private_messages

  validates :pesel, length: { in: 11..11 }, allow_blank: false, :uniqueness => true, :numericality => true
  validates :name_surname, :format => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/, :message => 'ma niepoprawny format.' }, allow_blank: false
  
  def self.search(search, page)
  paginate :per_page => 9, :page => page,
           :conditions => ['username like :q or name_surname like :q or email like :q', q: "%#{search}%"], :order => 'name_surname'
  end
end
