class RegionalProsecution < ApplicationRecord
  has_many :local_prosecutions

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete
    update(deleted: true)
  end
end
