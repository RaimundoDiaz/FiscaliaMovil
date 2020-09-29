class User < ApplicationRecord
  has_many :send_messages, class_name: 'Message', foreign_key: 'sender_user_id'
  has_many :receiver_messages, class_name: 'Message', foreign_key: 'receiver_user_id'
  has_many :procedures
  has_many :notifications
  belongs_to :local_prosecution, optional: true
  belongs_to :police_unit, optional: true
end
