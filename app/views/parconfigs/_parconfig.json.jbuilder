json.extract! parconfig, :id, :user_email, :json_parset, :json_parvals, :learner_class, :learner_type, :learner_name, :download_count, :upload_count, :default, :note, :created_at, :updated_at
json.url parconfig_url(parconfig, format: :json)
