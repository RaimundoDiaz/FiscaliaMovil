class PhotoInProcedure < ApplicationRecord
  belongs_to :procedure
  has_one :photo
end
