class Parconfig < ApplicationRecord
  validates :user_email, :json_parconfig, :learner_name, presence: true
  validates :json_parconfig, :uniqueness => { :scope => :json_parvals }
end
