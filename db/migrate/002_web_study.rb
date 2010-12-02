class WebStudy < ActiveRecord::Migration
  def self.up
    add_column :labs, :web_study_service, :boolean
    
    # TODO: define the tables, the columns/equations to show in the experimenter interface
    
    create_table :questionnaires do |t|
       t.string :name
       t.integer :lab_id
       t.boolean :active
       t.integer :order
       t.timestamps
     end
     create_table :questionnaire_fields do |t|
       t.integer :questionnaire_id
       t.string :question_text
       t.integer :order
       t.boolean :required
       t.string :field_type
       t.integer :number_min_value
       t.integer :number_max_value
       t.integer :text_length_seconds
       t.timestamps
     end
     create_table :questionnaire_field_choices do |t|
       t.integer :questionnaire_field_id
       t.integer :order
       t.string :text
       t.timestamps
     end
     create_table :questionnaire_records do |t|
       t.integer :questionnaire_id
       t.integer :participant_id
       t.string :filing_interface
       t.datetime :filed_at
       t.timestamps
     end
     create_table :questionnaire_record_fields do |t|
       t.integer :questionnaire_record_id
       t.integer :questionnaire_field_id
       t.string :field_type
       t.boolean :skipped
       t.integer :number_value
       t.integer :questionnaire_field_choice_id
       t.text :text
       t.integer :speech_clip_id
       t.timestamps
     end
     create_table :speech_clips do |t|
       t.text :transcription
       t.string :audio_original_url
       t.string :audio_file_name
       t.string :audio_content_type
       t.integer :audio_file_size
       t.datetime :audio_updated_at
       t.timestamps
     end
  end

  def self.down
    remove_column :labs, :web_study_service
    drop_table :questionnaires
    drop_table :questionnaire_fields
    drop_table :questionnaire_field_choices
    drop_table :questionnaire_records
    drop_table :questionnaire_record_fields
    drop_table :speech_clips
  end
end