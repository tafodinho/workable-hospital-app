json.extract! patient, :id, :name, :dob, :phone_number, :email, :address, :created_at, :updated_at
json.url patient_url(patient, format: :json)
