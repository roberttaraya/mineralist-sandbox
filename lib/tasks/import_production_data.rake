require 'csv'

namespace :import_from_csv do

  desc "Import Production from csv file"
  task :import_production => [:environment] do

    file = File.expand_path("../../assets/production.csv", __FILE__)
    start_time = Time.now
    csv_row_number = 1
    records_saved = 0
    records_not_saved = 0
    records_arry = []

    CSV.foreach(file, headers: true, header_converters: :symbol) do |data_row|
      csv_row_number += 1

      data_attrs = data_row.to_hash

      data_attrs[:api_number] = data_attrs[:api_number].to_i
      data_attrs[:barrels_oil] = data_attrs[:barrels_oil].to_f
      data_attrs[:barrels_water] = data_attrs[:barrels_water].to_f
      data_attrs[:days_producing] = data_attrs[:days_producing].to_i
      data_attrs[:mcf_gas] = data_attrs[:mcf_gas].to_f
      data_attrs[:reported_on] = Date.strptime("#{data_attrs[:reported_on]}", "%Y%m%d")

      production = Production.where(data_attrs).first_or_initialize(data_attrs)

      if production.new_record?
        production.save
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
