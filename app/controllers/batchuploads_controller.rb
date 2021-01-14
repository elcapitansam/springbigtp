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
    debugger
    tempfile = params['csvfile'].tempfile
    csv = CSV.new(tempfile, headers: true)
    csv.map(&:to_h).each_with_index { |row, index|
      # delete all errors for row id
      rec = identifier.records.create(row: index, **row)
=begin
      #rec = identifier.records.find_by(row: index)
      #errors = phone_validator(row['phone'])

      errors = 0
      ph = row['phone']
      if ph
      row['email']
      row['first']
      row['last']
=end
      
    }
    #debugger
    tempfile.close!()
    render 'output'
  end
end
