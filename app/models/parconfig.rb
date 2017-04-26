class Parconfig < ApplicationRecord
  self.unique_keys = :json_parconfig, :json_parvals
  validates :user_email, :json_parconfig, :learner_name, presence: true
  validates :json_parconfig, :uniqueness => { :scope => :json_parvals }
end
