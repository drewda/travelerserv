class Participant < ActiveRecord::Base
  has_many :devices
  
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end