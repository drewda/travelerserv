class Experimenter < ActiveRecord::Base
  belongs_to :lab
  
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end