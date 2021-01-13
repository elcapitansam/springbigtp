class RemoveIdentifierFromRecords < ActiveRecord::Migration[6.1]
  def change
    add_reference :records, :identifier, foreign_key: true
  end
end
