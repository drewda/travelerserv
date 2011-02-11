class WebStudy < ActiveRecord::Migration
  def self.up
    add_column :labs, :web_study_service, :boolean
    
    # TODO: define the tables, the columns/equations to show in the experimenter interface
    
    create_table :questionnaires do |t|
      t.string :name
      t.integer :lab_id
      t.boolean :active
      t.timestamps
    end
    add_index :questionnaires, :lab_id
    
    create_table :questionnaire_in_studies do |t|
      t.integer :questionnaire_id
      t.integer :study_id
      t.integer :order
      t.boolean :randomize
      t.timestamps
    end
    add_index :questionnaire_in_studies, :questionnaire_id
    add_index :questionnaire_in_studies, :study_id

    create_table :image_files_questionnaires, :id => false do |t|
     t.integer :image_file_id
     t.integer :questionnaire_id
    end
    add_index :image_files_questionnaires, :image_file_id
    add_index :image_files_questionnaires, :questionnaire_id
    
    create_table :questionnaire_fields do |t|
     t.integer :questionnaire_id
     t.string :question_text
     t.integer :order
     t.boolean :required
     t.string :kind
     t.integer :integer_min_value
     t.integer :integer_max_value
     t.integer :speech_clip_max_seconds
     t.timestamps
    end
    add_index :questionnaire_fields, :questionnaire_id
    
    create_table :questionnaire_field_choices do |t|
     t.integer :questionnaire_field_id
     t.integer :order
     t.string :text
     t.timestamps
    end
    add_index :questionnaire_field_choices, :questionnaire_field_id
    
    create_table :questionnaire_records do |t|
     t.integer :questionnaire_id
     t.integer :participant_id
     t.string :filing_interface
     t.datetime :filed_at
     t.timestamps
    end
    add_index :questionnaire_records, :questionnaire_id
    add_index :questionnaire_records, :participant_id
    
    create_table :questionnaire_record_fields do |t|
     t.integer :questionnaire_record_id
     t.integer :questionnaire_field_id
     t.string :kind
     t.boolean :skipped
     t.integer :integer
     t.decimal :decimal
     t.integer :questionnaire_field_choice_id
     t.text :text
     t.integer :speech_clip_id
     t.integer :image_file_id
     t.timestamps
    end
    add_index :questionnaire_record_fields, :questionnaire_record_id
    add_index :questionnaire_record_fields, :questionnaire_field_id
    add_index :questionnaire_record_fields, :questionnaire_field_choice_id, :name => "index-qrf-questionnaire_field_choice_id"
    add_index :questionnaire_record_fields, :speech_clip_id
    add_index :questionnaire_record_fields, :image_file_id
    
    create_table :speech_clips do |t|
     t.text :transcription
     t.string :audio_original_url
     t.string :audio_file_name
     t.string :audio_content_type
     t.integer :audio_file_size
     t.datetime :audio_updated_at
     t.timestamps
    end
    
    create_table :image_files do |t|
     t.string :name
     t.string :image_file_name
     t.string :image_content_type
     t.integer :image_file_size
     t.datetime :image_updated_at
     t.timestamps
    end
  end

  def self.down
    remove_column :labs, :web_study_service
    drop_table :questionnaires
    drop_table :questionnaire_in_studies
    drop_table :questionnaire_fields
    drop_table :questionnaire_field_choices
    drop_table :questionnaire_records
    drop_table :questionnaire_record_fields
    drop_table :speech_clips
    drop_table :image_files
  end
end