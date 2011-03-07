class AddTravelLogRate < ActiveRecord::Migration
  def self.up
    add_column :devices, :travel_log_rate, :int
    add_column :devices, :travel_log_adapt_rate, :boolean
    add_column :labs, :default_travel_log_rate, :int
    add_column :labs, :default_travel_log_adapt_rate, :boolean
  end

  def self.down
    remove_column :labs, :default_travel_log_adapt_rate
    remove_column :labs, :default_travel_log_rate
    remove_column :devices, :travel_log_adapt_rate
    remove_column :devices, :travel_log_rate
  end
end