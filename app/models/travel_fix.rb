class TravelFix < ActiveRecord::Base
  belongs_to :device
  belongs_to :participant
  has_many :starts_trips, :class_name => "Trip", :foreign_key => "start_travel_fix_id"
  has_many :ends_trips, :class_name => "Trip", :foreign_key => "end_travel_fix_id"
end
