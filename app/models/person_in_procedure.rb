class PersonInProcedure < ApplicationRecord
  belongs_to :person
  belongs_to :procedure
  #para el imputado
  enum state: {pending: 0, acd: 1, noticed: 2}
end
