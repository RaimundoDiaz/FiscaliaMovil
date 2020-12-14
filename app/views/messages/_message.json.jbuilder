json.extract! message, :id, :sender_user_id, :receiver_user_id, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
