class Activity < ActiveRecord:Base
  has_many :trips
  belongs_to :participant
end