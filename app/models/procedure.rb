class Procedure < ApplicationRecord
  belongs_to :police_in_charge, class_name: 'PoliceMan'
  belongs_to :local_prosecution_in_charge, class_name: 'LocalProsecution'
  belongs_to :police_unit_in_charge, class_name: 'PoliceUnit'
  belongs_to :prosecutor_in_charge, class_name: 'Prosecutor'
  has_many :person_in_procedures
  has_many :people, :through => :person_in_procedures
  has_many :crime_in_accuseds
  has_many :messages
  has_many :taggings
  has_many :tags, through: :taggings
end
