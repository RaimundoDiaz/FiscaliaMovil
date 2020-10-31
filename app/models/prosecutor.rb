class Prosecutor < ApplicationRecord
  has_many :procedures
  belongs_to :local_prosecution
end
