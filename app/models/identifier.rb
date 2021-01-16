class Identifier < ApplicationRecord
  has_many :records, dependent: :destroy
  has_many :record_errors, dependent: :destroy
  validates :identifier, presence: true
end
