require 'csv'

# load CSV and convert to array of hashes

array_of_hashes = CSV.parse(File.read("MOCK_DATA.csv"), headers: true).map(&:to_h)

# iterate through array and delete any hashes with blank values (except phone_number)

clean_hash = array_of_hashes.each do |hash|
  hash.each do |k, v|
    if v == nil
      if k != "phone_number"
        array_of_hashes.delete(hash)
      end
    end
  end
end

# write to clean CSV

CSV.open("cleaned_data.csv", "w") { |csv|
  headers = clean_hash.flat_map(&:keys).uniq
  csv << headers
  clean_hash.each { |row|
    csv << row.values_at(*headers)
  }
}
