class User < ActiveRecord::Base
    acts_as_authentic
    
    has_private_messages

  validates :pesel, length: { in: 11..11 }, allow_blank: false
  validates :name_surname, :format => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/, :message => 'ma niepoprawny format.' }, allow_blank: false
end
