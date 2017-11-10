#!/usr/bin/env ruby
# encoding: UTF-8

contents = nil

filePath = ARGV[0]
host = ARGV[1]


File.open(filePath, 'r') do |f|
  contents = f.read
end

contents.gsub!("\r", "")

new_contents = ""
contents.split("\n").each do |line|
  line.gsub!(/host: \{default: '(.+?)'/, "host: {default: '#{host}'")

  new_contents += "\n" + line
end

File.open(filePath, 'w') do |f|
  f.write(new_contents)
end
