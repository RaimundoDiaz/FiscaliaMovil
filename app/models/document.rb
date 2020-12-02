class Document < ApplicationRecord
  belongs_to :procedure
  has_one_attached :document

  validates :document,file_size: { less_than_or_equal_to: 50.megabytes},
            file_content_type: { allow: [ 'application/pdf', 'text/plain'] }
end
