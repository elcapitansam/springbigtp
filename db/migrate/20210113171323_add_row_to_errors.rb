class AddRowToErrors < ActiveRecord::Migration[6.1]
  def change
    add_column :errors, :row, :integer
  end
end
