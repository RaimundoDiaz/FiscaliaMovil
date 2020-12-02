class RegistryInAccused < ApplicationRecord
  belongs_to :prosecutor
  belongs_to :accused, class_name: 'PersonInProcedure'
end
