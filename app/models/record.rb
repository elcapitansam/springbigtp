class Record < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  validates :identifier, presence: true
end
