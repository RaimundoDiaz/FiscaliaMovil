class PoliceStation < ApplicationRecord
  belongs_to :prefecture
  has_many :police_units

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete
    update(deleted: true)
  end
end
