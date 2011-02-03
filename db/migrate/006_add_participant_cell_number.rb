class AddParticipantCellNumber < ActiveRecord::Migration
  def self.up
    add_column :participants, :cell_number, :string
  end

  def self.down
    remove_column :participants, :cell_number
  end
end