def split_line(line)
  raise ArgumentError, 'can not parse empty line' if line.empty?
  line = line.strip.split(/\s+/)

  return line
end

def encode_line(weather_data)
  raise ArgumentError, 'incomplete array' if weather_data.size < 3
  weather = {date: weather_data[0].to_i, max: weather_data[1].to_i, min: weather_data[2].to_i}

  return weather
end

def find_biggest_variation(weather_data)
  raise ArgumentError, 'array must not be empty' if weather_data.empty?
  return weather_data.max {|a, b| a[:max] - a[:min] <=> b[:max] - b[:min]}
end

def load_weather_file(filepath)
  raise ArgumentError, 'path must not be empty' if filepath.empty?
  raise IOError, 'file does not exist' if !File.file?(filepath)

  content = File.readlines(filepath)
  content.delete_at(0)
  content.delete_at(0)
end