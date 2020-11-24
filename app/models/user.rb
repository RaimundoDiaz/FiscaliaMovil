class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :messages
  has_many :procedures
  has_many :notifications
  belongs_to :local_prosecution, optional: true
  belongs_to :prosecutor, optional: true
  belongs_to :police_unit, optional: true

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete
    update(deleted: true)
  end

  def active_for_authentication?
    super and !self.deleted?
  end

  def inactive_message
    "Tu cuenta ha sido borrada"
  end



end

