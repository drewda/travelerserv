class Experimenter < ActiveRecord::Base
  belongs_to :lab
  has_many :log_entries
  has_many :studies
  
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  # for rails_admin
  def title
    self.full_name
  end
end