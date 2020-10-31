class PoliceUnit < ApplicationRecord
  belongs_to :police_station
  has_many :police_men
  has_many :users
  has_many :procedures
end
