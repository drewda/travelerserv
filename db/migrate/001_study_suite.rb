class StudySuite < ActiveRecord::Migration
  def self.up
    create_table :labs do |t|
      t.string :name
      t.string :slug
      t.string :web_site
      t.string :country
      t.boolean :active
      t.string :timezone
      t.timestamps
    end
    
    create_table :participants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :age
      t.string :sex
      t.string :identification
      t.string :timezone
      t.database_authenticatable
      t.recoverable
      t.rememberable
      t.trackable
      t.invitable
      t.timestamps
    end
    add_index :participants, :invitation_token # for invitable
    
    create_table :experimenters do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :web_site
      t.integer :lab_id
      t.boolean :manager
      t.boolean :active
      t.database_authenticatable
      t.recoverable
      t.rememberable
      t.trackable
      t.invitable
      t.timestamps
    end
    add_index :experimenters, :invitation_token # for invitable
    
    create_table :administrators do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :active
      t.database_authenticatable
      t.recoverable
      t.rememberable
      t.trackable
      t.invitable
      t.timestamps
    end
    
    create_table :log_entries do |t|
      t.integer :lab_id
      t.integer :participant_id
      t.integer :experimenter_id
      t.string :service
      t.string :note
      t.timestamps
    end
    add_index :log_entries, :lab_id
    add_index :log_entries, :participant_id
    add_index :log_entries, :experimenter_id
    
    create_table :studies do |t|
      t.string :name
      t.integer :lab_id
      t.boolean :active
      t.integer :experimenter_id
      t.boolean :ask_participant_id
      t.boolean :ask_name
      t.boolean :ask_email
      t.boolean :ask_age
      t.boolean :ask_sex
      t.timestamps
    end
    add_index :studies, :lab_id
    add_index :studies, :experimenter_id
    
    create_table :participant_in_studies do |t|
      t.integer :participant_id
      t.integer :study_id
      t.boolean :active
      t.boolean :complete
    end
    add_index :participant_in_studies, :participant_id
    add_index :participant_in_studies, :study_id
  end

  def self.down
    drop_table :labs
    drop_table :participants
    drop_table :experimenters
    drop_table :administrators
    drop_table :log_entries
    drop_table :studies
    drop_table :participant_in_studies
  end
end
