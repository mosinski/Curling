class Medium < ActiveRecord::Base
  attr_accessible :tytul, :url
  
    validates :tytul, length: { maximum: 100 }, allow_blank: false
    validates :url, length: { maximum: 150 }, allow_blank: false
end
