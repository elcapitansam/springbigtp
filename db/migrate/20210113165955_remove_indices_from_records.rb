class RemoveIndicesFromRecords < ActiveRecord::Migration[6.1]
  def change
    remove_index :records, column: [:identifier, :row]
  end
end
