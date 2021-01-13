class RemoveIdentifierFromRecordsForReal < ActiveRecord::Migration[6.1]
  def change
    remove_column :records, :identifier
  end
end
