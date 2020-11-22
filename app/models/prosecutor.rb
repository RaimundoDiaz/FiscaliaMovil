class Prosecutor < ApplicationRecord
  after_create :create_user
  validates :rut, uniqueness: true
  has_many :procedures
  has_one :user
  belongs_to :local_prosecution

  def create_user
    #Email
    @name = self.name.downcase.gsub!(/[^A-Za-z]/, ' ').split(" ")
    @name[0] = @name[0][0]
    @email = @name.join("")+"@fiscalia.com"

    #Search if email is duplicate
    @count = User.where("email LIKE ?", "%"+@name.join("")+"%").count

    if(@count>0)
      @name[1]+=(@count+1).to_s
      @email = @name.join("")+"@fiscalia.com"
    end

    #Password
    @password = 123456789

    User.create(prosecutor: self, email: @email, password: "123456789")
  end
end
