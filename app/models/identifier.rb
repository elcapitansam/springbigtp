class Identifier < ApplicationRecord
  has_many :records, dependent: :destroy
  has_many :record_errors, dependent: :destroy

  default_scope { order(processing: :desc, updated_at: :desc) }

  validates :identifier, presence: true

  def setup
    debugger
    update_all(processing: false)
  end
end