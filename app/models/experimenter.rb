class Experimenter < ActiveRecord::Base
  belongs_to :lab
  
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable
end