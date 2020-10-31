class Tag < ApplicationRecord
  has_many :taggings
  has_many :procedures, through: :taggings
end
