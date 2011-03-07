class AddTravelLogRate < ActiveRecord::Migration
  def self.up
    add_column :devices, :travel_log_rate, :int
    add_column :devices, :travel_log_adapt_rate, :boolean
    marcc
  end

  def self.down
    remove_column :devices, :travel_log_adapt_rate
    remove_column :devices, :travel_log_rate
  end
end