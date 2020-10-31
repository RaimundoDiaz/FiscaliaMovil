class LocalProsecution < ApplicationRecord
  belongs_to :regional_prosecution
  has_many :users
  has_many :procedures
  has_many :prosecutors
end
