class Crime < ApplicationRecord
  has_many :crime_in_accuseds, :dependent => :destroy
  has_many :people, through: :crime_in_accuseds

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete
    update(deleted: true)
  end

end
