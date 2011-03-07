# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 6) do

  create_table "activities", :force => true do |t|
    t.integer  "participant_id"
    t.datetime "start"
    t.datetime "stop"
  end

  add_index "activities", ["participant_id"], :name => "index_activities_on_participant_id"

  create_table "activties_trips", :id => false, :force => true do |t|
    t.integer "activity_id"
    t.integer "trip_id"
  end

  create_table "administrators", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                               :default => "", :null => false
    t.boolean  "active"
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token",     :limit => 20
    t.datetime "invitation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", :force => true do |t|
    t.integer  "lab_id"
    t.integer  "participant_id"
    t.string   "identification"
    t.string   "kind"
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["lab_id"], :name => "index_devices_on_lab_id"
  add_index "devices", ["participant_id"], :name => "index_devices_on_participant_id"

  create_table "experimenters", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                               :default => "", :null => false
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "web_site"
    t.integer  "lab_id"
    t.boolean  "manager"
    t.boolean  "active"
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token",     :limit => 20
    t.datetime "invitation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experimenters", ["invitation_token"], :name => "index_experimenters_on_invitation_token"

  create_table "histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "image_files", :force => true do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_files_questionnaires", :id => false, :force => true do |t|
    t.integer "image_file_id"
    t.integer "questionnaire_id"
  end

  add_index "image_files_questionnaires", ["image_file_id"], :name => "index_image_files_questionnaires_on_image_file_id"
  add_index "image_files_questionnaires", ["questionnaire_id"], :name => "index_image_files_questionnaires_on_questionnaire_id"

  create_table "labs", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "web_site"
    t.string   "country"
    t.boolean  "active"
    t.string   "timezone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "web_study_service"
    t.boolean  "traveler_service"
  end

  create_table "log_entries", :force => true do |t|
    t.integer  "lab_id"
    t.integer  "participant_id"
    t.integer  "experimenter_id"
    t.string   "service"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "device_id"
  end

  add_index "log_entries", ["experimenter_id"], :name => "index_log_entries_on_experimenter_id"
  add_index "log_entries", ["lab_id"], :name => "index_log_entries_on_lab_id"
  add_index "log_entries", ["participant_id"], :name => "index_log_entries_on_participant_id"

  create_table "participant_in_studies", :force => true do |t|
    t.integer "participant_id"
    t.integer "study_id"
    t.boolean "active"
    t.boolean "complete"
  end

  add_index "participant_in_studies", ["participant_id"], :name => "index_participant_in_studies_on_participant_id"
  add_index "participant_in_studies", ["study_id"], :name => "index_participant_in_studies_on_study_id"

  create_table "participants", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                               :default => "", :null => false
    t.integer  "age"
    t.string   "sex"
    t.string   "identification"
    t.string   "timezone"
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token",     :limit => 20
    t.datetime "invitation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cell_number"
  end

  add_index "participants", ["invitation_token"], :name => "index_participants_on_invitation_token"

  create_table "questionnaire_field_choices", :force => true do |t|
    t.integer  "questionnaire_field_id"
    t.integer  "order"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questionnaire_field_choices", ["questionnaire_field_id"], :name => "index_questionnaire_field_choices_on_questionnaire_field_id"

  create_table "questionnaire_fields", :force => true do |t|
    t.integer  "questionnaire_id"
    t.string   "question_text"
    t.integer  "order"
    t.boolean  "required"
    t.string   "kind"
    t.integer  "integer_min_value"
    t.integer  "integer_max_value"
    t.integer  "speech_clip_max_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questionnaire_fields", ["questionnaire_id"], :name => "index_questionnaire_fields_on_questionnaire_id"

  create_table "questionnaire_in_studies", :force => true do |t|
    t.integer  "questionnaire_id"
    t.integer  "study_id"
    t.integer  "order"
    t.boolean  "randomize"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questionnaire_in_studies", ["questionnaire_id"], :name => "index_questionnaire_in_studies_on_questionnaire_id"
  add_index "questionnaire_in_studies", ["study_id"], :name => "index_questionnaire_in_studies_on_study_id"

  create_table "questionnaire_record_fields", :force => true do |t|
    t.integer  "questionnaire_record_id"
    t.integer  "questionnaire_field_id"
    t.string   "kind"
    t.boolean  "skipped"
    t.integer  "integer"
    t.decimal  "decimal",                       :precision => 10, :scale => 0
    t.integer  "questionnaire_field_choice_id"
    t.text     "text"
    t.integer  "speech_clip_id"
    t.integer  "image_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questionnaire_record_fields", ["image_file_id"], :name => "index_questionnaire_record_fields_on_image_file_id"
  add_index "questionnaire_record_fields", ["questionnaire_field_choice_id"], :name => "index-qrf-questionnaire_field_choice_id"
  add_index "questionnaire_record_fields", ["questionnaire_field_id"], :name => "index_questionnaire_record_fields_on_questionnaire_field_id"
  add_index "questionnaire_record_fields", ["questionnaire_record_id"], :name => "index_questionnaire_record_fields_on_questionnaire_record_id"
  add_index "questionnaire_record_fields", ["speech_clip_id"], :name => "index_questionnaire_record_fields_on_speech_clip_id"

  create_table "questionnaire_records", :force => true do |t|
    t.integer  "questionnaire_id"
    t.integer  "participant_id"
    t.string   "filing_interface"
    t.datetime "filed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_id"
    t.integer  "trip_id"
  end

  add_index "questionnaire_records", ["participant_id"], :name => "index_questionnaire_records_on_participant_id"
  add_index "questionnaire_records", ["questionnaire_id"], :name => "index_questionnaire_records_on_questionnaire_id"

  create_table "questionnaires", :force => true do |t|
    t.string   "name"
    t.integer  "lab_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questionnaires", ["lab_id"], :name => "index_questionnaires_on_lab_id"

  create_table "speech_clips", :force => true do |t|
    t.text     "transcription"
    t.string   "audio_original_url"
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studies", :force => true do |t|
    t.string   "name"
    t.integer  "lab_id"
    t.boolean  "active"
    t.integer  "experimenter_id"
    t.boolean  "ask_participant_id"
    t.boolean  "ask_name"
    t.boolean  "ask_email"
    t.boolean  "ask_age"
    t.boolean  "ask_sex"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start_trip_questionnaire_id"
    t.integer  "end_trip_questionnaire_id"
    t.integer  "start_activity_questionnaire_id"
    t.integer  "end_activity_questionnaire_id"
  end

  add_index "studies", ["end_activity_questionnaire_id"], :name => "index_studies_on_end_activity_questionnaire_id"
  add_index "studies", ["end_trip_questionnaire_id"], :name => "index_studies_on_end_trip_questionnaire_id"
  add_index "studies", ["experimenter_id"], :name => "index_studies_on_experimenter_id"
  add_index "studies", ["lab_id"], :name => "index_studies_on_lab_id"
  add_index "studies", ["start_activity_questionnaire_id"], :name => "index_studies_on_start_activity_questionnaire_id"
  add_index "studies", ["start_trip_questionnaire_id"], :name => "index_studies_on_start_trip_questionnaire_id"

  create_table "travel_fixes", :force => true do |t|
    t.integer  "participant_id"
    t.decimal  "latitude",           :precision => 15, :scale => 10
    t.decimal  "longitude",          :precision => 15, :scale => 10
    t.decimal  "altitude",           :precision => 8,  :scale => 2
    t.decimal  "speed",              :precision => 5,  :scale => 2
    t.decimal  "accuracy",           :precision => 5,  :scale => 2
    t.integer  "device_id"
    t.string   "positioning_method"
    t.datetime "datetime"
    t.boolean  "clean"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "travel_fixes", ["device_id"], :name => "index_travel_fixes_on_device_id"
  add_index "travel_fixes", ["participant_id"], :name => "index_travel_fixes_on_participant_id"

  create_table "trips", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "start_travel_fix_id"
    t.integer  "end_travel_fix_id"
    t.string   "travel_mode"
    t.string   "travel_mode_specified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trips", ["end_travel_fix_id"], :name => "index_trips_on_end_travel_fix_id"
  add_index "trips", ["participant_id"], :name => "index_trips_on_participant_id"
  add_index "trips", ["start_travel_fix_id"], :name => "index_trips_on_start_travel_fix_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
