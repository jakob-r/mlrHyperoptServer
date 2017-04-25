json.extract! parconfig, :id, :user_email, :date, :json_parconfig, :json_parvals, :learner_class, :learner_type, :learner_name, :download_count, :upload_count, :default, :note
json.url parconfig_url(parconfig, format: :json)
