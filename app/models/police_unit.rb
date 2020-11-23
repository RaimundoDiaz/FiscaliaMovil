class PoliceUnit < ApplicationRecord
  after_create :create_user, :create_local_admin
  belongs_to :police_station
  has_many :users
  has_many :procedures

  def create_user
    #Email
    @email = "up"+self.id.to_s+"@up.com"

    #Password
    @password = 123456789

    User.create(police_unit: self, email: @email, password: "123456789")
  end

  def create_local_admin
    #Email
    @email = "up"+self.id.to_s+"@adminup.com"

    #Password
    @password = 123456789

    User.create(police_unit: self, admin: true, email: @email, password: "123456789")
  end
end
