class Operator < ApplicationRecord
  belongs_to :prosecutor

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete
    update(deleted: true)
  end
end
