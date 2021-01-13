class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.string :identifier
      t.integer :row
      t.string :first
      t.string :last
      t.string :phone
      t.string :email

      t.timestamps
    end
		add_index :records, [:identifier, :row]
  end
end
