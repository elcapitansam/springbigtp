class RecordError < ApplicationRecord
  belongs_to :identifier

  default_scope { order(row: :asc) }

  validates :row,
    presence: true,
    numericality: { only_integer: true }

  validates :text,
    presence: true,
    length: { maximum: 255 }
end
