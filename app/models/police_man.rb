class PoliceMan < ApplicationRecord
  validates :badge, uniqueness: true
  validates :rut, uniqueness: true
  has_many :procedures
end
