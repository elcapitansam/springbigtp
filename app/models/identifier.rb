class Identifier < ApplicationRecord
  has_many :records, dependent: :destroy
  has_many :record_errors, dependent: :destroy

  default_scope { order(processing: :desc, updated_at: :desc) }

  validates :identifier,
    presence: true,
    length: { minimum: 2, maximum: 255 },
    format: { with: /\A[0-9a-z]+\z/i, 
              message: "must contain only alphanumeric characters" }

  def setup
    debugger
    update_all(processing: false)
  end
end