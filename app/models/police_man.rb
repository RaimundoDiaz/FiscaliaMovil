class PoliceMan < ApplicationRecord
  has_many :procedures
  belongs_to :police_unit
end
