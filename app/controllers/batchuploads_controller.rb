class BatchuploadsController < ApplicationController
  require 'csv'

  def input
  end

  def output
    @identifiers = Identifier.all
  end

  def upload
    id = params['identifier']
    identifier = Identifier.find_by(identifier: id)
    if identifier.nil?
      identifier = Identifier.create(identifier: id)
    end
    identifier.record_errors.delete_all
    identifier.records.delete_all
    tempfile = params['csvfile'].tempfile
    csv = CSV.new(tempfile, headers: true)
    csv.map(&:to_h).each_with_index { |row, index|
      errors = phone_errors(row['phone'])
      errors += email_errors(row['email'])
      errors += name_errors(row['first'], row['last'])
      if errors.length != 0
        errors.each { |err|
          identifier.record_errors.create(row: index, text: err)
        }
      else
        identifier.records.create(row: index, **row)
      end
    }
    #debugger
    tempfile.close!()
    redirect_to output_url
  end

  private

    def fmt_error(label, text)
      return "#{label} field error: #{text}"
    end

    def phone_errors(phone)
      errors = []
      # required
      bad_char_off = /[^0-9\-\.()]/ =~ phone
      if bad_char_off != nil
        errors << fmt_error("phone", "invalid character at position [#{bad_char_off}]")
      end
      digits = phone.gsub(/[^0-9]/, '')
      if digits.length != 10
        errors << fmt_error("phone", "number must contain exactly 10 digits")
      end
      if /[01]/ =~ (digits[0]+digits[3])
        errors << fmt_error("phone", "number may not have 0 or 1 in the [0] or [3] position")
      end
      return errors
    end

    def email_errors(email)
      # required
      # must be standard and valid
      return []
    end

    def name_errors(first, last)
      # first and last must be alpha only and at least 2 characters long
      # neither are required, but if first name is empty, last cannot be specified
      return []
    end
end
