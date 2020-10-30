class User < ApplicationRecord
  has_many :messages
  has_many :procedures
  has_many :notifications
  belongs_to :local_prosecution, optional: true
  belongs_to :police_unit, optional: true
end

