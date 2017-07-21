#!/usr/bin/env ruby

contents = nil

filePath = ARGV[0]
versionCode = ARGV[1]
crosswalk = (ARGV[2] == '--crosswalk')

versionCode += "3" unless crosswalk


File.open(filePath, 'r') do |f|
  contents = f.read
end

contents.gsub!("\r", "")

new_contents = ""
contents.split("\n").each do |line|
  line.gsub!(/android-versionCode=".+?"/, "android-versionCode=\"#{versionCode}\"")

  next if line.match(/density="ldpi/)
  next if line.match(/density="land/)
  next if line.match(/density="port/)
  next if line.match(/android-minSdkVersion/) if crosswalk

  new_contents += "\n" + line
end

File.open(filePath, 'w') do |f|
  f.write(new_contents)
end
