class PersonInProcedure < ApplicationRecord
  belongs_to :person
  belongs_to :procedure
  belongs_to :prosecutor_pronounced, class_name: 'Prosecutor'
  #para el imputado
  enum state: {pending: 0, acd: 1, noticed: 2}
end
