class Tag < ApplicationRecord
  has_many :taggings, :dependent => :destroy
  has_many :procedures, through: :taggings

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete
    update(deleted: true)
  end
end
