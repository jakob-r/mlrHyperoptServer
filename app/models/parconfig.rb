class Parconfig < ApplicationRecord
  validates :user_email, :json_parconfig, :learner_name, presence: true
  validates :json_parconfig, :uniqueness => { :scope => :json_parvals }

  def anon_email
    user_email.gsub(/(?<=@)\w*/, '*')
  end

  def pretty_parconfig
    JSON.pretty_generate(JSON.parse(json_parconfig))
  end

  def parset
    parset = JSON.parse(json_parconfig)
    # Filter out defaults
    defaults = {"tunable" => true, "allow.inf" => true, "len" => 1}
    #...
    return parset
  end

  def pretty_parvals
    JSON.pretty_generate(JSON.parse(json_parvals))
  end

  def default_parvals
    {"tunable" => true, "allow.inf" => true, "len" => 1}
  end
end
