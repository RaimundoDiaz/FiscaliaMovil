class PoliceUnit < ApplicationRecord
  belongs_to :police_station
  has_many :users
end
