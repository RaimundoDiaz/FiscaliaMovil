class Person < ApplicationRecord
  has_many :procedures, through: :person_in_procedures
  has_many :alias_accuseds
  has_many :crime_in_accuseds
  has_many :crimes, through: :crime_in_accuseds
  has_many :person_in_procedures
  has_many :procedures, :through => :person_in_procedures
  validates :rut, presence: true
end
