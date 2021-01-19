class AddOrderIndexToIdentifier < ActiveRecord::Migration[6.1]
  def change
    add_index(:identifiers, [:processing, :updated_at], order: {processing: :desc, updated_at: :desc})
  end
end
