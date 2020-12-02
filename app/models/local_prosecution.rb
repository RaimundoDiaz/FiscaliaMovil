class LocalProsecution < ApplicationRecord
  after_create :create_admin
  belongs_to :regional_prosecution
  has_many :procedures, class_name: 'Procedure', foreign_key: :prosecutor_in_charge_id, dependent: :destroy
  has_many :prosecutors
  has_one :user
  has_many :police_units

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete
    update(deleted: true)
  end

  def create_admin
    #Email
    @email = "fiscalia"+self.id.to_s+"@admin.com"

    #Password
    @password = 123456789

    User.create(local_prosecution: self, admin:true, email: @email, password: "123456789")
  end
end
