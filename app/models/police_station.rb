class PoliceStation < ApplicationRecord
  belongs_to :prefecture
  has_many :police_units
end
