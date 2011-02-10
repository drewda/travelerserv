class Lab < ActiveRecord::Base
  has_many :experimenters
  has_many :log_entries
  has_many :devices
  has_many :studies
  has_many :questionnaires
end