require 'JSON'

ASSET = 'resources'
PATH = 'test/fixtures'

# puts "testing pdf_xcassets with name: #{ASSET} and path: #{PATH}"
# `pdf_xcassets #{ASSET} #{PATH}`

xcassets = "#{ASSET}.xcassets"
CONTENTS = 'Contents.json'
path = "#{xcassets}/#{CONTENTS}"
puts "Checking for #{path}"
exit 1 unless File.exist? path
puts "#{CONTENTS} is created ✅"
