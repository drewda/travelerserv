class Traveler < ActiveRecord::Migration
  def self.up
    add_column :labs, :traveler_service, :boolean
    
    add_column :participants, :cell_number, :string
    
    create_table :devices do |t|
      t.integer :lab_id
      t.integer :participant_id, :null => true
      t.string :identification
      t.string :kind
      t.string :name
      t.string :phone_number
      t.timestamps
    end
    add_column :log_entries, :device_id, :integer
    add_index :devices, :lab_id
    add_index :devices, :participant_id
    
    create_table :travel_fixes do |t|
      t.integer :participant_id
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.decimal :altitude, :precision => 8, :scale => 2
      t.decimal :speed, :precision => 5, :scale => 2
      t.decimal :accuracy, :precision => 5, :scale => 2
      t.integer :device_id
      t.string :positioning_method
      t.datetime :datetime
      t.boolean :clean
      t.timestamps
    end
    add_index :travel_fixes, :participant_id
    add_index :travel_fixes, :device_id
    
    create_table :trips do |t|
      t.integer :participant_id
      t.integer :start_travel_fix_id
      t.integer :end_travel_fix_id
      t.string :travel_mode
      t.string :travel_mode_specified_by
      t.timestamps
    end
    add_index :trips, :participant_id
    add_index :trips, :start_travel_fix_id
    add_index :trips, :end_travel_fix_id
    
    create_table :activities do |t|
      t.integer :participant_id
      t.datetime :start
      t.datetime :stop
    end
    add_index :activities, :participant_id
    add_column :questionnaire_records, :activity_id, :integer
    add_column :questionnaire_records, :trip_id, :integer
    
    add_column :studies, :start_trip_questionnaire_id, :integer
    add_column :studies, :end_trip_questionnaire_id, :integer
    add_column :studies, :start_activity_questionnaire_id, :integer
    add_column :studies, :end_activity_questionnaire_id, :integer
    add_index :studies, :start_trip_questionnaire_id
    add_index :studies, :end_trip_questionnaire_id
    add_index :studies, :start_activity_questionnaire_id
    add_index :studies, :end_activity_questionnaire_id
    
    # create_table :activities_trips, :id => false do |t|
    #   t.references :activity, :trip
    # end
    
  end

  def self.down
    remove_column :participants, :cell_number
    remove_column :studies, :end_activity_questionnaire_id
    remove_column :studies, :start_activity_questionnaire_id
    remove_column :studies, :end_trip_questionnaire_id
    remove_column :studies, :start_trip_questionnaire_id
    remove_index :studies, :start_trip_questionnaire_id
    remove_index :studies, :end_trip_questionnaire_id
    remove_index :studies, :start_activity_questionnaire_id
    remove_index :studies, :end_activity_questionnaire_id
    
    remove_column :questionnaire_records, :trip_id
    remove_column :questionnaire_records, :activity_id
    remove_column :labs, :traveler_service, :boolean
    
    drop_table :devices
    remove_column :log_entries, :device_id, :integer
    
    drop_table :travel_fixes
    
    drop_table :trips
  end
end