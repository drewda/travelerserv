class Participant < ActiveRecord::Base
  has_many :devices
  has_many :travel_fixes
  
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  attr_protected :encrypted_password, :password_salt
  
  def full_name
    "#{first_name} #{last_name}"
  end
end