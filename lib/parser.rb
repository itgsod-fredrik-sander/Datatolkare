def split_line(line)
  raise ArgumentError, 'can not parse empty line' if line.empty?

  # Split the line by using a regex.
  # / / symbolises start and end of regex.
  # \s+ means one or multiple whitespaces
  line = line.strip.split(/\s+/)

  return line
end

def encode_line(weather_data)
  raise ArgumentError, 'incomplete array' if weather_data.size < 3

  # Create new weather hash and assign it appropriate keys and values.
  weather = {date: weather_data[0].to_i, max: weather_data[1].to_i, min: weather_data[2].to_i}

  return weather
end

def find_biggest_variation(weather_data)
  raise ArgumentError, 'array must not be empty' if weather_data.empty?
  # Returns the biggest variation between max and min temperatures of all the hashes in weather_data.
  return weather_data.max {|a, b| a[:max] - a[:min] <=> b[:max] - b[:min]}
end

def load_weather_file(filepath)
  raise ArgumentError, 'path must not be empty' if filepath.empty?
  raise IOError, 'file does not exist' if !File.file?(filepath)
  
  # Initializes content to whatever lines there is in the file.
  content = File.readlines(filepath)
  # Delete two first lines.
  content.delete_at(0)
  content.delete_at(0)

  return content
end