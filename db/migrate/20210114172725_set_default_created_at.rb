class SetDefaultCreatedAt < ActiveRecord::Migration[6.1]
  def change
    change_column_default :records, :created_at, from: nil, to: ->{ 'now()' }
    change_column_default :records, :updated_at, from: nil, to: ->{ 'now()' }
  end
end
