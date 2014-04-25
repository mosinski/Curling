class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  has_private_messages

  validates :pesel, length: { in: 11..11 }, allow_blank: false, :uniqueness => true, :numericality => true
  validates :name_surname, :format => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/, :message => 'ma niepoprawny format.' }, allow_blank: false
  
  def self.search(search, page)
  paginate :per_page => 9, :page => page,
           :conditions => ['username LIKE :q or name_surname LIKE :q or email LIKE :q', q: "%#{search}%"], :order => 'name_surname'
  end
end
