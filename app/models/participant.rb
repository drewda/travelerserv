class Participant < ActiveRecord::Base
  has_many :devices
  
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable
end