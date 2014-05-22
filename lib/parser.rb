# Private: Splits the line into an array
#
# line - The line to be split.
#
# Examples
#
#   split_line("   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5\n")
#   # =>  ["1", "88", "59", "74", "53.8", "0.00", "F", "280", "9.6", "270", "17", "1.6", "93", "23", "1004.5"]
#
# Returns the split line as an array

def split_line(line)
  raise ArgumentError, 'can not parse empty line' if line.empty?
  line = line.strip.split(/\s+/)
  
  return line
end

# Private: Encodes array consisting of weather data into a hash with keys and values
#
# weather_data - The weather data to be encoded.
#
# Examples
#
#   encode_line(["1", "88", "59", "74", "53.8", "0.00", "F", "280", "9.6", "270", "17", "1.6", "93", "23", "1004.5"])
#   # =>  { date: 1, max: 88, min: 59 }
#
# Returns the encoded hash


def encode_line(weather_data)
  raise ArgumentError, 'incomplete array' if weather_data.size < 3
  weather = {date: weather_data[0].to_i, max: weather_data[1].to_i, min: weather_data[2].to_i}

  return weather
end

# Private: Calculates the biggest variation between encoded weather hashes
#
# weather_data - The weather data to be compared.
#
# Examples
#
#   find_biggest_variation([{ date: 1, max: 88, min: 59 }, { date: 2, max: 88, min: 53 }, { date: 3, max: 88, min: 67 } ])
#   # =>  { date: 2, max: 88, min: 53}
#
# Returns the hash which has the biggest variation in temperature


def find_biggest_variation(weather_data)
  raise ArgumentError, 'array must not be empty' if weather_data.empty?

  return weather_data.max {|a, b| a[:max] - a[:min] <=> b[:max] - b[:min]}
end

# Private: Loads all content from file except for first two lines
#
# Examples
#
#   load_weather_file("test.dat")
#   # =>  "   1  88    67    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5\n", "   2  87    61    71          46.5       0.00         330  8.7 340  23  3.3  70 28 1004.5\n", "   3  83    72    66          39.6       0.00         350  5.0 350   9  2.8  59 24 1016.8"]
#
# Returns the new calculated value


def load_weather_file(filepath)
  raise ArgumentError, 'path must not be empty' if filepath.empty?
  raise IOError, 'file does not exist' if !File.file?(filepath)

  content = File.readlines(filepath)
  content.delete_at(0)
  content.delete_at(0)

  return content
end

# Public: Prints out the day with the biggest temperature variation
#
# path - the file to be loaded
#
# Examples
#
#   main("test.dat")
#   # => "Day 2 had the biggest variation (26.0 degrees)\n"
#
# Prints out the day with the biggest temperature variation


def main(path)
  weather_data = load_weather_file(path)

  weather_data.map! {|data| split_line(data)}
  weather_data.map! {|data| encode_line(data)}
  
  biggest_variation = find_biggest_variation(weather_data)
  puts "Day #{biggest_variation[:date]} had the biggest variation (#{(biggest_variation[:max] - biggest_variation[:min]).to_f} degrees)"
end