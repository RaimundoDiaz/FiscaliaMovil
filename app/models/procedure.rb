class Procedure < ApplicationRecord
  belongs_to :police_in_charge, class_name: 'PoliceMan'
  belongs_to :local_prosecution_in_charge, class_name: 'LocalProsecution'

  belongs_to :police_unit_in_charge, class_name: 'PoliceUnit'
  belongs_to :prosecutor_in_charge, class_name: 'Prosecutor'
  has_many :person_in_procedures
  has_many :people, :through => :person_in_procedures
  has_many :crime_in_accuseds
  has_many :crimes, :through => :crime_in_accuseds
  has_many :messages
  belongs_to :creator, class_name: 'User'
  has_many_attached :videos
  has_many_attached :photos
  has_many_attached :documents

  validate :past_date
  validate :empty_address
  validates :videos, blob: { content_type: :video, max_size: 1.gigabytes}
  validates :photos, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/bmp'], max_size: 10.megabytes }
  validates :documents, blob: { content_type: ['application/pdf', 'application/doc', 'application/docx', 'application/ppt',
                                               'application/pptx', 'application/ps', 'application/rtf', 'application/txt',
                                               'application/xls', 'application/xlsx'], max_size: 10.megabytes }


  enum state: {open: 0, close: 1, draft: 2}
  enum classification: {flagrancy: 0, pending_arrest_warrant: 1, both: 2}

  def state
    super.to_s.humanize
  end

  def classification
    super.to_s.humanize
  end

  def created_at_str
    I18n.locale = :es
    I18n.l(self.created_at, format: '%A, %d de %B de %Y a las %H:%M')
  end

  def date_str
    I18n.locale = :es
    I18n.l(self.date_of_arrest, format: '%A, %d de %B de %Y a las %H:%M')
  end

  def past_date
    if date_of_arrest > Date.today
      errors.add(:date_of_arrest, "la fecha no puede ser en el futuro")
    end
  end

  def empty_address
    if address.match(/^$/)
      errors.add(:address, "la direccion no puede ser vacia")
    end
  end

  has_many :taggings
  has_many :tags, through: :taggings
end
