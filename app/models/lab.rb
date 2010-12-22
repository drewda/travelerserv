class Lab < ActiveRecord::Base
  has_many :experimenters
  has_many :log_entries
  has_many :devices
end