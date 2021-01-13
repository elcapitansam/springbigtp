class CreateErrors < ActiveRecord::Migration[6.1]
  def change
    create_table :errors do |t|
      t.string :text
      t.references :identifier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
