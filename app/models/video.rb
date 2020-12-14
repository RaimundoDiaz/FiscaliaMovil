class Video < ApplicationRecord
  belongs_to :procedure

  has_one_attached :video
  validates :video, file_size: { less_than_or_equal_to: 1.gigabytes },
            file_content_type: { allow: ['video/mp4']}
end
