require 'csv'

# load CSV and convert to array of hashes

data = CSV.parse(File.read("MOCK_DATA.csv"), headers: true).map(&:to_h)

# iterate through array and delete any hashes with blank values (except phone_number)

def clean_data(array)
  clean = []
  array.each do |hash|
    if hash["first_name"] != nil && hash["last_name"] != nil && hash["email"] != nil
      clean.push(hash)
    end
  puts clean
  end
end

clean_data(data)