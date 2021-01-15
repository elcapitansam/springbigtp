class BatchuploadsController < ApplicationController
  require 'csv'

  def input
  end

  def output
    @identifiers = Identifier.all
  end

  def upload
    identifier = Identifier.find_or_create_by(identifier: params['identifier'])
    identifier.record_errors.delete_all
    identifier.records.delete_all
    csv = CSV.new(params['csvfile'].tempfile, headers: true)
    csv.map(&:to_h).each_with_index { |row, index|
      rec = identifier.records.create(row: index, **row)
      errors = {}
      rec.errors.each { |err|
        errors[err.attribute] ||= "#{err.attribute.to_s.capitalize} #{err.message}"
      }
      errors.each_value { |e|
        identifier.record_errors.create(row: index, text: e)
      }
    }
    redirect_to output_url
  end

  private

end
