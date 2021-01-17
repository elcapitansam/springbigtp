class AddProcessingToIdentifier < ActiveRecord::Migration[6.1]
  def change
    add_column :identifiers, :processing, :boolean
  end
end
