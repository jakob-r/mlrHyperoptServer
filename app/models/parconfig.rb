class Parconfig < ApplicationRecord
  validates :user_email, :json_parconfig, :learner_name, presence: true
  validates :json_parconfig, :uniqueness => { :scope => :json_parvals }
  
  def anon_email
    self.user_email[/.*@.{1}/] + "..."
  end

  def pretty_parconfig
    JSON.pretty_generate(JSON.parse(self.json_parconfig))
  end

  def pretty_parvals
    JSON.pretty_generate(JSON.parse(self.json_parvals))
  end

end
