asset = 'resources'
path = 'test/fixtures'

puts "testing pdf_xcassets with name: #{asset} and path: #{path}"
`pdf_xcassets #{asset} #{path}`

dir = "#{asset}.xcassets"
name = 'Contents.json'
path = "#{dir}/#{name}"
puts "Checking for #{path}"
exit 1 unless File.exist? path
puts 'Contents.json is created ✅'
