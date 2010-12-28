class Participant < ActiveRecord::Base
  has_many :devices
  has_many :travel_fixes
  
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  attr_protected :encrypted_password, :password_salt
end