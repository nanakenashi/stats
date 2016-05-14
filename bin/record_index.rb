require_relative '../lib/google/drive'
require_relative '../lib/google/webmasters'

drive = Google::Drive.new
# webmasters = Google::Webmasters.new

# write file
place = File.expand_path('../../var/record_index/', __FILE__)
file_name = 'data.csv'
file_path = File.join(place, file_name)
File.open(file_path, "w") do |file|
  file.puts 'a, b, c'
  file.puts '1, 2, 3'
end

# create file
drive.create_file('test', 'text/csv', file_path)

# remove file
files = drive.list_files
files.each do |file|
  drive.delete_file(file[:id]) if file[:name] === 'test'
end
