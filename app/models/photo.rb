class Photo < ApplicationRecord
  belongs_to :procedure
  has_one_attached :photo

  validates :photo, file_size: { less_than_or_equal_to: 50.megabytes },
            file_content_type: { allow: ['image/jpeg', 'image/png', 'image/jpg', 'image/bmp'] }

end
