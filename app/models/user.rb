class User < ApplicationRecord
  has_many :send_messages, class_name: 'Message', foreign_key: 'sender_user_id'
  has_many :receiver_messages, class_name: 'Message', foreign_key: 'receiver_user_id'
  has_many :police_in_charge_procedures, class_name: 'Procedure', foreign_key: 'police_in_charge_id'
  has_many :prosecutor_in_charge_procedures, class_name: 'Procedure', foreign_key: 'prosecutor_in_charge_id'
  has_many :notifications
end
