class Procedure < ApplicationRecord
  belongs_to :user
  has_many :person_in_procedures
  has_many :people, :through => :person_in_procedures
  has_many :crime_in_accuseds
end
