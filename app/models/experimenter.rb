class Experimenter < ActiveRecord::Base
  belongs_to :lab
  has_many :log_entries
  
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end