class Device < ActiveRecord::Base
  belongs_to :lab
  belongs_to :participant
  
  validates :identification, :uniqueness => true
end