class BatchuploadsController < ApplicationController
  require 'csv'

  def input
    @identifier_name = params['identifier_name'] || ""
  end

  def output
    @identifiers = Identifier.all
  end

  def upload
    params.require([:identifier, :csvfile])
    process_csvfile_async(params['identifier'], params['csvfile'].tempfile)
    flash[:info] = "csvfile uploaded for processing; refresh to monitor status"
    redirect_to output_url
  end

  private

    def process_csvfile_async(identifier_name, csv_tempfile)
      # get a handle on the tempfile before the call returns
      csv = CSV.open(csv_tempfile, headers: true)
      identifier = Identifier.find_or_initialize_by(identifier: identifier_name)
      identifier.update_attribute(:processing, true)
      Thread.new {
        identifier.transaction do
          identifier.processing = true
          identifier.record_errors.delete_all
          csv.map(&:to_h).each_with_index { |row, index|
            rec = identifier.records.find_or_initialize_by(row: index)
            if !rec.update(row)
              errors = {}
              rec.errors.each { |err|
                errors[err.attribute] ||= "#{err.attribute.to_s.capitalize} #{err.message}"
              }
              errors.each_value { |emsg|
                identifier.record_errors.create(row: index, text: emsg)
              }
              rec.delete
            end
          }
        end
        identifier.processing = false
        identifier.save
      }

    end
end
