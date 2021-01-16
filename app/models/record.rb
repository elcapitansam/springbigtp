
class Record < ApplicationRecord
	belongs_to :identifier

	validates :row,
		presence: true

	validates :email,
		presence: true,
		length: { maximum: 255 },
		format: { with: /\A[\w+\-.]+@([a-z\d\-]+\.)+[a-z]{2,3}\z/i }

	validates :phone,
		presence: true,
		format: { with: /\A[0-9\-\.()]+\z/,
							message: "format error, only 0-9, -, ., (, ) permitted" }

	validate :phone_digit_check
	
	validates :first, :last,
		allow_blank: true,
		length: { minimum: 2, maximum: 255 },
		format: { with: /\A[a-z]+\z/i,
							message: "only alpha characters permitted" }

	validate :first_last_dependent_presence

	private

		def phone_digit_check
			return if phone.blank?
			digits = phone.gsub(/[^0-9]/, '')
			if digits.length != 10
				errors.add(:phone, "must contain exactly 10 digits")
			end
			if /[01]/ =~ (digits[0]+digits[3])
				errors.add(:phone, "may not have 0 or 1 in the [0] or [3] digit position")
			end
		end

		def first_last_dependent_presence
			if first.blank? && !last.blank?
				errors.add(:first, "must be specified if last name is specified")
			end
		end
end
