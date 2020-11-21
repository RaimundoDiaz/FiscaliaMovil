class Prosecutor < ApplicationRecord
  validates :rut, uniqueness: true
  has_many :procedures
  has_one :user
  belongs_to :local_prosecution
end
