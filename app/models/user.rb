class User < ApplicationRecord
  has_many :send_messages, class_name: 'Message', foreign_key: 'sender_user_id'
  has_many :receiver_messages, class_name: 'Message', foreign_key: 'receiver_user_id'
  has_many :procedures
  has_many :notifications
  has_one :local_prosecution
  has_one :police_unit
end
