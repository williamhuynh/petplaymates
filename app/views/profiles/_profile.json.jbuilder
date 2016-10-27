json.extract! profile, :id, :first_name, :last_name, :street, :suburb, :postcode, :state, :country, :phone, :photo, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)