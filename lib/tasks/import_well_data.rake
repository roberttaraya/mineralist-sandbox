require 'csv'

namespace :import_from_csv do

  desc "Import Well from csv file"
  task :import_wells => [:environment] do

    file = File.expand_path("../../assets/wells.csv", __FILE__)
    start_time = Time.now
    csv_row_number = 1
    records_saved = 0
    records_not_saved = 0
    records_arry = []

    CSV.foreach(file, headers: true, header_converters: :symbol) do |data_row|
      csv_row_number += 1

      data_attrs = data_row.to_hash

      data_attrs[:file_number] = data_attrs[:file_number].to_i
      data_attrs[:api_number] = data_attrs[:api_number].to_i
      data_attrs[:operator_name] = data_attrs[:operator_name]
      data_attrs[:township] = data_attrs[:township].to_i
      data_attrs[:township_bearing] = data_attrs[:township_bearing]
      data_attrs[:range] = data_attrs[:range].to_i
      data_attrs[:range_bearing] = data_attrs[:range_bearing]
      data_attrs[:section] = data_attrs[:section].to_i
      data_attrs[:state] = data_attrs[:state]
      data_attrs[:field_name] = data_attrs[:field_name]

      if data_attrs[:completed_on]== ""
        data_attrs[:completed_on] = nil
      else
        data_attrs[:completed_on] = Date.strptime("#{data_attrs[:completed_on]}", "%Y%m%d")
      end

      if data_attrs[:spudded_on]== "00000000"
        data_attrs[:spudded_on] = nil
      else
        data_attrs[:spudded_on]== Date.strptime("#{data_attrs[:spudded_on]}", "%Y%m%d")
      end

      data_attrs[:well_name] = data_attrs[:well_name]
      data_attrs[:well_number] = data_attrs[:well_number]
      data_attrs[:well_type] = data_attrs[:well_type]
      data_attrs[:formation] = data_attrs[:formation]
      data_attrs[:status] = data_attrs[:status]
      data_attrs[:elevation] = data_attrs[:elevation]
      data_attrs[:depth] = data_attrs[:depth].to_i
      data_attrs[:geom] = data_attrs[:geom]

      well = Well.where(data_attrs).first_or_initialize(data_attrs)

      if well.new_record?
        well.save
        records_saved += 1
        puts "Record #{csv_row_number} saved"
      else
        records_not_saved += 1
        # records_arry << data_attrs
        # puts "Record #{csv_row_number} not saved"
        print "."
      end
    end
    puts "#{records_saved} out of #{records_saved + records_not_saved} records were saved."

    # puts "These #{records_not_saved} records were not saved:"
    # records_arry.each do |r|
    #   puts r
    # end
    end_time = Time.now
    total_time = end_time - start_time
    puts "Time to complete import: #{total_time} seconds"
  end
end
