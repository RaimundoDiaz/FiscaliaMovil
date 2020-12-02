class PersonInProcedure < ApplicationRecord
  belongs_to :person
  belongs_to :procedure
  has_many :registry_in_accuseds
  #para el imputado
  enum state: {pending: 0, acd: 1, noticed: 2}
end
