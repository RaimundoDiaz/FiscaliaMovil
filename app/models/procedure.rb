class Procedure < ApplicationRecord
  belongs_to :police_in_charge, class_name: 'User'
  has_many :person_in_procedures
  has_many :people, :through => :person_in_procedures
  has_many :crime_in_accuseds
  belongs_to :local_prosecution
end
