class LocalProsecution < ApplicationRecord
  belongs_to :regional_prosecution
  has_many :users
  has_many :procedures, class_name: 'Procedure', foreign_key: :prosecutor_in_charge_id, dependent: :destroy
  has_many :prosecutors
end
