class Crime < ApplicationRecord
  has_many :crime_in_accuseds, :dependent => :destroy
  has_many :people, through: :crime_in_accuseds

end
