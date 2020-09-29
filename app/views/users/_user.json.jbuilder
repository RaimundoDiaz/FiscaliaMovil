json.extract! user, :id, :role, :rut, :birthday, :police_unit_id, :local_prosecution_id, :created_at, :updated_at
json.url user_url(user, format: :json)
