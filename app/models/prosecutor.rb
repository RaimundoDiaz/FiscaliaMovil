class Prosecutor < ApplicationRecord
  after_create :create_user
  validates :rut, uniqueness: true
  has_many :procedures
  has_one :user
  belongs_to :local_prosecution
  has_many :registry_in_accuseds

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete
    update(deleted: true)
  end

  def create_user
    #Email
    @name = self.name.downcase.gsub(/[^a-z]/, ' ').split(" ")
    if (@name.length>1)
      @name[0] = @name[0][0]
      @email = @name.join("")+"@fiscalia.com"

      #Search if email is duplicate
      @count = User.where("email LIKE ? AND admin = False", "%"+@name.join("")+"%").count

      if(@count>0)
        @name[1]+=(@count+1).to_s
        @email = @name.join("")+"@fiscalia.com"
      end
    else
      @email = @name.join("")+"@fiscalia.com"
    end

    #Password
    @password = 123456789

    User.create(prosecutor: self, email: @email, password: "123456789")
  end
end
