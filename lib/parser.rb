def split_line(line)
  raise ArgumentError, 'can not parse empty line' if line.empty?
  line = line.strip.split(/\s+/)

  return line
end

def encode_line(weather_data)
  raise ArgumentError, 'incomplete array' if weather_data.size < 3

  weather = {date: weather_data[0], max: weather_data[1], min: weather_data[2]}
end