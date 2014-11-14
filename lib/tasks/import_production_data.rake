require 'csv'

namespace :import_from_csv do

  desc "Import Production from csv file"
  task :import_production => [:environment] do

    file = "/Users/roberttaraya/Google Drive/Mineralist/Engineering/Geodata/Production/production.csv"
    start_time = Time.now
    csv_row_number = 1
    records_saved = 0
    records_not_saved = 0
    records_arry = []

    CSV.foreach(file, headers: true, header_converters: :symbol) do |data_row|
      csv_row_number += 1
      data_attrs = data_row.to_hash

      production = Production.where(data_attrs).first_or_initialize(data_attrs)

      if production.new_record?
        production.save
        records_saved += 1
        puts "Record #{csv_row_number} saved"
      else
        records_not_saved += 1
        # records_arry << data_attrs
        # puts "Record #{csv_row_number} not saved"
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
