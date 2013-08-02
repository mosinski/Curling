class Dashboard < ActiveRecord::Base
  acts_as_commentable
  attr_accessible :tytul, :tekst
end
