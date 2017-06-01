class Parconfig < ApplicationRecord
  validates :user_email, :json_parset, :learner_name, presence: true
  validates :json_parset, :uniqueness => { :scope => :json_parvals }

  def anon_email
    user_email.gsub(/(?<=@)[\w-]*/, '*')
  end

  def pretty_parset
    JSON.pretty_generate(JSON.parse(json_parset))
  end

  def parset
    parset = JSON.parse(json_parset)
    return parset
  end

  def pretty_parvals
    JSON.pretty_generate(JSON.parse(json_parvals))
  end

  def default_parvals
    {"tunable" => true, "allow.inf" => true, "len" => 1}
  end
end
