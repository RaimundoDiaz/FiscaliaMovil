class Prosecutor < ApplicationRecord
  validates :rut, uniqueness: true
  has_many :procedures
  belongs_to :local_prosecution
end
