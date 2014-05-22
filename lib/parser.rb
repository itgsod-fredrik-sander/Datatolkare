def split_line(line)
  raise ArgumentError, 'can not parse empty line' if line.empty?
  line = line.strip.split(/\s+/)

  return line
end