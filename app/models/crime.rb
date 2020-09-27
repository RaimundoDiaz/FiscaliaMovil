class Crime < ApplicationRecord
  has_many :person_in_procedures
  has_many :people, through: :person_in_procedures
end
