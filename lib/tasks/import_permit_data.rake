require 'csv'

namespace :import_from_csv do

  desc "Import Permits from csv file"
  task :import_permits => [:environment] do

    file = File.expand_path("../../assets/permits.csv", __FILE__)
    start_time = Time.now
    csv_row_number = 1
    records_saved = 0
    records_not_saved = 0
    records_arry = []

    CSV.foreach(file, headers: true, header_converters: :symbol) do |data_row|
      csv_row_number += 1

      data_attrs = data_row.to_hash

      data_attrs[:action_type] = data_attrs[:action_type]
      data_attrs[:api_number] = data_attrs[:api_number].to_i
      data_attrs[:effective_on] = Date.strptime("#{data_attrs[:effective_on]}", "%Y%m%d")
      data_attrs[:countyfips] = data_attrs[:countyfips].to_i
      data_attrs[:depth] = data_attrs[:depth].to_i
      data_attrs[:effective_on] = data_attrs[:effective_on]
      data_attrs[:field_name] = data_attrs[:field_name]
      data_attrs[:file_number] = data_attrs[:file_number].to_i
      data_attrs[:operator_name] = data_attrs[:operator_name]
      data_attrs[:range] = data_attrs[:range].to_i
      data_attrs[:range_bearing] = data_attrs[:range_bearing]
      data_attrs[:section] = data_attrs[:section].to_i
      data_attrs[:slant] = data_attrs[:slant]
      data_attrs[:state] = data_attrs[:state]
      data_attrs[:target_formation] = data_attrs[:target_formation]
      data_attrs[:township] = data_attrs[:township].to_i
      data_attrs[:township_bearing] = data_attrs[:township_bearing]
      data_attrs[:well_status] = data_attrs[:well_status]

      permit = Permit.where(data_attrs).first_or_initialize(data_attrs)

      if permit.new_record?
        permit.save
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



