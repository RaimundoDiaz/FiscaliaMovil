class Tag < ApplicationRecord
  has_many :taggings, :dependent => :destroy
  has_many :procedures, through: :taggings
end
