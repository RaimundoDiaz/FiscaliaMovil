class Message < ApplicationRecord
  belongs_to :sender_user, class_name: 'User'
  belongs_to :receiver_user, class_name: 'User'
end
