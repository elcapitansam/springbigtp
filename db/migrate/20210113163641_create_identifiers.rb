class CreateIdentifiers < ActiveRecord::Migration[6.1]
  def change
    create_table :identifiers do |t|
      t.string :identifier

      t.timestamps
    end
  end
end
