class PoliceMan < ApplicationRecord
  validates :badge, uniqueness: true
  validates :rut, uniqueness: true
  has_many :procedures

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete
    update(deleted: true)
  end
end
