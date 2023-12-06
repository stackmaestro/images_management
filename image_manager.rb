# frozen_string_literal: true

require 'date'

def solution(s)
  validate_input(s)
  photos = s.split("\n")
  grouped_photos = group_photos(photos)

  grouped_photos.transform_values do |city_photos|
    city_photos.sort_by { |photo| photo[:time_stamp] }.each_with_index do |photo, index|
      photo_count = city_photos.size
      number = (index + 1).to_s.rjust(photo_count.to_s.length, '0')
      extension = photo[:name].split('.').last
      photo[:new_name] = "#{photo[:city]}#{number}.#{extension}".strip
    end
  end

  renamed_photos = grouped_photos.values.flatten.sort_by { |photo| photo[:previous_position] }.map { |p| p[:new_name] }
  puts renamed_photos
  return renamed_photos
end

def validate_input(s)
  raise 'Invalid input: M should be an integer within the range (1..100)' unless (1..100).include?(s.lines.size)

  s.lines.each do |line|
    name, city, date_str = line.split(',').map(&:strip)

    raise "Invalid input: Photo name '#{name}' is not valid" unless valid_name?(name)
    raise "Invalid input: City name '#{city}' is not valid" unless valid_city_name?(city)

    date = DateTime.parse(date_str)
    raise 'Invalid input: Year should be within the range (2000..2020)' unless (2000..2020).include?(date.year)

    extension = name.split('.').last.strip
    raise 'Invalid input: Invalid extension' unless %w[jpg png jpeg].include?(extension)
  end
end

def valid_name?(name)
  /^[A-Za-z0-9_]{1,20}\.[a-z]{3,4}$/.match?(name)
end

def valid_city_name?(city)
  /^[A-Z][a-z]{0,19}$/.match?(city)
end

def group_photos(photos)
  grouped_photos = Hash.new { |hash, key| hash[key] = [] }
  photos.each_with_index do |photo, index|
    name, city, time_stamp = photo.split(',')
    grouped_photos[city] << { name: name, previous_position: index, time_stamp: time_stamp, city: city }
  end
  grouped_photos
end
