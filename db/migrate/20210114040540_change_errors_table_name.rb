class ChangeErrorsTableName < ActiveRecord::Migration[6.1]
  def change
    rename_table :errors, :record_errors
  end
end
